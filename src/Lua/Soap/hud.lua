//const
local menuxdisp = 15
local cosspace = 15
local cosinc = 30
local disp = 20
local supertauntdisp = -51

//actual code starts at 278 (control+g)
//from ringslinger neo
local drawammobar = function(v, player, mo, cam)
	local maxammo = 20
	local soap = player.soaptable
	if soap.isSuper
		maxammo = 30
	elseif soap.isSol
		maxammo = 16
	end
	local curammo = player.powers[pw_underwater]/TICRATE
	local x = 160
	local y = 115
	local barx = x - maxammo/2
	local bary = y + 8
	local patch1 = v.cachePatch("SBARSEG1") //blue
	local patch3 = v.cachePatch("SBARSEG3") //black
	local patch5 = v.cachePatch("SBARSEG5") //red
		v.drawScaled((barx-6)*(FRACUNIT), (y+10)*(FRACUNIT)+(FRACUNIT/3), FRACUNIT/2, v.cachePatch("BUBLA0"), V_HUDTRANS|V_PERPLAYER,v.getColormap(nil, nil))
		--Ammo bar
		local pos = 0
		while (pos < maxammo)
			local patch = patch3
			pos = $ + 1
			
				if pos <= curammo
					if pos > curammo - 1
						if (curammo <= 1)
							//first
							if player.powers[pw_underwater] <= 11*TICRATE
							and leveltime % 4 == 0
								patch = patch5
							else
								patch = patch1
							end
						else
							//fill
							if player.powers[pw_underwater] <= 11*TICRATE
							and leveltime % 4 == 0
								patch = patch5
							else
								patch = patch1
							end
						end
					else
						//the one at the right end
						if player.powers[pw_underwater] <= 11*TICRATE
						and leveltime % 4 == 0
							patch = patch5
						else
							patch = patch1
						end
					end
				end
			v.draw(barx + pos - 1, bary, patch, V_HUDTRANS|V_PERPLAYER)
		end
		
end
local drawdivecancelbar = function(v, p, me,soap)
	local maxammo = 16*3
	local curammo = (16-soap.divecancel)*3
	local x = 190
	local y = 105-6
	local barx = x - maxammo/2
	local bary = y
	local patch1 = v.cachePatch("CANSEG1") //blue
	local patch3 = v.cachePatch("CANSEG2") //black
	
		--Ammo bar
		local pos = 0
		while (pos < maxammo)
			local patch = patch3
			pos = $ + 1
			
			
				if pos <= curammo
					v.draw(barx + pos - 1, bary, patch3, V_HUDTRANS|V_PERPLAYER)
					if pos > curammo - 1
						if (curammo <= 1)
							//first
							patch = patch1
						else
							//fill
							patch = patch1
						end
					else
						patch = patch1
					end
				end
			v.draw(barx + pos - 1, bary, patch, V_HUDTRANS|V_PERPLAYER,v.getColormap(nil,me.color))
		end
		
end
local drawcombotimebar = function(v, p, me, soap, combdisp,comby)
	local maxammo = SoapFetchConstant("combo_maxtime")/5
	local curammo = soap.combotime/5
	local x = hudinfo[HUD_RINGS].x+18+combdisp
	local y = hudinfo[HUD_RINGS].y+30-2+comby
	local barx = x //- maxammo/2
	local bary = y
	local patch1 = v.cachePatch("CANSEG1") //blue
	local patch3 = v.cachePatch("CANSEG2") //black
	
		--Ammo bar
		local pos = 0
		while (pos < maxammo)
			local patch = patch3
			pos = $ + 1
			
			
				if pos <= curammo
					v.draw(barx + pos - 1, bary, patch3, V_SNAPTOTOP|V_SNAPTOLEFT|V_HUDTRANS|V_PERPLAYER)
					if pos > curammo - 1
						if (curammo <= 1)
							//first
							patch = patch1
						else
							//fill
							patch = patch1
						end
					else
						patch = patch1
					end
				end
			//todo: skincolors
			v.draw(barx + pos - 1, bary, patch, V_SNAPTOTOP|V_SNAPTOLEFT|V_HUDTRANS|V_PERPLAYER,v.getColormap(nil,SKINCOLOR_SUPERSILVER5))
		end
		
end
local drawcosmenuwaitbar = function(v,p,soap)
	local maxammo = (TICRATE*3/2)*2
	local curammo = soap.cosmenuwait*2
	local x = 160
	local y = 150
	local barx = x - maxammo/2
	local bary = y + 8
	local patch1 = v.cachePatch("COSSEG1") //black
	local patch2 = v.cachePatch("COSSEG2") //green
	
		--Ammo bar
		local pos = 0
		while (pos < maxammo)
			local patch = patch1
			local flags = V_PERPLAYER|V_50TRANS
			local color = 0
			pos = $ + 1
			
				if pos <= curammo
					if pos > curammo - 1
						if (curammo <= 1)
							//first
							patch = patch2
							flags = $ & ~V_50TRANS
						else
							//fill
							patch = patch2
							flags = $ & ~V_50TRANS
						end
					else
						//the one at the right end
						patch = patch2
						flags = $ & ~V_50TRANS
					end
					
					if soap.cosmenuwait >= (TICRATE*3/2)
					and (leveltime % 5) == 0
						color = ColorOpposite(p.skincolor)
					else
						color = p.skincolor
					end

				end
			v.draw(barx + pos - 1, bary, patch, flags,v.getColormap(nil,color) )
			if soap.cosmenuwait >= (TICRATE*3/2)
				v.drawString(x,bary+1,"Spin + C3: Open Cosmetics Menu",V_ALLOWLOWERCASE|V_PERPLAYER,"small-center")
			end
		end
		
end
local drawcosbar = function(v,p,x,y,text,color,barflag,textflag,texttype,x2,y2)
	if textflag == nil
		textflag = 0
	end
	if barflag == nil
		barflag = 0
	end
	local ty = 0
	if texttype == nil
		texttype = "thin-center"
	elseif texttype == "small-center"
		ty = 2
	end
	x2 = $ or 0
	y2 = $ or 0
	v.drawScaled(x*FRACUNIT+x2, y*FRACUNIT+y2, FRACUNIT/5, v.cachePatch("COSBAR"), V_10TRANS|V_PERPLAYER|barflag, v.getColormap(nil, color))
	v.drawString(x+14, y+3+ty, text, V_ALLOWLOWERCASE|V_PERPLAYER|textflag, texttype)
end

//LOTS of args but its useful for customization
local drawOnOffCosBar = function(v,p,x,y,ybase,ylevel,value,onvalue,offvalue,oncolor,offcolor,texttype,label,onbf,offbf,ontf,offtf,onx,offx,ony,offy)
	local color
	
	local barflag = 0
	local textflag = 0
	
	//we'll use this later for the label's y
	if ylevel == nil then ylevel = 0 end
	
	//flag changes
	if onbf == nil then onbf = 0 end
	if offbf == nil then offbf = 0 end
	
	if ontf == nil then ontf = 0 end
	if offtf == nil then offtf = 0 end
	
	//axis offsets
	if onx == nil then onx = 0 end
	if offx == nil then offx = 0 end
	
	if ony == nil then ony = 0 end
	if offy == nil then offy = 0 end

	local ty = 0
	local ly = ybase-25
	
	local xadd
	local yadd

	if texttype == nil
		texttype = "thin-center"
	elseif texttype == "small-center"
		ty = 2
	end

	if label == nil
		label = "\x85".."No label"
	end
	
	if value == onvalue
		color = oncolor
		barflag = onbf
		textflag = ontf
		xadd = onx
		yadd = ony
	elseif value == offvalue
		color = offcolor
		barflag = offbf
		textflag = offtf
		xadd = offx
		yadd = offy
	else
		value = "?"
		color = SKINCOLOR_GREY
		xadd = 0
		yadd = 0
	end

	v.drawScaled( ( x*FRACUNIT + (xadd*FRACUNIT) )+(menuxdisp*FRACUNIT), (y*FRACUNIT+(yadd*FRACUNIT))-(disp*FRACUNIT), FRACUNIT/5, v.cachePatch("COSBAR"), V_10TRANS|V_PERPLAYER|barflag, v.getColormap(nil, color))
	v.drawString(((x+14)+xadd)+menuxdisp, ((y+3+ty)+yadd)-disp, value, V_ALLOWLOWERCASE|V_PERPLAYER|textflag, texttype)
	
	//top
	if ylevel == 0
		ly = ybase-25
	//middle
	elseif ylevel == 1
		ly = $+cosinc
	//bottom+
	elseif ylevel >= 2
		ly = $+(cosinc*(ylevel))
	end
	//draw label
	v.drawString(x+15+menuxdisp,ly-disp,tostring(label),V_ALLOWLOWERCASE|V_PERPLAYER, "thin-center")
end

