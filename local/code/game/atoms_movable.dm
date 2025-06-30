/atom/movable/proc/do_sink_or_float(buoyancy)
	var/turf/open/swimmer_turf = src.loc
	if(!swimmer_turf)
		return
	if(!has_gravity(swimmer_turf))
		return
	var/turf/turf_below = GET_TURF_BELOW(swimmer_turf)
	if (buoyancy < 0 && (isopenspaceturf(swimmer_turf) || istype(swimmer_turf, /turf/open/water/deep_beach/openspace)) && isopenturf(turf_below))
		src.visible_message(
			span_danger("[src] sinks like a stone!"),
			span_userdanger("You feel yourself pulled to the bottom!")
		)
		if (HAS_TRAIT(src, TRAIT_MOVE_SWIMMING))
			REMOVE_TRAIT(src, TRAIT_MOVE_SWIMMING, SWIM_TRAIT_ELEMENT_ID)
		return

	var/turf/turf_above = GET_TURF_ABOVE(swimmer_turf)
	if (buoyancy > 0 && (isopenspaceturf(turf_above) && turf_above.liquids) || istype(turf_above, /turf/open/water/deep_beach/openspace))
		src.visible_message(
			span_danger("[src] shoots up toward the surface!"),
			span_userdanger("You feel yourself pulled upward!")
		)
		src.forceMove(turf_above)
