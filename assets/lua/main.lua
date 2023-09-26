/*
	Hey, luigi budd here. Expect a massive rewrite of ALL of Soap's lua
	scripts, since I've learned a lot of lua since I've first created this
	very exact script, so Soap becomes better. (i hope)
*/

--an absolute MESS of a script, but ehh... i'll clean it up later (i never did)

--condense these lua scripts into one file

--hey, the code works!
--thanks for Mizzhap on the message boards for helping me write the taunt code

--original runspeed was 58 keep this in mind for later

--thanks for Tempest97 (Krimps) on the message boards for making the spin control script reusable! ( https://mb.srb2.org/threads/free-movement-while-rolling-spin-control.28921/ )

//i should rewrite this before i try to revise anything in this heap of
//spaghetti

//set our constants
addHook("PlayerThink", function(p)	
	if not p.soaptable //get our table!
		SoapInitTable(p)
		local soap = p.soaptable
	return
	end
		
	if p.dashmode == 3*TICRATE then
		p.isDash = true
	else
		p.isDash = false
	end
	
	if P_IsObjectOnGround(p.mo) then
		p.onGround = true
	else
		p.onGround = false
	end
	
	if p.mo.skin == "soapthehedge" then
		p.isSoap = true
	else
		p.isSoap = false
	end
	
	if p.mo.valid then
		p.isValid = true
	else 
		p.isValid = false
	end
	
	if (p.mo.state == S_PLAY_STND) or (p.mo.state == S_PLAY_WAIT) then
		p.isIdle = true
	else
		p.isIdle = false
	end
	
	if p.isxmomentum
		p.isXmo = true
	else
		p.isXmo = false
	end
	
	if p.powers[pw_super]
		p.isSuper = true
	else
		p.isSuper = false
	end
	
	p.hassupermusic = false
	if p.isValid and p.isSoap then
		p.playerSpeed = p.speed / FRACUNIT
	end
	
	//get some super mystic stuff ready
	if not p.mysticsuper == "nil"
		if p.mysticsuper > 0 then
			p.isSuperM = 1
		else
			p.isSuperM = 0
		end
	end
	
	if (p == server) or (p == admin) then
		p.isElevated = 1
	else
		p.isElevated = 0
	end
	
	if p.isxmomentum then
		p.spcanflip = false
	end
	p.mrcecustomskin = 2
end)

//move this to the top so we can always have player.playerSpeed
//its been a week since ive written this and i dont even know what im doing
//needa fix this
/*
addHook("PlayerThink", function(p) //i dont think i can put hooks inside of other hooks
	if isValid then
		player.playerSpeed = p.speed / FRACUNIT
	end

	if isSoap and not isXmo and not p.powers[pw_super] then
		normalSpeedInt = p.normalspeed / FRACUNIT
		
		//lazy fix but ehh
		if p.dashmode < 0 then
			p.dashmode = 0
		end
		
		
		if player.playerSpeed < origRunSpeed then
			if  normalSpeedInt <= 72 then
				if lastDash > p.dashmode then
					p.dashmode = p.dashmode - 1
				else
					p.dashmode = 0
				end
			end
		end
				
		if p.mo.state == "S_PLAY_PAIN" then
			p.dashmode = 0
		end
		
		//same issue as above, so lazy fix
		//try keeping dashmode in mystic realm without this. I dare you. 
		if normalSpeedInt < 10 then
			p.normalspeed = 64 * FRACUNIT
		end
		
	end
	
	if isSoap and isXmo and not p.powers[pw_super] then
		if normalSpeedInt < 10 then
			p.normalspeed = 64 * FRACUNIT
		end
	end
end)
*/
/*
addHook("PlayerThink", function(p) //i dont think i can put hooks inside of other hooks
	if isValid and isSoap then
		player.playerSpeed = p.speed / FRACUNIT
	end

	if isSoap and not isSuper then
		lastDash = p.dashmode
		normalSpeedInt = p.normalspeed/FRACUNIT
		
		//lazy fix but ehh
		if p.dashmode < 0 then
			p.dashmode = 0
		end
				
/*		if player.playerSpeed < origRunSpeed then
			if normalSpeedInt <= 72 then
				if lastDash > p.dashmode then
					p.dashmode = p.dashmode - 1
				end
			end
		end
*/				
/*		if p.mo.state == "S_PLAY_PAIN" then
			p.dashmode = 0
		end
	end
end)
*/
//source spaghetti code
//lets go ahead and make soap do the schadenfreude
//i should rewrite the taunts soon

addHook("ThinkFrame", function() --paste this again so we can FLEX!!
    for player in players.iterate do
		if player.mo.skin ~= "soapthehedge"
			return
		end
		
		if player.mo.valid then
			if P_IsObjectOnGround(player.mo) and (player.mo.valid) and (player.cmd.buttons & BT_CUSTOM1) and player.isIdle then
				if player.laughing == 0
//					whoStasis = #player
					player.mo.state = S_PLAY_SOAP_LAUGH
					player.laughing = 1
					S_StartSound(player.mo, sfx_hahaha)
				else
					player.laughing = 0
					player.mo.state = S_PLAY_STND
				end
			end

			if player.laughing then
				player.pflags = $1|PF_FULLSTASIS
				if player.mo.state == S_PLAY_STND then --so you dont go full stasis when restarting level
					player.laughing = 0
				end
			end
			
			if P_PlayerInPain(player) and player.laughing then
				player.laughing = 0
				player.mo.state = S_PLAY_PAIN
			end
		end
	end
end)


addHook("ThinkFrame", function() --paste this again so we can FLEX!!
    for player in players.iterate do
		if (player.mo.skin ~= "soapthehedge") then
			continue
		end

        if  P_IsObjectOnGround(player.mo) and (player.mo.eflags & MFE_ONGROUND) and (player.mo.valid) and (player.cmd.buttons & BT_CUSTOM2) and player.isIdle		
            if player.playerFlexing == false
//				whoFlex = #player
			    player.mo.state = S_PLAY_SOAP_FLEX
                player.playerFlexing = true
			    S_StartSound(player.mo, sfx_flex)
            else
                player.playerFlexing = false
                player.mo.state = S_PLAY_STND
            end
        end

        if player.playerFlexing then
            player.pflags = $1|PF_FULLSTASIS
            if player.mo.state == S_PLAY_STND then --so you dont go full stasis when restarting level
                player.playerFlexing = false
            end
        end
        
        if P_PlayerInPain(player) and player.playerFlexing then
            player.playerFlexing = false
            player.mo.state = S_PLAY_PAIN
        end
	end
end)

addHook("PlayerThink", function (p)
	if p.isSoap then
		if not p.hugged == "nil" then
			if p.hugged then
				p.mo.sprite2 = SPR2_HUG_
			end
		end
	end
end)


local function rolltrolll(player, arg)
	if not(player and player.valid and player.mo)
		CONS_Printf(player, "Make sure you're in a level before you use this!")
		return
	end

    if arg then
		if arg == "true" or arg == "on" or arg == "1"
			player.rolltrol = 1
			CONS_Printf(player, "Soap now has more control when rolling!")
		else
			player.rolltrol = 0
			CONS_Printf(player, "Soap now has less control when rolling!")
		end
	else
		if player.rolltrol
			CONS_Printf(player, "Toggles rolltrolling for Soap. Currently on right now.")
		else
			CONS_Printf(player, "Toggles rolltrolling for Soap. Currently off right now.")
		end
	end
end

COM_AddCommand("soap_rolltrol", function(player, arg)
	rolltrolll(player, arg)
end)

addHook("PlayerThink",function(p)
	if p.isSoap then
		if p.pflags & PF_SPINNING
		and not (p.pflags & PF_STARTDASH)
		and p.onGround
		and p.rolltrol then
			if p.cmd.forwardmove ~= 0
			or p.cmd.sidemove ~= 0
			or p.camangle == nil
			or p.mo.eflags & MFE_SPRUNG then
				p.camangle = p.cmd.angleturn<<16 + R_PointToAngle2(0, 0, p.cmd.forwardmove*FRACUNIT, -p.cmd.sidemove<<16)
			end
			p.movespd = R_PointToDist2(p.mo.x, p.mo.y, p.mo.x + p.mo.momx, p.mo.y + p.mo.momy)
			P_InstaThrust(p.mo,R_PointToAngle2(p.mo.x - p.mo.momx,p.mo.y - p.mo.momy,p.mo.x + P_ReturnThrustX(p.mo,p.camangle,p.movespd),p.mo.y + P_ReturnThrustY(p.mo,p.camangle,p.movespd)),p.movespd)
		else
			p.camangle = nil
		end
	end 
end)

addHook("PlayerThink", function(p)
	if p.isIdle or p.mo.state == S_PLAY_WAIT or p.mo.state == S_PLAY_WALK or p.mo.state == S_PLAY_RUN or p.mo.state == S_PLAY_DASH or p.mo.state == S_PLAY_SKID
		if p.isSoap
			if not P_IsObjectOnGround(p.mo)
			and p.powers[pw_carry] != CR_ROLLOUT
			and p.powers[pw_carry] != CR_MINECART //this gives me an idea for a minecart anim
			and p.powers[pw_carry] != CR_ZOOMTUBE
			and p.powers[pw_carry] != CR_ROPEHANG
			and p.powers[pw_carry] != CR_PLAYER
			and p.powers[pw_carry] != CR_NIGHTSMODE
				if p.mo.momz >= 0
//					p.mo.state = S_PLAY_SOAP_FLAILUP
//					p.mo.state = S_PLAY_ROLL
					p.mo.state = S_PLAY_FLY
				else
//					p.mo.state = S_PLAY_ROLL
					p.mo.state = S_PLAY_FLY
				end
			end
		end
	end
end)

//i stole this from the discord!!!
//Zarosguth on the srb2 discord
addHook("PlayerThink", function(p)
    if not (p.mo and p.mo.valid and p.mo.skin == "soapthehedge") return end
    if p.powers[pw_underwater] > 20*TICRATE
       p.powers[pw_underwater] = 20*TICRATE 
    end
end)


//stole this from Krabs!! i feel like ive stolen this before...
//slightly modified to fit with soap a bit, and to lower the uncurl delay
// https://mb.srb2.org/threads/uncurl-v4-sfx-update.27876/
local UNCURL_LOCKTIME = 1
COM_AddCommand("soap_uncurl", function(player, value)
	if not(player and player.valid and player.mo)
		CONS_Printf(player,"Make sure you're in a level before you use this!")
		return
	end
	if player.isxmomentum
		CONS_Printf(player,"You can't use this while XMomentum is loaded.")
	end
	if value == "0" or value == "no" or value == "off"
		player.soap_uncurl = 0
		CONS_Printf(player,"Soap can no longer uncurl from spinning.")
	elseif value == "1" or value == "yes" or value == "on"
		player.soap_uncurl = 1
		CONS_Printf(player,"Soap can now uncurl from spinning.")
	else
		if not player.isxmomentum
			if player.soap_uncurl == 1
				CONS_Printf(player,"Soap is able to uncurl.")
			else
				CONS_Printf(player,"Soap is unable to uncurl.")
			end
		end
	end
end,0)

addHook("ThinkFrame", function(player)
	for player in players.iterate()
		//Init
		if player.isxmomentum
			return
		end
		
		if player.init == nil
			player.init = true
			player.prevbuttons = player.cmd.buttons
			if player.soap_uncurl == nil player.soap_uncurl = 1 end
			return
		end
		
		if player.mo and player.playerstate == PST_LIVE and not player.exiting and not player.powers[pw_nocontrol] and not P_PlayerInPain(player) and player.mo.skin == "soapthehedge"
			local pbtn = player.prevbuttons
			local btn = player.cmd.buttons
			local mo = player.mo
			
			//print(mo.uncurl_lock)
			//print(mo.will_uncurl)
			//Uncurl
			if mo.state == S_PLAY_ROLL and P_IsObjectOnGround(mo)
				local uncurlinput = false
				local recurlinput = false
				if player.soap_uncurl == 1
					uncurlinput = (btn & BT_USE) and not (pbtn & BT_USE)
				else
					uncurlinput = (pbtn & BT_USE) and not (btn & BT_USE)
					recurlinput = (btn & BT_USE) and not (pbtn & BT_USE)
				end
				
				if mo.uncurl_lock == UNCURL_LOCKTIME and uncurlinput
					uncurlinput = false
				end
				
				if uncurlinput
					mo.will_uncurl = true
				end
				if recurlinput
					mo.will_uncurl = false
				end
				
				if mo.uncurl_lock
					mo.uncurl_lock = max(0, $ - 1)
					
				elseif mo.will_uncurl
					mo.uncurl_lock = UNCURL_LOCKTIME
					mo.uncurlready = false
					if FixedHypot(mo.momx, mo.momy) >= player.runspeed
						mo.state = S_PLAY_RUN
					else
						mo.state = S_PLAY_WALK
					end
					if player.pflags & PF_SPINNING
						player.pflags = $1 & ~PF_SPINNING
					end
					S_StartSound(mo,sfx_uncurl)
					S_StopSoundByID(mo,sfx_spin)
				end
			else
				mo.uncurl_lock = UNCURL_LOCKTIME
				mo.will_uncurl = false
			end
			player.prevbuttons = btn
		end
	end
end)
//stolen code ends here

local function SetStateTo(player, arg)
	if not(player and player.valid and player.mo)
		CONS_Printf(player, "Make sure you're in a level before you use this!")
		return
	end

    if arg then
		player.mo.state = arg
		CONS_Printf(player, "State set.")
	else
		CONS_Printf(player, "Sets you into a state. Check out the List of States on the wiki so you don't break anything.")
	end
end

COM_AddCommand("setstate", function(player, arg)
	SetStateTo(player, arg)
end)

local function SoapHelpCommand(player, arg)
	print("Soap the Hedge indev3.0.p3 by luigi budd" + "\n")
end

COM_AddCommand("soap_help", function(player, arg)
	SoapHelpCommand(player, arg)
end)

local function SoapyMomentum(player, arg)
    if arg then
		if arg == "on" or arg == "1" or arg == "true"
			player.disableMomen = 0
			CONS_Printf(player, "Soap's momentum is ON!")
		else
			player.disableMomen = 1
			CONS_Printf(player, "Soap's momentum is OFF!")
		end
	else
		if not player.isxmomentum
			if not player.disableMomen then
				CONS_Printf(player, "Toggles momentum for Soap. Currently on right now.")
			else
				CONS_Printf(player, "Toggles momentum for Soap. Currently off right now.")
			end
		else
			CONS_Printf(player, "You can't use this while Xmomentum is loaded.")
		end
	end
end

COM_AddCommand("soap_momentum", function(player, arg)
	SoapyMomentum(player, arg)
end)

