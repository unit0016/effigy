/turf/closed/wall
	canSmoothWith = SMOOTH_GROUP_WALLS + SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WINDOW_FULLTILE_BRONZE + SMOOTH_GROUP_WINDOW_FULLTILE_PLASTITANIUM + SMOOTH_GROUP_WINDOW_FULLTILE_SHUTTLE + SMOOTH_GROUP_PAPERFRAME
	icon = 'local/icons/turf/walls/wall.dmi'
	var/trim_color = null
	var/trim_alpha = 255

/turf/closed/wall/update_overlays()
	. = ..()
	if(trim_color)
		var/mutable_appearance/our_mutable = mutable_appearance(/obj/effect/wall_trim::icon, src.icon_state, alpha = trim_alpha)
		our_mutable.color = trim_color
		our_mutable.icon_state = icon_state
		. += our_mutable

/turf/closed/wall/set_smoothed_icon_state()
	. = ..()
	update_appearance(UPDATE_ICON)
