//this should have functions for code that is just too darn big!

//this would make more sense if it was called SoapBooleans
rawset(_G, "SoapConstants", function(p, me, soap)
    if not soap
		return
	end
	
	if p.dashmode >= 3*TICRATE
        soap.isDash = 1
    else
        soap.isDash = 0
    end

    if P_IsObjectOnGround(me)  
	//or 	me.eflags & MFE_ONGROUND
	and not (P_CheckDeathPitCollide(me))
        soap.onGround = 1
    else
        soap.onGround = 0
    end

    if me.skin == "soapthehedge"
        soap.isSoap = 1
    else
        soap.isSoap = 0
    end

    if (me.valid) or (p.valid)
        soap.isValid = 1
    else
        soap.isValid = 0
    end

    if ((me.state == S_PLAY_STND) or (me.state == S_PLAY_WAIT))
//	or ((soap.accSpeed <= FRACUNIT) and not ((p.cmd.forwardmove) and (p.cmd.sidemove)))
        soap.isIdle = 1
    else
        soap.isIdle = 0
    end

    if p.isxmomentum
		soap.isXmo = 1
		if not p.xmomtoggledoff
			soap.isXmoON = 1
		else
			soap.isXmoON = 0
		end
    else
        soap.isXmo = 0
		soap.isXmoON = 0
    end

    if p.powers[pw_super]
        soap.isSuper = 1
    else
        soap.isSuper = 0
    end
   
    if (p == server) or (p == admin)
	or IsPlayerAdmin(p)
        soap.isElevated = 1
    else
        soap.isElevated = 0
    end

    if soap.isXmo
        p.spcanflip = 0
    end
	
    if P_PlayerInPain(p)
        soap.inPain = 1
    else
        soap.inPain = 0
    end

	if (p.powers[pw_shield] ~= SH_NONE)
		soap.noShield = 0
	else
		soap.noShield = 1
	end
	
//	print(soap.isSValid)
//	print(soap.noShield)
	
	//we dont have a vanilla shield, so no airdashing
/*
	if ((not soap.isSValid) and (not soap.noShield))
		soap.canADash = 0
	else
		soap.canADash = 1
	end
	
	//being super overwrites the one above
	if soap.isSuper and ((not soap.isSValid) and (not soap.noShield))
		soap.canADash = 1
	end
*/
	
	if p.solchar
		if p.solchar.istransformed > 0
			soap.isSol = 1
		else
			soap.isSol = 0
		end
	else
		soap.isSol = 0
	end
	
	if me.state >= S_PLAY_SUPER_TRANS1
	and me.state <= S_PLAY_SUPER_TRANS6
		soap.isTransform = 1
	else
		soap.isTransform = 0
	end
	
	soap.gravflip = P_MobjFlip(me)
	
	if me.eflags&MFE_UNDERWATER
	and not (me.eflags & MFE_TOUCHLAVA)
		soap.isWatered = 1
	else
		soap.isWatered = 0
	end
	
	if p.boostmentum 
		soap.isBoostm = 1
	else
		soap.isBoostm = 0
	end
	
	if p.pflags & PF_GODMODE
		soap.isGod = 1
	else
		soap.isGod = 0
	end
	
	//we NEED this mod here as to not break any clonefigher stuff
	if leveltime % 10 == 0
		if skins[p.skin].name == "clonefighter"
			soap.isCloneF = 1
		else
			soap.isCloneF = 0
		end
	end
	
	if not camera.chase
		soap.isFirstPerson = 1
	else
		soap.isFirstPerson = 0
	end
	
	if (gametype == GT_ZESCAPE)
	or (gametype == GT_ZSWARM)
		soap.isZE = true
	else
		soap.isZE = false
	end
	
	if me.state == S_PLAY_SOAP_SUPERTAUNT1
	or me.state == S_PLAY_SOAP_SUPERTAUNT2
	or me.state == S_PLAY_SOAP_SUPERTAUNT3
	or me.state == S_PLAY_SOAP_ASSBLAST
		soap.isSuperTaunting = 1
	else
		soap.isSuperTaunting = 0
	end
	
		if p.mysticsuper
		   soap.isSuperM = 1
		else
		   soap.isSuperM = 0
		end
	
end)

rawset(_G, "SoapButtonCheck", function(p, me, soap)
    //jump
	if not (p.cmd.buttons & BT_JUMP)
        soap.SjumpREADY = 1
        soap.SjumpDOWN = 0
		soap.SjumpOS = 0
    elseif soap.SjumpREADY
        soap.SjumpREADY = 0
        soap.SjumpDOWN = 1
		soap.SjumpOS = 1
	else
		soap.SjumpOS = 0
	end

	//spin
    if not (p.cmd.buttons & BT_USE)
        soap.SspinREADY = 1
        soap.SspinDOWN = 0
		soap.SspinOS = 0
    elseif soap.SspinREADY
        soap.SspinREADY = 0
        soap.SspinDOWN = 1
		soap.SspinOS = 1
    else
		soap.SspinOS = 0
	end

	//c1
	if not(p.cmd.buttons & BT_CUSTOM1)
		soap.Scustom1READY = 1
		soap.Scustom1DOWN = 0
		soap.Scustom1OS = 0
	elseif soap.Scustom1READY
		soap.Scustom1READY = 0
		soap.Scustom1DOWN = 1
		soap.Scustom1OS = 1
	else
		soap.Scustom1OS = 0
	end

    //c2
    if not (p.cmd.buttons & BT_CUSTOM2)
        soap.Scustom2READY = 1
        soap.Scustom2DOWN = 0
		soap.Scustom2OS = 0
    elseif soap.Scustom2READY
        soap.Scustom2READY = 0
        soap.Scustom2DOWN = 1
		soap.Scustom2OS = 1
    else
		soap.Scustom2OS = 0
	end

    //c3
    if not (p.cmd.buttons & BT_CUSTOM3)
        soap.Scustom3READY = 1
        soap.Scustom3DOWN = 0
		soap.Scustom3OS = 0
    elseif soap.Scustom3READY
        soap.Scustom3READY = 0
        soap.Scustom3DOWN = 1
		soap.Scustom3OS = 1
    else
		soap.Scustom3OS = 0
	end

    //tossflag
    if not (p.cmd.buttons & BT_TOSSFLAG)
        soap.StossflagREADY = 1
        soap.StossflagDOWN = 0
		soap.StossflagOS = 0
    elseif soap.StossflagREADY
        soap.StossflagREADY = 0
        soap.StossflagDOWN = 1
		soap.StossflagOS = 1
    else
		soap.StossflagOS = 0
	end

	//fire normal
	if not (p.cmd.buttons & BT_FIRENORMAL)
        soap.SfirenREADY = 1
        soap.SfirenDOWN = 0
		soap.SfirenOS = 0
    elseif soap.SfirenREADY
        soap.SfirenREADY = 0
        soap.SfirenDOWN = 1
		soap.SfirenOS = 1
	else
		soap.SfirenOS = 0
	end

end)

rawset(_G, "SoapSquashAndStretch", function(p, me)
		local soap = p.soaptable
		
		//dont do this in nights
		if (p.powers[pw_carry] == CR_NIGHTSMODE)
		or (p.powers[pw_carry] == CR_PLAYER)
		or (p.powers[pw_carry] == CR_ZOOMTUBE)
		or (p.powers[pw_carry] == CR_PTERABYTE)
		or (p.powers[pw_carry] == CR_MINECART)
		or (p.powers[pw_carry] == CR_ROPEHANG)
		//so there shouldnt be any weird shenanigans while bouncing on a water fof
		//so many parenthesis, i cant even read it
		or p.soaptable.isSuperTaunting
		or ( (not me.health and ((soap.saveddgmt) and (soap.saveddgmt == DMG_DROWNED))) and ((me.spritexscale == FRACUNIT) and (me.spriteyscale == FRACUNIT)))
			return
		end
		if p.jt == nil then
			p.jt = 0
			p.jp = 0
			p.sp = 0
			p.tk = 0
			p.tr = 0
		end
		if p.jt > 0 then
			p.jt = p.jt - 1
		end
		if p.jt < 0 then
			p.jt = p.jt + 1
		end
		if me.momz*soap.gravflip < 1 then
			p.jp = 0
		end
		if me.state != S_PLAY_CLIMB and me.eflags != me.eflags | MFE_GOOWATER then
			if me.momz*soap.gravflip > 0 and p.jp == 0 and me.state != S_PLAY_FLY and me.state != S_PLAY_SWIM and me.state != S_PLAY_FLY_TIRED and me.state != S_PLAY_WALK and me.state != S_PLAY_RUN and me.state != S_PLAY_WALK and me.state != S_PLAY_BOUNCE_LANDING then
				p.jp = 1
				p.jt = 5
			end
			if me.momz*soap.gravflip > 0 and p.jt < 0 and me.state != S_PLAY_FLY and me.state != S_PLAY_SWIM and me.state != S_PLAY_FLY_TIRED and me.state != S_PLAY_WALK and me.state != S_PLAY_RUN and me.state != S_PLAY_WALK and me.state != S_PLAY_BOUNCE_LANDING then
				p.jp = 1
				p.jt = 5
			end
		elseif me.eflags == me.eflags | MFE_GOOWATER
			p.jp = 1
		end
		if me.state == S_PLAY_BOUNCE_LANDING then
			p.jt = -5
		end
		/*
		if p.pflags != p.pflags | PF_SPINNING or p.pflags == p.pflags | PF_JUMPED then
			p.sp = 0
		end
		if p.pflags == p.pflags | PF_SPINNING and p.pflags != p.pflags | PF_JUMPED and p.sp == 0 and p.jt < 1 then
			p.sp = 1
			p.jt = -5
		end
		*/
		if p.pflags != p.pflags | PF_THOKKED then
			p.tk = 0
		end
		if p.pflags == p.pflags | PF_THOKKED and p.tk == 0 then
			p.tk = 1
			p.jt = 5
		end
		if me.state != S_PLAY_FLY_TIRED then
			p.tr = 0
		end
		if me.state == S_PLAY_FLY_TIRED and p.tr == 0 then
			p.tr = 1
			p.jt = 5
		end
		p.maths = p.jt*FRACUNIT
		p.maths = p.maths / 10
		me.spriteyscale = p.maths + FRACUNIT
		
		p.maths = p.jt*p.spinheight
		if me.state != S_PLAY_ROLL then
			p.maths = p.jt*p.height
		end
		p.maths = p.maths / 20
		me.spriteyoffset = -1*p.maths
		
		p.maths = p.jt*FRACUNIT
		p.maths = p.maths / 10
		p.maths = p.maths*-1
		me.spritexscale = p.maths + FRACUNIT
end)

//alt momentum for when SoapyMomentum doesnt wanan momen
rawset(_G, "SoapAltMomentum", function(p, me, soap)
	if not soap
	or not me
		return
	end
	
			//add ffoxD's FFDMomentum here because its awesome
			if (p.cmd.forwardmove or p.cmd.sidemove)
			and FixedDiv(p.normalspeed,me.scale) <= soap.accSpeed then
				me.friction = FRACUNIT
			else
			me.friction = 29*FRACUNIT/32
			end
end)
rawset(_G, "SoapyMomentum", function(p, me, soap)
		local battle = 0
		
		if CBW_Battle
			if CBW_Battle.BattleGametype()
				battle = 1
			else
				battle = 0
			end
		else
			battle = 0
		end
		
		if p.mrce
	//		if p.mrce.physics
				soap.canMomen = 0
	//		else
	//			soap.canMomen = 1
	//		end
		end
		
        if soap.disableMomen or battle
			soap.canMomen = 0
            return
        end
   
        if soap.isXmoON
            soap.canMomen = 0
			return
        else
            soap.canMomen = 1
        end
       
		if me and me.scale and me.friction and me.movefactor and soap.canMomen then			
			
			//Create history
			if p.waterlast == nil then
				p.waterlast = 0
				p.dashlast = 0
				p.realfriction = me.friction
			end
			local skin = skins[me.skin]

			//Stat adjust
			//just have our regular mindash
		//	if p.charability2 == CA2_SPINDASH then
		//		p.mindash = skin.mindash * 3/2
		//	end
			local water = 1+(me.eflags&MFE_UNDERWATER)/MFE_UNDERWATER //Water factor for momentum halving
			local grounded = P_IsObjectOnGround(me)
			local nmom = skin.normalspeed //Skin normalspeed, the integral component
			//Dashmode overrides skin normalspeed
			if p.dashmode >= 3*TICRATE then
				nmom = p.normalspeed
			end
			
			local scale = me.scale //Normalspeed calculations are affected by scale
			local friction = FixedDiv(me.friction,me.movefactor) //Reversing friction is required for sustaining ground momentum
			local mem = FixedDiv(FixedHypot(p.rmomx,p.rmomy),scale) //Current speed, scaled for normalspeed calculations
			local pwup = (p.powers[pw_sneakers]) or (p.powers[pw_super]) //Speed-ups multiply max allowed speed by 5/3
			local momangle = R_PointToAngle2(0,0,p.rmomx,p.rmomy) //Used for angling new momentum in ability cases
			//Adjust current speed reading for calculations with pwup status
			if pwup then
				mem = $*3/5
			end
			local mom = FixedHypot(me.momx,me.momy)

						
			
			/////////
			//General momentum scaling
			
			//Do landing momentum cut
			if me.eflags&MFE_JUSTHITFLOOR then 
				//kidding! dont cut our speed at all
				//thrust us a bit
				//a "bit"
				P_Thrust(me, p.drawangle, (((p.dashmode/2)/FRACUNIT))*me.scale)
				
			//Do ground momentum
			elseif grounded then
				//The amount of momentum to sustain
				local sustain = FixedDiv(min(mem*water,nmom*3),friction)
-- 				if mem > p.normalspeed then
					p.normalspeed = max(nmom,sustain)
-- 				end
			//Do air momentum
			elseif not(p.dashmode) then //Dashmode overrides normalspeed in the air
				p.normalspeed = skin.normalspeed
			end
			
			///////
			//Thok momentum scaling
-- 			if p.charability == CA_THOK
			if p.charability == CA_JUMPTHOK
				then
				//Raise thokspeed to current momentum if above innate actionspd
				p.actionspd = max(mem*water,skin.actionspd)
			end
						
			//Update history
			p.waterlast = (me.eflags&MFE_UNDERWATER > 0)
			p.dashlast = (p.pflags&PF_STARTDASH > 0)
			
		end
end)

