//commands!!!!!
//let elevated people control if soap slips while recurling in battlemod!
//note to self: functions is different from cmds!!!!!

COM_AddCommand("soap_rolltrol", function(p) //can i add the soap local into this?
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
    end

    if p.soaptable.rolltrol
        p.soaptable.rolltrol = 0
        CONS_Printf(p, "\x8D"+"Soap now has less control when rolling!")
    else
        p.soaptable.rolltrol = 1
        CONS_Printf(p, "\x82"+"Soap now has more control when rolling!")
    end
	SoapSaveStuff(p)
end)

COM_AddCommand("soap_uncurl", function(p)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end

	if p.soaptable.isXmoON
		CONS_Printf(p,"\x85"+"You can't use this while XMomentum is turned on.")
        return
	end

    if p.soaptable.soapUncurl
 		p.soaptable.soapUncurl = 0
        CONS_Printf(p,"\x8D"+"Soap can no longer uncurl while spinning.")
    else
 		p.soaptable.soapUncurl = 1
        CONS_Printf(p,"\x82"+"Soap can now uncurl while spinning.")
    end
	SoapSaveStuff(p)
end)

COM_AddCommand("soap_momentum", function(p)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end

	if p.soaptable.isXmoON
		CONS_Printf(p,"\x85"+"You can't use this while XMomentum is turned on.")
        return
	end
	
	if p.mrce
		if p.mrce.physics
			CONS_Printf(p,"\x85"+"You can't use this while MRCE Momentum is turned on.")
		end
	end
	
	if CBW_Battle
		if CBW_Battle.BattleGametype()
			CONS_Printf(p,"\x85"+"You can't use this while in a BattleMod gametype.")
			return
		end
	end

    if p.soaptable.disableMomen
        p.soaptable.disableMomen = 0
		CONS_Printf(p,"\x82"+"Soap's momentum is now enabled.")
    else
        p.soaptable.disableMomen = 1
		CONS_Printf(p,"\x8D"+"Soap's momentum is now disabled.")
    end
	SoapSaveStuff(p)
end)

COM_AddCommand("soap_thehorror", function(p)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	if not netgame
		CONS_Printf(p,"\x85"+"You can't use this outside of a netgame.")
		return
	end	
	if not (gametype == GT_COOP)
		CONS_Printf(p,"\x85"+"You can only use this in co-op.")
		return
	end
	
	//i dont want people finishing with the invuln aposing gives you
	if not (p.pflags&PF_FINISHED)
        CONS_Printf(p, "\x85"+"You need to finish the level before you can use this.")
        return
	end
	
	if not LB_Soap_APosers[p.mo.skin]
		for k,v in pairs(LB_Soap_APosers)
			local color = "\x82"
			
			//what is this
			if k == "sonic"
			or k == "tails"
			or k == "knuckles"
			or k == "amy"
			or k == "fang"
			or k == "metalsonic"
			or k == "pointy"
			or k == "fluffy"
				color = "\x86"
			end
				
			CONS_Printf(p,color..tostring(k) )
		end
		CONS_Printf(p, "\x85"+"You aren't qualified to use this.")
		CONS_Printf(p, "\x85"+"View the above skins to see who is qualified.")
        return
	end		
		
    if p.soaptable.thehorror
        p.soaptable.thehorror = 0
		CONS_Printf(p,"\x8D"+"That sucked!")
    else
        p.soaptable.thehorror = 1
		CONS_Printf(p,"\x85"+"This sucks!")
    end
end)