//pretty much just drawOnOffCosBar but with text!
local draw2StyledCosBar = function(v,p,
x,y,ybase,ylevel,
value,onvalue,offvalue,
oncolor,offcolor,
label,
tt1st,tt2nd,
text1st,text2nd,
onbf,offbf,
ontf,offtf,
onx,offx,
ony,offy)
	local color
	
	local barflag = 0
	local textflag = 0
	
	//we'll use this later for the label's y
	if ylevel == nil then ylevel = 0 end
	
	//flag changes
	if onbf == nil then onbf = 0 end
	if offbf == nil then offbf = 0 end
	
	if ontf == nil then ontf = 0 end
	if offtf == nil then offtf = 0 end
	
	//axis offsets
	if onx == nil then onx = 0 end
	if offx == nil then offx = 0 end
	
	if ony == nil then ony = 0 end
	if offy == nil then offy = 0 end

	local ty = 0
	local ly = ybase-25
	
	local xadd
	local yadd

	if tt1st == nil
		tt1st = "thin-center"
	elseif tt1st == "small-center"
		ty = 2
	end

	if tt2nd == nil
		tt2nd = "thin-center"
	elseif tt2nd == "small-center"
		ty = 2
	end

	//text to draw on the button
	if text1st == nil then text1st = "\x85".."No Text" end
	if text2nd == nil then text2nd = "\x85".."No Text" end

	if label == nil
		label = "\x85".."No label"
	end
	
	local text
	local texttype
	
	if value == onvalue
		color = oncolor
		barflag = onbf
		textflag = ontf
		xadd = onx
		yadd = ony
		text = text1st
		texttype = tt1st
	elseif value == offvalue
		color = offcolor
		barflag = offbf
		textflag = offtf
		xadd = offx
		yadd = offy
		text = text2nd
		texttype = tt2nd
	else
		value = "?"
		color = SKINCOLOR_GREY
		xadd = 0
		yadd = 0
	end

	v.drawScaled( ( x*FRACUNIT + (xadd*FRACUNIT) )+(menuxdisp*FRACUNIT), (y*FRACUNIT+(yadd*FRACUNIT))-(disp*FRACUNIT), FRACUNIT/5, v.cachePatch("COSBAR"), V_10TRANS|V_PERPLAYER|barflag, v.getColormap(nil, color))
	v.drawString(((x+14)+xadd)+menuxdisp, ((y+3+ty)+yadd)-disp, text, V_ALLOWLOWERCASE|V_PERPLAYER|textflag, texttype)
	
	//top
	if ylevel == 0
		ly = ybase-25
	//middle
	elseif ylevel == 1
		ly = $+cosinc
	//bottom+
	elseif ylevel >= 2
		ly = $+(cosinc*(ylevel))
	end
	//draw label
	v.drawString(x+15+menuxdisp,ly-disp,tostring(label),V_ALLOWLOWERCASE|V_PERPLAYER, "thin-center")
end

//"Variable names cannot start with numbers" -Tatsuru
//well thanks a lot, srb2
//shouldve told me earlier!!!!
local draw3StyledCosBar = function(v,p,x,y,ybase,ylevel,
value,value1st,value2nd,value3rd,
color1st,color2nd,color3rd,
tt1st,tt2nd,tt3rd,
label,
text1st,text2nd,text3rd,
bf1st,bf2nd,bf3rd,
tf1st,tf2nd,tf3rd,
x1st,x2nd,x3rd,
y1st,y2nd,y3rd)
//that sure is a lot of functions!

//first, lets set any nil stuff to 0
	local color
	
	local barflag = 0
	local textflag = 0
	
	local texttype
	
	//colors
	if color1st == nil then color1st = SKINCOLOR_SOAPAIREALLYGREEN end
	if color2nd == nil then color2nd = SKINCOLOR_SOAPAIREALLYGREEN end
	if color3rd == nil then color3rd = SKINCOLOR_SOAPAIREALLYGREEN end
	
	//text to draw on the button
	if text1st == nil then text1st = "\x85".."No Text" end
	if text2nd == nil then text2nd = "\x85".."No Text" end
	if text3rd == nil then text3rd = "\x85".."No Text" end

	//texttypes
	if tt1st == nil then tt1st = "thin-center" end
	if tt2nd == nil then tt2nd = "thin-center" end
	if tt3rd == nil then tt3rd = "thin-center" end
	
	//we'll use this later for the label's y
	if ylevel == nil then ylevel = 0 end
	
	//flag changes
	if bf1st == nil then bf1st = 0 end
	if bf2nd == nil then bf2nd = 0 end
	if bf3rd == nil then bf3rd = 0 end
	
	//text flag changes
	if tf1st == nil then tf1st = 0 end
	if tf2nd == nil then tf2nd = 0 end
	if tf3rd == nil then tf3rd = 0 end
	
	//axis offsets
	if x1st == nil then x1st = 0 end
	if x2nd == nil then x2nd = 0 end
	if x3rd == nil then x3rd = 0 end
	
	if y1st == nil then y1st = 0 end
	if y2nd == nil then y2nd = 0 end
	if y3rd == nil then y3rd = 0 end

	local ty = 0
	local ly = ybase-25
	
	local xadd
	local yadd

	if label == nil
		label = "\x85".."No label"
	end

	local text
	
	if value == value1st
		color = color1st
		barflag = bf1st
		textflag = tf1st
		xadd = x1st
		yadd = y1st
		texttype = tt1st
		text = text1st
	elseif value == value2nd
		color = color2nd
		barflag = bf2nd
		textflag = tf2nd
		xadd = x2nd
		yadd = y2nd
		texttype = tt2nd
		text = text2nd
	elseif value == value3rd
		color = color3rd
		barflag = bf3rd
		textflag = tf3rd
		xadd = x3rd
		yadd = y3rd
		texttype = tt3rd
		text = text3rd
	else
		value = "?"
		color = SKINCOLOR_GREY
		xadd = 0
		yadd = 0
	end

	v.drawScaled( ( x*FRACUNIT + (xadd*FRACUNIT) )+(menuxdisp*FRACUNIT), (y*FRACUNIT+(yadd*FRACUNIT))-(disp*FRACUNIT), FRACUNIT/5, v.cachePatch("COSBAR"), V_10TRANS|V_PERPLAYER|barflag, v.getColormap(nil, color))
	v.drawString(((x+14)+xadd)+menuxdisp, ((y+3+ty)+yadd)-disp, text, V_ALLOWLOWERCASE|V_PERPLAYER|textflag, texttype)
	
	//top
	if ylevel == 0
		ly = ybase-25
	//middle
	elseif ylevel == 1
		ly = $+cosinc
	//bottom+
	elseif ylevel >= 2
		ly = $+(cosinc*(ylevel))
	end
	//draw label
	v.drawString(x+15+menuxdisp,ly-disp,tostring(label),V_ALLOWLOWERCASE|V_PERPLAYER, "thin-center")

end

local drawcoscursor = function(v,p,x,y,color)
	if color == nil
		color = SKINCOLOR_SUPERGOLD4
	end
	v.drawScaled(x*FRACUNIT, y*FRACUNIT, FRACUNIT/5, v.cachePatch("COSCUR"), V_PERPLAYER, v.getColormap(nil, color))
end
local drawcosmenu = function(v,p,soap,cosspace,cosinc,disp)
	/*
		(this is actually outdated dont use this)
		
		HEY!!
		
		if you wanna add your own pages to this, follow this guide!
		currently all hud stuff is hardcoded, as i dont know a better
		way to code menus ;(
		
		first, we'll draw the buttons!
		
		drawcosbar is the function you wanna use, and heres how to use it!
		
		v, p: these are the same variables used in drawcosmenu, so 
		slap those in for those
		
		x: this is the x position where the button is gonna be drawn
		100 for left
		130 for middle
		160 for right
		pretty, pretty, pretty PLEASE add menuxdisp to your x's!!
		
		y: ok, now this ones a doozy, so get ready!
		make sure you subtract disp and set to 100 for every y!!
		so y = 100-disp <-- disp ALWAYS GOES LAST!!!
		
		[[
			FOR TOP ROW----
			subtract cosspace from 100
			100-cosspace-disp
			
			FOR MIDDLE ROW----
			add cosspace instead of subtracting it
			100+cosspace-disp
			
			FOR BOTTOM ROW----
			same as above, but add cosinc too, since thats the increment
			for each row after
			100+cosspace+(cosinc)-disp
			
			FOR LAST ROW----
			same as above, but cosinc is multiplied by 2
			normally, this is the last row to be used, thats why its called
			the *last* row, but nothings stopping you from adding more rows
			(except screen sizes). just make sure you multiply cosinc for
			each row you add, so the next row would have cosinc multiplied
			by 3.
			100+cosspace+(cosinc*2)-disp
		]]
		
		text: this is the "value"
		
	*/

	v.drawScaled(94*FRACUNIT, 25*FRACUNIT, (FRACUNIT*5)+(FRACUNIT/3), v.cachePatch("SOAPBACK"),V_30TRANS|V_PERPLAYER, v.getColormap(nil, SKINCOLOR_BLACK))

	local maxpage = 2
	if soap.isElevated then maxpage = 4 end
	
	if soap.cosmenupage == 0
	v.drawString(145+menuxdisp, 53-disp, "Soap Settings",V_ALLOWLOWERCASE|V_PERPLAYER, "center")
	elseif soap.cosmenupage == 1
	v.drawString(145+menuxdisp, 53-disp, "Soap's Cosmetics",V_ALLOWLOWERCASE|V_PERPLAYER, "center")
	elseif ((soap.cosmenupage == 2) or (soap.cosmenupage == 3))
	v.drawString(145+menuxdisp, 53-disp, "Admin Only Stuff",V_ALLOWLOWERCASE|V_PERPLAYER, "center")
	v.drawString(145+menuxdisp, 53+8-disp, "\x86Gray texts\x80 are \x86netvars\x80.",V_ALLOWLOWERCASE|V_PERPLAYER, "thin-center")
	end

	//we'll draw the cursor BEFORE the buttons so it doesnt
	//overlap the buttons' texts
	local x
	local y	
	if soap.cosmenucurx == 0
		if soap.cosmenupage ~= 0
			if soap.cosmenucury ~= 3
				x = 100
			elseif soap.cosmenucury == 3
				x = 130
			end
		else
			if soap.cosmenucury ~= 1
				x = 100
			elseif soap.cosmenucury == 1
				x = 130
			end		
		end
	else
		if soap.cosmenucury ~= 3
			x = 160
		//just in case
		elseif soap.cosmenucury == 3
			x = 130
		end
	end
	if soap.cosmenucury == 0
		y = 100-cosspace
	elseif soap.cosmenucury == 1
		y = 100+cosspace
	else
		y = 100+cosspace+(cosinc*(soap.cosmenucury-1))
	end
	
	drawcoscursor(v,p,x+menuxdisp,y-disp)
	
