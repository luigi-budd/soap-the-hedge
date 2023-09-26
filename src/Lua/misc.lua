
freeslot("MT_SOAPMINUS50TEXT")

local function AddToRollangle(mobj, ang, rng)
	if rng > 0
		mobj.rollangle = $ - (ang)
	else
		mobj.rollangle = $ + (ang)	
	end
end
//from clairebun
local function L_ZCollide(mo1,mo2)
	if mo1.z > mo2.height+mo2.z then return false end
	if mo2.z > mo1.height+mo1.z then return false end
	return true
end
local function LaunchTargetFromInflictor(type,target,inflictor,basespeed,speedadd)
	if (string.lower(type) == "instathrust") or type == 1
		P_InstaThrust(target, R_PointToAngle2(inflictor.x, inflictor.y, target.x, target.y), basespeed+(speedadd))
	else
		P_Thrust(target, R_PointToAngle2(inflictor.x, inflictor.y, target.x, target.y), basespeed+(speedadd))
	end
end
local function SoapDoParry(target,inflictor,source)
	if target.player.mo.skin ~= "soapthehedge" then return end
	
	if not inflictor or not inflictor.valid then return end
	
	if ((target.player.soaptable.flexxing) or (target.player.soaptable.laughing))
//	if target.player.soaptable and inflictor and inflictor.valid 
		
		local p = target.player
		local me = p.mo
		local soap = p.soaptable
		
		S_StartSound(me,sfx_sparry)
		
		soap.flexxing = 0
		soap.laughing = 0
		soap.fullstasistic = 5
		
		P_SetObjectMomZ(me,6*me.scale)
		local pthrust = R_PointToAngle2(inflictor.x-inflictor.momx,inflictor.y-inflictor.momy,me.x-me.momx,me.y-me.momy)
		P_Thrust(me,pthrust,10*me.scale)
		me.state = S_PLAY_FALL
		S_StopSoundByID(me, sfx_flex)
		S_StopSoundByID(me, sfx_hahaha)
		
		local bam = P_SpawnMobjFromMobj(me,0,0,0,MT_TNTDUST)
		bam.state = S_TNTBARREL_EXPL4 

		if source and source.valid and source.health and source.player and source.player.powers[pw_flashing]
			source.player.powers[pw_flashing] = 0
		end

		if inflictor.player
			if inflictor.player.powers[pw_invulnerability]
				inflictor.player.powers[pw_invulnerability] = 0
				P_RestoreMusic(inflictor.player)
			end
			P_DoPlayerPain(inflictor.player,me,me)
			local angle = R_PointToAngle2(me.x-me.momx,me.y-me.momy,inflictor.x-inflictor.momx,inflictor.y-inflictor.momy)
			local thrust = FRACUNIT*10
			P_SetObjectMomZ(inflictor,thrust)
			P_Thrust(inflictor,angle,thrust)
			inflictor.player.powers[pw_flashing] = 2
			inflictor.player.soaptable.fullstasistic = 10
		end
		if inflictor
			P_DamageMobj(inflictor,me,me)
		end
		
		p.powers[pw_flashing] = TICRATE
		return true
	else
	
		local mo = target
			
			mo.player.soaptable.timeshurt = $+1
			if mo.player.soaptable.combocount
				mo.player.soaptable.combotime = $-(TICRATE+(3*TICRATE/2))
			end
			
			if (gametype == GT_COOP)
			and mo.player.soaptable.pizzatowerstuff

				local minus50 = P_SpawnMobjFromMobj(mo, 0, 0, 3*mo.height/2, MT_SOAPMINUS50TEXT)
				minus50.timealive = 1
				minus50.scale = (3*FRACUNIT/4)
				minus50.color = SKINCOLOR_RED
				
				if mo.player.soaptable.score >= 50
				and mo.player.score >= 50
					P_AddPlayerScore(mo.player,-50)
				else
					P_AddPlayerScore(mo.player,-mo.player.score)
				end
			end
	
	end
end


//the misc file, for hooks!
//not to self: p.realmo exists!!

addHook("PlayerThink", function(p)
	
	if not p.valid
	or p.spectator
	or not p.realmo
		return
	end
	//soap already does this, so we dont need to do it again
	if p.mo.skin == "soapthehedge"
		return
	end
	
	if not p.soaptable
		return
	end
	
	if (p.mo) and (p.realmo.valid)
		SoapConstants(p, p.mo, p.soaptable)
		SoapButtonCheck(p, me, p.soaptable)
		//this is the only thing that makes sense doing for other chars
	
		//remove forcefield
		if p.soaptable.forcefield
		and p.soaptable.forcefield.valid
			SoapCONS_F(print, 0, "\x85".."Found a Forcefield owner that isn't a Soap! Deleting...")
			P_RemoveMobj(p.soaptable.forcefield)
			p.soaptable.forcefield = 0
		end
		//remove boombox
		if p.soaptable.boombox
		and p.soaptable.boombox.valid
			P_KillMobj(p.soaptable.boombox,p.mo,p.mo)
			p.soaptable.boombox = 0
		end
	end
		
end)

//copied with permission
local function isPTSkin(skin)
	if skin == 'peppino' or skin == 'thenoise' or skin == 'snick' then return true
	else return false end
end

freeslot("MT_SOAP_BOOMBOX")
freeslot("MT_SOAP_BOOMBOX_NOTE")

//lemme just get this from chrispychars!! by Lach!!!
local function CC_SpawnDustRingLOCAL(mo, speed, thrust, alwaysabove)
	local momz = mo.momz
	if alwaysabove
		momz = -P_MobjFlip(mo)*abs($)
	end
	if abs(momz) < mo.scale
		momz = $ < 0 and -mo.scale or mo.scale
	end
		
	local forwardangle = R_PointToAngle2(0, 0, mo.momx, mo.momy)
	local sideangle = forwardangle + ANGLE_90
	local vangle = R_PointToAngle2(0, 0, FixedHypot(mo.momx, mo.momy), momz)
	
	local cosine = cos(vangle)
	local sine = sin(vangle)
	
	local radius = FixedDiv(mo.height, mo.scale) >> 1
	local xspawn = -FixedMul(FixedMul(cos(forwardangle), cosine), radius)
	local yspawn = -FixedMul(FixedMul(sin(forwardangle), cosine), radius)
	local zspawn = -FixedMul(sine, radius)
	
	local hthrust = 0
	local vthrust = 0
	if thrust
		hthrust = FixedMul(thrust, cosine)
		vthrust = FixedMul(thrust, sine)
	end
	
	cosine = FixedMul($, speed)
	sine = FixedMul($, speed)
	
	for i = 1, 16
		local dust = P_SpawnMobjFromMobj(mo, xspawn, yspawn, radius, mo.eflags & (MFE_UNDERWATER | MFE_TOUCHWATER) and MT_MEDIUMBUBBLE or MT_DUST)
		
		local a = i*ANGLE_22h + forwardangle
		
		local forwardthrust = FixedMul(cos(a), sine)
		local sidethrust = FixedMul(sin(a), speed)
		local zthrust = FixedMul(cosine, cos(a))
		
		dust.z = $ + zspawn
		
		P_Thrust(dust, forwardangle, forwardthrust - hthrust)
		P_Thrust(dust, sideangle, sidethrust)
		dust.momz = -zthrust - vthrust
		
		dust.fuse = TICRATE/4
		dust.destscale = mo.scale/8
	end
end