rawset(_G, "SoapNoAirwalk", function(p, me, soap)
	if soap.isIdle 
	or me.state == S_PLAY_WAIT 
	or me.state == S_PLAY_WALK 
	or me.state == S_PLAY_RUN 
	or me.state == S_PLAY_DASH
	and not ( ((p.pflags & PF_SPINNING) or (p.pflags & PF_JUMPED)) and soap.SspinDOWN)
	
		if soap.isSoap
			if not soap.onGround
			and p.powers[pw_carry] != CR_ROLLOUT
			and p.powers[pw_carry] != CR_MINECART //this gives me an idea for a minecart anim
			and p.powers[pw_carry] != CR_ZOOMTUBE
			and p.powers[pw_carry] != CR_ROPEHANG
			and p.powers[pw_carry] != CR_PLAYER
			and p.powers[pw_carry] != CR_NIGHTSMODE
				soap.noairwalk = 1
				if me.momz >= 0
//					me.state = S_PLAY_SOAP_FLAILUP
//					me.state = S_PLAY_ROLL
					me.state = S_PLAY_SPRING
				else
//					me.state = S_PLAY_ROLL
					me.state = S_PLAY_SOAP_FREEFALL
				end
			end
		end
	end
end)

rawset(_G, "SoapSetTauntVariables", function(p, me, soap)
		if me.state == S_PLAY_SOAP_FLEX
			soap.flexxing = 1
		else
			soap.flexxing = 0
		end

		if me.state == S_PLAY_SOAP_LAUGH
			soap.laughing = 1
		else
			soap.laughing = 0
		end
end)

//sonic wants me to make these devmode only, using debug.print,
//which i had no idea existed, but i'll try it out later
//im pretty sure cons_printf only prints stuff to the player, and not
//to everyone else in the server

/*
rawset(_G, "SoapConsoleStatSpam", function(player, me, soap)
	if soap.debugStats and not soap.devmode
		local p = player
		//print EVERYTHING in the table so i can know whats unused 
		//i got lazy and didnt add new variables... too bad!
		if p.soaptable
			CONS_Printf(p, "     "+"\x82"+"Soap Stats {")
			CONS_Printf(p, "     	"+"Rolltrol " + soap.rolltrol)
			CONS_Printf(p, "     	"+"Uncurl " + soap.soapUncurl)
			CONS_Printf(p, "     	"+"Flexxing " + soap.flexxing)
			CONS_Printf(p, "     	"+"Laughing " + soap.laughing)
			CONS_Printf(p, "     	"+"DisableMomen " + soap.disableMomen)
			CONS_Printf(p, "     	"+"CanMomen " + soap.canMomen)
			CONS_Printf(p, "     	"+"DebugStats " + soap.debugStats)
			CONS_Printf(p, "     	"+"UncurlPrevBtn " + soap.uncurlprevbuttons)
			CONS_Printf(p, "     	"+"DashPreserve " + soap.dashpreserve)
			CONS_Printf(p, "     	"+"RecurlAble " + soap.recurlAble)
			CONS_Printf(p, "     	"+"CurlPainStasis " + soap.curlPainStasis)
			CONS_Printf(p, "     	"+"TheHorror! " + soap.thehorror)
			CONS_Printf(p, "     	"+"IsDash " + soap.isDash)
			CONS_Printf(p, "     	"+"OnGround " + soap.onGround)
			CONS_Printf(p, "     	"+"IsSoap " + soap.isSoap)
			CONS_Printf(p, "     	"+"IsXmo " + soap.isXmo)
			CONS_Printf(p, "     	"+"IsSuper " + soap.isSuper)
			CONS_Printf(p, "     	"+"IsSuperM " + soap.isSuperM)
			CONS_Printf(p, "     	"+"IsElevated " + soap.isElevated)
			CONS_Printf(p, "     	"+"InPain " + soap.inPain)
			CONS_Printf(p, "     	"+"SPR " + soap.SspinREADY)
			CONS_Printf(p, "     	"+"SPD " + soap.SspinDOWN)
			CONS_Printf(p, "     	"+"TFR " + soap.StossflagREADY)
			CONS_Printf(p, "     	"+"TFD " + soap.StossflagDOWN)
			CONS_Printf(p, "     	"+"C1R " + soap.Scustom1READY)
			CONS_Printf(p, "     	"+"C1D " + soap.Scustom1DOWN)
			CONS_Printf(p, "     	"+"C2R " + soap.Scustom2READY)
			CONS_Printf(p, "     	"+"C2D " + soap.Scustom2DOWN)
			CONS_Printf(p, "     	"+"C3R " + soap.Scustom3READY)
			CONS_Printf(p, "     	"+"C3D " + soap.Scustom3DOWN)
			CONS_Printf(p, "     "+"\x82"+"}")
		else
		CONS_Printf(p, "No SoapTable? How!?")
		end
		if p.SOAPfreefallFL
			CONS_Printf(p, "     "+"\x82"+"Soap FreeFallFrameList {")
			CONS_Printf(p, "     	"+"0")
			CONS_Printf(p, "     	"+"1")
			CONS_Printf(p, "     "+"\x82"+"}")
		
		else
		CONS_Printf(p, "No FreeFallFrameList? How!?")
		end
		CONS_Printf(p, "\x82"+"Player Stats")
		CONS_Printf(p, "Player# " + #player)
		CONS_Printf(p, "Player " + p.name)
		CONS_Printf(p, "Skin " + me.skin)
		CONS_Printf(p, "SoapTable " + soap)
		CONS_Printf(p, "Skin NormalSpeed " + skins[me.skin].normalspeed/FRACUNIT)
		CONS_Printf(p, "NormalSpeed " + p.normalspeed /FRACUNIT)
		CONS_Printf(p, "RunSpeed " + p.runspeed / FRACUNIT)
		CONS_Printf(p, "Speed " + p.speed / FRACUNIT)
		CONS_Printf(p, "MinDash " + p.mindash / FRACUNIT)
		CONS_Printf(p, "MaxDash " + p.maxdash / FRACUNIT)
		CONS_Printf(p, "Peel " + p.dashmode)
		CONS_Printf(p, "ActionSpeed " + p.actionspd / FRACUNIT)
		CONS_Printf(p, "AccelStart " + p.accelstart)
		CONS_Printf(p, "Acceleration " + p.acceleration)
		CONS_Printf(p, "ThrustFactor " + p.thrustfactor)
		if p.mrce
		CONS_Printf(p, "     "+"\x8D"+"Mystic Realm CE Table {")
		CONS_Printf(p, "     	"+"MRCE " + p.mrce)
		CONS_Printf(p, "     	"+"MRCECustomskin " + p.mrcecustomskin)
		CONS_Printf(p, "     	"+"Customskin " + p.mrce.customskin)
		CONS_Printf(p, "     	"+"MRCE Physics " + p.mrce.physics)
		CONS_Printf(p, "     "+"\x8D"+"}")
		else
		CONS_Printf(p, "No MRCE.")
		end
		if p.isxmomentum
		CONS_Printf(p, "     "+"\x8D"+"XMomentum Stuff {")
		CONS_Printf(p, "     	"+"Xmo " + p.isxmomentum)
		CONS_Printf(p, "     	"+"XmoON " + p.soaptable.isXmoON)		
		CONS_Printf(p, "     	"+"SpringFlip " + p.spcanflip)
		CONS_Printf(p, "     "+"\x8D"+"}")
		else
		CONS_Printf(p, "No XMomentum.")
		end
	end
end)
*/

rawset(_G, "SoapBattleModSet", function(p, me, soap)
	local battleModSet
			
			
			if (battleModSet) or not (CBW_Battle and CBW_Battle.SkinVars) then 
				return 
			end
			battleModSet = 1
			
			
			CBW_Battle.SkinVars["soapthehedge"] = {
				weight = 55,
				shields = 1,
				special = CBW_Battle.Action.SuperSpinJump,
				guard_enabled = 1,
				guard_frame = 2,
				func_guard_trigger = CBW_Battle.GuardFunc.Parry,
				func_priority = CBW_Battle.Priority_FullCommon,
				func_priority_ext = PriorityFunction
			}

			//the rare "then" !
			if CBW_Battle then
				if soap.isSoap and CBW_Battle.BattleGametype() then
					soap.nerfed = 1
					p.charability = CA_HOMINGTHOK
					p.actionspd = 84 * FRACUNIT //nerfed
					p.charflags = $ & ~SF_MULTIABILITY
					//^this isnt nerfed! its the same as indev2.1.4!
					if not ((soap.nerfbuff) or (soap.nerfmebuff))
						if not (p.normalspeed == (36 * FRACUNIT)) and (not soap.isDash)
							p.normalspeed = 36 * FRACUNIT
						end
						p.runspeed = 30 * FRACUNIT
						p.mindash = 15 * FRACUNIT
						p.maxdash = 70 * FRACUNIT
					//	soap.recurlAble = 0 //maybe i should make this a server var?
					else
						//resset these
						//i can probably make a way to reset this automatically, but im too lazy
						soap.nerfed = 0
						p.charflags = $1 |SF_MULTIABILITY
						if not (p.normalspeed == (64 * FRACUNIT)) and (not soap.isDash)
							p.normalspeed = 64 * FRACUNIT
						end
						p.runspeed = 58 * FRACUNIT
						p.mindash = 100 * FRACUNIT
						p.maxdash = skins[me.skin].maxdash
						soap.recurlAble = 1
					end
				else
					if soap.isSoap then
						soap.nerfed = 0
						p.charflags = $ & ~SF_MULTIABILITY
						p.charability = CA_JUMPTHOK
						p.actionspd = 30 * FRACUNIT //these probably interfere with the momentums thokspeed modifier but whatever
						//reset all our nerfed stuff back to normal!
						if not (p.normalspeed == (64 * FRACUNIT)) and (not soap.isDash)
							p.normalspeed = 64 * FRACUNIT
						end
						p.runspeed = 58 * FRACUNIT
						p.mindash = 100 * FRACUNIT
						p.maxdash = skins[me.skin].maxdash
						soap.recurlAble = 1
					end
				end
			end
end)

--[[
		rawset(_G, "SoapyTrail", function(colorize, glow, me, a, b)
			local trail = P_SpawnGhostMobj(me)
			if a
				trail.color = a
			elseif not a
				trail.color = me.color
			end
			
			if b
				trail.state = b
			end
			
			//based on alt sonic
			//unused
		/*	if taper
				trail.scale = me.scale
			end
		*/	

			//trail.destscale = $*(1/4)
			//trail.destscale = 0

			trail.fuse = 13
			if colorize
				trail.colorized = true
			else
				trail.colorized = false
			end
			if glow
				trail.blendmode = AST_ADD
			end
			trail.frame = TR_TRANS70
		end)

		//mustve messed something up, so im making another one
		//without any of the fancy stuff, just transparency
		rawset(_G, "SoapyTrail2", function(me)
			local trail = P_SpawnGhostMobj(me)
			trail.fuse = 13
			trail.frame = TR_TRANS90
		end)
--]]
//i wanna use this later, but i dont want this to be used while air uncurling
/*
rawset(_G, "SoapAirDash", function(p, me, soap)
			//this is the code that handles airdashing itself!	
			if (soap.momzfreeze > 0) or (soap.momzfreezeadd > 0)
				//give us some bounce!
				me.state = S_PLAY_SOAP_FREEFALL
				if soap.momzfreezeadd > 0
					soap.momzfreezeadd = $ - (1 * FRACUNIT)
				else
					soap.momzfreezeadd = 0
				end
				CONS_Printf(p, "Ghosts go here!")
				me.momz = 0 + soap.momzfreezeadd
				soap.momzfreeze = $ - 1
			end
			
end)
*/
local function FixedLerp(a, b, w)
    return FixedMul((FRACUNIT - w), a) + FixedMul(w, b)
end

