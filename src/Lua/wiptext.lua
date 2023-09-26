/*	WIP Text Script

	Originally made by D00D64

	Modified to be displayed everywhere possible
	
	modified again to prevent those silly errors that say "mo is nil"
*/

local function wipRender(v, player)
	if not player.realmo
	or not player.mo
	or not SoapFetchConstant("soap_devbuild")
		return
	end
	
	if player.mo.skin == "soapthehedge" then
		if not G_RingSlingerGametype()
			v.drawString(160, 180, ("Work in Progress - DO NOT SHARE OR HOST!"),V_SNAPTOBOTTOM|V_ALLOWLOWERCASE|V_30TRANS|V_REDMAP, "thin-center")
		else
			v.drawString(160, 160, ("Work in Progress - DO NOT SHARE OR HOST!"),V_SNAPTOBOTTOM|V_ALLOWLOWERCASE|V_30TRANS|V_REDMAP, "thin-center")
		end
	elseif player.mo.skin == "takisthefox" then
		v.drawString(160, 180, ("Work in Progress - indev0.0.1"),V_SNAPTOBOTTOM|V_ALLOWLOWERCASE|V_30TRANS|V_REDMAP, "thin-center")
	end
end

hud.add(wipRender, "game")
