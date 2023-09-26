//this should have functions for code that is just too darn big!
rawset(_G, "SoapConstants", function(p, me, soap)
    if p.dashmode >= 3*TICRATE
        soap.isDash = true
    else
        soap.isDash = false
    end

    if P_IsObjectOnGround(me)
        soap.onGround = true
    else
        soap.onGround = false
    end

    if me.skin == "soapthehedge"
        soap.isSoap = true
    else
        soap.isSoap = false
    end

    if (me.valid) or (p.valid)
        soap.isValid = true
    else
        soap.isValid = false
    end

    if (me.state == S_PLAY_STND) or (me.state == S_PLAY_WAIT)
        soap.isIdle = true
    else
        soap.isIdle = false
    end

    if p.isxmomentum
        soap.isXmo = true
    else
        soap.isXmo = false
    end

    if p.powers[pw_super]
        soap.isSuper = true
    else
        soap.isSuper = false
    end
   
    if (p == server) or (p == admin)
        soap.isElevated = true
    else
        soap.isElevated = false
    end

    if soap.isXmo
        p.spcanflip = false
    end
	
    if P_PlayerInPain(p)
        soap.inPain = true
    else
        soap.inPain = false
    end
    
	if not p.mysticsuper
		return
	end 

    if p.mysticsuper > 0
       soap.isSuperM = true
    else
       soap.isSuperM = false
    end

end)

rawset(_G, "SoapButtonCheck", function(p, me, soap)
    //spin
    if not (p.cmd.buttons & BT_USE)
        soap.SspinREADY = true
        soap.SspinDOWN = false
    elseif soap.SspinREADY
        soap.SspinREADY = false
        soap.SspinDOWN = true
    else
		soap.SspinDOWN = false
	end

	//c1
	if not(p.cmd.buttons & BT_CUSTOM1)
		soap.Scustom1READY = true
		soap.Scustom1DOWN = false
	elseif soap.Scustom1READY
		soap.Scustom1READY = false
		soap.Scustom1DOWN = true
	else
		soap.Scustom1DOWN = false
	end

    //c2
    if not (p.cmd.buttons & BT_CUSTOM2)
        soap.Scustom2READY = true
        soap.Scustom2DOWN = false
    elseif soap.Scustom2READY
        soap.Scustom2READY = false
        soap.Scustom2DOWN = true
    end 

    //c3
    if not (p.cmd.buttons & BT_CUSTOM3)
        soap.Scustom3READY = true
        soap.Scustom3DOWN = false
    elseif soap.Scustom3READY
        soap.Scustom3READY = false
        soap.Scustom3DOWN = true
    end 

    //tossflag
    if not (p.cmd.buttons & BT_TOSSFLAG)
        soap.StossflagREADY = true
        soap.StossflagDOWN = false
    elseif soap.StossflagREADY
        soap.StossflagREADY = false
        soap.StossflagDOWN = true
    end 

end)