//lets add some catagories!
COM_AddCommand("soap_help", function(p, arg)
	if not p.soaptable
		return
	end
	
	local soap = p.soaptable
	soap.ftkill = (1*TICRATE)
	if not p
	or not p.valid
		return
	end
    //so many prints!
/*		CONS_Printf(p, "\x88"+"Soap the Hedge "+"\x80"+"is a rad, fast, and powerful character!")
		CONS_Printf(p, "\x88"+"Soap "+"\x80"+"includes:")
		CONS_Printf(p,"     "+"\x84"+"Momentum "+"\x80"+"by CobaltBW")
		CONS_Printf(p,"     "+"\x84"+"Uncurl "+"\x80"+"by Krabs")
		CONS_Printf(p,"     "+"\x84"+"Spin Control (Rolltrol) "+"\x80"+"by Tempest97 (Krimps)")
		CONS_Printf(p,"     "+"\x84"+"Paper Peelout "+"\x80"+"by SuperPhanto")
		CONS_Printf(p,"     "+"\x84"+"Instaspin "+"\x80"+"from Icezer's "+"\x88"+"Crystal Sonic")
		CONS_Printf(p,"\n"+"\x88"+"Soap "+"\x80"+"has several commands for toggling different parts of him for different playstyles.")
		CONS_Printf(p,"There are also "+"\x82"+"secret "+"\x80"+"commands!")		
	//	CONS_Printf(p,"I feel like most of these commands are self-explanatory, so I won't explain them that much.")
		CONS_Printf(p,"     "+"\x86"+"soap_help "+"\x80"+": This is the command you are seeing right now.")
		CONS_Printf(p,"     "+"\x86"+"soap_debug "+"\x80"+": This spams your console with stats. Not very useful... at all.")
		CONS_Printf(p,"     "+"\x86"+"soap_momentum "+"\x80"+": Toggles "+"\x88"+"Soap's "+"\x80"+"momentum.")
		CONS_Printf(p,"     "+"\x86"+"soap_uncurl "+"\x80"+": Toggles uncurling for "+"\x88"+"Soap"+"\x80"+".")
		CONS_Printf(p,"     "+"\x86"+"soap_rolltrol "+"\x80"+": Toggles spin control (rolltrol) for "+"\x88"+"Soap"+"\x80"+".")
		CONS_Printf(p,"\n"+"I hope you have as much fun as I did making this little dude!")
	*/
	if not arg
		CONS_Printf(p, "\x88"+"Soap the Hedge "+"\x80"+"is a rad, fast, and powerful character!")
		CONS_Printf(p, "\x88"+"Soap "+"\x80"+"includes:")
		CONS_Printf(p,"     "+"\x84"+"Momentum "+"\x80"+"by CobaltBW")
		CONS_Printf(p,"     "+"\x84"+"Uncurl "+"\x80"+"from XMomentum")
		CONS_Printf(p,"     "+"\x84"+"Spin Control (Rolltrol) "+"\x80"+"by Tempest97 (Krimps)")
		CONS_Printf(p,"     "+"\x84"+"Paper Peelout "+"\x80"+"by SuperPhanto")
		CONS_Printf(p,"     "+"\x84"+"Instaspin "+"\x80"+"from Icezer's "+"\x88"+"Crystal Sonic")
		CONS_Printf(p,"\x86"+"Check out the MB page for more credits")
		CONS_Printf(p,"If you need instructions on how to get through the acts, check out the enclosed "+"\x86"+"tips "+"\x80"+"catagory.")
		CONS_Printf(p,"Insert one of the following catagories as an argument, like "+"\x86"+"soap_help <catagory>"+"\x80 to show either catagories.")
//		CONS_Printf(p,"To learn more about certain parts of "+"\x88"+"Soap"+"\x80"+", insert one of the following \ncatagories into the command, like "+"\x86"+"soap_help <catagory>"+"\x80.")
		CONS_Printf(p,"\x86"+"commands "+"\x80"+"Console commands!")
		CONS_Printf(p,"\x86"+"tips "+"\x80"+"Various tips & tricks!")
		CONS_Printf(p,"\x86"+" "+"\x80"+"")

	elseif arg == "commands"
		CONS_Printf(p,"\x88"+"Soap "+"\x80"+"has several commands for toggling different parts of him for different playstyles.")
		CONS_Printf(p,"There are also "+"\x82"+"secret "+"\x80"+"commands!")		
		CONS_Printf(p,"     "+"\x86"+"soap_help "+"\x80"+": This is the command you are seeing right now.")
	//	CONS_Printf(p,"     "+"\x86"+"soap_debug "+"\x80"+": This spams your console with stats. Not very useful... at all.")
		CONS_Printf(p,"     "+"\x86"+"soap_momentum "+"\x80"+": Toggles "+"\x88"+"Soap's "+"\x80"+"momentum.")
		CONS_Printf(p,"     "+"\x86"+"soap_uncurl "+"\x80"+": Toggles uncurling for "+"\x88"+"Soap"+"\x80"+".")
		CONS_Printf(p,"     "+"\x86"+"soap_rolltrol "+"\x80"+": Toggles spin control (rolltrol) for "+"\x88"+"Soap"+"\x80"+".")
		CONS_Printf(p,"Some commands toggle cosmetic changes for "+"\x88"+"Soap"+"\x80"+".")
		CONS_Printf(p,"     "+"\x86"+"soap_cos_glow "+"\x80"+": Toggles a glow effect for spin trails.")
		CONS_Printf(p,"     "+"\x86"+"soap_cos_trailstyle "+"\x80"+": Toggles between normal and ffoxD's spin trails.")
		CONS_Printf(p,"     "+"\x86"+"soap_cos_speedometer <int>"+"\x80"+": Toggles a speedometer on the HUD")
		CONS_Printf(p,"     "+"\x86"+"soap_cos_butter "+"\x80"+": Toggles slopes acting a little bit buttery while rolling on them.")
		CONS_Printf(p,"     "+"\x86"+"soap_cos_quakes "+"\x80"+": Toggles quakes caused by "+"\x88"+"Soap"+"\x80"+".")
		CONS_Printf(p,"     "+"\x86"+"soap_cos_flashes "+"\x80"+": Toggles flashes caused by "+"\x88"+"Soap"+"\x80"+".")
		CONS_Printf(p,"     "+"\x86"+"soap_cos_clocksound "+"\x80"+": Toggles Pizza Tower escape collectable sounds replacing your rings sounds.")
		CONS_Printf(p,"     "+"\x86"+"soap_cos_menu "+"\x80"+": Opens the cosmetics menu. You can only use this when next to an activated Starpost, except for admins.")
		CONS_Printf(p,"     "+"\x86"+"soap_file_wipe "+"\x80"+": Completely \resets\x80 your Soap config file.")
		CONS_Printf(p,"     "+"\x86"+"soap_file_save "+"\x80"+": Saves your current Soap Config file with your current settings at any time!")
		
		if soap.isElevated
		CONS_Printf(p,"\n"+"There are even admin-only commands for "+"\x88"+"Soap"+"\x80"+".")
		CONS_Printf(p,"     "+"\x86"+"[net] soap_cbwb_all_buff "+"\x80"+": Buffs all "+"\x88"+"Soaps"+"\x80"+" in BattleMod gametypes.")	
		CONS_Printf(p,"     "+"\x86"+"[net] soap_cbwb_allowcurl"+"\x80"+": Determines whether Soaps can recurl from springs in BattleMod gametypes.")
		CONS_Printf(p,"     "+"\x86"+"soap_cbwb_local_buff "+"\x80"+": Buffs you as "+"\x88"+"Soap"+"\x80"+" in BattleMod gametypes.")
//		CONS_Printf(p,"     "+"\x86"+" "+"\x80"+": ")
		CONS_Printf(p,"     "+"\x86"+"[net] soap_devmode <devmode flag>"+"\x80"+": Displays Player flags and Soap booleans for all people.")
		CONS_Printf(p,"     "+"\x86"+"[net] soap_mobjthinkers <string>"+"\x80"+": Toggles MobjThinkers. Useful if everyone is experiencing lag in large maps.")
		CONS_Printf(p,"     "+"\x86"+"[net] soap_yellowdemon "+"\x80"+": Soap-chasing rings will kill Soaps. Forced on in the Yellow Demon gametype.")
		CONS_Printf(p,"     "+"\x86"+"[net] soap_pvp_buff"+"\x80"+": Buffs Soaps in Poyo's PVP Gametype.")
		CONS_Printf(p,"     "+"\x86"+"[net] soap_blockmaps"+"\x80"+": Toggles blockmaps to help with performance.")
		CONS_Printf(p,"     "+"\x86"+"[net] soap_performance"+"\x80"+": Throttles certain effects to help with performance.")
		CONS_Printf(p,"     "+"\x86"+"[net] soap_friendlyfire"+"\x80"+": Determines whether Soaps can hurt other players with their moves.")
		CONS_Printf(p,"     "+"\x86"+"[net] soap_bananatoss"+"\x80"+": Determines whether non-admins can throw Banana Peels in Co-op.")
		CONS_Printf(p,"     "+"\x86"+"[net] soap_bananalimit"+"\x80"+": Sets amount of Banana Peels that are able to exist at once in a map.")

		if SoapFetchConstant("soap_devbuild")
		CONS_Printf(p,"     "+"\x86"+"soap_rawset_print "+"\x80"+": Prints all of the Soap Rawset.")		
		end
		CONS_Printf(p,"     "+"\x86"+"[net] soap_rawset_banana_clear "+"\x80"+": Clears all the Banana Peels on the map.")
		
		end
			
	elseif arg == "tips"
		CONS_Printf(p,"\x82"+"How to Play")
		CONS_Printf(p,"\x82"+"--Spin Specials")
		CONS_Printf(p,"\x82"+" -Uncurling: Press spin while rolling to uncurl!")
		CONS_Printf(p,"\x82"+" -Recurling: Press spin as you spring to recurl!")
		CONS_Printf(p,"\x82"+" -Airdash: Press spin as you thok to Airdash!")
		CONS_Printf(p,"\x82"+" -Bomb Dive Cancel: Press spin while diving to cancel it!")
		CONS_Printf(p,"\x82"+" -Bounce: Press spin while jumping to recoil off the ground!")
		
		CONS_Printf(p,"")
		
		CONS_Printf(p,"\x82"+"--Custom1 Actions")
		CONS_Printf(p,"\x82"+" -Bomb Dive: Press C1 midair to start dropping down like a bomb! This can nuke enemies and players!")
		CONS_Printf(p,"\x82"+" -Air Boost: Have C1 held down after Bomb Dive Canceling and before you fall to get a quick boost!")

		CONS_Printf(p,"\x82"+"--Custom2 Actions")
		CONS_Printf(p,"\x82"+" -Shield Ability: Press C2 to active your shield's ability!")

		CONS_Printf(p,"")
		 
		CONS_Printf(p,"\x82"+"--Dashmode")
		CONS_Printf(p,"\x82"+" -Building Dashmode: Running, uncurling, recurling and airdashing all give some Dashmode!")
		
		CONS_Printf(p,"\x82"+"\nAdditional Tips")
		CONS_Printf(p,"\x82"+"-Spamming uncurl gives you a small speed boost!")
		CONS_Printf(p,"\x82"+"-When in\x88 DashMode\x82,"+"\x88"+" Soap "+"\x82"+"can build even more DashMode!\n"..
							 " You can even enter \x83Mach 4 \x82if you keep running!")
		CONS_Printf(p,"\x82"+"-\x83Mach 4 \x82"+"makes you impervious to damage, and it emits red and green afterimages! Cool!")
		CONS_Printf(p,"\x82"+"-\x83Mach 4 \x82"+"wears off fast! Keep moving and airdashing to maintain it!")
		CONS_Printf(p,"\x82"+"-Collecting rings with \x83Mach 4 \x82"+"can maintain it!")
		CONS_Printf(p,"\x82"+"-When you get hurt, look for when you glow! You can jump out of pain if you are!")
		CONS_Printf(p,"\x82"+"-Skidding right off of solid ground is dangerous! Try not to do that.")
//		CONS_Printf(p,"\x82"+"-Some shields have special actions that can be triggered as you hold C3 as you Airdash!")
		CONS_Printf(p,"\x82"+"-Recurling right after bouncing off a spring gives you extra height, and a whole second's worth of\x88 DashMode\x82!")
		CONS_Printf(p,"\x82"+"-Cancelling your Bomb Dive won't let you dive again unless you touch a spring, the ground, or a carrier!")
		CONS_Printf(p,"\x82"+"-You can't bounce more than 8 times consecutively. You'll also lose height with each bounce!")
		
		CONS_Printf(p, "\n\n"+"Use PageUp or PageDown to navigate through this massive wall of text.")
		
		
	else
		CONS_Printf(p,"\x85"+"The catagory you entered does not exist! Please use one of the following:")
		CONS_Printf(p,"\x86"+"commands "+"\x80"+"Console commands!")
		CONS_Printf(p,"\x86"+"tips "+"\x80"+"Various tips & tricks!")
	//	CONS_Printf(p,"\x86"+" "+"\x80"+"")	
	end
end)

