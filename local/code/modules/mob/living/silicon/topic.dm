/mob/living/silicon/Topic(href, href_list)
	. = ..()
	if(href_list["lookup_info"] == "open_examine_panel")
		mob_examine_panel.ui_interact(usr) //datum has a examine_panel datum, here we open the window
