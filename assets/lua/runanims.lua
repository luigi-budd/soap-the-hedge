--this is the script to handle 2 run animations!!!

local run2Speed = 57 --1 less than 58
local coolspeed = 0
local isDashMode = false
local canRun2 = false

addHook("PlayerThink", function(p)		
	if p.mo and p.valid then
		coolspeed = (p.speed / FRACUNIT)
		isDashMode =  p.dashmode > 3*TICRATE
		
		if isDashMode == false then
			canRun2 = true
		end
	end
	
	if isDashMode == true and P_IsObjectOnGround(p.mo) then
		canRun2 = false
	end

	print("Debug")
	print(coolspeed)
	print(isDashMode)
	print(canRun2)
	
	if coolspeed > 57 and isDashMode == false and canRun2 == true then
		if P_IsObjectOnGround(p.mo) and p.mo.state == S_PLAY_RUN then
			p.mo.state = S_PLAY_SOAP_RUN2
		end
	end
	
end)