/*
COM_AddCommand("soap_debug", function(p)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	
	if p.soaptable.debugStats
		p.soaptable.debugStats = 0
        CONS_Printf(p,"\x82"+"Untoggled console spam.")	
	else
		p.soaptable.debugStats = 1
        CONS_Printf(p,"\x8D"+"Toggled console spam.")	
	end
end)
*/

//moved to main2.lua
/*
COM_AddCommand("soap_devmode", function(p, arg)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	
	if not p.soaptable.isElevated
        CONS_Printf(p, "\x85"+"You need to be the server host or an admin before you can use this.")
        return
	end
	

	if arg
	
	//just pretend this is indented
	if p.soaptable.devmode
		p.soaptable.devmode = 0
		CONS_Printf(p,"\x82"+"Soap Devmode Off.")
		if not netgame
			COM_BufInsertText(p, "devmode 0")
		end
	else
		p.soaptable.devmode = 1
		CONS_Printf(p,"\x82"+"Soap Devmode On.")	
	end

		if not netgame
			COM_BufInsertText(p, "devmode "..tonumber(arg))
		else
			CONS_Printf(p, "\x83"+"NOTICE:"+"\x80"+"DEVMODE will not be toggled in netgames.")
			return	
		end
	else
		CONS_Printf(p, "soap_devmode <devmode_flag> Toggles special devmode for Soap, plus regular devmode. You'll need to enter regular numbers (ex: 4095) for devmode.")
	end
end)
*/

