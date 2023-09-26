if not SoapInitTable
    return
end

addHook("MobjMoveBlocked", function(mo, thing, line)
	if not mo
	or not mo.valid
		return
	end
	
	local p = mo.player
	local me = p.mo
	local soap = p.soaptable
	
	if me.skin ~= "soapthehedge"
		return
	end
	
	if ((thing) and (thing.valid)) or ((line) and (line.valid))
		if p.dashmode >= 4*TICRATE
			if thing and thing.valid
				P_DoPlayerPain(p, thing, thing)
				P_InstaThrust(me,thing.angle,(25*FRACUNIT))
			elseif line and line.valid
				P_DoPlayerPain(p)
				P_InstaThrust(me,p.drawangle,(-20*FRACUNIT))
			end
			S_StartSound(me,sfx_bmslam)	
			soap.recovwait = -99*FRACUNIT
		end
	end
	
end, MT_PLAYER)
