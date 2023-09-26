//init all of soaps stuff here!!
//istg if rolltrol doesnt work om gonan cry :(((
//im gonna cry ;(
//im not gonna cry B)

//lb for luigi budd
rawset(_G,"LB_Soap",{})
local lb = LB_Soap
lb.bananalist = {}
lb.afterimageslist = {}
lb.rankfillx = {
	35*FRACUNIT,
	36*FRACUNIT,
	32*FRACUNIT,
	36*FRACUNIT,
}
lb.rankfilly = {
	39*FRACUNIT,
	40*FRACUNIT,
	43*FRACUNIT,
	44*FRACUNIT,
}
lb.backuprankscores = {
	35000,
	50000,
	0,
	20200,
	12400,
	0,
	310600,
	20960,
	0,
	72000,
	232860,
	0,
	13316,
	9000,
	0,
	18220,
	nil,
	nil,
	nil,
	nil,
	nil,
	7210,
	59400,	
	nil,
	449080,
	0,
	0,
	nil,
	nil,
	64410,
	25600,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,	
	80400,
	11440,
	79960,
}

//this is gamemap indexed
lb.rankscores = {
	//gfz
	35000,
	50300,
	0,
	//thz
	20200,
	12400,
	0,
	//dsz
	310600,
	20960,
	0,
	//cez
	72000,
	232860,
	0,
	//acz
	13316,
	9000,
	0,
	//rvz
	18220,
	
	//blanks
	nil,
	nil,
	nil,
	nil,
	nil,
	
	//erz
	7210,
	59400,
	
	nil,
	
	//bcz
	449080,
	0,
	0,
	
	nil,
	nil,
	
	//fhz
	64410,
	//ptz
	25600,
	
	//i dont have the rest unlocked :(
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	
	//hhz
	80400,
	//agz
	11440,
	//azt
	79960,
	
	
	
}


