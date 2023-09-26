--hey, the code works!
--thanks for Mizzhap on the message boards for helping me write this

--also make sure you cant do this in NiGHTS

freeslot("S_PLAY_SOAP_TAUNT")

states[S_PLAY_SOAP_TAUNT] = {
    sprite = SPR_PLAY,
    frame = SPR2_CLMB|FF_ANIMATE,
    var2 = 2,
    tics = -1,
    nextstate = S_PLAY_STND
}

addHook("ThinkFrame", function()
    for player in players.iterate do
		if player.mo.skin ~= "soapthehedge" then
            continue
        end

        if (player.cmd.buttons & BT_CUSTOM1) then --make this a toggle for the taunt 
            player.mo.state = S_PLAY_SOAP_TAUNT
            player.taunting = true
        end

        if player.taunting then
            player.pflags = $1|PF_FULLSTASIS
        end
        
        if not player.mo.state == S_PLAY_SOAP_TAUNT or (player.cmd.buttons & BT_JUMP) then
            player.taunting = false
        end
        
        print(player.taunting)
	end
end)

--i will NOT use lua EVER again unless i work on my year old roblo game