/datum/weather/rain_storm
	name = "rain storm"
	desc = "Thick bouts of rain trickle in from the trees above, coating the outside jungle."
	probability = 90
	telegraph_message = span_boldnotice("The atmosphere shifts as clouds converge...")
	telegraph_overlay = "light_rain"
	weather_message = span_boldnotice("Rain pours in from the breaks in the trees above!")
	weather_overlay = "rain_storm"
	weather_duration_lower = 1 MINUTES
	weather_duration_upper = 3 MINUTES
	end_duration = 10 SECONDS
	end_message = span_notice("The raindrops slow, before falling still.")
	area_type = /area
	target_trait = ZTRAIT_RAINSTORM
	use_glow = FALSE
	weather_overlay_icon = 'local/icons/effects/weather_effects.dmi'

	protected_areas = list(
		/area/taeloth/underground, \
		/area/taeloth/nearstation/bridge_roof/patio/under, \
		/area/taeloth/nearstation/bridge_crossway/deck, \
		)

/datum/weather/rain_storm/weather_act_mob(mob/living/living)
	. = ..()
	living.extinguish_mob()
	living.adjust_wet_stacks(2) // Gets out a lil faster than being in a lake or something.

/* EffigyEdit TODO: Ruby
/datum/weather/rain_storm/can_get_alert(mob/player)
	if(!..())
		return FALSE

	if(!is_station_level(player.z))
		return TRUE  // bypass checks

	if(isobserver(player))
		return TRUE

	if(HAS_MIND_TRAIT(player, TRAIT_DETECT_STORM))
		return TRUE

	if(istype(get_area(player), /area/taeloth))
		return TRUE

	for(var/area/rain_area in impacted_areas) // This is the most expensive so ideally it's a last resort.
		if(locate(rain_area) in view(player))
			return TRUE

	return FALSE
*/ // EffigyEdit TODO End

// This sucks HARDER but not as any fault of it's own.
/datum/weather/rain_storm/forever_storm
	telegraph_duration = 0
	weather_flags = parent_type::weather_flags | WEATHER_ENDLESS
	probability = 0