local pnk = "\x8E"
local wht = "\x80"
rawset(_G, "SoapInitTable", function(p, silent)
	//why print?
if not silent
	CONS_Printf(p,"\x86"+"Initializing Soap's table...")
end

p.soaptable = {
//table
firsttime = 1,
firstttic = 2*TICRATE, //wait before showing text
ftblink = 0, //this determines how long the text blinks for
ftkill = nil, //timer for killing the text
	//some lag notif stuff for admins
	//the way i wrote firsttime is pretty confusing, so i'll try to clean
	//it up for this one

rolltrol = 1,
soapUncurl = 1,
flexxing = 0,
laughing = 0,
disableMomen = 0,
canMomen = 1,
recurlAble = 1,
dashpreserve = 0,
curlPainStasis = 0,
dashBoostSfxREADY = 0,
dashBoostSfx = 0,
sdmsfxREADY = 0,
sdmsfx = 0,
thehorror = 0,
dispensercooldown = 0,
momzfreeze = 0,
	//momzfreezeadd = 0,
	//ghostcolor = 0,
airdashtimer = 0, //like adventure sonic's far thok!
airdashed = 0,
airdashwait = 0,
airdashing = 0,
airdashanim = 0, 
	//jumptrailtimer = 0,
nerfed = 0,
nerfbuff = 0,
nerfmebuff = 0,
recovwait = 0,
devmode = 0,
	//ptaicolor = 1,
ptaiframing = 0,
accSpeed = 0,
spindown = 0,
gravflip = 1,
fullstasistic = 0,
cantdive = 0,
	//dived = 0,
	//diving = 0,
	//divefallwait = 0,
	//candivewait = 0,
	//divecancel = 0,
goobounce = 0,
helpedpoyo = 0,
saveddmgt = 0,
body = 0,
noballroll = 0,
bounced = 0,
bounceagain = 0,
bouncecount = 0,
forceuse = 0,
attracttarg = 0,
attracthome = 0,
justSpunREADY = 0,
justSpunNOW = 0,
spinning = 0,
spindowncurl = 0,
forcefield = 0,
uncurlframe = 0,
hudshieldability = 0,
alreadyloaded = 0,
	//contrary to popular belief, groundtime actually counts down
	//how long youre allowed to be on the ground (for bounce)
	//groundtime = 0, 
YDcount = 0,
yellowdemonkill = 0,
canbounce = 1,
justhurtREADY = 0,
justhurtNOW = 0,
wallslamcount = 0,
pvpnerf = 1, //this is pretty stupid, considering i already have soap.nerfed,
			 //but i coded that thing a little weird, so im doin it again!!!!
ctfnamecolor = 0,
diveanimstart = 0,
starteddive = 0,
divemomz = 0,
divecancel = 0,
cantdive = 0,
bananapeeled = 0,
bananaskid = 0,
bananatime = 0, //failsafe incase you never land while banana peeled
bananabounce = 0,
boombox = 0,
c2down = 0,
breakdancing = 0,
breakdanceframe = {
	0,1,2,3,4,
	//loop
	5,6,7,8,9,10,11,12,13,14
},
flytoggle = 0,
flycooldown = 0,
glowyeffects = 0, //fancy effects for diving on an enemy 
unsuperREADY = 0,
unsuperNOW = 0,
spintrailcolor = 0, //for supercolor mod
trailed = false, //a boolean?????!??!?!!!
levelstartscore = 0,
score = 0,
rankscore = 0,
rank = 1,
lastrank = 1,
rankgrow = 0,
lastmap = 1,
alreadyannounced = false,
pizzatowerstuff = 0,
hitboss = false,
timeshurt = 0,

//combo stuff
combocount = 0,
combotime = 0,
comboendtics = 0,
comboendscore = 0,
comboendvery = false,
comboendrank = 1,
comborank = 1,
combovery = false,
comborankuptic = 0,
combodropped = false,
comboranks = {
	"Lame...",
	"\x83Soapy",
	"\x88".."Alright...",
	"\x8B".."Going Places!",
	"\x82Nice!",
	"\x84".."Gamer!",
	"\x8D".."Destructive!",
	"\x87".."Demolition Expert!",
	"\x85Menacing!",
	"\x86WICKED!!",
	"\x85".."Adobe Flash!",
	"\x86Robo!",
	"\x88".."BLAST!!",
	"F"..pnk.."u"..wht.."n"..pnk.."n"..wht.."y"..pnk.."!",
	"\x86Unfunny."
},

//super taunt stuff
	//supertaunted = 0,
supertauntedbefore = 0,
supertaunthudhelper = 0,
supertauntready = 0,
supertauntringsleft = 85,
supertauntkillsleft = 40,
supertauntfragsleft = 10, //kills from players
supertauntid = 0,
supertauntspritexoffset = {
	-200*FRACUNIT,
	67*FRACUNIT,
	26*FRACUNIT,
	4,
	0			//assblast
},
supertauntspriteyoffset = {
	0,
	-100*FRACUNIT,
	-25*FRACUNIT,
	4,
	0			//assblast
},
supertaunttimer = -1,

//cosmetics menu
cosmenuwait = 0,
cosmenucanopen = 0,
cosmenuopen = 0,
cosmenujustopened = 0,
cosmenuleft = 0,
cosmenuright = 0,
cosmenuup = 0,
cosmenudown = 0,
cosmenujump = 0,
cosmenuspin = 0,
cosmenuflipn = 0,
cosmenuflipp = 0,
cosmenucurx = 0,
cosmenucury = 0,
cosmenuselect = 0,
cosmenupage = 0,
cosmenucooldown = 0,
	//timeshurt = 0, //timeshit?
	//hurttextshow = -1,
	//parried = 0,
	//parryflash = 0,

//cosmetics
cosspinglow = 1,
cosquakes = 1,
cosflashes = 1,
cosbuttered = 1,
cosspeedometer = 2, //1 for FRACs, 2 for values divided by FRACUNIT
cosclocksound = 0,
costrailstyle = 1, //1 for regular, 2 for ffoxD's smooth spintrails
cosusedlimitbefore = 0,

//devmode
	//bblx = 127,
	//bbly = 118,
ftx = 160,
fty = 60,
	//bombxd = 100,
	//bombyd = 20,

//constants
isDash = 0,
onGround = 0,
isSoap = 0,
isValid = 0,
isIdle = 0,
isXmo = 0,
isXmoON = 0,
isSuper = 0,
isSuperM = 0,
isElevated = 0, //i plan to do something with this in the future, not sure what though
inPain = 0,
noShield = 0,
isSol = 0,
isTransform = 0, //see if we're in TRNS frames
isWatered = 0,
isBoostm = 0, //boostmentum
isGod = 0, //quick check for godmode
isCloneF = 0,
isFirstPerson = 0,
isZE = 0,
isSuperTaunting = 0,

//buttons
StossflagREADY = 0,
StossflagDOWN = 0,
Scustom1READY = 0,
Scustom1DOWN = 0,
Scustom2READY = 0,
Scustom2DOWN = 0,
Scustom3READY = 0,
Scustom3DOWN = 0,
SspinREADY = 0,
SspinDOWN = 0,
SjumpREADY = 0,
SjumpDOWN = 0,
SfirenREADY = 0,
SfirenDOWN = 0,
//one-shot buttons
StossflagOS = 0,
Scustom1OS = 0,
Scustom2OS= 0,
Scustom3OS= 0,
SspinOS = 0,
SjumpOS = 0,
SfirenOS = 0,

//hud stuff
hudquakeshakex = 0,
hudquakeshakey = 0,
hudflashespulse = 0,
hudclocksounddisp = 0,

//death/hurt messages
// ctrl+f "HurtMsg"
dmbombdive = 0,
dmmach4 = 0,
	//this isnt really a death message helper, but its useful for player deaths
dmmach4phase = 0,
dmsupertaunt = 0,
dmassblast = 0,
dmbounce = 0,
dmphysprop = 0,
dmbananaclash = 0,

prev = {
	set = false,
	mom = {},
	angle = 0,
	drawangle = 0,
	pflags = 0,
	state = 0,
	frame = 0,
	tics = 0,
	sprite2 = 0,
	
},
last = {
	pos = {},
	mom = {},
	leveltime = 0,
},

}

//dont know why i didnt put these tables in soaptable
//i thought you couldn't have tables inside a table
//but i can put soaptable in player_t? (a table)
p.SOAPfreefallFL = {
	0,
	1
}


p.ballframes = {
	0,
	1,
	3,
	4
}

p.soapPityFrames = {
	0,
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	11
}

p.diveballframes = {
	0,
	1,
	2,
	3
}
//now we can tell if this actually worked or not
if not silent
CONS_Printf(p, "\n"+"\x84"+"Initialized Soap the Hedge's variables!")
if SoapFetchConstant("soap_devbuild")
CONS_Printf(p, "")
CONS_Printf(p, "Please do "+"\x85"+"NOT "+"\x80"+"share or modify "+"\x85"+"ANY "+"\x80"+"part of this DEV file! Or else I'll cry :(")
CONS_Printf(p, "")
CONS_Printf(p, "If you want versions you can host with or share, check out his Message Board page!")
CONS_Printf(p, "\x83"+"https://mb.srb2.org/addons/soap-the-hedge.5028/")
CONS_Printf(p, "")
CONS_Printf(p, "\x82".."If you want sneak peeks at new stuff for Soap, join the SRB2 Soap Server!")
CONS_Printf(p, "\x82".."https://discord.com/invite/JY6ukFuQJV")
end
CONS_Printf(p, "")
CONS_Printf(p, "\x8A"+"Use "+"\x86"+"soap_help"+"\x8A"+" in the console for some help on Soap the Hedge!")
CONS_Printf(p, "\x83"+"Made by luigi budd and coolerguysoverhere")
end
	
	return true
end)

