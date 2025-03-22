/// Zonal markings
/datum/preference/choiced/markings
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_MARKINGS
	abstract_type = /datum/preference/choiced/markings
	relevant_external_organ = null
	var/body_zone
	var/markingval

/datum/preference/choiced/markings/init_possible_values()
	var/datum/bodypart_overlay/simple/body_marking/body_markings/markings = new /datum/bodypart_overlay/simple/body_marking/body_markings()
	var/list/returnval = list()
	var/list/allmarkings = assoc_to_keys_features(SSaccessories.body_markings)
	returnval += "None"
	for(var/i in allmarkings)
		var/datum/sprite_accessory/body_marking/accessory = markings.get_accessory(i)
		if(accessory.body_zones & body_zone)
			returnval += i
	return sort_list(returnval)

/datum/preference/choiced/markings/create_default_value()
	return SPRITE_ACCESSORY_NONE

/datum/preference/choiced/markings/apply_to_human(mob/living/carbon/human/target, value)

	if(value == SPRITE_ACCESSORY_NONE)
		return

	if(!target.dna.features["markings_list"])
		var/list/markings_listt = list()
		LAZYSETLEN(markings_listt, MARKING_LIST_LEN)
		target.dna.features["markings_list"] = markings_listt

	if(!target.dna.features["markings_list_zones"])
		var/list/markings_listt = list()
		LAZYSETLEN(markings_listt, MARKING_LIST_LEN)
		target.dna.features["markings_list_zones"] = markings_listt

	target.dna.features["markings_list"][markingval] = value
	target.dna.features["markings_list_zones"][markingval] = body_zone

/// Zonal marking colors
/datum/preference/color/markings
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_MARKINGS
	relevant_head_flag = null
	abstract_type = /datum/preference/color/markings
	var/markingval

/datum/preference/color/markings/apply_to_human(mob/living/carbon/human/target, value)
	if(!target.dna.features["markings_list_colors"])
		var/list/markings_listt = list()
		LAZYSETLEN(markings_listt, MARKING_LIST_LEN)
		target.dna.features["markings_list_colors"] = markings_listt

	target.dna.features["markings_list_colors"][markingval] = value

/datum/species/proc/add_zonal_markings(mob/living/carbon/human/target, value, colorvalue, bodypart)
	var/handlayer = FALSE
	bodypart = marking_zones(bodypart)
	if(bodypart == BODY_ZONE_PRECISE_L_HAND)
		handlayer = EXTERNAL_HAND
		bodypart = BODY_ZONE_L_ARM
	else if(bodypart == BODY_ZONE_PRECISE_R_HAND)
		handlayer = EXTERNAL_HAND
		bodypart = BODY_ZONE_R_ARM
	var/obj/item/bodypart/people_part =  target.get_bodypart(bodypart)
	if(people_part)
		var/datum/bodypart_overlay/simple/body_marking/body_markings/overlay = new /datum/bodypart_overlay/simple/body_marking/body_markings()
		var/datum/sprite_accessory/accessory = overlay.get_accessory(value)

		if(isnull(accessory))
			CRASH("Value: [value] did not have a corresponding sprite accessory!")

		overlay.icon = accessory.icon
		overlay.icon_state = accessory.icon_state
		if(handlayer)
			overlay.ishand = TRUE
			overlay.layers = handlayer
		if(bodypart == BODY_ZONE_HEAD)
			overlay.use_gender = FALSE
		else
			overlay.use_gender = accessory.gender_specific

		overlay.draw_color = colorvalue || accessory.color_src
		people_part.add_bodypart_overlay(overlay)

/datum/species/add_body_markings(mob/living/carbon/human/target)
	. = ..()

	if(target.dna.features["markings_list"])
		if(islist(target.dna.features["markings_list"]) && islist(target.dna.features["markings_list_colors"]) && islist(target.dna.features["markings_list_zones"]))
			var/list/markingslist = target.dna.features["markings_list"]
			for(var/i in 1 to markingslist.len)
				if(markingslist[i] && markingslist[i] != SPRITE_ACCESSORY_NONE)
					add_zonal_markings(target, target.dna.features["markings_list"][i], target.dna.features["markings_list_colors"][i], target.dna.features["markings_list_zones"][i])

/datum/bodypart_overlay/simple/body_marking/body_markings
	blocks_emissive = EMISSIVE_BLOCK_NONE
	var/ishand = FALSE

/datum/bodypart_overlay/simple/body_marking/body_markings/get_accessory(name)
	return SSaccessories.body_markings[name]

/datum/bodypart_overlay/simple/body_marking/body_markings/get_image(layer, obj/item/bodypart/limb)
	var/gender_string = ""
	if(use_gender && !(limb.body_zone in GLOB.limb_zones))
		gender_string = (limb.is_dimorphic) ? (limb.limb_gender == "m" ? MALE + "_" : FEMALE + "_") : "male_" // defaults to male so that andros dont get tiddies
	var/zonestring = limb.body_zone
	if(limb.bodyshape & BODYSHAPE_DIGITIGRADE)
		zonestring = "digitigrade_1_" + limb.body_zone
	if(ishand)
		zonestring = limb.aux_zone
	return image(icon, gender_string + icon_state + "_" + zonestring, layer = layer)

/datum/preference/color/markings/markings_r_leg3/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_r_leg2) != SPRITE_ACCESSORY_NONE

#undef MARKING_LIST_LEN

/// cover_flags2body_zones is funky with hand bitflags for some reason. this is more efficient for what we want to do anyway
/datum/species/proc/marking_zones(zone)
	if(!zone)
		return
	switch(zone)
		if(HEAD)
			return BODY_ZONE_HEAD
		if(CHEST)
			return BODY_ZONE_CHEST
		if(ARM_LEFT)
			return BODY_ZONE_L_ARM
		if(ARM_RIGHT)
			return BODY_ZONE_R_ARM
		if(HAND_LEFT)
			return BODY_ZONE_PRECISE_L_HAND
		if(HAND_RIGHT)
			return BODY_ZONE_PRECISE_R_HAND
		if(LEG_LEFT)
			return BODY_ZONE_L_LEG
		if(LEG_RIGHT)
			return BODY_ZONE_R_LEG