//making the SoapyTrail into seperate functions, so things dont break again
//first up is jump trails
rawset(_G, "SoapSpawnJumpTrail", function(glow, p, me, fuse, xs, ys, trailmo, freq, trailsmall)
	//we cant curl in ZE, so trails would look weird there
	if p.soaptable.isZE
		return
	end
	if p.soaptable.flytoggle
		return
	end
	if p.soaptable.trailed
		return
	else
		p.soaptable.trailed = true
	end

	if ((p.soaptable.divecancel) and (p.soaptable.divecancel <= 16))
		return
	end
	
		//this looks a little weird in software, so lets change that!
		local rend = 1
		if p == displayplayer
			rend = CV_FindVar("renderer").value
		end
		
		local freq
		local soap = p.soaptable
		local blend = AST_TRANSLUCENT
		
		if glow
			blend = AST_ADD
		end
		
		freq = FRACUNIT
		
		if rend == 1
			if glow
				freq = 14*FRACUNIT
			else
				freq = 9*FRACUNIT
			end
		elseif rend == 2
			if glow
				freq = 5*FRACUNIT/2
			else
				freq = 3*FRACUNIT/2
			end			
		end
		
		if SoapFetchConstant("soap_performance")
			freq = 3*$/2
		end
		if (soap.spintrailcolor == SKINCOLOR_SOAPYGREEN)
		or (soap.spintrailcolor == SKINCOLOR_GREEN)
		or (soap.spintrailcolor == SKINCOLOR_ICY)
		and soap.cosspinglow
			freq = $*2
		end
		
		if p.soaptable.costrailstyle == 1
			
			//rebound dash
			//im too lazy to make anopther one so i just used rebound dash's
			local previousx = soap.last.pos[1]
			local previousy = soap.last.pos[2]
			local previousz = soap.last.pos[3]
			local mo = me
							
			for i = 0, 9
				local percent = FRACUNIT * (i * 10) / 100
				local trail = P_SpawnMobj(mo.x, mo.y, mo.z, MT_THOK)
				local tx = FixedLerp(mo.x,previousx,percent)
				local ty = FixedLerp(mo.y,previousy,percent)
				local tz = FixedLerp(mo.z + 3*FRACUNIT,previousz + 4*FRACUNIT,percent)
				local trans = TR_TRANS70
				P_SetOrigin(trail, tx, ty, tz - 7 * FRACUNIT)
				trail.color = soap.spintrailcolor
				trail.spriteyoffset = 7*FRACUNIT
				//trail.fuse = 13
				trail.state = S_THOK
				trail.scalespeed = FRACUNIT/12
				trail.scale = (FRACUNIT * 5/6) - (i * FRACUNIT/120)
				trail.destscale = 0
				if blend == AST_ADD then
					trans = TR_TRANS90
				end
				trail.frame = trans|A
				trail.blendmode = blend
				trail.tracer = me
			end
				
		elseif p.soaptable.costrailstyle == 2
			//for whatever reason, applying soap's hiresscale to this
			//makes it not flip gravity
			//strange
			if trailmo == MT_SOAPYTRAIL
				trailmo = MT_THOK
			end
			
			//ffoxD's smooth spintrails
			local mo = me
			if not mo.prevz or not mo.prevleveltime or (mo.prevleveltime ~= leveltime - 1) then
			   mo.prevz = mo.z
			end
			
			local rmomz = mo.z - mo.prevz
			mo.prevz = mo.z
			mo.prevleveltime = leveltime

			local mospeed = R_PointToDist2(0, 0, R_PointToDist2(0, 0, mo.momx, mo.momy), rmomz)
			local dist = (mospeed/freq)
			local trans = TR_TRANS20
			
			if mospeed >= 4*me.scale
				mospeed = 4*me.scale
			end
			if dist >= 50
				dist = 50
			end
			
			-- The loop, repeats until it spawns all the thok objects.			
			for i = dist, 1, -1 do
				local spawnedmo = P_SpawnMobjFromMobj(mo, (mo.momx/dist)*i, (mo.momy/dist)*i, ((rmomz*soap.gravflip)/dist)*i, trailmo)
				
				//outta my face!
				if not soap.isFirstPerson
					spawnedmo.flags2 = $ &~MF2_DONTDRAW
				else
					spawnedmo.flags2 = $|MF2_DONTDRAW
				end

				if trailsmall
					spawnedmo.scale = FixedMul(3*FRACUNIT/4, me.scale)
				end
				
				spawnedmo.color = soap.spintrailcolor
				
				if glow
					trans = TR_TRANS90
				else
					if rend == 1
						trans = TR_TRANS40
					else
						trans = TR_TRANS90
					end
				end
				spawnedmo.blendmode = blend
				spawnedmo.frame = trans|A
	
				spawnedmo.scalespeed = $*10/9				
				spawnedmo.destscale = spawnedmo.scalespeed+1
				
				spawnedmo.fuse = fuse

				//spawnedmo.destscale = $/180
				//spawnedmo.scalespeed = FRACUNIT/10
			
				spawnedmo.spriteyoffset = -6*FRACUNIT
				if trailsmall
					spawnedmo.spriteyoffset = 1*FRACUNIT
				end
				
				if xs
					spawnedmo.spritexscale = xs
				end
				if ys
					spawnedmo.spriteyscale = ys
				end

			end
			
		end
end)

//small little aura that surrounds us
rawset(_G, "SoapSpawnSurroundingSpinTrail", function(p,me,soap,glow)
	local rend = 1
	if p == displayplayer
		rend = CV_FindVar("renderer").value
	end
	
	
	local spawnedmo = P_SpawnMobjFromMobj(me,0,0,0,MT_THOK)
	spawnedmo.color = soap.spintrailcolor
	spawnedmo.destscale = 8*$/6
	spawnedmo.scalespeed = FRACUNIT/10
	if glow
		if rend == 2
			spawnedmo.blendmode = AST_ADD -- blend
			//glowy but not bright?
			spawnedmo.frame = TR_TRANS90
		else
			spawnedmo.blendmode = AST_ADD -- blend
			//glowy but not bright?
			spawnedmo.frame = TR_TRANS50
		end
	else
		if rend == 1
			spawnedmo.frame = TR_TRANS40
		else
			spawnedmo.frame = TR_TRANS90
			spawnedmo.blendmode = AST_TRANSLUCENT
		end
	end
	

end)


//just SoapSpawnJumpTrail but a little smaller
rawset(_G, "SoapSpawnThokDashTrail", function(glow, p, me, fuse)
	if p.soaptable.flytoggle
		return
	end
	
	local soap = p.soaptable
	local blend = AST_TRANSLUCENT
		
	if glow
		blend = AST_ADD
 	end
	
	if p.soaptable.costrailstyle == 1
	
		if soap.trailed
			return
		else
			soap.trailed = true
		end
			
		//rebound dash
		//im too lazy to make anopther one so i just used rebound dash's
		local previousx = soap.last.pos[1]
		local previousy = soap.last.pos[2]
		local previousz = soap.last.pos[3]
		local mo = me
							
		for i = 0, 9
			local percent = FRACUNIT * (i * 10) / 100
			local trail = P_SpawnMobj(mo.x, mo.y, mo.z, MT_THOK)
			local tx = FixedLerp(mo.x,previousx,percent)
			local ty = FixedLerp(mo.y,previousy,percent)
			local tz = FixedLerp(mo.z + 3*FRACUNIT,previousz + 4*FRACUNIT,percent)
			local trans = TR_TRANS70
			P_SetOrigin(trail, tx, ty, tz - 7 * FRACUNIT)
			trail.color = soap.spintrailcolor
			trail.spriteyoffset = 17*FRACUNIT
			//trail.fuse = 13
			trail.state = S_THOK
			trail.scalespeed = FRACUNIT/12
			trail.scale = (FRACUNIT * 4/6) - (i * FRACUNIT/100)
			trail.destscale = 0
			if blend == AST_ADD then
				trans = TR_TRANS90
			end
			trail.frame = trans|A
			trail.blendmode = blend
			trail.tracer = me
		end
			
	elseif  p.soaptable.costrailstyle == 2
		SoapSpawnJumpTrail(p.soaptable.cosspinglow, p, me, 32, me.spritexscale, me.spriteyscale, MT_SOAPYTRAIL, 6*FRACUNIT, true)
	end

end)


//nothing fancy here, just regular ghosts
//scrap that, lets add some pizza tower styled afterimages!!
//lets make this follow the soap, so we can actually see the thing
/*
rawset(_G, "SoapySneakerDashTrail", function(p, me, soap, color)
//	local ghost = P_SpawnGhostMobj(me)
//	ghost.frame = TR_TRANS80
//	ghost.destscale = $*99
	if soap.ptaiframewait
//	or p.ptaiinit
	//^so it doesnt interfere with my other addon
	//https://mb.srb2.org/addons/pizza-tower-styled-after-imageme.4825/
		return
	end
	if soap.isTransform
		return
	end
	local chasecam = CV_FindVar("chasecam")
	local afteri = P_SpawnGhostMobj(me)

	local pspeed = soap.accSpeed - skins[me.skin].normalspeed
	local nspeed
	if not soap.nerfed
		nspeed = skins[me.skin].normalspeed
	else
		nspeed = 36*FRACUNIT
	end
	local trns = 0
	
	//scale transparency with speed
	//making this scale with normalspeed would not only:
	//1: make it compatible with battlemod nerf
	//2: easy copy+paste into my addon
//	if pspeed
	//	
//	end
	
	afteri.colorized = true
	afteri.frame = FF_FULLBRIGHT|me.frame|AST_COPY
	//this might error if theres no transparency
	if trns
		afteri.frame = $ |trns & ~AST_COPY
	end
	afteri.fuse = 14
	//see if this can prevent our trails from making the killing blow sound
	afteri.isGhost = 1
	afteri.spritexscale = me.spritexscale
	afteri.spriteyscale = me.spriteyscale

	P_SetOrigin(afteri, afteri.x-(me.momx/-2), afteri.y-(me.momy/-2), afteri.z)
	
	if p.ptaistyle and (p.ptaistyle == 2)
		if color == 1
			afteri.color = SKINCOLOR_AIREALLYBLUE
		elseif color == 2
			afteri.color = SKINCOLOR_AIREALLYPINK
		end	
	elseif p.ptaistyle and (p.ptaistyle == 3)
	and ((p.ptaicolor1) and (p.ptaicolor2))
		if color == 1
			afteri.color = p.ptaicolor1
		elseif color == 2
			afteri.color = p.ptaicolor2
		end			
	else
	
		if color == 1
			afteri.color = SKINCOLOR_SOAPAIREALLYRED
		elseif color == 2
			afteri.color = SKINCOLOR_SOAPAIREALLYGREEN
		end
	end
	
	//should you be out of my face?
	if chasecam.value
		afteri.flags2 = $ & ~MF2_DONTDRAW
	else
		afteri.flags2 = $ | MF2_DONTDRAW
		return
	end
	
	//P_RemoveMobj(afteri)
end)
*/


rawset(_G, "SoapyAirAfterImages", function(me, fuse)
	local ghost = P_SpawnGhostMobj(me)
	ghost.color = SKINCOLOR_ICY
	ghost.colorized = true
	ghost.fuse = fuse
	ghost.frame = TR_TRANS70
	ghost.isGhost = 1

end)

rawset(_G, "SoapySuperGhosts", function(me)
	local ghost = P_SpawnGhostMobj(me)
	ghost.color = me.color
	ghost.colorized = true
	ghost.frame = TR_TRANS90
	ghost.destscale = $*105
	//move us to soap, so we look like an aura, and not a trail
	P_MoveOrigin(ghost, me.x, me.y, me.z)
end)

rawset(_G, "SoapQuakes", function(p, int, tic)
	if p.soaptable.cosquakes
	and p == displayplayer
		P_StartQuake(int, tic)
	end
end)

rawset(_G, "SoapFlashPals", function(p, pal, tic)
	if p.soaptable.cosflashes
		P_FlashPal(p, pal, tic)
	end
end)
rawset(_G, "SoapySuperDashBoom", function(p, me)
	local ghost = P_SpawnGhostMobj(me)
	ghost.color = me.color
	ghost.colorized = true
	ghost.scale = me.scale*(1+(1/2))
	ghost.destscale = $*4590
	SoapQuakes(p, 60*FRACUNIT, 5)
	//destroy any enemies near us, so we dont instantly lose dashmode
	P_NukeEnemies(me, me, 10*me.scale)
	SoapFlashPals(p, PAL_WHITE, 3)

end)

//for when you hold c3 when airdashing, with a shield
//replace shield actions with c2!
				//link shield ability to c2
			//	if (not soap.noShield)
			//	and not soap.onGround
			//	and (p.pflags & PF_JUMPED) and (not (p.pflags & PF_SHIELDABILITY))
			//		p.pflags = $ |PF_SHIELDABILITY
			//		SoapyShieldSynergy(p, me, soap)
			//	end

