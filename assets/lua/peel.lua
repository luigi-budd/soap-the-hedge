--big thanks to SuperPhanto! https://mb.srb2.org/members/superphanto.6302/

freeslot("SPR_PEEL")

addHook("ThinkFrame", do
	for player in players.iterate
		if (player.mo.valid) and (player.mo.skin == "soapthehedge")
			player.charflags = $ | SF_DASHMODE
			if player.dashmode >= 3*TICRATE
				player.nomoredashmodeflash = P_SpawnGhostMobj(player.mo)
				player.nomoredashmodeflash.fuse = 1
				player.nomoredashmodeflash.frame = player.mo.frame
				
				if player.mo.state == S_PLAY_DASH
					local force = FRACUNIT*10
					local angle = ANGLE_90

					local shiftx = FixedMul(cos(player.drawangle + angle), force)
					local shifty = FixedMul(sin(player.drawangle + angle), force)
	
					local shiftx2 = FixedMul(cos(player.drawangle + angle), 8*FRACUNIT)
					local shifty2 = FixedMul(sin(player.drawangle + angle), 8*FRACUNIT)
					
					local shiftx3 = FixedMul(cos(player.drawangle + angle), 9*FRACUNIT)
					local shifty3 = FixedMul(sin(player.drawangle + angle), 9*FRACUNIT)
					
					local shiftx4 = FixedMul(cos(player.drawangle + angle), 7*FRACUNIT)
					local shifty4 = FixedMul(sin(player.drawangle + angle), 7*FRACUNIT)
					
					local shiftx5 = FixedMul(cos(player.drawangle + angle), 10*FRACUNIT)
					local shifty5 = FixedMul(sin(player.drawangle + angle), 10*FRACUNIT)

					player.peelout1 = P_SpawnMobj(player.mo.x - shiftx, player.mo.y - shifty, player.mo.z, MT_THOK)
					player.peelout1.fuse = 1
					player.peelout1.sprite = SPR_PEEL
					if player.mo.frame == A
						player.peelout1.frame = A
					elseif player.mo.frame == B
						player.peelout1.frame = B
					elseif player.mo.frame == C
						player.peelout1.frame = C
					elseif player.mo.frame == D
						player.peelout1.frame = D
					end
					player.peelout1.renderflags = RF_PAPERSPRITE
					player.peelout1.angle = player.drawangle + ANG15
					player.peelout1.scale = player.mo.scale/2
					if player.mo.eflags & MFE_VERTICALFLIP
						player.peelout1.eflags = $ | MFE_VERTICALFLIP
						player.peelout1.z = player.mo.z + player.mo.height - player.peelout1.height
					end
					
					player.peelout2 = P_SpawnMobj(player.mo.x + shiftx, player.mo.y + shifty, player.mo.z, MT_THOK)
					player.peelout2.fuse = 1
					player.peelout2.sprite = SPR_PEEL
					if player.mo.frame == A
						player.peelout2.frame = C
					elseif player.mo.frame == B
						player.peelout2.frame = D
					elseif player.mo.frame == C
						player.peelout2.frame = A
					elseif player.mo.frame == D
						player.peelout2.frame = B
					end
					player.peelout2.renderflags = RF_PAPERSPRITE
					player.peelout2.angle = player.drawangle - ANG15
					player.peelout2.scale = player.mo.scale/2
					if player.mo.eflags & MFE_VERTICALFLIP
						player.peelout2.eflags = $ | MFE_VERTICALFLIP
						player.peelout2.z = player.mo.z + player.mo.height - player.peelout2.height
					end
					
					player.peelout3 = P_SpawnMobj(player.mo.x - shiftx2, player.mo.y - shifty2, player.mo.z, MT_THOK)
					player.peelout3.fuse = 1
					player.peelout3.sprite = SPR_PEEL
					if player.mo.frame == A
						player.peelout3.frame = A
					elseif player.mo.frame == B
						player.peelout3.frame = B
					elseif player.mo.frame == C
						player.peelout3.frame = C
					elseif player.mo.frame == D
						player.peelout3.frame = D
					end
					player.peelout3.renderflags = RF_PAPERSPRITE
					player.peelout3.angle = player.drawangle + ANG15
					player.peelout3.scale = player.mo.scale/2
					if player.mo.eflags & MFE_VERTICALFLIP
						player.peelout3.eflags = $ | MFE_VERTICALFLIP
						player.peelout3.z = player.mo.z + player.mo.height - player.peelout3.height
					end
					
					player.peelout4 = P_SpawnMobj(player.mo.x + shiftx2, player.mo.y + shifty2, player.mo.z, MT_THOK)
					player.peelout4.fuse = 1
					player.peelout4.sprite = SPR_PEEL
					if player.mo.frame == A
						player.peelout4.frame = C
					elseif player.mo.frame == B
						player.peelout4.frame = D
					elseif player.mo.frame == C
						player.peelout4.frame = A
					elseif player.mo.frame == D
						player.peelout4.frame = B
					end
					player.peelout4.renderflags = RF_PAPERSPRITE
					player.peelout4.angle = player.drawangle - ANG15
					player.peelout4.scale = player.mo.scale/2
					if player.mo.eflags & MFE_VERTICALFLIP
						player.peelout4.eflags = $ | MFE_VERTICALFLIP
						player.peelout4.z = player.mo.z + player.mo.height - player.peelout4.height
					end
					
					player.peelout5 = P_SpawnMobj(player.mo.x - shiftx3, player.mo.y - shifty3, player.mo.z, MT_THOK)
					player.peelout5.fuse = 1
					player.peelout5.sprite = SPR_PEEL
					if player.mo.frame == A
						player.peelout5.frame = A
					elseif player.mo.frame == B
						player.peelout5.frame = B
					elseif player.mo.frame == C
						player.peelout5.frame = C
					elseif player.mo.frame == D
						player.peelout5.frame = D
					end
					player.peelout5.renderflags = RF_PAPERSPRITE
					player.peelout5.angle = player.drawangle + ANG15
					player.peelout5.scale = player.mo.scale/2
					if player.mo.eflags & MFE_VERTICALFLIP
						player.peelout5.eflags = $ | MFE_VERTICALFLIP
						player.peelout5.z = player.mo.z + player.mo.height - player.peelout5.height
					end
					
					player.peelout6 = P_SpawnMobj(player.mo.x + shiftx3, player.mo.y + shifty3, player.mo.z, MT_THOK)
					player.peelout6.fuse = 1
					player.peelout6.sprite = SPR_PEEL
					if player.mo.frame == A
						player.peelout6.frame = C
					elseif player.mo.frame == B
						player.peelout6.frame = D
					elseif player.mo.frame == C
						player.peelout6.frame = A
					elseif player.mo.frame == D
						player.peelout6.frame = B
					end
					player.peelout6.renderflags = RF_PAPERSPRITE
					player.peelout6.angle = player.drawangle - ANG15
					player.peelout6.scale = player.mo.scale/2
					if player.mo.eflags & MFE_VERTICALFLIP
						player.peelout6.eflags = $ | MFE_VERTICALFLIP
						player.peelout6.z = player.mo.z + player.mo.height - player.peelout6.height
					end
					
					player.peelout7 = P_SpawnMobj(player.mo.x - shiftx4, player.mo.y - shifty4, player.mo.z, MT_THOK)
					player.peelout7.fuse = 1
					player.peelout7.sprite = SPR_PEEL
					if player.mo.frame == A
						player.peelout7.frame = A
					elseif player.mo.frame == B
						player.peelout7.frame = B
					elseif player.mo.frame == C
						player.peelout7.frame = C
					elseif player.mo.frame == D
						player.peelout7.frame = D
					end
					player.peelout7.renderflags = RF_PAPERSPRITE
					player.peelout7.angle = player.drawangle + ANG15
					player.peelout7.scale = player.mo.scale/2
					if player.mo.eflags & MFE_VERTICALFLIP
						player.peelout7.eflags = $ | MFE_VERTICALFLIP
						player.peelout7.z = player.mo.z + player.mo.height - player.peelout7.height
					end
					
					player.peelout8 = P_SpawnMobj(player.mo.x + shiftx4, player.mo.y + shifty4, player.mo.z, MT_THOK)
					player.peelout8.fuse = 1
					player.peelout8.sprite = SPR_PEEL
					if player.mo.frame == A
						player.peelout8.frame = C
					elseif player.mo.frame == B
						player.peelout8.frame = D
					elseif player.mo.frame == C
						player.peelout8.frame = A
					elseif player.mo.frame == D
						player.peelout8.frame = B
					end
					player.peelout8.renderflags = RF_PAPERSPRITE
					player.peelout8.angle = player.drawangle - ANG15
					player.peelout8.scale = player.mo.scale/2
					if player.mo.eflags & MFE_VERTICALFLIP
						player.peelout8.eflags = $ | MFE_VERTICALFLIP
						player.peelout8.z = player.mo.z + player.mo.height - player.peelout8.height
					end
					
					player.peelout9 = P_SpawnMobj(player.mo.x - shiftx5, player.mo.y - shifty5, player.mo.z, MT_THOK)
					player.peelout9.fuse = 1
					player.peelout9.sprite = SPR_PEEL
					if player.mo.frame == A
						player.peelout9.frame = A
					elseif player.mo.frame == B
						player.peelout9.frame = B
					elseif player.mo.frame == C
						player.peelout9.frame = C
					elseif player.mo.frame == D
						player.peelout9.frame = D
					end
					player.peelout9.renderflags = RF_PAPERSPRITE
					player.peelout9.angle = player.drawangle + ANG15
					player.peelout9.scale = player.mo.scale/2
					if player.mo.eflags & MFE_VERTICALFLIP
						player.peelout9.eflags = $ | MFE_VERTICALFLIP
						player.peelout9.z = player.mo.z + player.mo.height - player.peelout9.height
					end
					
					player.peelout10 = P_SpawnMobj(player.mo.x + shiftx5, player.mo.y + shifty5, player.mo.z, MT_THOK)
					player.peelout10.fuse = 1
					player.peelout10.sprite = SPR_PEEL
					if player.mo.frame == A
						player.peelout10.frame = C
					elseif player.mo.frame == B
						player.peelout10.frame = D
					elseif player.mo.frame == C
						player.peelout10.frame = A
					elseif player.mo.frame == D
						player.peelout10.frame = B
					end
					player.peelout10.renderflags = RF_PAPERSPRITE
					player.peelout10.angle = player.drawangle - ANG15
					player.peelout10.scale = player.mo.scale/2
					if player.mo.eflags & MFE_VERTICALFLIP
						player.peelout10.eflags = $ | MFE_VERTICALFLIP
						player.peelout10.z = player.mo.z + player.mo.height - player.peelout10.height
					end
				end
			end
		end
	end
end)