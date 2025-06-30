#define SWIM_TRAIT_ELEMENT_ID "swimming" // Actually used outside of this file; might be best to move it to defines

/datum/element/swimmable_turf
	element_flags = ELEMENT_DETACH_ON_HOST_DESTROY

/datum/element/swimmable_turf/Attach(datum/target)
	. = ..()
	if(!isopenturf(target))
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(target, COMSIG_ATOM_ENTERED, PROC_REF(enter_swimmable_turf))

/datum/element/swimmable_turf/Detach(datum/source, ...)
	. = ..()
	UnregisterSignal(source, COMSIG_ATOM_ENTERED)

/datum/element/swimmable_turf/proc/enter_swimmable_turf(datum/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	SIGNAL_HANDLER

	if(!isopenturf(source))
		qdel(src)
		return
	var/turf/open/our_turf = source

	if (!istype(arrived, /mob/living))
		return
	var/mob/living/living_mob = arrived
	if (our_turf.liquids?.liquid_state < LIQUID_STATE_SHOULDERS && !istype(our_turf, /turf/open/water/deep_beach/openspace))
		if (HAS_TRAIT(living_mob, TRAIT_MOVE_SWIMMING))
			REMOVE_TRAIT(living_mob, TRAIT_MOVE_SWIMMING, SWIM_TRAIT_ELEMENT_ID)
			living_mob.visible_message(
				span_notice("[living_mob] stops swimming."),
				span_notice("You stop swimming.")
			)
		return
	var/turf/turf_below = GET_TURF_BELOW(our_turf)
	living_mob.update_buoyancy()
	// Not deep enough to swim
	if (our_turf.liquids?.liquid_state < LIQUID_STATE_WAIST && !istype(our_turf, /turf/open/water/deep_beach/openspace))
		return
	// Handle flight interruption
	if (HAS_TRAIT(living_mob, TRAIT_MOVE_FLYING) && our_turf.liquids?.liquid_state >= LIQUID_STATE_FULLTILE)
		if (istype(living_mob, /mob/living/carbon))
			var/mob/living/carbon/carbon_mob = living_mob
			if ((carbon_mob.movement_type & FLYING) && !carbon_mob.buckled)
				var/obj/item/organ/wings/functional/our_wings = carbon_mob.get_organ_slot(ORGAN_SLOT_EXTERNAL_WINGS)
				if (our_wings)
					our_wings.toggle_flight(carbon_mob)
					our_wings.fly_slip(carbon_mob)
				else
					return

	// Begin swimming
	if (!HAS_TRAIT(living_mob, TRAIT_MOVE_SWIMMING))
		ADD_TRAIT(living_mob, TRAIT_MOVE_SWIMMING, SWIM_TRAIT_ELEMENT_ID)
		living_mob.visible_message(
			span_notice("[living_mob] starts to swim."),
			span_notice("You start to swim.")
		)

	// One final check to catch out anything that hasn't yet been
	if (ismovable(arrived))
		arrived.do_sink_or_float()

