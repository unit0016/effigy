/obj/structure/table/wood
	icon = 'local/icons/obj/smooth_structures/wood_table.dmi'

/obj/structure/table/reinforced/Initialize()
	. = ..()
	AddElement(/datum/element/liquids_height, 20)
