/datum/preference/choiced/scream
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "character_scream"

/datum/preference/choiced/scream/init_possible_values()
	return assoc_to_keys(GLOB.scream_types)

/datum/preference/choiced/scream/create_default_value()
	return /datum/scream_type/none::name

/datum/preference/choiced/scream/apply_to_human(mob/living/carbon/human/target, value)
	var/scream_instance = GLOB.scream_types[value]
	if(!scream_instance)
		return
	target.selected_scream = scream_instance
