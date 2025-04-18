/turf/closed/indestructible/normal_wall
	name = "wall"
	icon = 'icons/turf/walls/wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_WALLS

/turf/closed/indestructible/fakedoor/blast_door
	name = /obj/machinery/door/poddoor::name
	desc = /obj/machinery/door/poddoor::desc
	icon = /obj/machinery/door/poddoor::icon
	icon_state = /obj/machinery/door/poddoor::icon_state

/turf/closed/indestructible/opsglass
	icon = 'local/icons/obj/smooth_structures/plastitanium_window.dmi'

/turf/closed/indestructible/splashscreen/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSprocessing, src)

/turf/closed/indestructible/splashscreen/process(seconds_per_tick)
	. = ..()
	transform = transform.Scale(1.25, 1.25) // Resets scale
	color = COLOR_BLACK
	handle_generic_titlescreen_sizes() // Resets X axis
	pixel_y = 0
	/// First we fade in.
	animate(src, 2 SECONDS, color = COLOR_WHITE)
	/// Check our maximum X and Y value; then use that as the ceiling.
	var/icon/size_check = icon(SStitle.icon, icon_state)
	var/max_width = (size_check.Width() * 0.10)
	var/max_height = (size_check.Height() * 0.10)
	transform = transform.Turn(rand(-10, 10))
	animate(src, 10 SECONDS, pixel_x = rand(-max_width, max_width))
	animate(src, 10 SECONDS, pixel_y = rand(-max_height, max_height))
	animate(src, 10 SECONDS, transform = transform.Turn(rand(-10, 10)))
	sleep(8 SECONDS)
	animate(src, 2 SECONDS, color = COLOR_BLACK)
	sleep(2 SECONDS)
	transform = null
