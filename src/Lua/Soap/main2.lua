//main rewrite!!
//get rid of all that spaghetti code!
//note to self: mobjs have health too! not just players!

//id totally pay someone if they were to fix all of this for me

//hey, be honest, how much if you actually codedive?

//more like lasnagea code
//haheha

//fun fact: srb2 multiplies momz values with 117*FRACUNIT/200 underwater!

//awesome thanks!
/*
	Sonic - my friend who coded up sol form stuff
	the people on the SRB2 discord - for being awesome and helping me with lua stuff
	and you - for choosing to play as this little fella
	
	
*/

/*
	CODE TODO-------
	-[done]remove all of the playerme.iterates
	-[done]fix spin not working in netgames
	-[done?]fix speed boost on other skins in netgames
	-[done]taunts fullstasis every other soap (also in netgames)
	-[done]fix taunts not working at higher player counts (yet again in netgames)
	-[done]fix mrce still breaking soap normalspeed
	-[done]fix normalspeed not adjusting when switching to soap for the first time. mrce bug?
	  idk, i have noticed that this happens with that fieldtest dev rewrite build thing i sent
	  sonic, and thats a pretty old version. still will need to check nonetheless
	-mama luigi civ posing!
	-possible resynchs? idk, might just be that one guy
	-[done]clean up and fix ghosts and actions that use ghosts
	-[done]fix shields interfering with airdashing
	-[done]fix spinning
	-[done]implement shield bonuses when airdashing
	-[done?]maybe modify some stuff with battlemod nerf?
	-[done]fix up airdashing (again)
	-[done]fix soap transforming as you airdash
	-{scrapped}fix hud not being beside the crosshair on resolutions that arent 1600x900
	-[done]fix forced strafing when air uncurling or jumping out of pain
	-{scrapped}scale pt afterimages with speed
	-[done]jump strecthing with gravflip
	-[done]diving not going up with gravflip
	-[done]2.2.11!! P_TeleportMove is deprecated in there, and a thok trail is always brighter and more opaque than the others
	-[done]move NetVars hook here, and make netvars locals!
	-[done]fix ring sparks flickering after being collected
	-[done]ring pull optimizations
	-[done]make ring pull into blockmap funcs. to lower lag even more
	-[done]hud "Experiencing lag? Try disabling soap_mobjthinkers..." when lag in big maps from ring pull
	-[done]clean up dead bodies (delete bodies who's owners have since left)
	-[done, although somewhat sloppily]fix NiGHTS weird camera
	-[done?]make mach4 kill radius bigger
	-[done]fix elemental use + bomb dive infini-climb
	-[done]align speedometer to the right side of screen. not everyone uses 1600x900!
	-[done]work on the stuff in the fla!!!
	-[done]maybe rewrite the dive stuff?
	-[done]netvar toggles for effects and blockmaps
	-redo super buffs + add some neat effects
	-[done]replace all cos buttons with the shiny new drawonoffcosbar function
	  also, make one of those for stuff like the speedometer, and make
	  them rawsets. make the hud constants used in those SoapConstants,
	  so i can fetch em
	-[done]make the grounded bounce cancel a bit more 
	-[done?]fix whirlwind activating when it shouldnt
	-[done]make springs cancel airdash momzfreeze
	-[done]make dive reset when sprung
	-[done?]rushchars likes to break super for some reason, so gonna need to fix
	-[done]do pointy fly for soap
	-[done]do enemy bouncing
	-[done]make player followmobjs align with banana peeled players' rollangle
	-fix carries interupting banana peeling
	-implement personal banana lists (banana lists per player)
	-coyote time?
	-[done]chaos mode super taunts
	-banana limit in admin panel
	-[done]make bounce work in goop
	-[done]ASS BLAST
	-[done]bounce off the ground 1 in banana peeled
	-[done]move up c3 hud button even if c2 isnt drawn
	-[done]make aposing sorta like solchars
	-sms-like grabbing while super?
	-[done]make breakdancing boombox restricted before posting
	-[done]oneshot for desuper for tunes
	-[done]table of spriteoffsets for super taunts
	-[done]redo power springs
	-{scrapped}add fireass
	-[done]break solids at mach 4 (only if netvar on)
	-[done]use prev table for supertaunts
	-{scrapped}Make soaptable work with older builds
	-[done]port the other buttons to the new funcs in the menu drawer
	-[done]update soap_help to include the new commands
	-[done]add backup config file
	-[done]Remove shields with Super Taunts
	-OPTIMIZATION!!!!!!!!!
	-[done]test out combo stuff?
	-{scrapped}random crits on bosses?
	-[done??]only let SoapLoadStuff use soap_load
	-make starpostpoints, for levelstartscore
	-[done]prevent jumping with JumpSpecial while in certain states
	-update file wipe to fit the new args
	-{scrapped?}mock starposts for record attack
	-completely remove spawn table stuff
	-remove flytoggle when unsupered
	-yet another rewrite lol (yar soap)
	
	GMT_ TODO-------
	-[done???]the death i deseriolioiio jingle (P_PlayJingleMusic(p, "songnm", 0, true, JT_MASTER)
	-[done]your fat ass slows you down P_PlayJingleMusic(p, "songnm", 0, true, GT_GOVER)
	
	ANIM TODO-------
	-maybe change WAITB2B8's legs? i switched the legs on B8, and im too lazy
	to change it
	-update EDGE animme. just a lazy trace of sonic's, still not sure what to draw
	-make super variation of TRNS, wont ever be used in the near future though
	-[scrapped]laugh sprites!!
	-[done]freefall sprites!!
	-{scrapped}maybe finish FKIK?? idk, need to see if milnekicking works now
	-[done]WALK ANIMATIONS!!!!!!!!!!!!
	-[done]roll sprites!
	-[done?]spindash?
	-[done]civ poses (not for vanilla chars though)
	-[done]peel sprites?
	-airdash sprites
	-super sprites lmao i aint ever doin those
	-[done]super taunts?
	-[done]ASS BLAST
*/
//lb for luigi budd
local lb = LB_Soap

//netvars
//////stuff the cosmenu can change
local soap_devmode = 0
local soap_allbuff = 0
local soap_nerfcurl = 0
////these are grouped as 1
local soap_ringpull = true
local soap_boosterboost = 1
//
local soap_blockmapsallowed = 1
local soap_yellowdemon = false
local soap_pvpnerf = true
local soap_performance = false
local soap_largemap = false
local soap_friendlyfire = true //extra friendlyfire for soaps
local soap_bananatoss = true
local soap_bananalimit = 100
local soap_isspecialstage = 0
local soap_inbossmap = false
local soap_numberoftokens = 0
local soap_collectedtokens = 0
local soap_numberofstarposts = 0
///////

--RELEASE
local soap_devbuild = true
//

//behold!! real soap constants!!
local RING_PULL = 155
local RING_FUSE = 1 //lost soap-chasing ring fuse. this gets mutliplied by TICRATE when used!
local DIVE_START = 12
local BANANA_BOUNCE = 1
local SUPERTAUNT_RINGSLEFT = 85
local SUPERTAUNT_KILLSLEFT = 25
local SUPERTAUNT_FRAGSLEFT = 10
local ASSBLAST_CHANCE = FRACUNIT/13
local SUPERTAUNTS_LENGTH = 10
local SUPERTAUNTS_MULTI = 2
local AFTERIMAGES_FUSE = 3
local COMBO_MAXTIME = 7*TICRATE

//st as in super taunt
//local AFTERIMAGES_ST_FUSE = 2*TICRATE

////////////////////
rawset(_G, "SoapIsLargeMap", function(dummy)
	return soap_largemap
end)
rawset(_G, "SoapMobjThinkerAllowed", function(thinka)
	if string.lower(thinka) == "ring_pull"
		return soap_ringpull
	elseif string.lower(thinka) == "booster_boost"
		return soap_boosterboost
	else
		error("Invalid argument inserted into SoapMobjThinkerAllowed. ("+string.lower(thinka)+")", 2)
		return
	end
end)

rawset(_G, "SoapFetchConstant", function(cons)
	local const = tostring(cons)
	const = string.lower(const)
	
	if const == "ring_pull"
		return RING_PULL
	elseif const == "ring_fuse"
		return RING_FUSE
	elseif const == "dive_start"
		return DIVE_START
	elseif const == "banana_bounce"
		return BANANA_BOUNCE
	elseif const == "supertaunt_ringsleft"
		return SUPERTAUNT_RINGSLEFT
	elseif const == "supertaunt_killsleft"
		return SUPERTAUNT_KILLSLEFT	
	elseif const == "supertaunt_fragsleft"
		return SUPERTAUNT_FRAGSLEFT
	elseif const == "supertaunts_length"
		return SUPERTAUNTS_LENGTH
	elseif const == "supertaunts_multi"
		return SUPERTAUNTS_MULTI
	elseif const == "afterimages_fuse"
		return AFTERIMAGES_FUSE
	elseif const == "assblast_chance"
		return ASSBLAST_CHANCE
	elseif const == "combo_maxtime"
		return COMBO_MAXTIME
//	elseif const == "afterimages_st_fuse"
//		return AFTERIMAGES_ST_FUSE
		
	//non-constants
	elseif const == "soap_devmode"
		return soap_devmode
	elseif const == "soap_allbuff"
		return soap_allbuff
	elseif const == "soap_nerfcurl"
		return soap_nerfcurl
	elseif const == "soap_yellowdemon"
		return soap_yellowdemon
	elseif const == "soap_devbuild"
		return soap_devbuild
	elseif const == "soap_pvpnerf"
		return soap_pvpnerf
	elseif const == "soap_performance"
		return soap_performance
	elseif const == "soap_blockmapsallowed"
		return soap_blockmapsallowed
	elseif const == "soap_friendlyfire"
		return soap_friendlyfire
	elseif const == "soap_bananatoss"
		return soap_bananatoss
	elseif const == "soap_bananalimit"
		return soap_bananalimit
	elseif const == "soap_isspecialstage"
		return soap_isspecialstage
	elseif const == "soap_inbossmap"
		return soap_inbossmap
	elseif const == "soap_numberoftokens"
		return soap_numberoftokens
	elseif const == "soap_collectedtokens"
		return soap_collectedtokens
	elseif const == "soap_numberofstarposts"
		return soap_numberofstarposts	
	else
		error("Invalid argument inserted into SoapFetchConstant. ("+cons+")", 2)
		return
	end
end)

rawset(_G, "prtable", function(text, t, prefix, cycles)
    prefix = $ or ""
    cycles = $ or {}

    print(prefix..text.." = {")

    for k, v in pairs(t)
        if type(v) == "table"
            if cycles[v]
                print(prefix.."    "..tostring(k).." = "..tostring(v))
            else
                cycles[v] = true
                prtable(k, v, prefix.."    ", cycles)
            end
        elseif type(v) == "string"
            print(prefix.."    "..tostring(k)..' = "'..v..'"')
        else
			if type(v) == "userdata" and v.valid and v.name
				v = v.name
			end
            print(prefix.."    "..tostring(k).." = "..tostring(v))
        end
    end

	print(prefix.."}")
end)
local function addpoint(p,me,soap)
	if not p.exiting return end
	
	S_StartSound(me,sfx_chchng)
	
	P_AddPlayerScore(p, 100)
	local plus100 = P_SpawnMobjFromMobj(me, 0, 0, 50*me.scale, MT_SOAPPLUS100TEXT)
	plus100.timealive = 1
	plus100.scale = (3*FRACUNIT/4)
	if (not (gametyperules & GTR_FRIENDLY))
		plus100.color = p.skincolor
	else
		plus100.color = SKINCOLOR_WHITE
	end
end

//SUPER TAUNT definitions
states[S_PLAY_SOAP_ASSBLAST] = {
	sprite = SPR_PLAY,
	frame = SPR2_STAB|FF_ANIMATE,
	var1 = 10,
	var2 = 2,
	tics = SoapFetchConstant("supertaunts_length")*SoapFetchConstant("supertaunts_multi"),
	nextstate = S_PLAY_STND,
}
states[S_PLAY_SOAP_SUPERTAUNT1] = {
	sprite = SPR_PLAY,
	frame = SPR2_SSTA|FF_ANIMATE,
	var1 = 10,
	var2 = 2,
	tics = SoapFetchConstant("supertaunts_length")*SoapFetchConstant("supertaunts_multi"),
	nextstate = S_PLAY_STND,
}
states[S_PLAY_SOAP_SUPERTAUNT2] = {
	sprite = SPR_PLAY,
	frame = SPR2_SSTB|FF_ANIMATE,
	var1 = 10,
	var2 = 2,
	tics = SoapFetchConstant("supertaunts_length")*SoapFetchConstant("supertaunts_multi"),
	nextstate = S_PLAY_STND,
}
states[S_PLAY_SOAP_SUPERTAUNT3] = {
	sprite = SPR_PLAY,
	frame = SPR2_SSTC|FF_ANIMATE,
	var1 = 10,
	var2 = 2,
	tics = SoapFetchConstant("supertaunts_length")*SoapFetchConstant("supertaunts_multi"),
	nextstate = S_PLAY_STND,
}


////////////////////

addHook("NetVars", function(net)
	LB_Soap = net(LB_Soap)
	LB_Soap_APosers = net(LB_Soap_APosers)
	soap_devmode = net(soap_devmode)
	soap_allbuff = net(soap_allbuff)
	soap_nerfcurl = net(soap_nerfcurl)
	soap_ringpull = net(soap_ringpull)
	soap_boosterboost = net(soap_boosterboost)
	soap_blockmapsallowed = net(soap_blockmapsallowed)
	soap_largemap = net(soap_largemap)
	soap_devbuild = net(soap_devbuild)
	soap_yellowdemon = net(soap_yellowdemon)
	soap_pvpnerf = net(soap_pvpnerf)
	soap_performance = net(soap_performance)
	soap_friendlyfire = net(soap_friendlyfire)
	soap_bananatoss = net(soap_bananatoss)
	soap_bananalimit = net(soap_bananalimit)
	soap_isspecialstage = net(soap_isspecialstage)
	soap_inbossmap = net(soap_inbossmap)
	soap_numberoftokens = net(soap_numberoftokens)
	soap_collectedtokens = net(soap_collectedtokens)
	soap_numberofstarposts = net(soap_numberofstarposts)
end)

//i couldve used this :/
addHook("MapChange", function(mapnum)
	soap_numberoftokens = 0
	soap_collectedtokens = 0
	
	for p in players.iterate
		if p.starpostnum == 0
		and mapnum ~= p.soaptable.lastmap
			p.soaptable.combodropped = false
			p.soaptable.levelstartscore = p.score
			p.soaptable.lastrank = 1
			p.soaptable.timeshurt = 0
			p.soaptable.hitboss = false
		end
	end
	
end)
addHook("MapThingSpawn", function(mo,mt)
	soap_numberoftokens = $+1
end, MT_TOKEN)
addHook("MobjSpawn", function(mo)
	soap_numberofstarposts = $+1
end, MT_STARPOST)

addHook("MobjDeath", function(target,inflict,source)
	soap_collectedtokens = $+1
	if (netgame or splitscreen)
	
		if source.player

			for i = 0, 10
				SoapAddToCombo(source.player,source.player.soaptable,false)
			end
			
			for p in players.iterate
				
				//refill every soap's combo bar
				if p.mo.skin == "soapthehedge"
				and p.soaptable.combocount
				
					for i = 0, 10
						SoapAddToCombo(p,p.soaptable,false)
					end
					
				end
				
			end
		
		end
		
	else
	
		for i = 0, 10
			SoapAddToCombo(source.player,source.player.soaptable,false)
		end
		
	end
end, MT_TOKEN)

