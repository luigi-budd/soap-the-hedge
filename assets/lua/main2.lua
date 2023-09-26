//main rewrite!!
//get rid of all that spaghetti code!

addHook("PlayerThink", function(p)
    if not p.valid
        return
    end

    //get our table first thing!
    if not p.soaptable
        SoapInitTable(p)
    return
    end
    
    if p.mo.valid //kick off our entire script
    local me = p.mo
    local soap = p.soaptable
    local UNCURL_LOCKTIME = 1
        if me.skin == "soapthehedge"
            //hopefully this fixes that stupid mrce momentum bug for soap
            p.mrcecustomskin = 2

            //constants
			//im so silly, i forgot to put in the 2 other args!
            SoapConstants(p, me, soap)
            SoapButtonCheck(p, me, soap)
            SoapSquashAndStretch(p, me)
            SoapyMomentum(p, me, soap)
            SoapNoAirwalk(p, me, soap)

//these should be in their own script
/*
            local function rolltrolll(p, arg)
                if not(p and p.valid and me)
                    CONS_Printf(player, "Make sure you're in a level before you use this!")
                    return
                end

                if arg then
                    if arg == "true" or arg == "on" or arg == "1"
                        soap.rolltrol = 1
                        CONS_Printf(p, "Soap now has more control when rolling!")
                    else
                        soap.rolltrol = 0
                        CONS_Printf(p, "Soap now has less control when rolling!")
                    end
                else
                    if soap.rolltrol
                        CONS_Printf(p, "Toggles rolltrolling for Soap. Currently on right now.")
                    else
                        CONS_Printf(p, "Toggles rolltrolling for Soap. Currently off right now.")
                    end
                end
            end

            COM_AddCommand("soap_rolltrol", function(p, arg)
                rolltrolll(p, arg)
            end)

            COM_AddCommand("soap_uncurl", function(p, value)
                if not(me)
                    CONS_Printf(p,"Make sure you're in a level before you use this!")
                    return
                end
                if soap.isXmo
                    CONS_Printf(p,"You can't use this while XMomentum is loaded.")
                end
                if value == "0" or value == "no" or value == "off"
                    soap.soap_uncurl = 0
                    CONS_Printf(p,"Soap can no longer uncurl from spinning.")
                elseif value == "1" or value == "yes" or value == "on"
                    soap.soap_uncurl = 1
                    CONS_Printf(p,"Soap can now uncurl from spinning.")
                else
                    if not soap.isXmo
                        if soap.soap_uncurl == 1
                            CONS_Printf(p,"Soap is able to uncurl.")
                        else
                            CONS_Printf(p,"Soap is unable to uncurl.")
                        end
                    end
                end
            end,0)
*/

            //i have an idea!
            //why not combine both flex and laugh scripts into one?
            for p in players.iterate do
                if not soap.isSoap
                    return
                end
                //laugh
                if soap.onGround and soap.isValid and soap.isIdle and (soap.StossflagDOWN and soap.Scustom3DOWN)
                    if not soap.laughing
                        me.state = S_PLAY_SOAP_LAUGH
                        soap.laughing = 1
					    S_StartSound(me, sfx_hahaha)
                    else
                        soap.laughing = 0
                        me.state = S_PLAY_STND
                    end
				end

                if soap.laughing
                    p.pflags = $1|PF_FULLSTASIS
                    if soap.isIdle
                        soap.laughing = 0
                    end
                end

                if soap.inPain and soap.laughing
                    soap.laughing = 0
                    me.state = S_PLAY_PAIN
                end
                
                //flex
                if soap.onGround and soap.isValid and soap.isIdle and (soap.StossflagDOWN and soap.Scustom2DOWN)
                    if not soap.flexxing
                        me.state = S_PLAY_SOAP_FLEX
                        soap.flexxing = 1
					    S_StartSound(me, sfx_flex)
                    else
                        soap.flexxing = 0
                        me.state = S_PLAY_STND
                    end
				end

                if soap.flexxing
                    p.pflags = $1|PF_FULLSTASIS
                    if soap.isIdle
                        soap.flexxing = 0
                    end
                end

                if soap.inPain and soap.flexxing
                    soap.flexxing = 0
                    me.state = S_PLAY_PAIN
                end
            end

            if p.hugged
                me.sprite2 = SPR2_HUG_
            end

            if p.pflags & PF_SPINNING
            and not (p.pflags & PF_STARTDASH)
            and soap.onGround
            and soap.rolltrol then
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

            if not (me) return end
            if p.powers[pw_underwater] > 20*TICRATE
            p.powers[pw_underwater] = 20*TICRATE 
            end

            for p in players.iterate()
                //Init
                if soap.isXmo
                    return
                end
                
                if soap.soapCurlInit == nil
                    soap.soapCurlInit = true
                    soap.uncurlprevbuttons = p.cmd.buttons
                    if soap.soapUncurl == nil soap.soapUncurl = 1 end
                    return
                end
                
                if me and p.playerstate == PST_LIVE and not p.exiting and not p.powers[pw_nocontrol] and not soap.inPain and soap.isSoap
                    local pbtn = soap.uncurlprevbuttons
                    local btn = p.cmd.buttons
                    
                    //print(me.uncurl_lock)
                    //print(me.will_uncurl)
                    //Uncurl
                    if me.state == S_PLAY_ROLL and soap.onGround
                        local uncurlinput = false
                        local recurlinput = false
                        if soap.soapUncurl == 1
                            uncurlinput = (btn & BT_USE) and not (pbtn & BT_USE)
                        else
                            uncurlinput = (pbtn & BT_USE) and not (btn & BT_USE)
                            recurlinput = (btn & BT_USE) and not (pbtn & BT_USE)
                        end
                        
                        if me.uncurl_lock == UNCURL_LOCKTIME and uncurlinput
                            uncurlinput = false
                        end
                        
                        if uncurlinput
                            me.will_uncurl = true
                        end
                        if recurlinput
                            me.will_uncurl = false
                        end
                        
                        if me.uncurl_lock
                            me.uncurl_lock = max(0, $ - 1)
                            
                        elseif me.will_uncurl
                            me.uncurl_lock = UNCURL_LOCKTIME
                            me.uncurlready = false
                            if FixedHypot(me.momx, me.momy) >= p.runspeed
                                me.state = S_PLAY_RUN
                            else
                                me.state = S_PLAY_WALK
                            end
                            if p.pflags & PF_SPINNING
                                p.pflags = $1 & ~PF_SPINNING
                            end
                            S_StartSound(me,sfx_uncurl)
                            S_StopSoundByID(me,sfx_spin)
                        end
                    else
                        me.uncurl_lock = UNCURL_LOCKTIME
                        me.will_uncurl = false
                    end
                    soap.uncurlprevbuttons = btn
                end
            end
           
            //"borrowed" from alt sonic
			if not soap.onGround and not (p.powers[pw_carry] == CR_NIGHTSMODE) and (p.panim == PA_SPRING) and soap.SspinDOWN and soap.isValid
				SoapSquashAndStretch(p, me)
                S_StartSound(me,sfx_srecur)
				p.pflags = $ + PF_JUMPED
				me.state = S_PLAY_JUMP
			end

            if soap.isSuperM
                p.accelstart = 150
                p.acceleration = 65
                p.thrustfactor = 8
            else
                p.accelstart = 110
                p.acceleration = 40
                p.thrustfactor = 5
            end

        end //skin if
    end //script hat
end) 