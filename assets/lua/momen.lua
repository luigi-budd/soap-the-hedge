--thanks for CobaltBW for this code!!! ( https://mb.srb2.org/threads/the-momentum-mod.27233/ )
//should i make this into its own file?? it IS bigger than all of the scripts here
//yeah i think i should
local debug = 0

addHook('ThinkFrame', do
	for player in players.iterate do
		if player.mo and player.mo.scale and player.mo.friction and player.mo.movefactor and canMomen == true then
			local pmo = player.mo
			//Create history
			if player.waterlast == nil then
				player.waterlast = false
				player.dashlast = false
				player.realfriction = pmo.friction
			end
			local skin = skins[pmo.skin]
			
			//Stat adjust
			if player.charability2 == CA2_SPINDASH then
				player.mindash = skin.mindash * 3/2
			end
			local water = 1+(pmo.eflags&MFE_UNDERWATER)/MFE_UNDERWATER //Water factor for momentum halving
			local grounded = P_IsObjectOnGround(pmo)
			local nmom = skin.normalspeed //Skin normalspeed, the integral component
			//Dashmode overrides skin normalspeed
			if player.dashmode >= 3*TICRATE then
				nmom = player.normalspeed
			end
			
			local scale = pmo.scale //Normalspeed calculations are affected by scale
			local friction = FixedDiv(pmo.friction,pmo.movefactor) //Reversing friction is required for sustaining ground momentum
			local pmom = FixedDiv(FixedHypot(player.rmomx,player.rmomy),scale) //Current speed, scaled for normalspeed calculations
			local pwup = (player.powers[pw_sneakers]) or (player.powers[pw_super]) //Speed-ups multiply max allowed speed by 5/3
			local momangle = R_PointToAngle2(0,0,player.rmomx,player.rmomy) //Used for angling new momentum in ability cases
			//Adjust current speed reading for calculations with pwup status
			if pwup then
				pmom = $*3/5
			end
			local mom = FixedHypot(pmo.momx,pmo.momy)

						
			
			/////////
			//General momentum scaling
			
			//Do landing momentum cut
			if pmo.eflags&MFE_JUSTHITFLOOR then
				player.normalspeed = skin.normalspeed
				pmo.friction = $-$/10
			//Do ground momentum
			elseif grounded then
				//The amount of momentum to sustain
				local sustain = FixedDiv(min(pmom*water,nmom*2),friction)
-- 				if pmom > player.normalspeed then
					player.normalspeed = max(nmom,sustain)
-- 				end
			//Do air momentum
			elseif not(player.dashmode) then //Dashmode overrides normalspeed in the air
				player.normalspeed = skin.normalspeed
			end
			
			///////
			//Thok momentum scaling
-- 			if player.charability == CA_THOK
			if player.charability == CA_JUMPTHOK
				then
				//Raise thokspeed to current momentum if above innate actionspd
				player.actionspd = max(pmom*water,skin.actionspd)
			end
			
			//////
			// Tails flight momentum (Sonic 3 style)
			if player.charability == CA_FLY and player.powers[pw_tailsfly]
				and player.charflags|SF_MULTIABILITY then
				//Create flight history
				if player.normalspeed_last == nil then
					player.normalspeed_last = player.normalspeed
				end
				//Scale actionspd with water physics
				player.actionspd = skin.actionspd/water
				//Other vars
				local flip = P_MobjFlip(pmo) //Gravity flip orientation
				local nomom = nmom/2 //horz momentum while ascending
				local fullmom = nmom*2/water //horz momentum while descending
				//Reduce speed when attempting to rise
				if player.cmd.buttons&BT_JUMP and not(player.cmd.buttons&BT_USE) then
					nmom = max(player.normalspeed_last-friction,nomom)
					//Limit speed of ascent
					if pmo.momz*flip > 4*scale/water then
						pmo.momz = flip*max(4*scale/water,pmo.momz*flip-friction)
					end
				else //Regain speed when not attempting to rise
					nmom = min(player.normalspeed_last+friction,fullmom)
				end
				//Apply horizontal mobility
				if (pmom > nmom/2) then 
					pmom = $-friction
					pmo.momx = FixedMul(P_ReturnThrustX(nil,momangle,pmom),scale)
					pmo.momy = FixedMul(P_ReturnThrustY(nil,momangle,pmom),scale)
-- 					P_InstaThrust(pmo,momangle,max(FixedMul(nmom/2,scale),FixedMul(pmom,scale)))
				end
				//Update normalspeed and history
				player.normalspeed = nmom
				player.normalspeed_last = player.normalspeed
-- 				print(pmom/FRACUNIT)
-- 				print(pmo.momz/FRACUNIT)
-- 				print(zlerp*100/FRACUNIT)
-- 				print(player.normalspeed/FRACUNIT)
-- 				print(player.actionspd)
			end
			
			//////
			//Knuckles momentum renewal
			if player.charability == CA_GLIDEANDCLIMB then
				//Create glide history
				if player.glidelast == nil then
					player.glidelast = 0
				end
				local gliding = player.pflags&PF_GLIDING
				local thokked = player.pflags&PF_THOKKED
				local exitglide = (player.glidelast == 1 and not(gliding) and thokked)
				local landglide = (player.glidelast == 2 and not(gliding|thokked))
				//Restore glide momentum after deactivation
				if exitglide or landglide then
					pmo.momx = FixedMul(P_ReturnThrustX(nil,momangle,pmom),scale)
					pmo.momy = FixedMul(P_ReturnThrustY(nil,momangle,pmom),scale)
				end
				//Update glide history
				if gliding then
					player.glidelast = 1 //Gliding
				elseif exitglide then
					player.glidelast = 2 //Falling from glide
				elseif not(gliding|thokked) then
					player.glidelast = 0 //Not in glide state
				end
			end
			
			//////
			//Fang momentum renewal
			if player.charability == CA_BOUNCE then
				//Create bounce history
				if player.bouncelast == nil then
					player.bouncelast = false
				end
				if player.pflags&PF_BOUNCING and not(player.bouncelast) //Activate bounce
					or (not(player.pflags&PF_BOUNCING) and player.pflags&PF_THOKKED and player.bouncelast) //Deactivate bounce
					//Undo the momentum cut from bounce activation/deactivation
					pmo.momx = FixedMul(P_ReturnThrustX(nil,momangle,pmom),scale)
					pmo.momy = FixedMul(P_ReturnThrustY(nil,momangle,pmom),scale)
					pmo.momz = $*2
				end
				//Update bounce history
				player.bouncelast = (player.pflags&PF_BOUNCING > 0)
			end
			
			//Update history
			player.waterlast = (pmo.eflags&MFE_UNDERWATER > 0)
			player.dashlast = (player.pflags&PF_STARTDASH > 0)
			
			//DEBUG//
			if debug then
				print("momz " + pmo.momz/FRACUNIT)
				print("actionspd   " + player.actionspd/FRACUNIT)
				print("pmom        " + pmom/FRACUNIT)
				print("normalspeed " + player.normalspeed/FRACUNIT)
			end
		end
	end
end)