addHook("MapLoad", function(mapnum)
	lb.bananalist = {}

	soap_largemap = false
	soap_isspecialstage = G_IsSpecialStage(mapnum)
	soap_inbossmap = false
	
	//this is kinda hardware-dependant :/
	if #mapthings >= 2640
		soap_largemap = true
	end
		
	//toggle yellowdemon
	if gametype == GT_YELLOWDEMON
		if not soap_yellowdemon
			soap_yellowdemon = true
			print("\x8D"+"Yellow Demon has been turned \x85ON!\x8D Collecting Soap-chasing rings will now kill you.")
			if not soap_ringpull
				print("\x8D"+"Ring Pull has been toggled back \x85ON!")
				soap_ringpull = true
			end
			
		end
		S_StartSound(nil, sfx_yeldea)
	end
	
	//so singleplayer, right?
	if ((gametype == GT_COOP) and (not (netgame and splitscreen)))
		
		for p in players.iterate
			p.soaptable.combodropped = false
		end

	end
	
	if netgame
		for p in players.iterate
			
			if mapnum == p.soaptable.lastmap
			and p.starpostnum == 0
				p.soaptable.levelstartscore = p.score
			end
			
		end
	end
end)

//disable yd if we're in a bossstage
addHook("BossThinker", function(mo)
	//EXCEPT for eggrock 2...,
	if gamemap ~= 23
		
		if soap_yellowdemon
		and not soap_inbossmap
			print("\x82"+"Yellow Demon has been turned \x83OFF!\x82 Soap-chasing rings are now safe to collect.")
		end
		
		soap_inbossmap = true
		
		soap_yellowdemon = false
		
	end
end)

//we'll want to reset some stuff when we spawn
addHook("PlayerSpawn", function(p)
	if p.mo and p.mo.health and p.mo.valid and p.soaptable
		local me = p.mo
		local soap = p.soaptable
		if p.mo.skin == "soapthehedge"
			SoapResetBounceAndDiveVars(p, me, soap)
			if soap.forcefield
			and soap.forcefield.valid
				P_RemoveMobj(soap.forcefield)
			end
			soap.forcefield = 0
			me.spritexscale = FRACUNIT
			me.spriteyscale = FRACUNIT
			
			soap.YDcount = 0
			soap.cosmenuopen = 0
			soap.cosmenuwait = 0
		end
		
		soap.supertauntringsleft = SoapFetchConstant("supertaunt_ringsleft")
		soap.supertauntkillsleft = SoapFetchConstant("supertaunt_killsleft")
		soap.supertauntfragsleft = SoapFetchConstant("supertaunt_fragsleft")
		soap.supertauntready = 0
		soap.supertaunttimer = -1
		
		soap.bananapeeled = 0
		soap.bananaskid = 0
		soap.bananatime = 0
		
		SoapResetComboVars(soap)
		
		//ok, so we're playing singleplayer?
		if ((gametype == GT_COOP) and (not netgame))
			//give spawn invuln with yd!
			if SoapFetchConstant("soap_yellowdemon")
				p.powers[pw_invulnerability] = 3*TICRATE
			end
		end
	end
end)
////////////////////
COM_AddCommand("soap_rawset_print", function(p)
	if not ((p == server) or (p == admin) or IsPlayerAdmin(p))
	or not SoapFetchConstant("soap_devbuild")
		CONS_Printf(p, "\x86"+"\"LB_Soap\" is currently "+LB_Soap+".")
        return
	end
/*
	if not SoapFetchConstant("soap_devmode")
        CONS_Printf(p, "\x85"+"You need Soap's DEVMODE for this.")
        return
	end
*/

	prtable("Soap Rawset",lb)

end)

COM_AddCommand("soap_rawset_banana_clear", function(p)
	if not ((p == server) or (p == admin) or IsPlayerAdmin(p))
		CONS_Printf(p, "\x85You need to be an admin to clear Banana Peels.")
        return
	end
/*
	if not SoapFetchConstant("soap_devmode")
        CONS_Printf(p, "\x85"+"You need Soap's DEVMODE for this.")
        return
	end
*/	

	//is this 0-indexed or not? TELL ME GAME!!!!
	//lua lists are always indexed from 1, silly
    for b = 1, #lb.bananalist
		if lb.bananalist[b] == nil
			continue
		end
		//lb.bananalist[b].soapCommandKilled = true
		P_RemoveMobj(lb.bananalist[b])
//		table.remove(lb.bananalist,b)
	end
	lb.bananalist = {}
	p.soaptable.cosusedlimitbefore = 1
	print("\x82".."Cleared Bananas")
	
end)

//move soap_devmode and soap_cbwb_all_buff here so they can access netvars
COM_AddCommand("soap_devmode", function(p, arg)
//    if not p or not p.soaptable or not p.valid
//       CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
//       return
//	end
	
//	if not p.soaptable.isElevated
	if not ((p == server) or (p == admin) or IsPlayerAdmin(p))
    //    CONS_Printf(p, "\x85"+"You need to be the server host or an admin before you can use this.")
		CONS_Printf(p, "\x86"+"\"soap_devmode\" is currently "+SoapFetchConstant("soap_devmode")+".")
        return
	end
	

	if arg
	
	//just pretend this is indented
	if soap_devmode
		soap_devmode = 0
		print("\x82"+"Soap Devmode Off.")
		if not netgame
			COM_BufInsertText(p, "devmode 0")
		end
	else
		soap_devmode = 1
		print("\x82"+"Soap Devmode On.")	
	end
	/////
	
		if not netgame
			COM_BufInsertText(p, "devmode "..tonumber(arg))
		else
			CONS_Printf(p, "\x83"+"NOTICE:"+"\x80"+" DEVMODE will not be toggled in netgames.")
			return	
		end
	else
		CONS_Printf(p, "soap_devmode <devmode_flag> Toggles special devmode for Soap, plus regular devmode. You'll need to enter regular numbers (ex: 4095) for devmode.")
	end
end)
COM_AddCommand("soap_blockmaps", function(p)
//    if not p or not p.soaptable or not p.valid
//       CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
//       return
//	end
	
//	if not p.soaptable.isElevated
	if not ((p == server) or (p == admin) or IsPlayerAdmin(p))
    //    CONS_Printf(p, "\x85"+"You need to be the server host or an admin before you can use this.")
		CONS_Printf(p, "\x86"+"\"soap_blockmapsallowed\" is currently "+SoapFetchConstant("soap_blockmapsallowed")+".")
        return
	end
	
	if soap_blockmapsallowed
		soap_blockmapsallowed = 0
		print("\x8D"+"Certain blockmap functions have now been disabled to improve performance.")
	else
		soap_blockmapsallowed = 1
		print("\x82"+"Certain blockmap functions have now been enabled to decrease performance.")
	end
end)
COM_AddCommand("soap_performance", function(p)
//    if not p or not p.soaptable or not p.valid
//       CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
//       return
//	end
	
//	if not p.soaptable.isElevated
	if not ((p == server) or (p == admin) or IsPlayerAdmin(p))
    //    CONS_Printf(p, "\x85"+"You need to be the server host or an admin before you can use this.")
		CONS_Printf(p, "\x86"+"\"soap_performance\" is currently "+SoapFetchConstant("soap_performance")+".")
        return
	end
	
	if soap_performance
		soap_performance = false
		
		print("\x82"+"Certain effects have now been reenabled.")
	else
		soap_performance = true
		print("\x8D"+"Certain effects have been throttled to increase performance.")
	end
end)
COM_AddCommand("soap_friendlyfire", function(p)
	if not ((p == server) or (p == admin) or IsPlayerAdmin(p))
		CONS_Printf(p, "\x86"+"\"soap_friendlyfire\" is currently "+SoapFetchConstant("soap_friendlyfire")+".")
        return
	end
	
	if soap_friendlyfire
		soap_friendlyfire = false
		
		print("\x8D"+"Soaps can no longer harm other players with their moves.")
	else
		soap_friendlyfire = true
		print("\x82"+"Soaps can now harm other players with their moves.")
	end
end)
COM_AddCommand("soap_bananatoss", function(p)
	if not ((p == server) or (p == admin) or IsPlayerAdmin(p))
		CONS_Printf(p, "\x86"+"\"soap_bananatoss\" is currently "+SoapFetchConstant("soap_bananatoss")+".")
        return
	end
	
	if soap_bananatoss
		soap_bananatoss = false
		
		print("\x8D"+"Non-admins can no longer sling bananas in Co-op.")
	else
		soap_bananatoss = true
		print("\x82"+"Non-admins can now sling bananas in Co-op.")
	end
end)


//green demon almost
COM_AddCommand("soap_yellowdemon", function(p)
    if not p or not p.soaptable or not p.valid
//        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        CONS_Printf(p, "\x86"+"\"soap_yellowdemon\" is currently "+SoapFetchConstant("soap_yellowdemon")+".")
		return
    end
	
	//howd i forget tthis??
	if not p.soaptable.isElevated
//        CONS_Printf(p, "\x85"+"You need to be an admin or server host before you can use this!")
        CONS_Printf(p, "\x86"+"\"soap_yellowdemon\" is currently "+SoapFetchConstant("soap_yellowdemon")+".")
		return	
	end

	if soap_inbossmap
		CONS_Printf(p, "\x85You can't use this right now.")
		return
	end
	
	if gametype == GT_YELLOWDEMON
        CONS_Printf(p, "\x85"+"You can't disable this right now.")
        return
    end		
		
    if soap_yellowdemon
        soap_yellowdemon = false
        print("\x82"+"Yellow Demon has been turned \x83OFF!\x82 Soap-chasing rings are now safe to collect.")
    else
        soap_yellowdemon = true
		print("\x8D"+"Yellow Demon has been turned \x85ON!\x8D Collecting Soap-chasing rings will now kill you.")
		if not soap_ringpull
			print("\x82"+"But you are safe for now, as ring pull is disabled!")
		end
		S_StartSound(nil, sfx_yeldea)
	end
end)
COM_AddCommand("soap_cbwb_all_buff", function(p)
	if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
//	if not p.soaptable.isSoap
//       CONS_Printf(p, "\x85"+"You need to be Soap before you can buff Soap!")
//        return	
//	end
	if not p.soaptable.isElevated
//        CONS_Printf(p, "\x85"+"You need to be an admin or server host before you can use this!")
        CONS_Printf(p, "\x86"+"\"soap_allbuff\" is currently "+SoapFetchConstant("soap_allbuff")+".")
		return	
	end
	if not CBW_Battle
	or not CBW_Battle.BattleGametype()
//	or not p.soaptable.nerfed
    //    CONS_Printf(p, "\x85"+"Obviously you need something to nerf Soap before you can even buff him!")
		CONS_Printf(p, "\x85"+"Obviously you need BattleMod to nerf Soap before you can even buff him!")
        return	
	end	
	local soap = p.soaptable
	if not soap_allbuff
		soap_allbuff = 1
		print("\x82"+"All Soaps' movesets are now that of indev2.1.4!")
	else
		soap_allbuff = 0
		soap.nerfed = 1
		print("\x8D"+"All Soaps' movesets are now nerfed!")
	end
end)
//poyos pvp gt
COM_AddCommand("soap_pvp_buff", function(p)
	if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
//	if not p.soaptable.isSoap
//        CONS_Printf(p, "\x85"+"You need to be Soap before you can buff Soap!")
//        return	
//	end
	if gametype ~= GT_PVP
		CONS_Printf(p, "\x85"+"You need Poyo's PVP Gametype to nerf Soap before you can buff him!")
        return	
	end	
	if not p.soaptable.isElevated
//        CONS_Printf(p, "\x85"+"You need to be an admin or server host before you can use this!")
        CONS_Printf(p, "\x86"+"\"soap_pvpnerf\" is currently "+SoapFetchConstant("soap_pvpnerf")+".")
		return	
	end
	local soap = p.soaptable
	if not soap_pvpnerf
		soap_pvpnerf = true
		print("\x8D"+"Soaps have now been nerfed!")
	else
		soap_pvpnerf = false
		print("\x82"+"Soaps now act and behave normally!")
	end
end)

COM_AddCommand("soap_cbwb_allowcurl", function(p)
	if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
//	if not p.soaptable.isSoap
//        CONS_Printf(p, "\x85"+"You need to be Soap before you can buff Soap!")
//       return	
//	end
	if not p.soaptable.isElevated
//        CONS_Printf(p, "\x85"+"You need to be an admin or server host before you can use this!")
        CONS_Printf(p, "\x86"+"\"soap_nerfcurl\" is currently "+SoapFetchConstant("soap_nerfcurl")+".")
		return	
	end
	if not CBW_Battle
	or not CBW_Battle.BattleGametype()
//	or not p.soaptable.nerfed
    //    CONS_Printf(p, "\x85"+"Obviously you need something to nerf Soap before you can even buff him!")
		CONS_Printf(p, "\x85"+"Obviously you need BattleMod to nerf Soap before you can even buff him!")
        return	
	end	
	if not soap_nerfcurl
		soap_nerfcurl = 1
		print("\x82"+"Soaps can now recurl from springs!")
	else
		soap_nerfcurl = 0
		print("\x8D"+"Soaps can no longer recurl from springs.")
	end
end)
COM_AddCommand("soap_mobjthinkers", function(p, arg)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	
	if not p.soaptable.isElevated
//        CONS_Printf(p, "\x85"+"You need to be the server host or an admin before you can use this.")
        CONS_Printf(p, "\x86"+"\"soap_ringpull\" is currently "+SoapMobjThinkerAllowed("ring_pull")+".")
		CONS_Printf(p, "\x86"+"\"soap_boosterboost\" is currently "+SoapMobjThinkerAllowed("booster_boost")+".")
		return
	end
	
	if arg
		local argL = string.lower(arg)
		//toggle mobjthinkers for rings and boosters
		//useful if my unoptimized code is causing major lag
		if argL == "ring_pull"
			if gametype == GT_YELLOWDEMON
				CONS_Printf(p,"\x85Sorry, but you can't toggle this right now!")
				return
			end
			
			if soap_ringpull
				soap_ringpull = false
				print("\x8D"+"Soaps can no longer pull in rings when close enough.")	
			else
				soap_ringpull = true
				print("\x82"+"Soaps can now pull in rings when close enough.")				
			end
		elseif argL == "booster_boost"
			if soap_boosterboost
				soap_boosterboost = 0
				print("\x8D"+"Soaps can no longer get extra boost from boosters.")	
			else
				soap_boosterboost = 1
				print("\x82"+"Soaps can now get extra boost from boosters.")
			end		
		else
			CONS_Printf(p, "\x85"+"This is not a valid argument!")
			CONS_Printf(p, "\x85"+"Make sure you've typed in one of these arguments.")
			CONS_Printf(p, "	"+"\x86"+"ring_pull"+"\x80"+" Toggles rings' attraction to Soaps when they're close.")
			CONS_Printf(p, "	"+"\x86"+"booster_boost"+"\x80"+"Toggles Soaps getting extra boost from Red and Yellow Boosters.")		
		end
	
	else
		CONS_Printf(p, "Toggles MT_NULL MobjThinkers made by Soap. Toggle if they're causing major lag.")
	//	CONS_Printf(p, "This command's arguments are CASE SENSITIVE, so type them in as you see here.")
	//	CONS_Printf(p, "	"+"\x86"+""+"\x80"+"")
		CONS_Printf(p, "	"+"\x86"+"ring_pull"+"\x80"+" Toggles rings' attraction to Soaps when they're close.")
		CONS_Printf(p, "	"+"\x86"+"booster_boost"+"\x80"+" Toggles Soaps getting extra boost from Red and Yellow Boosters.")
	end
end)
COM_AddCommand("soap_bananalimit", function(p, arg)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end
	
	if not p.soaptable.isElevated
//        CONS_Printf(p, "\x85"+"You need to be the server host or an admin before you can use this.")
        CONS_Printf(p, "\x86"+"\"soap_bananalimit\" is currently "+SoapFetchConstant("soap_bananalimit")+".")
		return
	end
	
	local num = tonumber(arg)
	
	if num == nil
        CONS_Printf(p, "\x86"+"\"soap_bananalimit\" is currently "+SoapFetchConstant("soap_bananalimit")+".")
		CONS_Printf(p, "\x86"+"This command lets you set how many bananas are allowed to exist at once. Input a number as an argument to change the limit.")
		return
	end
	
	if num < 0
        CONS_Printf(p, "\x85"+"You need to put a number above 0 .")
		return	
	end
	
	
	soap_bananalimit = num
	
	p.soaptable.cosusedlimitbefore = 1
	SoapSaveStuff(p,false,true)
	
	COM_BufInsertText(p,"soap_rawset_banana_clear")
	
	print("\x82".."Banana Peel limit has been set to "..num..".")
end)



