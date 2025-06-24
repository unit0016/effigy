/obj/item/organ/frills
	name = "frills"

/datum/bodypart_overlay/mutant/frills
	layers = EXTERNAL_ADJACENT | EXTERNAL_ADJACENT_2 | EXTERNAL_ADJACENT_3

/datum/bodypart_overlay/mutant/frills/color_image(image/overlay, draw_layer, obj/item/bodypart/limb)
	if(limb == null)
		return ..()
	if(limb.owner == null)
		return ..()
	if(draw_layer == bitflag_to_layer(EXTERNAL_ADJACENT))
		overlay.color = limb.owner.dna.features["frills_color_1"]
		return overlay
	else if(draw_layer == bitflag_to_layer(EXTERNAL_ADJACENT_2))
		overlay.color = limb.owner.dna.features["frills_color_2"]
		return overlay
	else if(draw_layer == bitflag_to_layer(EXTERNAL_ADJACENT_3))
		overlay.color = limb.owner.dna.features["frills_color_3"]
		return overlay
	return ..()

/// Frills toggle
/datum/preference/toggle/frills
	savefile_key = "frills_toggle"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	priority = PREFERENCE_PRIORITY_DEFAULT

/datum/preference/toggle/frills/apply_to_human(mob/living/carbon/human/target, value)
	if(value == FALSE)
		target.dna.features["frills"] = /datum/sprite_accessory/frills/none::name

/datum/preference/toggle/frills/create_default_value()
	return FALSE

/datum/preference/toggle/frills/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[FRILLS]))
		return FALSE

	return TRUE

/// Frills type
/datum/preference/choiced/lizard_frills
	category = PREFERENCE_CATEGORY_CLOTHING

/datum/preference/choiced/lizard_frills/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/frills_color::savefile_key
	return data

/datum/preference/choiced/lizard_frills/create_default_value()
	return /datum/sprite_accessory/frills/none::name

/datum/preference/choiced/lizard_frills/icon_for(value)
	return generate_side_icon(SSaccessories.frills_list[value], "frills")

/datum/preference/choiced/lizard_frills/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[FRILLS]))
		return FALSE

	var/has_frills = preferences.read_preference(/datum/preference/toggle/frills)
	if(has_frills == TRUE)
		return TRUE

	return FALSE

/// Frill colors
/datum/preference/tri_color/frills_color
	priority = PREFERENCE_PRIORITY_BODY_TYPE
	savefile_key = "frills_color"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES

/datum/preference/tri_color/frills_color/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["frills_color_1"] = value[1]
	target.dna.features["frills_color_2"] = value[2]
	target.dna.features["frills_color_3"] = value[3]

/datum/preference/tri_color/frills_color/create_default_value()
	return list(sanitize_hexcolor("[pick("7F", "FF")][pick("7F", "FF")][pick("7F", "FF")]"),
	sanitize_hexcolor("[pick("7F", "FF")][pick("7F", "FF")][pick("7F", "FF")]"),
	sanitize_hexcolor("[pick("7F", "FF")][pick("7F", "FF")][pick("7F", "FF")]"))

/datum/preference/tri_color/frills_color/is_valid(value)
	if (!..(value))
		return FALSE
	return TRUE

/datum/species/regenerate_organs(mob/living/carbon/target, datum/species/old_species, replace_current = TRUE, list/excluded_zones, visual_only = FALSE)
	. = ..()
	if(target.dna.features["frills"] && (type in GLOB.bodypart_allowed_species[FRILLS]))
		if(target.dna.features["frills"] != /datum/sprite_accessory/frills/none::name && target.dna.features["frills"] != /datum/sprite_accessory/blank::name)
			var/obj/item/organ/replacement = SSwardrobe.provide_type(/obj/item/organ/frills)
			replacement.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
			return .
	var/obj/item/organ/old_part = target.get_organ_slot(ORGAN_SLOT_EXTERNAL_FRILLS)
	if(old_part)
		old_part.Remove(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		old_part.moveToNullspace()
