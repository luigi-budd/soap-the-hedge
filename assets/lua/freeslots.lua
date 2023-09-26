--lets freeslot everything here so it doesnt clutter up my already messy main script
--also add the freeslots from socs, actually nevermind i dont know how to translate soc to lua

freeslot("S_PLAY_SOAP_DIEDED")

states[S_PLAY_SOAP_DIEDED] = {
    sprite = SPR_PLAY,
    frame = SPR2_DEAD,
    var2 = 2,
    tics = 1*TICRATE,
    nextstate = S_PLAY_STND
}

freeslot("S_PLAY_SOAP_FLEX")

states[S_PLAY_SOAP_FLEX] = {
    sprite = SPR_PLAY,
    frame = SPR2_MLEE,
    var2 = 2,
    tics = 1*TICRATE,
    nextstate = S_PLAY_STND
}

freeslot("sfx_hlds")

sfxinfo[sfx_hlds].caption = "Source Death Sound"

freeslot("sfx_flex")

sfxinfo[sfx_flex].caption = "Soap Flexing"

freeslot("S_PLAY_SOAP_RUN2")

states[S_PLAY_SOAP_RUN2] = {
    sprite = SPR_PLAY,
    frame = SPR2_SWIM|FF_ANIMATE,
    var2 = 2,
    action = A_SetPAnim,
    tics = 1,
    nextstate = S_PLAY_SOAP_RUN2
}