//from chrispy chars!!! by Lach!!!!
local function SafeFreeslot(...)
	for _, item in ipairs({...})
		if rawget(_G, item) == nil
			freeslot(item)
		end
	end
end

SafeFreeslot("SPR2_TPOS")


if not PlayerAnimInfo
	rawset(_G, "PlayerAnimInfo", {})
end

PlayerAnimInfo = {
	["soapthehedge"] = {
		["runFrames"] = {0, 2},
		["dashFrames"] = {0, 1, 2, 3},
		["walkFrames"] = {3, 7},
		["waitFrames"] = {0},
	//	["milnekickFrames"] = {0, 4},
		["run"] = true,
		["dash"] = true,
		["walk"] = true,
		["idle"] = true,
		["wait"] = true,
	//	["milnekick"] = true,
		["superRun"] = true,
		["superDash"] = true,
		["superWalk"] = true,
		["superIdle"] = true,
		["superWait"] = true 
	},
}

//freeslots

//uhh should i translate the socs freeslots into lua?

--SPR_ FREESLOT
SafeFreeslot("SPR_PEEL")

freeslot("SPR_P10T")
freeslot("SPR_P100")
freeslot("SPR_M50T")
freeslot("SPR_SFFS")
//just incase this isnt freeslotted?
//game this was working fine before whats wrong now
freeslot("SPR_STHK")

