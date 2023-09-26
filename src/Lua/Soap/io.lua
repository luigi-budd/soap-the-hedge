//io file

//thank you SMS reborn for being reusable!
//Y7GDSUYFHIDJPK AAAAAAAAAAAHHHHHHHHH!!!!!!!!

//if you use this manually and mess something up, its not my fault!
COM_AddCommand("soap_load", function(p, a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16)
if a1 == nil
CONS_Printf(p,"\x85"+"Do not use this command manually! You may risk messing up Soap or your config!")
return
end

a1 = tonumber(a1) //Turn all of you to numbers!
a2 = tonumber(a2)
a3 = tonumber(a3)
a4 = tonumber(a4)
a5 = tonumber(a5)
a6 = tonumber(a6)
a7 = tonumber(a7)
a8 = tonumber(a8)
a9 = tonumber(a9)
a10 = tonumber(a10)
a11 = tonumber(a11)
a12 = tonumber(a12)
a13 = tonumber(a13)
a14 = tonumber(a14)
a15 = tonumber(a15)
a16 = tonumber(a16)

/*
for i = a1, a17
	print(tonumber(i))
	if i == nil
		CONS_Printf(p,"\x85Tried to load nil value! Haulting code...")
		CONS_Printf(p, "Nil failure at value "+d+" at iteration "+i+".")
		return
	end
end
*/

//insert to buffer or set vars directly?
//well i say set vars as to  not clutter up the player's console
local soap = p.soaptable
if a1 == 1
	soap.cosspinglow = 1
elseif a1 == 0
	soap.cosspinglow = 0
else
	CONS_Printf(p,"\x85"+"Error loading glow! Defaulting to 1...")
end
if a2 == 1
	soap.cosquakes = 1
elseif a2 == 0
	soap.cosquakes = 0
else
	CONS_Printf(p,"\x85"+"Error loading quakes! Defaulting to 1...")
end
if a3 == 1
	soap.cosflashes = 1
elseif a3 == 0
	soap.cosflashes = 0
else
	CONS_Printf(p,"\x85"+"Error loading flashes! Defaulting to 1...")
end
if a4 == 1
	soap.cosbuttered = 1
elseif a4 == 0
	soap.cosbuttered = 0
else
	CONS_Printf(p,"\x85"+"It isn't butter? Unbelievable! Defaulting to 1...")
end

soap.cosspeedometer = a5
if (a5 == nil) or (a5 > 2)
	CONS_Printf(p,"\x85"+"Speedometer style invalid! Defaulting to 2...")
	soap.cosspeedometer = 2
end

soap.cosclocksound = a6
if ((a6 ~= 0) and (a6 ~= 1))
	CONS_Printf(p,"\x85"+"Error loading Clocksound! Defaulting to 0...")
	soap.cosclocksound = 0
end

soap.costrailstyle = a7
if ((a7 ~= 1) and (a7 ~= 2))
	CONS_Printf(p,"\x85"+"Error loading Trail Style! Defaulting to Vanilla...")
	soap.costrailstyle = 1
end

soap.firsttime = a8
if ((a8 ~= 0) and (a8 ~= 1))
	CONS_Printf(p,"\x85"+"Error in loaded! Assuming you've played before...")
	soap.firsttime = 0
end

soap.rolltrol = a9
if ((a9 ~= 0) and (a9 ~= 1))
	CONS_Printf(p,"\x85"+"Error loading Rolltrol! Defaulting to 1...")
	soap.rolltrol = 1
end

soap.soapUncurl = a10
if ((a10 ~= 0) and (a10 ~= 1))
	CONS_Printf(p,"\x85"+"Error loading Uncurl! Defaulting to 1...")
	soap.soapUncurl = 1
end

soap.disableMomen = a11
if ((a11 ~= 0) and (a11 ~= 1))
	CONS_Printf(p,"\x85"+"Error loading Momentum! Defaulting to 0...")
	soap.disableMomen = 0
end

soap.cosusedlimitbefore = a12
if ((a12 ~= 0) and (a12 ~= 1))
	CONS_Printf(p,"\x85"+"Can't tell if you've use the limit before! Defaulting to 0...")
	soap.cosusedlimitbefore = 0
end


soap.supertauntedbefore = a13
if ((a13 ~= 0) and (a13 ~= 1))
	CONS_Printf(p,"\x85"+"Can't tell if you've Super Taunted before! Defaulting to 0...")
	soap.supertauntedbefore = 0
end

//we dont need to set ftx and fty, since you've probably played soap 
//more than once if youre loading
//actually, some stuff use ftx & fty, so lets load those
soap.ftx = a14
if a14 == nil
	soap.ftx = 160
end

soap.fty = a15
if a15 == nil
	soap.fty = 60
end

soap.pizzatowerstuff = a16
if ((a16 ~= 0) and (a16 ~= 1))
	CONS_Printf(p,"\x85"+"Error loading Pizza Tower Stuff! Defaulting to 1...")
	soap.pizzatowerstuff = 1
end

CONS_Printf(p, "\x82Loaded Soap Settings!")
end)

print("\x82Successfully initialized \x86io.lua")