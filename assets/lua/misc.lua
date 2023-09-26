//the misc file, for hooks!
//make everyone be able spam dispensers here!
addHook("PlayerThink", function(player)
	//do we redefine locals again?
	//im not gonna just incase
	if player.mo.skin ~= "soapthehedge"
		
		if player.mo.state == S_PLAY_SOAP_APOSE
				
				if ((player.cmd.buttons & BT_TOSSFLAG) and (player.cmd.buttons & BT_CUSTOM2))
						
						if player.mo.state == S_PLAY_SOAP_APOSE
						
							if (player.cmd.buttons & BT_CUSTOM2)
							
								if not player.soaptable.dispensercooldown
								
									S_StartSound(me, sfx_x5dish)
									player.soaptable.dispensercooldown = 17 
								end
							end
						end
				end			
				
		end
		
		if player.soaptable.dispensercooldown
			player.soaptable.dispensercooldown = $ - 1
		end
		
		//do our apose buffs
			if player.soaptable.thehorror
				if not player.health
					player.mo.state = S_PLAY_SOAP_APOSE
				end
				player.normalspeed = 32 * FRACUNIT
				player.powers[pw_invulnerability] = 1
				
			else
				if player.mo.state == S_PLAY_SOAP_APOSE
					player.powers[pw_invulnerability] = 0
					
				end
				if player.speed and player.mo.state == S_PLAY_SOAP_APOSE
					player.mo.state = S_PLAY_WALK
				end
			end

	end
end)