if soap.cosmenupage == 0
	drawOnOffCosBar(v,p,
	100, 					//x
	100-cosspace, 			//y
	100, 					//raw y
	0, 						//(x,0) ylevel
	1-soap.disableMomen, 	//value
	1, 						//on value
	0, 						//off value
	SKINCOLOR_LAVENDER,		//on color
	SKINCOLOR_AZURE, 		//off color
	nil,					//text type
	"Momentum")				//label
	
	drawOnOffCosBar(v,p,
	160, 					//x
	100-cosspace, 			//y
	100, 					//raw y
	0, 						//(x,0) ylevel
	soap.rolltrol, 			//value
	1, 						//on value
	0, 						//off value
	SKINCOLOR_PERIDOT,		//on color
	SKINCOLOR_APPLE, 		//off color
	nil,					//text type
	"Rolltrol")				//label
	
	//next row
	drawOnOffCosBar(v,p,
	130, 					//x
	100+cosspace, 			//y
	100, 					//raw y
	1, 						//(x,0) ylevel
	soap.soapUncurl, 		//value
	1, 						//on value
	0, 						//off value
	SKINCOLOR_WAVE,			//on color
	SKINCOLOR_VAPOR, 		//off color
	nil,					//text type
	"Uncurl")				//label

	v.drawString(145+menuxdisp, 100+cosspace+(cosinc)-disp, "Press \x86WEAPON NEXT",V_ALLOWLOWERCASE|V_PERPLAYER, "thin-center")
	v.drawString(145+menuxdisp, 100+cosspace+(cosinc)-disp+8, "to flip the page!",V_ALLOWLOWERCASE|V_PERPLAYER, "thin-center")

//PAGE 1
elseif soap.cosmenupage == 1

	drawOnOffCosBar(v,p,
	100, 					//x
	100-cosspace, 			//y
	100, 					//raw y
	0, 						//(x,0) ylevel
	soap.cosquakes,		 	//value
	1, 						//on value
	0, 						//off value
	SKINCOLOR_BRONZE,		//on color
	SKINCOLOR_BROWN, 		//off color
	nil,					//text type
	"Quakes",				//label
	nil,nil,nil,nil,		//on/off bar and text flags
	soap.hudquakeshakex,	//on x offset
	nil,					//off x offset
	soap.hudquakeshakey)	//on y offset

	drawOnOffCosBar(v,p,
	160, 					//x
	100-cosspace, 			//y
	100, 					//raw y
	0, 						//(x,0) ylevel
	soap.cosspinglow, 		//value
	1, 						//on value
	0, 						//off value
	SKINCOLOR_GREEN,		//on color
	SKINCOLOR_FOREST, 		//off color
	nil,					//text type
	"Spin Glow",			//label
	V_ADD)					//on bar flag

	//next row
	drawOnOffCosBar(v,p,
	100, 					//x
	100+cosspace, 			//y
	100, 					//raw y
	1, 						//(x,0) ylevel
	soap.cosbuttered, 		//value
	1, 						//on value
	0, 						//off value
	SKINCOLOR_YELLOW,		//on color
	SKINCOLOR_APRICOT, 		//off color
	nil,					//text type
	"Butter Slopes")		//label

	drawOnOffCosBar(v,p,
	160, 					//x
	100+cosspace, 			//y
	100, 					//raw y
	1, 						//(x,0) ylevel
	soap.cosflashes, 		//value
	1, 						//on value
	0, 						//off value
	SKINCOLOR_AETHER,		//on color
	SKINCOLOR_SLATE, 		//off color
	nil,					//text type
	"Flashes")				//label

	//next row
	draw3StyledCosBar(v,p,
	100,					//x
	100+cosspace+(cosinc),	//y
	100,					//raw y
	2,						//(x,0) ylevel
	soap.cosspeedometer,	//value
	0,						//1st value
	1,						//2nd value
	2,						//3rd value
	SKINCOLOR_SILVER,		//1st color
	SKINCOLOR_RUBY,			//2nd color
	SKINCOLOR_FLAME,		//3rd color
	nil,					//1st text type
	"small-center",			//2nd text type
	nil,					//3rd text type
	"Speedometer",			//label
	"Off",					//1st text
	"FRAC/FRAC",			//2nd text
	"FRACs",				//3rd text
	nil,nil,nil,			//1st-3rd bar flags
	nil,nil,nil,			//1st-3rd textflags
	nil,nil,nil,			//1st-3rd x offsets
	nil,nil,nil				//1st y offsets
	)

	drawOnOffCosBar(v,p,
	160, 					//x
	100+cosspace+(cosinc), 	//y
	100, 					//raw y
	2, 						//(x,0) ylevel
	soap.cosclocksound, 	//value
	1, 						//on value
	0, 						//off value
	SKINCOLOR_KETCHUP,		//on color
	SKINCOLOR_GOLD, 		//off color
	nil,					//text type
	"Clocksound")			//label
	
	draw2StyledCosBar(v,p,
	130, 					//x
	100+cosspace+(cosinc*2),//y
	100, 					//raw y
	3, 						//(x,0) ylevel
	soap.costrailstyle, 	//value
	1, 						//on value
	2, 						//off value
	SKINCOLOR_GREEN,		//on color
	SKINCOLOR_SAPPHIRE, 	//off color
	"Trail Style",			//label
	nil,nil,
	"Vanilla","ffoxD")

/*
	if soap.costrailstyle == 1
		drawcosbar(v,p,130+menuxdisp,100+cosspace+(cosinc*2)-disp,"Vanilla",SKINCOLOR_GREEN,nil,nil,"small-center")
	elseif soap.costrailstyle == 2
		drawcosbar(v,p,130+menuxdisp,100+cosspace+(cosinc*2)-disp,"ffoxD",SKINCOLOR_SAPPHIRE)
	else
		drawcosbar(v,p,130+menuxdisp,100+cosspace+(cosinc*2)-disp,"?",SKINCOLOR_GREY)
	end
	v.drawString(145+menuxdisp, 100-25+(cosinc*3)-disp, "Trail Style",V_ALLOWLOWERCASE|V_PERPLAYER, "thin-center")
*/
//PAGE 2
elseif soap.cosmenupage == 2

	drawOnOffCosBar(v,p,
	100, 								//x
	100-cosspace, 						//y
	100, 								//raw y
	0, 									//(x,0) ylevel
	SoapFetchConstant("soap_allbuff"), 	//value
	1, 									//on value
	0, 									//off value
	SKINCOLOR_AZURE,					//on color
	SKINCOLOR_LAVENDER, 				//off color
	nil,								//text type
	"\x86".."CBW B. Buff")				//label

	drawOnOffCosBar(v,p,
	160, 								//x
	100-cosspace, 						//y
	100, 								//raw y
	0, 									//(x,0) ylevel
	soap.nerfed, 						//value
	1, 									//on value
	0, 									//off value
	SKINCOLOR_OLIVE,					//on color
	SKINCOLOR_SANDY, 					//off color
	nil,								//text type
	"CBW B. Buff")						//label

	//next row
	drawOnOffCosBar(v,p,
	100, 										//x
	100+cosspace, 								//y
	100, 										//raw y
	1, 											//(x,0) ylevel
	SoapFetchConstant("soap_nerfcurl"), 		//value
	1, 											//on value
	0, 											//off value
	SKINCOLOR_COPPER,							//on color
	SKINCOLOR_SUNSET, 							//off color
	nil,										//text type
	"\x86".."CBW B. Curl")						//label

	drawOnOffCosBar(v,p,
	160, 													//x
	100+cosspace, 											//y
	100, 													//raw y
	1, 														//(x,0) ylevel
	tostring(SoapFetchConstant("soap_yellowdemon")), 		//value
	"true", 												//on value
	"false", 												//off value
	SKINCOLOR_GOLD,											//on color
	SKINCOLOR_SUPERRUST5, 									//off color
	nil,													//text type
	"\x86Yellow Demon")										//label

	//new row
	drawOnOffCosBar(v,p,
	100, 													//x
	100+cosspace+(cosinc), 									//y
	100, 													//raw y
	2, 														//(x,0) ylevel
	SoapFetchConstant("soap_devmode"), 						//value
	1, 														//on value
	0, 														//off value
	SKINCOLOR_SUPERPURPLE2,									//on color
	SKINCOLOR_PURPLE, 										//off color
	nil,													//text type
	"\x86Soap Devmode")										//label

	drawOnOffCosBar(v,p,
	160, 													//x
	100+cosspace+(cosinc), 									//y
	100, 													//raw y
	2, 														//(x,0) ylevel
	tostring(SoapFetchConstant("soap_pvpnerf")), 			//value
	"true", 												//on value
	"false", 												//off value
	SKINCOLOR_JET,											//on color
	SKINCOLOR_CLOUDY, 										//off color
	nil,													//text type
	"\x86PVP Nerf")											//label

	//last row
	drawOnOffCosBar(v,p,
	130, 													//x
	100+cosspace+(cosinc*2), 									//y
	100, 													//raw y
	3, 														//(x,0) ylevel
	tostring(SoapMobjThinkerAllowed("ring_pull")), 			//value
	"true", 												//on value
	"false", 												//off value
	SKINCOLOR_GOLD,											//on color
	SKINCOLOR_SUPERRUST5, 										//off color
	nil,													//text type
	"\x86Ring Pull")											//label