COM_AddCommand("soap_cos_butter", function(p)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	
	if p.soaptable.cosbuttered
		p.soaptable.cosbuttered = 0
        CONS_Printf(p,"\x8D"+"Slopes now act normally.")	
	else
		p.soaptable.cosbuttered = 1
        CONS_Printf(p,"\x82"+"Slopes now feel a little buttery.")	
	end
	SoapSaveStuff(p)
end)


COM_AddCommand("soap_cos_speedometer", function(p, arg)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	
	local soap = p.soaptable
	local prevspeed = 0
	local argV

	if arg
		argV = tonumber(arg)
		prevspeed = soap.cosspeedometer
		soap.cosspeedometer = argV
		if not argV and not (argV == 0)
		or argV > 2
		or argV < 0
			soap.cosspeedometer = prevspeed
			CONS_Printf(p, "\x85"+"Value is too high or not a number! Please pick from a range of 0-2.")
			return
		end
		CONS_Printf(p, "Style set to "+"\x82"+argV+"\x80"+".")
		SoapSaveStuff(p)
	else
		CONS_Printf(p, "Shows a speedometer on the HUD as speed/normalspeed.")
		CONS_Printf(p, "This has 2 styles available:")
		CONS_Printf(p, "0: " + "Off") 
		CONS_Printf(p, "1: " + "Fracunit/Tic")
		CONS_Printf(p, "2: " + "Fracunit/Tic, but divided by FRACUNIT for human-readable values.") 
		CONS_Printf(p, "Current style is \x82" + soap.cosspeedometer+"\x80"+". Default is 2.") 
	end
end)


