// Nakati
/obj/item/seeds/nakati
	name = "pack of nakati starters"
	desc = "This bacterial colony forms into bioluminescent nakati growths."
	icon = 'local/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-nakati"
	species = "nakati"
	plantname = "Nakati Colony"
	product = /obj/item/food/grown/nakati
	growing_icon = 'local/icons/obj/hydroponics/growing.dmi'
	icon_grow = "nakati-grow"
	icon_dead = "nakati-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	lifespan = 60
	endurance = 50
	growthstages = 4
	reagents_add = list(/datum/reagent/consumable/nakati_spice = 0.25)

/obj/item/food/grown/nakati
	seed = /obj/item/seeds/nakati
	name = "nakati bark"
	desc = "A segment of fragrant brown 'bark' from a nakati growth, grinds into a zesty spice widely used in teshari cooking."
	icon = 'local/icons/obj/hydroponics/harvest.dmi'
	icon_state = "nakati"
	foodtypes = VEGETABLES
	grind_results = list(/datum/reagent/consumable/nakati_spice = 0)
	tastes = list("overwhelming spicyness" = 1)
