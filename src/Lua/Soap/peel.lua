--big thanks to SuperPhanto! https://mb.srb2.org/members/superphanto.6302/
//because of the way this script works, im not sure if i can import this into main2 in someway... maybe in the future
//i think this would be cooler to put in misc.lua
addHook("ThinkFrame", do
	for player in players.iterate
		if (player and player.mo and player.mo.valid) and (player.mo.skin == "soapthehedge")
			if player.mo.state == S_PLAY_DASH
			and not (player.powers[pw_super])
				for i = -40, 40
					
					local force = i*FRACUNIT/3
					local angle = ANGLE_90

					local shiftx = FixedMul(cos(player.drawangle + angle), force)
					local shifty = FixedMul(sin(player.drawangle + angle), force)
					
					local shiftx2 = FixedMul(cos(player.drawangle), FRACUNIT)
					local shifty2 = FixedMul(sin(player.drawangle), FRACUNIT)
					
					if i > 20
					or i < -20
						//MT_OVERLAY would cause lag and look incorrect in angel island tour
						//so i replaced it with MT_THOK to avoid any of that
						local peelout = P_SpawnMobjFromMobj(player.mo, shiftx2 + shiftx, shifty2 + shifty, 0, MT_THOK)
						peelout.target = player.mo
						peelout.fuse = 1
						peelout.sprite = SPR_PEEL
						if i < 0
							if player.mo.frame == A
								peelout.frame = A
							elseif player.mo.frame == B
								peelout.frame = B
							elseif player.mo.frame == C
								peelout.frame = C
							elseif player.mo.frame == D
								peelout.frame = D
							end
							peelout.angle = player.drawangle + ANGLE_90/6
						else
							if player.mo.frame == A
								peelout.frame = C
							elseif player.mo.frame == B
								peelout.frame = D
							elseif player.mo.frame == C
								peelout.frame = A
							elseif player.mo.frame == D
								peelout.frame = B
							end
							peelout.angle = player.drawangle - ANGLE_90/6
						end
						peelout.renderflags = RF_PAPERSPRITE
						peelout.scale = player.mo.scale/2
						if player.mo.eflags & MFE_VERTICALFLIP
							peelout.eflags = $ | MFE_VERTICALFLIP
							peelout.z = player.mo.z + player.mo.height - peelout.height
						end
						
						//should you be out of my face?
						if player.soaptable.isFirstPerson
							peelout.flags2 = $ |MF2_DONTDRAW
						else
							peelout.flags2 = $ & ~MF2_DONTDRAW
						end
					end
				end
			end
		end
	end
end)