COM_AddCommand("soap_cos_glow", function(p)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	
	if p.soaptable.cosspinglow
		p.soaptable.cosspinglow = 0
        CONS_Printf(p,"\x8D"+"Spin trails no longer glow.")
	else
		p.soaptable.cosspinglow = 1
        CONS_Printf(p,"\x82"+"Spin trails now glow.")	
	end
	SoapSaveStuff(p)
end)

COM_AddCommand("soap_cos_trailstyle", function(p)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	
	if p.soaptable.costrailstyle == 1
		p.soaptable.costrailstyle = 2
        CONS_Printf(p,"\x82"+"Spin trails are now ffoxD's Smooth Spin Trail.")	
	else
		p.soaptable.costrailstyle = 1
        CONS_Printf(p,"\x82"+"Spin trails are now normal trails.")	
	end
	SoapSaveStuff(p)
end)

COM_AddCommand("soap_cos_quakes", function(p)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	
	if p.soaptable.cosquakes
		p.soaptable.cosquakes = 0
        CONS_Printf(p,"\x8D"+"Soap can no longer cause screen quakes.")	
	else
		p.soaptable.cosquakes = 1
        CONS_Printf(p,"\x82"+"Soap can now cause screen quakes.")	
	end
	SoapSaveStuff(p)
end)

COM_AddCommand("soap_cos_flashes", function(p)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	
	if p.soaptable.cosflashes
		p.soaptable.cosflashes = 0
        CONS_Printf(p,"\x8D"+"Soap can no longer cause screen flashes.")	
	else
		p.soaptable.cosflashes = 1
        CONS_Printf(p,"\x82"+"Soap can now cause screen flashes.")	
	end
	SoapSaveStuff(p)
end)

COM_AddCommand("soap_cos_clocksound", function(p)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	
	if p.soaptable.cosclocksound
		p.soaptable.cosclocksound = 0
        CONS_Printf(p,"\x8D"+"Collecting rings as Soap will now play the ring sound.")	
	else
		p.soaptable.cosclocksound = 1
        CONS_Printf(p,"\x82"+"Collecting rings as Soap will now play the Pizza Tower escape collectable sound")	
	end
	SoapSaveStuff(p)
end)

