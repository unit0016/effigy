/obj/structure/falsewall
	canSmoothWith = /turf/closed/wall::canSmoothWith
	icon = 'local/icons/turf/walls/false_walls.dmi'
	fake_icon = /turf/closed/wall::icon
	var/trim_color = null
	var/trim_alpha = 255

/obj/structure/falsewall/update_overlays()
	. = ..()
	if(trim_color)
		var/mutable_appearance/our_mutable = mutable_appearance(/obj/effect/wall_trim::icon, "walltrim-[smoothing_junction]", alpha = trim_alpha)
		our_mutable.color = trim_color
		our_mutable.icon_state = "walltrim-[smoothing_junction]"
		. += our_mutable

/obj/structure/falsewall/set_smoothed_icon_state()
	. = ..()
	update_appearance(UPDATE_ICON)
