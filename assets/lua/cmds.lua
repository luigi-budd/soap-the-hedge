//commands!!!!!

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
end)

COM_AddCommand("soap_uncurl", function(p)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end

	if p.soaptable.isXmo
		CONS_Printf(p,"\x85"+"You can't use this while XMomentum is loaded.")
        return
	end

    if p.soaptable.soapUncurl
 		p.soaptable.soapUncurl = 0
        CONS_Printf(p,"\x8D"+"Soap can no longer uncurl while spinning.")
    else
 		p.soaptable.soapUncurl = 1
        CONS_Printf(p,"\x82"+"Soap can now uncurl while spinning.")
    end
end)

COM_AddCommand("soap_momentum", function(p)
    if not p or not p.soaptable or not p.valid
        CONS_Printf(p, "\x85"+"Soap's table or Soap himself aren't valid yet!")
        return
	end

	if p.soaptable.isXmo
		CONS_Printf(p,"\x85"+"You can't use this while XMomentum is loaded.")
        return
	end

    if p.soaptable.disableMomen
        p.soaptable.disableMomen = 0
		CONS_Printf(p,"\x82"+"Soap's momentum is now enabled.")
    else
        p.soaptable.disableMomen = 1
		CONS_Printf(p,"\x8D"+"Soap's momentum is now disabled.")
    end
end)

COM_AddCommand("soap_help", function(p)
    //so many prints!
    CONS_Printf(p, "\x88"+"Soap the Hedge "+"\x80"+"is a rad, fast, and powerful character!")
    CONS_Printf(p, "\x88"+"Soap "+"\x80"+"includes:")
    CONS_Printf(p,"     "+"\x84"+"Custom momentum "+"\x80"+"by CobaltBW")
    CONS_Printf(p,"     "+"\x84"+"Uncurl "+"\x80"+"by Krabs")
    CONS_Printf(p,"     "+"\x84"+"Spin Control (Rolltrol) "+"\x80"+"by Tempest97 (Krimps)")
    CONS_Printf(p,"     "+"\x84"+"Paper Peelout "+"\x80"+"by SuperPhanto")
    CONS_Printf(p,"\n"+"\x88"+"Soap "+"\x80"+"has several commands for toggling different parts of him for different playstyles.")
    CONS_Printf(p,"I feel like most of these commands are self-explanatory, so I won't explain them that much.")
    CONS_Printf(p,"     "+"\x86"+"soap_help "+"\x80"+": This is the command you are seeing right now.")
    CONS_Printf(p,"     "+"\x86"+"soap_momentum "+"\x80"+": Toggles "+"\x88"+"Soap's "+"\x80"+"momentum.")
    CONS_Printf(p,"     "+"\x86"+"soap_uncurl "+"\x80"+": Toggles uncurling for "+"\x88"+"Soap"+"\x80"+".")
    CONS_Printf(p,"     "+"\x86"+"soap_rolltrol "+"\x80"+": Toggles spin control (rolltrol) for "+"\x88"+"Soap"+"\x80"+".")
    CONS_Printf(p,"\n"+"I hope you have as much fun as I did making this little dude!")
end)