/obj/item/airlock_painter/wall_painter
	name = "wall painter"
	desc = "An advanced autopainter designed to paint over walls."
	initial_ink_type = /obj/item/toner/large
	var/set_color = "#FFFFFF"

/obj/item/airlock_painter/wall_painter/ui_interact(mob/user, datum/tgui/ui)
	return // nuh

/obj/item/airlock_painter/wall_painter/attack_self(mob/user, modifiers)
	var/new_color = tgui_color_picker(user, "Set Trim Color", "[src]", set_color)
	if(new_color)
		set_color = new_color

/obj/item/airlock_painter/wall_painter/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(iswallturf(get_turf(interacting_with)) && use_paint(user))
		var/obj/effect/wall_trim/new_trim = new get_turf(interacting_with)
		new_trim.color = set_color
		new_trim.apply_to_wall_or_window()
		return ITEM_INTERACT_SUCCESS
	return NONE
