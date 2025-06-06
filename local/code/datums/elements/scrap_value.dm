/datum/element/scrap_value
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH_ON_HOST_DESTROY
	argument_hash_start_idx = 2
	/// What's our worth to the funny scrap compactor?
	var/our_value = 0

/datum/element/scrap_value/Attach(datum/target, set_value)
	. = ..()
	if(!isatom(target) || isarea(target) || set_value < 1)
		return ELEMENT_INCOMPATIBLE
	our_value = set_value()
	RegisterSignal(target, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/element/scrap_value/Detach(datum/target)
	UnregisterSignal(target, COMSIG_ATOM_EXAMINE)
	return ..()

/datum/element/scrap_value/proc/on_examine(atom/source, mob/user, list/examine_texts)
	SIGNAL_HANDLER
	if(!DOING_INTERACTION_WITH_TARGET(user, source))
		INVOKE_ASYNC(src, PROC_REF(appraise), source, user) //Do not sleep the proc.

/datum/element/scrap_value/proc/appraise(atom/source, mob/user)
	if(HAS_TRAIT(user, TRAIT_RESEARCH_SCANNER) || isdead(user))
		to_chat(user, "It's worth [our_value] credits.")
