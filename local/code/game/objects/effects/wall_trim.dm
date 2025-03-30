/obj/effect/wall_trim
	name = "wall trim helper"
	icon = 'local/icons/turf/walls/wall_trim.dmi'
	icon_state = "walltrim-0"
	color = "#FFFFFF"
	alpha = 125

/obj/effect/wall_trim/Initialize(mapload)
	. = ..()
	var/turf/closed/wall/our_turf = get_turf(src)
	if(iswallturf(our_turf))
		if(our_turf.trim_color) // Already defined by something else
			CRASH("[src] tried to initialize but the [our_turf] already had it's trim color set!")
		our_turf.trim_color = color
		our_turf.trim_alpha = alpha
		our_turf.update_appearance()
		qdel(src)
		return INITIALIZE_HINT_QDEL
	var/obj/structure/falsewall/found_falsewall = locate(/obj/structure/falsewall) in src.loc.contents
	if(found_falsewall)
		if(found_falsewall.trim_color) // Already defined by something else
			CRASH("[src] tried to initialize but the [found_falsewall] already had it's trim color set!")
		found_falsewall.trim_color = color
		found_falsewall.trim_alpha = alpha
		found_falsewall.update_appearance()
		return INITIALIZE_HINT_QDEL
	var/obj/structure/window/found_window = locate(/obj/structure/window) in src.loc.contents
	if(found_window?.fulltile)
		if(found_window.trim_color) // Already defined by something else
			CRASH("[src] tried to initialize but the [found_window] already had it's trim color set!")
		found_window.trim_color = color
		found_window.trim_alpha = alpha
		found_window.update_appearance()
		return INITIALIZE_HINT_QDEL
	CRASH("[src] tried to initialize but wasn't on a wall or window!")

/// STATION ///
/// Keep these alphabetical
/obj/effect/wall_trim/station/cargo
	color = COLOR_CARGO_BROWN

/obj/effect/wall_trim/station/civilian
	color = COLOR_ASSISTANT_OLIVE

/obj/effect/wall_trim/station/command
	color = COLOR_COMMAND_BLUE

/obj/effect/wall_trim/station/engineering
	color = COLOR_ENGINEERING_ORANGE

/obj/effect/wall_trim/station/medical
	color = COLOR_MEDICAL_BLUE

/obj/effect/wall_trim/station/research
	color = COLOR_SCIENCE_PINK

/obj/effect/wall_trim/station/security
	color = COLOR_SECURITY_RED

/obj/effect/wall_trim/station/security/prison
	color = COLOR_PRISONER_ORANGE

/obj/effect/wall_trim/station/service
	color = COLOR_SERVICE_LIME

/obj/effect/wall_trim/station/service/alt
	color = COLOR_ALMOST_BLACK

/// OFFSTATION ///
/obj/effect/wall_trim/offstation/syndicate
	color = COLOR_SYNDIE_RED

/obj/effect/wall_trim/offstation/syndicate/security
	color = COLOR_DARK_ORANGE

/obj/effect/wall_trim/offstation/nanotrasen
	color = "#61466A"

/// We're using purple primarily; but I want centcom navyblue to be available too
/obj/effect/wall_trim/offstation/nanotrasen/blue
	color = COLOR_CENTCOM_BLUE
