if not paused
	if (soap.accSpeed >= 76*me.scale)
	and me.health and not splitscreen
		local trans = V_90TRANS
		local color = SKINCOLOR_BONE
		local x = 0
		local y = 0
		
		//cap offsets
		if x < 0
			x = 0
		elseif x > 3
			x = 3
		end
		if y < 0
			y = 0	
		elseif y > 3
			y = 3
		end

		
	end
end