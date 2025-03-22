/datum/preferences
	/// Preference of how the preview should show the character.
	var/preview_style = PREVIEW_STYLE_JOB

// Updates the mob's chat color in the global cache
/datum/preferences/safe_transfer_prefs_to(mob/living/carbon/human/character, icon_updates = TRUE, is_antag = FALSE)
	. = ..()
	GLOB.chat_colors_by_mob_name[character.name] = list(character.chat_color, character.chat_color_darkened) // by now the mob has had its prefs applied to it