rawset(_G, "SoapyShieldSynergy", function(p, me, soap)	
		//pity shields
		//great for cashing them in for rings!
		if (p.powers[pw_shield] == SH_PITY)
		or (p.powers[pw_shield] == SH_PINK)
			SoapFlashPals(p, PAL_WHITE, 3)
			P_GivePlayerRings(p, 10)
			S_StartSound(me,sfx_chchng)
			S_StartSound(me,sfx_itemup)
			p.powers[pw_shield] = SH_NONE
			
			//give points!
				P_AddPlayerScore(p, 100)
				local plus100 = P_SpawnMobjFromMobj(me, 0, 0, 50*me.scale, MT_SOAPPLUS100TEXT)
				plus100.timealive = 1
				plus100.scale = (3*FRACUNIT/4)
				if (not (gametyperules & GTR_FRIENDLY))
					plus100.color = p.skincolor
				else
					plus100.color = SKINCOLOR_WHITE
				end

		end
		
		//boost with whirlwind
		if (p.powers[pw_shield] == SH_WHIRLWIND)
			if (me.momz*soap.gravflip) > 0
				me.momz = $+(15*soap.gravflip)*me.scale
			else
				me.momz = (25*soap.gravflip)*me.scale
			end
			S_StartSound(me,sfx_wdjump)
			p.pflags = $ & ~PF_THOKKED & ~PF_SPINNING
			SoapResetBounceAndDiveVars(p, me, soap)
		end
			
		//may death be opon ye
		if (p.powers[pw_shield] == SH_ARMAGEDDON)
			//kaaBOOM!!!
			P_NukeEnemies(me, me, 3500*me.scale)
			SoapQuakes(p, 60*FRACUNIT, 5)
			SoapFlashPals(p, PAL_NUKE, 5)
			S_StartSound(me,sfx_bkpoof)
			p.powers[pw_shield] = SH_NONE
		end
		
		if (p.powers[pw_shield] == SH_ELEMENTAL)
			//good thing vanilla already handles the
			//drop for us, so all we need to do is set PF_SHIELDABILTIY
			S_StartSound(me,sfx_s3k43)
			me.state = S_PLAY_FALL
			me.momx = 0
			me.momy = 0
		end
		
		local t = soap.attracttarg
		//literally just copied from TeamNew
		if (p.powers[pw_shield] == SH_ATTRACT)
			p.pflags = $|PF_THOKKED|PF_SHIELDABILITY
			p.homing = 2
			if t and t.valid
				me.target = t
				me.tracer = t
				P_HomingAttack(me,me.target)
				me.angle = R_PointToAngle2(me.x,me.y, t.x, t.y)
				p.pflags = $&~PF_NOJUMPDAMAGE
				me.state = S_PLAY_ROLL
				S_StartSound(me, sfx_s3k40)
				p.homing = 3*TICRATE
				SoapResetAirdashTimer(soap)
			else
				me.target = nil
				me.tracer = nil
				S_StartSound(me, sfx_s3ka6)
			end
		end
		
		if (p.powers[pw_shield] & SH_FORCE)
			soap.forceuse = $+1
			if soap.forceuse <= 5
				S_StartSound(me,sfx_ngskid)
				me.momx = 0
				me.momy = 0
				me.momz = 0
				soap.noballroll = 1
			else
				if not soap.inPain
					P_DoPlayerPain(p, me, me)
					p.drawangle = me.angle
					S_StartSound(me,sfx_slip)
					P_Thrust(me, me.angle, (-15*(soap.forceuse-4))*FRACUNIT)
					p.pflags = $ & ~PF_SHIELDABILITY
					//no chance of jumping out of this one!
					soap.recovwait = -99*FRACUNIT
				end
			end
			SoapResetBounceAndDiveVars(p, me, soap)
		end
		
		if (p.powers[pw_shield] == SH_FLAMEAURA)
			p.pflags = $ |PF_THOKKED
			me.momz = 0
			P_Thrust(me, me.angle, (30*me.scale))
			p.drawangle = me.angle
			me.state = S_PLAY_ROLL
			S_StartSound(me,sfx_s3k43)
		end
		
		if (p.powers[pw_shield] == SH_BUBBLEWRAP)
			me.momz = (-20*FRACUNIT)*soap.gravflip
			p.pflags = $&~(PF_NOJUMPDAMAGE)
			me.state = S_PLAY_ROLL
			S_StartSound(me,sfx_s3k44)
			
		end
		
		if (p.powers[pw_shield] == SH_THUNDERCOIN)
			P_DoJumpShield(p)
		end
		
		if (p.powers[pw_shield] & SH_FIREFLOWER)
		//	P_SpawnMobjFromMobj(
			return
		end
end)

rawset(_G, "SoapyShieldHUDText", function(p, me, soap)	
		//literally just SoapyShieldSynergy but just with small strings for the hud
		if (p.powers[pw_shield] == SH_PITY)
		or (p.powers[pw_shield] == SH_PINK)
			soap.hudshieldability = "Plus 10 rings & 100 score"
		end
		
		if (p.powers[pw_shield] == SH_WHIRLWIND)
		or (p.powers[pw_shield] == SH_THUNDERCOIN)
			soap.hudshieldability = "Extra Jump"
		end
			
		if (p.powers[pw_shield] == SH_ARMAGEDDON)
			soap.hudshieldability = "Insta-Nuke"
		end
		
		if (p.powers[pw_shield] == SH_ELEMENTAL)
			soap.hudshieldability = "Elemental Ground-pound"
		end
		if (p.powers[pw_shield] == SH_ATTRACT)
			soap.hudshieldability = "Homing Attack"
		end
		
		if (p.powers[pw_shield] & SH_FORCE)
			soap.hudshieldability = "5 Force Stops"
		end
		
		if (p.powers[pw_shield] == SH_FLAMEAURA)
			soap.hudshieldability = "Flame Dash"
		end
		
		if (p.powers[pw_shield] == SH_BUBBLEWRAP)
			soap.hudshieldability = "Bubble Bounce"
		end
		
		if (p.powers[pw_shield] & SH_FIREFLOWER)
			return
		end
end)
rawset(_G, "SoapSolFormBonuses", function(p, me, soap, sol)
	if not sol
		return
	end
	
	//based off a script my friend made for me
	
	if (me.state == S_PLAY_ROLL or me.state == S_PLAY_RUN or me.state == S_PLAY_DASH) and soap.onGround
	and not soap.isWatered
		P_ElementalFire(p)
	end
	
	//fire extinguishes water
	if (p.pflags & PF_THOKKED)
	and not soap.isWatered
		A_BossScream(me, 0, MT_FIREBALLTRAIL)
	end
	
	if not soap.isWatered
		local SolTrail3 = P_SpawnMobjFromMobj(p.realmo, P_RandomRange(-20, 20) * FRACUNIT, P_RandomRange(-20, 20) * FRACUNIT, P_RandomRange(0, 50) * FRACUNIT, MT_FIREBALLTRAIL)
			SolTrail3.color = SKINCOLOR_RED
			SolTrail3.colorized = true
			SolTrail3.scale = (1*FRACUNIT/2)*me.scale
			SolTrail3.destscale = (1*FRACUNIT/4)*me.scale
			SolTrail3.momz = 2*FRACUNIT
		local SolTrail4 = P_SpawnMobjFromMobj(p.realmo, P_RandomRange(-20, 20) * FRACUNIT, P_RandomRange(-20, 20) * FRACUNIT, P_RandomRange(0, 50) * FRACUNIT, MT_PUMATRAIL)
			SolTrail4.color = SKINCOLOR_ORANGE
			SolTrail4.colorized = true
			SolTrail4.scale = (1*FRACUNIT/2)*me.scale
			SolTrail4.destscale = (1*FRACUNIT/4)*me.scale
			SolTrail4.momz = 2*FRACUNIT
	end
end)

//lets see if i can make something thats actually decent
rawset(_G, "SoapBetterAirDash", function(p, me, soap)
	if soap.spindown
		soap.airdashed = 1
		p.homing = 0
		soap.airdashing = 13
		p.pflags = $ & ~PF_SPINNING	
		me.state = S_PLAY_SOAP_FREEFALL
		soap.momzfreeze = 10
		me.momz = 0
		p.dashmode = $ + (25 + (($/FRACUNIT)/2))
		S_StartSound(me,sfx_rail2)
		if soap.isDash
			S_StartSound(me,sfx_sburst)
		end
		p.drawangle = me.angle
/*		
		if soap.Scustom3DOWN and soap.isSValid
			SoapyShieldSynergy(p, me)
		end
*/		
		if not soap.nerfed
			P_Thrust(me, me.angle, (soap.accSpeed*2/3)+(45*me.scale))
		else
			P_InstaThrust(me,me.angle,45*me.scale,true)
		end
		
		if soap.accSpeed >= 3*skins[me.skin].normalspeed/2
			SoapSpawnWindRing(p,me,soap)
		end
		
//		if soap.isSuper or soap.isSol
//			me.momx = $*2
//			me.momy = $*2
	//	elseif soap.isSol
	//		me.momx = $*2
	//		me.momy = $*2
//		end

	end
end)

//kinda finiky, but ehh
rawset(_G, "SoapSpikeBreak", function(me)
	if SoapFetchConstant("soap_blockmapsallowed") == 0
		return
	end
	
						local px = me.x
						local py = me.y
						local br = 3*me.scale

						searchBlockmap("objects", function(me, found)
							if found and found.valid
							and ( ((found.z+found.height) - me.z) <= 80*FRACUNIT+(abs(me.momz/2))) and ((found.z+found.height) - me.z) > 0
							and found.health
								if found.type == MT_SPIKE --Endlessly harrass spikes!
								or found.type == MT_WALLSPIKE --Endlessly harrass spikes! X2
								or found.type == MT_WALLSPIKEBASE --Endlessly harrass spikes! X3
								and not (found.flags & MF_SPRING)
									P_KillMobj(found, me, me) //KILL!!!
								end--This kills the things
							end
						end, me, px-br, px+br, py-br, py+br)
end)


rawset(_G, "MeSound", function(sfx, player)
	S_StartSound(nil, sfx, player)
end)

rawset(_G, "MeSoundHalfVolume", function(sfx, player)
	S_StartSoundAtVolume(nil, sfx, 255/2, player)
end)

--[[
//function that handles diveing
rawset(_G, "SoapBombDive", function(p, me, soap)
	if not soap.dived
	//	S_StopSoundByID(me, sfx_bombst)
		S_StopSoundByID(me, sfx_bomblp)
//		if soap.bombsfx ~= 33
//			soap.bombsfx = 33
//		end
		return
	end
	
	if soap.divefallwait
		soap.divefallwait = $-1
	//	S_StopSoundByID(me, sfx_bombst)
		S_StopSoundByID(me, sfx_bomblp)		
		return
	end
	
	if not ((me.state == S_PLAY_JUMP) or (me.state == S_PLAY_ROLL))
	//	S_StopSoundByID(me, sfx_bombst)
		S_StopSoundByID(me, sfx_bomblp)		
		return
	end
	
	if soap.divecancel
		return
	end
	
	soap.bombsfxplay = S_SoundPlaying(me,sfx_bomblp)

	if not soap.bombsfxplay
		S_StartSound(me,sfx_bomblp)
	end

	soap.diving = 1
	//chrispy chars
	if not (p.cmd.forwardmove or p.cmd.sidemove)
		me.momx = 0
		me.momy = 0
	end
	
	//print(me.eflags & MFE_GOOWATER)
	if me.eflags & MFE_GOOWATER
		me.momz = $ - soap.gravflip*FixedMul(skins[me.skin].actionspd/40, me.scale)
		if not soap.goobounce
			soap.goobounce = 12
		end
		if abs(me.momz) > 15*FRACUNIT
			me.momz = 15*FRACUNIT
		end
	else
		if not soap.isWatered
			me.momz = soap.gravflip*(min(soap.gravflip*$, 0) - FixedMul((skins[me.skin].actionspd)/7, me.scale))
			SoapQuakes(p, me.momz/2, 1)
		else
//			if not (abs(me.momz) > 15*FRACUNIT)
				me.momz = soap.gravflip*(min(soap.gravflip*$, 0) - FixedMul((skins[me.skin].actionspd)/30, me.scale))	
//			end
			SoapQuakes(p, me.momz/4, 1)
		end
		soap.goobounce = 0
	end
		
	p.pflags = $ |PF_THOKKED
	
	//maybe make this a tic system?
	//this
	if ((me.momz*soap.gravflip) < (soap.bombmomz*soap.gravflip))
		soap.bombmomz = me.momz
	end
/*
	if (me.momz*soap.gravflip) < 5*FRACUNIT
		me.spriteyscale = FRACUNIT+(abs(me.momz)/soap.bombyd)
		me.spritexscale = FRACUNIT-(abs(me.momz)/soap.bombxd)
	end
	
	//cap stetching so we dont go paper thin
	if me.spriteyscale < (me.scale/3)
		me.spriteyscale = me.scale/3
	elseif me.spritexscale < (me.scale/3)
		me.spritexscale = me.scale/3
	end
*/	
	SoapSpawnJumpTrail(soap.cosspinglow, p, me, 32, me.spritexscale, me.spriteyscale, MT_SOAPYTRAIL, 4*FRACUNIT)

end)

//this caused me way more trouble than it shouldve
//check if we've hit the ground while diving
rawset(_G, "SoapCheckForDiveBomb", function(p, me, soap)
				if soap.dived or soap.diving
				and not (soap.divecancel)
				and P_IsObjectOnGround(me)
				and p.playerstate == PST_LIVE
					if not (soap.divecancel == 0)
						soap.divecancel = 0
						return
					end
					if (abs(soap.bombmomz))/FRACUNIT > 35
						PVPEarthQuake(me, me, abs(soap.bombmomz)*20,me)
					end

					soap.bouncecount = 0
					S_StartSound(me,sfx_bmslam)
					SoapQuakes(p, abs(soap.bombmomz*2/3), 10)
					soap.bombmomz = 0
				end
end)
--]]

//thank you Tatsuru for this thing on the srb2 discord!
local function CheckAndCrumble(me, sec)
	for fof in sec.ffloors()
		if not (fof.flags & FF_EXISTS) continue end -- Does it exist?
		if not (fof.flags & FF_BUSTUP) continue end -- Is it bustable?
		
		if me.z + me.height < fof.bottomheight continue end -- Are we too low?
		if me.z > fof.topheight continue end -- Are we too high?

		EV_CrumbleChain(fof) -- Crumble
	end
end

//function so bounce and dive can use this without having to copypaste
rawset(_G, "SoapBustableFOFBreak", function(p, me)
	CheckAndCrumble(me, me.subsector.sector)
end)

//only used once or twice, but still prettu useful for laziness
rawset(_G, "SoapResetBounceAndDiveVars", function(p, me, soap)
	if p.soaptable
		soap.bounced = 0
		soap.bounceagain = 0
		soap.bouncecount = 0
		soap.fullstasistic = 0
		soap.goobounce = 0
		soap.starteddive = 0
		soap.diveanimstart = 0
		soap.divemomz = 0
		soap.divecancel = 0
	end
end)
rawset(_G, "SoapResetComboVars", function(soap)
	if soap
		soap.combocount = 0
		soap.combotime = 0
		soap.comboendtics = 0
		soap.comboendscore = 0
		soap.comboendrank = 1
		soap.comboendvery = false
		soap.comborank = 1
		soap.combovery = false
		soap.comborankuptic = 0
	end
end)


//local because what else needs to use this?
local function AddRollangleToForceField(ff, angle)
	if ff.rngspin == 1
		ff.rollangle = $ - (angle)
	else
		ff.rollangle = $ + (angle)
	end
end
local function ChangeForceFieldFrame(ff, table)
	if ff.rngspin == 1
		ff.frame = table[(leveltime % 12) + 1]
	else
		ff.frame = table[(12 - ((leveltime % 12) + 1))+1]
	end

end

