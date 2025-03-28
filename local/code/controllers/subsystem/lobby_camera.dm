SUBSYSTEM_DEF(lobby_eye)
	name = "Lobby Eye"
	wait = 50
	flags = SS_KEEP_TIMING | SS_TICKER
	runlevels = RUNLEVEL_LOBBY | RUNLEVEL_SETUP
	init_order = INIT_ORDER_MINOR_MAPPING - 1 // Immediately after minor mapping

	/// The subsystem's eye.
	var/mob/eye/linked_eye
	/// How many tiles do we try to move in any direction?
	var/path_target = 30
	/// How many invalid turfs can we cross before we forcefully reset?
	var/invalid_reset = 8
	/// Blacklist of areas we don't want to focus on.
	var/static/list/invalid_areas = list(
		/area/space, \
		/area/lavaland, \
		/area/icemoon, \
		/area/ocean, \
		/area/taeloth, \
		)
	/// Movement delay of our eye.
	var/moving_speed = 4
	/// The HUD element handling fading.
	var/atom/movable/screen/splash/fading_screen
	/// Cached list of the pathway we expect to take this fire().
	var/list/pathway = list()

/datum/controller/subsystem/lobby_eye/Initialize(start_timeofday)
	. =	SS_INIT_SUCCESS
	linked_eye = new()
	linked_eye.set_glide_size(4)
	fading_screen = new()
	fading_screen.color = "000000" // universal lobby compatibility; right here!
	fading_screen.layer = LOBBY_BELOW_MENU_LAYER - 1

/datum/controller/subsystem/lobby_eye/Destroy()
	QDEL_NULL(linked_eye)
	QDEL_NULL(fading_screen)
	pathway = null
	return ..()

/// Pushes our relevant (via prefs) batch of /mob/_new_players to watch the camera.
/datum/controller/subsystem/lobby_eye/proc/lock_eyes()
	for(var/mob/checking_mob as anything in GLOB.new_player_list)
		if(!checking_mob.client || !checking_mob.client?.prefs.read_preference(/datum/preference/toggle/lobby_cam) || SSticker.current_state < GAME_STATE_PREGAME)
			continue
		if(!(fading_screen in checking_mob.client?.screen))
			checking_mob.client?.screen += fading_screen
		if(checking_mob.client?.eye != linked_eye)
			checking_mob.client?.eye = linked_eye

/// Moves everyone back to the proper lobbybox where they belong.
/datum/controller/subsystem/lobby_eye/proc/unlock_eyes()
	for(var/mob/checking_mob in GLOB.new_player_list)
		if(!checking_mob.client)
			continue
		if(fading_screen && (fading_screen in checking_mob.client?.screen))
			checking_mob.client?.screen -= fading_screen
		if(checking_mob.client?.eye != linked_eye)
			continue
		checking_mob.client?.eye = checking_mob.client?.mob
		checking_mob.lighting_cutoff = LIGHTING_CUTOFF_HIGH

/datum/controller/subsystem/lobby_eye/fire(resumed)
	/// Check if we're disabled in config or pregame is over - if we are, don't bother to do anything more, return.
	if(!CONFIG_GET(flag/lobby_camera) || SSticker.current_state != GAME_STATE_PREGAME || GAME_STATE_STARTUP)
		can_fire = FALSE
		return

	/// Check if we're nearing roundstart - if we're locking in for the round, fade out.
	var/time_remaining = SSticker.GetTimeLeft()
	if((time_remaining <= 10 SECONDS && SSticker.current_state == GAME_STATE_PREGAME))
		unlock_eyes()
		return

	//find the starting location
	var/turf/starting_turf = get_safe_random_station_turf()
	pathway = list(starting_turf)

	//start building the pathway
	var/chosen_direction = pick(GLOB.cardinals)
	var/invalid_crossed = 0
	var/turf/chosen_turf = starting_turf
	for(var/creating_pathway in 1 to path_target)
		chosen_turf = get_step(chosen_turf, chosen_direction)
		if(!chosen_turf)
			break
		if(is_type_in_list(get_area(chosen_turf), invalid_areas))
			invalid_crossed++
		if(invalid_crossed >= invalid_reset)
			break
		pathway += chosen_turf

	//move camera to starting location and lock
	linked_eye.loc = starting_turf
	lock_eyes()

	//fade in
	fading_screen.icon_state = "1"
	animate(fading_screen, alpha = 0, time = 1 SECONDS, easing = LINEAR_EASING)
	sleep(1 SECONDS)

	//move
	for(var/turf/moving_turf in pathway)
		linked_eye.loc = moving_turf
		sleep(moving_speed)

	//fade out
	animate(fading_screen, alpha = 255, time = 1 SECONDS, easing = LINEAR_EASING)
	sleep(1 SECONDS)

	fire()