////////////////////

print("\x82Successfully initialized \x86main2.lua")

//before we playerthink, we will thinkframe for the rawset
addHook("ThinkFrame", do
	
	for n,mo in ipairs(lb.bananalist)
		if not(mo.valid)
			SoapCONS_F(print, 0, "\x85".."Deleted invalid banana peel.")
			table.remove(lb.bananalist,n)
		end
	end
	
	//more bananas than the limit allows? delete them!
	if #lb.bananalist > SoapFetchConstant("soap_bananalimit")
		for b = SoapFetchConstant("soap_bananalimit"), #lb.bananalist
			if lb.bananalist[b] == nil
				continue
			end
			/*
			lb.bananalist[b].soapCommandKilled = true
			
			//this actually removes more bananas than needed,
			//but thats alright
			P_RemoveMobj(lb.bananalist[b])
			*/
		end
	end
	
end)
addHook("PlayerThink", function(p) //maybe adding "player" into the function will let me modify pflags? nope!
    if not p.valid
	or p.spectator
	or not p.realmo
	or not p.mo.valid
        return
    end

    //get our table first thing!
	//im convinced that other characters initing soaps table might be breaking soap
    if not p.soaptable
        SoapInitTable(p)
		return
    end
    
    if p.mo.valid and p.mo //kick off our entire script
    local me = p.mo
    local soap = p.soaptable
		
		if not soap.alreadyloaded
			SoapLoadStuff(p)
		end
		
        if me.skin == "soapthehedge"
			
			if (p.rings < 26) or p.powers[pw_super] or p.powers[pw_shield] or soap.isSol
				p.charflags = $|SF_SUPER				
			elseif (p.charflags & SF_SUPER)
				p.charflags = $ & ~SF_SUPER			
			end			

			p.mrcecustomskin = 2
			if p.mrce
				p.mrce.customskin = 2
			end
			
			//init net stuff
			soap.nerfbuff = soap_allbuff
			soap.devmode = soap_devmode
			if CBW_Battle
			and CBW_Battle.BattleGametype()
				if (not soap_allbuff)
					soap.recurlAble = soap_nerfcurl
				end
			end
	//		soap.bombsfxplay = S_SoundPlaying(me,sfx_bomblp)
			if soap.firsttime 
				soap.ftblink = $+1 
				if soap.firstttic > 0
					soap.firstttic = $-1
	//			elseif not soap.firstttic
	//			and soap.fttic
	//				soap.fttic = $-1
				end
				if soap.ftkill
					soap.ftkill = $-1
				elseif soap.ftkill == 0
					soap.firsttime = 0
					//save this so we don't have the thing appear
					SoapSaveStuff(p)
				end
				//the rest of first time text is handled in hud.lua
			end
            //hopefully this fixes that stupid mrce momentum bug for soap
			/*
				p.mrcecustomskin = 2
				if p.mrce
					p.mrce.customskin = 2
				end
			*/
			//huh!?? i thought i only needed to set  p.mrcecustomskin to 2 on every frame!!
			//why do i need to set the other customskin to 2????
			
			//remove that, because i want the player to be able to switch
			//between soap's and mrce's momentum
						
			if not CC_TrickSkins
				rawset(_G, "CC_TrickSkins", {})
			end
			
			CC_TrickSkins["soapthehedge"] = {
				alwaysenabled = 0,
				bouncetricks = 1,
				{
					sprite2 = SPR2_APOS,
					rotation = "random",
					tics = 0,
				},
				{
					sprite2 = SPR2_WALK,
					rotation = "random",
					tics = 0,
					frames = 6,
				},
				{
					sprite2 = SPR2_SFFA,
					rotation = "random",
					frame = 1,
					tics = 0,
				},
				{
					sprite2 = SPR2_ROLL,
					rotation = "random",
					frames = 4,
					tics = 0,
				}

			}

			//just incase this doesnt reset
	//		p.mindash = skins[me.skin].mindash
	//		p.maxdash = skins[me.skin].maxdash
			
            //constants
			//im so silly, i forgot to put in the 2 other args!
            SoapConstants(p, me, soap) //are these really constants if they change every frame?
            SoapButtonCheck(p, me, soap)
            SoapyMomentum(p, me, soap)
			SoapNoAirwalk(p, me, soap)
			SoapBattleModSet(p, me, soap)
			SoapSetTauntVariables(p, me, soap)
			SoapSolFormBonuses(p, me, soap, soap.isSol)
			SoapSpawnRobloxForceField(p, me, soap)
			SoapyShieldHUDText(p, me, soap)
			SoapDoOneShots(p, me, soap)
			SoapMach4Kill(p,me,soap)
			if SoapFetchConstant("soap_devmode")
				if soap.Scustom1OS
					soap.supertauntringsleft = 0
				end
				if soap.Scustom2OS
					soap.combocount = $+10
					soap.combotime = 100*TICRATE
					soap.comborank = $+1
					soap.comborankuptic = 2*TICRATE
				end
				if soap.Scustom3OS
				and not soap.supertauntready
					p.dashmode = $+(4*TICRATE)
				end
			end
			soap.trailed = false
			//SoapRingPull(p, me, soap, soap_ringpull)
			
			if p.powers[pw_carry] == CR_NIGHTSMODE
				//i know i already have an elseif for nights,
				//but i need this here to stop any
				//camera shenanigans in nights
				return
			end

			//so our momentum is cancelled, not turned off
			//seems to work fine enough
			if not soap.canMomen
				//not sure why this happens
				SoapAltMomentum(p, me, soap)
				if not soap.nerfed
					if p.normalspeed < skins[me.skin].normalspeed*2/3
						p.normalspeed = skins[me.skin].normalspeed
					end
				end
			end
			//more accurate speed thing
			soap.accSpeed = FixedDiv(abs(FixedHypot(p.rmomx,p.rmomy)), me.scale)
			soap.score = p.score-soap.levelstartscore
			
			//i cant believe its not buttered!
			//is this really cosmetic if it affects gameplay?
			if soap.cosbuttered
				SoapButteredSlopes(me)
				//yeah sure, lets just tack this on along with ours
				P_ButteredSlope(me)
			end 
			if soap.fullstasistic
				p.pflags = $ | PF_FULLSTASIS
				soap.fullstasistic = $-1
			end
			
			//goin' fast? make some speed lines!
			//the fastest!!!
			if soap.accSpeed >= (200*FRACUNIT)
				SoapWind(me)
				SoapWind(me)
			elseif soap.accSpeed >= 160*FRACUNIT
				if (leveltime & 4) <= 2
					SoapWind(me)
				end
			elseif soap.accSpeed >= 110*FRACUNIT
				if (leveltime % 6) <= 4
					SoapWind(me)
				end
			elseif soap.accSpeed >= 3*(64*FRACUNIT)/2
				if (leveltime % 10) <= 3
					SoapWind(me)
				end
			elseif soap.accSpeed >= p.runspeed
				if (leveltime % 7) == 0
					SoapWind(me)
				end
			end
			
			if p.score == 0
			and soap.levelstartscore > 0
				soap.levelstartscore = 0
			end
			
			//rank handler
			if not SoapFetchConstant("soap_inbossmap")
			if (lb.rankscores[gamemap] ~= nil)
			and gametype == GT_COOP
			
				local coco = soap.combocount
				local scorec = ((coco*coco)/4)+(10*coco)
				
				soap.rankscore = soap.score+scorec
				
				/*
				print("ranks",
				soap.rankscore.."/"..(lb.rankscores[gamemap]),
				soap.rankscore.."/"..(3*lb.rankscores[gamemap]/4),
				soap.rankscore.."/"..(lb.rankscores[gamemap]/2),
				soap.rankscore.."/"..(lb.rankscores[gamemap]/4)
				)
				*/
				
				//p/s rank
				if soap.rankscore >= (lb.rankscores[gamemap])
					if SoapIsPRank(p,soap)
						soap.rank = 6
					else
						soap.rank = 5
					end
				elseif soap.rankscore >= (3*lb.rankscores[gamemap]/4)
					soap.rank = 4
				elseif soap.rankscore >= (lb.rankscores[gamemap]/2)
					soap.rank = 3
				elseif soap.rankscore >= (lb.rankscores[gamemap]/4)
					soap.rank = 2
				else//if soap.rankscore < (lb.rankscores[gamemap]/4)
					soap.rank = 1
				end
			end
			
			//boss map
			else
			
				if soap.timeshurt > 5
					soap.rank = 1
				elseif soap.timeshurt == 5
					soap.rank = 2
				elseif soap.timeshurt >= 4
					soap.rank = 3
				elseif soap.timeshurt >= 2
					soap.rank = 4
				elseif soap.timeshurt >= 1
					soap.rank = 5
				elseif soap.timeshurt == 0
					if soap.hitboss == true
						soap.rank = 6
					else
						soap.rank = 5
					end
				end
			
			end

			if soap.rank ~= soap.lastrank
				//we went up!
				if soap.rank > soap.lastrank
					if soap.rank == 6
						MeSoundHalfVolume(sfx_rakupp,p)
					elseif soap.rank == 5
						MeSoundHalfVolume(sfx_rakups,p)
					elseif soap.rank == 4
						MeSoundHalfVolume(sfx_rakupa,p)
					elseif soap.rank == 3
						MeSoundHalfVolume(sfx_rakupb,p)
					elseif soap.rank == 2
						MeSoundHalfVolume(sfx_rakupc,p)
					end
				//down?
				else
					if soap.rank == 5
						MeSoundHalfVolume(sfx_rakdns,p)
					elseif soap.rank == 4
						MeSoundHalfVolume(sfx_rakdna,p)
					elseif soap.rank == 3
						MeSoundHalfVolume(sfx_rakdnb,p)
					elseif soap.rank == 2
						MeSoundHalfVolume(sfx_rakdnc,p)
					elseif soap.rank == 1
						MeSoundHalfVolume(sfx_rakdnd,p)

					end
				end
				soap.rankgrow = FRACUNIT/3
			end		
			soap.lastrank = soap.rank
				
			if soap.rankgrow > 0
				soap.rankgrow = $/2
			else
				soap.rankgrow = 0
			end
		
			//uncurl
			//from xmo
			soap.spinning = $!=nil and $ or false
			soap.spindowncurl = soap.SspinDOWN and ($ and $+1 or 1) or 0
			if (p.pflags & PF_SPINNING) and soap.spinning and (soap.spindowncurl == 1)
			and p.mo.state != S_PLAY_SPINDASH and not (p.pflags & PF_STARTDASH) and p.dashspeed == 0
			and soap.soapUncurl
			and (p.powers[pw_carry] == CR_NONE)
				p.pflags = $1 & ~PF_SPINNING
				if soap.onGround
					if not soap.isWatered
						P_Thrust(me, me.angle, min(FixedHypot(me.momx, me.momz), soap.accSpeed/4))
					else
						P_Thrust(me, me.angle, min(FixedHypot(me.momx, me.momz), soap.accSpeed/9))
					end
					soap.uncurlframe = 4
					if soap.accSpeed >= p.runspeed
						me.state = S_PLAY_RUN
						me.frame = P_RandomRange(0,3)
					else
						
						me.state = S_PLAY_WALK
						me.frame = P_RandomRange(0,7)
					end
					p.dashmode = $+3
				else
					me.state = S_PLAY_FALL
				end
				S_StartSound(me,sfx_uncurl)
				S_StopSoundByID(me,sfx_spin)		
			end
			soap.spinning = p.pflags & PF_SPINNING

			//spin specials
			if soap.SspinDOWN
			and me.health
				soap.spindown = $ + 1
				
				
				//prevent shield abilities interfering with airdashing
			//	if (p.pflags & (PF_SHIELDABILITY))
			//	and not (not me.SOAPuncurlready)
			//		soap.cantdive = 1
			//	end

				//"borrowed" from alt sonic
				//spring recurl
				if not soap.onGround and not (p.powers[pw_carry] == CR_NIGHTSMODE) and (p.panim == PA_SPRING)
				and soap.spindown == 1
				and not soap.flytoggle
					if soap.recurlAble
						soap.spindown = $+1
						SoapSquashAndStretch(p, me)
						if (me.momz*soap.gravflip) >= (13 * me.scale)
							S_StartSound(me,sfx_srcrl2)
							S_StartSound(me,sfx_sburst)					
							me.momz = me.momz + (me.momz / 2)
							p.dashmode = $ + 3 * TICRATE
							soap.dashpreserve = true
						else
							S_StartSound(me,sfx_srecur)
						end
						p.pflags = $ + PF_JUMPED
						soap.airdashed = 0
						SoapResetAirdashTimer(soap)
						me.state = S_PLAY_JUMP
					else
						S_StartSound(me,sfx_slip)
						MeSound(sfx_snocrl, p)
						P_DoPlayerPain(p)
						soap.curlPainStasis = 1
					end
				end
				
				//airdash
				if (soap.airdashtimer < 71) and not (soap.airdashed)
				and ((p.pflags & PF_THOKKED) and (p.pflags & PF_JUMPED))
				and ((soap.spindown) and (soap.spindown <= 13))
				and not soap.starteddive
			//	and (soap.divecancel >= 7)
				and not (p.pflags & PF_FULLSTASIS)
			//	and (not (p.pflags & (PF_SHIELDABILITY)))
					//we need to set momzfreeze before we can use this
	//				soap.momzfreeze = 10
					SoapBetterAirDash(p, me, soap)
				end

				//dive cancel
				if soap.starteddive
				and (soap.diveanimstart <= DIVE_START-2)
				and not soap.divecancel
				//	soap.airdashed = 1
					me.state = S_PLAY_ROLL
					soap.noballroll = 1
					soap.momzfreeze = 16
					soap.fullstasistic = 16
					S_StartSoundAtVolume(me,sfx_kc55, 160)
					SoapResetBounceAndDiveVars(p,me,soap)
					soap.divecancel = 1
				end
				
				//bounce				
				if not (soap.onGround)
				and (p.pflags & PF_JUMPED)
				and not (p.pflags & (PF_THOKKED))
				and ((me.state == S_PLAY_JUMP) or (me.state == S_PLAY_ROLL))
				and ((not soap.bounced) or (soap.bounceagain))
				and (soap.spindown == 1 and soap.SspinOS)
				and not (me.eflags & MFE_GOOWATER)
				and (soap.bouncecount <= (8*me.scale))
				and not (me.eflags & MFE_SPRUNG)
				//stop!!!
				and (p.powers[pw_carry] == CR_NONE)
				and (me.state ~= S_PLAY_RIDE)
				//grraahhh!!! whyd you make me make a new var??
				and soap.canbounce
				and not soap.flytoggle
				//	soap.groundtime = 3
					S_StartSoundAtVolume(me,sfx_kc55, 160)
					me.momz = ((-1*FRACUNIT)-abs($/4))*soap.gravflip 
					soap.bounced = 1
					soap.bounceagain = 0
					soap.bouncecount = $+me.scale //== FRACUNIT normally
					
				end
			
			else
				soap.spindown = 0
			end
			
			if soap.Scustom1DOWN
				
				//dive 
				if (p.pflags & PF_JUMPED)
				and ((me.state == S_PLAY_ROLL) or (me.state == S_PLAY_JUMP))
				//or ((p.pflags & PF_SPINNING) and (not soap.onGround) and (not soap.divecancel) and (not soap.starteddive))
				and not soap.airdashing
				and not ((soap.bounced) and not (soap.bounceagain))
				and not soap.starteddive
				and not soap.divecancel
				and not soap.cantdive
				and not (p.pflags & PF_SHIELDABILITY)
				and not soap.isZE
				and not (me.eflags & MFE_GOOWATER)
					S_StartSound(me,sfx_sostbd)
					soap.bounced = 0
					soap.bounceagain = 0
					soap.bouncecount = 0

					if not (p.cmd.forwardmove or p.cmd.sidemove)
						HaltMobjMomentum(me,false)
					else
						me.momx = 50*$/55
						me.momy = 50*$/55
					end
					me.momz = 0
					P_SetObjectMomZ(me,19*me.scale)
					soap.starteddive = 1
					soap.diveanimstart = DIVE_START
				end
			end
			
			//stuff to do when c2 is held
			if soap.Scustom2DOWN
				if p.playerstate == PST_LIVE
					soap.c2down = $+1
				end	
				
				//super taunt
				if soap.Scustom3OS
			//	and (p.pflags & PF_JUMPED) 
			//	and not soap.onGround
				and SoapFetchConstant("soap_devbuild")
				and soap.supertauntready
				and not soap.flytoggle
				and not soap.inPain
				and p.powers[pw_carry] == CR_NONE
				//and p.rings >= 5

				/*
					if ((CBW_Battle)
					and ( CBW_Battle.BattleGametype() )
					and (p.rings >= 10) )
					or ((p.chaos) and (p.rings >= 5))
					or (( G_RingSlingerGametype() )
					and (p.rings >= 10) 
					and (p.powers[pw_automaticring] >= 10)
					and (p.powers[pw_bouncering] >= 15)
					and (p.powers[pw_scatterring] >= 20)
					and (p.ringweapons & RW_AUTO)
					and (p.ringweapons & RW_BOUNCE)
					and (p.ringweapons & RW_SCATTER))
					or not ((CBW_Battle)
					and ( CBW_Battle.BattleGametype() )
					and (p.chaos) and ( G_RingSlingerGametype() ) )
				*/
					
					soap.supertauntringsleft = SoapFetchConstant("supertaunt_ringsleft")
					soap.supertauntkillsleft = SoapFetchConstant("supertaunt_killsleft")
					soap.supertauntfragsleft = SoapFetchConstant("supertaunt_fragsleft")
					soap.supertauntready = 0
					soap.supertaunttimer = SoapFetchConstant("supertaunts_length")*SoapFetchConstant("supertaunts_multi")
					
					//init prev table
					if soap.prev.set == false
						soap.prev.set = true
						soap.prev.mom = {me.momx,me.momy,me.momz}
						soap.prev.angle = me.angle
						soap.prev.drawangle = p.drawangle
						soap.prev.pflags = p.pflags &~PF_SHIELDABILITY
						soap.prev.state = me.state
						soap.prev.frame = me.frame
						soap.prev.tics = me.tics
						soap.prev.sprite2 = me.sprite2
						soap.prev.dashmode = p.dashmode
					end

					soap.dashpreserve = false
					p.dashmode = 0
					
					if not soap.supertauntedbefore
						soap.supertauntedbefore = 1
						SoapSaveStuff(p,false,true)
					end
					soap.c2down = 0
					soap.breakdancing = 0
					
					local flash = P_SpawnMobjFromMobj(me,0,0,me.height/2,MT_SOAP_TAUNTFLASH)
					flash.scale = 3*me.scale/2
					flash.target = me
					me.frame = A
					SoapResetBounceAndDiveVars(p,me,soap)
					p.pflags = $ &~(PF_SHIELDABILITY|PF_THOKKED|PF_JUMPED|PF_SPINNING)
					
					me.spritexscale, me.spriteyscale = FRACUNIT,FRACUNIT
					
					soap.momzfreeze, soap.fullstasistic = SoapFetchConstant("supertaunts_length")*SoapFetchConstant("supertaunts_multi")
					SoapQuakes(p, 25*FRACUNIT, (SoapFetchConstant("supertaunts_length")*SoapFetchConstant("supertaunts_multi"))/2)
					HaltMobjMomentum(me)
					if not P_RandomChance( SoapFetchConstant("assblast_chance") )
						//me.state = S_PLAY_SOAP_SUPERTAUNT3
						me.state = P_RandomRange(S_PLAY_SOAP_SUPERTAUNT1,S_PLAY_SOAP_SUPERTAUNT3)
						S_StartSound(me,sfx_ssptnt)
					else
						me.state = S_PLAY_SOAP_ASSBLAST
						S_StartSound(me,sfx_assbst)
						soap.supertauntid = 5
					end
					
					//erm how do i do this better
					if me.state == S_PLAY_SOAP_SUPERTAUNT1
						soap.supertauntid = 1
					elseif me.state == S_PLAY_SOAP_SUPERTAUNT2
						soap.supertauntid = 2
					elseif me.state == S_PLAY_SOAP_SUPERTAUNT3
						soap.supertauntid = 3
					end 
					
					SoapSuperTauntNuke(p,me,soap)
					
					//end
					
				end
				
			else
				soap.c2down = 0
			end
			
			//custom 2 one shot
			if soap.Scustom2OS
			
				//airbrake for super flying
				if soap.flytoggle
					
					HaltMobjMomentum(me,true,true,p)
					
					soap.fullstasistic = 3
					S_StartSound(me,sfx_skid)
					
				end
				
				//link shield ability to c2
				if (not soap.noShield)
				and not soap.onGround
				and not soap.airdashing
				and not soap.isSuperTaunting
					if (p.powers[pw_shield] ~= SH_WHIRLWIND)
						if (p.pflags & PF_JUMPED) and (not (p.pflags & PF_SHIELDABILITY))
							if not soap.inPain
								p.pflags = $ |PF_SHIELDABILITY
							end
							SoapyShieldSynergy(p, me, soap)
						end
					//use whirlwinds even if you arent jumping
					else
						if (not (p.pflags & PF_SHIELDABILITY))
						and not soap.flytoggle
						and not soap.isSuperTaunting
							me.state = S_PLAY_JUMP
							p.pflags = $ |PF_SHIELDABILITY|PF_JUMPED
							SoapyShieldSynergy(p, me, soap)					
						end
					end
				end
				
				//emergency brake for super!
				if soap.onGround
				and soap.accSpeed > (10*FRACUNIT)
				and soap.SspinDOWN
				and p.powers[pw_super]
					
					HaltMobjMomentum(me,false)
					
					p.cmd.forwardmove = 0
					p.cmd.sidemove = 0
					me.state = S_PLAY_SKID
					S_StartSound(me,sfx_skid)
					MeSound(sfx_sdashm,p)
					MeSound(sfx_kc3b,p)
					MeSound(sfx_kc40,p)
					SoapySuperDashBoom(p, me)


				end
			end
			
			//transform!!!!
			if soap.Scustom3OS
			and SoapFetchConstant("soap_devbuild")
				if not p.powers[pw_super]
					if (p.rings >= 50) and All7Emeralds(emeralds)
						if ((p.pflags & PF_JUMPED) and (not (p.pflags & PF_THOKKED)))
						and ((me.state == S_PLAY_ROLL) or (me.state == S_PLAY_JUMP))
						and not (p.pflags & PF_SPINNING)
						and not ((soap.bounced) or (soap.bonuceagain))
							SoapResetBounceAndDiveVars(p,me,soap)
							
							p.charflags = $|SF_SUPER
							if not p.powers[pw_super] then p.powers[pw_super] = 1 COM_BufInsertText(p, "tunes _super") end				
						
							S_StartSound(me,sfx_supert)
							S_StartSound(me,sfx_sburst)
							S_StartSound(me,sfx_slghtn)

							me.state = S_PLAY_SUPER_TRANS1
						end
					else
						p.charflags = $ &~SF_SUPER
					end
				end
			end
			
			//restore our music back to normal if our
			//super runs out
			if not p.powers[pw_super]
				if S_MusicName() == "_super"
				and soap.unsuperNOW
					COM_BufInsertText(p, "tunes -default")
					P_RestoreMusic(p)
				end
			end
			
			//sprite offsets for super taunts
			if soap.isSuperTaunting
				P_ResetScore(p)
				soap.fullstasistic = 1
				//me.spritexoffset = 26*FRACUNIT
				//me.spriteyoffset = -25*FRACUNIT
				me.spritexoffset = soap.supertauntspritexoffset[soap.supertauntid]
				//me.spriteyoffset = soap.supertauntspriteyoffset[soap.supertauntid]
				me.spritexscale, me.spriteyscale = FRACUNIT,FRACUNIT
				soap.c2down = 0
				soap.breakdancing = 0
				soap.bananapeeled = 0
				soap.bananatime = 0
				soap.bananaskid = 0
				soap.flytoggle = 0
				me.flags = $ &~MF_NOGRAVITY
			else
				me.spritexoffset = 0
			//	soap.supertauntid = 0
			end
			
			//stuff to do while being sprung
			if me.eflags & MFE_SPRUNG
				soap.airdashtimer = 0
				soap.airdashed = 0
				soap.airdashing = 0
				soap.momzfreeze = 0
			end
			
			if soap.SjumpOS
			
				//we can use jump to activate whirlwinds
				if (not soap.noShield)
				and not soap.onGround
				and (me.state ~= S_PLAY_JUMP)
				and not soap.starteddive
				and not ((soap.bounced) or (soap.bounceagain))
		//		and not (p.pflags & PF_JUMPED|PF_THOKKED)
				and not soap.airdashing
				and not soap.isSuperTaunting
				and not soap.flytoggle
					if (p.powers[pw_shield] == SH_WHIRLWIND)
						if (not (p.pflags & PF_SHIELDABILITY))
							me.state = S_PLAY_JUMP
							p.pflags = $ |PF_SHIELDABILITY|PF_JUMPED
							SoapyShieldSynergy(p, me, soap)					
						end
					end
				end			
				
			end
			
			//stuff to do while using shield abilities
			if p.pflags & PF_SHIELDABILITY
				if (p.powers[pw_shield] == SH_ELEMENTAL)
				or (p.powers[pw_shield] == SH_BUBBLEWRAP)
					me.momz = $+((-5*soap.gravflip)*me.scale)
					me.momx = $*8/9
					me.momy = $*8/9
					me.state = S_PLAY_ROLL
					soap.norollball = 1
					SoapResetBounceAndDiveVars(p, me, soap)
					
					soap.cantdive = 1
				end
			//	if (p.powers[pw_shield] == SH_BUBBLEWRAP)
			//		P_DoBubbleBounce(p)
			//	end
				
			//	if (p.powers[pw_shield] == SH_ATTRACT)
			//		if soap.attracthome
			//		and soap.attracttarg
			//		and soap.attracttarg.valid
			//			P_HomingAttack(me,p.target)
			//		end
			//	end
			else
				if me.target
				or (me.tracer == me.target)
					me.target = nil
					me.tracer = nil
				end
			end
			
			//stuff to do while shielded
			if not soap.noShield
				if (p.powers[pw_shield] == SH_ATTRACT)
					soap.attracttarg = P_LookForEnemies(p, true, false)
					if soap.attracttarg and soap.attracttarg.valid
					and (p.pflags & PF_JUMPED)
						P_SpawnLockOn(p, soap.attracttarg, S_LOCKON2)
					end
				end
			else
				soap.hudshieldability = nil
			end
			
			if soap.supertaunttimer == 0
				
				local x = cos(soap.prev.angle)
				local y = sin(soap.prev.angle)
				
				me.momx,me.momy,me.momz = unpack(soap.prev.mom)
				//thanks nicholas
				P_MovePlayer(p)
				p.drawangle = soap.prev.drawangle
				p.pflags = soap.prev.pflags
				me.state = soap.prev.state
				me.frame = soap.prev.frame
				me.tics = soap.prev.tics
				me.sprite2 = soap.prev.sprite2
				p.dashmode = soap.prev.dashmode
				
				//reset
				soap.prev.set = false
				soap.prev.mom = {}
				soap.prev.angle = 0
				soap.prev.drawangle = 0
				soap.prev.pflags = 0
				soap.prev.state = 0
				soap.prev.frame = 0
				soap.prev.tics = 0
				soap.prev.sprite2 = 0
				soap.prev.dashmode = 0
			
			end
			
			//ctrl f "on ground"
			//stuff to do while grounded
			if soap.onGround
				
				if soap.flytoggle
					p.thrustfactor = skins[me.skin].thrustfactor
					soap.flytoggle = 0
					me.flags = $ &~MF_NOGRAVITY
					p.pflags = $ &~PF_CANCARRY
				end
				
				soap.wallslamcount = 0
				
				//landed while diving? then bomb your surroundings!
				if soap.starteddive
					soap.starteddive = 0
					p.pflags = $ &~(PF_JUMPED|PF_THOKKED)
					S_StartSound(me,sfx_bmslam)
					//dive kaboom!!
					SoapQuakes(p,10*FRACUNIT,6)
					if not soap.isSuper
						PVPEarthQuake(me, me, abs(soap.divemomz)*3,me,"dive")
					else
						PVPEarthQuake(me, me, abs(soap.divemomz)*6,me,"dive")
					end
					SoapBustableFOFBreak(p,me)
					
				end
				soap.starteddive = 0
				soap.divemomz = 0
				soap.divecancel = 0
				soap.cantdive = 0

				//spawn dust to show dashmode
				if p.dashmode
				and soap.accSpeed >= (p.runspeed*2/3)
				and not (p.pflags & PF_SPINNING)
				and me.health
			//	and p.dashmode % 2 == 0
					if not SoapFetchConstant("soap_performance")
						P_SpawnSkidDust(p, ((p.dashmode/TICRATE)*3)*FRACUNIT, sfx_none)
						P_SpawnSkidDust(p, ((p.dashmode/3))*FRACUNIT, sfx_none)
					end
					P_SpawnSkidDust(p, ((p.dashmode/4)*2)*FRACUNIT, sfx_none)
				end
				
				soap.noairwalk = 0
				if soap.bounced
					SoapBustableFOFBreak(p, me)
				end
				
				if p.pflags & PF_SHIELDABILITY
				and (p.powers[pw_shield] == SH_BUBBLEWRAP)
					P_DoBubbleBounce(p)
					soap.momzfreezeadd = 4
				end
				
				//bounce up!
				if soap.bounced
	//			and me.eflags & MFE_JUSTHITFLOOR
				and not P_CheckDeathPitCollide(me)
					SoapDoBounce(p,me,soap)
				/*
				elseif soap.bounced
				or soap.bounceagain
				and	soap.groundtime == 0
				and not me.pmomz
					S_StartSound(me,sfx_uncurl)
					if (me.momz*soap.gravflip) > 0
						me.state = S_PLAY_SPRING
					else
						me.state = S_PLAY_SOAP_FREEFALL
					end
					SoapResetBounceAndDiveVars(p, me, soap)
				elseif soap.bounceagain
					soap.bounced = 0
					soap.bounceagain = 0
					soap.bouncecount = 0
				*/
				end
				
				soap.momzfreeze = 0 //reset our freeze
				SoapResetAirdashTimer(soap)
				soap.airdashed = 0
				soap.airdashwait = 0
				soap.airdashing = 0
				soap.airdashanim = 0
				soap.recovwait = 0
				soap.helpedpoyo = 0
				soap.bounced = 0
				soap.noballroll = 0
				soap.forceuse = 0
				soap.attracthome = 0
				
				if ((not soap.bounced) and (soap.bounceagain) and (not soap.fullstasistic))
					soap.bouncecount = 0
				end
				
				if ((soap.bounceagain) and (not soap.bounced))
				and me.state ~= ((S_PLAY_ROLL) or (S_PLAY_JUMP))
					SoapResetBounceAndDiveVars(p,me,soap)
				end
				
				//breakdance if we have a boombox!
				if ((soap.boombox) and (soap.boombox.valid))
				//if soap.isIdle
					if soap.c2down >= 20
						soap.fullstasistic = 1
						if not soap.breakdancing
							S_StartSound(me,sfx_breakd)
						end
						soap.breakdancing = $+35
						/*
						print("bd")
						print(soap.breakdancing)
						if (soap.breakdancing-1) <= 4
							print("Below")
							print(soap.breakdanceframe[(soap.breakdancing-1) +1])
						elseif (soap.breakdancing-1) > 4
							print("Above")
							print(soap.breakdanceframe[((4+((soap.breakdancing-5) % 11))) +1])
						end
						print("")
						*/
					else
						if soap.breakdancing
							if p.playerstate == PST_LIVE
								me.state = S_PLAY_STND
								me.sprite2 = SPR2_STND
							end
							soap.breakdancing = 0
						end
					end
				else
					//we can reset this here since nothing else uses
					//it right now
					soap.c2down = 0 
					
					if soap.breakdancing
						if p.playerstate == PST_LIVE
							me.state = S_PLAY_STND
							me.sprite2 = SPR2_STND
						end
						soap.breakdancing = 0
					end
				end
				
	//		else //in air
		
			end				
			
			if soap.breakdancing
				if soap.breakdancing == 1
					S_StartSound(me,sfx_breakd)
				end
				me.state = S_PLAY_STND
				me.sprite2 = SPR2_BRDA
				local bdint = soap.breakdancing/TICRATE
				if (bdint-1) <= 4
					me.frame = soap.breakdanceframe[(bdint-1) +1]
				elseif (soap.breakdancing-1) > 4
					me.frame = soap.breakdanceframe[((4+((bdint-5) % 11))) +1]
				end
			end
			
			//diving? then lets do this!!
			if soap.starteddive
				if me.health
				and p.powers[pw_carry] == CR_NONE
					p.pflags = $|PF_THOKKED|PF_JUMPED
					if me.momz*soap.gravflip < 0
						soap.divemomz = soap.divemomz-(me.momz*soap.gravflip)
					end
					if me.momz*soap.gravflip <= (-18*me.scale)
						//skip the fancy startup animation!
						soap.diveanimstart = 0
					end
					if soap.diveanimstart
						if not (me.eflags & MFE_GOOWATER)
						and soap.diveanimstart <= (DIVE_START-3)
							me.momz = $+((-7*me.scale)*soap.gravflip)
						end
						soap.diveanimstart = $-1
						me.state = S_PLAY_SOAP_DIVE_START
					else
						if me.frame > D then me.frame = A end
						me.state = S_PLAY_SOAP_DIVE_BALL
						if not soap.isWatered
							me.momz = $+((-10*me.scale)*soap.gravflip)
						else
							if (me.eflags & MFE_GOOWATER)
								if not soap.goobounce then soap.goobounce = 5 end
								me.momz = $+((1*me.scale)*soap.gravflip)
							else
								//regular water
								me.momz = $+((-me.scale/2)*soap.gravflip)
							end
						end
					end
					
				//	SoapQuakes(p,me.momz/2,1)
					
					//power spring!
					if me.eflags & MFE_SPRUNG
						SoapResetBounceAndDiveVars(p, me, soap)
						soap.divecancel = 0
						S_StartSound(me, sfx_sprong)
						me.momz = 3*abs($)/2
						soap.glowyeffects = 3*(me.momz/FRACUNIT)/2
						me.momx = 4*$/3
						me.momy = 6*$/3
						me.state = S_PLAY_SPRING
						p.pflags = $ &~(PF_JUMPED|PF_THOKKED)
					elseif soap.goobounce == 1
						S_StartSound(me,sfx_uncurl)
						SoapResetBounceAndDiveVars(p, me, soap)
						me.state = S_PLAY_SOAP_FREEFALL
					end
				end
			//canceled our dive? do this!
			elseif soap.divecancel
				if soap.divecancel == 1
				
					HaltMobjMomentum(me)
				
					soap.fullstasistic = 16
				end
				
				//if we're holding down C1 by the time stasis ends,
				//we get a boost forward!
				if soap.Scustom1DOWN
				and soap.divecancel == 16
					p.drawangle = me.angle
					SoapSpawnWindRing(p,me,soap)
					P_Thrust(me,me.angle,70*me.scale)
					me.momz = (25*me.scale)*soap.gravflip
					p.dashmode = $+2*TICRATE
					S_StartSound(me,sfx_kc5b)
				end
				
				if soap.divecancel < 16
					if soap.Scustom1DOWN
						SoapSpawnSurroundingSpinTrail(p,me,soap,soap.cosspinglow)
					end
				end
				
				if soap.fullstasistic == 1
				and (p.pflags & PF_THOKKED)
					p.pflags = $&~PF_THOKKED
				end
			end
						
			//returns generally go into functions
			
			//try to fix the issue stated in line 11
			//seems like this happens ONLY to soap when some
			//momentum altering mod is added at all!
			//biggest offender is xmomentum
			if CBW_Battle
				if ((not CBW_Battle.BattleGametype()) and (p.normalspeed <= (36 * FRACUNIT)))
					p.normalspeed = 64 * FRACUNIT
				end
	/*		else
				if ((p.normalspeed <= (36 * FRACUNIT)))
					p.normalspeed = 64 * FRACUNIT
				end
	*/		end
			
			//oh my god, me so sleepy honk-shoo honk-shoo
		
		    //i have an idea!
            //why not combine both flex and laugh scripts into one?
			//taunts!
			if ((soap.StossflagDOWN) and ((soap.Scustom2DOWN) or (soap.Scustom3DOWN)))
				if soap.isSuper
					if soap.isIdle
						if soap.Scustom2DOWN
							if not soap.flexxing
								S_StartSound(me,sfx_supert)
								S_StartSound(me,sfx_sburst)
								S_StartSound(me,sfx_slghtn)
								me.state = S_PLAY_SUPER_TRANS1
								soap.flexxing = 1
								addpoint(p,me,soap)
							else
								me.state = S_PLAY_STND
								soap.flexxing = 0
							end
						else
							if not soap.laughing
								S_StartSound(me,sfx_hahaha)
								me.state = S_PLAY_SOAP_LAUGH
								soap.laughing = 1
								addpoint(p,me,soap)
							else
								me.state = S_PLAY_STND
								soap.laughing = 0
							end
						end
					elseif me.state == S_PLAY_SOAP_APOSE
						if soap.Scustom2DOWN
							if not soap.dispensercooldown
								S_StartSound(me, sfx_x5dish)
								soap.dispensercooldown = 17 
							end
						end
					end
				else
					if soap.isIdle
					and not p.powers[pw_flashing]
						if soap.Scustom2DOWN
							if not soap.flexxing
								S_StartSound(me,sfx_flex)
								me.state = S_PLAY_SOAP_FLEX
								soap.flexxing = 1
								addpoint(p,me,soap)
							else
								me.state = S_PLAY_STND
								soap.flexxing = 0
							end
						else
							if not soap.laughing
								S_StartSound(me,sfx_hahaha)
								me.state = S_PLAY_SOAP_LAUGH
								soap.laughing = 1
								addpoint(p,me,soap)
							else
								me.state = S_PLAY_STND
								soap.laughing = 0
							end
						end
					elseif me.state == S_PLAY_SOAP_APOSE
						if soap.Scustom2DOWN
							if not soap.dispensercooldown
								S_StartSound(me, sfx_x5dish)
								soap.dispensercooldown = 17 
							end
						end
					end
				end
			end			
			
			//stuff to do while diving
			/*
			if soap.diving
				SoapSpikeBreak(me)
				if soap.goobounce == 1
	//				S_StopSoundByID(me, sfx_bombst)
					S_StopSoundByID(me, sfx_bomblp)		
					S_StartSound(me,sfx_uncurl)
					soap.diving = 0
					soap.divecancel = 1
					p.pflags = $ & ~PF_THOKKED
				elseif soap.gravflip*me.momz > 0
					if me.eflags & MFE_SPRUNG
						soap.diving = 0
						soap.dived = 0
						soap.divecancel = 1
						S_StartSound(mo, sfx_sprong)
						me.momz = 7*$/5 // yes, I know this doesn't account for the type of spring hit. no, I don't care. maybe I should add a spring hook to SRB2.
						me.momx = 4*$/3
						me.momy = 4*$/3
					elseif not soap.goobounce
						soap.diving = 0
						p.pflags = $ & ~PF_THOKKED
					end
				end
				
				if soap.goobounce
					soap.goobounce = $ - 1
				end			
				
				if (me.momz*soap.gravflip) <= (-10*me.scale)
					me.sprite2 = SPR2_SBDB
				else
					me.sprite2 = SPR2_ROLL
				end

			end
			*/

			//banana peeled lol
			if soap.bananapeeled
				SoapResetBounceAndDiveVars(p,me,soap)
			end
			
			//stuff to do when bouncing
			if ((soap.bounced) or (soap.bounceagain))
			and (not soap.onGround)
			and (p.playerstate == PST_LIVE)
			//	if soap.goobounce
			//		soap.goobounce = $ - 1
			//	end			
			
				if not (p.pflags & PF_JUMPED)
				and not soap.bananapeeled
				and p.powers[pw_carry] ~= CR_ROLLOUT
					p.pflags = $|PF_JUMPED
				end
								
				//cap our momz
				if (me.momz*soap.gravflip) <= (-36*me.scale)
					me.momz = (-36*me.scale)*soap.gravflip
				//	me.momz = 60*$/50
				end
				
				//stupid gooop ATTGHGH!!!
				//thanks amperbee for the help!
				local posz = me.floorz
				if soap.gravflip == -1
					posz = me.ceilingz
				end
						
				if me.z == posz
				and not soap.bounceagain
					soap.bounced = 0
					SoapDoBounce(p,me,soap)
				end
				
				//going... up?
				/*
				if (me.momz*soap.gravflip) >= 8*me.scale
				and not soap.bounceagain
					SoapResetBounceAndDiveVars(p,me,soap)
					S_StartSound(me,sfx_uncurl)
				end
				*/
				
				/*
				if (me.momz*soap.gravflip) >= 0
				and soap.bounced
				and not soap.bounceagain
					if not (me.eflags & MFE_GOOWATER)
						me.momz = 3*$/4
					else
						me.momz = ( (22*me.scale)-((soap.bouncecount)*(1+(1/2))) )*soap.gravflip
						me.momz = $*20/25
					end
					
					if not (p.pflags & PF_THOKKED)
						S_StartSoundAtVolume(me,sfx_kc52,(180-( (soap.bouncecount/me.scale) *8))  )
					end
					//this actually resets our bouncecount, but whatever
					SoapResetBounceAndDiveVars(p, me, soap)
				end
				*/
				
				if me.state ~= S_PLAY_ROLL
				and (not soap.inPain)
				and (not soap.airdashing)
					me.state = S_PLAY_ROLL
				end
				
				p.pflags = $ & ~PF_SPINNING
				
				if soap.bounced
				and ((me.state == S_PLAY_JUMP) or (me.state == S_PLAY_ROLL))
				//	me.momz = $ - ((6*me.scale)*soap.gravflip)
					me.spritexscale = FRACUNIT-(FRACUNIT/2)
					me.spriteyscale = FRACUNIT+(FRACUNIT/2)
				end
				
				if p.pflags & (PF_THOKKED)
					SoapResetBounceAndDiveVars(p,me,soap)
					P_Thrust(me, me.angle, 8*me.scale)
				end
				
				if not soap.bounceagain
				and (not (me.eflags & MFE_SPRUNG))
					SoapSpawnJumpTrail(soap.cosspinglow, p, me, 32, FRACUNIT, FRACUNIT, MT_SOAPYTRAIL, 4*FRACUNIT)
					if me.eflags & MFE_GOOWATER
						me.momz = $ - soap.gravflip*(2*me.scale)
					//	if not soap.goobounce
					//		soap.goobounce = 12
					//	end
					else
						if soap.isWatered
							me.momz = $ - soap.gravflip*(4*me.scale)	
						else
							me.momz = $ - soap.gravflip*(6*me.scale)	
						end
					//	soap.goobounce = 0
					end
				end
				//cancel conds.
				if p.powers[pw_carry] ~= CR_NONE
					soap.bounced = 0
					soap.bounceagain = 0
					soap.bouncecount = 0
			//	elseif soap.goobounce == 1
			//		S_StartSound(me,sfx_uncurl)
			//		soap.bounced = 0
			//		soap.bounceagain = 0
			//		soap.bouncecount = 0
				elseif soap.gravflip*me.momz > 0
					if me.eflags & MFE_SPRUNG
					and (not soap.bounceagain)
						SoapResetBounceAndDiveVars(p, me, soap)
						S_StartSound(mo, sfx_sprong)
						me.momz = 7*abs($)/5 // yes, I know this doesn't account for the type of spring hit. no, I don't care. maybe I should add a spring hook to SRB2.
						soap.glowyeffects = abs(me.momz)/FRACUNIT
						me.momx = 4*$/3
						me.momy = 6*$/3
						me.state = S_PLAY_SPRING
					end
				elseif soap.inPain
					SoapResetBounceAndDiveVars(p, me, soap)
				end
			end
			
			//stuff to do when carried by someone
			if p.powers[pw_carry] == CR_PLAYER
				if me.state == S_PLAY_RIDE and (p.pflags & PF_JUMPED)
					p.pflags = $ & ~PF_JUMPED & ~PF_THOKKED & ~PF_SPINNING

				end
				
				me.spritexscale = FRACUNIT
				me.spriteyscale = FRACUNIT
				
				soap.dashpreserve = false
				
		//		soap.cantdive = 1
				if me.tracer and me.tracer.player
					if (me.tracer.player.powers[pw_tailsfly] < 30) 
					and (me.tracer.skin == "poyo")
					and not soap.helpedpoyo
	
						if (me.tracer.player.charability == CA_FLY) 
							if soap.SspinDOWN
								
								//thrust us forward
								P_Thrust(me.tracer, me.tracer.angle, 15*me.tracer.scale)
								soap.helpedpoyo = 1
								CONS_Printf(me.tracer.player,"\x83"+p.name+"\x82 gave you 20 second's worth of flight time!")
								CONS_Printf(me.tracer.player,"\x82"+"Let them graze the ground so they can boost you again!")
								me.tracer.momz = 8*FRACUNIT
								me.tracer.player.powers[pw_tailsfly] = $+(20*TICRATE)
								me.tracer.player.dashmode = $+(p.dashmode)+53
								MeSound(sfx_spfbst, p)
								S_StartSound(me,sfx_spfbst, me.tracer.player)
								//flying as youre tired? whar?
								if me.tracer.state == S_PLAY_FLY_TIRED
									me.tracer.state = S_PLAY_FLY
								end
								
							end
						else
							soap.helpedpoyo = 0
							P_DoPlayerPain(p, me, me)
							S_StartSound(me,sfx_slip)
						end
					end
				end

			//stuff to do while carried by castle eggman swings
			elseif p.powers[pw_carry] == CR_MACESPIN
				SoapSpawnJumpTrail(soap.cosspinglow, p, me, 32, FRACUNIT, FRACUNIT, MT_SOAPYTRAIL, 4*FRACUNIT)
				soap.noballroll = 1
				soap.dashpreserve = false
			
			//stuff to do while carried by rollout rocks
			elseif p.powers[pw_carry] == CR_ROLLOUT
				if ((me.state == S_PLAY_ROLL) or (me.state == S_PLAY_JUMP))
					me.state = S_PLAY_WALK
				end
				soap.bounced = 0
				soap.bounceagain = 0
				SoapResetBounceAndDiveVars(p,me,soap)
			
			//stuff to do while riding minecarts
			elseif p.powers[pw_carry] == CR_MINECART
				me.spritexscale = FRACUNIT
				me.spriteyscale = FRACUNIT
				
			//stuff to do while in zoomtubes
			elseif p.powers[pw_carry] == CR_ZOOMTUBE
				soap.noballroll = 1
				//cancel dive
				soap.goobounce = 1
				SoapSpawnJumpTrail(soap.cosspinglow, p, me, 32, FRACUNIT, FRACUNIT, MT_SOAPYTRAIL, 4*FRACUNIT)
			
			//stuff to do while being carried by ropes
			elseif (p.powers[pw_carry] == CR_ROPEHANG)
				soap.starteddive,soap.divecancel,soap.diveanimstart = 0,0,0
				me.spritexscale = FRACUNIT
				me.spriteyscale = FRACUNIT				
			
			//stuff to do while in nights
			elseif (p.powers[pw_carry] == CR_NIGHTSMODE)
				me.spritexscale = FRACUNIT
				me.spriteyscale = FRACUNIT			
				
			//stuff to do while being carried by arid canyon dust devils
			elseif (p.powers[pw_carry] == CR_DUSTDEVIL)
			end
			
			//stuff to do while being carried at all
			if p.powers[pw_carry] ~= CR_NONE
				SoapResetBounceAndDiveVars(p, me, soap)
				soap.starteddive = 0
				soap.divecancel = 0
				soap.diveanimstart = 0
				soap.canbounce = 0
				soap.cantdive = 1
				soap.dashpreserve = false
			elseif p.powers[pw_carry] == CR_NONE
				soap.canbounce = 1
				soap.cantdive = 0
			end

			//stuff do to while in zombie escape/"ze" (for control+f)
			//doin all of this just in case soap isnt defined!
			if soap.isZE
			and SoapFetchConstant("soap_devbuild")
				//sorry guys, but i cant do much else without having
				//to modify the ze files!
				soap.canbounce = 0
				
			end
			
			//PVP thinker
			//i can do this later!!!
			if gametype == GT_PVP
		//		S_LookForPlayers(me,512*me.scale,590*me.scale,false)
				//if p.charability == CA_HOMINGTHOK
		//			if me.target and me.target.valid
		//			and (p.pflags & PF_JUMPED)
		//				P_SpawnLockOn(p, me.target, S_LOCKON1)
		//			end
				//end
				
				if SoapFetchConstant("soap_pvpnerf")
					soap.pvpnerf = 1
					p.charability = CA_THOK
					p.actionspd = skins["sonic"].actionspd
					p.charflags = $ |SF_MULTIABILITY
					if not (p.normalspeed == (36 * FRACUNIT)) and (not soap.isDash)
						p.normalspeed = 36 * FRACUNIT
					end
					p.runspeed = 30 * FRACUNIT
					p.mindash = 15 * FRACUNIT
					p.maxdash = 70 * FRACUNIT
					p.jumpfactor = skins["sonic"].jumpfactor
					
				else
					soap.pvpnerf = 0
					p.charability = skins[me.skin].ability
					p.actionspd = skins[me.skin].actionspd
					p.charflags = skins[me.skin].flags
					p.runspeed = skins[me.skin].runspeed
					p.mindash = skins[me.skin].mindash
					p.maxdash = skins[me.skin].maxdash
					p.jumpfactor = skins[me.skin].jumpfactor
				end
			end

			//stuff to do while underwater
			if soap.isWatered
				if not P_PlayerTouchingSectorSpecial(p, 1, 3)
						
					//spawn bubbles when we're drowning
					if ((p.powers[pw_underwater]) and (p.powers[pw_underwater] <= 16*TICRATE))
					and me.health
					and leveltime % 16 == 0
						SoapSpawnBubbles(p, me, soap)
					end
					
					//reduce underwater timer
					if not soap.isSuper
						if not soap.isSol
							if p.powers[pw_underwater] > 20*TICRATE
								p.powers[pw_underwater] = 20*TICRATE 
							end
						else
							if p.powers[pw_underwater] > 16*TICRATE
								p.powers[pw_underwater] = 16*TICRATE 
							end
						end
					end
					
				end
				
			end
			
			//stuff to do when dead
			if p.playerstate == PST_DEAD
				soap.breakdancing = 0
				soap.c2down = 0
				soap.combotime = 0
				soap.dashpreserve = false
				soap.supertauntringsleft = SoapFetchConstant("supertaunt_ringsleft")
				soap.supertauntkillsleft = SoapFetchConstant("supertaunt_killsleft")
				soap.supertauntfragsleft = SoapFetchConstant("supertaunt_fragsleft")
				soap.supertauntready = 0
				p.pflags = $ &~(PF_SPINNING|PF_JUMPED|PF_THOKKED|PF_SHIELDABILITY)
				
				if me.sprite2 == SPR2_BRDA 
					me.frame = A
					me.state = S_PLAY_DEAD
					me.sprite2 = SPR2_DEAD
				end
				
				p.hugged, p.sonichugged, p.tailshugged, p.amyhugged, p.minthugged, p.soaphugged = false,false,false,false,false,false
				
				/*
				//keep resetting this
				if soap.isWatered
				and not P_PlayerTouchingSectorSpecial(p, 1, 3)
				and not ((soap.saveddmgt == DMG_FIRE) or (me.eflags & MFE_TOUCHLAVA)) //STOP!!
				and p.powers[pw_underwater]
					soap.saveddmgt = DMG_DROWNED
					if soap.saveddmgt ~= DMG_DROWNED
					or soap.saveddmgt == DMG_INSTAKILL
					and not ((soap.saveddmgt == DMG_FIRE) or (me.eflags & MFE_TOUCHLAVA))
						soap.saveddmgt = DMG_DROWNED
					end
				end
				*/
				
				//in ball
				if ((me.state == S_PLAY_ROLL) or (me.state == S_PLAY_JUMP))
					me.state = S_PLAY_DEAD
				end
				
				if ((soap.saveddmgt) and (soap.saveddmgt == DMG_FIRE))
					me.colorized = true
				end
				
				soap.bounced = 0
				soap.bounceagain = 0
				soap.bouncecount = 0
				SoapResetBounceAndDiveVars(p,me,soap)
				me.flags = $ &~(MF_NOCLIPHEIGHT|MF_NOCLIP)

				if soap.isDash
					p.dashmode = 0
					S_StartSound(me,sfx_slip)
				//looks silly when we have dashmode and die with it
				end
				
				/*
				if soap.isWatered
				and soap.saveddmgt ~= DMG_DROWNED
					soap.saveddmgt = DMG_DROWNED
					if me.state ~= S_PLAY_DRWN then 
						me.state = S_PLAY_DRWN 
						S_StartSound(me,sfx_drown)
					end
					
				end
			*/
		//		if not soap.onGround
		//		and me.sprite2 == SPR2_SHIT
		//			me.sprite2 = SPR2_DEAD
		//			me.momz = $+((-6*FRACUNIT)*soap.gravflip)
		//		elseif soap.onGround
		//			if me.sprite2 ~= SPR2_SHIT
		//				me.sprite2 = SPR2_SHIT
		//			end
		//		end
				
				SoapDeathAnims(p, me, soap)
				
			//stuff to do when alive
			//aka reset timers and stuff
			elseif p.playerstate == PST_LIVE
				
				if soap.divecancel
					soap.divecancel = $+1
				end
				
				soap.supertaunttimer = $-1
				
				//if soap.groundtime then soap.groundtime = $-1 end
				
				if soap.movingbounce then soap.movingbounce = $-1 end
				
				if soap.flycooldown then soap.flycooldown = $-1 end
				
				if soap.glowyeffects
					if SoapFetchConstant("soap_performance") 
						soap.glowyeffects = 1
					end
					
					local spark = P_SpawnMobjFromMobj(me, 0, 0, 0, MT_IVSP)
					if (leveltime % 1 == 0)
						spark.scale = $*2
					elseif (leveltime % 3 == 0)
						spark.scale = $*3
					end
					spark.color = P_RandomRange(SKINCOLOR_SUPERGOLD1, SKINCOLOR_SUPERGOLD5)
					spark.colorized = true
					spark.destscale = me.scale/5
					spark.blendmode = AST_ADD
					spark.fuse = 13
					

					local freq = FRACUNIT*10
					local mospeed = R_PointToDist2(0, 0, R_PointToDist2(0, 0, me.momx, me.momy), me.momz)
					local dist = (mospeed/freq)
					
					if dist >= 25
						dist = 25
					end
			
					-- The loop, repeats until it spawns all the thok objects.			
					for i = dist, 1, -1 do

					//	local ghost = P_SpawnMobjFromMobj(me, (me.momx/dist)*i, (me.momy/dist)*i, (me.momz/dist)*i, MT_THOK)
						local ghost = P_SpawnGhostMobj(me)
						ghost.fuse = 8
						
					/*
						ghost.skin = me.skin
						ghost.sprite = me.sprite
						ghost.sprite2 = me.sprite2
						ghost.state = me.state
						ghost.frame = me.frame|TR_TRANS50
						ghost.angle = p.drawangle
					*/	
						ghost.color = SKINCOLOR_SUPERGOLD5
						ghost.colorized = true
						ghost.destscale = me.scale/3
						ghost.blendmode = AST_ADD
						P_SetOrigin(ghost, 
						ghost.x-(me.momx/dist)*i, 
						ghost.y-(me.momy/dist)*i, 
						ghost.z-(me.momz/dist)*i
						)
						
					end
					
					soap.glowyeffects = $-1
				end
				
				//delete our dead body
				if (soap.body and soap.body.valid)
				//	P_SpawnMobjFromMobj(soap.body, 0, 0, 0, MT_EXPLODE)
					local poof = P_SpawnMobjFromMobj(soap.body, 0, 0, 0, MT_TNTDUST)
					poof.scale = 2*soap.body.scale
					P_RemoveMobj(soap.body)
				end
				if soap.uncurlframe
					soap.uncurlframe = $-1
				end
				if soap.goobounce then soap.goobounce = $-1 end
				soap.yellowdemonkill = $-1
								
				//do colorized blinking
				if not soap.flytoggle
					if not soap.onGround 
					and not (p.powers[pw_carry] == CR_NIGHTSMODE) 
					and (p.panim == PA_SPRING) 
					and soap.isValid 
					and ((me.momz >= (13 * me.scale)*soap.gravflip)) 
					and not me.colorized
						me.colorized = true				
					else
						me.colorized = false
					end
				end

				//repurpose this for squash				
				if soap.momzfreezeadd					
					me.spritexscale = $*(50/40)
					me.spriteyscale = $/(50/40)
					soap.momzfreezeadd = $-1
				end
				
				if soap.momzfreeze
					me.momz = 0
					soap.momzfreeze = $-1
				end
			end

			//combo stuff
			if soap.combotime > 0
				if soap.combotime > SoapFetchConstant("combo_maxtime") 
					soap.combotime = SoapFetchConstant("combo_maxtime") 
				end
					
				if p.powers[pw_carry] == CR_NONE
					soap.combotime = $-1	
				end
			else
				
				if soap.combotime < 0 
					soap.combotime = 0 
				end
										
				if soap.combocount
					local cc = soap.combocount
					local score = ((cc*cc)/4)+(10*cc)
					P_AddPlayerScore(p,score)
					if not soap.comboendtics
						soap.comboendtics = TICRATE*2
					end
					soap.comboendscore = score
					soap.comboendvery = soap.combovery
					soap.comboendrank = soap.comboranks[ ((soap.comborank-1) % 15)+1]
					soap.combocount = 0
					MeSound(sfx_shudcl,p)
					//if you drop your combo while finished,
					//you wont actually drop your combo
					//so if you have a p rank, and finish,
					//it wont be dropped because of some afk bloke
					if not (p.pflags & PF_FINISHED)
						soap.combodropped = true
					end
				end
				
				soap.comborank = 1
				
			end
				
			if soap.combocount >= 150
				soap.combovery = true
			else
				soap.combovery = false
			end
							
			if soap.comborankuptic then soap.comborankuptic = $-1 end
			if soap.comboendtics then soap.comboendtics = $-1 end
			
			//to somewhat qoute the pumpkin man, "yes, even dead enemies think"
			//corpse thinker
			if ((soap.body) and (soap.body.valid))
				//goto us!
				P_MoveOrigin(soap.body,me.x,me.y,me.z)
			/*	
				if not (P_IsObjectOnGround(soap.body))
					if soap.body.sprite2 == SPR2_SHIT
						soap.body.sprite2 = SPR2_DEAD
					end
				else
					if soap.body.sprite2 ~= SPR2_SHIT
						S_StartSound(soap.body,sfx_bmslam)
						soap.body.sprite2 = SPR2_SHIT
					end
				end
			*/	
			
				//animate our body
				if soap.saveddmgt
					if soap.saveddmgt == DMG_SPACEDROWN
						me.rollangle = $ - ANG1
						soap.body.momz = 0				
					end
				end
			end
			
			if soap.dispensercooldown
				soap.dispensercooldown = $ - 1
			end

			if soap.flexxing or soap.laughing
				p.pflags = $1|PF_FULLSTASIS
				if soap.isIdle
					soap.flexxing = 0
					soap.laughing = 0
				end
	//			if soap.inPain
	//				soap.flexxing = 0
	//				soap.laughing = 0
	//				me.state = S_PLAY_PAIN
				
	//			end
			end
            
			if p.hugged
			//add support for Sonic's JunioDX scripts
			or p.sonichugged
			or p.tailshugged
			or p.amyhugged
			or p.minthugged
			//plus mine
			or p.soaphugged
			and p.playerstate == PST_LIVE
                p.pflags = $|PF_STASIS
				me.frame = A
				if me.sprite2 ~= SPR2_HUG_
					me.sprite2 = SPR2_HUG_
				end
            end

			
			if soap.justSpun and soap.noairwalk
				S_StartSound(me,sfx_spin)
			end
			
			//things do to while spinning
            if p.pflags & PF_SPINNING
				if me.state == S_PLAY_SOAP_FREEFALL
					me.state = S_PLAY_ROLL
				end
				
				//pflag stuff so we can dive while spinning midair
				if soap.Scustom1OS
				and not soap.onGround
					p.pflags = $|PF_JUMPED &~PF_SPINNING
				end
				
				//srb2 gives us PF_THOKKED when we roll up off a slope, so lets remove that
				if ((p.pflags & PF_SPINNING|PF_THOKKED) and not (p.pflags & PF_JUMPED))
					p.pflags = $ & ~PF_THOKKED
				end
				
				if ((p.pflags & PF_JUMPED) or (p.pflags & PF_THOKKED))
					p.pflags = $ & ~PF_SPINNING
				end
				
				if soap.rolltrol
				and (p.powers[pw_carry] ~= CR_NIGHTSMODE)
				and (p.powers[pw_carry] ~= CR_ZOOMTUBE)
				//this probably gets messed up in 2d
					if soap.onGround
						if p.cmd.forwardmove ~= 0
						or p.cmd.sidemove ~= 0
						or p.camangle == nil
						or p.mo.eflags & MFE_SPRUNG then
							p.camangle = p.cmd.angleturn<<16 + R_PointToAngle2(0, 0, p.cmd.forwardmove*FRACUNIT, -p.cmd.sidemove<<16)
						end
						if not (me.flags2 & MF2_TWOD or twodlevel)
						p.movespd = R_PointToDist2(p.mo.x, p.mo.y, p.mo.x + p.mo.momx, p.mo.y + p.mo.momy)
						P_InstaThrust(p.mo,R_PointToAngle2(p.mo.x - p.mo.momx,p.mo.y - p.mo.momy,p.mo.x + P_ReturnThrustX(p.mo,p.camangle,p.movespd),p.mo.y + P_ReturnThrustY(p.mo,p.camangle,p.movespd)),p.movespd)
						else
						p.movespd = R_PointToDist2(p.mo.x, 0, p.mo.x + p.mo.momx, 0)
						P_InstaThrust(p.mo,R_PointToAngle2(p.mo.x - p.mo.momx,0,p.mo.x + P_ReturnThrustX(p.mo,p.camangle,p.movespd),0),p.movespd)
						me.momy = 0
						end
					end
				else
					p.camangle = nil
				end
				
				//adding PF_JUMPED if we spun off of ground caused problems
				//thok out of roll
				if soap.SjumpOS
				and not ((p.pflags & PF_JUMPED) or (p.pflags & PF_THOKKED))
				and (not (soap.onGround))
				//	P_DoJump(p, true)
					soap.noballroll = 1
					me.state = S_PLAY_JUMP
					p.pflags = $|PF_JUMPED & ~PF_SPINNING & ~PF_JUMPDOWN & ~PF_THOKKED & ~PF_STARTDASH
				end
			else
				p.camangle = nil
			end
			
			if soap.curlPainStasis and not soap.recurlAble and me.state == S_PLAY_PAIN
				p.pflags = $1|PF_FULLSTASIS
			else
				if not me.state == S_PLAY_PAIN
					soap.curlPainStasis = 0
				end
			end
			

            //this sticks around after youre not mysticsuper, for some reason
            //maybe mysticsuper doesnt reset? maybe add a super check?
		/*	if soap.isSuperM and soap.isSoap
                p.accelstart = 150
                p.acceleration = 65
                p.thrustfactor = 8
            else
                p.accelstart = 110
                p.acceleration = 40
                p.thrustfactor = 5
            end
		*/				
			
			//yet again, "borrowed" from alt sonic
			//xmo already does this, dont need to do it again
			if me and me.valid and soap.isSoap and not soap.isXmoON
				if p.dashmode > 3*TICRATE //If you have dash mode, preserve it in the air.
					soap.dashpreserve = true
				end
				if not soap.onGround or (p.panim == PA_SPRING)//If in the air, keep dash mode set so it doesn't count down.
					if soap.dashpreserve
						p.dashmode = max(p.dashmode, 3*36)
					end
				end
				if not soap.onGround //Build dash mode in the air the same way you would on the ground. Based on source code.
				and (p.dashmode >= 3*TICRATE)
					if (p.normalspeed < skins[me.skin].normalspeed*(9+(p.dashmode/TICRATE))) // If the player normalspeed is not currently at normalspeed*2 in dash mode, add speed each tic.
						p.normalspeed = $ + FRACUNIT/5
					end
					if (p.jumpfactor < FixedMul(skins[me.skin].jumpfactor, 5*FRACUNIT/7)) // Boost jump height.
						p.jumpfactor = $ + FRACUNIT/300
					end
				end
				if (p.dashmode) //If you have dash mode :v
					if not (me.health) //If any of these conditionals are met, don't preserve dash mode.
					or soap.inPain
					or (p.gotflag)
					or (p.exiting)
					or (p.pflags & (PF_STASIS|PF_JUMPSTASIS))
				//	or (p.powers[pw_carry])
						soap.dashpreserve = false
					end
				end
				if soap.onGround //If on the ground and dash mode isn't active, don't preserve what doesn't exist.
					if p.dashmode <= 3*TICRATE
						soap.dashpreserve = false
					end
				end
			end
			
			//leaving a level? do this!
			if p.exiting
				//p rank stuff
				if not soap_inbossmap
					if SoapIsPRank(p,soap)
					and soap.combocount
						if G_GametypeUsesLives()
							P_GivePlayerLives(p,2)
						end
						P_AddPlayerScore(p,15000)
						print("\x83"..p.name.."\x82 has just gotten a \x89P RANK\x82!!")
						S_StartSound(nil,sfx_flex)
					end
				else
					if SoapIsPRank(p,soap)
					and not soap.alreadyannounced
						soap.alreadyannounced = true
						if G_GametypeUsesLives()
							P_GivePlayerLives(p,2)
						end
						P_AddPlayerScore(p,15000)
						print("\x83"..p.name.."\x82 has just gotten a \x89P RANK\x82!!")
						S_StartSound(nil,sfx_flex)
					end				
				end

				soap.combotime = 0
				
				//unused super taunt turns into points
				if soap.supertauntready
				
					P_GivePlayerRings(p, 10)
					S_StartSound(me,sfx_chchng)
					S_StartSound(me,sfx_itemup)
				
					P_AddPlayerScore(p, 100)
					local plus100 = P_SpawnMobjFromMobj(me, 0, 0, 50*me.scale, MT_SOAPPLUS100TEXT)
					plus100.timealive = 1
					plus100.scale = (3*FRACUNIT/4)
					if (not (gametyperules & GTR_FRIENDLY))
						plus100.color = p.skincolor
					else
						plus100.color = SKINCOLOR_WHITE
					end
					
					soap.supertauntready = 0

					soap.supertauntringsleft = SoapFetchConstant("supertaunt_ringsleft")
					soap.supertauntkillsleft = SoapFetchConstant("supertaunt_killsleft")
					soap.supertauntfragsleft = SoapFetchConstant("supertaunt_fragsleft")

				end
								
			else
				soap.alreadyannounced = false
			end
			
			//hat offsets
			if Cosmetics
				if me.hatmobj
					me.hatmobj.spritexscale = me.spritexscale
					me.hatmobj.spriteyscale = me.spriteyscale
				elseif me.hat
					me.hat.spritexscale = me.spritexscale
					me.hat.spriteyscale = me.spriteyscale
				end
				if not me.health //so we're dead, right? right??
					if ((me.sprite2 == SPR2_DEAD) or (me.sprite2 == SPR2_DRWN))
						Cosmetics.SkinOffsets["soapthehedge"] = 22
					elseif (me.sprite2 == SPR2_SHIT)
						Cosmetics.SkinOffsets["soapthehedge"] = 2
					end
				elseif me.health //and we're alive??
					if me.state == S_PLAY_ROLL
					or me.state == S_PLAY_JUMP
						Cosmetics.SkinOffsets["soapthehedge"] = 6
					elseif soap.inPain
						Cosmetics.SkinOffsets["soapthehedge"] = 9
					elseif soap.flexxing
						Cosmetics.SkinOffsets["soapthehedge"] = 6
					elseif me.state == S_PLAY_SKID
						Cosmetics.SkinOffsets["soapthehedge"] = 8
					else
						Cosmetics.SkinOffsets["soapthehedge"] = 10
					end
				end
			end
						
			if soap.sdmsfx
				S_StartSound(me,sfx_sdmsfx)
				//thursting for mach4
			//	P_Thrust(me, me.angle, ((soap.accSpeed/FRACUNIT)/2)*me.scale)
			end
			if soap.dashBoostSfx and soap.isValid
				if p.dashmode > (3*TICRATE)
					S_StartSound(me,sfx_sdashm)
					S_StartSound(me,sfx_kc3b)
					S_StartSound(me,sfx_kc40)
					SoapySuperDashBoom(p, me)
				end
				S_StartSound(me,sfx_sburst)
			end
			
			//bring back an old command!!
			if soap.thehorror
				//we dont want to be aposing when we're dead
				if me.health
					me.state = S_PLAY_SOAP_APOSE
				end
				p.normalspeed = 32 * FRACUNIT
			//	p.pflags = $ |PF_GODMODE
				p.powers[pw_sneakers] = 1
			else
			//	if not (CV_FindVar("god"))
			//		p.pflags = $ & ~PF_GODMODE
			//	end
				if me.state == S_PLAY_SOAP_APOSE
					p.powers[pw_invulnerability] = 0
					p.powers[pw_sneakers] = 0
					me.state = S_PLAY_STND
				end
				if soap.accSpeed and me.state == S_PLAY_SOAP_APOSE
					me.state = S_PLAY_WALK
				//we cant really prevent other characters from aposing
				//but why restrict them? its fun!
/*				elseif (not soap.isSoap) and (me.state == S_PLAY_SOAP_APOSE)
					if p.speed
						me.state = S_PLAY_WALK
					else
						me.state = S_PLAY_STND
					end
	*/			end
			end
			
						
			if ((p.pflags & (PF_THOKKED)) and (p.pflags & (PF_JUMPED)))
			
				if not soap.onGround
					soap.airdashtimer = $ + 1
				end
//				if (soap.airdashtimer < 71) and not (soap.airdashed )
//					if soap.SspinDOWN
						//we need to set momzfreeze before we can use this
	//					soap.momzfreeze = 10
//						(p, me, soap)
//					end
//				end

			end
			
			if SoapFetchConstant("soap_isspecialstage")
				soap.supertauntringsleft = SoapFetchConstant("supertaunt_ringsleft")
				soap.supertauntkillsleft = SoapFetchConstant("supertaunt_killsleft")
				soap.supertauntfragsleft = SoapFetchConstant("supertaunt_fragsleft")
			end
			if soap.supertauntringsleft > SoapFetchConstant("supertaunt_ringsleft") then soap.supertauntringsleft = SoapFetchConstant("supertaunt_ringsleft") end
			if soap.supertauntkillsleft > SoapFetchConstant("supertaunt_killsleft") then soap.supertauntkillsleft = SoapFetchConstant("supertaunt_killsleft") end
			if soap.supertauntfragsleft > SoapFetchConstant("supertaunt_fragsleft") then soap.supertauntfragsleft = SoapFetchConstant("supertaunt_fragsleft") end
			if (soap.supertauntringsleft < 0) then soap.supertauntringsleft = 0 end
			if (soap.supertauntkillsleft < 0) then soap.supertauntkillsleft = 0 end
			if (soap.supertauntfragsleft < 0) then soap.supertauntfragsleft = 0 end
			
			if soap.supertaunthudhelper then soap.supertaunthudhelper = $-1 end
			
			if soap.supertauntringsleft == 0
			or soap.supertauntkillsleft == 0
			or soap.supertauntfragsleft == 0
				if not soap.supertauntready
					soap.supertauntready = 1
					if not soap.supertauntedbefore
						soap.supertaunthudhelper = 6*TICRATE
					end
					MeSound(sfx_stnoti,p)
				end
			else
				soap.supertauntready = 0
			end
			
			if soap.supertauntready
				local rad = me.radius/FRACUNIT
				local hei = me.height/FRACUNIT
				local x = P_RandomRange(-rad,rad)*FRACUNIT
				local y = P_RandomRange(-rad,rad)*FRACUNIT
				local z = P_RandomRange(0,hei)*FRACUNIT
				local spark = P_SpawnMobjFromMobj(me,x,y,z,MT_SOAP_SUPERTAUNT_FLYINGBOLT)
				spark.target = me
				spark.state = P_RandomRange(S_SOAP_SUPERTAUNT_FLYINGBOLT1,S_SOAP_SUPERTAUNT_FLYINGBOLT5)			
				spark.blendmode = AST_ADD
				spark.color = soap.spintrailcolor
				spark.angle = p.drawangle+(FixedAngle( P_RandomRange(-337,337)*FRACUNIT ))
			end

			//spin trails!
			if (p.pflags & (PF_SPINNING))
			and not (p.pflags & PF_STARTDASH)
			or soap.uncurlframe
				if (soap.accSpeed > 20*FRACUNIT)
					SoapSpawnJumpTrail(soap.cosspinglow, p, me, 30, FRACUNIT, FRACUNIT, MT_SOAPYTRAIL, 4*FRACUNIT)
				//going slower than 10 FRACs? then spawn a thok trail!
				else
					SoapSpawnThokDashTrail(soap.cosspinglow, p, me, 13)
				end
			end

			//lets redo the jump trail stuff
			if (p.pflags & (PF_JUMPED)) 
			and (not (p.pflags & (PF_THOKKED))) 
			and (not soap.airdashing)
			and not soap.isTransform
			and p.powers[pw_carry] == CR_NONE
			or soap.starteddive
			or (p.pflags & PF_SHIELDABILITY)
			and p.playerstate == PST_LIVE
				SoapSpawnJumpTrail(soap.cosspinglow, p, me, 32, FRACUNIT, FRACUNIT, MT_SOAPYTRAIL, 4*FRACUNIT)
			end
			
			//jump trail!
			//pretty messy
			/*
			if (p.pflags & (PF_JUMPED)) 
			and (not (p.pflags & (PF_THOKKED))) 
			and (not soap.airdashing)
			and not soap.isTransform
			and p.powers[pw_carry] == CR_NONE
				
				SoapResetAirdashTimer(soap) //dont carry our timer from frame-perfect jumps
				soap.airdashed = 0 //frame-perfect jumps wouldnt let this reset
				
				if ((not soap.bounced) and (not soap.bounceagain) and (not soap.fullstasistic))
					soap.bouncecount = 0 //this too
				end
				
				if (me.momz*soap.gravflip) > (-12 * FRACUNIT)
				//or ((soap.airdashtimer) and (soap.airdashtimer <= 70))
					SoapSpawnJumpTrail(soap.cosspinglow, p, me, 32, FRACUNIT, FRACUNIT, MT_SOAPYTRAIL, 4*FRACUNIT)
				end
			
			elseif (p.pflags & (PF_JUMPED)) and (p.powers[pw_carry] == CR_NONE) and (not soap.airdashing)//so we've thokked
			
				if (soap.airdashtimer <= TICRATE) //we've thokked for less than a second
					if (me.momz*soap.gravflip) > (-12 * FRACUNIT)
						SoapSpawnJumpTrail(soap.cosspinglow, p, me, 32, FRACUNIT, FRACUNIT, MT_SOAPYTRAIL, 4*FRACUNIT)
					end
				end
			
			end
			*/
			
			
			//mess with homing thok so we can airdash
			//why even prevent soap from recurling after a homing thok?
			//"its a feature, not a bug"
			if p.pflags & (PF_THOKKED)
			//obviously this is for homingthok, so check for that 
			and not soap.airdashing
				//weve thokked without a target
				
				if me.state ~= S_PLAY_ROLL
				and not (p.pflags & (PF_SHIELDABILITY))
				and not soap.inPain
				and not soap.starteddive
					me.state = S_PLAY_ROLL
				end
				if p.charability == CA_HOMINGTHOK
					if p.pflags & PF_THOKKED and (not (p.pflags & (PF_JUMPED)))
					and not p.homing
						p.pflags = $|PF_JUMPED & ~PF_NOJUMPDAMAGE
					elseif p.homing
						p.pflags = $ & ~PF_NOJUMPDAMAGE
					end
				end
			end
			
			//we've thokked and are able to airdash
			//make sure this works with homing thok!
			if (p.pflags & (PF_THOKKED)) and (p.pflags & (PF_JUMPED)) and (soap.airdashtimer < 71) and (not soap.airdashing) and (not soap.airdashed)
			//	SoapSpawnThokDashTrail(soap.cosspinglow, p, me, 13)
				//so we're only making trails when we've thokked for less than a second
				//if (soap.airdashtimer < 36)
					SoapSpawnThokDashTrail(soap.cosspinglow, p, me, 13)
				//end
					
			end
			
			//make after images when we're going fast!!!
			if (p.dashmode > (4*TICRATE)) 
			or ((p.powers[pw_sneakers]) and (soap.accSpeed > 49 * FRACUNIT)) 
			or ((soap.accSpeed > (45*me.scale)) and (soap.nerfed))
			and not (p.pflags & PF_STARTDASH)
			and not soap.isSuperTaunting
			and me.health
				soap.ptaiframing = 1
				/*
				SoapySneakerDashTrail(p, me, soap, soap.ptaicolor)
				if not soap.ptaiframewait
					soap.ptaiframewait = 3
					if soap.ptaicolor == 1
						soap.ptaicolor = 2
					else
						soap.ptaicolor = 1
					end
				else
					soap.ptaiframewait = $ -1
				end
				*/
				
				local color = SKINCOLOR_SOAPAIREALLYRED
				local color2 = SKINCOLOR_SOAPAIREALLYGREEN
				
				if p.ptaistyle and (p.ptaistyle == 2)
					
					color = SKINCOLOR_AIREALLYBLUE
					color2 = SKINCOLOR_AIREALLYPINK
					
				elseif p.ptaistyle and (p.ptaistyle == 3)
				and ((p.ptaicolor1) and (p.ptaicolor2))
				and PizzaTowerAICandidates[me.skin][2]
				
					color = p.ptaicolor1
					color2 = p.ptaicolor2
					
				end

				SoapCreateAfterimage(p,me,color,color2)
				
			else
				soap.ptaiframing = 0
			end
			
			//get more dashmode if we have sneakers!
			if (p.powers[pw_sneakers]) and (soap.accSpeed >= p.runspeed)
				p.dashmode = $ + 1
			end
			
			//this is for air uncurling!
			/*
			if soap.ghostspawntimer
				soap.ghostspawntimer = $ - 1
				SoapyAirAfterImages(me, 12)
			end
			*/
			
			//animate freefalling sprites!
			if me.state == S_PLAY_SOAP_FREEFALL
			//	print(p.SOAPfreefallFL[(me.momz % 2)])
				me.frame = p.SOAPfreefallFL[(abs((me.momz/2)/FRACUNIT) % 2)+1]
				
			end
			
			//stuff to do when in pain
			if soap.inPain  
				//increase our hurt count!
			/*	if soap.justhurtNOW
					soap.timeshurt = $+1
					if soap.timeshurt % 5 == 0
						soap.hurttextshow = 5*TICRATE
					end
				end
			*/	
				if soap.breakdancing
					soap.c2down = 0
					soap.breakdancing = 0
					me.frame = A
					me.state = S_PLAY_PAIN
					me.sprite2 = SPR2_PAIN
				end
				
				//reset ringsleft
				/*
				if not soap.supertauntready
					soap.supertauntringsleft = SoapFetchConstant("supertaunt_ringsleft")
					soap.supertauntkillsleft = SoapFetchConstant("supertaunt_killsleft")
				end
				*/
				
				SoapResetBounceAndDiveVars(p,me,soap)
				me.state = S_PLAY_PAIN
				p.pflags = $ &~(PF_JUMPED|PF_THOKKED|PF_SPINNING)
				soap.airdashtimer = 0
				
				if soap.isDash
					p.dashmode = 0
					S_StopSoundByID(me,skins[me.skin].soundsid[SKSPLPAN4]) //so sfx_slip doesnt play twice
					S_StartSound(me,sfx_slip)
				end
				if soap.flexxing or soap.taunting
					soap.flexxing = 0
					soap.laughing = 0
				end
				
				if soap.accSpeed >= 45*FRACUNIT
				and not (p.powers[pw_carry] == CR_DUSTDEVIL)
					if (leveltime % 35 == 0)
						if me.sprite2 == SPR2_PAIN
							S_StartSound(me,sfx_yeeeow)
							me.sprite2 = SPR2_DEAD
						end
					end
				end
				
				if soap.recovwait < 0
					me.rollangle = $-FixedAngle(soap.accSpeed/4)
					me.momx = $*26/25
					me.momy = $*26/25
					if not (me.eflags & MFE_GOOWATER)
						me.momz = $-((FRACUNIT*2/3)*soap.gravflip)
					end
				end
				
				//recovery jumping
				if soap.recovwait > (15)
				and not me.recoveryWait //i actually dont even know what this does
				and not (p.pflags & PF_FULLSTASIS)
					//glow to show that you can jump
					if (leveltime % 2 == 0)
						me.colorized = true
					else
						me.colorized = false
					end
					
					if soap.SjumpDOWN
						P_DoJump(p, true)
						soap.recovwait = 0
						me.colorized = false
					end	
				else
					soap.recovwait = $+1
				end

				
			end
			
			//this is a LIE!!
			//this checks when you been unhurt
			//i.e., just gotten out of pain
			if soap.justhurtNOW
			and me.rollangle
				me.rollangle = 0
			end
			
			if (soap.airdashwait > 5)
				me.state = S_PLAY_ROLL
				soap.airdashwait = 0
				p.pflags = $ |PF_JUMPED|PF_THOKKED
			else
				if (me.state == S_PLAY_SOAP_FREEFALL) and soap.airdashed and not soap.airdashing
					soap.airdashwait = $ + 1
				end
			end
			
			if soap.airdashing
				SoapyAirAfterImages(me, 13)
				soap.airdashing = $-1
			end
						
			if me.state == S_PLAY_SKID and (not soap.onGround)
				me.state = S_PLAY_SOAP_SKID
			end
			
			if me.state == S_PLAY_SOAP_SKID
				p.pflags = $1|PF_FULLSTASIS
				if (leveltime % 4 == 0)
					S_StartSoundAtVolume(me, sfx_kc38, 40)
				end
			else
				S_StopSoundByID(me,sfx_kc38)
			end 
			
			//dashmode stuff!!!
			//stuff to do while dashing
			if soap.isDash				
				if p.dashmode > 3*TICRATE
				and not (p.pflags & PF_STARTDASH)
					//get more dashmode!! (maybe negate the loss?)
					p.dashmode = $ + 1
				end
				
				//in mach 4
				if p.dashmode >= 4*TICRATE
				or soap.ptaiframing
					//break spikes in our way in super dashmode!! 
					//from alt sonic, just modified to have a shorter radius and to only destroy spikes
//						SoapSpikeBreak(me)
					//decrease our dashmode because it looks weird peeling while standing still
					if abs(soap.accSpeed) < 4*FRACUNIT
					and soap.onGround
						if not soap.accSpeed
							p.dashmode = $ - 9
						else
							p.dashmode = $ - 3
						end
					end
					
					if soap.accSpeed >= 3*(skins[me.skin].normalspeed)/2
						if (leveltime % 29) == 0	
							SoapSpawnWindRing(p,me,soap)
						end
					end
				end
			
			end
			
			//funny chaos stuff
			if p.chaos
				local ch = p.chaos
				
				if ch.combo > soap.combocount
					soap.combocount = ch.combo
				end
				
				if ch.combotime > soap.combotime
					soap.combotime = ch.combotime
				end
				//super taunt
			end
			
			//super flying!
			if soap.flytoggle
				
				p.thrustfactor = 2*skins[me.skin].thrustfactor
				me.state = S_PLAY_STND
				
				p.pflags = $|PF_THOKKED|PF_CANCARRY
				soap.airdashtimer = 100
				
				//get out of flying!
				if soap.Scustom3OS
					me.flags = $ &~MF_NOGRAVITY
					soap.flytoggle = 0
					p.thrustfactor = skins[me.skin].thrustfactor
					soap.flycooldown = 2
					p.pflags = $ &~(PF_JUMPED|PF_THOKKED|PF_CANCARRY)
					me.state = S_PLAY_FALL
				end
				
				if soap.SjumpDOWN
					me.momz = $+((2*me.scale)*soap.gravflip)
					me.state = S_PLAY_SPRING
				end
				if soap.SspinDOWN
					me.momz = $+((-2*me.scale)*soap.gravflip)
					me.state = S_PLAY_SOAP_FREEFALL
				end
				
				//not pressing jump or spin?
				//then slowly reduce our momz to a standstill
				if me.momz
				and not ((soap.SjumpDOWN) and (soap.SspinDOWN))
					me.momz = ($ - ($/abs($)) * min(abs(P_GetMobjGravity(me)), abs($))) - soap.gravflip
				end
				
				//we will also do the same for horizontal speed!
				//chrispychars
				local dirinput = p.cmd.forwardmove or p.cmd.sidemove
				
				if soap.accSpeed
				and not dirinput
					FakeAutoBrake(p)
				end
				
				//no dashmode!
				p.dashmode = 0
				soap.dashpreserve = false
				
			end
			
			soap.lastmap = gamemap
			
			//give us some buffs when we're super!
			if soap.isSuper
				
				//spawn some sparkles!
				if not SoapFetchConstant("soap_performance")
					if (leveltime % 7) == 0	
						local supers = P_SpawnMobjFromMobj(me,P_RandomRange(-15,15)*me.scale,P_RandomRange(-15,15)*me.scale,P_RandomRange(-10,50)*me.scale,MT_BOXSPARKLE)
						supers.scale = P_RandomRange(1,2)*me.scale
						supers.color = me.color
						supers.momz = 5*me.scale
						supers.destscale = me.scale/2
					end
				end
				
				if (p.pflags & PF_JUMPED) and (not (p.pflags & PF_THOKKED))
				and soap.Scustom3OS
				and not soap.flytoggle
				and not (me.flags & MF_NOGRAVITY)
				and not soap.flycooldown
					me.flags = $|MF_NOGRAVITY
					soap.flytoggle = 1
					soap.flycooldown = 2
				end
				
				if (soap.accSpeed > p.runspeed)
					p.dashmode = $ + 2
					
				end
				
				
			end //super buffs
        //so not soap?
		else
			
			//reset combo time so you cant cheese it
			soap.combotime = 0
		end //skin if
    end //script hat
end)

