//init all of soaps stuff here!!
//istg if rolltrol doesnt work om gonan cry :(((
//im gonna cry ;(
//im not gonna cry B)

rawset(_G, "SoapInitTable", function(p)
	//why print?
	CONS_Printf(p,"\x86"+"Initializing Soap's table...")

p.soaptable = {
rolltrol = 1,
soapUncurl = 1,
flexxing = 0,
laughing = 0,
disableMomen = 0,
canMomen = 1,
debugStats = 0,
uncurlprevbuttons = p.cmd.buttons,
dashpreserve = 0,
recurlAble = 1,
curlPainStasis = 0,
dashBoostSfxREADY = false,
dashBoostSfx = false,
//constants
isDash = 0,
onGround = 0,
isSoap = 0,
isValid = 0,
isIdle = 0,
isXmo = 0,
isSuper = 0,
isSuperM = false,
isElevated = 0,
inPain = 0,
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
SspinDOWN = 0
}
//now we can tell if this actually worked or not
CONS_Printf(p, "\n"+"\x84"+"Initialized Soap the Hedge's variables!")
CONS_Printf(p, "Please do "+"\x85"+"NOT "+"\x80"+"share or modify "+"\x85"+"ANY "+"\x80"+"part of this DEV file! Or else I'll cry :(")
CONS_Printf(p, "\x8A"+"Use "+"\x86"+"soap_help"+"\x8A"+" in the console for some help on Soap the Hedge!")
	
	return true
end)

if not PlayerAnimInfo
	rawset(_G, "PlayerAnimInfo", {})
end

PlayerAnimInfo = {
	["soapthehedge"] = {
		["runFrames"] = {0, 2},
		["dashFrames"] = {0, 1, 2, 3},
		["walkFrames"] = {3, 7},
		["waitFrames"] = {0},
		["milnekickFrames"] = {0, 4},
		["run"] = true,
		["dash"] = true,
		["walk"] = true,
		["idle"] = true,
		["wait"] = true,
		["milnekick"] = true,
		["superRun"] = true,
		["superDash"] = true,
		["superWalk"] = true,
		["superIdle"] = true,
		["superWait"] = true 
	},
}

//freeslots
//uhh should i translate the socs freeslots into lua?
freeslot("SRP2_FKIK")

freeslot("SRP2_FROZ")

freeslot("SPR2_HUG_")

freeslot("SRP2_SHIT")

freeslot("SPR2_FLEX")

freeslot("SPR2_FLEX")

freeslot("S_PLAY_SOAP_FLEX")
states[S_PLAY_SOAP_FLEX] = {
    sprite = SPR_PLAY,
    frame = SPR2_FLEX,
    var2 = 2,
    tics = 1*TICRATE,
    nextstate = S_PLAY_STND
}


freeslot("sfx_hlds")
sfxinfo[sfx_hlds].caption = "Source Death Sound"

freeslot("sfx_slip")
sfxinfo[sfx_slip].caption = "Banana Slip"

freeslot("sfx_flex")
sfxinfo[sfx_flex].caption = "Soap Flexxing"


freeslot("sfx_hahaha")
sfxinfo[sfx_hahaha].caption = "Goofy Ahh Laugh"

freeslot("SPR2_LAFF")

freeslot("S_PLAY_SOAP_LAUGH")
states[S_PLAY_SOAP_LAUGH] = {
	sprite = SPR_PLAY,
	frame = SPR2_LAFF,
	var2 = 2,
	tics = 1*TICRATE,
	nextstate = S_PLAY_STND
}

freeslot("SPR2_APOS")

freeslot("S_PLAY_SOAP_APOSE")
states[S_PLAY_SOAP_APOSE] = {
	sprite = SPR_PLAY,
	frame = SPR2_APOS,
	var2 = 2,
	tics = -1
}

freeslot("sfx_uncurl.ogg")
sfxinfo[sfx_uncurl].caption = "Uncurl"

freeslot("sfx_srecur.ogg")
sfxinfo[sfx_srecur].caption = "Recurl"

freeslot("sfx_srcrl2")
sfxinfo[sfx_srcrl2].caption = "Quick-curl"

freeslot("sfx_sburst")
sfxinfo[sfx_sburst].caption = "Small Burst"

sfxinfo[sfx_s25f].caption = "Transformation"

freeslot("sfx_slghtn")
sfxinfo[sfx_slghtn].caption = "Lightning Strike"
sfxinfo[sfx_slghtn] = {
	flags = SF_X8AWAYSOUND
}

freeslot("sfx_snocrl")
sfxinfo[sfx_snocrl].caption = "Failed to Recurl"