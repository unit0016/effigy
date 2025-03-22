/datum/examine_panel
	/// Mob that the examine panel belongs to
	var/mob/living/holder
	/// The screen containing the appearance of the mob
	var/atom/movable/screen/map_view/examine_panel_screen/examine_panel_screen

/datum/examine_panel/New(mob/holder_mob)
	holder = holder_mob

/datum/examine_panel/Destroy(force)
	SStgui.close_uis(src)
	holder = null
	qdel(examine_panel_screen)
	return ..()

/datum/examine_panel/ui_state(mob/user)
	return GLOB.always_state

/datum/examine_panel/ui_close(mob/user)
	user.client?.clear_map(examine_panel_screen.assigned_map)

/atom/movable/screen/map_view/examine_panel_screen
	name = "examine panel screen"

/datum/examine_panel/ui_interact(mob/user, datum/tgui/ui)
	if(!examine_panel_screen)
		examine_panel_screen = new
		examine_panel_screen.name = "screen"
		examine_panel_screen.assigned_map = "examine_panel_[REF(holder)]_map"
		examine_panel_screen.del_on_map_removal = FALSE
		examine_panel_screen.screen_loc = "[examine_panel_screen.assigned_map]:1,1"

	var/mutable_appearance/current_mob_appearance = new(holder)
	current_mob_appearance.setDir(SOUTH)
	current_mob_appearance.transform = matrix() // We reset their rotation, in case they're lying down.

	// In case they're pixel-shifted, we bring 'em back!
	current_mob_appearance.pixel_x = 0
	current_mob_appearance.pixel_y = 0

	examine_panel_screen.cut_overlays()
	examine_panel_screen.add_overlay(current_mob_appearance)

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		examine_panel_screen.display_to(user)
		user.client.register_map_obj(examine_panel_screen)
		ui = new(user, src, "ExaminePanel")
		ui.open()

/datum/examine_panel/ui_data(mob/user)
	var/list/data = list()

	var/datum/preferences/preferences = holder.client?.prefs

	var/flavour_text
	var/custom_species
	var/custom_species_lore
	var/obscured
	var/name = ""
	var/ooc_notes = ""
	var/headshot = ""

	//  Handle OOC notes first
	if(preferences)
		// Now we handle silicon and/or human, order doesn't really matter
		// If other variants of mob/living need to be handled at some point, put them here
		if(issilicon(holder))
			flavour_text = preferences.read_preference(/datum/preference/text/silicon_flavour_text)
			// Silicon prefs and headshot
			custom_species = preferences.read_preference(/datum/preference/text/custom_species/silicon)
			custom_species_lore = preferences.read_preference(/datum/preference/text/custom_species_lore/silicon)
			ooc_notes += preferences.read_preference(/datum/preference/text/ooc_notes/silicon)
			headshot += preferences.read_preference(/datum/preference/text/headshot/silicon)
			name = holder.name

	if(ishuman(holder))
		var/mob/living/carbon/human/holder_human = holder
		obscured = (holder_human.wear_mask && (holder_human.wear_mask.flags_inv & HIDEFACE)) || \
		(holder_human.head && (holder_human.head.flags_inv & HIDEFACE))

		//Check if the mob is obscured, then continue to headshot and species lore
		ooc_notes += holder_human.dna?.features["ooc_notes"]
		if((obscured || !holder_human.dna) && !isobserver(user))
			custom_species = "Obscured"
			custom_species_lore = "Obscured"
			flavour_text = "Obscured"
			name = "Unknown"
		else
			headshot = holder_human.dna.features["headshot"]
			flavour_text = holder_human.dna.features["flavour_text"]
			name = holder.name
		//Custom species handling. Reports the normal custom species if there is not one set.
			if(holder_human.dna.features["custom_species"] == "")
				custom_species = holder_human.dna.species.name
			else
				custom_species = holder_human.dna.features["custom_species"]
		//Custom species lore handling. Reports the species lore with summary if there is not one set. Does this separately so you can name your subrace without the lore changing.
			if(holder_human.dna.features["custom_species_lore"] == "")
				var/desc = holder_human.dna.species.get_species_description()
				var/list/lore = holder_human.dna.species.get_species_lore()
				custom_species_lore += desc
				custom_species_lore += "\n\n\n"
				custom_species_lore += lore.Join("\n\n")
			else
				custom_species_lore = holder_human.dna.features["custom_species_lore"]

	data["obscured"] = obscured ? TRUE : FALSE
	data["character_name"] = name
	data["assigned_map"] = examine_panel_screen.assigned_map
	data["flavour_text"] = flavour_text
	data["ooc_notes"] = ooc_notes
	data["custom_species"] = custom_species
	data["custom_species_lore"] = custom_species_lore
	data["headshot"] = headshot
	return data
