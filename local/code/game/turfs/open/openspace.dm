/turf/open/water/deep_beach/openspace
	name = "open ocean"
	alpha = 125

/turf/open/water/deep_beach/openspace/Initialize(mapload)
	. = ..()
	if(PERFORM_ALL_TESTS(focus_only/openspace_clear) && !GET_TURF_BELOW(src))
		stack_trace("[src] was inited as openspace with nothing below it at ([x], [y], [z])")
	return INITIALIZE_HINT_LATELOAD

/turf/open/water/deep_beach/openspace/LateInitialize()
	ADD_TURF_TRANSPARENCY(src, INNATE_TRAIT)

/turf/open/water/deep_beach/openspace/zAirIn()
	return TRUE

/turf/open/water/deep_beach/openspace/zAirOut()
	return TRUE

/turf/open/water/deep_beach/openspace/zPassIn(direction)
	if(direction == DOWN)
		for(var/obj/contained_object in contents)
			if(contained_object.obj_flags & BLOCK_Z_IN_DOWN)
				return FALSE
		return TRUE
	if(direction == UP)
		for(var/obj/contained_object in contents)
			if(contained_object.obj_flags & BLOCK_Z_IN_UP)
				return FALSE
		return TRUE
	return FALSE

/turf/open/water/deep_beach/openspace/zPassOut(direction)
	if(direction == DOWN)
		for(var/obj/contained_object in contents)
			if(contained_object.obj_flags & BLOCK_Z_OUT_DOWN)
				return FALSE
		return TRUE
	if(direction == UP)
		for(var/obj/contained_object in contents)
			if(contained_object.obj_flags & BLOCK_Z_OUT_UP)
				return FALSE
		return TRUE
	return FALSE

/turf/open/water/deep_beach/openspace/replace_floor(turf/open/new_floor_path, flags)
	if (!initial(new_floor_path.overfloor_placed))
		ChangeTurf(new_floor_path, flags = flags)
		return
	// Create plating under tiled floor we try to create directly onto the air
	place_on_top(/turf/open/floor/plating, flags = flags)
	place_on_top(new_floor_path, flags = flags)
