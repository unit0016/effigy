/obj/item/reagent_containers/pill/liquid_solder
	name = "liquid solder pill"
	desc = "Used to treat synthetic brain damage."
	icon_state = "pill21"
	list_reagents = list(/datum/reagent/medicine/liquid_solder = 30)

// Lower quantity solder pill.
// 50u pills heal 375 brain damage, 10u pills heal 75.
/obj/item/reagent_containers/pill/liquid_solder/braintumor
	list_reagents = list(/datum/reagent/medicine/liquid_solder = 10)

/obj/item/reagent_containers/pill/nanite_slurry
	name = "nanite slurry pill"
	desc = "Used to repair robotic bodyparts."
	icon_state = "pill18"
	list_reagents = list(/datum/reagent/medicine/nanite_slurry = 19)

/obj/item/reagent_containers/pill/system_cleaner
	name = "system cleaner pill"
	desc = "Used to detoxify synthetic bodies."
	icon_state = "pill7"
	list_reagents = list(/datum/reagent/medicine/system_cleaner = 30)
