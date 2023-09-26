//hud stuff for soap.devmode!!!!!!!!!!!!!!!!!!
//and maybe for some future stuff ;)
//local fttexty = 60
//local fttrans = 0
local shownNotif = false
//with some from sms
hud.add(function(v, p)
if not p.mo
return end
 
if not p.soaptable
return
end

if (p.powers[pw_carry] == CR_NIGHTSMODE)
return
end

//cant do anything without these locals first!
local soap = p.soaptable
local me = p.mo
local movedown = 0
local extramovedown = 0
local extraextramove = 0
movedown = 0
extramovedown = 0
extraextramove = 0



if soap.isValid
and me.skin == "soapthehedge"
//	print(soap.firsttime)
//	print(soap.firstttic)
//	print(soap.fttic)
//	print(soap.ftkill)
	if customhud
		customhud.SetupItem("lives", "vanilla")
	end
	
	if (not me.health)
	or (p.exiting)
		return
	end

	//i know this thing is annoying, but i want people to know how to play as this fella!
	if soap.firsttime
	//its our first time playing
	and not soap.firstttic
	//we're not waiting for the text to show anymore
//	and soap.fttic
	//we're allowed to show the text
//	and not (soap.ftblink % 2 == 0)
	and soap.ftblink
	and not (soap.ftkill and soap.ftblink % 2 == 0)
	and not (soap.ftblink-2*TICRATE < 30 and soap.ftblink % 2 == 0)
	and not (p == secondarydisplayplayer)
		
		v.drawString(soap.ftx, soap.fty, "New to\x88 Soap\x80? Check out\x86 soap_help\x80 to learn the ins and outs of\x88 Soap\x80.",V_ALLOWLOWERCASE|V_PERPLAYER, "thin-center")
		v.drawString(soap.ftx, (soap.fty+12), "\x86Use soap_help in console or press C2 to close",V_50TRANS|V_ALLOWLOWERCASE|V_PERPLAYER, "small-center")
	end
	
	
	//"You've hurt "+skins[me.skin].realname+" "+soap.timeshurt+" times..."
//	if soap.justhurtNOW
/*
	if (soap.timeshurt % 5 == 0) and soap.timeshurt
	and (soap.hurttextshow)
	and ( ((not (soap.hurttextshow % 2 == 0)) and (soap.hurttextshow < TICRATE*2/3)) )
		v.drawString(soap.ftx, soap.fty, "You've hurt "+skins[me.skin].realname+" "+soap.timeshurt+" times...",V_ALLOWLOWERCASE|((soap.hurttextfade%9))<<V_ALPHASHIFT, "thin-center")
	end
*/
//	if not soap.fttic
	if (soap.Scustom2OS)
	and not soap.firstttic
	and (not soap.ftkill)
		soap.ftkill = TICRATE
	end
	
	if p.powers[pw_underwater]
	and me.eflags & MFE_UNDERWATER
	and not soap.isGod
//	and not (p.dashmode >= (4*TICRATE))
		if p.powers[pw_underwater] < 11*TICRATE
		and (p.powers[pw_underwater] % 5 == 0)
			v.drawString(125, 116, "   " + "\x85"+(p.powers[pw_underwater]/TICRATE),V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER, "small-right")
			v.drawScaled(soap.bblx*(FRACUNIT), soap.bbly*(FRACUNIT), FRACUNIT/2, v.cachePatch("BUBLA0"), V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER,v.getColormap(nil, me.color))
		else
			v.drawString(125, 116, "   " +(p.powers[pw_underwater]/TICRATE),V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER, "small-right")
	//		v.drawScaled(127*(FRACUNIT), 93*(FRACUNIT), FRACUNIT/2, v.cachePatch("BUBLA0"), V_SNAPTORIGHT|V_SNAPTOBOTTOM,v.getColormap(nil, me.color))	
			v.drawScaled(soap.bblx*(FRACUNIT), soap.bbly*(FRACUNIT), FRACUNIT/2, v.cachePatch("BUBLA0"), V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER,v.getColormap(nil, me.color))
		end
	end

	if p.dashmode > (3*TICRATE)+4
		if not (p.dashmode >= 4*TICRATE)
			v.drawString(125, 120, "Mach 4: " + ((p.dashmode - (3*TICRATE))-4),V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER, "small-right")
		elseif p.dashmode > 4*TICRATE
			if soap.ptaicolor == 1
				v.drawString(125, 120, "Mach 4: " + "\x85"+((p.dashmode - (3*TICRATE))-4),V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER, "small-right")
			else
				v.drawString(125, 120, "Mach 4: " + "\x83"+((p.dashmode - (3*TICRATE))-4),V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER, "small-right")
			end
		end
	elseif (p.dashmode > 9) and p.dashmode <= (3*TICRATE)
		v.drawString(125, 120, "DashMode: " + p.dashmode,V_50TRANS|V_ALLOWLOWERCASE|V_PERPLAYER, "small-right")
	end
	
	if soap.airdashtimer 
	and soap.airdashtimer < 2*TICRATE
	and not soap.airdashed
		v.drawString(125, 124, "Airdash: " +(70-soap.airdashtimer)+"/70",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER, "small-right")
	//	if soap.isSValid
	//		v.drawString(135, 128, "C3 + Spin: Detonate Shield",V_60TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	//		movedown = 4
	//	end
	end
	
	if soap.cosspeedometer == 1
		v.drawString(125, 128+movedown, "Speed (Fu/T): " +(soap.accSpeed)+"/"+(p.normalspeed),V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER, "small-right")
		extramovedown = 4
	elseif soap.cosspeedometer == 2
		v.drawString(125, 128+movedown, "Speed (Fu/T): " +(soap.accSpeed/FRACUNIT)+"/"+(p.normalspeed/FRACUNIT),V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER, "small-right")
		extramovedown = 4
	else
		extramovedown = 0
	end

	if ((p.pflags & PF_JUMPED) and (not (p.pflags & PF_SHIELDABILITY)))
	and (not soap.noShield) and soap.isSValid
		v.drawString(135, 128+(movedown+extramovedown), "C2: Detonate Shield ("+(soap.hudshieldability)+")",V_60TRANS|V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER, "small-right")
		extraextramove = 4
	end

	//lets add a picture of soap dashing into an enemy to show
	//that super dashmode kills enemies on contact
	if p.dashmode >= 4*TICRATE
	or ((p.powers[pw_sneakers]) and (soap.accSpeed > 49 * FRACUNIT))
	or ((soap.accSpeed > p.normalspeed) and (soap.nerfed))
		//old peppino placeholder
//		v.drawScaled(250*FRACUNIT, 150*FRACUNIT, 20000, v.cachePatch("PEPP"), V_SNAPTORIGHT|V_SNAPTOBOTTOM,v.getColormap(nil, me.color))	
		//v2
//		v.drawScaled(250*FRACUNIT, 150*FRACUNIT, FRACUNIT/6, v.cachePatch("SSDMINC2"), V_SNAPTORIGHT|V_SNAPTOBOTTOM|V_PERPLAYER,v.getColormap(nil, nil)) //the one with the afterimages		
//		v.drawScaled(250*FRACUNIT, 150*FRACUNIT, FRACUNIT/6, v.cachePatch("SSDMINC1"), V_SNAPTORIGHT|V_SNAPTOBOTTOM|V_PERPLAYER,v.getColormap(nil, me.color))
		//existing sprites
//		v.drawScaled(0, 0, 0, FRACUNIT, v.getSprite2Patch("soapthehedge", SPR2_DASH, false, A, 7, 0), V_SNAPTORIGHT|V_SNAPTOBOTTOM|V_PERPLAYER,v.getColormap(nil, nil)) //the one with the afterimages		
	end

	v.drawScaled(300*FRACUNIT, 150*FRACUNIT, FRACUNIT/8, v.getSprite2Patch("soapthehedge", SPR2_DASH, false, A, 7, 0), V_SNAPTORIGHT|V_SNAPTOBOTTOM|V_PERPLAYER, v.getColormap(nil, me.color))

	//c2 indicator to show shield abilities are binded to c2
	if not soap.noShield
	and soap.isSValid
	//next to life
	//	v.drawScaled(((hudinfo[HUD_LIVES].x*5)*FRACUNIT), 175*FRACUNIT, FRACUNIT/5, v.cachePatch("SOAPC2"), V_SNAPTOLEFT|V_SNAPTOBOTTOM,v.getColormap(nil, nil))
	//	v.drawString((hudinfo[HUD_LIVES].x*6)+2, hudinfo[HUD_LIVES].y+5, "Shield Ability",V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOBOTTOM, "small")
	//above life
		if not ((p.mrce) or (soap.isCloneF))
			v.drawScaled(hudinfo[HUD_LIVES].x*FRACUNIT, (hudinfo[HUD_LIVES].y-20)*FRACUNIT, FRACUNIT/5, v.cachePatch("SOAPC2"), V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER,v.getColormap(nil, nil))
			v.drawString(hudinfo[HUD_LIVES].x+20, hudinfo[HUD_LIVES].y-14, "Shield Ability",V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER, "small")
		else //move up to account for mrce hud and for clonefighter
			v.drawScaled(hudinfo[HUD_LIVES].x*FRACUNIT, (hudinfo[HUD_LIVES].y-40)*FRACUNIT, FRACUNIT/5, v.cachePatch("SOAPC2"), V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER,v.getColormap(nil, nil))
			v.drawString(hudinfo[HUD_LIVES].x+20, hudinfo[HUD_LIVES].y-34, "Shield Ability",V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER, "small")
		end
	end
	
	if p.powers[pw_carry] == CR_PLAYER
				
		if me.tracer and me.tracer.player
			if (me.tracer.player.powers[pw_tailsfly] < 17) 
			and (me.tracer.player.charability == CA_FLY) 
			and (me.tracer.skin == "poyo")
			and not soap.helpedpoyo
				if (leveltime % 2 == 0)			
					v.drawString(soap.ftx, soap.fty+31, "\x85"+"Spin: Boost!",V_20TRANS|V_ALLOWLOWERCASE|V_PERPLAYER, "small-center")
				else
					v.drawString(soap.ftx, soap.fty+32, "\x83"+"Spin: Boost!",V_20TRANS|V_ALLOWLOWERCASE|V_PERPLAYER, "small-center")	
				end
			end
		end

	end

end //skin def

if soap.isElevated
	if SoapIsLargeMap(23)
	and (not shownNotif)
			v.drawString(soap.ftx, soap.fty, "Experiecing lag?",V_ALLOWLOWERCASE, "thin-center")
			v.drawString(soap.ftx, soap.fty+12, " Try disabling MobjThinkers with "+"\x86"+"soap_mobjthinkers ring_pull "+"\x80"+"to ease the lag.",V_ALLOWLOWERCASE, "thin-center")
			v.drawString(soap.ftx, (soap.fty+24), "\x86Press Custom1 to dismiss this message.",V_30TRANS|V_ALLOWLOWERCASE, "small-center")
			if p.cmd.buttons & BT_CUSTOM1
			and (not shownNotif)
				shownNotif = true
			end
	elseif not SoapIsLargeMap(234)
		shownNotif = false
	end
end

if gametype == GT_YELLOWDEMON
or SoapFetchConstant("soap_yellowdemon")
	v.drawString(160, 180, soap.YDcount,V_SNAPTOBOTTOM|V_ALLOWLOWERCASE|V_30TRANS|V_PERPLAYER, "thin-center")
end

//DEVMODE STUFF
if not soap.devmode
	return
end

if soap.nerfed
	v.drawString(100, 215, "Homing " + p.homing,V_70TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end


//pflag stuff
v.drawString(100, 56, "Player Flags (In order listed on wiki)",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
if p.pflags & PF_FLIPCAM
	v.drawString(100, 60, "\x83"+"FC",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(100, 60, "\x85"+"FC",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
if p.pflags & PF_ANALOGMODE
	v.drawString(108+2, 60, "\x83"+"AM",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(108+2, 60, "\x85"+"AM",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
if p.pflags & PF_DIRECTIONCHAR
	v.drawString(116+4, 60, "\x83"+"DC",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(116+4, 60, "\x85"+"DC",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
if p.pflags & PF_AUTOBRAKE
	v.drawString(124+6, 60, "\x83"+"AB",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(124+6, 60, "\x85"+"AB",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
if p.pflags & PF_GODMODE
	v.drawString(132+8, 60, "\x83"+"GM",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(132+8, 60, "\x85"+"GM",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
if p.pflags & PF_NOCLIP
	v.drawString(140+10, 60, "\x83"+"NC",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(140+10, 60, "\x85"+"NC",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
if p.pflags & PF_INVIS
	v.drawString(148+12, 60, "\x83"+"IN",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(148+12, 60, "\x85"+"IN",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
if p.pflags & PF_ATTACKDOWN
	v.drawString(156+14, 60, "\x83"+"AD",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(156+14, 60, "\x85"+"AD",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
if p.pflags & PF_SPINDOWN
	v.drawString(164+16, 60, "\x83"+"SD",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(164+16, 60, "\x85"+"SD",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
if p.pflags & PF_JUMPDOWN
	v.drawString(172+18, 60, "\x83"+"JD",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(172+18, 60, "\x85"+"JD",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
if p.pflags & PF_WPNDOWN
	v.drawString(180+20, 60, "\x83"+"WD",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(180+20, 60, "\x85"+"WD",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
if p.pflags & PF_STASIS
	v.drawString(188+22, 60, "\x83"+"SS",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(188+22, 60, "\x85"+"SS",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
if p.pflags & PF_JUMPSTASIS
	v.drawString(196+26, 60, "\x83"+"JS",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(196+26, 60, "\x85"+"JS",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
if p.pflags & PF_FULLSTASIS
	v.drawString(204+28, 60, "\x83"+"FS",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(204+28, 60, "\x85"+"FS",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
//new  line
if p.pflags & PF_APPLYAUTOBRAKE
	v.drawString(100, 64, "\x83"+"AA",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(100, 64, "\x85"+"AA",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
if p.pflags & PF_STARTJUMP
	v.drawString(108+2, 64, "\x83"+"SJ",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(108+2, 64, "\x85"+"SJ",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
if p.pflags & PF_JUMPED
	v.drawString(116+4, 64, "\x83"+"JU",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(116+4, 64, "\x85"+"JU",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
if p.pflags & PF_NOJUMPDAMAGE
	v.drawString(124+6, 64, "\x83"+"ND",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(124+6, 64, "\x85"+"ND",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
if p.pflags & PF_SPINNING
	v.drawString(132+8, 64, "\x83"+"SP",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(132+8, 64, "\x85"+"SP",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
if p.pflags & PF_STARTDASH
	v.drawString(140+10, 64, "\x83"+"ST",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(140+10, 64, "\x85"+"ST",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
if p.pflags & PF_THOKKED
	v.drawString(148+12, 64, "\x83"+"TH",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(148+12, 64, "\x85"+"TH",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
if p.pflags & PF_SHIELDABILITY
	v.drawString(156+14, 64, "\x83"+"SA",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(156+14, 64, "\x85"+"SA",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end
if p.pflags & PF_GLIDING
	v.drawString(164+16, 64, "\x83"+"GL",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
else
	v.drawString(164+16, 64, "\x85"+"GL",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
end

if p.soaptable
	//soap booleans
	v.drawString(100,68, "Soap Booleans (In order listed in init.lua)",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	if soap.isDash
		v.drawString(100, 72, "\x83"+"DA",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	else
		v.drawString(100, 72, "\x85"+"DA",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	end
	if soap.onGround
		v.drawString(108+2, 72, "\x83"+"OG",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	else
		v.drawString(108+2, 72, "\x85"+"OG",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	end
	if soap.isSoap
		v.drawString(116+4, 72, "\x83"+"IS",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	else
		v.drawString(116+4, 72, "\x85"+"IS",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	end
	if soap.isValid
		v.drawString(124+6, 72, "\x83"+"VA",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	else
		v.drawString(124+6, 72, "\x85"+"VA",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	end
	if soap.isIdle
		v.drawString(132+8, 72, "\x83"+"ID",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	else
		v.drawString(132+8, 72, "\x85"+"ID",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	end
	if soap.isXmo
		v.drawString(140+10, 72, "\x83"+"XM",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	else
		v.drawString(140+10, 72, "\x85"+"XM",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	end
	if soap.isXmoON
		v.drawString(148+12, 72, "\x83"+"XO",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	else
		v.drawString(148+12, 72, "\x85"+"XO",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	end
	if soap.isSuper
		v.drawString(156+14, 72, "\x83"+"SU",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	else
		v.drawString(156+14, 72, "\x85"+"SU",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	end
	if soap.isSuperM
		v.drawString(172+18, 72, "\x83"+"SM",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	else
		v.drawString(172+18, 72, "\x85"+"SM",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	end
	if soap.isElevated
		v.drawString(180+20, 72, "\x83"+"EL",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	else
		v.drawString(180+20, 72, "\x85"+"EL",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	end
	if soap.inPain
		v.drawString(188+22, 72, "\x83"+"PA",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	else
		v.drawString(188+22, 72, "\x85"+"PA",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	end
	if soap.canADash
		v.drawString(196+24, 72, "\x83"+"CA",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	else
		v.drawString(196+24, 72, "\x85"+"CA",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	end
	if soap.isSValid
		v.drawString(204+26, 72, "\x83"+"SV",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	else
		v.drawString(204+26, 72, "\x85"+"SV",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	end
	//new line
	if soap.noShield
		v.drawString(100, 76, "\x83"+"NS",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	else
		v.drawString(100, 76, "\x85"+"NS",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	end
	if soap.isSol
		v.drawString(108+2, 76, "\x83"+"SO",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	else
		v.drawString(108+2, 76, "\x85"+"SO",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	end
	if soap.isTransform
		v.drawString(116+4, 76, "\x83"+"TR",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	else
		v.drawString(116+4, 76, "\x85"+"TR",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	end
	if soap.isWatered
		v.drawString(124+6, 76, "\x83"+"WA",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	else
		v.drawString(124+6, 76, "\x85"+"WA",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	end
	if soap.isBoostm
		v.drawString(132+8, 76, "\x83"+"BM",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	else
		v.drawString(132+8, 76, "\x85"+"BM",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	end
	if soap.isGod
		v.drawString(140+10, 76, "\x83"+"GO",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	else
		v.drawString(140+10, 76, "\x85"+"GO",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	end
end



if soap.debugStats
	//for reference, (for me) 
	//i=ex1,ex2,ex3
	//ex1 to ex2, in steps of ex3
	for key, value in pairs(soap)
		v.drawString(205, 24+((#key*4)+value*4), key +" "+ value,V_70TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
	end
end
end)