rawset(_G, "SoapSpawnRobloxForceField", function(p, me, soap)
			if (p.powers[pw_invulnerability]) and (maptol & TOL_MARIO) then
				return
			end
			
			//spawn roblox forcefield!
			if ((p.powers[pw_invulnerability]) or (p.powers[pw_flashing]))
			and me.health
				if not soap.forcefield
					soap.forcefield = P_SpawnMobjFromMobj(me, 0, 0, 0, MT_SOAPYFORCEFIELD)
					soap.forcefield.rngspin = P_RandomRange(-1, 1)
				end
			else
				if soap.forcefield
				and soap.forcefield.valid
					P_RemoveMobj(soap.forcefield)
					soap.forcefield = 0
					//spawn sparkles!
					for i = 0, 25
						if i == 0
							//SoapFlashPals(p, PAL_WHITE, 3)
							//MeSound(sfx_pop,p)
						end
						if not SoapFetchConstant("soap_performance")
							P_SpawnMobjFromMobj(me,P_RandomRange(-i,i)*FRACUNIT,P_RandomRange(-i,i)*FRACUNIT,P_RandomRange(-i,i)*FRACUNIT,MT_BOXSPARKLE)
						end
						//MORE!!
						//maybe not
						if not SoapFetchConstant("soap_performance")
							if i <= 15
								P_SpawnMobjFromMobj(me,(P_RandomRange(-66, 66)*FRACUNIT),(P_RandomRange(-66, 66)*FRACUNIT),(P_RandomRange(-1, 66)*FRACUNIT), MT_BOXSPARKLE)
							end
						else
							if i <= 4
								P_SpawnMobjFromMobj(me,(P_RandomRange(-66, 66)*FRACUNIT),(P_RandomRange(-66, 66)*FRACUNIT),(P_RandomRange(-1, 66)*FRACUNIT), MT_BOXSPARKLE)
							end						
						end
				//		P_SpawnMobjFromMobj(me,P_RandomRange(-i,i)*FRACUNIT/3,P_RandomRange(-i,i)*FRACUNIT/3,P_RandomRange(-i,i)*FRACUNIT/3,MT_BOXSPARKLE)

						if not SoapFetchConstant("soap_performance")
							A_BossScream(me, 0, MT_BOXSPARKLE)
						end
					end
				/*	if not soap.forcefield.fuse
						soap.forcefield.fuse = 15
					else
						soap.forcefield.frame = $ + FF_TRANS30
						print(soap.forcefield.fuse)
					end
			*/	end
			end
			
			if soap.forcefield
			//bottomless pits kill everything, so if a bottomless pit kills
			//this and you get an error, too bad!
			and soap.forcefield.valid
				//set owner
				soap.forcefield.target = me
				//spawn a sparkle
				if leveltime % 4 == 0
					if not soap.isSol
						local sparkle = P_SpawnMobjFromMobj(me,(P_RandomRange(-66, 66)*FRACUNIT),(P_RandomRange(-66, 66)*FRACUNIT),(P_RandomRange(-1, 66)*FRACUNIT), MT_BOXSPARKLE)
						sparkle.momz = 2*FRACUNIT
						sparkle.scale = P_RandomRange(1, 3)*FRACUNIT
						sparkle.fuse = TICRATE/2
						sparkle.frame = $ |FF_FULLBRIGHT
					else
						local sparkle = P_SpawnMobjFromMobj(me,(P_RandomRange(-66, 66)*FRACUNIT),(P_RandomRange(-66, 66)*FRACUNIT),(P_RandomRange(-1, 66)*FRACUNIT), MT_SPINDUST)
						sparkle.momz = 2*FRACUNIT
						sparkle.state = S_SPINDUST_FIRE1
						sparkle.scale = P_RandomRange(1, 3)*FRACUNIT
						sparkle.fuse = TICRATE/2
						sparkle.target = me
						sparkle.tracer = me
					end
				end
				if soap.forcefield.rngspin == 0
					soap.forcefield.rngspin = P_RandomRange(-1, 1)
				end
				
				soap.forcefield.scale = FixedMul(me.scale, p.shieldscale)
				
				if (not (gametyperules & GTR_FRIENDLY))
					soap.forcefield.color = p.skincolor
				else
					soap.forcefield.color = SKINCOLOR_SKY
				end
				
				AddRollangleToForceField(soap.forcefield, ANG2+ANG2+ANG1)
				ChangeForceFieldFrame(soap.forcefield, p.soapPityFrames)
			//	soap.forcefield.frame = p.soapPityFrames[(leveltime % 12) + 1]
				soap.forcefield.frame = $|FF_ANIMATE|FF_FULLBRIGHT
				soap.forcefield.spritexscale = me.spritexscale
				soap.forcefield.spriteyscale = me.spriteyscale
				soap.forcefield.spriteyoffset = me.spriteyoffset
				soap.forcefield.eflags = me.eflags
				soap.forcefield.flags = $|MF_NOGRAVITY 
				soap.forcefield.flags2 = $|MF2_OBJECTFLIP
				if me.eflags & MFE_VERTICALFLIP 
					soap.forcefield.eflags = $ |MFE_VERTICALFLIP
				else
					soap.forcefield.eflags = $ & ~MFE_VERTICALFLIP
				end
				if leveltime % 10 == 0
					soap.forcefield.frame = $|FF_TRANS90
					soap.forcefield.colorized = true
					if (gametyperules & GTR_FRIENDLY)
						soap.forcefield.color = SKINCOLOR_ICY
					end
				elseif ((leveltime % 10 == 1) or (leveltime % 10 == 9))
					soap.forcefield.frame = $|FF_TRANS20
					soap.forcefield.colorized = true
				elseif ((leveltime % 10 == 2) or (leveltime % 10 == 8))
					soap.forcefield.frame = $|FF_TRANS30
					soap.forcefield.colorized = false
				elseif ((leveltime % 10 == 3) or (leveltime % 10 == 7))
					soap.forcefield.frame = $|FF_TRANS40
					soap.forcefield.colorized = false
				else
					soap.forcefield.frame = $|FF_TRANS50
					soap.forcefield.colorized = false
					if (gametyperules & GTR_FRIENDLY)
						soap.forcefield.color = SKINCOLOR_TEAL
					end
				end
				if leveltime % 2 == 0
				and ((p.powers[pw_flashing]) or (p.powers[pw_invulnerability] <= 2*TICRATE))
					soap.forcefield.frame = $|FF_TRANS70
					if (gametyperules & GTR_FRIENDLY)
						soap.forcefield.color = SKINCOLOR_SAPPHIRE
					end
				end
				if leveltime % 6 == 0
				and ( ((p.powers[pw_flashing]) and (p.powers[pw_flashing] <= 2*TICRATE)) or((p.powers[pw_invulnerability]) and (p.powers[pw_invulnerability] <= 2*TICRATE)) )
				//so tinks dont play at the start of matches
				and (p.realtime > 0)
				and not soap.cosmenuopen
				and not soap.isSol
					//S_StartSound(soap.forcefield, sfx_tink)
				end

			end
end)

rawset(_G, "SoapResetAirdashTimer", function(soap)
	soap.airdashtimer = 0
end)

rawset(_G, "SoapSaveStuff", function(p, reset, silent)
	//write
	local a1 =0 local a2 =0 local a3 =0 local a4 =0 local a5 =0 local a6 =0 local a7 =0 local a8 =0 local a9 =0 local a10 =0 
	local a11 =0 local a12 =0 local a13 =0 local a14 =0 local a15 =0 local a16 =0 local a17 =0

if not reset
	--Okay, let's generate this autoconfig command. Since it'd be a pain to type out/remember, we'll auto-execute this when SMS is loaded.
	--It'll also let players make commands that load alongside SMS, such as a bind or naming themselves Super Mystic <name> or whatever.
	if p.soaptable.cosspinglow then a1 = 1 else a1 = 0 end
	if p.soaptable.cosquakes then a2 = 1 else a2 = 0 end
	if p.soaptable.cosflashes then a3 = 1 else a3 = 0 end
	if p.soaptable.cosbuttered then a4 = 1 else a4 = 0 end
	if p.soaptable.cosspeedometer == 1
		a5 = 1
	elseif p.soaptable.cosspeedometer == 2
		a5 = 2
	else
		a5 = 0
	end
	if p.soaptable.cosclocksound then a6 = 1 else a6 = 0 end
	if (p.soaptable.costrailstyle == 1) then a7 = 1 else a7 = 2 end
	if p.soaptable.firsttime then a8 = 1 else a8 = 0 end
	if p.soaptable.rolltrol then a9 = 1 else a9 = 0 end
	if p.soaptable.soapUncurl then a10 = 1 else a10 = 0 end
	if p.soaptable.disableMomen then a11 = 1 else a11 = 0 end
	if p.soaptable.cosusedlimitbefore then a12 = 1 else a12 = 0 end
	a13 = p.soaptable.supertauntedbefore
	a14 = p.soaptable.ftx
	a15 = p.soaptable.fty
	a16 = p.soaptable.pizzatowerstuff
//	a17 = p.soaptable.bombyd
end
	if io
		if not reset
			local file = io.openlocal("client/soapthehedge/config.dat", "w+")
			file:write("soap_load "+a1+" "+a2+" "+a3+" "+a4+" "+a5+" "+a6+" "+a7+" "+a8+" "+a9+" "+a10+" "+a11+" "+a12+" "+a13+" "+a14+" "+a15+" "+a16)
			
			local backup = io.openlocal("client/soapthehedge/backupcfg.dat", "w+")
			backup:write("soap_load "+a1+" "+a2+" "+a3+" "+a4+" "+a5+" "+a6+" "+a7+" "+a8+" "+a9+" "+a10+" "+a11+" "+a12+" "+a13+" "+a14+" "+a15+" "+a16)
			
			if not silent
				CONS_Printf(p, "\x82Saved Soap's settings!")
			end
			
			file:close()
			backup:close()
			
		else
			local file = io.openlocal("client/soapthehedge/config.dat", "w+")
			file:write("soap_load 1 1 1 1 2 0 1 1 1 1 0 0 0 160 60 100 20 0")

			local backup = io.openlocal("client/soapthehedge/backupcfg.dat", "w+")
			backup:write("soap_load 1 1 1 1 2 0 1 1 1 1 0 0 0 160 60 100 20 0")
			
			if not silent
				CONS_Printf(p, "\x85Successfully wiped Soap's config.")
			end
			
			file:close()	
			backup:close()
		end
	end
end)

rawset(_G, "SoapLoadStuff", function(p)
	
	if p.soaptable.alreadyloaded
		return
	end
	
	if io --load savefile
		local file = io.openlocal("client/soapthehedge/config.dat")
		local backup = io.openlocal("client/soapthehedge/backupcfg.dat")
		
		
		//load file
		if file 
		
			local code = file:read("*a")
			
			if code ~= nil and not (string.find(code, ";"))
				COM_BufInsertText(p, code)
				p.soaptable.alreadyloaded = 1
			end
		
			file:close()
		
		//load backup
		elseif backup

			local code = backup:read("*a")
			
			if code ~= nil and not (string.find(code, ";"))
				COM_BufInsertText(p, code)
				p.soaptable.alreadyloaded = 1
			end
		
			backup:close()
			
		end
		
	end
end)

//i wouldve gotten away with this if it wasnt for you meddling code divers!
rawset(_G, "SoapSpawnDeadBody", function(p, me, soap)
	if p.deadtimer >= 3*TICRATE and not (soap.body and soap.body.valid)
		soap.body = P_SpawnMobjFromMobj(me, 0, 0, 0, MT_SOAP_DEAD_BODY)
		soap.body.skin = me.skin
		soap.body.scale = me.scale
		soap.body.state = me.state
		soap.body.sprite2 = me.sprite2
		soap.body.angle = p.drawangle
		soap.body.rollangle = me.rollangle
		soap.body.color = me.color
		soap.body.frame = me.frame
		
		soap.body.flags = me.flags
		soap.body.eflags = me.eflags
		soap.body.momx = me.momx
		soap.body.momy = me.momy
		soap.body.momz = me.momz
		soap.body.target = me
		
		soap.body.colorized = me.colorized
	end
end)