//PAGE 3
elseif soap.cosmenupage == 3
	drawOnOffCosBar(v,p,
	100, 													//x
	100-cosspace, 											//y
	100, 													//raw y
	0, 														//(x,0) ylevel
	tostring(SoapFetchConstant("soap_blockmapsallowed")), 	//value
	"1", 												//on value
	"0", 												//off value
	SKINCOLOR_ICY,											//on color
	SKINCOLOR_COBALT, 										//off color
	nil,													//text type
	"\x86".."Blockmaps")									//label

	drawOnOffCosBar(v,p,
	160, 												//x
	100-cosspace, 										//y
	100, 												//raw y
	0, 													//(x,0) ylevel
	tostring(SoapFetchConstant("soap_performance")), 	//value
	"true", 											//on value
	"false", 											//off value
	SKINCOLOR_CRIMSON,									//on color
	SKINCOLOR_KETCHUP, 									//off color
	nil,												//text type
	"\x86".."Perform.")									//label

	//new line
	drawOnOffCosBar(v,p,
	100, 												//x
	100+cosspace, 										//y
	100, 												//raw y
	1, 													//(x,0) ylevel
	tostring(SoapFetchConstant("soap_friendlyfire")), 	//value
	"true", 											//on value
	"false", 											//off value
	SKINCOLOR_COPPER,									//on color
	SKINCOLOR_SUNSET, 									//off color
	nil,												//text type
	"\x86".."Friendly F.")								//label


	drawOnOffCosBar(v,p,
	160, 												//x
	100+cosspace, 										//y
	100, 												//raw y
	1, 													//(x,0) ylevel
	tostring(SoapFetchConstant("soap_bananatoss")), 	//value
	"true", 											//on value
	"false", 											//off value
	SKINCOLOR_SANDY,									//on color
	SKINCOLOR_SOAPYGREEN, 								//off color
	nil,												//text type
	"\x86".."Bananas")									//label

	//next row
	/*
	drawOnOffCosBar(v,p,
	100, 												//x
	100+cosspace+(cosinc), 								//y
	100, 												//raw y
	2, 													//(x,0) ylevel
	tostring(SoapFetchConstant("soap_solidsbreak")), 	//value
	"true", 											//on value
	"false", 											//off value
	SKINCOLOR_PEACHY,									//on color
	SKINCOLOR_OLIVE, 									//off color
	nil,												//text type
	"\x86Solids Break")									//label
	*/
	
	//last row
	drawcosbar(v,p,130+menuxdisp,100+cosspace+(cosinc*2)-disp,"Clear Bananas",SKINCOLOR_YELLOW)
end
	
	drawcosbar(v,p,85+menuxdisp,190-disp,"Exit (C1)",SKINCOLOR_JET)
	
	//page indc.
	v.drawString(145+menuxdisp, 195-disp, "Page "..(soap.cosmenupage+1).." of "..maxpage,V_ALLOWLOWERCASE|V_PERPLAYER, "small-center")
	
	//flip button
	if soap.cosmenupage == 0
		drawcosbar(v,p,175+menuxdisp,190-disp,"Next (WN)",SKINCOLOR_CARBON,nil,nil,"small-center")	
	elseif soap.cosmenupage == 1
		if soap.isElevated
			drawcosbar(v,p,175+menuxdisp,190-disp,"Flip (WN/WP)",SKINCOLOR_CARBON,nil,nil,"small-center")
		else
			drawcosbar(v,p,175+menuxdisp,190-disp,"Prev. (WP)",SKINCOLOR_CARBON,nil,nil,"small-center")		
		end
	elseif soap.cosmenupage == 2
		drawcosbar(v,p,175+menuxdisp,190-disp,"Flip (WN/WP)",SKINCOLOR_CARBON,nil,nil,"small-center")
	elseif soap.cosmenupage == 3
		drawcosbar(v,p,175+menuxdisp,190-disp,"Prev. (WP)",SKINCOLOR_CARBON,nil,nil,"small-center")
	end
	
end

//sourceeee
local function V_DrawDebugFlag(v,p, x,y, hasflag, onmap,offmap, string)
	if hasflag
		v.drawString(x,y,string,V_50TRANS|onmap|V_SNAPTORIGHT|V_SNAPTOTOP,"small")
	else
		v.drawString(x,y,string,V_50TRANS|offmap|V_SNAPTORIGHT|V_SNAPTOTOP,"small")
	end
end