freeslot("SPR_SBBS")
freeslot("SPR_SBBM")
freeslot("SPR_SBBL")

freeslot("SPR_WDRG")

freeslot("SPR_SBAN")

freeslot("SPR_SBB_")
freeslot("SPR_SBBN")

freeslot("SPR_STB1")
freeslot("SPR_STB2")
freeslot("SPR_STB3")
freeslot("SPR_STB4")
freeslot("SPR_STB5")
SafeFreeslot("SPR_TANT")
SafeFreeslot("SPR_SCTH")


--

--SPR2 FREESLOT

//SafeFreeslot("SRP2_FKIK")
//no fun allowed here!

SafeFreeslot("SRP2_FROZ")

SafeFreeslot("SPR2_HUG_")

SafeFreeslot("SPR2_SHIT")

--

//sprite2 of soap hugging
freeslot("SPR2_SOHG")

freeslot("SPR2_FLEX")

//freeslot("SPR2_LAFF")

SafeFreeslot("SPR2_APOS")

freeslot("SPR2_SFFA")

freeslot("SPR2_SQSH")

freeslot("SPR2_SBDB")

//SUPERTaunt frames
freeslot("SPR2_SSTA")
freeslot("SPR2_SSTB")
freeslot("SPR2_SSTC")

SafeFreeslot("SPR2_BRDA")

//super taunt ass blast
SafeFreeslot("SPR2_STAB")
--

SafeFreeslot("SPR2_JSKI")
if not boatchars
	rawset(_G, "boatchars", {})
end
boatchars["soapthehedge"] = {0, 1, 0}

//originally "SNBR" but i put "SNRB" in the animations
//freeslot("SPR2_SNRB")
spr2defaults[SPR2_FLEX] = SPR2_PAIN
//spr2defaults[SPR2_LAFF] = SPR2_DEAD
spr2defaults[SPR2_APOS] = SPR2_STND
spr2defaults[SPR2_SFFA] = SPR2_FALL


--STATE FREESLOTS

freeslot("S_PLAY_SOAP_FLEX")
states[S_PLAY_SOAP_FLEX] = {
    sprite = SPR_PLAY,
    frame = SPR2_FLEX,
    var2 = 2,
    tics = 1*TICRATE,
    nextstate = S_PLAY_STND
}


freeslot("S_PLAY_SOAP_LAUGH")
states[S_PLAY_SOAP_LAUGH] = {
	sprite = SPR_PLAY,
	frame = SPR2_APOS,
	var2 = 2,
	tics = 1*TICRATE,
	nextstate = S_PLAY_STND
}


freeslot("S_PLAY_SOAP_APOSE")
states[S_PLAY_SOAP_APOSE] = {
	sprite = SPR_PLAY,
	frame = SPR2_APOS,
	var2 = 2,
	tics = -1
}

//dupe that has tpos spr2 for amy (and other chars)
freeslot("S_PLAY_SOAP_TAPOSE")
states[S_PLAY_SOAP_TAPOSE] = {
	sprite = SPR_PLAY,
	frame = SPR2_TPOS,
	var2 = 2,
	tics = -1
}

freeslot("S_PLAY_SOAP_FREEFALL")
states[S_PLAY_SOAP_FREEFALL] = {
	sprite = SPR_PLAY,
	frame = SPR2_SFFA|FF_ANIMATE,
}