/*
COM_AddCommand("soap_pizzatowerstuff", function(p)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	
	if p.soaptable.pizzatowerstuff == 1
		p.soaptable.pizzatowerstuff = 0
        CONS_Printf(p,"\x8D"+"Disabled Combos and Ranks for you.")	
	else
		p.soaptable.pizzatowerstuff = 1
        CONS_Printf(p,"\x82"+"Enabled Combos and Ranks for you.")	
	end
	SoapSaveStuff(p)
end)
*/

COM_AddCommand("soap_cbwb_local_buff", function(p)
	if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	if not p.soaptable.isSoap
        CONS_Printf(p, "\x85"+"You need to be Soap before you can buff Soap!")
        return	
	end
	if not CBW_Battle
	or not CBW_Battle.BattleGametype()
//	or not p.soaptable.nerfed
    //    CONS_Printf(p, "\x85"+"Obviously you need something to nerf Soap before you can even buff him!")
		CONS_Printf(p, "\x85"+"Obviously you need BattleMod to nerf Soap before you can even buff him!")
        return	
	end	
	if not p.soaptable.isElevated
        CONS_Printf(p, "\x85"+"You need to be an admin or server host before you can use this!")
        return	
	end
	local soap = p.soaptable
	if not soap.nerfmebuff
		soap.nerfmebuff = 1
		CONS_Printf(p, "\x82"+"Soap's moveset for you is now that of indev2.1.4!")
	else
		soap.nerfmebuff = 0
		soap.nerfed = 1
		CONS_Printf(p, "\x8D"+"Soap's moveset for you is now that of indev3.0.p3!")
	end
end)

COM_AddCommand("soap_file_wipe", function(p, arg)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	
	if not p.soaptable.isIdle
        CONS_Printf(p, "\x85"+"You can't use this right now.")
        return
	end
	
	if arg
		if arg ~= p.name
			CONS_Printf(p, "\x85"+'Wrong name entered! Maybe check your spelling? \x86(soap_file_wipe "'+p.name+'")')
			return
		elseif arg == p.name
			SoapSaveStuff(p, true)
			p.soaptable = nil
			SoapInitTable(p, true)
		end
	else
        CONS_Printf(p, "\x85"+'Watch out! This reset your config file for Soap! To delete your config, type your name in quotations into the command. \x86(soap_file_wipe "'+p.name+'")')
		
	end
end)

COM_AddCommand("soap_file_save", function(p)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	
	SoapSaveStuff(p)
end)

COM_AddCommand("soap_file_load", function(p, type)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	
	/*
	if type == nil
        CONS_Printf(p, "\x86"+"This loads Soap's Config file! This comes with an argument. Valid arguments are listed below.")
        CONS_Printf(p, "\x86"+"reg - This loads the regular Config file.")
        CONS_Printf(p, "\x86"+"backup - This loads the Backup Config file. Use this if your Config has been lost!")
		return
	end
	*/
	
	SoapLoadStuff(p)
end)


COM_AddCommand("soap_cos_menu",function(p,silent)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	
	if ((not p.soaptable.cosmenucanopen) and (not p.soaptable.cosmenuopen) and (not p.soaptable.isElevated))
	or (p.soaptable.cosmenujustopened ~= 0)
	or (((p.soaptable.inPain) or ((not p.mo) and (not p.mo.valid)) or (p.playerstate == PST_DEAD)) and (not p.soaptable.isElevated))
//	or (p.soaptable.cosmenuopen)
	or (p.spectator)
		if not silent
			CONS_Printf(p, "\x85"+"You can't use this right now.")
		end
        return		
	end
	
	local soap = p.soaptable
	
	soap.cosmenujustopened = TICRATE/2
	
	if not soap.cosmenuopen
		MeSound(sfx_shudop,p)
		soap.cosmenuopen = 1
	else
		MeSound(sfx_shudcl,p)
		soap.cosmenuopen = 0
		//exiting the menu? lets reset the vars then
		soap.cosmenucurx = 0
		soap.cosmenucury = 0
		soap.cosmenuselect = 0
		soap.cosmenupage = 0
		
		p.pflags = $ & ~PF_FORCESTRAFE
	end
end)

