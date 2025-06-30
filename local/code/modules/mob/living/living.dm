/mob/living/set_pull_offsets(mob/living/pull_target, grab_state, animate = TRUE)
	. = ..()
	SEND_SIGNAL(pull_target, COMSIG_LIVING_SET_PULL_OFFSET)

/mob/living/reset_pull_offsets(mob/living/pull_target, override)
	. = ..()
	SEND_SIGNAL(pull_target, COMSIG_LIVING_RESET_PULL_OFFSETS)

/mob/living/proc/update_buoyancy()
	var/buoyancy = 0
	for (var/obj/item/carried_item in contents)
		/// This is admittedly really silly but my logic is small things make float good big things make float bad. Science man agree; I think
		if (carried_item.w_class <= WEIGHT_CLASS_SMALL)
			buoyancy += 1
		else if (carried_item.w_class  > WEIGHT_CLASS_SMALL)
			buoyancy -= 1
	do_sink_or_float(buoyancy)