freeslot("S_PLAY_SOAP_SKID")
states[S_PLAY_SOAP_SKID] = {
	sprite = SPR_PLAY,
	frame = SPR2_SKID,
	tics = -1
}

//me.height didnt work, so i squished the scrunkly down :(((
freeslot("S_PLAY_SOAP_SQUISH")
states[S_PLAY_SOAP_SQUISH] = {
	sprite = SPR_PLAY,
	frame = SPR2_SQSH,
	tics = -1
}

freeslot("S_PLAY_SOAP_DIVE_START")
freeslot("S_PLAY_SOAP_DIVE_BALL")
states[S_PLAY_SOAP_DIVE_START] = {
	sprite = SPR_PLAY,
	frame = SPR2_FALL,
	tics = 2,
	nextstate = S_PLAY_SOAP_DIVE_BALL
}

//freeslot("S_PLAY_SOAP_DIVE_BALL")
states[S_PLAY_SOAP_DIVE_BALL] = {
	sprite = SPR_PLAY,
	frame = SPR2_SBDB,
	tics = 1,
	nextstate = S_PLAY_SOAP_DIVE_BALL
}


/*
freeslot("S_PLAY_SOAP_NOBALLROLL")
states[S_PLAY_SOAP_NOBALLROLL] = {
	sprite = SPR_PLAY,
	frame = SPR2_SNRB|FF_ANIMATE,
	
}
*/

freeslot("S_PLAY_SOAP_ASSBLAST")
freeslot("S_PLAY_SOAP_SUPERTAUNT1")
freeslot("S_PLAY_SOAP_SUPERTAUNT2")
freeslot("S_PLAY_SOAP_SUPERTAUNT3")
//move to main2.lua
/*
states[S_PLAY_SOAP_SUPERTAUNT] = {
	sprite = SPR_PLAY,
	frame = SPR2_SSTA|FF_ANIMATE,
	var2 = 1,
	tics = 11,
	nextstate = S_PLAY_FALL,
}
*/

--

--SFX FREESLOT

SafeFreeslot("sfx_uncurl.ogg")
sfxinfo[sfx_uncurl].caption = "Uncurl"

freeslot("sfx_srecur.ogg")
sfxinfo[sfx_srecur].caption = "Recurl"

freeslot("sfx_srcrl2")
sfxinfo[sfx_srcrl2].caption = "Quick-curl"

freeslot("sfx_sburst")
sfxinfo[sfx_sburst].caption = "Small Burst"

//sfxinfo[sfx_s25f].caption = "Transformation"

freeslot("sfx_slghtn")
sfxinfo[sfx_slghtn].caption = "Lightning Strike"
sfxinfo[sfx_slghtn] = {
	flags = SF_X8AWAYSOUND
}

freeslot("sfx_snocrl")
sfxinfo[sfx_snocrl].caption = "Failed to Recurl"


//freeslot("sfx_airucl")
//sfxinfo[sfx_airucl].caption = "Uncurl"


freeslot("sfx_hlds")
sfxinfo[sfx_hlds].caption = "Source Engine Death Sound"

freeslot("sfx_slip")
sfxinfo[sfx_slip].caption = "Banana Slip"

freeslot("sfx_x5dish")
//"x5dish"? what does that mean?
//what does x+5 equal in tf2? thats right, need a dis(penser) h(ere)
sfxinfo[sfx_x5dish].caption = '-"Need a dispenser here!"'
sfxinfo[sfx_x5dish] = {
	flags = SF_X8AWAYSOUND
}

freeslot("sfx_flex")
sfxinfo[sfx_flex].caption = "Soap Flexxing"


freeslot("sfx_hahaha")
sfxinfo[sfx_hahaha].caption = "Goofy Laugh"

//hide this from our captions
freeslot("sfx_sdashm")
sfxinfo[sfx_sdashm].caption = "/"

//hide this as well
sfxinfo[sfx_kc38].caption = "/"

sfxinfo[sfx_kc3b].caption = "Super Power Up"

sfxinfo[sfx_kc40].caption = "/"

freeslot("sfx_sdmkil")
sfxinfo[sfx_sdmkil].caption = "\x85Killing Blow!\x80"

