/datum/config_entry/string/discordlink
	default = "https://tgstation13.org/phpBB/viewforum.php?f=60"

/// manifest preview in pre-lobby
/datum/config_entry/flag/show_manifest_preview
	default = TRUE

/datum/config_entry/flag/setup_bypass_player_check

/// File where fluff status messages are stored
/datum/config_entry/string/fluff_status_file
	default = "config/effigy_splash_fluff.txt"

/// Use the new lobby track scheduler, disable to use old lobby music system
/datum/config_entry/flag/use_scheduled_lobby_track
	default = TRUE

/// Lobby music track ID
/datum/config_entry/string/pregame_lobby_track

/// Lobby music track duration
/datum/config_entry/number/pregame_lobby_duration
	default = -1

/datum/config_entry/number/jungle_budget
	default = 2
	integer = FALSE
	min_val = 0

// Please note the intended jungle caves budget will be ~8 depending on how many ruins there are - this is to avoid issues atm.
/datum/config_entry/number/jungle_cave_budget
	default = 2
	integer = FALSE
	min_val = 0

/datum/config_entry/number/ocean_budget
	default = 6
	integer = FALSE
	min_val = 0

// Please note the intended jungle caves budget will be ~8 depending on how many ruins there are - this is to avoid issues atm.
/datum/config_entry/number/trench_budget
	default = 6
	integer = FALSE
	min_val = 0
