/***********************************
RJW Weapons N Ammo
***********************************/

/obj/item/ammo_casing/a145
	name = "shell casing"
	desc = "A 14.5mm shell."
	icon_state = "lcasing"
	spent_icon = "lcasing-spent"
	caliber = "14.5mm"
	projectile_type = /obj/item/projectile/bullet/rifle/a145
	matter = list(DEFAULT_WALL_MATERIAL = 1250)

/obj/item/ammo_magazine/arisakabox
	name = "arisaka ammo"
	icon_state = "mosin_ammo"
//	origin_tech = "combat=2"
	mag_type = MAGAZINE
	caliber = "6.50x50mm"
	w_class = 2
	matter = list(DEFAULT_WALL_MATERIAL = 4500)
	ammo_type = /obj/item/ammo_casing/a145
	max_ammo = 50
	multiple_sprites = TRUE
	is_box = TRUE

/obj/item/ammo_casing/a762x54
	desc = "A 7.62x54mm bullet casing."
	caliber = "a762x54"
	icon_state = "kclipe-bullet"
	spent_icon = "kclipe-casing"
	weight = 0.012
	projectile_type = /obj/item/projectile/bullet/rifle/a762x54

/obj/item/ammo_casing/a650x50
	desc = "A 6.50x50mm bullet casing."
	icon_state = "kclip-bullet"
	spent_icon = "kclip-casing"
	caliber = "a650x50"
	weight = 0.0127
	projectile_type = /obj/item/projectile/bullet/rifle/a650x50

/obj/item/ammo_casing/a762x38
	desc = "A 7.62x38mmR bullet casing."
	caliber = "a762x38"
	weight = 0.0056
	projectile_type = /obj/item/projectile/bullet/rifle/a762x38

/obj/item/ammo_casing/c9mm_jap_revolver
	desc = "A 9mm revolver bullet casing."
	icon_state = "pistol_bullet_anykind"
	spent_icon = "pistol_bullet_casing"
	caliber = "c9mm_jap_revolver"
	weight = 0.0095
	projectile_type = /obj/item/projectile/bullet/rifle/c9mm_jap_revolver


/*
/obj/item/ammo_casing/svt
	desc = "A SVT bullet casing."
	caliber = "a792x33"
	projectile_type = /obj/item/projectile/bullet/rifle/a792x33
*/
/************************
		OTHER
************************/

/obj/item/ammo_casing/a650x50
	name = "a 6.50x50 bullet casing"
	projectile_type = /obj/item/projectile/bullet/rifle/a650x50
	weight = 0.0136
	caliber = "a650x50"

/obj/item/ammo_casing/a762x54
	name = "a 7.62x54 bullet casing"
	projectile_type = /obj/item/projectile/bullet/rifle/a762x51
	caliber = "a762x54"

/obj/item/ammo_casing/grenade
	name = "grenade"
	desc = "I hate descriptions."
	caliber = "grenade"

/obj/item/ammo_casing/grenade/he
	name = "he grenade"
	icon_state = "he_grenade"
	projectile_type = /obj/item/projectile/grenade/he
	caliber = "grenade"

/obj/item/ammo_casing/grenade/smoke
	name = "smoke grenade"
	icon_state = "smoke_grenade"
	projectile_type = /obj/item/projectile/grenade/smoke
	caliber = "grenade"