freeslot("sfx_sdmsfx")
sfxinfo[sfx_sdmsfx].caption = "Power Up"

freeslot("sfx_wbrkpt")
sfxinfo[sfx_wbrkpt].caption = "/"

//freeslot("sfx_bombcn")
//sfxinfo[sfx_bombcn].caption = "Bomb Drop Cancel"


//freeslot("sfx_bombst")
//sfxinfo[sfx_bombst].caption = "Bomb Drop"

//freeslot("sfx_bomblp")
//sfxinfo[sfx_bomblp].caption = "Bomb Drop"

freeslot("sfx_sostbd")
sfxinfo[sfx_sostbd].caption = "Bomb Drop"

freeslot("sfx_bmslam")
sfxinfo[sfx_bmslam].caption = "Slam"

freeslot("sfx_spfbst")
sfxinfo[sfx_spfbst].caption = "/"

for i = 0, 8
	SafeFreeslot("sfx_bellc"..i)
	sfxinfo[sfx_bellc0 + i].caption = "/"
end

freeslot("sfx_yeeeow")
sfxinfo[sfx_yeeeow].caption = "Cries of pain"

freeslot("sfx_yeldea")
sfxinfo[sfx_yeldea].caption = "\x82Yellow Demon Activation\x80"

freeslot("sfx_shudcl")
sfxinfo[sfx_shudcl].caption = "Menu Close"
freeslot("sfx_shudop")
sfxinfo[sfx_shudop].caption = "Menu Open"
freeslot("sfx_shudmo")
sfxinfo[sfx_shudmo].caption = "Menu Move"
freeslot("sfx_shudsl")
sfxinfo[sfx_shudsl].caption = "Menu Select"
freeslot("sfx_shuddy")
sfxinfo[sfx_shuddy].caption = "Menu Denied"

for i = 0, 7
	SafeFreeslot("sfx_spnsd"..i)
	sfxinfo[sfx_spnsd0 + i].caption = "Slip n' Slide"
end

for i = 0, 2
	SafeFreeslot("sfx_snsed"..i)
	sfxinfo[sfx_snsed0 + i].caption = "Slipped n' Slid"
end

freeslot("sfx_bomtun")
//~130 bpm for the boombox tune
sfxinfo[sfx_bomtun].caption = "Boombox Tune"

SafeFreeslot("sfx_breakd")
sfxinfo[sfx_breakd].caption = "Breakdance!"

//its back baby!!!!
freeslot("sfx_sparry")
sfxinfo[sfx_sparry].caption = "\x82POW!\x80"


sfxinfo[sfx_kc52].caption = "Bounce"
sfxinfo[sfx_kc55].caption = "Drop"

freeslot("sfx_ssptnt")
sfxinfo[sfx_ssptnt].caption = "\x82Super Taunt!!!\x80"
sfxinfo[sfx_ssptnt] = {
	flags = SF_X4AWAYSOUND,
	priority = 100
}

freeslot("sfx_sodebt")
sfxinfo[sfx_sodebt].caption = "Debt Paid"

freeslot("sfx_stnoti")
sfxinfo[sfx_stnoti].caption = "\x8DSuper Taunt Ready!\x80"

freeslot("sfx_assbst")
sfxinfo[sfx_assbst].caption = "\x82".."ASS BLAST!!!!!\x80"
sfxinfo[sfx_assbst] = {
	flags = SF_X4AWAYSOUND,
	priority = 110
}

for i = 0, 2
	SafeFreeslot("sfx_comup"..i)
	sfxinfo[sfx_comup0 + i].caption = "\x83".."Combo Up!\x80"
end

freeslot("sfx_rakupc")
sfxinfo[sfx_rakupc].caption = "/"
freeslot("sfx_rakupb")
sfxinfo[sfx_rakupb].caption = "/"
freeslot("sfx_rakupa")
sfxinfo[sfx_rakupa].caption = "/"
freeslot("sfx_rakups")
sfxinfo[sfx_rakups].caption = "/"
freeslot("sfx_rakupp")
sfxinfo[sfx_rakupp].caption = "/"