rawset(_G, "SoapDeathAnims", function(p, me, soap)
	//death anims!
	if soap.saveddmgt

		if soap.saveddmgt == DMG_SPIKE
			me.rollangle = $ - ANG10
			if p.deadtimer == 1
				P_Thrust(me, me.angle, -10*FRACUNIT)
				S_StartSound(me,sfx_yeeeow)
			end
		elseif soap.saveddmgt == DMG_CRUSHED
			me.flags = $ & ~(MF_NOGRAVITY|MF_NOCLIPHEIGHT|MF_NOCLIP)
			me.momz = $/2
			me.height = 0
			me.state = S_PLAY_SOAP_SQUISH
			SoapSpawnDeadBody(p, me, soap)
			return
		
		elseif soap.saveddmgt == DMG_DROWNED
			if soap.onGround
				me.momz = FRACUNIT*soap.gravflip
			end
			if soap.isWatered
				me.momz = FRACUNIT*3/4
			else
				me.momz = -FRACUNIT
			end

			me.rollangle = $ - ANG1
			if p.deadtimer == 3*TICRATE
				for i = 1, 21
					SoapSpawnBubbles(p, me, soap)
					local bubblerng = P_RandomRange(MT_SMALLBUBBLE, MT_EXTRALARGEBUBBLE)
					local bubble = P_SpawnMobjFromMobj(me,(P_RandomRange(-i, i)*FRACUNIT),(P_RandomRange(-i, i)*FRACUNIT),(P_RandomRange(-i, i)*FRACUNIT), bubblerng)
					bubble.frame = P_RandomRange(0, 4)
					bubble.color = me.color
				end
			elseif p.deadtimer < 3*TICRATE
				if leveltime % 3 == 0
					SoapSpawnBubbles(p, me, soap)
					local bubblerng2 = P_RandomRange(MT_SMALLBUBBLE, MT_MEDIUMBUBBLE)
					local bubble2 = P_SpawnMobjFromMobj(me,(P_RandomRange(-10, 10)*FRACUNIT),(P_RandomRange(-5, 5)*FRACUNIT),(P_RandomRange(-1, me.height/FRACUNIT)*FRACUNIT), bubblerng2)
					bubble2.frame = P_RandomRange(0, 4)
					bubble2.color = me.color
				end
			end
			
			return
		elseif soap.saveddmgt == "DMG_MACH4"
			if p.deadtimer == 1
				S_StartSound(me,sfx_yeeeow)
			end
			
			if not soap.onGround
								
				me.rollangle = $ - ANG20
				
			end

		elseif soap.saveddmgt == DMG_INSTAKILL
			//reset to drowning
			if soap.isWatered
			and me.eflags & MFE_UNDERWATER
			and not (me.eflags & MFE_TOUCHLAVA)
				soap.saveddmgt = DMG_DROWNED
				if me.state ~= S_PLAY_DRWN then 
					me.state = S_PLAY_DRWN 
					S_StartSound(me,sfx_drown)
				end

			end

			if soap.onGround
				me.momz = 1*soap.gravflip
			else
				me.momz = $ - (20*FRACUNIT*soap.gravflip)
			end
		elseif soap.saveddmgt == DMG_FIRE
			if p.deadtimer == 1
				S_StartSound(me,sfx_yeeeow)
				me.color = SKINCOLOR_JET
			//	me.momz = 0
			elseif p.deadtimer < 5
				S_StartSound(me,sfx_fire)
			end
			me.color = SKINCOLOR_JET
			me.colorized = true
			
			if (leveltime & 3) == 0
			and not P_PlayerTouchingSectorSpecial(p, 1, 3)
			and p.deadtimer <= 2*TICRATE
				A_BossScream(me, 0, MT_FIREBALLTRAIL)
			end
			
			if soap.onGround
			and p.deadtimer > 2
				S_StopSoundByID(me,sfx_yeeeow)
			end			
			
			//pull us into the lava
			if soap.onGround
			and P_PlayerTouchingSectorSpecial(p, 1, 3)
			and p.deadtimer > 2
				me.flags = $|MF_NOCLIPHEIGHT
				me.momz = (-FRACUNIT/4)*soap.gravflip
			end
		elseif soap.saveddmgt == DMG_SPACEDROWN
			
			me.rollangle = $ - ANG1
			me.momz = 0
			
			SoapSpawnDeadBody(p, me, soap)
			return
		elseif soap.saveddmgt == DMG_DEATHPIT
			me.flags = $ |MF_NOCLIP|MF_NOCLIPHEIGHT
			return
		elseif soap.saveddmgt == DMG_ELECTRIC
			
			if p.deadtimer <= TICRATE
				if (leveltime % 3) == 0
					me.color = SKINCOLOR_SUPERGOLD1
				else
					me.color = SKINCOLOR_JET
				end
				
				if p.deadtimer == 1
					S_StartSound(me, sfx_buzz2)
				end
	
				local rad = me.radius/FRACUNIT
				local hei = me.height/FRACUNIT
				local x = P_RandomRange(-rad,rad)*FRACUNIT
				local y = P_RandomRange(-rad,rad)*FRACUNIT
				local z = P_RandomRange(0,hei)*FRACUNIT
				local spark = P_SpawnMobjFromMobj(me,x,y,z,MT_SOAP_SUPERTAUNT_FLYINGBOLT)
				spark.target = me
				spark.state = P_RandomRange(S_SOAP_SUPERTAUNT_FLYINGBOLT1,S_SOAP_SUPERTAUNT_FLYINGBOLT5)			
				spark.blendmode = AST_ADD
				spark.color = P_RandomRange(SKINCOLOR_SUPERGOLD1,SKINCOLOR_SUPERGOLD5)
				spark.angle = p.drawangle+(FixedAngle( P_RandomRange(-337,337)*FRACUNIT ))

				me.colorized = true
			elseif p.deadtimer == TICRATE+1
				me.color = p.skincolor
				me.colorized = false
			end
		
		end
		
		//add returns to damagetypes to prevent this
		if soap.onGround
			me.rollangle = 0
			if me.eflags & MFE_JUSTHITFLOOR
			and me.sprite2 ~= SPR2_SHIT
			and p.deadtimer > 1
				me.frame = A
				me.sprite2 = SPR2_SHIT
		//		me.momz = 0
				S_StartSound(me,sfx_bmslam)
				SoapFlashPals(p, PAL_NUKE, 5)
				SoapQuakes(p, 15*FRACUNIT, 5)
			end
		else
			if me.sprite2 == SPR2_SHIT
				me.momz = $+((-6*FRACUNIT)*soap.gravflip)
				me.frame = A
				me.sprite2 = SPR2_DEAD
			end
		end
		SoapSpawnDeadBody(p, me, soap)
	else
	
		if p.deadtimer <= 3
			//reset to drowning
			if soap.isWatered
			and me.eflags & MFE_UNDERWATER
			and not (me.eflags & MFE_TOUCHLAVA)
				soap.saveddmgt = DMG_DROWNED
				if me.state ~= S_PLAY_DRWN then 
					me.state = S_PLAY_DRWN 
					S_StartSound(me,sfx_drown)
				end

			elseif (me.eflags & MFE_TOUCHLAVA)
				soap.saveddmgt = DMG_FIRE
				S_StartSound(me,sfx_yeeeow)
				me.color = SKINCOLOR_JET				
			end
		end

//		if soap.specialdeath ~= 1
			if soap.onGround
				me.rollangle = 0
				if me.eflags & MFE_JUSTHITFLOOR
				and me.sprite2 ~= SPR2_SHIT
				and p.deadtimer > 1
					me.frame = A
					me.sprite2 = SPR2_SHIT
			//		me.momz = 0
					S_StartSound(me,sfx_bmslam)
					SoapFlashPals(p, PAL_NUKE, 5)
					SoapQuakes(p, 15*FRACUNIT, 5)
				end
			else
				if me.sprite2 == SPR2_SHIT
					me.momz = $+((-6*FRACUNIT)*soap.gravflip)
					me.frame = a
					me.sprite2 = SPR2_DEAD
				end
			end
		
		//special death
/*		elseif soap.specialdeath == 1
			if p.deadtimer == 1
				me.momx = soap.prevmomx
				me.momy = soap.prevmomy
				me.momz = soap.prevmomz/3
				P_SetObjectMomZ(me,10*FRACUNIT,true)
			end
			
			if me.eflags & MFE_JUSTHITFLOOR
			and soap.onGround
				me.sprite2 = SPR2_SHIT
				me.momx = $*39/55
				me.momy = $*39/55
				if soap.specialhit < 6
				and soap.accSpeed > 10*FRACUNIT
					S_StartSound(me,sfx_s3k5d)		
					S_StartSound(me,sfx_bmslam)
					P_SetObjectMomZ(me,(10-(soap.specialhit*2))*FRACUNIT,true)
					soap.specialhit = $+1
				end
			end
			
			if soap.onGround
			and not (me.eflags & MFE_JUSTHITFLOOR)
				me.momx = $/2
				me.momy = $/2
				if soap.accSpeed > 3*FRACUNIT
				and not ((soap.body) and (soap.body.valid))
					P_SpawnSkidDust(p,FRACUNIT,sfx_s3kd1s)
				end
				me.rollangle = 0
			end
		end
*/		
		SoapSpawnDeadBody(p, me, soap)
	end
	
	if p.deadtimer == 1
		if (not (S_SoundPlaying(me,skins[me.skin].soundsid[SKSPLDET4])))
			SoapFlashPals(p,PAL_NUKE, 5)
		//source death sfx
		else
			SoapFlashPals(p,PAL_NUKE, TICRATE)
		end

	end

end)

rawset(_G, "SoapSpawnBubbles", function(p, me, soap)
	local bubblerng2 = P_RandomRange(MT_SOAPBUBBLESMALL, MT_SOAPBUBBLEMEDIUM)
	local bubble2 = P_SpawnMobjFromMobj(me,(P_RandomRange(-10, 10)*FRACUNIT),(P_RandomRange(-5, 5)*FRACUNIT),(P_RandomRange(5, (me.height/FRACUNIT)+10)*FRACUNIT), bubblerng2)
	bubble2.eflags = me.eflags
	bubble2.tracer = me
	bubble2.scale = (P_RandomRange(1,2)*FRACUNIT)/3//*skins[me.skin].highresscale
	bubble2.color = me.color
end) 

rawset(_G, "SoapDoOneShots", function(p, me, soap)
	//we've just been hurt! ow!
	if soap.inPain
		soap.justhurtREADY = 1
		soap.justhurtNOW = 0
	elseif soap.justhurtREADY
		soap.justhurtREADY = 0
		soap.justhurtNOW = 1
	else
		soap.justhurtNOW = 0
	end

	//detect when we've just spun
	if not (p.pflags & PF_SPINNING)
		soap.justSpunREADY = 1
		soap.justSpunNOW = 0
	elseif soap.justSpunREADY
		soap.justSpunREADY = 0
		soap.justSpunNOW = 1
	else
		soap.justSpunNOW = 0
	end
			
	if (p.dashmode < 3*TICRATE) and soap.isValid
		soap.dashBoostSfxREADY = 1
		soap.dashBoostSfx = 0
	elseif soap.dashBoostSfxREADY
		soap.dashBoostSfxREADY = 0
		soap.dashBoostSfx = 1
	else
		soap.dashBoostSfx = 0
	end
			
	if p.dashmode < 4*TICRATE
		soap.sdmsfxREADY = 1
		soap.sdmsfx = 0
	elseif soap.sdmsfxREADY
		soap.sdmsfxREADY = 0
		soap.sdmsfx = 1
	else
		soap.sdmsfx = 0
	end
	
	if p.powers[pw_super]
		soap.unsuperREADY = 1
		soap.unsuperNOW = 0
	elseif soap.unsuperREADY
		soap.unsuperREADY = 0
		soap.unsuperNOW = 1
	else
		soap.unsuperNOW = 0
	end
	
end)

//maybe add "..." for the txt arg?
rawset(_G, "SoapCONS_F", function(ttype, p, txt)
/*
	ttype = tostring($)
	local typeL = string.lower(ttype)
	
	if SoapFetchConstant("soap_devmode")
		if (typeL == cons) or (typeL == f)
			CONS_Printf(p, txt)
		elseif (typeL == print)
			print(txt)
		end
	end
*/
	
	if not SoapFetchConstant("soap_devmode")
		return
	end
	print(txt)
end)

//from clairebun
local function L_ZCollide(mo1,mo2)
	if mo1.z > mo2.height+mo2.z then return false end
	if mo2.z > mo1.height+mo1.z then return false end
	return true
end

rawset(_G, "SoapMach4Kill", function(p,me,soap)
//	if not SoapFetchConstant("soap_devbuild")
//		return
//	end

	if not soap.ptaiframing
		return
	end
	
	local px = me.x
	local py = me.y
	local br = 3*(16*me.scale)/2

	searchBlockmap("objects", function(me, found)
		if found and found.valid
		and (L_ZCollide(me,found) == true)
		and found.health
			if (found.flags & MF_ENEMY)
			or (found.flags & MF_MONITOR)
			and not (found.flags & MF_SPRING)
			and ((P_CheckSight(me,found)) and (P_CheckSight(found,me)))
						
				local bam = P_SpawnMobjFromMobj(me,0,0,0,MT_TNTDUST)
				bam.state = S_TNTBARREL_EXPL4
				
				p.dashmode = $+35

				P_KillMobj(found, me, me) //KILL!!!
			end--This kills the things
		end
	end, me, px-br, px+br, py-br, py+br)
	
	
end)

/*
rawset(_G, "S_LookForPlayers", function(me,dist,maxdist,allround,tracer)
	local px = me.x
	local py = me.y
	local br = dist

	searchBlockmap("objects", function(me, found)
		if found and found.valid
		and found.health
		
			local dx = me.x-found.x
			local dy = me.y-found.y
			local dz = me.z-found.z
			
			if (found.player)
			and (found.player.valid)
			and (FixedHypot(FixedHypot(dx,dy),dz)) <= maxdist
			and not (P_PlayerInPain(found.player))
	//		and ((P_CheckSight(me,found)) and (P_CheckSight(found,me)))
				me.target = found
				return true
			end
		end
	end, me, px-br, px+br, py-br, py+br)
	
end)
*/

