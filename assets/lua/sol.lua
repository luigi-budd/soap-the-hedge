//maybe dont force this to be added?
/*
local canSol = 0

addHook("PlayerThink", function(p)
	if p.solchar ~= "nil"
		canSol = true
	else
		canSol = false
	end
end)	

if not solchars
    rawset(_G, "solchars", {})
end
solchars["soapthehedge"] = {SKINCOLOR_SUPERRED1, 2}

	addHook("AbilitySpecial", function(player)
		if player.mo.skin == "soapthehedge" and canSol
and player.solchar.istransformed > 0
and not (player.pflags & PF_THOKKED)
				S_StartSound(player.mo, sfx_zoom)
end
end)

addHook("PlayerThink", function(player) 
		if player.mo.skin == "soapthehedge" and canSol
		and player.solchar.istransformed > 0
		and (player.mo.state == S_PLAY_ROLL) 
		and (P_IsObjectOnGround(player.mo) == true)
			P_ElementalFire(player)
	end
		if player.mo.skin == "soapthehedge" and canSol
		and player.solchar.istransformed > 0
		and player.mo.state == S_PLAY_RUN
		if not player.weapondelay
		P_ElementalFire(player)
		player.weapondelay = TICRATE/10
		end
	end
end)


addHook("PlayerThink", function(player) 
		if player.mo.skin == "soapthehedge" and canSol
		and player.solchar.istransformed > 0
		and (player.pflags & PF_THOKKED)
		A_BossScream(player.mo, 0, 	MT_FIREBALLTRAIL)
	end
end)

addHook("PlayerThink", function(player) 
		if player.mo.skin == "soapthehedge" and canSol //so its YOU whos messing with other skins abilities
		and player.solchar.istransformed > 0
		player.charability = CA_HOMINGTHOK
		player.actionspd = 84 * FRACUNIT
		else
		player.charability = CA_JUMPTHOK
		player.actionspd = 30 * FRACUNIT
	end
end)


addHook("PlayerThink", function(player) 
		if player.mo.skin == "soapthehedge"
		and player.solchar.istransformed > 0
					local trail3 = P_SpawnMobjFromMobj(player.realmo, P_RandomRange(-20, 20) * FRACUNIT, P_RandomRange(-20, 20) * FRACUNIT, P_RandomRange(0, 50) * FRACUNIT, MT_FIREBALLTRAIL)
	trail3.color = SKINCOLOR_RED
	trail3.colorized = true
	trail3.scale = 1*FRACUNIT/2
	trail3.destscale = 1*FRACUNIT/4
	trail3.momz = 2*FRACUNIT
		local trail4 = P_SpawnMobjFromMobj(player.realmo, P_RandomRange(-20, 20) * FRACUNIT, P_RandomRange(-20, 20) * FRACUNIT, P_RandomRange(0, 50) * FRACUNIT, MT_PUMATRAIL)
	trail4.color = SKINCOLOR_ORANGE
	trail4.colorized = true
	trail4.scale = 1*FRACUNIT/2
	trail4.destscale = 1*FRACUNIT/4
	trail4.momz = 2*FRACUNIT
	end
end)
*/