//ADD NETVAR
//moved to main2.lua
/*
COM_AddCommand("soap_cbwb_all_buff", function(p)
	if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	if not p.soaptable.isSoap
        CONS_Printf(p, "\x85"+"You need to be Soap before you can buff Soap!")
        return	
	end
	if not CBW_Battle
	or not CBW_Battle.BattleGametype()
//	or not p.soaptable.nerfed
    //    CONS_Printf(p, "\x85"+"Obviously you need something to nerf Soap before you can even buff him!")
		CONS_Printf(p, "\x85"+"Obviously you need BattleMod to nerf Soap before you can even buff him!")
        return	
	end	
	if not p.soaptable.isElevated
        CONS_Printf(p, "\x85"+"You need to be an admin or server host before you can use this!")
        return	
	end
	local soap = p.soaptable
	if not soap.nerfbuff
		soap.nerfbuff = 1
		print("\x82"+"Soap's moveset is now that of indev2.1.4!")
	else
		soap.nerfbuff = 0
		soap.nerfed = 1
		print("\x8D"+"Soap's moveset is now that of indev3.0.p3!")
	end
end)
*/

/*
COM_AddCommand("bblx", function(p, arg)
	if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	if not p.soaptable.devmode
        CONS_Printf(p, "\x85"+"You need Soap's DEVMODE for this.")
        return
	end

	local soap = p.soaptable
	
	if arg
		soap.bblx = arg
		SoapSaveStuff(p)
	else
		CONS_Printf(p,soap.bblx)
	end
end)

COM_AddCommand("bbly", function(p, arg)
	if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	if not p.soaptable.devmode
        CONS_Printf(p, "\x85"+"You need Soap's DEVMODE for this.")
        return
	end

	local soap = p.soaptable
	
	if arg
		soap.bbly = arg
		SoapSaveStuff(p)
	else
		CONS_Printf(p,soap.bbly)
	end
end)
*/

COM_AddCommand("ftx", function(p, arg)
	if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	if not p.soaptable.devmode
        CONS_Printf(p, "\x85"+"You need Soap's DEVMODE for this.")
        return
	end

	local soap = p.soaptable
	
	if arg
		soap.ftx = arg
		SoapSaveStuff(p)
	else
		CONS_Printf(p,soap.ftx)
	end
end)

COM_AddCommand("fty", function(p, arg)
	if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	if not p.soaptable.devmode
        CONS_Printf(p, "\x85"+"You need Soap's DEVMODE for this.")
        return
	end

	local soap = p.soaptable
	
	if arg
		soap.fty = arg
		SoapSaveStuff(p)
	else
		CONS_Printf(p,soap.fty)
	end
end)
/*
COM_AddCommand("bombxd", function(p, arg)
	if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	if not p.soaptable.devmode
        CONS_Printf(p, "\x85"+"You need Soap's DEVMODE for this.")
        return
	end

	local soap = p.soaptable
	
	if arg
		soap.bombxd = arg
		SoapSaveStuff(p)
	else
		CONS_Printf(p,soap.bombxd)
	end
end)

COM_AddCommand("bombyd", function(p, arg)
	if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	if not p.soaptable.devmode
        CONS_Printf(p, "\x85"+"You need Soap's DEVMODE for this.")
        return
	end

	local soap = p.soaptable
	
	if arg
		soap.bombyd = arg
		SoapSaveStuff(p)
	else
		CONS_Printf(p,soap.bombyd)
	end
end)
*/

print("\x82Successfully initialized\x86 cmds.lua")
print("\x86Now loading SOC stuff...")

/*
local soapbattlerecurl = false

COM_AddCommand("soap_battlerecurl", function(p, network)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end

	if not CBW_Battle
		CONS_Printf(p,"\x85"+"You can't use this if BattleMod isn't loaded.")
		return
	end
	
	if not p.soaptable.isElevated
		CONS_Printf(p,"\x85"+"You can't use this if you're not the server or server admin.")
		return
	end
	
	local CBWrec = false //CBW battle recurl
	if not CBWrec
		CBWrec = true
		//print so everyone can know
		print("\x8D"+"Soap will no longer slip when recurling in a BattleMod gametype.")
	else
		CBWrec = false
		print("\x82"+"Soap will now slip when recurling in a BattleMod gametype.")
	end
end)

//how do i do a netvar?
addHook("NetVars", function(network)
	soapbattlerecurl = CBWrec
	soapbattlerecurl = network(soapbattlerecurl)
end)

*/