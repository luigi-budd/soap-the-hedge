//i stole all of this stuff from Rafael44642 on the message boards!
local cv_extra = CV_RegisterVar({"play_extra", "On", CV_NETVAR, CV_OnOff})

freeslot("S_PLAY_EXTRA", "MT_EXTRA")

states[S_PLAY_EXTRA] = {SPR_PLAY, SPR2_CLMB, 5, nil, 0, 0, S_PLAY_EXTRA}

addHook("MobjThinker", function(mobj)
	if (mobj.valid) and (mobj.health)
		P_SpawnGhostMobj(mobj)
		P_KillMobj(mobj)
	end
end, MT_EXTRA)

addHook("PlayerThink", function(player)
	if player.mo and player.mo.valid and player.mo.skin == "soapHedge"
		//Detect when we press Toss Flag
		if not (player.cmd.buttons & BT_TOSSFLAG)
			player.soapHedgetosstapready = true
			player.soapHedgetosstapping = false
		elseif player.soapHedgetosstapready 
			player.soapHedgetosstapping = true
			player.soapHedgetosstapready = false
		else
			player.soapHedgetosstapping = false
		end
		
        if player.powers[pw_carry] == CA_NONE
            if player.extra
                player.panim = PA_DASH
                if player.soapHedgetosstapping
                    if player.mo.state == S_PLAY_EXTRA
                        player.mo.state = S_PLAY_STND
                    end
                    player.extra = false
                    P_RestoreMusic(player)
                else
                    if player.mo.state != S_PLAY_EXTRA
                        player.mo.state = S_PLAY_EXTRA
                    end
                    player.pflags = $|PF_FULLSTASIS
                end
            elseif player.soapHedgetosstapping
                player.extra = true
                P_PlayJingleMusic(player, "EXTRA", nil, true, JT_OTHER)
            end
        end
	end
end)

addHook("ShouldJingleContinue", function(player, musname)
	if true return end
	if musname != "EXTRA" return end
	if player and player.mo and player.mo.skin == "soapHedge" and player.pedxtra
		return true
	else
		return false
	end
end)

addHook("PlayerSpawn", function(player)
    if player.mo and player.mo.valid and player.mo.skin == "soapHedge"
        if player.powers[pw_carry] != CR_NIGHTSMODE then player.mo.state = S_PLAY_STND end
        player.extra = false
    end
end)