//make everyone be able spam dispensers here!
addHook("PlayerThink", function(player)
	//do we redefine locals again?
	//im not gonna just incase
	if not player.valid
	or not player.realmo
	or not player.realmo.valid
		return
	end
	
	if not player.soaptable
	or player.spectator
		return
	end

	local p = player
	local me = p.mo
	local soap = p.soaptable
	
	if soap.thehorror
	and not (p.pflags & PF_FINISHED)
		soap.thehorror = 0
		me.state = S_PLAY_STND
	end
	
	if player.mo.skin ~= "soapthehedge"
		
		if player.mo.state == S_PLAY_SOAP_APOSE or player.mo.state == S_PLAY_SOAP_TAPOSE
				
				if ((player.cmd.buttons & BT_TOSSFLAG) and (player.cmd.buttons & BT_CUSTOM2))
						
						if ((player.mo.state == S_PLAY_SOAP_APOSE) or (player.mo.state == S_PLAY_SOAP_TAPOSE))
						
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
			//we dont want to be aposing when we're dead
			//TODO!!!
			if player.mo.health
				if LB_Soap_APosers[player.mo.skin] == "tpose"
					player.mo.state = S_PLAY_SOAP_TAPOSE
				elseif LB_Soap_APosers[player.mo.skin] == "apose"
					player.mo.state = S_PLAY_SOAP_APOSE
				end 

			end
			player.normalspeed = 32 * FRACUNIT
			player.powers[pw_invulnerability] = 1
		else
			if player.mo.state == S_PLAY_SOAP_APOSE or player.mo.state == S_PLAY_SOAP_TAPOSE
				player.powers[pw_invulnerability] = 0
				me.state = S_PLAY_STND
			end
			if player.speed and ((player.mo.state == S_PLAY_SOAP_APOSE) or (player.mo.state == S_PLAY_SOAP_TAPOSE))
				player.mo.state = S_PLAY_WALK
			end
		end

	end
	
	//now onto the global player stuff!

	//look for activated starposts for cos hud!
	if ( (gametype == GT_COOP) or ((gametype == GT_COOP) and (not netgame)) )	
	and (SoapFetchConstant("soap_blockmapsallowed") == 1)
		local px = me.x
		local py = me.y
		local br = 50*me.scale

		searchBlockmap("objects", function(me, found)
			if found and found.valid
								
				if (found.type == MT_STARPOST)
				and (found.state ~= S_STARPOST_IDLE)
				and P_CheckSight(found,me)
					
					local dx = me.x-found.x
					local dy = me.y-found.y
					local dz = me.z-found.z
					
					if FixedHypot(FixedHypot(dx,dy),dz) <= 64*me.scale
						if p.speed < (3*me.scale)
							soap.cosmenuwait = $+1
						else
							soap.cosmenuwait = $-2
						end
					else
						soap.cosmenuwait = 0
					end
				end
			else
				soap.cosmenuwait = 0
			end
		end, me, px-br, px+br, py-br, py+br)		
	end

	if ( (gametype == GT_COOP) or ((gametype == GT_COOP) and (not netgame)) )	
	and (SoapFetchConstant("soap_blockmapsallowed") == 1)
		
		local px = me.x
		local py = me.y
		local br = 200*me.scale
	
		searchBlockmap("objects", function(me, found)
			if found and found.valid
				
				//special stuff for soap
				if me.skin == "soapthehedge"
					if found.type == MT_PLAYER
					and found.player
					and found.player.valid
					and found.player.pt
					and isPTSkin(found.skin)
						local dx = me.x-found.x
						local dy = me.y-found.y

						if (FixedHypot(dx,dy)) <= 175*FRACUNIT
							local breakd = found.player.pt.breakdancing
							
							if breakd
								if not ((soap.boombox) and (soap.boombox.valid))
									CC_SpawnDustRingLOCAL(me,6*me.scale,2*me.scale,true)
									local x = cos(R_PointToAngle2(me.x,me.y,found.x,found.y))
									local y = sin(R_PointToAngle2(me.x,me.y,found.x,found.y))
									soap.boombox = P_SpawnMobjFromMobj(me,-10*x,-10*y,0,MT_SOAP_BOOMBOX)
									P_SetObjectMomZ(soap.boombox,7*me.scale)
									soap.boombox.angle = R_PointToAngle2(me.x,me.y,found.x,found.y)
									soap.boombox.color = p.skincolor
								end
							else
								if ((soap.boombox) and (soap.boombox.valid))
									P_KillMobj(soap.boombox,me,me)
									soap.boombox = 0
								end
							end
						else
							if ((soap.boombox) and (soap.boombox.valid))
								P_KillMobj(soap.boombox,me,me)
								soap.boombox = 0
							end
						end
					end
				end
			end
		end, me, px-br, px+br, py-br, py+br)		
	end
	
	local canFire = true
	
	if soap.bananapeeled then canFire = false end
	if soap.bananaskid then canFire = false end
	if P_PlayerInPain(p) then canFire = false end
	if SoapFetchConstant("soap_isspecialstage") then canFire = false end
//	if SoapFetchConstant("soap_inbossmap") then canFire = false end

	//reset banana stuff while in a carry
	if p.powers[pw_carry] ~= CR_NONE
		soap.bananapeeled = 0
		soap.bananaskid = 0
		soap.bananatime = 0
		soap.bananabounce = 0

		if me.rollangle ~= 0 then me.rollangle = 0 end
	end
	
	if ((gametype == GT_COOP) and (not soap.isElevated) and SoapFetchConstant("soap_bananatoss"))
	or soap.isElevated
		if soap.SfirenOS
		and canFire
			//before we fire the peel, check if theres no space for it
			if (#LB_Soap.bananalist) >= SoapFetchConstant("soap_bananalimit")
				CONS_Printf(p,"\x85".."Not enough empty slots to toss peel! ("..tostring(#LB_Soap.bananalist).."/"..tostring(SoapFetchConstant("soap_bananalimit"))..")")
				MeSound(sfx_shuddy,p)
				return
			end
			
			if SoapFetchConstant("soap_inbossmap")
				CONS_Printf(p,"\x85".."You can't toss bananas in a boss map!")
				MeSound(sfx_shuddy,p)
				return				
			end
			
			local banan = P_SpawnMobjFromMobj(me,0,0,3*me.height/2,MT_SOAP_BANANA_PEEL)
			table.insert(LB_Soap.bananalist,banan)
			banan.angle = me.angle
			S_StartSound(banan,sfx_s3k51)
			if G_RingSlingerGametype()
				banan.momz = FixedMul(14*FRACUNIT, sin(p.aiming))+me.momz
				P_InstaThrust(banan,me.angle,50*me.scale+p.speed,true)
				banan.momzmul = FRACUNIT
			else
				P_SetObjectMomZ(banan,(5*me.scale)+(3*me.momz/2),true)
				P_InstaThrust(banan,me.angle,15*me.scale+p.speed)
				banan.momzmul = FRACUNIT
			end			
			
			banan.tracer = me
		end

	end
	
	if soap.bananatime then soap.bananatime = $+1 end
	if soap.dmsupertaunt then soap.dmsupertaunt = $-1 end
	if soap.dmphysprop then soap.dmphysprop = $-1 end
	if soap.dmbananaclash then soap.dmbananaclash = $-1 end
	if soap.dmbounce then soap.dmbounce = $-1 end
	if soap.dmassblast then soap.dmassblast = $-1 end
	if not (soap.bananapeeled) then soap.bananatime = 0 end
	
	//banana peeled for too long?
	if soap.bananatime >= (13*TICRATE)
		soap.bananaskid = 0
		soap.bananapeeled = 0
		me.rollangle = 0
		if p.followitem
		and ((p.followmobj) and (p.followmobj.valid))
			p.followmobj.flags2 = $ &~MF2_DONTDRAW
		end
		p.powers[pw_flashing] = 3*TICRATE
		P_DoPlayerPain(p)
		soap.bananatime = 0
	end
	
	if soap.onGround
		if not soap.bananaskid
			if soap.bananapeeled > 2
				if soap.bananabounce
					P_SetObjectMomZ(me,13*FRACUNIT)
					S_StartSound(me,P_RandomRange(sfx_spnsd0,sfx_spnsd7))
					p.drawangle = me.angle
					P_Thrust(me,p.drawangle,14*me.scale)
					soap.bananabounce = $-1
					local bam = P_SpawnMobjFromMobj(me,0,0,-(me.height/2),MT_TNTDUST)
					bam.state = S_TNTBARREL_EXPL4
					S_StopSoundByID(me,sfx_slip)
				else
					soap.bananaskid = TICRATE
					me.rollangle = 0
					soap.bananapeeled = 0
				end
			end
		else
			if soap.bananaskid == TICRATE
				S_StartSound(me,P_RandomRange(sfx_snsed0,sfx_snsed2))
			end
			me.frame = A
			me.sprite2 = SPR2_DEAD
			soap.bananaskid = $-1
			if soap.bananaskid == 1
				if p.followitem
				and ((p.followmobj) and (p.followmobj.valid))
					p.followmobj.flags2 = $ &~MF2_DONTDRAW
				end 
				P_DoJump(p,true)
				soap.bananaskid = 0
			end
		end
	else
		if soap.bananaskid
			//slip again!
			P_Thrust(me,p.drawangle,14*me.scale)
			soap.bananatime = 1
			S_StartSound(me,sfx_slip)
			p.pflags = $ &~(PF_SPINNING|PF_JUMPED|PF_THOKKED)
			me.state = S_PLAY_PAIN
			soap.bananapeeled = 2
			soap.bananaskid = 0
		end
	end
	
	if p.playerstate == PST_LIVE
	//timers
		if soap.dmmach4clash then soap.dmmach4clash = $-1 end

	end
	
	if soap.bananaskid
		p.pflags = $|PF_FULLSTASIS
	end
	
	if soap.inPain
	or p.playerstate == PST_DEAD
		if ((soap.bananapeeled) or (soap.bananaskid))
			soap.bananapeeled = 0
			soap.bananaskid = 0
			soap.bananatime = 0
			me.rollangle = 0
			if p.followitem
			and ((p.followmobj) and (p.followmobj.valid))
				p.followmobj.flags2 = $ &~MF2_DONTDRAW
			end 
		end
	end

	if soap.bananapeeled
		me.state = S_PLAY_PAIN
		me.frame = A
		me.sprite2 = SPR2_DEAD
		
		p.dashmode = 0
		soap.dashpreserve = false
		
		if soap.bananapeeled == 1
			P_SetObjectMomZ(me,17*FRACUNIT)
		end
		p.pflags = $|PF_STASIS|PF_JUMPSTASIS
		/*
		me.rollangle = $-ANG20
		if p.followitem
		and ((p.followmobj) and (p.followmobj.valid))
			p.followmobj.rollangle = $-ANG20
		end 
		*/
		if soap.bananapeeled >= 10
		and soap.bananapeeled <= 18
			me.rollangle = -(ANG20*(soap.bananapeeled-9))
			if p.followitem
			and ((p.followmobj) and (p.followmobj.valid))
			//	p.followmobj.rollangle = -(ANG20*(soap.bananapeeled-9))
				p.followmobj.flags2 = $|MF2_DONTDRAW
			end 
		end
		SoapResetBounceAndDiveVars(p,me,soap)
		soap.bananapeeled = $+1
	end
	
	if soap.cosmenuwait
		if soap.cosmenuwait >= TICRATE*3/2
		and not soap.cosmenuopen
			soap.cosmenucanopen = 1
		else
			soap.cosmenucanopen = 0
		end
	else
		soap.cosmenucanopen = 0
	end
	
	if soap.cosmenuwait == TICRATE*3/2
		MeSound(sfx_s3k89,p)
	end
	
	if soap.cosmenuwait < 0
	or soap.cosmenuopen
		soap.cosmenuwait = 0
	end
	
	if soap.cosmenujustopened then soap.cosmenujustopened = $-1 end
	
	if (p.playerstate == PST_LIVE)
		soap.dmbombdive = false
		if soap.dmmach4
			me.rollangle = 0
		end
		soap.dmmach4 = false
		soap.dmmach4phase = 0
	elseif p.playerstate == PST_DEAD
		if soap.dmmach4
		
			p.pflags = $ &~(PF_JUMPED|PF_THOKKED|PF_SPINNING)
			
			if me.skin ~= "soapthehedge"
	
				if soap.dmmach4phase == 1
			
					p.deadtimer = 0
					
					me.flags = $ &~MF_NOCLIPHEIGHT
					
					me.rollangle = $ + ANG20
					
					if soap.onGround
						me.flags = $|MF_NOCLIPHEIGHT
						HaltMobjMomentum(me)
						me.rollangle = 0
						
						soap.dmmach4phase = 2
						
						P_PlayDeathSound(me)
						SoapQuakes(p,10*FRACUNIT,5)
						SoapFlashPals(p,PAL_NUKE,5)
						P_SetObjectMomZ(me,14*me.scale,false)
						
					end
				
				end
			elseif me.skin == "soapthehedge"
				soap.saveddmgt = "DMG_MACH4"
			end
			
			if not soap.onGround
			and soap.dmmach4phase == 1
				if (leveltime % 5) == 0
					local poof = P_SpawnMobjFromMobj(me,0,0,me.height/2,MT_SPINDUST)
					poof.scale = FixedMul(2*FRACUNIT,me.scale)
					poof.color = me.color
					poof.colorized = true
					poof.destscale = me.scale/4
					poof.scalespeed = FRACUNIT/4
					poof.fuse = 10				
				end
			end
		end
	end
	
	soap.hudquakeshakex = P_RandomRange(-2,2)
	soap.hudquakeshakey = P_RandomRange(-1,1)
	soap.hudflashespulse = ((leveltime % 14)+1)
	if soap.hudflashespulse > 7
		soap.hudflashespulse = 14-$
	end
	soap.hudflashespulse = $<<V_ALPHASHIFT
	if (leveltime % 35) == 0
		soap.hudclocksounddisp = 6
	end
	if soap.hudclocksounddisp
		soap.hudclocksounddisp = $-2
	end
	
	if (gametyperules & GTR_TEAMS)
		if p.ctfteam == 1
			soap.ctfnamecolor = "\x85"+p.name+"\x80"
		elseif p.ctfteam == 2
			soap.ctfnamecolor = "\x84"+p.name+"\x80"
		elseif p.ctfteam == 0
			soap.ctfnamecolor = "\x86"+p.name+"\x80"
		else
			soap.ctfnamecolor = "\x8F"+p.name+"\x80"
		end
	else
		soap.ctfnamecolor = "\x80"+p.name+"\x80"
	end
	
end)

addHook("MobjThinker", function(bbox)
	if not bbox
	or not bbox.valid
		return
	end
	
	//the source code!
	//m_menu.c
	//this is stupid why arent you working
	local bpm = 130
	local work = bpm
	bbox.bounce = $ or 0
	local hscale = 0
	local vscale = 0
	local ang
	local ANGLETOFINESHIFT = 19
	local FINEMASK = (8192-1)
	
	work = FixedDiv(work*180, bpm)

	ang = (FixedAngle(work)>>ANGLETOFINESHIFT) & FINEMASK
	bbox.bounce = (sin(ang) - FRACUNIT/2)
	hscale = $-bbox.bounce/16
	vscale = $+bbox.bounce/16
	
	bbox.spritexscale = FRACUNIT-hscale
	bbox.spriteyscale = FRACUNIT+vscale
	
	if bbox.soaptimealive == nil
		bbox.soaptimealive = 1
	else
		bbox.soaptimealive = $+1
	end
	
	bbox.tuneplaying = S_SoundPlaying(bbox,sfx_bomtun)
	
	if not bbox.tuneplaying
		S_StartSound(bbox,sfx_bomtun)
	end
	
	//spawn notes!
	if leveltime % 6 == 1
		local x = cos(bbox.angle)
		local y = sin(bbox.angle)
		local r = bbox.radius/FRACUNIT
		
		local note = P_SpawnMobjFromMobj(bbox,(P_RandomRange(r,-r)*FRACUNIT)*2,(P_RandomRange(r,-r)*FRACUNIT)*2,P_RandomRange(-3,(bbox.height/FRACUNIT)+4)*FRACUNIT,MT_SOAP_BOOMBOX_NOTE)
		note.frame = P_RandomRange(A,G)
		note.momz = 5*bbox.scale
		note.fuse = P_RandomRange(20,40)
	end
	
	
	
end, MT_SOAP_BOOMBOX)
addHook("MobjDeath", function(bbox)
	S_StopSound(bbox)
	local boom = P_SpawnMobjFromMobj(bbox,0,0,0,MT_EXPLODE)
	S_StartSound(boom,sfx_pop)
end, MT_SOAP_BOOMBOX)

addHook("MobjDeath", function(mobj, inflictor, source)
	if source 
	and source.valid 
	and source.player 
	and source.player.valid
	and source.player.mo
	and source.player.mo.valid
	and source.skin == "soapthehedge"
		local p = source.player
		local me = p.mo
		local soap = p.soaptable
		
		SoapResetBounceAndDiveVars(p,me,soap)
		
		HaltMobjMomentum(me,true)
		
		me.state = S_PLAY_GASP
	end
end, MT_EXTRALARGEBUBBLE)

//soap stuff!!
//hugging stuff
addHook("MobjThinker", function(mo)
	if (mo.state == S_ROSY_HUG)
		//for soap ONLY!1111!
		//Extra checks to prevent broken sprites
		if (mo.target) and (mo.target.skin == "soapthehedge")
		and mo.target.player.panim == PA_IDLE
		and (mo.target.health)
			if mo.target.state ~= S_PLAY_STND
				mo.target.state = S_PLAY_STND
			end
//			mo.target.player.pflags
			mo.target.frame = A
			mo.target.sprite2 = SPR2_HUG_
		end
	end

end, MT_ROSY)

//from alt sonic!!!!!!
addHook("PlayerCanDamage", function(player, mobj)
	if not player.mo 
	or not player.mo.valid 
//	and player.soaptable.bananapeeled
		return
	end
	
	if player.mo and player.mo.valid and player.mo.skin == "soapthehedge"
		//basically if we can do the pt afterimages
		if not player.soaptable
			SoapCONS_F(f, player, "\x85"+"Soaptable error at Killing Blow")
			SoapCONS_F(f, player, "\x85"+"Soap's table isn't valid yet!")
			return
		end
		
		local me = player.mo
		
		if player.soaptable.ptaiframing
		or player.powers[pw_super]
			
			if L_ZCollide(me,mobj)
			and (mobj.flags & MF_ENEMY)
			and (mobj.type ~= MT_ROSY)
				
				//prevent killing blow sound from mobjs way above/below us
				player.dashmode = $+35
				
				local bam = P_SpawnMobjFromMobj(mobj,0,0,0,MT_TNTDUST)
				bam.state = S_TNTBARREL_EXPL4 

				P_KillMobj(mobj, me, me) //actually kill the thing. looking at you, lance-a-bots!
				return true
			end
			
		end
	end
end)

//prevent things being able to damage you in mach 4!
addHook("ShouldDamage", function(target, inflictor, source, damage, damagetype)
    if ((source) and (source.valid) and (source.soapbananapeeled)) then return false end
	
	if target and target.valid and target.skin == "soapthehedge" and target.player
    //basically if we can do the pt afterimages
	and (target.player.soaptable.ptaiframing)
//	or ((target.player.powers[pw_sneakers]) and (target.player.soaptable.accSpeed > 49 * FRACUNIT)) 
//	or ((target.player.soaptable.accSpeed > target.player.normalspeed) and (target.player.soaptable.nerfed))
//	or target.player.soaptable.flexxing
//	or target.player.soaptable.laughing
    and not (damagetype & DMG_DEATHMASK)//) or (damagetype & DMG_DEATHPIT))
    and (not target.player.soaptable.dmmach4clash)
		return false
    end
	
end, MT_PLAYER)

//kill spikes
local function KillSpike(spike, plmo)
    if not (plmo and plmo.valid and plmo.skin == "soapthehedge") then return end
    if plmo.type ~= MT_PLAYER then return end
    if plmo.z + plmo.height < spike.z or (spike.z + (spike.height+(spike.height/2))) < plmo.z then return end

    local player = plmo.player
	
    if player.soaptable.ptaiframing
	or player.powers[pw_invulnerability]
	or player.soaptable.starteddive
	or player.soaptable.bounced
	or player.powers[pw_super]
	and L_ZCollide(spike,plmo)
		player.dashmode = $+5
		SoapAddToCombo(player,player.soaptable,true)
		P_KillMobj(spike, plmo, plmo)
    end
end
addHook("MobjCollide", KillSpike, MT_SPIKE)
addHook("MobjCollide", KillSpike, MT_WALLSPIKE)
addHook("MobjCollide", KillSpike, MT_SPIKEBALL)
//not a spike thing, but i still want it gone
addHook("MobjCollide", KillSpike, MT_BOMBSPHERE)


//I HATE THESE SALOON DOORS!!!!
addHook("MobjMoveCollide", function(h, v)
	if not (h or h.player) return end
	local p = h.player
	if not p.soaptable
		SoapCONS_F(f, p, "\x85"+"Soaptable error at Saloon Door Break")
		SoapCONS_F(f, p, "\x85"+"Soap's table isn't valid yet!")
		return
	end
	if h.skin == "soapthehedge"
	and (v.valid and v.health and h.player and (p.soaptable.ptaiframing))
	local px = h.x
	local py = h.y
	local br = 250*h.scale
		searchBlockmap("objects", function(mo, found)
			if found.valid
			and (found.type == MT_SALOONDOOR or found.type == MT_SALOONDOORCENTER) //the fuck
			and not found.deadlol
				found.flags = $ | MF_NOCLIP
				if found.type == MT_SALOONDOOR
					p.dashmode = $+5
					P_KillMobj(found)
					S_StartSound(h,sfx_wbreak)
					S_StartSound(h,sfx_wbrkpt)
				else
					found.deadlol = true
				end
			end
		end, h, px-br, px+br, py-br, py+br)
	end
end, MT_PLAYER)

//thanks to Clone Fighter for helping me out on getting the damagetype!
//now how do i keep make this presist after death?
addHook("MobjDeath", function(pmo, inf, src, damagetype)
	local p = pmo.player
	local me = p.mo
	local soap = p.soaptable
	if me.skin ~= "soapthehedge"
		return
	end
		
	//how much do you guys wanna bet that most of my code
	//is just commented out? 
	//save our damage type for use in main2
	soap.saveddmgt = 0
	if soap.dmmach4
		soap.saveddmgt = "DMG_MACH4"
		return
	end
	
	if damagetype
		soap.saveddmgt = damagetype
	//	if soap.isWatered
	//	and not P_PlayerTouchingSectorSpecial(p, 1, 3)
	//	and not (me.eflags & MFE_TOUCHLAVA)
	//	and p.powers[pw_underwater]
	//		soap.saveddmgt = DMG_DROWNED
	//		if soap.saveddmgt ~= DMG_DROWNED
	//		or soap.saveddmgt == DMG_INSTAKILL
	//			soap.saveddmgt = DMG_DROWNED
	//		end
	//	end
		if P_PlayerTouchingSectorSpecial(p, 1, 3)
		and soap.saveddmgt ~= DMG_FIRE
			soap.saveddmgt = DMG_FIRE
		end
		if soap.saveddmgt == DMG_DROWNED
			if (not soap.isWatered) and p.powers[pw_spacetime]
				//we need to set this because srb2 is silly
				soap.saveddmgt = DMG_SPACEDROWN
			else
				soap.saveddmgt = DMG_DROWNED
			end
		elseif soap.saveddmgt == DMG_SPACEDROWN
			soap.saveddmgt = DMG_SPACEDROWN
		end
	end
end, MT_PLAYER)

//ring point and clocksound
local function clocksoundandstuff(target, inflictor, source, damage, damagetype)
	if source
	and source.valid
	and source.player
//	and source.player.mo.skin == "soapthehedge"
/*
	and ((target.type == MT_RING) or (target.type == MT_FLINGRING))
	or ((target.type == MT_BOUNCEPICKUP) or (target.type == MT_AUTOPICKUP))
	or ((target.type == MT_RAILPICKUP) or (target.type == MT_EXPLODEPICKUP))
	or ((target.type == MT_SCATTERPICKUP) or (target.type == MT_GRENADEPICKUP))
	//ringslinger rings
	or ((target.type == MT_BOUNCERING) or (target.type == MT_RAILRING))
	or ((target.type == MT_INFINITYRING) or (target.type == MT_AUTOMATICRING))
	or ((target.type == MT_EXPLOSIONRING) or (target.type == MT_SCATTERRING) or (target.type == MT_GRENADERING) or (target.type == MT_REDTEAMRING) or (target.type == MT_BLUETEAMRING))
	//monitors
	or ((target.flags & MF_MONITOR) and not (target.type == MT_EGGMAN_BOX))
	//coin
	or ((target.type == MT_COIN) or (target.type == MT_FLINGCOIN))
	//sphere
	or ((target.type == MT_BLUESPHERE) or (target.type == MT_FLINGBLUESPHERE))
*/
		if not source
		or not source.valid
			SoapCONS_F(print, 0, "\x85MobjDeath Score Add source not valid!")
			return
		end
		
		local rng = 0
		local isPanel = false
		local monitor = false
		local coin = false
		local flinged = false
		local sphere = false
		
		if P_WeaponOrPanel(target.type)
			isPanel = true
		else
			isPanel = false
		end
		
		if ((target.type == MT_COIN) or (target.type == MT_FLINGCOIN))
			coin = true
		else
			coin = false
		end
		
		if ((target.flags & MF_MONITOR) and (target.type ~= MT_EGGMAN_BOX))
			monitor = true
		else
			monitor = false
		end
		
		if not source.player
		or not source.player.valid
			return
		end

		//all collectables (flinged or not) keep up our mach 4!
		if source
		and source.player
		and source.player.valid
			if source.player.dashmode >= (4*TICRATE)
				source.player.dashmode = $+20
			end
		end
		
		if ((target.type == MT_FLINGRING) or (target.type == MT_FLINGCOIN))
		or (target.type == MT_FLINGBLUESPHERE)
			flinged = true
		else
			flinged = false
		end
		
		if ((target.type == MT_FLINGBLUESPHERE) or (target.type == MT_BLUESPHERE))
			sphere = true
		else
			sphere = false
		end
		
		//make us know we're collected
		if not flinged
		and not monitor
		and not isPanel
			target.soapCollected = 1
		end
		
		
		if ((source.player.mo.skin ~= "soapthehedge") and (gametype ~= GT_YELLOWDEMON))
		and not ((gametype == GT_COOP) and (not netgame))
			return
		end

		if target.soapChaseTimer
		and ((target.target) and (target.target.valid))
		and ((source.player.soaptable.YDcount) and (target.target.player.soaptable.YDcount))
			target.target.player.soaptable.YDcount = $-1
		end
				
		//kill soap if demons are on
		if SoapFetchConstant("soap_yellowdemon")
		and target.soapChaseTimer
			//got a shield? mine now!
			if source.player.powers[pw_shield]
				P_RemoveShield(source.player)
				
				//still have a shield?
				if source.player.powers[pw_shield]
					source.player.powers[pw_shield] = SH_NONE
				end
				
				P_DoPlayerPain(source.player)
				source.player.soaptable.yellowdemonkill = 4
				
				source.player.rings = 0
				P_PlayRinglossSound(source, source.player)
				
				target.target = nil
				target.type = target.info.reactiontime
				
			else //dont have a shield? your life is mine now!
				if not source.player.powers[pw_invulnerability]
					source.player.soaptable.yellowdemonkill = 1
					P_DamageMobj(source, nil, nil, 1, DMG_INSTAKILL)
				end
			end
			
			if source.player.powers[pw_invulnerability]
				P_DoPlayerPain(source.player)
			end
		end
		
		if SoapFetchConstant("soap_yellowdemon")
		or gametype == GT_YELLOWDEMON
			return
		end
		
		//bell sound
		if source.player.soaptable.cosclocksound
		and (not (coin or sphere))
			if (isPanel or monitor) and (not (flinged))//we shouldve picked up a panel
				rng = P_RandomRange(sfx_bellc5, sfx_bellc8)
			else
				rng = P_RandomRange(sfx_bellc0, sfx_bellc4)
			end
				
			if S_SoundPlaying(source.player.mo,sfx_itemup)
				S_StopSoundByID(source.player.mo,sfx_itemup)
			end
			if S_SoundPlaying(source.player.mo,sfx_ncitem)
				S_StopSoundByID(source.player.mo,sfx_ncitem)
			end

			S_StartSound(source.player.mo,rng)
		end
		
		//refill combo bar
		SoapAddToCombo(source.player,source.player.soaptable,false)
		if (isPanel)
			for i = 0, 10 do 
				SoapAddToCombo(source.player,source.player.soaptable,false)
			end
		end
		
		//super taunt stuff
		if ((not flinged) and (not isPanel) and (not monitor) and (not sphere) )
		and source.player.mo.skin == "soapthehedge"
			if not source.player.soaptable.supertauntready
				source.player.soaptable.supertauntringsleft = $-1
			end
		end
		
		//give us score!
		if (not (flinged) and (not (isPanel or monitor)))			
			P_AddPlayerScore(source.player, 10)
			local plus10 = P_SpawnMobjFromMobj(target, 0, 0, 50*source.player.mo.scale, MT_SOAPPLUS10TEXT)
			plus10.timealive = 1
			plus10.scale = (3*FRACUNIT/4)
			if (not (gametyperules & GTR_FRIENDLY))
				plus10.color = source.player.skincolor
			else
				plus10.color = SKINCOLOR_WHITE
			end

		elseif ((not (flinged)) and ((isPanel) or (monitor)))
			P_AddPlayerScore(source.player, 100)
			//this one we'll spawn from the panel, since it looks a little weird
			//for the +100 to spawn on the player
			local plus100 = P_SpawnMobjFromMobj(target, 0, 0, 50*source.player.mo.scale, MT_SOAPPLUS100TEXT)
			plus100.timealive = 1
			plus100.scale = (3*FRACUNIT/4)
			if (not (gametyperules & GTR_FRIENDLY))
				plus100.color = source.player.skincolor
			else
				plus100.color = SKINCOLOR_WHITE
			end
		end
	end
end

addHook("MobjDeath",clocksoundandstuff,MT_RING)
addHook("MobjDeath",clocksoundandstuff,MT_FLINGRING)

addHook("MobjDeath",clocksoundandstuff,MT_BOUNCEPICKUP)
addHook("MobjDeath",clocksoundandstuff,MT_AUTOPICKUP)
addHook("MobjDeath",clocksoundandstuff,MT_RAILPICKUP)
addHook("MobjDeath",clocksoundandstuff,MT_EXPLODEPICKUP)
addHook("MobjDeath",clocksoundandstuff,MT_SCATTERPICKUP)
addHook("MobjDeath",clocksoundandstuff,MT_GRENADEPICKUP)

addHook("MobjDeath",clocksoundandstuff,MT_BOUNCERING)
addHook("MobjDeath",clocksoundandstuff,MT_RAILRING)
addHook("MobjDeath",clocksoundandstuff,MT_INFINITYRING)
addHook("MobjDeath",clocksoundandstuff,MT_AUTOMATICRING)
addHook("MobjDeath",clocksoundandstuff,MT_EXPLOSIONRING)
addHook("MobjDeath",clocksoundandstuff,MT_SCATTERRING)
addHook("MobjDeath",clocksoundandstuff,MT_GRENADERING)
addHook("MobjDeath",clocksoundandstuff,MT_REDTEAMRING)
addHook("MobjDeath",clocksoundandstuff,MT_BLUETEAMRING)

addHook("MobjDeath",clocksoundandstuff,MT_COIN)
addHook("MobjDeath",clocksoundandstuff,MT_FLINGCOIN)

addHook("MobjDeath",clocksoundandstuff,MT_BLUESPHERE)
addHook("MobjDeath",clocksoundandstuff,MT_FLINGBLUESPHERE)

addHook("MobjDeath",clocksoundandstuff,MT_RING_BOX)
addHook("MobjDeath",clocksoundandstuff,MT_PITY_BOX)
addHook("MobjDeath",clocksoundandstuff,MT_ATTRACT_BOX)
addHook("MobjDeath",clocksoundandstuff,MT_FORCE_BOX)
addHook("MobjDeath",clocksoundandstuff,MT_ARMAGEDDON_BOX)
addHook("MobjDeath",clocksoundandstuff,MT_WHIRLWIND_BOX)
addHook("MobjDeath",clocksoundandstuff,MT_ELEMENTAL_BOX)
addHook("MobjDeath",clocksoundandstuff,MT_SNEAKERS_BOX)
addHook("MobjDeath",clocksoundandstuff,MT_INVULN_BOX)
addHook("MobjDeath",clocksoundandstuff,MT_1UP_BOX)
addHook("MobjDeath",clocksoundandstuff,MT_MIXUP_BOX)
addHook("MobjDeath",clocksoundandstuff,MT_MYSTERY_BOX)
addHook("MobjDeath",clocksoundandstuff,MT_GRAVITY_BOX)
addHook("MobjDeath",clocksoundandstuff,MT_RECYCLER_BOX)
addHook("MobjDeath",clocksoundandstuff,MT_SCORE1K_BOX)
addHook("MobjDeath",clocksoundandstuff,MT_SCORE10K_BOX)
addHook("MobjDeath",clocksoundandstuff,MT_FLAMEAURA_BOX)
addHook("MobjDeath",clocksoundandstuff,MT_BUBBLEWRAP_BOX)
addHook("MobjDeath",clocksoundandstuff,MT_THUNDERCOIN_BOX)
addHook("MobjDeath",clocksoundandstuff,MT_PITY_GOLDBOX)
addHook("MobjDeath",clocksoundandstuff,MT_ATTRACT_GOLDBOX)
addHook("MobjDeath",clocksoundandstuff,MT_FORCE_GOLDBOX)
addHook("MobjDeath",clocksoundandstuff,MT_ARMAGEDDON_GOLDBOX)
addHook("MobjDeath",clocksoundandstuff,MT_WHIRLWIND_GOLDBOX)
addHook("MobjDeath",clocksoundandstuff,MT_ELEMENTAL_GOLDBOX)
addHook("MobjDeath",clocksoundandstuff,MT_SNEAKERS_GOLDBOX)
addHook("MobjDeath",clocksoundandstuff,MT_INVULN_GOLDBOX)
addHook("MobjDeath",clocksoundandstuff,MT_GRAVITY_GOLDBOX)
addHook("MobjDeath",clocksoundandstuff,MT_FLAMEAURA_GOLDBOX)
addHook("MobjDeath",clocksoundandstuff,MT_BUBBLEWRAP_GOLDBOX)
addHook("MobjDeath",clocksoundandstuff,MT_THUNDERCOIN_GOLDBOX)
addHook("MobjDeath",clocksoundandstuff,MT_RING_REDBOX)
addHook("MobjDeath",clocksoundandstuff,MT_RING_BLUEBOX)


//HAHAHAHA!! AND YOU THOUGHT ALL FREESLOTS WERE IN INIT.LUA!!! THINK AGAIN, BUSTER!!
//btw all freeslots needed here are lumped together here
freeslot("MT_SOAPPLUS10TEXT")
freeslot("MT_SOAPPLUS100TEXT")
freeslot("MT_SOAPYFORCEFIELD")
//soap bubbles
freeslot("MT_SOAPBUBBLESMALL")
freeslot("MT_SOAPBUBBLEMEDIUM")
//ragdoll
freeslot("MT_SOAP_RAGDOLL")
freeslot("MT_SOAP_DEAD_BODY")
//banana!!
freeslot("MT_SOAP_BANANA_PEEL")
freeslot("MT_SOAP_BANANA_PEEL_DEAD")
//after image
freeslot("MT_SOAP_AFTERIMAGE_OBJECT")

//lua freeslots these, and soc defines them, so no errors should occur

addHook("MobjThinker", function(mobj)
	mobj.timealive = $ + 1
	local flip = P_MobjFlip(mobj)
	if (mobj.timealive & 25 == 0)
		mobj.frame = B|FF_FULLBRIGHT
	else
		mobj.frame = A|FF_FULLBRIGHT
	end
	
	if mobj.timealive <= 7
		mobj.z = $ - ((7-mobj.timealive)*FRACUNIT)*flip
	else
		mobj.z = $ + ((mobj.timealive-5)*FRACUNIT)*flip
	end
	
	if mobj.timealive >= 30
		mobj.frame = $|FF_TRANS80
	elseif mobj.timealive >= 25
		mobj.frame = $|FF_TRANS70
	elseif mobj.timealive >= 20
		mobj.frame = $|FF_TRANS50
	elseif mobj.timealive >= 10
		mobj.frame = $|FF_TRANS30
	end
end, MT_SOAPPLUS10TEXT)

addHook("MobjThinker", function(mobj)
	mobj.timealive = $ + 1
	local flip = P_MobjFlip(mobj)
	if (mobj.timealive & 25 == 0)
		mobj.frame = B|FF_FULLBRIGHT
	else
		mobj.frame = A|FF_FULLBRIGHT
	end
	
	if mobj.timealive <= 7
		mobj.z = $ - ((7-mobj.timealive)*FRACUNIT)*flip
	else
		//move this up slower
		mobj.z = $ + ((mobj.timealive-7)*FRACUNIT)*flip
	end
	
	if mobj.timealive >= 30
		mobj.frame = $|FF_TRANS80
	elseif mobj.timealive >= 25
		mobj.frame = $|FF_TRANS70
	elseif mobj.timealive >= 20
		mobj.frame = $|FF_TRANS50
	elseif mobj.timealive >= 10
		mobj.frame = $|FF_TRANS30
	end
end, MT_SOAPPLUS100TEXT)

//

local function RPblock(mobj)
		local px = mobj.x
		local py = mobj.y
		local br = SoapFetchConstant("RING_PULL")*FRACUNIT
		
		//look for players first before wedo any of this 
		searchBlockmap("objects", function(me, found)
			if not SoapIsLargeMap()
			//keep following if we already have a target
			or ((mobj.target) and (mobj.target.player))
				mobj.canthink = true 
				return true 
			end
			if found and found.valid
			and ( ((found.z+found.height) - me.z) <= 80*FRACUNIT+(abs(me.momz/2))) and ((found.z+found.height) - me.z) > 0
				if found.player //is the found mobj a player?
				and found.health
					mobj.canthink = true
					return true
				else //no player found?
					mobj.canthink = false
					//keep searching
					return false
				end
			end
		end, mobj, px-br, px+br, py-br, py+br)

end

//pull rings towards us when we're close enough
//im not sure if you guys have noticed this, but the term "reusable"
//seems to have been replaced with "open assets" on the MB at the time im writing this (3/15/23 in freedom form)
//the tag "reusable content" is still a thing, but its called "open assets"
//idk, just confused me and id thought id point it out
//im not sure if i should split this into different thinkers, for different mobjs
//that'd be a lot of control c+v, but i can just put it into a local func.
local function DoSoapRingPull(mobj)
		//this hurts in big maps!
		if ((mobj.type == MT_AXIS) or (mobj.type == MT_AXISTRANSFER) or (mobj.type == MT_AXISTRANSFERLINE))
			return
		end
		
		if not SoapMobjThinkerAllowed("ring_pull")
			return
		end
		
		if (not(mobj.flags & MF_SPECIAL))
		or (mobj.flags & MF_MONITOR)
		or (mobj.flags & MF_ENEMY)
		or (mobj.flags & MF_SHOOTABLE)
//		or (((mobj.type < 300) and (mobj.type > 309)) or (mobj.type > 1206))
			//300-309 are all the mobjs we need here
			return
		end
		
		if mobj.type == MT_SPARK
		or mobj.sprite == SRP_SPRK
		or not mobj
		or not mobj.valid
			return
		end

		RPblock(mobj)
		
		if mobj.canthink == false
			return
		end
		
		/*
		if (mobj.type == MT_RING)
		//ringslinger rings
		or ((mobj.type == MT_BOUNCERING) or (mobj.type == MT_RAILRING))
		or ((mobj.type == MT_INFINITYRING) or (mobj.type == MT_AUTOMATICRING))
		or ((mobj.type == MT_EXPLOSIONRING) or (mobj.type == MT_SCATTERRING) or (mobj.type == MT_GRENADERING) or (mobj.type == MT_REDTEAMRING) or (mobj.type == MT_BLUETEAMRING))
		//coin
		or (mobj.type == MT_COIN)
		//bluesphere
		or (mobj.type == MT_BLUESPHERE)
		*/
			//referenced A_AttractChase for this one
			// https://wiki.srb2.org/wiki/A_AttractChase\
			if not mobj.target
				if not SoapFetchConstant("soap_yellowdemon")
					P_LookForPlayers(mobj, SoapFetchConstant("RING_PULL")*mobj.scale, true, false)
				else
					//bigger range so you cant just avoid the rings
					P_LookForPlayers(mobj, SoapFetchConstant("RING_PULL")*3*mobj.scale, true, false)
				end
			end
			
			if ((leveltime % 1 == 0) and (mobj.fuse) and (mobj.fuse < 2*TICRATE))
				mobj.flags2 = $ |MF2_DONTDRAW
			else
				mobj.flags2 = $ & ~MF2_DONTDRAW
			end		
				
			if mobj.target		
			and mobj.target.player
		//	and (mobj.target.player.mo.skin == "soapthehedge")
				
			//	if (mobj.target.player.powers[pw_carry] == CR_NIGHTSMODE)
			//		mobj.target = nil
			//		return
			//	end
				
				//found a player? check if theyre not soap and the gt isnt yd to unset
				//if yd is on and we're in singlep, then ignore!
				if (mobj.target.player.mo.skin ~= "soapthehedge") 
				and (gametype ~= GT_YELLOWDEMON)
				and not ((gametype == GT_COOP) and (not netgame))
				//	mobj.target.player.soaptable.YDcount = $-1
					mobj.target = nil
					return
				end
				
			//	if mobj.type == MT_FLINGRING
		//			mobj.type = MT_RING
		//		end
				
				//cant collect team rings that arent yours!
				if ((mobj.type == MT_REDTEAMRING) and (mobj.target.player.ctfteam ~= 1))
				or ((mobj.type == MT_BLUETEAMRING) and (mobj.target.player.ctfteam ~= 2))
					return
				end

				if gametype == GT_YELLOWDEMON
				or (SoapFetchConstant("soap_yellowdemon"))
					if mobj.target
						//stop this now
						if not (P_CanPickupItem(mobj.target.player))
						or (mobj.target.player.powers[pw_flashing])
						or (P_PlayerInPain(mobj.target.player))
							if mobj.soapChaseTimer
								mobj.target.player.soaptable.YDcount = $-1
								mobj.target = nil											
								mobj.flags = $ & ~MF_NOCLIP & ~MF_NOCLIPHEIGHT & ~MF_NOGRAVITY
								mobj.fuse = SoapFetchConstant("ring_fuse")*TICRATE
								mobj.type = mobj.info.reactiontime
								return
							else
								mobj.target = nil
								return							
							end
						end	
					end
				end
				
				//we've just found a player, and are unable
				//to be picked up by them, so abort code
				if not (P_CanPickupItem(mobj.target.player))
				and not mobj.soapChaseTimer
				//dont target the player if theyve just respawned
				or ((mobj.target.player.powers[pw_flashing]) and SoapFetchConstant("soap_yellowdemon"))
					mobj.target.player.soaptable.YDcount = $-1
					mobj.target = nil
					return
				end				
				
				//dropped rings never respawn, and thats a problem
				//well this is designed to be used in short range, so ehhhh				
				if not mobj.target
				or not mobj.target.player
				or not mobj.target.health
		//		or not (P_CheckSight(mobj, mobj.target))
				//you are NOT outrunning the rings!
				//i'd like to see you try a "yellow demon" challenge ;)
				or not (P_CanPickupItem(mobj.target.player))
				or ((mobj.target.player.powers[pw_flashing]) and (SoapFetchConstant("soap_yellowdemon")))
				or ((mobj.target.player.mo.skin ~= "soapthehedge") and not ((gametype == GT_COOP) and (not netgame)))
				and mobj.soapChaseTimer
					mobj.target.player.soaptable.YDcount = $-1
					mobj.target = nil					
					mobj.type = mobj.info.reactiontime
					mobj.fuse = SoapFetchConstant("ring_fuse")*TICRATE
					mobj.flags = $ & ~MF_NOCLIP & ~MF_NOCLIPHEIGHT & ~MF_NOGRAVITY
					return
				end
				
				if (((mobj.target) and (mobj.target.player)))
					mobj.flags = $ & ~MF_NOCLIPHEIGHT
					mobj.flags = $ |MF_NOCLIP
					
					//go faster!
					if (mobj.soapChaseTimer == nil)
						mobj.soapChaseTimer = 1
						//just found our target!
						mobj.target.player.soaptable.YDcount = $+1
						if SoapFetchConstant("soap_yellowdemon")
							S_StartSoundAtVolume(mobj,sfx_gbeep, 175)
						end
					else
						mobj.soapChaseTimer = $+1
						if not SoapFetchConstant("soap_yellowdemon")
							mobj.movefactor = $ + (2*FRACUNIT)
							
						//yellow demons
						else
							mobj.movefactor = $ + (FRACUNIT/15)
						end
					end
										
					local dx = mobj.x - mobj.target.x
					local dy = mobj.y - mobj.target.y
											
					P_HomingAttack(mobj, mobj.target)
					P_Thrust(mobj, mobj.angle, mobj.movefactor)
										
					if mobj.movefactor >= TICRATE*FRACUNIT
		//			and mobj.soapChaseTimer >= TICRATE/2
					and (FixedHypot(dx, dy) <= (96*FRACUNIT))
					and not SoapFetchConstant("soap_yellowdemon")
						P_SetOrigin(mobj, mobj.target.x, mobj.target.y, mobj.target.z+(mobj.target.height/2))
						mobj.movefactor = 0
					end
					
					//ok this has been going on for too long
					if mobj.soapChaseTimer >= (5*TICRATE)
					and not SoapFetchConstant("soap_yellowdemon")
						mobj.movefactor = 0
						mobj.flags = $|(MF_NOCLIP|MF_NOCLIPHEIGHT)
						P_SetOrigin(mobj, mobj.target.x, mobj.target.y, mobj.target.z+(mobj.target.height/2))
					end
					
				end
			end
//		end

end

local function SoapYDpull(mobj)
	if not SoapMobjThinkerAllowed("ring_pull")
		return
	end

	if gametype == GT_YELLOWDEMON
		DoSoapRingPull(mobj)
	end
end

addHook("MobjThinker", DoSoapRingPull, MT_RING)
//addHook("MobjThinker", SoapYDpull, MT_FLINGRING)

addHook("MobjThinker", DoSoapRingPull, MT_BOUNCERING)
addHook("MobjThinker", DoSoapRingPull, MT_RAILRING)
addHook("MobjThinker", DoSoapRingPull, MT_INFINITYRING)
addHook("MobjThinker", DoSoapRingPull, MT_AUTOMATICRING)
addHook("MobjThinker", DoSoapRingPull, MT_EXPLOSIONRING)
addHook("MobjThinker", DoSoapRingPull, MT_SCATTERRING)
addHook("MobjThinker", DoSoapRingPull, MT_GRENADERING)

addHook("MobjThinker", DoSoapRingPull, MT_REDTEAMRING)
addHook("MobjThinker", DoSoapRingPull, MT_BLUETEAMRING)

addHook("MobjThinker", DoSoapRingPull, MT_COIN)
addHook("MobjThinker", DoSoapRingPull, MT_BLUESPHERE)

//delete forcefields without owners
addHook("MobjThinker", function(mobj)
	local ff = mobj
	if not ff.target
	and ((ff) and (ff.valid))
		SoapCONS_F(print, 0, "\x85Soapy Forcefield failed to despawn! Deleting anyway...")
		P_RemoveMobj(ff)
	elseif ((ff.target) and (ff.target.valid))
		//since railai bots arent real players, they dont playerthink
		//so we'll move the ff here
		P_MoveOrigin(ff,ff.target.x,ff.target.y,ff.target.z)
	end
end, MT_SOAPYFORCEFIELD)

//respawn dropped soap-chasing rings
addHook("MobjFuse", function(mobj)
	if mobj.soapChaseTimer
		mobj.type = mobj.info.painchance
		P_RemoveMobj(mobj)
		return true
	end
end)

local function SoapBoosterBoost(t, tm)
		if not SoapMobjThinkerAllowed("booster_boost")
			return
		end
		
		if not L_ZCollide(t,tm) then return end
		
		if not tm 
		or not tm.valid 
		or not tm.player
		or tm.player.mo.skin ~= "soapthehedge"
			return
		end
		
		local lastspeed = tm.player.soaptable.accSpeed
		local p = tm.player
		local me = p.mo
		
		if not p.soaptable
			SoapCONS_F(f, p, "\x85"+"Soaptable error at Booster Stop")
			SoapCONS_F(f, p, "\x85"+"Soap's table isn't valid yet!")
			return
		end
		local soap = p.soaptable
		
	//	if ((t.type == MT_REDBOOSTER) or (t.type == MT_YELLOWBOOSTER))
			SoapResetBounceAndDiveVars(p, me, soap)
			P_Thrust(me, t.angle, lastspeed+32*me.scale)
			S_StartSound(me,sfx_sdmsfx)
			if p.dashmode < 3*TICRATE
				p.dashmode = 3*TICRATE
			end
			
			//if not (p.pflags & PF_SPINNING)
			//	p.pflags = $ & PF_JUMPED|PF_THOKKED
				p.pflags = $ &~PF_SPINNING
				if soap.onGround
					if soap.accSpeed >= p.runspeed
						me.state = S_PLAY_RUN
					else
						me.state = S_PLAY_WALK
					end
				end
		//	end
//		end
end

addHook("MobjCollide", SoapBoosterBoost, MT_REDBOOSTER)
addHook("MobjCollide", SoapBoosterBoost, MT_YELLOWBOOSTER)

//let enemies and badniks and stuff slip on bananas!
addHook("MobjCollide", function(t,tm)
	if not t
	or not t.valid
		return
	end
	
	if not tm
	or not tm.valid
		return
	end
	
	if not L_ZCollide(t,tm) then return end
	if not (tm.flags & MF_ENEMY) then return end
	
	S_StartSound(tm,sfx_slip)
	tm.soapbananapeeled = 1
	
	tm.flags2 = $|MF2_DONTDRAW
	
	local ragdoll = P_SpawnMobjFromMobj(tm,0,0,0,MT_SOAP_RAGDOLL)
	//lets make the ragdoll look like the guy we just killed
	tm.tics = -1
	ragdoll.sprite = tm.sprite
//	ragdoll.sprite2 = target.sprite2
	ragdoll.color = tm.color
	ragdoll.angle = tm.angle
	ragdoll.frame = tm.frame
	ragdoll.soapbananapeeled = 1
	ragdoll.rngspin = P_RandomRange(0,1)
	ragdoll.soapdontkill = 4
	
	P_SetObjectMomZ(ragdoll,17*FRACUNIT)
	P_Thrust(ragdoll,ragdoll.angle,14*ragdoll.scale)

	SoapAddToCombo(t.tracer.player,t.tracer.player.soaptable,true)
	P_KillMobj(t,tm,tm)
end, MT_SOAP_BANANA_PEEL)
//bounce banana peeled enemies
addHook("MobjMoveBlocked", function(me, thing, line)
	if me
	and me.soapbananapeeled
		
		if me.soapbananapeeled
			P_BounceMove(me)
			S_StartSound(me,P_RandomRange(sfx_spnsd0,sfx_spnsd7))
			me.momx = 3*$/2
			me.momy = 3*$/2
		end
		
	end
end, MT_SOAP_RAGDOLL)

//if the banana peel's owner isnt valid, then delete it
addHook("MobjThinker", function(mobj)
	if not mobj
	or not mobj.valid
		return
	end
		
	if not mobj.tracer
	or not mobj.tracer.valid
	or not mobj.tracer.player
	or not mobj.tracer.player.valid
		P_KillMobj(mobj,mobj,mobj)
		
	end
end, MT_SOAP_BANANA_PEEL)
//same for dead bodies
addHook("MobjThinker", function(mobj)
	if not mobj
	or not mobj.valid
		return
	end
	
	if not mobj.target
	or not mobj.target.valid
	or not mobj.target.player
	or not mobj.target.player.valid
	
		local poof = P_SpawnMobjFromMobj(mobj, 0, 0, 0, MT_TNTDUST)
		poof.scale = 2*mobj.scale
		poof.destscale = mobj.scale/2
		
		SoapCONS_F(print, 0, "\x85".."Found dead body without an owner! Deleting....")
		P_RemoveMobj(mobj)
	end
end, MT_SOAP_DEAD_BODY)

//do banana slipping
addHook("MobjDeath", function(target,inflictor,source)
	table.remove(LB_Soap.bananalist, LB_Soap.bananalist[target])

	local peeled = P_SpawnMobjFromMobj(target,0,0,0,MT_SOAP_BANANA_PEEL_DEAD)	
//	peeled.angle = InvAngle(R_PointToAngle2(target.x,target.y,source.x,source.y)
	peeled.angle = target.angle

	
	if not source
	or not source.valid
//	or not inflictor
//	or not inflictor.valid
		return
	end
	
	if not target.tracer
	or not target.tracer.valid
		return
	end
	
//	if not source.player
//	or not source.player.valid
//		return
//	end
	
	if source == target
		return
	end
	
	if source == target.tracer
	and target.soapslipwait
		return true
	end
		
	if ((target.tracer) and (target.tracer.valid))
	and source.player ~= target.tracer.player
	or source.flags & MF_ENEMY
		P_AddPlayerScore(target.tracer.player,10)
		
		local plus10 = P_SpawnMobjFromMobj(target.tracer, 0, 0, 50*target.tracer.scale, MT_SOAPPLUS10TEXT)
		plus10.timealive = 1
		plus10.scale = (3*FRACUNIT/4)
		if (not (gametyperules & GTR_FRIENDLY))
			plus10.color = target.tracer.player.skincolor
		else
			plus10.color = SKINCOLOR_WHITE
		end
		
		if source.player
			CONS_Printf(target.tracer.player,"\x82"..source.player.soaptable.ctfnamecolor.."\x82 slipped on your banana! Got 10 points!")
		//	CONS_Printf(source.player,"\x8D".."Silly! You slipped on "..target.tracer.player.soaptable.ctfnamecolor.."\x8D".."'s banana peel!")
			print(target.tracer.player.soaptable.ctfnamecolor.."'s Banana Peel slipped "..source.player.soaptable.ctfnamecolor.."!")
		elseif source.flags & MF_ENEMY
			CONS_Printf(target.tracer.player,"\x82".."An enemy slipped on your banana! Got 10 points!")
		end
	end
	
	if source.player == target.tracer.player
		CONS_Printf(target.tracer.player,"\x8D".."Clumsy! You slipped on your own banana peel!")
		print(target.tracer.player.soaptable.ctfnamecolor.." slipped on their own banana peel.")
	end
	
	local p
	if source.player
	and source.player.valid
		p = source.player
	end
	
	local me
	if source.flags & MF_ENEMY
		me = source
	elseif source.player
	and source.player.valid
		me = p.mo
	end
	
	local soap
	if p
		soap = p.soaptable
	end
	
	P_SetObjectMomZ(me,17*FRACUNIT)
	if p
		P_Thrust(me,p.drawangle,14*me.scale)
		soap.bananatime = 1
		soap.bananabounce = SoapFetchConstant("banana_bounce")
	elseif me.flags & MF_ENEMY
		P_Thrust(me,me.angle,14*me.scale)
	end
	S_StartSound(me,sfx_slip)
	if p
		p.pflags = $ &~(PF_SPINNING|PF_JUMPED|PF_THOKKED)
		me.state = S_PLAY_PAIN
		soap.bananapeeled = 1
		soap.bananaskid = 0
	end
	
end, MT_SOAP_BANANA_PEEL)

//stupid hook that removes bananas from the list

addHook("MobjRemoved", function(banan)
//	if not banan.soapCommandKilled then return end
	
//	table.remove(LB_Soap.bananalist, LB_Soap.bananalist[banan])

	local peeled = P_SpawnMobjFromMobj(banan,0,0,0,MT_SOAP_BANANA_PEEL_DEAD)	
	peeled.angle = banan.angle
	
end, MT_SOAP_BANANA_PEEL)


addHook("MobjSpawn", function(mobj)
	mobj.fuse = 3*TICRATE/2
	mobj.rollangle = ANGLE_180
	P_SetObjectMomZ(mobj,5*FRACUNIT)
	P_InstaThrust(mobj,mobj.angle,5*FRACUNIT)
end,MT_SOAP_BANANA_PEEL_DEAD)

//KILL people with pvp!
addHook("MobjCollide", function(t, tm)
/*
	if not (CV_FindVar("friendlyfire").value)
	//lets assume you have friendlyfire on with pvp
//	or (gametype ~= GT_PVP)
		return
	end
*/	

	if not tm.player
	or not tm.player.valid
	or not t.player
	or not t.player.valid
	or not tm
	or not tm.valid
	or not t
	or not t.valid
		return
	end

	if not (gametyperules & GTR_TEAMS)
		if not (CV_FindVar("friendlyfire").value and SoapFetchConstant("soap_friendlyfire"))
			return
		end
	else
		if tm.player.ctfteam == t.player.ctfteam
		and not (CV_FindVar("friendlyfire").value and SoapFetchConstant("soap_friendlyfire"))
			return
		end
	end
	
	if tm.player
	and tm.player.valid
	and t.player
	and t.player.valid
		
		if not t.player.soaptable
		or not tm.player.soaptable
			return
		end
		
		local p = tm.player
		local p2 = t.player
		
		local soap = p.soaptable
		local soap2 = p2.soaptable
		
		if ((p.spectator) or (p2.spectator))
			return
		end
				
		if ((p.mo) and (p.mo.valid)) and ((p2.mo) and (p2.mo.valid))

			local me = p.mo
			local me2 = p2.mo
			
			if me.skin == "soapthehedge"
				
				//above or below our target? cancel code!
				if me.z + me.height < me2.z or (me2.z + (me2.height)) < me.z then return end
				
				if not ((me.health) or (me2.health))
					return
				end
				
				if soap.ptaiframing

					//is our target not emitting afterimages?
					if not (soap2.ptaiframing)
					
						//before we can kill them, we need to check
						//if they're taunting so they can parry us
						if ((soap2.flexxing) or (soap2.laughing))
				//		if soap2
							SoapDoParry(me2,me,me)
							S_StartSound(me,sfx_bmslam)
							local bam = P_SpawnMobjFromMobj(me2,0,0,0,MT_TNTDUST)
							bam.state = S_TNTBARREL_EXPL4
							P_KillMobj(me,me2,me2)
							soap.saveddmgt = "DMG_MACH4"
							LaunchTargetFromInflictor(1,me,me2,63*FRACUNIT,soap.accSpeed/5)
							return
						end
						S_StartSound(me2,sfx_sdmkil)
						S_StartSound(me,sfx_bmslam)
						
						local bam = P_SpawnMobjFromMobj(me2,0,0,0,MT_TNTDUST)
						bam.state = S_TNTBARREL_EXPL4 

						soap2.dmmach4 = true
						soap2.dmmach4phase = 1						
						P_DamageMobj(me2, me, me, 1, DMG_INSTAKILL)
						soap2.dmmach4 = true
						soap2.dmmach4phase = 1

						soap.saveddmgt = "DMG_MACH4"
						
						if me2.skin ~= "soapthehedge"
							SoapFlashPals(p2,PAL_NUKE,5)
						end
						
						SoapQuakes(p,10*FRACUNIT,5)
						SoapQuakes(p2,10*FRACUNIT,5)
						
						P_SetObjectMomZ(me2, 15*FRACUNIT+(soap.accSpeed/9), false)
						
						LaunchTargetFromInflictor(1,me2,me,63*FRACUNIT,soap.accSpeed/5)

						P_AddPlayerScore(p, 100)
						local plus100 = P_SpawnMobjFromMobj(me, 0, 0, 50*me.scale, MT_SOAPPLUS100TEXT)
						plus100.timealive = 1
						plus100.scale = (3*FRACUNIT/4)
						if (not (gametyperules & GTR_FRIENDLY))
							plus100.color = p.skincolor
						else
							plus100.color = SKINCOLOR_WHITE
						end

						//extra dsashmode than from enemies
						p.dashmode = $ + 20
					
					//so we both are afterimaging!
					elseif ((soap.ptaiframing) and (soap2.ptaiframing))
						
						me.angle = R_PointToAngle2(me.x,me.y,me2.x,me2.y)
						me2.angle = R_PointToAngle2(me2.x,me2.y,me.x,me.y)
						
						//hurt p2
						P_DamageMobj(me2, me, me)
						P_KillMobj(me2,me,me)
		//				P_Thrust(me2,p.drawangle,-15*me2.scale)
						//hurt p1
						P_DamageMobj(me,me2,me2)
						P_KillMobj(me,me,me2)
		//				P_Thrust(me,p2.drawangle,-15*me.scale)

						p.dashmode = 0
						p2.dashmode = 0
						soap.dmmach4clash = 3
						soap2.dmmach4clash = 3
						soap.saveddmgt = "DMG_MACH4"
						soap2.saveddmgt = "DMG_MACH4"
												
						S_StartSound(me2,sfx_sdmkil)
						S_StartSound(me,sfx_bmslam)
						SoapQuakes(p,10*FRACUNIT,5)
						SoapQuakes(p2,10*FRACUNIT,5)
						
						//spawn thing!
						local bam = P_SpawnMobjFromMobj(me,0,0,0,MT_TNTDUST)
						bam.state = S_TNTBARREL_EXPL4 
						local bam = P_SpawnMobjFromMobj(me2,0,0,0,MT_TNTDUST)
						bam.state = S_TNTBARREL_EXPL4 
												
						//fling!
						LaunchTargetFromInflictor(1,me2,me,63*FRACUNIT,soap.accSpeed/5)
						LaunchTargetFromInflictor(1,me,me2,63*FRACUNIT,soap2.accSpeed/5)
						
					end
					
				end
			end
		end
	end
	
end, MT_PLAYER)

local function KillThingMach4(t,tm)
	if not ((t) and (t.valid) and (t.player) and (t.player.valid))
		return
	end
		
	//so we ran into an enemy?
	if ((tm) and (tm.valid))
		if not ((tm.flags & MF_ENEMY) or (tm.flags & MF_MONITOR)) then return end
		if not ((t) and (t.valid) and (t.player) and (t.player.valid) and (t.skin == "soapthehedge")) then return end
		if not tm.health then return end
		
		if (L_ZCollide(tm,t) == false) then return end

		if t.player.soaptable.ptaiframing
		or t.player.powers[pw_super]
			
			local bam = P_SpawnMobjFromMobj(t,0,0,0,MT_TNTDUST)
			bam.state = S_TNTBARREL_EXPL4
			
			t.player.dashmode = $+35

			P_KillMobj(tm,t,t)
			return false
		end
	end
end

//KILL enemies when we walk into them!!
addHook("MobjCollide", KillThingMach4, MT_PLAYER)
addHook("MobjMoveCollide", KillThingMach4, MT_PLAYER)

//slam into walls!
//i have this run only is this is a dev build, because i dont think people
//would like it, if you're wondering
addHook("MobjMoveBlocked", function(mo, thing, line)
	if not mo
	or not mo.valid
	or not SoapFetchConstant("soap_devbuild")
	or (leveltime)
		return
	end
	
	local p = mo.player
	local soap = p.soaptable
	
	if p.mo
	and p.mo.valid
		local me = p.mo
		
		if me.skin ~= "soapthehedge"
			return
		end
		
		if soap.accSpeed < p.runspeed-(10*FRACUNIT)
			return
		end
		
		if ((thing) and (thing.valid)) or ((line) and (line.valid))
			if soap.ptaiframing
				if thing and thing.valid
					if thing.flags & MF_MONITOR
						return
					end
					
					P_DoPlayerPain(p, thing, thing)
					P_InstaThrust(me,thing.angle,(25*FRACUNIT))
				elseif line and line.valid
					P_DoPlayerPain(p)
					P_Thrust(me,p.drawangle,(-soap.accSpeed/5)-((soap.wallslamcount*FRACUNIT)*3/2))
				end
				if not (p.dashmode >= 4*TICRATE)
					S_StartSound(me,sfx_shldls)	
				end
				SoapFlashPals(p,PAL_NUKE,5)
				S_StartSound(me,sfx_bmslam)	
				soap.recovwait = -99*FRACUNIT
				//unfortunatly i have to make it to where you can escape from this
				me.momz = ((15*FRACUNIT)-((soap.wallslamcount*FRACUNIT)*3/2))*soap.gravflip
				soap.wallslamcount = $+1
			end
		end
	end
end, MT_PLAYER)
//

addHook("MobjMoveBlocked", function(mo, thing, line)
	if not mo
	or not mo.valid
		return
	end
		
	if ((line) and (line.valid))
		if line and line.valid
			P_BounceMove(mo)
		end
		S_StartSound(mo,sfx_tink)	
	end
end, MT_SOAP_RAGDOLL)


//hide our shield if we have a forcefield!
addHook("MobjThinker", function(shield)
	if shield and shield.valid
		if not shield.target return end
	
		if not (shield.flags2 & MF2_SHIELD)
			return
		end
		/*
		if not ((shield.type == MT_ELEMENTAL_ORB) or (shield.type == MT_ATTRACT_ORB))
		or not ((shield.type == MT_FORCE_ORB) or (shield.type == MT_ARMAGEDDON_ORB))
		or not ((shield.type == MT_PITY_ORB) or (shield.type == MT_FLAMEAURA_ORB))
		or not ((shield.type == MT_THUNDERCOIN_ORB) or (shield.type == MT_BUBBLEWRAP_ORB))
			return
		end
		*/
		
		if shield.target.player
			if shield.target.player.soaptable
				if ((shield.target.player.soaptable.forcefield) and (shield.target.player.soaptable.forcefield.valid))
					shield.flags2 = $|MF2_DONTDRAW
				else
					shield.flags2 = $ & ~MF2_DONTDRAW
				end
			end
		end
	end
end, MT_OVERLAY)

addHook("MobjThinker", function(bbl)
	if bbl and bbl.valid
		if not (bbl.eflags & MFE_UNDERWATER)
		or (bbl.eflags & MFE_JUSTHITFLOOR)
			P_RemoveMobj(bbl)
			return
		end
		bbl.momz = (FRACUNIT/2)*P_MobjFlip(bbl)
		
		bbl.momx = P_RandomRange(-1, 1)*FRACUNIT
		bbl.momy = P_RandomRange(-1, 1)*FRACUNIT
		
		if bbl.tracer
		and bbl.tracer.valid
			bbl.eflags = bbl.tracer.eflags
		end
	end
end, MT_SOAPBUBBLESMALL)
addHook("MobjThinker", function(bbl)
	if bbl and bbl.valid
		if not (bbl.eflags & MFE_UNDERWATER)
		or (bbl.eflags & MFE_JUSTHITFLOOR)
			P_RemoveMobj(bbl)
			return
		end
		bbl.momz = (FRACUNIT/2)*P_MobjFlip(bbl)
		
		bbl.momx = P_RandomRange(-1, 1)*FRACUNIT
		bbl.momy = P_RandomRange(-1, 1)*FRACUNIT
		
		if bbl.tracer
		and bbl.tracer.valid
			bbl.eflags = bbl.tracer.eflags
		end
	end
end, MT_SOAPBUBBLEMEDIUM)


//bounce off of walls when we hit them!
addHook("MobjMoveBlocked", function(me, thing, line)
	if me
	and me.player
	and not me.player.spectator
		local p = me.player
		local soap = p.soaptable
		
		
			if p.playerstate == PST_DEAD
				if ((me.skin == "soapthehedge") or (soap.dmmach4phase == 1))
					if line or thing
						P_BounceMove(me)
						S_StartSound(me,sfx_bmslam)
							
						SoapFlashPals(p,PAL_NUKE,5)
						SoapQuakes(p,10*FRACUNIT,5)
						
						local bam = P_SpawnMobjFromMobj(me,0,0,0,MT_TNTDUST)
						bam.state = S_TNTBARREL_EXPL4 

					end
				end
			else
				if soap.bananapeeled
					P_BounceMove(me)
					S_StartSound(me,P_RandomRange(sfx_spnsd0,sfx_spnsd7))
					me.momx = 3*$/2
					me.momy = 3*$/2
				end
			end
	end
end, MT_PLAYER)

/*
addHook("PlayerJoin", function()
	if SoapFetchConstant("soap_yellowdemon")
		//notify joining people if yellowdemon is on
		chatprint("\x86"+"Welcome! Soap's Yellow Demon is\x85 ON!\x86 Soap-chasing rings will kill when collected.")
	end
	
end)
*/

//pretty small prethinkframe, but it looks cleaner with this
addHook("PreThinkFrame", do
for player in players.iterate
	if not player
	or not player.valid
	or not player.mo
	or not player.mo.valid
	or not player.soaptable
		return
	end
	
	if player.mo.valid
		local p = player
		local me = p.mo
		local soap = p.soaptable
				
		if me.skin == "soapthehedge"
			if not me.health
				
				//so we dont stay on death pits
				if P_CheckDeathPitCollide(me)
					me.flags = $|MF_NOCLIPHEIGHT
				end
		
			//else
				//soap.prevmomx, soap.prevmomy, soap.prevmomz = me.momx,me.momy,me.momz
			end
			
			soap.last.pos = {me.x,me.y,me.z}
			soap.last.mom = {me.momx,me.momy,me.momz}
			soap.last.leveltime = leveltime
		end
		
		//global prethinker
		
		if soap.cosmenucanopen
		and ((p.cmd.buttons & BT_USE) and (p.cmd.buttons & BT_CUSTOM3))
		and not ((soap.cosmenuopen) or (soap.cosmenujustopened))
			COM_BufInsertText(p, "soap_cos_menu true")
			p.cmd.buttons = $ & ~BT_USE & ~BT_CUSTOM3
			p.pflags = $ & ~(PF_STARTDASH|PF_SPINNING|PF_SPINDOWN)
			me.state = S_PLAY_STND
		end
		
		//menu thinker for us
		if soap.cosmenuopen
			SoapCosmeticsMenuThinker(p,me,soap)
		end
	end
end //iterator
end)

addHook("PostThinkFrame", function()
for player in players.iterate
	if not player
	or not player.valid
	or not player.mo
	or not player.mo.valid
	or not player.soaptable
		return
	end
	
	if player.mo.valid
		local p = player
		local me = p.mo
		local soap = p.soaptable
		
		//global postthinker
		if soap.onGround
			if soap.bananaskid
				me.frame = A
				me.sprite2 = SPR2_DEAD
			end
		end
	end
end //iterator


end)



//just hit and ran a dude with mach4? fling 'em!!
addHook("MobjDeath", function(target, inflictor, source, dmgt)
	if not (target.flags & MF_ENEMY) return end
	if not ((target) and (target.valid) and (source) and (source.valid) and (source.player) and (source.skin == "soapthehedge") and ((source.player.soaptable.ptaiframing) or (source.player.powers[pw_super]))) return end
	//ok... so our stuff is valid?
	local p = source.player
	
	S_StopSound(target)
	SoapQuakes(p,20*FRACUNIT,4)
	S_StartSound(source,sfx_sdmkil)
	//lets hide the target so its ragdoll can take over!
	target.flags2 = $|MF2_DONTDRAW
	
	local ragdoll = P_SpawnMobjFromMobj(target,0,0,0,MT_SOAP_RAGDOLL)
	//lets make the ragdoll look like the guy we just killed
	target.tics = -1
	ragdoll.sprite = target.sprite
//	ragdoll.sprite2 = target.sprite2
	ragdoll.color = target.color
	ragdoll.angle = target.angle
	ragdoll.frame = target.frame
	ragdoll.rngspin = P_RandomRange(0,1)
	ragdoll.soapdontkill = 4
	P_SetObjectMomZ(ragdoll, 15*FRACUNIT+(p.soaptable.accSpeed/9), false)
	LaunchTargetFromInflictor(1,ragdoll,source,63*FRACUNIT,p.soaptable.accSpeed/5)
end)

addHook("MobjThinker", function(mobj)
	if not mobj
	or not mobj.valid
	or not mobj.health
		return
	end
	
	if mobj.valid
		local mo = mobj
		
		if not mo.soapragdollkill
			if mo.soapdontkill
				mo.soapdontkill = $-1
			end
			
			if mo.soapdeadtimer == nil then mo.soapdeadtimer = 1 end
			mo.soapdeadtimer = $+1
			
			//flung for too long? then kill us anyway!
			if (mo.soapdeadtimer >= (2*TICRATE))
				HaltMobjMomentum(mo)
				mo.flags = $ | MF_NOGRAVITY
				mo.soapdeadtimer = 0
				local rag = P_SpawnMobjFromMobj(mo, 0, 0, 0, MT_SOAP_RAGDOLL)
				rag.sprite = mo.sprite
				rag.tracer = mo
				rag.rollangle = mo.rollangle
				rag.angle = mo.angle
				rag.color = mo.color
				rag.soapragdollkill = 1
				S_StartSound(rag,sfx_pop)
				if mo.soapbananapeeled
					S_StartSound(rag,sfx_sdmkil)
				end
				P_KillMobj(mo)
				mo.rollangle = 0
			
			end
			
			//mach 4 fling
			if not P_IsObjectOnGround(mo)
				AddToRollangle(mo,ANG20,mo.rngspin)
				mo.angle = $+(ANGLE_45)
				if (leveltime % 5) == 0
					local poof = P_SpawnMobjFromMobj(mo,0,0,mo.height/2,MT_SPINDUST)
					poof.scale = FixedMul(2*FRACUNIT,mo.scale)
					poof.color = mo.color
					poof.colorized = true
					poof.destscale = mo.scale/4
					poof.scalespeed = FRACUNIT/4
					poof.fuse = 10				
				end
			else
				if not mo.soapdontkill
					HaltMobjMomentum(mo,true)
					mo.flags = $ | MF_NOGRAVITY
					mo.soapdeadtimer = 0
					local rag = P_SpawnMobjFromMobj(mo, 0, 0, 0, MT_SOAP_RAGDOLL)
					rag.sprite = mo.sprite
					rag.tracer = mo
					rag.rollangle = mo.rollangle
					rag.angle = mo.angle
					rag.color = mo.color
					rag.soapragdollkill = 1
					S_StartSound(rag,sfx_pop)
					if mo.soapbananapeeled
						S_StartSound(rag,sfx_sdmkil)
					end
					P_KillMobj(mo)
					mo.rollangle = 0
				end
			end
			
		else
			//can you stop breaking sprites
			mo.frame = A
			mo.tics = -1
			if ((mo.tracer) and (mo.tracer.valid))
				HaltMobjMomentum(mo,true)
				if leveltime % 2 == 0
					mo.flags2 = $|MF2_DONTDRAW
				else
					mo.flags2 = $&~MF2_DONTDRAW
				end
			else
				SoapCONS_F(print, 0, "\x85".."Found ragdoll without an owner! Deleting...")
				P_RemoveMobj(mo)
			end
		end
	end
end, MT_SOAP_RAGDOLL)

//end of soap stuff!

//maybe we should do soap constants for other people?
//^i did

//not sure why i added player instead of p
//i think i was gonna do something with #player, or maybe it just needs
//player in the function for #player to work

//i just realized!@@
//"#player" refers to the number of players, right?
//"p" and "player" are basically the same thing, right?
//so maybe "#p" works just like "#player"!
/*
addHook("PlayerThink", function(player)
	if player.mo
		local devmode = CV_FindVar("devmode")
		if (devmode == nil)
			devmode = 0
		end
		if not player.soaptable
			if devmode
				SoapCONS_F(f, player, "\x85"+"Soaptable error at Global Console Spam")
				SoapCONS_F(f, player, "\x85"+"Soap's table isn't valid yet!")
			end
			return
		end
		if player.soaptable.debugStats
			SoapConsoleStatSpam(player, player.mo, player.soaptable)
		end
	end
end)
*/

//GT_YELLOWDEMON jingles
addHook("PlayerSpawn", function(p)
		if not p
		or not p.valid
		or not p.mo
		or not p.mo.valid
			return
		end
		
		if gametype == GT_YELLOWDEMON
			if p.mo.health
			and S_MusicName() ~= "DEATHM"
			and S_MusicName() ~= "_SHOES"
			and S_MusicName() ~= "_DROWN"
		//		P_PlayJingleMusic(p, "DEATHM", 0, true, JT_MASTER)
				COM_BufInsertText(p, "tunes DEATHM")
				//why cant i use tunes??????
				S_ChangeMusic("DEATHM", true, consoleplayer)
			end
			
		end
end)
addHook("PlayerThink", function(p)
		if not p
		or not p.valid
			return
		end

		if gametype == GT_YELLOWDEMON
			if p.pflags & PF_GAMETYPEOVER
			or p.lives == 0
			and S_MusicName() ~= "YFASYD"
			and not splitscreen
		//		COM_BufInsertText(p, "tunes YFASYD")
				S_ChangeMusic("YFASYD", false, p)
			end
		end
end)


addHook("HurtMsg", function(p, inflict, source)
//	if gametype ~= GT_YELLOWDEMON
//	or not SoapFetchConstant("soap_yellowdemon")
	if not p
	or not p.valid
		return
	end
	
	if not p.soaptable
		return
	end
	
	local soap = p.soaptable
	//we'll assume our mo is valid
	local me = p.mo
	
	if soap.yellowdemonkill == 1
		if not (gametyperules & GTR_TEAMS)
			print(p.name+"\x80 ("+tostring(skins[me.skin].realname)+") was killed by a Yellow Demon.")
			return true
		else
			print(soap.ctfnamecolor+"\x80 ("+tostring(skins[me.skin].realname)+") was killed by a Yellow Demon.")
			return true
		
		end
/*	elseif p.soaptable.yellowdemonkill >= 2
		print(p.name+" ("+tostring(skins[p.mo.skin].realname)+") was hurt by a Yellow Demon.")
		return true
	
*/	elseif soap.dmbombdive
		if ((source) and (source.valid) and (source.player) and (source.player.valid))
			if not (gametyperules & GTR_TEAMS)
				if me.health
//					print(p.name + "\x80 was hurt by "+source.player.name+"'s Bomb Dive.")
					print(source.player.name.."'s Bomb Dive hurt "..p.name)
					return true
				else
//					print(p.name + "\x80 was killed by "+source.player.name+"'s Bomb Dive.")
					print(source.player.name.."'s Bomb Dive killed "..p.name)
					return true				
				end
			else
				if me.health
//					print(soap.ctfnamecolor + "\x80 was hurt by "+source.player.soaptable.ctfnamecolor+"'s Bomb Dive.")
					print(source.player.soaptable.ctfnamecolor.."'s Bomb Dive hurt "..soap.ctfnamecolor)
					return true
				else
//					print(soap.ctfnamecolor + "\x80 was killed by "+source.player.soaptable.ctfnamecolor+"'s Bomb Dive.")
					print(source.player.soaptable.ctfnamecolor.."'s Bomb Dive killed "..soap.ctfnamecolor)
					return true				
				end
			
			end
		end
	elseif soap.dmmach4
		if ((source) and (source.valid) and (source.player) and (source.player.valid))
			if not (gametyperules & GTR_TEAMS)
				if me.health
//					print(p.name + "\x80 was hurt by "+source.player.name+"'s Mach 4 Dash.")
					print(source.player.name.."'s Mach 4 Dash hurt "..p.name)
					return true
				else
//					print(p.name + "\x80 was killed by "+source.player.name+"'s Mach 4 Dash.")
					print(source.player.name.."'s Mach 4 Dash killed "..p.name)
					return true				
				end
			else
				if me.health
//					print(soap.ctfnamecolor + "\x80 was hurt by "+source.player.soaptable.ctfnamecolor+"'s Mach 4 Dash.")
					print(source.player.soaptable.ctfnamecolor.."'s Mach 4 Dash hurt "..soap.ctfnamecolor)
					return true
				else
//					print(soap.ctfnamecolor + "\x80 was killed by "+source.player.soaptable.ctfnamecolor+"'s Mach 4 Dash.")
					print(source.player.soaptable.ctfnamecolor.."'s Mach 4 Dash killed "..soap.ctfnamecolor)
					return true				
				end
			
			end
		end	
	elseif soap.dmassblast
	
		if ((source) and (source.valid) and (source.player) and (source.player.valid))
		
			if not me.health
				print(source.player.soaptable.ctfnamecolor.."'s ".."\x82".."ASS BLAST\x80 killed "..soap.ctfnamecolor)
				return true		
			else
				print(source.player.soaptable.ctfnamecolor.."'s ".."\x82".."ASS BLAST\x80 killed "..soap.ctfnamecolor)
				return true					
			end

		end
		
	elseif soap.dmsupertaunt
		
		if ((source) and (source.valid) and (source.player) and (source.player.valid))
		
			if not me.health
				print(source.player.soaptable.ctfnamecolor.."'s \x82Super Taunt\x80 killed "..soap.ctfnamecolor)
				return true		
			else
				print(source.player.soaptable.ctfnamecolor.."'s \x82Super Taunt\x80 hurt "..soap.ctfnamecolor)
				return true					
			end

		end
	elseif soap.dmbounce

		if ((source) and (source.valid) and (source.player) and (source.player.valid))
		
			if not me.health
				print(source.player.soaptable.ctfnamecolor.."'s Bounce move killed "..soap.ctfnamecolor)
				return true		
			else
				print(source.player.soaptable.ctfnamecolor.."'s Bounce move hurt "..soap.ctfnamecolor)
				return true					
			end

		end
		
	elseif soap.dmphysprop

		if ((source) and (source.valid) and (source.player) and (source.player.valid))
		
			if not me.health
				print(source.player.soaptable.ctfnamecolor.."'s Physics Prop killed "..soap.ctfnamecolor)
				return true		
			else
				print(source.player.soaptable.ctfnamecolor.."'s Physics Prop hurt "..soap.ctfnamecolor)
				return true					
			end

		end
	
	elseif soap.dmbananaclash

		if ((source) and (source.valid) and (source.player) and (source.player.valid))
		
			if not me.health
				print(source.player.soaptable.ctfnamecolor.." managed to crash into "..soap.ctfnamecolor.." and kill them")
				return true		
			else
				print(source.player.soaptable.ctfnamecolor.." managed to crash into "..soap.ctfnamecolor)
				return true					
			end

		end
	
	end
end)

addHook("MobjThinker", function(mobj)
	if not mobj
	or not mobj.valid
	or not mobj.target
		return
	end
	
	if ((mobj.target) and (mobj.target.valid))
		local p = mobj.target.player
		local me = mobj.target
		if p.powers[pw_carry] == CR_MINECART and ((gametype == GT_YELLOWDEMON) or (SoapFetchConstant("soap_yellowdemon") and me.skin == "soapthehedge"))
			
			//eject if we're being chased
			if p.cmd.buttons & BT_USE
				p.powers[pw_carry] = CR_NONE
				p.pflags = $ |PF_JUMPED & ~PF_THOKKED
				me.momx = mobj.momx
				me.momy = mobj.momy
				me.momz = (8*FRACUNIT)*P_MobjFlip(me)
				P_DoJump(p,true)
				mobj.target = nil
				return
			end
		end
	end
end, MT_MINECART)

local function YDmusic(old, new)
	if gametype ~= GT_YELLOWDEMON
	or splitscreen
		return
	end
	
	if old ~= "DEATHM"
		return
	end
	
	//if our new song is equal to one of these, let it play!
	if new == "_INV"
	or new == "_SHOES"
	or new == "_DROWN"
	or new == "_1UP"
	or new == "DEATHM"
		return false
	else
		return true
	end
	
end

addHook("MusicChange", YDmusic)

//ze stuff
//i miss the old ze, though it could do without the droolers in there
//im not sure if you guys've noticed, but hamitto's ze has terrible
//indenting, and a ludicrous amount of [if p.mo.skin == __ then elseif p.mo.skin...]
//like, even I could probably code something better than that
//yandere simulator lookin code 
/*
addHook("PlayerThink", function(p)
	//the obligatory wall of "if or or or or return end"
	if not p
	or not p.valid
	or (gametype ~= GT_ZESCAPE)
	or (gametype ~= GT_ZSWARM)
	or not SoapFetchConstant("soap_devbuild")
	or not p.mo
	or not p.mo.valid
		return
	end
	
	
end)
*/

//bouncing on a thing? lets handle that here
//TODO: do stupid stuff and make a death copy for monitors
//why is it doing that ???
addHook("MobjDamage", function(target, inflictor, source)
	if target.player
	or not (source and source.skin == "soapthehedge" and source.player and source.player.soaptable)
		return
	end

	local p = source.player	
	local soap = source.player.soaptable
	local me = p.mo
	
	if (target.flags & (MF_ENEMY|MF_BOSS))
		
		//cancel our bounce!
		if inflictor and inflictor.player
		
			if target.flags & MF_BOSS
				inflictor.player.soaptable.hitboss = true
			end

			//bouncin down
			if ((soap.bounced) and (not soap.bounceagain))
			//	soap.groundtime = 1
				soap.bounced = 0
				//lol!
				SoapDoBounce(p,me,soap)
				me.momz = 0
				me.momz = ( (22*me.scale)-((soap.bouncecount)*(1+(1/2))) )*soap.gravflip
			end
			
			//diving onto it? lets do this!
			if soap.starteddive
				
				soap.glowyeffects = 16
				
				//this is just copy paste, but it prevents the
				//c stack overflow error, so...
				if (target.flags & MF_BOSS)
					
					soap.starteddive = 0
					me.momz = (22*me.scale)*soap.gravflip
					S_StartSound(me,sfx_sparry)
					
					local bam = P_SpawnMobjFromMobj(me,0,0,0,MT_TNTDUST)
					bam.state = S_TNTBARREL_EXPL4 
					
				end
				
				if not soap.isSuper
					PVPEarthQuake(me, me, abs(soap.divemomz)*3,me,"dive")
				else
					PVPEarthQuake(me, me, abs(soap.divemomz)*6,me,"dive")
				end
				
				soap.starteddive = 0
				me.momz = (22*me.scale)*soap.gravflip
				S_StartSound(me,sfx_sparry)
				
				local bam = P_SpawnMobjFromMobj(me,0,0,0,MT_TNTDUST)
				bam.state = S_TNTBARREL_EXPL4 
				
				if not (target.flags & MF_BOSS)
				and target.valid
					P_KillMobj(target,me,me)
				end
				
				p.pflags = $ &~PF_THOKKED
				me.state = S_PLAY_JUMP
				SoapResetBounceAndDiveVars(p,me,soap)
			end
			
		end
	end
end)

//thing died by soap
freeslot("MT_SOAP_MOBJHOLDER")
addHook("MapThingSpawn", function(mo,map)
	if  mo.flags & (MF_NOTHINK|MF_SCENERY)
		return
	end
	
	mo.spawn = {
		pos = {mo.x,mo.y,mo.z},
		angle = mo.angle,
		flags = mo.flags,
		flags2 = mo.flags2,
		eflags = mo.eflags,
		type = mo.type,
		scale = mo.scale,
		state = mo.state,
		sprite = mo.sprite,
	}
end)
addHook("MobjSpawn", function(mo)
	mo.prev = {}
end,MT_SOAP_MOBJHOLDER)

addHook("MobjThinker", function(mo)
	if not mo
	or not mo.valid
		return
	end
	
	if mo.prev.phase == 1
		mo.flags2 = $|MF2_DONTDRAW
	elseif mo.prev.phase == 2
		if not (leveltime % 2)
			mo.flags2 = $|MF2_DONTDRAW
		else
			mo.flags2 = $ &~MF2_DONTDRAW
		end
		mo.flags = $|MF_NOCLIP|MF_NOGRAVITY
		local x,y,z = unpack(mo.prev.pos)
		P_SetOrigin(mo,x,y,z)
	end
	
end,MT_SOAP_MOBJHOLDER)
addHook("MobjFuse", function(mo)
	if mo.prev.phase == 1
		mo.prev.phase = 2
		return true
	end
	
end,MT_SOAP_MOBJHOLDER)

addHook("MobjDeath", function(target, inflictor, source)
	if not (source and source.skin == "soapthehedge" and source.player and source.player.soaptable)
		return
	end
	
	local p = source.player	
	local soap = source.player.soaptable
	local me = p.mo
	
	if (target.flags & MF_ENEMY)
	or ((target.player) and (target.player.valid))
		if not soap.supertauntready
			if (target.flags & MF_ENEMY)
				soap.supertauntkillsleft = $-1
			elseif ((target.player) and (target.player.valid))
				soap.supertauntfragsleft = $-1
			end
		end
		if not target.soapalreadykilled
			SoapAddToCombo(inflictor.player,soap,true)
		end
		if ((target.player) and (target.player.valid)) then return end
	end
	
	if (target.flags & (MF_MONITOR))
	
		//cancel our bounce!
		if inflictor and inflictor.player
		
			if not target.soapalreadykilled
				SoapAddToCombo(inflictor.player,soap,true)
			end
			
			//1ups and 10k score boxes give us super taunts
			if target.type == MT_1UP_BOX
			or target.type == MT_SCORE10K_BOX
				
				if source.skin == "soapthehedge"
					source.player.soaptable.supertauntkillsleft = 0
				end
				
			end

			//bouncin down
			if ((soap.bounced) and (not soap.bounceagain))
			//	soap.groundtime = 1
				soap.bounced = 0
				//lol!
				SoapDoBounce(p,me,soap)
				me.momz = 0
				me.momz = ( (22*me.scale)-((soap.bouncecount)*(1+(1/2))) )*soap.gravflip
			end
			
			//diving onto it? lets do this!
			if soap.starteddive
				
				soap.starteddive = 0
				me.momz = (22*me.scale)*soap.gravflip
				SoapResetBounceAndDiveVars(p,me,soap)
				soap.starteddive = 1
				
			end
			
		end
	end
end)

//parry
addHook("MobjDamage", SoapDoParry,MT_PLAYER)

/*
addHook("MobjDamage", function(mo)
	if mo
	and mo.valid
		
		if mo.skin == "soapthehedge"
			if mo.player.soaptable.combocount
				mo.player.soaptable.combotime = $-(TICRATE+(3*TICRATE/2))
			end
			
			if (gametype == GT_COOP)

				local minus50 = P_SpawnMobjFromMobj(mo, 0, 0, 3*mo.height/2, MT_SOAPMINUS50TEXT)
				minus50.timealive = 1
				minus50.scale = (3*FRACUNIT/4)
				minus50.color = SKINCOLOR_RED
				
				if mo.player.soaptable.score >= 50
				and mo.player.score >= 50
					P_AddPlayerScore(mo.player,-50)
				else
					P_AddPlayerScore(mo.player,-mo.player.score)
				end
			end
			
		end
		
	end
end,MT_PLAYER)
*/

addHook("MobjThinker", function(mobj)
	mobj.timealive = $ + 1
	local flip = P_MobjFlip(mobj)
	if (mobj.timealive & 25 == 0)
		mobj.frame = B|FF_FULLBRIGHT
	else
		mobj.frame = A|FF_FULLBRIGHT
	end
	
	if mobj.timealive <= 7
		mobj.z = $ - ((7-mobj.timealive)*FRACUNIT)*flip
	else
		mobj.z = $ + FRACUNIT*flip
	end
	
	if mobj.timealive >= 30
		mobj.frame = $|FF_TRANS80
	elseif mobj.timealive >= 25
		mobj.frame = $|FF_TRANS70
	elseif mobj.timealive >= 20
		mobj.frame = $|FF_TRANS50
	elseif mobj.timealive >= 10
		mobj.frame = $|FF_TRANS30
	end
end, MT_SOAPMINUS50TEXT)


addHook("MobjMoveCollide", function(mo,inflict)
	if not mo
	or not mo.valid
		return
	end
	
	if not (inflict.flags & (MF_ENEMY|MF_BOSS))
	or not L_ZCollide(mo,inflict)
		return
	end
	
	local p = mo.player
	local me = p.mo
	local soap = p.soaptable
	
	if soap.bananapeeled
	or soap.bananaskid
		if ((inflict.player) and (inflict.player.valid))
			inflict.player.soaptable.dmbananaclash = 3
		end
		P_DamageMobj(inflict,me,me)
		return true
	end
	
end,MT_PLAYER)

//after image
addHook("MobjThinker", function(ai)
	if not ai
	or not ai.valid
		return
	end
	
	//we need a thing to follow
	if not ai.target
	or not ai.target.valid
		SoapCONS_F(print, 0, "\x85".."Found an afterimage without an owner! Deleting...")
		P_RemoveMobj(ai)
		return
	end
	

	if (leveltime % 6) > 3
//		ai.frame = $|TR_TRANS70
		ai.flags2 = $|MF2_DONTDRAW
	else
//		ai.frame = $ &~TR_TRANS70
		ai.flags2 = $ &~MF2_DONTDRAW
	end
	
	local p = ai.target.player
	local me = p.mo
	local soap = p.soaptable
	
	ai.spritexoffset = me.spritexoffset
	ai.spriteyoffset = me.spriteyoffset
	
	ai.colorized = true
	if not ai.timealive
		ai.timealive = 1
	else
		ai.timealive = $+1
	end
	
	//no interpolation please fingers crossed???????
	//i said PLEASE
	P_SetOrigin(ai, ai.x, ai.y, ai.z)
	
	if soap.isFirstPerson
	or soap.isSuperTaunting
		ai.flags2 = $|MF2_DONTDRAW
	end
	
	local fuselimit = SoapFetchConstant("afterimages_fuse")

/*
	if ai.soapsupertauntclone
		fuselimit = SoapFetchConstant("afterimages_st_fuse")
		ai.tics = -1
	end
*/
		
	//because fuse doesnt wanna work
	if ai.timealive > fuselimit
		table.remove(LB_Soap.afterimageslist,LB_Soap.afterimageslist[ai])
		P_RemoveMobj(ai)
		return
	end
	
end, MT_SOAP_AFTERIMAGE_OBJECT)

freeslot("MT_SOAP_SUPERTAUNT_FLYINGBOLT")
addHook("MobjThinker", function(spark)
	if not spark
	or not spark.valid
		return
	end
	
	if not spark.target
	or not spark.target.valid
		SoapCONS_F(print, 0, "\x85Super Taunt Spark missing parent!")
		P_RemoveMobj(spark)
		return
	end
	
	local p = spark.target.player
	local soap = p.soaptable
	
	if soap.isFirstPerson
		spark.flags2 = $|MF2_DONTDRAW
	else
		spark.flags2 = $ &~MF2_DONTDRAW
	end
	
end, MT_SOAP_SUPERTAUNT_FLYINGBOLT)

freeslot("MT_SOAP_TAUNTFLASH")
addHook("MobjThinker", function(flash)
	if not flash
	or not flash.valid
		return
	end
	
	if not flash.target
	or not flash.target.valid
		SoapCONS_F(print, 0, "\x85Taunt flash missing parent!")
		P_RemoveMobj(flash)
		return
	end
	
	local me = flash.target
	local p = me.player
	local soap = p.soaptable
	P_MoveOrigin(flash, me.x,me.y,me.z)
	
	if soap.isFirstPerson
		flash.flags2 = $|MF2_DONTDRAW
	else
		flash.flags2 = $ &~MF2_DONTDRAW	
	end
end, MT_SOAP_TAUNTFLASH)

//memory leaks!!
--[[
freeslot("MT_SOAP_FLINGSOLID")
//init fling solids
addHook("MobjSpawn", function(fling)
	fling.prev = {
		mobj = 0,
		pos = {0,0,0},
		flags = 0,
		flags2 = 0,
		eflags = 0,
		angle = 0,
		scale = FRACUNIT,
		phase = 1,
		special = false,
		canspike = true,
		children = {},
	}
	fling.timealive = 1
	fling.rngspin = P_RandomRange(0,1)
end, MT_SOAP_FLINGSOLID)

//break solids when we bash into them
addHook("MobjMoveCollide", function(tm, t)
	if not SoapFetchConstant("soap_solidsbreak")
		return
	end
	
	if not t
	or not t.valid
		return
	end
	
	if (t.type == MT_SOAP_FLINGSOLID)
	and t.tracer == tm
	and t.timealive < 5
		return false
	end
	
	//touching our fling solid? look for a thing and throw it at em!
	if (t.type == MT_SOAP_FLINGSOLID)
	and t.tracer == tm
	and t.timealive > 5
	and t.prev.canspike
	and L_ZCollide(tm,t)
		t.flags = $ &~MF_SOLID
		
		if tm.player.soaptable.SjumpDOWN
			P_DoJump(tm.player,true)
		end
		P_SetObjectMomZ(t,-66*tm.scale)
	end
	
	//are we valid?
	if not tm
	or not tm.valid
		return
	end
	
	//is our player valid?
	if not tm.player
	or not tm.player.valid
		return
	end
	
	//are we soap?
	if tm.player.mo.skin ~= "soapthehedge"
		return
	end
	
/*
	if not (
	(tm.player.soaptable.accSpeed >= 3*skins["soapthehedge"].normalspeed/2)
	or
	(tm.player.soaptable.ptaiframing)
	)
		return
	end
*/	
	//is the object valid?
	if not t
	or not t.valid
		return
	end
	
	//is the object solid?
	if not (t.flags & MF_SOLID)
		return
	end
	
	//we already break spike things, no need to break them here
	if (t.type == MT_SPIKE)
	or (t.type == MT_WALLSPIKE)
	or (t.type == MT_SPIKEBALL)
	or (t.type == MT_BOMBSPHERE)
		return
	end
	
	//we wont break these
	local flg = t.flags
	if (flg & (MF_MONITOR|MF_PUSHABLE|MF_SPECIAL|MF_NOCLIP|MF_NOCLIPHEIGHT|MF_PAIN))
	or ((t.player) and (t.player.valid))
	or (t.type == MT_SOAP_FLINGSOLID)
	or (t.type == MT_STEAM)
	or ((t.state <= S_GOLDBOX_OFF7) and (t.state >= S_GOLDBOX_OFF1))
	or ((t.type <= MT_CACTISMALLSEG) and (t.type >= MT_CACTI1))
	or (t.type == MT_ROLLOUTROCK)
		return
	end
	
	if not (L_ZCollide(tm,t))
		return
	end
	
	S_StartSound(t,sfx_crumbl)
	S_StartSound(t,sfx_wbreak)
	S_StartSound(t,sfx_wbrkpt)
	
	if tm.player 
		SoapQuakes(tm.player,35*FRACUNIT,4)
		tm.player.dashmode = $+25
		//SoapAddToCombo(tm.player,tm.player.soaptable,true)
	end
		
	local bam = P_SpawnMobjFromMobj(tm,0,0,0,MT_TNTDUST)
	bam.state = S_TNTBARREL_EXPL4 

	//spawn a fling thing that looks exactly like the thing we bashed
	local fling = P_SpawnMobjFromMobj(t,0,0,0,MT_SOAP_FLINGSOLID)
	fling.state = t.state
	fling.sprite = t.sprite
	if tm.player
		fling.tracer = tm
	else
		fling.tracer = tm.tracer
	end
	
	fling.prev.mobj = t.type
	fling.prev.pos = {t.x,t.y,t.z}
	fling.prev.flags = t.flags
	fling.prev.flags2 = t.flags2
	fling.prev.eflags = t.eflags
	fling.prev.angle = t.angle
	fling.prev.scale = t.scale
	
	fling.height = 6*t.height/5
	fling.radius = t.radius*2
	
	fling.fuse = 3*TICRATE
	
	fling.scale = t.scale
	fling.angle = R_PointToAngle2(t.x,t.y, tm.x,tm.y)

	LaunchTargetFromInflictor(2,fling,tm,6*t.scale,tm.player.soaptable.accSpeed/5)
	P_SetObjectMomZ(fling,15*FRACUNIT)
	
	//we're done here! remove the bashed thing and return!
	P_RemoveMobj(t)
	return false
end, MT_PLAYER)

//respawn the flung solid
addHook("MobjFuse", function(fling)
	if fling.prev.phase == -1
		print(fling.fuse)
	elseif fling.prev.phase == 1
		local x,y,z = unpack(fling.prev.pos)
		local fling2 = P_SpawnMobj(x,y,z,MT_SOAP_FLINGSOLID)
		local t = fling
		
		fling2.state = t.state
		fling2.sprite = t.sprite
		fling2.tracer = t.tracer
		
		fling2.flags = $|MF_NOGRAVITY
	
		fling2.prev.mobj = fling.prev.mobj
		fling2.prev.pos = fling.prev.pos
		fling2.prev.flags = fling.prev.flags
		fling2.prev.flags2 = fling.prev.flags2
		fling2.prev.eflags = fling.prev.eflags
		fling2.prev.angle = fling.prev.angle

		fling2.height = t.height
		fling2.radius = t.radius

		fling2.target = fling
		fling2.fuse = 30
		fling2.prev.phase = 2
		S_StartSound(fling2,sfx_monton)
		return false
	elseif fling.prev.phase == 2
		local x,y,z = unpack(fling.prev.pos)
		local new = P_SpawnMobj(x,y,z,fling.prev.mobj)
		new.flags = fling.prev.flags
		new.flags2 = fling.prev.flags2
		new.eflags = fling.prev.eflags
		new.angle = fling.prev.angle
		new.scale = fling.prev.scale
		
		P_RemoveMobj(fling)
		return true	
	end
end,MT_SOAP_FLINGSOLID)

addHook("MobjThinker",function(fling)
	if not fling
	or not fling.valid
		return
	end
	
	if not fling.tracer
	or not fling.tracer.valid
		SoapCONS_F(print, 0, "\x85".."Deleted Fling Solid without a target.")
		local x,y,z = unpack(fling.prev.pos)
		local new = P_SpawnMobj(x,y,z,fling.prev.mobj)
		new.flags = fling.prev.flags
		new.flags2 = fling.prev.flags2
		new.eflags = fling.prev.eflags
		new.angle = fling.prev.angle
		new.scale = fling.prev.scale
		P_RemoveMobj(fling)
	end
	
	if fling.prev.phase == 1
		
		if fling.timealive < 5
			fling.flags = $ &~MF_SOLID
		else
			fling.flags = $|MF_SOLID
		end
		
		if fling.timealive >= TICRATE*2
			SoapCONS_F(print, 0, "\x85".."Deleted long lasting Fling Solid.")
			local x,y,z = unpack(fling.prev.pos)
			local new = P_SpawnMobj(x,y,z,fling.prev.mobj)
			new.flags = fling.prev.flags
			new.flags2 = fling.prev.flags2
			new.eflags = fling.prev.eflags
			new.angle = fling.prev.angle
			new.scale = fling.prev.scale
			P_RemoveMobj(fling)
			return
		end
		
		print("\x83iphokftogsg")
		
		AddToRollangle(fling,(ANG1+ANG2),fling.rngspin)
		if not fling.prev.special
			fling.flags = $|MF_NOCLIPHEIGHT
			fling.timealive = $+1
			if (leveltime % 5) == 0
				local dust = P_SpawnMobjFromMobj(fling,0,0,fling.height/2,MT_SPINDUST)
				dust.scale = FixedMul(2*FRACUNIT,fling.scale)
				dust.color = fling.tracer.color
				dust.colorized = true
				dust.destscale = fling.scale/4
				dust.scalespeed = FRACUNIT/4
				dust.fuse = 10
			end
		else
			if (leveltime % 2) == 0
				fling.flags2 = $|MF2_DONTDRAW
			else
				fling.flags2 = $ &~MF2_DONTDRAW
			end
		
		end
		
		if P_IsObjectOnGround(fling)
		and fling.timealive > 3
			if not (fling.flags & MF_SOLID)
				PVPEarthQuake(fling,fling.tracer,700*fling.scale,fling,"physprop","source")
				fling.flags = $|MF_SOLID
			end
			if fling.prev.canspike == false
				PVPEarthQuake(fling,fling.tracer,700*fling.scale,fling,"physprop","source")
			end
			fling.fuse = TICRATE
			fling.prev.special = true
			P_SetObjectMomZ(fling,10*FRACUNIT)
			S_StartSound(fling,sfx_pstop)
			fling.prev.canspike = false
			local bam = P_SpawnMobjFromMobj(fling,0,0,0,MT_TNTDUST)
			bam.state = S_TNTBARREL_EXPL4
		end
	elseif fling.prev.phase == 2
		fling.angle = fling.prev.angle
		if fling.fuse >= 11
			if (leveltime % 2) == 0
				fling.flags2 = $|MF2_DONTDRAW
			else
				fling.flags2 = $ &~MF2_DONTDRAW
			end
			fling.flags = $ &~MF_SOLID
		else
			fling.flags2 = $ &~MF2_DONTDRAW
			fling.flags = $|MF_SOLID
		end
		
	end
end,MT_SOAP_FLINGSOLID)

//kill things with fling solids
addHook("MobjMoveCollide", function(tm, t)
	//make flingsolids break other solids
	
	//are we valid
/*
	if not tm
	or not tm.valid
		return
	end
*/	
	//is our target valid?
	if not t
	or not t.valid
		return
	end

	//is our target our tracer?
	if (t == tm.tracer)
	or tm.prev.children[t]
		return false
	end
	
	if not L_ZCollide(tm,t)
		return
	end
	
//	if t.type == MT_PLAYER
//		return
//	end
	
	local flg = t.flags
	
	if flg & MF_SPECIAL
		return
	end
	
	if (flg & MF_SOLID)
	and tm.timealive > 3
	//and t.type ~= MF_FLINGSOLID
	
		tm.fuse = 3*TICRATE
		tm.prev.phase = 1
		tm.prev.special = false
		
		if t.type == MT_PLAYER
		
			if ((t.player) and (t.player.valid))
				//are there teams?
				if (gametyperules & GTR_TEAMS)
					if (t.player.ctfteam == tm.tracer.player.ctfteam)
					and not ((CV_FindVar("friendlyfire").value and SoapFetchConstant("soap_friendlyfire")))
						return
					end
				else
					if not ((CV_FindVar("friendlyfire").value and SoapFetchConstant("soap_friendlyfire")))
						return
					end
				end

				t.player.soaptable.dmphysprop = 3		
				P_DamageMobj(t,tm.tracer,tm.tracer)
				P_SetObjectMomZ(tm,15*FRACUNIT)
				tm.fuse = 3*TICRATE

			end

			return
			
		end
		
		//this is ours now thank you	
		if t.type == MT_SOAP_FLINGSOLID
			//SoapAddToCombo(tm.tracer.player,tm.tracer.player.soaptable,true)
			t.tracer = tm.tracer
			table.insert(tm.prev.children,t)
			P_SetObjectMomZ(t,15*FRACUNIT)
			LaunchTargetFromInflictor(2,t,tm,6*t.scale,FixedDiv(abs(FixedHypot(tm.momx,tm.momy)), tm.scale))
			return true
		end
		
		//we wont break these
		local flg = t.flags
		if (flg & (MF_MONITOR|MF_PUSHABLE|MF_SPECIAL|MF_NOCLIP|MF_NOCLIPHEIGHT|MF_PAIN))
		or ((t.player) and (t.player.valid))
		or (t.type == MT_SOAP_FLINGSOLID)
		or (t.type == MT_STEAM)
		or ((t.state <= S_GOLDBOX_OFF7) and (t.state >= S_GOLDBOX_OFF1))
		or ((t.type <= MT_CACTISMALLSEG) and (t.type >= MT_CACTI1))
			return
		end

		S_StartSound(t,sfx_crumbl)
		S_StartSound(t,sfx_wbreak)
		S_StartSound(t,sfx_wbrkpt)

		local bam = P_SpawnMobjFromMobj(t,0,0,0,MT_TNTDUST)
		bam.state = S_TNTBARREL_EXPL4 

		//spawn a fling thing that looks exactly like the thing we bashed
		local fling = P_SpawnMobjFromMobj(t,0,0,0,MT_SOAP_FLINGSOLID)
		fling.state = t.state
		fling.sprite = t.sprite
		fling.tracer = tm.tracer
		table.insert(tm.prev.children,t)
		
		fling.prev.mobj = t.type
		fling.prev.pos = {t.x,t.y,t.z}
		fling.prev.flags = t.flags
		fling.prev.flags2 = t.flags2
		fling.prev.eflags = t.eflags
		fling.prev.angle = t.angle
		fling.prev.scale = t.scale
		
		fling.height = 6*t.height/5
		fling.radius = t.radius*2
		
		fling.fuse = 3*TICRATE
		
		fling.scale = t.scale
		fling.angle = R_PointToAngle2(t.x,t.y, tm.x,tm.y)

		LaunchTargetFromInflictor(2,fling,tm,6*t.scale,FixedDiv(abs(FixedHypot(tm.momx,tm.momy)), tm.scale))
		P_SetObjectMomZ(fling,15*FRACUNIT)
		
		P_RemoveMobj(t)
		return false

	end
	
	if (flg & MF_ENEMY)
	and not (flg & MF_BOSS)
		//SoapAddToCombo(tm.tracer.player,tm.tracer.player.soaptable,false)
		P_KillMobj(t,tm,tm.tracer)
		P_SetObjectMomZ(tm,15*FRACUNIT)
		tm.fuse = 3*TICRATE
	elseif (flg & MF_BOSS)
		P_DamageMobj(t,tm,tm.tracer)
		P_SetObjectMomZ(tm,15*FRACUNIT)
		tm.fuse = 3*TICRATE
	end
	
	if ((t.player) and (t.player.valid))
		//are there teams?
		if (gametyperules & GTR_TEAMS)
			if (t.player.ctfteam == tm.tracer.player.ctfteam)
			and not ((CV_FindVar("friendlyfire").value and SoapFetchConstant("soap_friendlyfire")))
				return
			end
		else
			if not ((CV_FindVar("friendlyfire").value and SoapFetchConstant("soap_friendlyfire")))
				return
			end
		end

		t.player.soaptable.dmphysprop = 3		
		P_DamageMobj(t,tm.tracer,tm.tracer)
		P_SetObjectMomZ(tm,15*FRACUNIT)
		tm.fuse = 3*TICRATE

	end

end,MT_SOAP_FLINGSOLID)
--]]

//whatever
addHook("MobjThinker", function(thok)
	if not thok
	or not thok.valid
		return
	end
	
	if not thok.tracer
	or not thok.tracer.valid
		//dont remove the thok or else regular thok trails wont appear
		return
	end
	
	if thok.tracer.player.soaptable.isFirstPerson
		thok.flags2 = $|MF2_DONTDRAW
	else
		thok.flags2 = $ &~MF2_DONTDRAW
	end
end,MT_THOK)


local listofshields = {
	MT_ELEMENTAL_ORB,
	MT_ATTRACT_ORB,
	MT_FORCE_ORB,
	MT_ARMAGEDDON_ORB,
	MT_WHIRLWIND_ORB,
	MT_PITY_ORB,
	MT_FLAMEAURA_ORB,
	MT_BUBBLEWRAP_ORB,
	MT_THUNDERCOIN_ORB,
	MT_IVSP
}

//test this!!!!
addHook("MobjThinker", function(shield)
	if not shield
	or not shield.valid
		return
	end
	
	if not shield.target
	or not shield.target.valid
		return
	end
	
	if shield.target.type == MT_ELEMENTAL_ORB
	or shield.target.type == MT_ARMAGEDDON_ORB
		if shield.target.target.player.soaptable.isSuperTaunting
		//or ((shield.target.target.player.soaptable.forcefield.valid) and (shield.target.target.player.soaptable.forcefield.valid))	
			shield.flags2 = $|MF2_DONTDRAW
		elseif (shield.flags2 & MF2_DONTDRAW)
			shield.flags2 = $ & ~MF2_DONTDRAW
		end
	end
	
end,MT_OVERLAY)

local function hideshield(shield)
	if not shield
	or not shield.valid
		return
	end
	
	if not shield.target
	or not shield.target.valid
		return
	end
	
	if listofshields[shield.target.type]
		if shield.target.player.soaptable.isSuperTaunting
		or ((shield.target.player.soaptable.forcefield) and (shield.target.player.soaptable.forcefield.valid))	
			shield.flags2 = $|MF2_DONTDRAW
		elseif (shield.flags2 & MF2_DONTDRAW)
			shield.flags2 = $ & ~MF2_DONTDRAW
		end
	
	end
end

addHook("MobjThinker", hideshield, MT_ELEMENTAL_ORB)
addHook("MobjThinker", hideshield, MT_ATTRACT_ORB)
addHook("MobjThinker", hideshield, MT_FORCE_ORB)
addHook("MobjThinker", hideshield, MT_ARMAGEDDON_ORB)
addHook("MobjThinker", hideshield, MT_WHIRLWIND_ORB)
addHook("MobjThinker", hideshield, MT_PITY_ORB)
addHook("MobjThinker", hideshield, MT_FLAMEAURA_ORB)
addHook("MobjThinker", hideshield, MT_THUNDERCOIN_ORB)
addHook("MobjThinker", hideshield, MT_IVSP)

//starposts refill combo bar
addHook("MobjSpawn", function(post)
	post.activators = {}
end, MT_STARPOST)

addHook("TouchSpecial", function(post,touch)

	//thanks amperbee
	if not post.activators[touch]
		post.activators[touch] = true
		if touch.player.soaptable.combocount
			
			for i = 0, 14
				SoapAddToCombo(touch.player,touch.player.soaptable,false)
			end
			
		end

	end
end, MT_STARPOST)

addHook("JumpSpecial", function(p)
	if not p
	or not p.valid
		return
	end
	
	if p.soaptable
		local soap = p.soaptable
		
		if soap.bananapeeled
		or soap.momzfreezeadd
		or soap.starteddive
			return true
		end
	end
end)