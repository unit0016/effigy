/obj/effect/wall_trim
	name = "wall trim helper"
	icon = 'local/icons/turf/walls/wall_trim.dmi'
	icon_state = "wall-0"
	color = "#FFFFFF"
	alpha = 255

/obj/effect/wall_trim/Initialize(mapload)
	. = ..()
	var/turf/closed/wall/our_turf = get_turf(src)
	if(!iswallturf(our_turf))
		CRASH("[src] tried to initialize but wasn't on a wall!")
	our_turf.trim_color = color
	our_turf.trim_alpha = alpha
	our_turf.update_appearance()
	qdel(src)

/obj/effect/wall_trim/security
	color = COLOR_SECURITY_RED
	alpha = 125