//postthink for editting some anims
addHook("PostThinkFrame", function(player)
	for player in players.iterate()
		if not player
		or player.spectator
		or not player.valid
		or not player.mo.valid
		or not player.soaptable
			return
		end
		
		if player.mo.valid
			local p = player
			local me = p.mo
			local soap = p.soaptable
			if me.skin == "soapthehedge"
				
				if not soap.isSuper
					soap.spintrailcolor = me.color
				else
					soap.spintrailcolor = me.color
				//	if (p.scolor and p.scolor ~= "Default")
				//		soap.spintrailcolor = p.scolor
				//	end
				end
				
				//during bouncing
				if ((soap.bounced) or (soap.bounceagain))
				and (not soap.onGround)
				and (p.playerstate == PST_LIVE)
					if (me.eflags & MFE_SPRUNG)
						if ((soap.bounced) and not (soap.bounceagain))
							//the previous check is a bit redundant, but whatever
							S_StartSound(mo, sfx_sprong)
							me.momz = 7*abs($)/5 // yes, I know this doesn't account for the type of spring hit. no, I don't care. maybe I should add a spring hook to SRB2.
							soap.glowyeffects = (abs(me.momz)/FRACUNIT)/3
							me.momx = 4*$/3
							me.momy = 6*$/3
						end
						SoapResetBounceAndDiveVars(p,me,soap)
					end
					
					if ((me.state == S_PLAY_JUMP) or (me.state == S_PLAY_ROLL))
					and (p.pflags & PF_JUMPED)
					and not (me.eflags & MFE_SPRUNG)
					and not soap.isTransform
						me.frame = p.ballframes[(leveltime % 4) +1]
						if (leveltime % 3 == 0)
							me.frame = 2
						end
					/*
					elseif not (p.pflags & PF_JUMPED)
					and ((me.state == S_PLAY_JUMP) or (me.state == S_PLAY_ROLL))
					and not (me.eflags & MFE_SPRUNG)
						if (me.momz*soap.gravflip) > 0
							me.state = S_PLAY_SPRING
						else
							me.state = S_PLAY_FALL
						end
						soap.bounceagain = 0
					*/
					end
				end
				
				if me.state == S_PLAY_SOAP_DIVE_BALL
					me.frame = p.diveballframes[(leveltime % 4) +1]
				end
				if me.state == S_PLAY_SOAP_DIVE_START
					p.drawangle = $+(3*(ANG30*2)/4)
				end
				if me.eflags & MFE_SPRUNG
					if ((me.state == S_PLAY_SOAP_DIVE_BALL) or (me.state == S_PLAY_SOAP_DIVE_START))
						if (me.momz*soap.gravflip) > 0
							me.state = S_PLAY_SPRING
						else
							me.state = S_PLAY_FALL
						end
					end
				end
				
				/*
				if soap.isDash
					if me.colorized
						me.colorized = false
					end
				end
				*/
				
				if p.pflags & PF_SPINNING
				and soap.accSpeed <= (20*FRACUNIT)
					soap.noballroll = 1
				end
				
				if soap.noballroll
					if me.frame == C
						me.frame = D
					elseif (me.frame == F)
						me.frame = A
					end
				end
				
				//teleport our forcefield
				if soap.forcefield
				and soap.forcefield.valid
					
					if soap.isSuperTaunting
						soap.forcefield.flags2 = $|MF2_DONTDRAW
					elseif soap.forcefield.flags2 & MF2_DONTDRAW
						soap.forcefield.flags2 = $ &~MF2_DONTDRAW
					end
					//thank you Lach on the srb2 discord for helping me out with this!
					if me.eflags & MFE_VERTICALFLIP
						P_MoveOrigin(soap.forcefield, me.x, me.y, me.z + me.height - soap.forcefield.height)
					else
						P_MoveOrigin(soap.forcefield, me.x, me.y, me.z)
					end	
				end
				
				SoapSquashAndStretch(p, me) //squishy
			end //skin
		end //valid
	end //iterate
end) //thinkframe
				