freeslot("sfx_rakdns")
sfxinfo[sfx_rakdns].caption = "/"
freeslot("sfx_rakdna")
sfxinfo[sfx_rakdna].caption = "/"
freeslot("sfx_rakdnb")
sfxinfo[sfx_rakdnb].caption = "/"
freeslot("sfx_rakdnc")
sfxinfo[sfx_rakdnc].caption = "/"
freeslot("sfx_rakdnd")
sfxinfo[sfx_rakdnd].caption = "/"



//freeslot("sfx_smach3")

--SKINCOLOR FREESLOT
freeslot("SKINCOLOR_FURLESS")
skincolors[SKINCOLOR_FURLESS] = {
    name = "Furless",
    ramp = {49,218,219,220,220,221,222,223,224,226,229,231,231,231,231,231},
    invcolor = SKINCOLOR_COPPER,
    invshade = 9,
    chatcolor = V_BROWNMAP,
    accessible = true
}

freeslot("SKINCOLOR_SOAPAIREALLYRED")
freeslot("SKINCOLOR_SOAPAIREALLYGREEN")

skincolors[SKINCOLOR_SOAPAIREALLYRED] = {
    name = "Really Red",
    ramp = {35,35,35,35,35,35,35,35,35,35,35,41,41,41,41,41},
    invcolor = SKINCOLOR_SOAPAIREALLYGREEN,
    invshade = 9,
    chatcolor = V_REDMAP,
    accessible = true
}
//freeslot("SKINCOLOR_SOAPAIREALLYGREEN")

skincolors[SKINCOLOR_SOAPAIREALLYGREEN] = {
    name = "Really Green",
    ramp = {100,100,100,100,100,100,100,100,100,100,100,191,191,191,191,191},
    invcolor = SKINCOLOR_SOAPAIREALLYRED,
    invshade = 35,
    chatcolor = V_GREENMAP,
    accessible = true
}

//a palette of all the colors soap uses is included in his DEV folder
freeslot("SKINCOLOR_SOAPYGREEN")
skincolors[SKINCOLOR_SOAPYGREEN] = {
    name = "Soapy_Green",
	//yknow srb2, if you could stop being so SENSITIVE i wouldnt
	//have to put this stupid underscore in the name
    ramp = {98,98,98,101,101,101,103,103,105,105,106,108,108,109,109,109},
    invcolor = SKINCOLOR_RED,
    invshade = 35,
    chatcolor = V_GREENMAP,
    accessible = true
}
--

//give us a sol form!
if not solchars
rawset(_G, "solchars", {})
end
solchars["soapthehedge"] = {SKINCOLOR_SUPERRED1, 2}

//do stuff for 2.2.11
if ((not P_MoveOrigin) or (not P_SetOrigin))
	rawset(_G, "P_MoveOrigin", function(actor, x, y, z)
		P_TeleportMove(actor, x, y, z)
	end)
	rawset(_G, "P_SetOrigin", function(actor, x, y, z)
		P_TeleportMove(actor, x, y, z)
	end)
end

G_AddGametype({
    name = "Yellow Demon",
    identifier = "yellowdemon",
    typeoflevel = TOL_RACE,
    rules = GTR_SPECTATORS|GTR_FRIENDLY|GTR_NOSPECTATORSPAWN|GTR_HURTMESSAGES|GTR_PITYSHIELD|GTR_SPAWNINVUL|GTR_ALLOWEXIT|GTR_LIVES|GTR_RACE,
    intermissiontype = int_race,
    headercolor = 75,
	rankingtype = GT_RACE,
    description = "Avoid rings and use each other to reach the goal before anyone else!"
})

--MOBJ FREESLOT

freeslot("MT_SOAPYWINDRING")
freeslot("S_SOAPYWINDRING")
//jeez
freeslot("S_SOAP_SUPERTAUNT_FLYINGBOLT1")
freeslot("S_SOAP_SUPERTAUNT_FLYINGBOLT2")
freeslot("S_SOAP_SUPERTAUNT_FLYINGBOLT3")
freeslot("S_SOAP_SUPERTAUNT_FLYINGBOLT4")
freeslot("S_SOAP_SUPERTAUNT_FLYINGBOLT5")
freeslot("S_SOAP_TAUNTFLASH")