rawset(_G, "PVPEarthQuake", function(inflict,source,radius,me,dmtype,actualsource)
	//P_Earthquake(inflict, source, radius)
	
	if actualsource == nil then actualsource = "" end
	
	actualsource = string.lower(actualsource)
	
	//hurt people aswell!
	//reference from source code
	//p_user.c line 9008
	for i = 0, 16
		local fa = (i*ANGLE_22h)
		local spark = P_SpawnMobjFromMobj(me,0,0,0,MT_SUPERSPARK)
		spark.momx = FixedMul(sin(fa),radius)
		spark.momy = FixedMul(cos(fa),radius)
		local spark2 = P_SpawnMobjFromMobj(me,0,0,0,MT_SUPERSPARK)
		spark2.color = me.color
		spark2.momx = FixedMul(sin(fa),radius/20)
		spark2.momy = FixedMul(cos(fa),radius/20)
	end
	
		//i could just use source for this but ehhhhhhh
		local px = me.x
		local py = me.y
		local br = radius
		
		local p
		local soap

		if actualsource == "source"
			p = source.player
		else
			p = me.player
		end
		
		soap = p.soaptable

		searchBlockmap("objects", function(me, found)
			if found and found.valid
			and found.health
				
				if found == source then return end
				
				//this will make it easier for me to check flagsss :(
				local flg = found.flags
				local typ = found.type
				
				if (found.player)
					
					if (found.player.valid)
					and (found.health)
					and not (P_PlayerInPain(found.player))
					and (P_CheckSight(me,found))
					and (P_CheckSight(found,me))
						
						if (gametype == GT_PVP)
						or ((CBW_Battle) and (CBW_Battle.BattleGametype()))
						or (found.player.combat == true)
						or ((CV_FindVar("friendlyfire").value and SoapFetchConstant("soap_friendlyfire")))
						
							//are there teams?
							if (gametyperules & GTR_TEAMS)
								if (found.player.ctfteam == p.ctfteam)
								and not ((CV_FindVar("friendlyfire").value and SoapFetchConstant("soap_friendlyfire")))
									return
								end
							else
								if not ((CV_FindVar("friendlyfire").value and SoapFetchConstant("soap_friendlyfire")))
									return
								end
							end
							if dmtype == "dive"
								found.player.soaptable.dmbombdive = true
							elseif dmtype == "bounce"
								found.player.soaptable.dmbounce = 3
							elseif dmtype == "physprop"
								found.player.soaptable.dmphysprop = 3
							end
							
							//SoapAddToCombo(p,soap,false)
							
							P_DamageMobj(found,me,me,1)
						
						end
					
					end
				//so not a player?
				else
					//is this a thing we can kill?
					if not found.health
					or not found.valid
						return
					end
					
					if (flg & MF_ENEMY)
					or (flg & MF_MONITOR)
					or (flg & MF_SHOOTABLE)
					and not (flg & MF_SPECIAL)
					or ((typ == MT_SPIKE) or (typ == MT_WALLSPIKE))
					or (typ == MT_SPIKEBALL)
						if not ((P_CheckSight(me,found)) and (P_CheckSight(found,me)))
							return
						end
						//dont let an eggman box we probably couldnt see hurt us
						if (found.type == MT_EGGMAN_BOX) then return end
			//			if ((P_CheckSight(me,found)) and (P_CheckSight(found,me)))
						if (flg & MF_MONITOR)
							//only kill those we can see!
							//SoapAddToCombo(p,soap,true)
							found.soapalreadykilled = true
							SoapAddToCombo(p,soap,true)
							P_KillMobj(found,me,me)
						end
						
						if not (flg & MF_MONITOR)
						//but firsttttt we gotta check if we can see it
			//			and (P_CheckSight(me,found))
							//yes? then KILL!!
							if not (flg & MF_BOSS)
								//SoapAddToCombo(p,soap,true)
								//if ((typ == MT_SPIKE) or (typ == MT_WALLSPIKE))
								//or (typ == MT_SPIKEBALL)
								//	found.soapalreadykilled = true
								//	SoapAddToCombo(p,soap,true)
								//end
								
								found.soapalreadykilled = true
								SoapAddToCombo(p,soap,true)
								P_KillMobj(found,me,me)
							else
								//SoapAddToCombo(p,soap,false)
								P_DamageMobj(found,me,me,1)
							end
						end
					end
				end
			end
		end, me, px-br, px+br, py-br, py+br)
		
end)

rawset(_G, "SoapCosmeticsMenuThinker",function(p,me,soap)
	p.pflags = $ |PF_FULLSTASIS|PF_FORCESTRAFE
	
	if soap.isElevated
		p.powers[pw_flashing] = 2
	end
			
	//exit
	if (p.cmd.buttons & BT_CUSTOM1)
	or soap.inPain
	or ((not (me.health)) and (not soap.isElevated))
		COM_BufInsertText(p, "soap_cos_menu true")
	end
	
	if soap.cosmenucooldown then soap.cosmenucooldown = $-1 end
			
	//set our moves to menu inputs
	if (p.cmd.forwardmove > 19)
		soap.cosmenuup = $+1
		soap.cosmenudown = 0
	else
		soap.cosmenuup = 0
	end
	if (p.cmd.forwardmove < -19)
		soap.cosmenudown = $+1
		soap.cosmenuup = 0
	else
		soap.cosmenudown = 0
	end
	if (p.cmd.sidemove > 19) and not (soap.cosmenudown or soap.cosmenuup)
		soap.cosmenuright = $+1
		soap.cosmenuleft = 0
	else
		soap.cosmenuright = 0
	end
	if (p.cmd.sidemove < -19) and not (soap.cosmenudown or soap.cosmenuup)
		soap.cosmenuleft = $+1
		soap.cosmenuright = 0
	else
		soap.cosmenuleft = 0
	end
	if (p.cmd.buttons & BT_JUMP)
		soap.cosmenujump = $+1
		soap.cosmenuspin = 0
	else
		soap.cosmenujump = 0
	end
	if (p.cmd.buttons & BT_USE)
		soap.cosmenuspin = $+1
		soap.cosmenujump = 0
	else
		soap.cosmenuspin = 0
	end
	if (p.cmd.buttons & BT_WEAPONNEXT)
		soap.cosmenuflipn = $+1
		soap.cosmenuflipp = 0
	else
		soap.cosmenuflipn = 0
	end
	if (p.cmd.buttons & BT_WEAPONPREV)
		soap.cosmenuflipp = $+1
		soap.cosmenuflipn = 0
	else
		soap.cosmenuflipp = 0
	end

	//aliases!
	local left = soap.cosmenuleft
	local right = soap.cosmenuright
	local up = soap.cosmenuup
	local down = soap.cosmenudown
	local jump = soap.cosmenujump
	local spin = soap.cosmenuspin
	local flipn = soap.cosmenuflipn
	local flipp = soap.cosmenuflipp
			
	if left == 1
		if soap.cosmenucurx ~= 0
			soap.cosmenucurx = 0
			MeSound(sfx_shudmo,p)
		end
	end
	if right == 1
		if soap.cosmenucurx ~= 1
			soap.cosmenucurx = 1
			MeSound(sfx_shudmo,p)
		end
	end
	if soap.cosmenupage ~= 0
		if soap.cosmenucury == 3
			soap.cosmenucurx = 0
		end
	else
		if soap.cosmenucury == 1
			soap.cosmenucurx = 0
		end	
	end
	if up == 1	
		if soap.cosmenucury > 0
			soap.cosmenucury = $-1
			MeSound(sfx_shudmo,p)
		end 
	end
	if down == 1	
		if soap.cosmenupage ~= 0
			if soap.cosmenucury <= 2
				soap.cosmenucury = $+1
				MeSound(sfx_shudmo,p)
			end 
		else
			if soap.cosmenucury <= 0
				soap.cosmenucury = $+1
				MeSound(sfx_shudmo,p)
			end 		
		end
	end

	if soap.cosmenupage == 0		
		//cap y movement
		if soap.cosmenucury > 1
			soap.cosmenucury = 1
		end
		//cap x at first y level
		if soap.cosmenucury == 1
		and soap.cosmenucurx ~= 0
			soap.cosmenucurx = 0
		end
	
		if soap.cosmenucury == 0
			if soap.cosmenucurx == 0
				soap.cosmenuselect = "momentum"
			elseif soap.cosmenucurx == 1
				soap.cosmenuselect = "rolltrol"
			end
		elseif soap.cosmenucury == 1
			if soap.cosmenucurx == 0
				soap.cosmenuselect = "uncurl"
			end
		end
	elseif soap.cosmenupage == 1
		if soap.cosmenucury == 0
			if soap.cosmenucurx == 0
				soap.cosmenuselect = "quakes"
			else
				soap.cosmenuselect = "glow"
			end
		elseif soap.cosmenucury == 1
			if soap.cosmenucurx == 0
				soap.cosmenuselect = "butter"
			else
				soap.cosmenuselect = "flashes"
			end	
		elseif soap.cosmenucury == 2
			if soap.cosmenucurx == 0
				soap.cosmenuselect = "speedometer"
			else
				soap.cosmenuselect = "clocksound"
			end	
		elseif soap.cosmenucury == 3
			if soap.cosmenucurx == 0
				soap.cosmenuselect = "trailstyle"
			end	
		end
	//page 2!!
	elseif soap.cosmenupage == 2
		if soap.cosmenucury == 0
			if soap.cosmenucurx == 0
				soap.cosmenuselect = "cbwb_all_buff"
			elseif soap.cosmenucurx == 1
				soap.cosmenuselect = "cbwb_local_buff"
			end
		elseif soap.cosmenucury == 1
			if soap.cosmenucurx == 0
				soap.cosmenuselect = "cbwb_allowcurl"
			elseif soap.cosmenucurx == 1
				soap.cosmenuselect = "yellowdemon"
			end
		elseif soap.cosmenucury == 2
			if soap.cosmenucurx == 0
				soap.cosmenuselect = "devmode 1"
			elseif soap.cosmenucurx == 1
				soap.cosmenuselect = "pvp_buff"
			end
		elseif soap.cosmenucury == 3
			if soap.cosmenucurx == 0
				soap.cosmenuselect = 'mobjthinkers "ring_pull"'
			end	
		end
	
	//page 3!!
	elseif soap.cosmenupage == 3
		//cap y movement
		if soap.cosmenucury > 3
			soap.cosmenucury = 3
		end
		
		if soap.cosmenucury == 0
			if soap.cosmenucurx == 0
				soap.cosmenuselect = "blockmaps"
			elseif soap.cosmenucurx == 1
				soap.cosmenuselect = "performance"
			end
		elseif soap.cosmenucury == 1
			if soap.cosmenucurx == 0
				soap.cosmenuselect = "friendlyfire"
			elseif soap.cosmenucurx == 1
				soap.cosmenuselect = "bananatoss"
			end
		elseif soap.cosmenucury == 3
			if soap.cosmenucurx == 0
				soap.cosmenuselect = "rawset_banana_clear"
			end

		end

	end
	
	//select
	if jump == 1
		if soap.cosmenupage == 0
			
			COM_BufInsertText(p, "soap_"..soap.cosmenuselect)
			
		elseif soap.cosmenupage == 1
			if soap.cosmenuselect ~= "speedometer"
				if soap.cosmenuselect == "trailstyle"
				and ((soap.costrailstyle ~= 1) and (soap.costrailstyle ~= 2))
					MeSound(sfx_shuddy,p)
					return
				end
				COM_BufInsertText(p, "soap_cos_"..soap.cosmenuselect)
			else
				if soap.cosspeedometer == 0
					COM_BufInsertText(p, "soap_cos_"..soap.cosmenuselect.." 1")
				elseif soap.cosspeedometer == 1
					COM_BufInsertText(p, "soap_cos_"..soap.cosmenuselect.." 2")
				elseif soap.cosspeedometer == 2
					COM_BufInsertText(p, "soap_cos_"..soap.cosmenuselect.." 0")
				else
					MeSound(sfx_shuddy,p)
					return
				end
			end
		//we replace most of the command here, instead of just adding a snippet
		elseif soap.cosmenupage == 2
		or soap.cosmenupage == 3
			
			if soap.cosmenucooldown then
				CONS_Printf(p,"\x85You're on cooldown! Wait "..soap.cosmenucooldown.." tics before selecting something!")
				MeSound(sfx_shuddy,p)
				return	
			end	
				
			COM_BufInsertText(p, "soap_"..soap.cosmenuselect)
			soap.cosmenucooldown = TICRATE/2
			//lets check to see if we can run some of these
			if soap.cosmenuselect == "cbwb_all_buff"
			or soap.cosmenuselect == "cbwb_local_buff"
			or soap.cosmenuselect == "cbwb_allowcurl"
				if not CBW_Battle
				or not CBW_Battle.BattleGametype()
				//	CONS_Printf(p, "\x85"+"Obviously you need BattleMod to nerf Soap before you can even buff him!")
					MeSound(sfx_shuddy,p)
					return	
				end	
			elseif soap.cosmenuselect == "yellowdemon"
				if gametype == GT_YELLOWDEMON
					MeSound(sfx_shuddy,p)
					return
				end
			elseif soap.cosmenuselect == "pvp_buff"
				if gametype ~= GT_PVP
					MeSound(sfx_shuddy,p)
					return	
				end	
			elseif soap.cosmenuselect == 'mobjthinkers "ring_pull"'
				if gametype == GT_YELLOWDEMON
					MeSound(sfx_shuddy,p)
					return
				end
			end
		end
		MeSound(sfx_shudsl,p)
	end
	
	//turn the page to see admin stuff!
	if flipn == 1
		if soap.cosmenupage == 1
			if soap.isElevated
				soap.cosmenupage = 2
			else
				soap.cosmenupage = 1
				MeSound(sfx_shuddy,p)
				return
			end
		elseif soap.cosmenupage == 2
			soap.cosmenupage = 3
			
			//theres a small window of time where you can see the cursor
			//beyond its limits, so we'll cap the y here too
			if soap.cosmenucury > 1
				soap.cosmenucury = 1
			end

		elseif soap.cosmenupage == 3
			soap.cosmenupage = 3
			MeSound(sfx_shuddy,p)
			return
		elseif soap.cosmenupage == 0
			soap.cosmenupage = 1
		end
		MeSound(sfx_shudmo,p)
	//flip back
	elseif flipp == 1
		if soap.cosmenupage == 1
			soap.cosmenupage = 0
			//theres a small window of time where you can see the cursor
			//beyond its limits, so we'll cap the y here too
			if soap.cosmenucury > 1
				soap.cosmenucury = 1
			end
			//cap x at first y level
			if soap.cosmenucury == 1
			and soap.cosmenucurx ~= 0
				soap.cosmenucurx = 0
			end
		elseif soap.cosmenupage == 2
			soap.cosmenupage = 1
		elseif soap.cosmenupage == 3
			soap.cosmenupage = 2
		elseif soap.cosmenupage == 0
			soap.cosmenupage = 0
			MeSound(sfx_shuddy,p)
			return
		end
		MeSound(sfx_shudmo,p)	
	end
	
//	print("control",left,right,up,down,jump,flipn+" "+flipp,"cur",soap.cosmenucurx,soap.cosmenucury,"select",soap.cosmenuselect,"page",soap.cosmenupage)

end)

