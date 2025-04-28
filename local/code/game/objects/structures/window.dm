/obj/structure/window
	var/trim_color = null
	var/trim_alpha = 255

/obj/structure/window/update_overlays()
	. = ..()
	if(trim_color && fulltile)
		var/mutable_appearance/our_mutable = mutable_appearance(/obj/effect/wall_trim::icon, "walltrim-[smoothing_junction]", alpha = trim_alpha)
		our_mutable.color = trim_color
		our_mutable.icon_state = "walltrim-[smoothing_junction]"
		. += our_mutable

/obj/structure/window/fulltile
	canSmoothWith = SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE_SHUTTLE + SMOOTH_GROUP_WINDOW_FULLTILE_PLASTITANIUM + SMOOTH_GROUP_WINDOW_FULLTILE_BRONZE + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_PAPERFRAME + SMOOTH_GROUP_WALLS

/obj/structure/window/reinforced/fulltile
	canSmoothWith = /obj/structure/window/fulltile::canSmoothWith

/obj/structure/window/reinforced/tinted/fulltile
	canSmoothWith = /obj/structure/window/fulltile::canSmoothWith

/obj/structure/window/plasma/fulltile
	canSmoothWith = /obj/structure/window/fulltile::canSmoothWith

/obj/structure/window/reinforced/plasma/fulltile
	canSmoothWith = /obj/structure/window/fulltile::canSmoothWith

/obj/structure/window/reinforced/shuttle
	canSmoothWith = /obj/structure/window/fulltile::canSmoothWith

/obj/structure/window/reinforced/plasma/plastitanium
	canSmoothWith = /obj/structure/window/fulltile::canSmoothWith

/obj/structure/window/paperframe
	canSmoothWith = /obj/structure/window/fulltile::canSmoothWith

/obj/structure/window/bronze/fulltile
	canSmoothWith = /obj/structure/window/fulltile::canSmoothWith