//freeslot("MT_CRITICALHIT_MARKER")
//freeslot("S_CRITICALHIT_MARKER")

//a mobj definition that isnt in SOC?
//rebound dash
--Wallbounce ring effect object
mobjinfo[MT_SOAPYWINDRING] = {
	doomednum = -1,
	spawnstate = S_SOAPYWINDRING,
	flags = MF_NOCLIP|MF_NOCLIPHEIGHT|MF_SCENERY|MF_NOGRAVITY
}
states[S_SOAPYWINDRING] = {
	sprite = SPR_WDRG,
	frame = TR_TRANS10|FF_PAPERSPRITE|A
}

//freeslot in misc.lua
mobjinfo[MT_SOAP_SUPERTAUNT_FLYINGBOLT] = {
	doomednum = -1,
	spawnstate = S_SOAP_SUPERTAUNT_FLYINGBOLT1,
	flags = MF_NOCLIP|MF_NOCLIPHEIGHT|MF_NOGRAVITY
}

states[S_SOAP_SUPERTAUNT_FLYINGBOLT1] = {
	sprite = SPR_STB1,
	frame = FF_PAPERSPRITE|FF_ANIMATE,
	var1 = 4,
	var2 = 2,
	tics = 4*2
}
states[S_SOAP_SUPERTAUNT_FLYINGBOLT2] = {
	sprite = SPR_STB2,
	frame = FF_PAPERSPRITE|FF_ANIMATE,
	tics = 4*2,
	var1 = 4,
	var2 = 2
}
states[S_SOAP_SUPERTAUNT_FLYINGBOLT3] = {
	sprite = SPR_STB3,
	frame = FF_PAPERSPRITE|FF_ANIMATE,
	var1 = 4,
	var2 = 2,
	tics = 4*2
}
states[S_SOAP_SUPERTAUNT_FLYINGBOLT4] = {
	sprite = SPR_STB4,
	frame = FF_PAPERSPRITE|FF_ANIMATE,
	tics = 4*2,
	var1 = 4,
	var2 = 2
}
states[S_SOAP_SUPERTAUNT_FLYINGBOLT5] = {
	sprite = SPR_STB5,
	frame = FF_PAPERSPRITE|FF_ANIMATE,
	tics = 4*2,
	var1 = 4,
	var2 = 2
}
mobjinfo[MT_SOAP_TAUNTFLASH] = {
	doomednum = -1,
	spawnstate = S_SOAP_TAUNTFLASH,
	dispoffset = -1,
	flags = MF_NOCLIP|MF_NOCLIPHEIGHT|MF_NOGRAVITY
}
states[S_SOAP_TAUNTFLASH] = {
	sprite = SPR_TANT,
	frame = FF_ANIMATE,
	tics = 20,
	var1 = 10,
	var2 = 2
}

/*
mobjinfo[MT_CRITICALHIT_MARKER] = {
	doomednum = -1,
	spawnstate = S_CRITICALHIT_MARKER,
	dispoffset = 3,
	flags = MF_NOCLIP|MF_NOCLIPHEIGHT|MF_NOGRAVITY|MF_NOBLOCKMAP
}
states[S_CRITICALHIT_MARKER] = {
	sprite = SPR_SCTH,
	tics = 20
}
*/


//i would just makeLB_Soap_APosersthis part of lb_soap, but ermmmmm
if not PizzaTowerAICandidates
	rawset(_G, "LB_Soap_APosers", {})
end
//ok lets init these goobers

//please put this in lowercase
LB_Soap_APosers["sonic"] = "apose"
LB_Soap_APosers["tails"] = "apose"
LB_Soap_APosers["knuckles"] = "apose"
LB_Soap_APosers["amy"] = "tpose"
LB_Soap_APosers["fang"] = "apose"
LB_Soap_APosers["metalsonic"] = "apose"
LB_Soap_APosers["soapthehedge"] = "apose"
LB_Soap_APosers["pointy"] = "tpose"
LB_Soap_APosers["fluffy"] = "tpose"

--
print("\x82Successfully initialized \x86init.lua")