rawset(_G, "SoapSpawnWindRing", function(p,me,soap)
	//trig NOO!OOOO
	local x = cos(me.angle)
	local y = sin(me.angle)
	
	//thanks rebound dash!	
	local circle = P_SpawnMobjFromMobj(me, 128*x, 128*y, me.scale * 24, MT_SOAPYWINDRING)
	circle.angle = p.drawangle + ANGLE_90
	circle.fuse = 14
	circle.scale = FRACUNIT / 3
	circle.destscale = 10*FRACUNIT
	circle.scalespeed = FRACUNIT/10
	circle.colorized = true
	circle.color = SKINCOLOR_WHITE
	circle.momx = me.momx / 2
	circle.momy = me.momy / 2			
end)

//delf!!
rawset(_G, "SoapWind", function(mobj)
	if not mobj.health then return end
	if SoapFetchConstant("soap_performance") then return end
    local r = mobj.radius / FRACUNIT
    local explosion = P_SpawnMobj(
        (mobj.x+(50*cos(mobj.angle))) + (P_RandomRange(r, -r) * FRACUNIT),
        (mobj.y+(50*sin(mobj.angle))) + (P_RandomRange(r, -r) * FRACUNIT),
        mobj.z + (P_RandomKey(mobj.height / FRACUNIT) * FRACUNIT) - mobj.height/2,
        MT_THOK)
    explosion.sprite = SPR_RAIN
    explosion.renderflags = $|RF_PAPERSPRITE
    explosion.angle = R_PointToAngle2(0, 0, mobj.momx, mobj.momy)
	//remove the "-" beforfe the "mobj.momz" or else the wind will point down
	//when you go up
    explosion.rollangle = R_PointToAngle2(0, 0, R_PointToDist2(0, 0, mobj.momx, mobj.momy), mobj.momz) + ANGLE_90
    explosion.source = mobj
    explosion.blendmode = AST_ADD
	local x = cos(mobj.angle)
	local y = sin(mobj.angle)
end)

rawset(_G, "SoapDoBounce", function(p,me,soap)
	me.state = S_PLAY_ROLL
	if me.momz*soap.gravflip > 0
		me.momz = $+( (22*me.scale)-((soap.bouncecount)*(1+(1/2))) )*soap.gravflip
	else
		me.momz = ( (22*me.scale)-((soap.bouncecount)*(1+(1/2))) )*soap.gravflip
	end
	soap.bounceagain = 3
	soap.fullstasistic = 3
	p.pflags = $ |PF_JUMPED & ~PF_THOKKED
	soap.momzfreezeadd = 4
	
	S_StartSoundAtVolume(me,sfx_kc52,(180-( (soap.bouncecount/me.scale) *8))  )
	if ((me.eflags & MFE_TOUCHWATER) and not (me.eflags & MFE_TOUCHLAVA))
		S_StartSound(me,sfx_wslap)
		soap.glowyeffects = 5
		me.momz = $*25/20
	end
	
	if soap.isSuper
		//btw you need the last arg as a mobj for
		//the pvp blockmap PVPEarthQuake uses for pvp
		PVPEarthQuake(me, me, 256*FRACUNIT,me,"bounce")
		S_StartSound(me, sfx_pstop)
	end

	SoapBustableFOFBreak(p,me)

end)

//source code!
rawset(_G, "FakeAutoBrake", function(player, factor)
	local mo = player.mo
	local speed = FixedHypot(mo.momx - player.cmomx, mo.momy - player.cmomy)
	local acceleration = (player.accelstart + (FixedDiv(speed, mo.scale) >> FRACBITS) * player.acceleration) * (player.thrustfactor or skins[mo.skin].thrustfactor) * 20
	local moveangle = R_PointToAngle2(0, 0, mo.momx - player.cmomx, mo.momy - player.cmomy)
	
	if not factor
		factor = P_IsObjectOnGround(mo) and FRACUNIT or (FRACUNIT >> 1)
	end
	
	acceleration = FixedMul($, factor)
	
	if mo.movefactor ~= FRACUNIT
		acceleration = FixedMul($ << FRACBITS, mo.movefactor) >> FRACBITS
	end
	
	P_Thrust(mo, moveangle, -min(acceleration, speed))
end)

//lazy, but nicer than writing all this
rawset(_G, "HaltMobjMomentum", function(mobj, stopmomz, input, player)
	if not mobj
	or not mobj.valid
		return
	end
	
	mobj.momx, mobj.momy = 0,0
	if stopmomz == true
		mobj.momz = 0
	end
	
	if input == true
		player.cmd.forwardmove, player.cmd.sidemove = 0,0
	end
	
end)

local function setdmtaunt(soap,flictor)
	if flictor.state == S_PLAY_SOAP_ASSBLAST
		soap.dmassblast = 3
	else
		soap.dmsupertaunt = 3
	end
end
rawset(_G, "SoapSuperTauntNuke", function (p,me,soap)	

		local px = me.x
		local py = me.y
		//is this too big?
		local br = 3200*me.scale
		if p.chaos then br = 7000*FRACUNIT end
		
		/*
		if CBW_Battle
		and CBW_Battle.BattleGametype()
			if p.rings < 10
				return
			end
			
			p.rings = $-10
			MeSound(sfx_sodebt,p)
		elseif p.chaos
			if p.rings <5
				return
			end
			p.rings = $-5
			MeSound(sfx_sodebt,p)
		elseif G_RingSlingerGametype()
			if p.rings < 10
				return
			end
			if p.powers[pw_automaticring] < 10
			or p.powers[pw_bouncering] < 15
			or p.powers[pw_scatterring] < 20
			or not (p.ringweapons & RW_AUTO)
			or not (p.ringweapons & RW_BOUNCE)
			or not (p.ringweapons & RW_SCATTER)
				return
			end
			p.rings = $-10
			p.powers[pw_automaticring] = $-10
			p.powers[pw_bouncering] = $-15
			p.powers[pw_scatterring] = $-20
			MeSound(sfx_sodebt,p)
		end
		*/

		//p.rings = $-5
		//MeSound(sfx_sodebt,p)

		//thanks Flame for helping me out on this one!
		for i = 1, 18 do
			local fa = (i*ANG20)
			local x = FixedMul(cos(fa), 22*(me.scale/FRACUNIT))*FRACUNIT
			local y = FixedMul(sin(fa), 22*(me.scale/FRACUNIT))*FRACUNIT
			local height = me.height
			local spark = P_SpawnMobjFromMobj(me,x,y,(3*height/2)*soap.gravflip,MT_SOAP_SUPERTAUNT_FLYINGBOLT)
			spark.target = me
			spark.state = P_RandomRange(S_SOAP_SUPERTAUNT_FLYINGBOLT1,S_SOAP_SUPERTAUNT_FLYINGBOLT5)
			spark.color = soap.spintrailcolor
			spark.momx, spark.momy = x,y
			spark.blendmode = AST_ADD
			spark.angle = fa
		end
	
		searchBlockmap("objects", function(me, found)
			if found and found.valid

				//player hurt
				if ((found.player) and (found.player.valid))
					//some random bloke we found
					if not (gametyperules & GTR_TEAMS)
						//can we hurt them?
						if (CV_FindVar("friendlyfire").value and SoapFetchConstant("soap_friendlyfire"))
							setdmtaunt(found.player.soaptable,me)
							P_DamageMobj(found,me,me)
						end
					//either a teammate or foe
					else
						//can we hurt the teammate?
						if found.player.ctfteam == p.ctfteam
							if (CV_FindVar("friendlyfire").value and SoapFetchConstant("soap_friendlyfire"))
								setdmtaunt(found.player.soaptable,me)
								P_DamageMobj(found,me,me)
							end
						else
							setdmtaunt(found.player.soaptable,me)
							P_DamageMobj(found,me,me)
						end
					end
				end
				
				if ((found.flags & MF_ENEMY) or (found.flags & MF_BOSS))
				and found.health

					if not (found.flags & MF_BOSS)
						local ragdoll = P_SpawnMobjFromMobj(found,0,0,0,MT_SOAP_RAGDOLL)
						//lets make the ragdoll look like the guy we just killed
						found.tics = -1
						ragdoll.sprite = found.sprite
					//	ragdoll.sprite2 = target.sprite2
						ragdoll.color = found.color
						ragdoll.angle = found.angle
						ragdoll.frame = found.frame
						ragdoll.soapbananapeeled = 1
						ragdoll.rngspin = P_RandomRange(0,1)
						ragdoll.soapdontkill = 4
						
						P_SetObjectMomZ(ragdoll,17*FRACUNIT)
						
						P_Thrust(found, 
						R_PointToAngle2(me.x, me.y, found.x, found.y), 
						13*found.scale+(5*me.scale)
						)
					end
					
					P_KillMobj(found,me,me)
					
				end
				
			end
		end, me, px-br, px+br, py-br, py+br)		

end)

//from clairebun
//https://wiki.srb2.org/wiki/User:Clairebun/Sandbox/Common_Lua_Functions#L_Choose
local function choosething(...)
	local args = {...}
	local choice = P_RandomRange(1,#args)
	return args[choice]
end

//i referenced scr_afterimage's create_afterimage function from pizza tower
rawset(_G, "SoapCreateAfterimage", function(p,me, color1, color2)
	local ghost = P_SpawnMobjFromMobj(me,0,0,0,MT_SOAP_AFTERIMAGE_OBJECT)
	ghost.target = me
	//ghost.fuse = SoapFetchConstant("afterimages_fuse")
	
	ghost.skin = me.skin
	ghost.scale = me.scale
	
	ghost.sprite = me.sprite
	
	ghost.state = me.state
	ghost.sprite2 = me.sprite2
	ghost.frame = me.frame
	
	ghost.angle = p.drawangle
	
	
	ghost.color = choosething(color1,color2)
	ghost.spritexscale,ghost.spriteyscale = me.spritexscale, me.spriteyscale
	
	table.insert(LB_Soap.afterimageslist,ghost)
	return ghost
end)

rawset(_G, "SoapButteredSlopes", function(mo)
	local thrust
	
	if not mo.standingslope
		return
	end
	
	local slope = mo.standingslope
	
	if slope.flags & SL_NOPHYSICS
		return
	end
	
	if mo.flags & (MF_NOGRAVITY|MF_NOCLIPHEIGHT)
		return
	end
	
	if mo.player
		if abs(slope.zdelta) < FRACUNIT/4
		and not ((mo.player.soaptable.accSpeed >= 20*FRACUNIT) or (mo.player.pflags & PF_SPINNING))
			return
		end
		
		if abs(slope.zdelta) < FRACUNIT/2
		and not (mo.player.rmomx or mo.player.rmomy)
			return
		end
	end
	
	thrust = sin(slope.zangle)*3 / 2*(mo.eflags & MFE_VERTICALFLIP and 1 or -1)

	if (mo.player) and ((mo.player.soaptable.accSpeed >= 20*FRACUNIT) or (mo.player.pflags & PF_SPINNING))
		local mult = 0
		if (mo.momx or mo.momy)
			local angle = R_PointToAngle2(0,0,mo.momx,mo.momy) - slope.xydirection
			
			if P_MobjFlip(mo)*slope.zdelta < 0
				angle = $^ANGLE_180
			end
			
			mult = cos(angle)
		end
		
		thrust = FixedMul(thrust, FRACUNIT*2/3+mult/8)
	end
	
	if (mo.momx or mo.momy)
		thrust = FixedMul(thrust, FRACUNIT+FixedHypot(mo.momx,mo.momy)/16)
	end
	
	thrust = FixedMul(thrust, abs(P_GetMobjGravity(mo)))
	
	thrust = FixedMul(thrust, FixedDiv(mo.friction, 29*FRACUNIT/3))
	
	P_Thrust(mo,slope.xydirection,thrust)
	//TODO make this add dashmode!!
end)

//lazy function but its better than typing all of this
//ive said that the last 5 times
rawset(_G, "SoapAddToCombo", function(p, soap, wasenemy)
	if not soap.pizzatowerstuff
		return
	end
	
	if wasenemy
		soap.combocount = $+1
		
		//dancy menu open sfx
		if soap.combocount == 1
			MeSound(sfx_shudop,p)
		end
		
		if soap.combocount % 10 == 0
			S_StopSoundByID(nil,sfx_comup0)
			S_StopSoundByID(nil,sfx_comup1)
			S_StopSoundByID(nil,sfx_comup2)
			MeSound(P_RandomRange(sfx_comup0,sfx_comup2),p)
			soap.comborank = $+1
			soap.comborankuptic = 2*TICRATE
		end
		
		soap.combotime = SoapFetchConstant("combo_maxtime")
	else	
		if soap.combotime
			soap.combotime = $+(TICRATE/2)
		end
	end
end)

//its just a p rank bro!
rawset(_G, "SoapIsPRank", function(p,soap)
	if not soap.pizzatowerstuff
		return false
	end
	
	local haspost = true
	
	if SoapFetchConstant("soap_numberofstarposts") > 0
		if p.starpostnum < 1
			haspost = false
		end
	end
	
	if not SoapFetchConstant("soap_inbossmap")
		if (not soap.combodropped) and (SoapFetchConstant("soap_collectedtokens") == SoapFetchConstant("soap_numberoftokens"))
		and (haspost)
			return true
		end
		return false
	else
		if soap.timeshurt == 0
		and soap.hitboss
			return true
		end
		return false
		
	end
end)

print("\x82Successfully initialized\x86 functions.lua")

//bllahbufijko
//im tired and i dont wanna whip out my drawing tablet and draw sprites
//grr!!!!