local function DevmodeFlags(v, p)
//pflag stuff
v.drawString(100, 56, "Player Flags (In order listed on wiki)",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")
V_DrawDebugFlag(v,p,100,60,p.pflags&PF_FLIPCAM,V_GREENMAP,V_REDMAP,"fc")
V_DrawDebugFlag(v,p,110,60,p.pflags&PF_ANALOGMODE,V_GREENMAP,V_REDMAP,"am")
V_DrawDebugFlag(v,p,120,60,p.pflags&PF_DIRECTIONCHAR,V_GREENMAP,V_REDMAP,"dc")
V_DrawDebugFlag(v,p,130,60,p.pflags&PF_AUTOBRAKE,V_GREENMAP,V_REDMAP,"ab")
V_DrawDebugFlag(v,p,140,60,p.pflags&PF_GODMODE,V_GREENMAP,V_REDMAP,"gm")
V_DrawDebugFlag(v,p,150,60,p.pflags&PF_NOCLIP,V_GREENMAP,V_REDMAP,"nc")
V_DrawDebugFlag(v,p,160,60,p.pflags&PF_INVIS,V_GREENMAP,V_REDMAP,"in")
V_DrawDebugFlag(v,p,170,60,p.pflags&PF_ATTACKDOWN,V_GREENMAP,V_REDMAP,"ad")
V_DrawDebugFlag(v,p,180,60,p.pflags&PF_SPINDOWN,V_GREENMAP,V_REDMAP,"sd")
V_DrawDebugFlag(v,p,190,60,p.pflags&PF_JUMPDOWN,V_GREENMAP,V_REDMAP,"jd")
V_DrawDebugFlag(v,p,200,60,p.pflags&PF_WPNDOWN,V_GREENMAP,V_REDMAP,"wd")
V_DrawDebugFlag(v,p,210,60,p.pflags&PF_STASIS,V_GREENMAP,V_REDMAP,"ss")
V_DrawDebugFlag(v,p,220,60,p.pflags&PF_JUMPSTASIS,V_GREENMAP,V_REDMAP,"js")
V_DrawDebugFlag(v,p,230,60,p.pflags&PF_FULLSTASIS,V_GREENMAP,V_REDMAP,"fs")

//new  line
V_DrawDebugFlag(v,p,100,64,p.pflags&PF_APPLYAUTOBRAKE,V_GREENMAP,V_REDMAP,"aa")
V_DrawDebugFlag(v,p,110,64,p.pflags&PF_STARTJUMP,V_GREENMAP,V_REDMAP,"sj")
V_DrawDebugFlag(v,p,120,64,p.pflags&PF_JUMPED,V_GREENMAP,V_REDMAP,"ju")
V_DrawDebugFlag(v,p,130,64,p.pflags&PF_NOJUMPDAMAGE,V_GREENMAP,V_REDMAP,"nd")
V_DrawDebugFlag(v,p,140,64,p.pflags&PF_SPINNING,V_GREENMAP,V_REDMAP,"sp")
V_DrawDebugFlag(v,p,150,64,p.pflags&PF_STARTDASH,V_GREENMAP,V_REDMAP,"st")
V_DrawDebugFlag(v,p,160,64,p.pflags&PF_THOKKED,V_GREENMAP,V_REDMAP,"th")
V_DrawDebugFlag(v,p,170,64,p.pflags&PF_SHIELDABILITY,V_GREENMAP,V_REDMAP,"sa")
V_DrawDebugFlag(v,p,180,64,p.pflags&PF_GLIDING,V_GREENMAP,V_REDMAP,"gl")


if p.soaptable
	local soap = p.soaptable
	//soap booleans
	v.drawString(100,68, "Soap Booleans (In order listed in init.lua)",V_50TRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOTOP, "small")

	V_DrawDebugFlag(v,p,100,72,soap.isDash,V_GREENMAP,V_REDMAP,"da")
	V_DrawDebugFlag(v,p,110,72,soap.onGround,V_GREENMAP,V_REDMAP,"og")
	V_DrawDebugFlag(v,p,120,72,soap.isSoap,V_GREENMAP,V_REDMAP,"is")
	V_DrawDebugFlag(v,p,130,72,soap.isValid,V_GREENMAP,V_REDMAP,"va")
	V_DrawDebugFlag(v,p,140,72,soap.isIdle,V_GREENMAP,V_REDMAP,"id")
	V_DrawDebugFlag(v,p,150,72,soap.isXmo,V_GREENMAP,V_REDMAP,"xm")
	V_DrawDebugFlag(v,p,160,72,soap.isXmoON,V_GREENMAP,V_REDMAP,"xo")
	V_DrawDebugFlag(v,p,170,72,soap.isSuper,V_GREENMAP,V_REDMAP,"su")
	V_DrawDebugFlag(v,p,180,72,soap.isSuperM,V_GREENMAP,V_REDMAP,"sm")
	V_DrawDebugFlag(v,p,190,72,soap.isElevated,V_GREENMAP,V_REDMAP,"el")
	V_DrawDebugFlag(v,p,200,72,soap.inPain,V_GREENMAP,V_REDMAP,"pa")
	V_DrawDebugFlag(v,p,210,72,soap.noShield,V_GREENMAP,V_REDMAP,"ns")
	V_DrawDebugFlag(v,p,220,72,soap.isSol,V_GREENMAP,V_REDMAP,"so")
	V_DrawDebugFlag(v,p,230,72,soap.isTransform,V_GREENMAP,V_REDMAP,"tr")

	//new line
	V_DrawDebugFlag(v,p,100,76,soap.isWatered,V_GREENMAP,V_REDMAP,"wa")
	V_DrawDebugFlag(v,p,110,76,soap.isBoostm,V_GREENMAP,V_REDMAP,"bm")
	V_DrawDebugFlag(v,p,120,76,soap.isGod,V_GREENMAP,V_REDMAP,"go")
	V_DrawDebugFlag(v,p,130,76,soap.isCloneF,V_GREENMAP,V_REDMAP,"cf")
	V_DrawDebugFlag(v,p,140,76,soap.isFirstPerson,V_GREENMAP,V_REDMAP,"fp")
	V_DrawDebugFlag(v,p,150,76,soap.isZE,V_GREENMAP,V_REDMAP,"ze")
	V_DrawDebugFlag(v,p,160,76,soap.isSuperTaunting,V_GREENMAP,V_REDMAP,"st")


end
end
//sorry for this extremely long function!


//hud stuff for soap.devmode!!!!!!!!!!!!!!!!!!
//and maybe for some future stuff ;)
//local fttexty = 60
//local fttrans = 0
//with some from sms

//this is stupid
local shownNotif = false

//stupid hud thing v2
addHook("HUD", function(v,p)
if not p.mo
return end

local mach4f = 0
local smflag = V_SNAPTORIGHT|V_SNAPTOBOTTOM|V_HUDTRANS|V_PERPLAYER

local speed1x = 0
local speed1y = 0
local speed1x2 = 0
local speed1y2 = 0
local speed1type = "right"
local speed1type2 = "thin-right"

local speed2x = 0
local speed2y = 0
local speed2x2 = 0
local speed2y2 = 0

local speednx = 0
local speedny = 0

local superc3add = 0

if not p.soaptable
return
end

//cant do anything without these locals first!
local soap = p.soaptable
local me = p.mo

if soap.cosmenuopen
	drawcosmenu(v,p,soap,cosspace,cosinc,disp)
	hud.disable("crosshair")
end

if (p.cmd.buttons & BT_CUSTOM1)
	if not (hud.enabled("crosshair"))
		hud.enable("crosshair")
	end
end

if me.skin == "soapthehedge"	
	
/*
	if (not me.health)
//	or (p.exiting)
		return
	end
//	if (p.powers[pw_carry] == CR_NIGHTSMODE)
//		return
//	end
*/

//EW I HATE THIS THING!!!
///////FT START
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
		
		v.drawString(soap.ftx, soap.fty, "New to\x88 Soap\x80? Check out\x86 soap_help\x80 to learn the ins and outs of\x88 Soap\x80.",V_ALLOWLOWERCASE|V_PERPLAYER|V_HUDTRANS, "thin-center")
		v.drawString(soap.ftx, soap.fty+8, 'Played\x88 Soap\x80 before? Use\x86 soap_file_load "backup"\x80 to load your Config.',V_ALLOWLOWERCASE|V_PERPLAYER|V_HUDTRANS, "thin-center")
		v.drawString(soap.ftx, (soap.fty+20), "\x86Use soap_help in console or press C2 to close",V_10TRANS|V_ALLOWLOWERCASE|V_PERPLAYER, "small-center")
	end

	if (soap.Scustom2OS)
	and not soap.firstttic
	and (not soap.ftkill)
		soap.ftkill = TICRATE
	end
///////FT END

if ((p.mrce) or (soap.isCloneF))
	superc3add = -20
end

//ok! lets copy that c2 thing
	//c2 indicator to show shield abilities are binded to c2
	if not soap.noShield
	and soap.isSValid
	//next to life
	//	v.drawScaled(((hudinfo[HUD_LIVES].x*5)*FRACUNIT), 175*FRACUNIT, FRACUNIT/5, v.cachePatch("SOAPC2"), V_SNAPTOLEFT|V_SNAPTOBOTTOM,v.getColormap(nil, nil))
	//	v.drawString((hudinfo[HUD_LIVES].x*6)+2, hudinfo[HUD_LIVES].y+5, "Shield Ability",V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOBOTTOM, "small")
	//above life
		if not ((p.mrce) or (soap.isCloneF))
			superc3add = -20
			v.drawScaled(hudinfo[HUD_LIVES].x*FRACUNIT, (hudinfo[HUD_LIVES].y-20)*FRACUNIT, FRACUNIT/5, v.cachePatch("SOAPC2"), V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER|V_HUDTRANS,v.getColormap(nil, nil))
			if not ((RingSlinger) and (G_RingSlingerGametype()))
				v.drawString(hudinfo[HUD_LIVES].x+20, hudinfo[HUD_LIVES].y-14, "Shield Ability ("+(soap.hudshieldability)+")",V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER|V_HUDTRANS, "small")
			else
				//wrap for ringslinger neo
				v.drawString(hudinfo[HUD_LIVES].x+20, hudinfo[HUD_LIVES].y-16, "Shield Ability \n("+(soap.hudshieldability)+")",V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER|V_HUDTRANS, "small")
			end
		else //move up to account for mrce hud and for clonefighter
			superc3add = -40
			v.drawScaled(hudinfo[HUD_LIVES].x*FRACUNIT, (hudinfo[HUD_LIVES].y-40)*FRACUNIT, FRACUNIT/5, v.cachePatch("SOAPC2"), V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER|V_HUDTRANS,v.getColormap(nil, nil))
			v.drawString(hudinfo[HUD_LIVES].x+20, hudinfo[HUD_LIVES].y-34, "Shield Ability ("+(soap.hudshieldability)+")",V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER|V_HUDTRANS, "small")
		end
	end
//

//show that c3 makes you super!
if (p.rings >= 50) and All7Emeralds(emeralds)
and not p.powers[pw_super]
and SoapFetchConstant("soap_devbuild")
	v.drawScaled(hudinfo[HUD_LIVES].x*FRACUNIT, ((hudinfo[HUD_LIVES].y-20)*FRACUNIT)+(superc3add*FRACUNIT), FRACUNIT/5, v.cachePatch("SOAPC3"), V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER,v.getColormap(nil, nil))
	v.drawString(hudinfo[HUD_LIVES].x+20, (hudinfo[HUD_LIVES].y-14)+superc3add, "Super",V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER, "small")
end


//just look at your trail
/*
	if soap.airdashtimer
	and soap.airdashtimer <= 70
	and not soap.airdashed
		v.drawString(soap.ftx+135, soap.fty+60, 70-soap.airdashtimer+"/70",V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_PERPLAYER|V_HUDTRANS, "small-center")
	end
*/

//yucky
//these are center aligned by default!
speed1x = 160+40
speed1y = hudinfo[HUD_LIVES].y-4
speed1type = "center"

speed1x2 = 160+40
speed1y2 = hudinfo[HUD_LIVES].y+2
speed1type2 = "thin-center"

speed2x = 155+35
speed2y = hudinfo[HUD_LIVES].y-4
speed2x2 = 166+35
speed2y2 = hudinfo[HUD_LIVES].y
	
speednx = 160+35
speedny = hudinfo[HUD_LIVES].y-2

if (not RingSlinger)
	//right-aligned
	speed1x = 315-60
	speed1x2 = 320-60
	speed1type = "right" 
	speed1type2 = "thin-right"

	speed2x = 155+125-60
	speed2y = hudinfo[HUD_LIVES].y-4
	speed2x2 = 166+125-60
	speed2y2 = hudinfo[HUD_LIVES].y
		
	speednx = 160+125-60
	speedny = hudinfo[HUD_LIVES].y-2

else
	//ringlinger neo
	if G_RingSlingerGametype()

		if soap.isFirstPerson
			smflag = $|V_SNAPTOLEFT &~V_SNAPTORIGHT
			if soap.isZE
				speed1y = $-45
				speed1y2 = $-45
				
				speed2y = $-45
				speed2y2 = $-45
				
				speedny = $-45
			else
				speed1y = $+12
				speed1y2 = $+12
				
				speed2y = $+13
				speed2y2 = $+13
				
				speedny = $+13				
			end
		else
			//right-aligned
			speed1x = 315-60
			speed1x2 = 320-60
			speed1type = "right" 
			speed1type2 = "thin-right"

			speed2x = 155+125-60
			speed2y = hudinfo[HUD_LIVES].y-4
			speed2x2 = 166+125-60
			speed2y2 = hudinfo[HUD_LIVES].y
				
			speednx = 160+125-60
			speedny = hudinfo[HUD_LIVES].y-2
		end
	else
		//right-aligned
		speed1x = 315-60
		speed1x2 = 320-60
		speed1type = "right" 
		speed1type2 = "thin-right"

		speed2x = 155+125-60
		speed2y = hudinfo[HUD_LIVES].y-4
		speed2x2 = 166+125-60
		speed2y2 = hudinfo[HUD_LIVES].y
			
		speednx = 160+125-60
		speedny = hudinfo[HUD_LIVES].y-2

	end
end

local color = V_REDMAP
local color2 = V_GREENMAP

if p.ptaistyle and (p.ptaistyle == 2)

	color = V_SKYMAP
	color2 = V_ROSYMAP

elseif p.ptaistyle and (p.ptaistyle == 3)
and ((p.ptaicolor1) and (p.ptaicolor2))

	color = skincolors[p.ptaicolor1].chatcolor
	color2 = skincolors[p.ptaicolor2].chatcolor
	
end

if (v.RandomRange(1,2)) == 1
and not paused
and me.prevleveltime ~= leveltime
	mach4f = color2
else
	mach4f = color
end

/*
if soap.ptaicolor == 1	
	mach4f = V_REDMAP
else
	mach4f = V_GREENMAP
end
*/

//ringslinger neo "viewmodel" covers this. too bad!
//add soap after ringslinger neo!
if p.powers[pw_carry] ~= CR_NIGHTSMODE
if soap.cosspeedometer
	if soap.cosspeedometer == 1
		v.drawString(speed1x, speed1y, soap.accSpeed, smflag, speed1type2)		
	//	v.drawString((hudinfo[HUD_LIVES].x*20)+14, hudinfo[HUD_LIVES].y-2, "/",smflag, "thin")
		v.drawString(speed1x2, speed1y2, p.normalspeed, smflag|V_YELLOWMAP, speed1type)
	elseif soap.cosspeedometer == 2
		v.drawString(speed2x, speed2y, soap.accSpeed/FRACUNIT, smflag, "thin-right")		
		v.drawString(speednx, speedny, "/",smflag, "thin")
		v.drawString(speed2x2, speed2y2, p.normalspeed/FRACUNIT, smflag|V_YELLOWMAP, "left")
	end
end
end

if p.powers[pw_underwater]
and not soap.isGod
	drawammobar(v, p, me)
end


if p.dashmode >= 4*TICRATE
and not soap.isTransform
	v.drawString(160, 128, p.dashmode-(4*TICRATE), V_HUDTRANS|V_ALLOWLOWERCASE|V_PERPLAYER|mach4f, "small-center")
end

//whoops!
if p.powers[pw_carry] == CR_PLAYER
	if me.tracer and me.tracer.player
		if (me.tracer.player.powers[pw_tailsfly] < 17) 
		and (me.tracer.player.charability == CA_FLY) 
		and (me.tracer.skin == "poyo")
		and not soap.helpedpoyo
			if (leveltime % 2 == 0)			
				v.drawString(soap.ftx, soap.fty+31, "\x85"+"Spin: Boost!",V_HUDTRANS|V_ALLOWLOWERCASE|V_PERPLAYER, "small-center")
			else
				v.drawString(soap.ftx, soap.fty+32, "\x83"+"Spin: Boost!",V_HUDTRANS|V_ALLOWLOWERCASE|V_PERPLAYER, "small-center")	
			end
		end
	end
end


if soap.divecancel
	if soap.divecancel <= 16
		drawdivecancelbar(v,p,me,soap)
		if soap.Scustom1DOWN
			v.drawString(175, 105, "C1: Air Boost",V_HUDTRANS|V_YELLOWMAP|V_ALLOWLOWERCASE|V_PERPLAYER, "small")
		else
			v.drawString(175, 105, "C1: Air Boost",V_50TRANS|V_ALLOWLOWERCASE|V_PERPLAYER, "small")
		end
	end
end
/*
soap.supertaunthudhelper > 201
local shift = soap.supertaunthudhelper-201
soap.supertaunthudhelper < 10
local shift = 10-soap.supertaunthudhelper
V_ALPHASHIFT
*/
//supertauntdisp
if soap.supertaunthudhelper
or (soap.supertauntready and (paused or menuactive))
	//fade in
	if soap.supertaunthudhelper > 201
		local shift = soap.supertaunthudhelper-201
		v.drawScaled((160+supertauntdisp)*FRACUNIT, 158*FRACUNIT, FRACUNIT/5, v.cachePatch("SOAPC2"), V_PERPLAYER|(shift<<V_ALPHASHIFT),v.getColormap(nil, nil))
		v.drawScaled((179+supertauntdisp)*FRACUNIT+(FRACUNIT/10), 163*FRACUNIT+(FRACUNIT/4), FRACUNIT/5, v.cachePatch("SOAPPLUS"), V_PERPLAYER|(shift<<V_ALPHASHIFT),v.getColormap(nil, nil))
		v.drawScaled((190+supertauntdisp)*FRACUNIT, 158*FRACUNIT, FRACUNIT/5, v.cachePatch("SOAPC3"), V_PERPLAYER|(shift<<V_ALPHASHIFT),v.getColormap(nil, nil))
		v.drawString(212+supertauntdisp, 163, "Super Taunt",(shift<<V_ALPHASHIFT)|V_ALLOWLOWERCASE|V_PERPLAYER, "thin")
	elseif soap.supertaunthudhelper < 10
		local shift = 10-soap.supertaunthudhelper
		v.drawScaled((160+supertauntdisp)*FRACUNIT, 158*FRACUNIT, FRACUNIT/5, v.cachePatch("SOAPC2"), V_PERPLAYER|(shift<<V_ALPHASHIFT),v.getColormap(nil, nil))
		v.drawScaled((179+supertauntdisp)*FRACUNIT+(FRACUNIT/10), 163*FRACUNIT+(FRACUNIT/4), FRACUNIT/5, v.cachePatch("SOAPPLUS"), V_PERPLAYER|(shift<<V_ALPHASHIFT),v.getColormap(nil, nil))
		v.drawScaled((190+supertauntdisp)*FRACUNIT, 158*FRACUNIT, FRACUNIT/5, v.cachePatch("SOAPC3"), V_PERPLAYER|(shift<<V_ALPHASHIFT),v.getColormap(nil, nil))
		v.drawString(212+supertauntdisp, 163, "Super Taunt",(shift<<V_ALPHASHIFT)|V_ALLOWLOWERCASE|V_PERPLAYER, "thin")
	else
		v.drawScaled((160+supertauntdisp)*FRACUNIT, 158*FRACUNIT, FRACUNIT/5, v.cachePatch("SOAPC2"), V_PERPLAYER|V_HUDTRANS,v.getColormap(nil, nil))
		v.drawScaled((179+supertauntdisp)*FRACUNIT+(FRACUNIT/10), 163*FRACUNIT+(FRACUNIT/4), FRACUNIT/5, v.cachePatch("SOAPPLUS"), V_PERPLAYER|V_HUDTRANS,v.getColormap(nil, nil))
		v.drawScaled((190+supertauntdisp)*FRACUNIT, 158*FRACUNIT, FRACUNIT/5, v.cachePatch("SOAPC3"), V_PERPLAYER|V_HUDTRANS,v.getColormap(nil, nil))
		v.drawString(212+supertauntdisp, 163, "Super Taunt",V_HUDTRANS|V_ALLOWLOWERCASE|V_PERPLAYER, "thin")	
	end
	if paused
	or menuactive
		v.drawScaled((160+supertauntdisp)*FRACUNIT, 158*FRACUNIT, FRACUNIT/5, v.cachePatch("SOAPC2"), V_PERPLAYER|V_HUDTRANS,v.getColormap(nil, nil))
		v.drawScaled((179+supertauntdisp)*FRACUNIT+(FRACUNIT/10), 163*FRACUNIT+(FRACUNIT/4), FRACUNIT/5, v.cachePatch("SOAPPLUS"), V_PERPLAYER|V_HUDTRANS,v.getColormap(nil, nil))
		v.drawScaled((190+supertauntdisp)*FRACUNIT, 158*FRACUNIT, FRACUNIT/5, v.cachePatch("SOAPC3"), V_PERPLAYER|V_HUDTRANS,v.getColormap(nil, nil))
		v.drawString(212+supertauntdisp, 163, "Super Taunt",V_HUDTRANS|V_ALLOWLOWERCASE|V_PERPLAYER, "thin")		
	end

end

//super taunt ready? let us know!
if soap.isFirstPerson
and soap.supertauntready
	v.drawString(280,165,"Super Taunt Ready!",V_HUDTRANS|V_ALLOWLOWERCASE|V_SNAPTORIGHT|V_SNAPTOBOTTOM|V_PERPLAYER,"small-center")
	v.drawScaled(280*FRACUNIT, 160*FRACUNIT, FRACUNIT/4, v.getSpritePatch("TANT", D, 0, 0), V_HUDTRANS|V_SNAPTORIGHT|V_SNAPTOBOTTOM|V_PERPLAYER,v.getColormap(nil,nil))
end

//rollball paper doll
if p.pflags & PF_SPINNING
and ((me.state == S_PLAY_ROLL) or (me.state == S_PLAY_JUMP))
and soap.isFirstPerson
	v.drawScaled(279*FRACUNIT, 157*FRACUNIT, FRACUNIT/8, v.getSprite2Patch("soapthehedge","ROLL",false,me.frame, 3, 0), V_FLIP|V_HUDTRANS|V_SNAPTORIGHT|V_SNAPTOBOTTOM|V_PERPLAYER,v.getColormap(nil,me.color))	
end

local combdisp = 8
local comby = 0
local endmovedown = 0
if p.pflags & PF_FINISHED
	comby = 5+5+15
end
//combo stuff
if soap.combotime
	v.draw(hudinfo[HUD_RINGS].x-combdisp+5,hudinfo[HUD_RINGS].y+14+comby,v.cachePatch("COMBBACK"),V_SNAPTOLEFT|V_SNAPTOTOP|V_30TRANS|V_PERPLAYER, v.getColormap(nil, SKINCOLOR_BLACK))
	v.drawNum(hudinfo[HUD_RINGS].x+16+combdisp,hudinfo[HUD_RINGS].y+20+comby,soap.combocount,V_HUDTRANS|V_SNAPTOLEFT|V_SNAPTOTOP|V_PERPLAYER)
	v.drawString(hudinfo[HUD_RINGS].x+18+combdisp,hudinfo[HUD_RINGS].y+20+comby,"Combo!",V_HUDTRANS|V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOTOP|V_PERPLAYER,"thin")
	drawcombotimebar(v,p,me,soap,combdisp,comby)
	if ((p.chaos) and (p.chaos.combotime > SoapFetchConstant("combo_maxtime")))
		local diff = p.chaos.combotime-SoapFetchConstant("combo_maxtime")
		v.drawString(hudinfo[HUD_RINGS].x+18+combdisp,hudinfo[HUD_RINGS].y+32+comby,"+ "..diff.." tics",V_HUDTRANS|V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOTOP|V_PERPLAYER,"small")		
	end
	endmovedown = 25
end
if soap.comboendtics
	if not soap.combolastroundtics
		v.drawString(hudinfo[HUD_RINGS].x+4,hudinfo[HUD_RINGS].y+20+endmovedown+comby,"That combo was",V_HUDTRANS|V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOTOP|V_PERPLAYER,"thin")
	else
		v.drawString(hudinfo[HUD_RINGS].x+4,hudinfo[HUD_RINGS].y+20+endmovedown+comby,"Last round, your combo was",V_HUDTRANS|V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOTOP|V_PERPLAYER,"thin")
	end
	
	v.drawString(hudinfo[HUD_RINGS].x+34,hudinfo[HUD_RINGS].y+20+17+endmovedown+comby,soap.comboendrank,V_HUDTRANS|V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOTOP|V_PERPLAYER,"thin-center")
	if soap.comboendvery
		v.drawScaled((hudinfo[HUD_RINGS].x-combdisp+5+7)*FRACUNIT,(hudinfo[HUD_RINGS].y+14+15+endmovedown+comby)*FRACUNIT,FRACUNIT/3,v.cachePatch("COMBVERY"),V_SNAPTOLEFT|V_SNAPTOTOP|V_HUDTRANS|V_PERPLAYER, v.getColormap(nil, nil))	
	end
	
	v.drawString(hudinfo[HUD_RINGS].x+35,hudinfo[HUD_RINGS].y+20+34+endmovedown+comby,soap.comboendscore,V_HUDTRANS|V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOTOP|V_PERPLAYER,"small-center")

end
if soap.comborankuptic
	local xdisp = 10
	local ydisp = 15
	v.drawString(hudinfo[HUD_RINGS].x+34+xdisp,hudinfo[HUD_RINGS].y+20+17+ydisp,soap.comboranks[ ((soap.comborank-1) % 15)+1],V_HUDTRANS|V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOTOP|V_PERPLAYER,"thin-center")
	if soap.combovery
		v.drawScaled((hudinfo[HUD_RINGS].x-combdisp+5+7+xdisp)*FRACUNIT,(hudinfo[HUD_RINGS].y+14+15+ydisp)*FRACUNIT,FRACUNIT/3,v.cachePatch("COMBVERY"),V_SNAPTOLEFT|V_SNAPTOTOP|V_HUDTRANS|V_PERPLAYER, v.getColormap(nil, nil))	
	end
end

local rankhudx = (hudinfo[HUD_RINGS].x-combdisp+5+7)
local rankhudy = 100
local rankhudf = V_SNAPTOLEFT|V_HUDTRANS|V_PERPLAYER
/*
if gametype == GT_COOP
and soap.pizzatowerstuff
if not SoapFetchConstant("soap_inbossmap")

	if (LB_Soap.rankscores[gamemap] ~= nil)

	//D
	if soap.rank == 1
		
		local num = abs((LB_Soap.rankscores[gamemap]*FRACUNIT)/4)
		local uhh = FixedDiv(
		soap.rankscore*FRACUNIT,
		num)
		
		uhh = abs(uhh)
		
		local scale = LB_Soap.rankfilly[1]-(FixedMul(uhh,LB_Soap.rankfilly[1]))
		if scale < 0 then scale = 0 end
		v.drawScaled(rankhudx*FRACUNIT-(soap.rankgrow*20),rankhudy*FRACUNIT-(soap.rankgrow*20),FRACUNIT/3+soap.rankgrow,v.cachePatch("HUDRANKD"),rankhudf, v.getColormap(nil, nil))
		v.drawCropped(rankhudx*FRACUNIT,rankhudy*FRACUNIT+(scale/3),FRACUNIT/3,FRACUNIT/3,v.cachePatch("RANKFILLD"),rankhudf, v.getColormap(nil, nil),0,scale,LB_Soap.rankfillx[1],LB_Soap.rankfilly[1])

	//C
	elseif soap.rank == 2
		
		local num = abs((LB_Soap.rankscores[gamemap]*FRACUNIT)/4)
		local uhh = FixedDiv(
		((soap.rankscore*FRACUNIT)-num)*2,
		num*2)
		
		uhh = abs(uhh)
		
		local scale = LB_Soap.rankfilly[2]-(FixedMul(uhh,LB_Soap.rankfilly[2]))
		if scale < 0 then scale = 0 end
		v.drawScaled(rankhudx*FRACUNIT-(soap.rankgrow*20),rankhudy*FRACUNIT-(soap.rankgrow*20),FRACUNIT/3+soap.rankgrow,v.cachePatch("HUDRANKC"),rankhudf, v.getColormap(nil, nil))
		v.drawCropped(rankhudx*FRACUNIT,rankhudy*FRACUNIT+(scale/3),FRACUNIT/3,FRACUNIT/3,v.cachePatch("RANKFILLC"),rankhudf, v.getColormap(nil, nil),0,scale,LB_Soap.rankfillx[2],LB_Soap.rankfilly[2])
		
	//B
	elseif soap.rank == 3

		local num = abs((LB_Soap.rankscores[gamemap]*FRACUNIT)/4)
		local num2 = abs((LB_Soap.rankscores[gamemap]*FRACUNIT)/2)
		local uhh = FixedDiv(
		((soap.rankscore*FRACUNIT)-num-num)*2,
		num*2)
		
		uhh = abs(uhh)
		
		local scale = LB_Soap.rankfilly[3]-(FixedMul(uhh,LB_Soap.rankfilly[3]))
		if scale < 0 scale = 0 end
		v.drawScaled(rankhudx*FRACUNIT-(soap.rankgrow*20),rankhudy*FRACUNIT-(soap.rankgrow*20),FRACUNIT/3+soap.rankgrow,v.cachePatch("HUDRANKB"),rankhudf, v.getColormap(nil, nil))
		v.drawCropped(rankhudx*FRACUNIT,rankhudy*FRACUNIT+(scale/3),FRACUNIT/3,FRACUNIT/3,v.cachePatch("RANKFILLB"),rankhudf, v.getColormap(nil, nil),0,scale,LB_Soap.rankfillx[3],LB_Soap.rankfilly[3])
		
	//A
	elseif soap.rank == 4

		local num = abs((LB_Soap.rankscores[gamemap]*FRACUNIT)/4)
		local uhh
		
		uhh = FixedDiv(
		((soap.rankscore*FRACUNIT)-num-num-num)*2,
		num*2)
		
		uhh = abs(uhh)
		
		local scale = LB_Soap.rankfilly[4]-(FixedMul(uhh,LB_Soap.rankfilly[4]))
		if scale < 0 then scale = 0 end
		v.drawScaled(rankhudx*FRACUNIT-(soap.rankgrow*20),rankhudy*FRACUNIT-(soap.rankgrow*20),FRACUNIT/3+soap.rankgrow,v.cachePatch("HUDRANKA"),rankhudf, v.getColormap(nil, nil))
		v.drawCropped(rankhudx*FRACUNIT,rankhudy*FRACUNIT+(scale/3),FRACUNIT/3,FRACUNIT/3,v.cachePatch("RANKFILLA"),rankhudf, v.getColormap(nil, nil),0,scale,LB_Soap.rankfillx[4],LB_Soap.rankfilly[4])
		
	//S
	elseif soap.rank == 5
		v.drawScaled(rankhudx*FRACUNIT-(soap.rankgrow*20),rankhudy*FRACUNIT-(soap.rankgrow*20),FRACUNIT/3+soap.rankgrow,v.cachePatch("HUDRANKS"),rankhudf, v.getColormap(nil, nil))
		
	//P
	elseif soap.rank == 6
		v.drawScaled(rankhudx*FRACUNIT-(soap.rankgrow*20),rankhudy*FRACUNIT-(soap.rankgrow*20),FRACUNIT/3+soap.rankgrow,v.cachePatch("HUDRANKP"),rankhudf, v.getColormap(nil, nil))
		
	end

	end

else
	
	local rankhud = "HUDRANKD"
	
	if soap.rank == 2
		rankhud = "HUDRANKC"
	elseif soap.rank == 3
		rankhud = "HUDRANKB"
	elseif soap.rank == 4
		rankhud = "HUDRANKA"
	elseif soap.rank == 5
		rankhud = "HUDRANKS"
	elseif soap.rank == 6
		rankhud = "HUDRANKP"
	end

	v.drawScaled(rankhudx*FRACUNIT-(soap.rankgrow*20),100*FRACUNIT-(soap.rankgrow*20),FRACUNIT/3+soap.rankgrow,v.cachePatch(rankhud),rankhudf, v.getColormap(nil, nil))

end
end //dont delete this
*/
//v.drawString(hudinfo[HUD_RINGS].x,hudinfo[HUD_RINGS].y+12+8+6,soap.combotime,V_HUDTRANS|V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOTOP|V_PERPLAYER,"thin")

local scorex = hudinfo[HUD_SCORENUM].x
local scorey = hudinfo[HUD_SCORENUM].y
local scoref = hudinfo[HUD_SCORENUM].f|V_HUDTRANS
local score2x = hudinfo[HUD_SCORE].x
local score2y = hudinfo[HUD_SCORE].y
local score2f = hudinfo[HUD_SCORE].f|V_HUDTRANS

/*
//if gametype == GT_COOP
if not SoapFetchConstant("soap_isspecialstage")
and soap.pizzatowerstuff
	hud.disable("score")

	v.draw(score2x,score2y,v.cachePatch("STTSCORE"),score2f,v.getColormap(nil, nil))
	v.drawNum(scorex,scorey,p.score-soap.levelstartscore,scoref)
	if soap.levelstartscore ~= 0
		v.drawString(scorex+8,scorey,"("..p.score..")",scoref,"thin")
	end
end

if not soap.pizzatowerstuff
and not (hud.enabled("score"))
	hud.enable("score")
end
*/
end //skin if

/*
if not (hud.enabled("score"))
and gametyperules & GTR_FRIENDLY
and not G_RingSlingerGametype()
*/
/*
	if not hud.enabled("score")
		hud.enable("score")
	end
*/
//end


//show lag thing
if soap.isElevated
	if SoapIsLargeMap(23)
	and (not shownNotif)
			v.drawString(soap.ftx, soap.fty, "Experiecing lag?",V_ALLOWLOWERCASE|V_HUDTRANS, "thin-center")
			v.drawString(soap.ftx, soap.fty+12, " Try disabling MobjThinkers with "+"\x86"+"soap_mobjthinkers ring_pull "+"\x80"+"to ease the lag.",V_ALLOWLOWERCASE|V_HUDTRANS, "thin-center")
			v.drawString(soap.ftx, (soap.fty+24), "\x86Press Custom1 to dismiss this message.",V_30TRANS|V_ALLOWLOWERCASE, "small-center")
			if p.cmd.buttons & BT_CUSTOM1
			and (not shownNotif)
				shownNotif = true
			end
	elseif not SoapIsLargeMap(234)
		shownNotif = false
	end
end

//show how many YDs are chasing you!
if gametype == GT_YELLOWDEMON
or ((SoapFetchConstant("soap_yellowdemon")) and (me.skin == "soapthehedge"))
or SoapFetchConstant("soap_devmode")
or ((SoapFetchConstant("soap_yellowdemon")) and ((gametype == GT_COOP) and (not netgame)))
	v.drawScaled(((hudinfo[HUD_LIVES].x*5)*FRACUNIT)+(5*FRACUNIT), 189*FRACUNIT, FRACUNIT/2,v.getSpritePatch("RING", A, 0, 0), V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_HUDTRANS|V_PERPLAYER)
	v.drawString((hudinfo[HUD_LIVES].x*6)+2, hudinfo[HUD_LIVES].y+5, soap.YDcount,V_ALLOWLOWERCASE|V_SNAPTOLEFT|V_SNAPTOBOTTOM|V_HUDTRANS|V_PERPLAYER, "thin")
end

if soap.cosmenuwait
	drawcosmenuwaitbar(v,p,soap)
end

local bananaflag = 0
local bananatext = ""

if not soap.devmode
and soap.isElevated
	if #LB_Soap.bananalist >= (SoapFetchConstant("soap_bananalimit")/2)
	and #LB_Soap.bananalist > 0
		if #LB_Soap.bananalist >= (4*SoapFetchConstant("soap_bananalimit")/5)
			bananatext = " Too many bananas!"
			if (leveltime % 4) <= 1
				bananaflag = V_REDMAP
			end
		end
		
		if bananatext == " Too many bananas!"
		and not soap.cosusedlimitbefore
			v.drawString(hudinfo[HUD_LIVES].x-40,hudinfo[HUD_LIVES].y-1-24,"Use \x86soap_bananalimit\x80 to change",V_ALLOWLOWERCASE|V_HUDTRANS,"thin")
			v.drawString(hudinfo[HUD_LIVES].x-40,hudinfo[HUD_LIVES].y-1-16,"the limit on bananas!",V_ALLOWLOWERCASE|V_HUDTRANS,"thin")
			v.drawString(hudinfo[HUD_LIVES].x-40,hudinfo[HUD_LIVES].y-1-8,"Or \x86soap_rawset_banana_clear\x80 to clear.",V_ALLOWLOWERCASE|V_HUDTRANS,"thin")
		end
		
		v.drawString(hudinfo[HUD_LIVES].x-24,hudinfo[HUD_LIVES].y-1,#LB_Soap.bananalist.."/"..SoapFetchConstant("soap_bananalimit")..bananatext,V_ALLOWLOWERCASE|V_HUDTRANS|bananaflag,"thin")
		v.drawScaled((hudinfo[HUD_LIVES].x-32)*FRACUNIT, (hudinfo[HUD_LIVES].y+5)*FRACUNIT, FRACUNIT/5, v.getSpritePatch("SBAN", A, 0, 0), V_HUDTRANS,v.getColormap(nil,nil))	
		
		
	end
end

if soap.devmode
	DevmodeFlags(v, p)
	
	local stflag = 0
	
	v.drawString(hudinfo[HUD_LIVES].x-24,hudinfo[HUD_LIVES].y-1,#LB_Soap.bananalist.."/"..SoapFetchConstant("soap_bananalimit"),V_ALLOWLOWERCASE|V_HUDTRANS,"thin")
	v.drawScaled((hudinfo[HUD_LIVES].x-32)*FRACUNIT, (hudinfo[HUD_LIVES].y+5)*FRACUNIT, FRACUNIT/5, v.getSpritePatch("SBAN", A, 0, 0), V_HUDTRANS,v.getColormap(nil,nil))	
	
	if soap.supertauntready then stflag = V_YELLOWMAP end
	
	v.drawString(hudinfo[HUD_LIVES].x-24,hudinfo[HUD_LIVES].y-9,(soap.supertauntringsleft),stflag|V_ALLOWLOWERCASE|V_HUDTRANS,"thin")
	v.drawString(hudinfo[HUD_LIVES].x+8,hudinfo[HUD_LIVES].y-9,(soap.supertauntkillsleft),stflag|V_ALLOWLOWERCASE|V_HUDTRANS,"thin")
	v.drawString(hudinfo[HUD_LIVES].x+36,hudinfo[HUD_LIVES].y-9,(soap.supertauntfragsleft),stflag|V_ALLOWLOWERCASE|V_HUDTRANS,"thin")
	v.drawScaled((hudinfo[HUD_LIVES].x-32)*FRACUNIT, (hudinfo[HUD_LIVES].y-3)*FRACUNIT, FRACUNIT/5, v.getSpritePatch("RING", A, 0, 0), V_HUDTRANS,v.getColormap(nil,nil))	
	v.drawScaled((hudinfo[HUD_LIVES].x-2)*FRACUNIT, (hudinfo[HUD_LIVES].y-3)*FRACUNIT, FRACUNIT/5, v.getSpritePatch("POSS", A, 2, 0), V_FLIP|V_HUDTRANS,v.getColormap(nil,nil))
	v.drawScaled((hudinfo[HUD_LIVES].x+28)*FRACUNIT, (hudinfo[HUD_LIVES].y-3)*FRACUNIT, FRACUNIT/6, v.getSprite2Patch("sonic","DEAD",false,A, 2, 0), V_HUDTRANS,v.getColormap(nil,me.color))	
	
	if soap.bananatime
		v.drawString(-10, 100-8-8-8-8, "Banana Time: ("..soap.bananatime/TICRATE..") "..soap.bananatime,V_ALLOWLOWERCASE|V_HUDTRANS, "thin")
	end
	
	local x = 160
	local y = 150
	local barx = x
	local bary = y+8
	if soap.bananaskid
		v.drawScaled(barx*FRACUNIT, bary*FRACUNIT, FRACUNIT/2, v.getSpritePatch("SBAN", A, 0, 0), V_50TRANS|V_PERPLAYER,v.getColormap(nil,nil))
	elseif soap.bananapeeled
		v.drawScaled(barx*FRACUNIT, bary*FRACUNIT, FRACUNIT/2, v.getSpritePatch("SBAN", A, 0, 0), V_HUDTRANS|V_PERPLAYER,v.getColormap(nil,nil))
	end
	if soap.isWatered
		v.drawString(-10, 100-8-8-8, "Underwater: ("..p.powers[pw_underwater]/TICRATE..") "..p.powers[pw_underwater],V_ALLOWLOWERCASE|V_HUDTRANS, "thin")
	end
	if soap.goobounce
		v.drawString(-10, 100-8-8-8-8, "Goobounce: "..soap.goobounce,V_ALLOWLOWERCASE|V_HUDTRANS, "thin")
	end
	if soap.airdashtimer
		v.drawString(-10, 100-8-8, "Airdash Timer: "..(70-soap.airdashtimer),V_ALLOWLOWERCASE|V_HUDTRANS, "thin")	
	end
	v.drawString(-10, 100-8, "Dashmode: "..p.dashmode,V_ALLOWLOWERCASE|V_HUDTRANS, "thin")

	if ((soap.starteddive) or (soap.divemomz) or (soap.diveanimstart))
		v.drawString(-10, 100, "divemomz: ("..soap.divemomz/FRACUNIT..") "..soap.divemomz,V_ALLOWLOWERCASE|V_HUDTRANS, "thin")
		v.drawString(-10, 108, "Blast Radius: ("..(abs(soap.divemomz)*10)/FRACUNIT..") "..abs(soap.divemomz)*10,V_ALLOWLOWERCASE|V_HUDTRANS, "thin")
		v.drawString(-10, 108+8, "Startup Anim Length: "..soap.diveanimstart,V_ALLOWLOWERCASE|V_HUDTRANS, "thin")
	end
	if soap.cosmenuopen
		v.drawString(-10, 100, "Controls: "..soap.cosmenuleft.." "..soap.cosmenuright.." "..soap.cosmenuup.." "..soap.cosmenudown,V_ALLOWLOWERCASE|V_HUDTRANS, "thin")
		v.drawString(-10, 108, "Page Controls: "..soap.cosmenuflipp.." "..soap.cosmenuflipn,V_ALLOWLOWERCASE|V_HUDTRANS, "thin")
		v.drawString(-10, 116, "Cursor: "..soap.cosmenucurx..", "..soap.cosmenucury,V_ALLOWLOWERCASE|V_HUDTRANS, "thin")
		v.drawString(-10, 132-8, "Selection: (soap_)"..soap.cosmenuselect,V_ALLOWLOWERCASE|V_HUDTRANS, "thin")
		v.drawString(-10, 140-8, "Page: "..soap.cosmenupage,V_ALLOWLOWERCASE|V_HUDTRANS, "thin")
		v.drawString(-10, 148-8, "Cooldown: "..soap.cosmenucooldown,V_ALLOWLOWERCASE|V_HUDTRANS, "thin")
	end
	if ((soap.bounced) or (soap.bounceagain) or (soap.bouncecount))
		v.drawString(-10, 100, "Bouncing Down: "..soap.bounced,V_ALLOWLOWERCASE|V_HUDTRANS, "thin")
		v.drawString(-10, 100+8, "Bouncing Up: "..soap.bounceagain,V_ALLOWLOWERCASE|V_HUDTRANS, "thin")
		v.drawString(-10, 100+8+8, "Bounce Count: "..soap.bouncecount/me.scale.." Can Bounce? "..tostring((soap.bouncecount <= (8*FRACUNIT))),V_ALLOWLOWERCASE|V_HUDTRANS, "thin")
	end
end

end, "game")

