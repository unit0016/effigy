/turf/open/floor/plating
	icon = 'local/icons/turf/floors/plating.dmi'
	icon_state = "plating-0"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SMOOTH_GROUP_PLATING
	canSmoothWith = SMOOTH_GROUP_PLATING
	liquid_height = -5 // Very very slight dip

/turf/open/floor/plating/rcd
	icon = 'local/icons/hud/radial.dmi'
	smoothing_flags = NONE
	smoothing_groups = NONE
	canSmoothWith = NONE

/turf/open/floor/plating/elevatorshaft
	icon = EFFIGY_TURFS_ICON_FILE
	smoothing_flags = NONE
	smoothing_groups = NONE
	canSmoothWith = NONE
	liquid_height = 0 // No dip

/turf/open/floor/plating/foam
	icon = 'local/icons/turf/floors/foam_plating.dmi'
	icon_state = "foam_plating-0"
	base_icon_state = "foam_plating"

/turf/open/floor/plating/reinforced // can't smooth because of the way it's deconstruction steps are named. should best be changed upstream tbh
	icon = EFFIGY_TURFS_ICON_FILE
	smoothing_flags = NONE
	smoothing_groups = NONE
	canSmoothWith = NONE