rawset(_G, "SoapSquashAndStretch", function(p, me)
		if p.jt == nil then
			p.jt = 0
			p.jp = false
			p.sp = false
			p.tk = false
			p.tr = false
		end
		if p.jt > 0 then
			p.jt = p.jt - 1
		end
		if p.jt < 0 then
			p.jt = p.jt + 1
		end
		if me.momz < 1 then
			p.jp = false
		end
		if me.state != S_PLAY_CLIMB and me.eflags != me.eflags | MFE_GOOWATER then
			if me.momz > 0 and p.jp == false and me.state != S_PLAY_FLY and me.state != S_PLAY_SWIM and me.state != S_PLAY_FLY_TIRED and me.state != S_PLAY_WALK and me.state != S_PLAY_RUN and me.state != S_PLAY_WALK and me.state != S_PLAY_BOUNCE_LANDING then
				p.jp = true
				p.jt = 5
			end
			if me.momz > 0 and p.jt < 0 and me.state != S_PLAY_FLY and me.state != S_PLAY_SWIM and me.state != S_PLAY_FLY_TIRED and me.state != S_PLAY_WALK and me.state != S_PLAY_RUN and me.state != S_PLAY_WALK and me.state != S_PLAY_BOUNCE_LANDING then
				p.jp = true
				p.jt = 5
			end
		elseif me.eflags == me.eflags | MFE_GOOWATER
			p.jp = true
		end
		if me.state == S_PLAY_BOUNCE_LANDING then
			p.jt = -5
		end
		/*
		if p.pflags != p.pflags | PF_SPINNING or p.pflags == p.pflags | PF_JUMPED then
			p.sp = false
		end
		if p.pflags == p.pflags | PF_SPINNING and p.pflags != p.pflags | PF_JUMPED and p.sp == false and p.jt < 1 then
			p.sp = true
			p.jt = -5
		end
		*/
		if p.pflags != p.pflags | PF_THOKKED then
			p.tk = false
		end
		if p.pflags == p.pflags | PF_THOKKED and p.tk == false then
			p.tk = true
			p.jt = 5
		end
		if me.state != S_PLAY_FLY_TIRED then
			p.tr = false
		end
		if me.state == S_PLAY_FLY_TIRED and p.tr == false then
			p.tr = true
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
		
        if soap.disableMomen or battle
            return
        end
   
        if soap.isXmo
            soap.canMomen = false
        else
            soap.canMomen = true
        end
       
		if me and me.scale and me.friction and me.movefactor and soap.canMomen then
			//Create history
			if p.waterlast == nil then
				p.waterlast = false
				p.dashlast = false
				p.realfriction = me.friction
			end
			local skin = skins[me.skin]
			
			//Stat adjust
			if p.charability2 == CA2_SPINDASH then
				p.mindash = skin.mindash * 3/2
			end
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
				p.normalspeed = skin.normalspeed
				me.friction = $-$/20 //what does this do now
			//Do ground momentum
			elseif grounded then
				//The amount of momentum to sustain
				local sustain = FixedDiv(min(mem*water,nmom*2),friction)
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
	if soap.isIdle or me.state == S_PLAY_WAIT or me.state == S_PLAY_WALK or me.state == S_PLAY_RUN or me.state == S_PLAY_DASH or me.state == S_PLAY_SKID
		if soap.isSoap
			if not soap.onGround
			and p.powers[pw_carry] != CR_ROLLOUT
			and p.powers[pw_carry] != CR_MINECART //this gives me an idea for a minecart anim
			and p.powers[pw_carry] != CR_ZOOMTUBE
			and p.powers[pw_carry] != CR_ROPEHANG
			and p.powers[pw_carry] != CR_PLAYER
			and p.powers[pw_carry] != CR_NIGHTSMODE
				if me.momz >= 0
//					me.state = S_PLAY_SOAP_FLAILUP
//					me.state = S_PLAY_ROLL
					me.state = S_PLAY_SPRING
				else
//					me.state = S_PLAY_ROLL
					me.state = S_PLAY_FLY
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

rawset(_G, "SoapConsoleStatSpam", function(player, me, soap)
	if soap.debugStats
		local p = player
		//print EVERYTHING in the table so i can know whats unused 
		if p.soaptable
			CONS_Printf(p, "\x82"+"Soap Stats")
			CONS_Printf(p, "Rolltrol " + soap.rolltrol)
			CONS_Printf(p, "Uncurl " + soap.soapUncurl)
			CONS_Printf(p, "Flexxing " + soap.flexxing)
			CONS_Printf(p, "Laughing " + soap.laughing)
			CONS_Printf(p, "DisableMomen " + soap.disableMomen)
			CONS_Printf(p, "CanMomen " + soap.canMomen)
			CONS_Printf(p, "DebugStats " + soap.debugStats)
			CONS_Printf(p, "UncurlPrevBtn " + soap.uncurlprevbuttons)
			CONS_Printf(p, "DashPreserve " + soap.dashpreserve)
			CONS_Printf(p, "RecurlAble " + soap.recurlAble)
			CONS_Printf(p, "CurlPainStasis " + soap.curlPainStasis)
			CONS_Printf(p, "IsDash " + soap.isDash)
			CONS_Printf(p, "OnGround " + soap.onGround)
			CONS_Printf(p, "IsSoap " + soap.isSoap)
			CONS_Printf(p, "IsXmo " + soap.isXmo)
			CONS_Printf(p, "IsSuper " + soap.isSuper)
			CONS_Printf(p, "IsSuperM " + soap.isSuperM)
			CONS_Printf(p, "IsElevated " + soap.isElevated)
			CONS_Printf(p, "InPain " + soap.inPain)
			CONS_Printf(p, "SPR " + soap.SspinREADY)
			CONS_Printf(p, "SPD " + soap.SspinDOWN)
			CONS_Printf(p, "TFR " + soap.StossflagREADY)
			CONS_Printf(p, "TFD " + soap.StossflagDOWN)
			CONS_Printf(p, "C1R " + soap.Scustom1READY)
			CONS_Printf(p, "C1D " + soap.Scustom1DOWN)
			CONS_Printf(p, "C2R " + soap.Scustom2READY)
			CONS_Printf(p, "C2D " + soap.Scustom2DOWN)
			CONS_Printf(p, "C3R " + soap.Scustom3READY)
			CONS_Printf(p, "C3D " + soap.Scustom3DOWN)
		end
		CONS_Printf(p, "\x82"+"Player Stats")
		CONS_Printf(p, "Player# " + #player)
		CONS_Printf(p, "Player " + p.name)
		CONS_Printf(p, "Skin " + me.skin)
		CONS_Printf(p, "SoapTable " + soap)
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

	end
end)
