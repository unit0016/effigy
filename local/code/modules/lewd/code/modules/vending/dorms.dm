/obj/machinery/vending/dorms
	name = "\improper Keepsake Enticements"
	desc = "A vending machine filled with various adult toys and accessories."
	icon_state = "dorms"
	base_icon_state = "dorms_vendor"
	icon = 'local/icons/lewd/obj/machines/vending.dmi'
	light_mask = "dorms-light-mask"
	age_restrictions = TRUE
	product_ads = "Long Night?;Some spice for your intimacy!;Make the memory last."
	vend_reply = "Thank you for choosing Keepsake!"
	panel_type = "dorms-panel"

	/// KEEP THESE ALPHABETICAL
	product_categories = list(
		list(
			"name" = "Fashion",
			"icon" = FA_ICON_SHIRT,
			"products" = list(
				// B
				/obj/item/clothing/shoes/ballet_heels = 3,
				/obj/item/clothing/under/costume/bunnylewd = 3,
				// D
				/obj/item/clothing/head/domina_cap = 4,
				// J
				/obj/item/clothing/under/costume/jabroni = 3,
				// K
				/obj/item/clothing/head/costume/kitty = 4,
				// L
				/obj/item/clothing/shoes/latex_socks = 3,
				/obj/item/clothing/gloves/long_gloves = 4,
				// M
				/obj/item/clothing/accessory/maidapron = 5,
				/obj/item/clothing/gloves/maid = 5,
				/obj/item/clothing/accessory/maidcorset = 5,
				/obj/item/clothing/under/costume/maid = 5,
				/obj/item/clothing/head/costume/maidheadband = 5,
				/obj/item/clothing/neck/maid = 5,
				/obj/item/clothing/under/rank/civilian/janitor/maid = 5,
				// P
				/obj/item/clothing/under/rank/prisoner/customizable = 4,
				/obj/item/clothing/under/rank/prisoner/skirt/customizable = 4,
				// R
				/obj/item/clothing/head/costume/rabbitears = 4,
				// T
				/obj/item/clothing/under/tearaway_garments = 4,
				/obj/item/storage/belt/thigh_satchel = 4,
				/obj/item/clothing/glasses/regular/thin = 1, // i opted not to port the 'nice goggles'; but this is close enough tribute
			),
		),
		list(
			"name" = "Restraints",
			"icon" = FA_ICON_HANDCUFFS,
			"products" = list(
				// B
				/obj/item/clothing/mask/ballgag = 4,
				/obj/item/clothing/gloves/ball_mittens = 4,
				/obj/item/clothing/glasses/blindfold = 2,
				// D
				/obj/item/clothing/head/deprivation_helmet = 3,
				// F
				/obj/item/restraints/handcuffs/fake = 2,
				// G
				/obj/item/clothing/mask/gas/dorms_mask = 4,
				/obj/item/stack/shibari_rope/glow/full = 5,
				// L
				/obj/item/clothing/glasses/blindfold/dorms = 4,
				// M
				/obj/item/clothing/mask/muzzle = 4,
				// P
				/obj/item/clothing/ears/dorms_headphones = 2,
				/obj/item/clothing/gloves/ball_mittens/paw_mittens = 4,
				// S
				/obj/item/clothing/suit/straight_jacket/shackles = 4,
				/obj/item/stack/shibari_rope/full = 5,
			),
		),
		list(
			"name" = "Tools & Fixtures",
			"icon" = FA_ICON_TOOLBOX,
			"products" = list(
				// H
				/obj/item/clothing/glasses/hypno = 4,
				// L
				/obj/item/clothing/erp_leash = 8,
				// S
				/obj/item/construction_kit/pole = 2,
			),
		),
		list(
			"name" = "Collars",
			"icon" = FA_ICON_TOOLBOX,
			"products" = list(
				// Thin
				/obj/item/clothing/neck/collar = 4,
				/obj/item/clothing/neck/collar/bell = 4,
				/obj/item/clothing/neck/collar/cowbell = 4,
				/obj/item/clothing/neck/collar/cross = 4,
				/obj/item/clothing/neck/collar/tagged = 4,
				// Thick
				/obj/item/clothing/neck/collar/thick = 4,
				/obj/item/clothing/neck/collar/thick/bell = 4,
				/obj/item/clothing/neck/collar/thick/cowbell = 4,
				/obj/item/clothing/neck/collar/thick/cross = 4,
				/obj/item/clothing/neck/collar/thick/tagged = 4,
				// Leather
				/obj/item/clothing/neck/collar/leather = 4,
				/obj/item/clothing/neck/collar/leather/bell = 4,
				/obj/item/clothing/neck/collar/leather/cowbell = 4,
				/obj/item/clothing/neck/collar/leather/cross = 4,
				/obj/item/clothing/neck/collar/leather/tagged = 4,
			),
		), // Keep collars last to keep them a little more congruent with premium; if you please.
	)

	premium = list(
		/obj/item/clothing/neck/collar/holocollar = 3,
		/obj/item/clothing/neck/collar/thick/holocollar = 3,
		/obj/item/clothing/neck/collar/leather/holocollar = 3,
		)

	contraband = list(
		/obj/item/restraints/handcuffs = 2,
		/obj/item/clothing/under/rank/civilian/mime/sexy = 1,
		/obj/item/clothing/mask/gas/sexymime = 1,
		/obj/item/clothing/under/rank/civilian/clown/sexy = 1,
		/obj/item/clothing/mask/gas/sexyclown = 1,
		)

	refill_canister = /obj/item/vending_refill/dorms
	payment_department = ACCOUNT_SRV
	default_price = PAYCHECK_CREW * 0.6
	extra_price = PAYCHECK_COMMAND * 2.5

/obj/machinery/vending/dorms/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/disable_lewd_items))
		new /obj/item/kirbyplants/random(get_turf(src))
		return INITIALIZE_HINT_QDEL

//Refill item
/obj/item/vending_refill/dorms
	machine_name = "Keepsake Enticements"
	icon_state = "refill_dorms"
	icon = 'local/icons/obj/vending_restock.dmi'

/obj/item/vending_refill/dorms/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/disable_lewd_items))
		new /obj/item/vending_refill/cola(get_turf(src))
		return INITIALIZE_HINT_QDEL
