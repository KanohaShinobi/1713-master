/***********************************
RUSSO-JAPANESE WAR WEAPONS MAGS N AMMO
***********************************/

/obj/item/ammo_magazine/mosin
	name = "Clip (7.62x54mm)"
	icon_state = "clip"
	caliber = "a762x54"
	matter = list(DEFAULT_WALL_MATERIAL = 360)
	ammo_type = /obj/item/ammo_casing/a762x54
	max_ammo = 5
	weight = 0.04
	multiple_sprites = TRUE

/obj/item/ammo_magazine/mosinbox
	name = "magazine box (7.62x54mm)"
	icon_state = "mosin_ammo"
//	origin_tech = "combat=2"
	mag_type = MAGAZINE
	caliber = "a762x54"
	w_class = 3
	matter = list(DEFAULT_WALL_MATERIAL = 4500)
	ammo_type = /obj/item/ammo_casing/a762x54
	max_ammo = 50
	multiple_sprites = TRUE
	is_box = TRUE

/obj/item/ammo_magazine/a65x50
	name = "Clip (6.5x50mm)"
	icon_state = "kclip"
	caliber = "a60x50"
	matter = list(DEFAULT_WALL_MATERIAL = 360)
	ammo_type = /obj/item/ammo_casing/a65x50
	max_ammo = 5
	weight = 0.038
	multiple_sprites = TRUE

/obj/item/ammo_magazine/arisakabox
	name = "magazine box (6.5x50mm)"
	icon_state = "mosin_ammo"
//	origin_tech = "combat=2"
	mag_type = MAGAZINE
	caliber = "a65x50"
	w_class = 3
	matter = list(DEFAULT_WALL_MATERIAL = 4500)
	ammo_type = /obj/item/ammo_casing/a65x50
	max_ammo = 50
	multiple_sprites = TRUE
	is_box = TRUE


/obj/item/ammo_magazine/maxim
	name = "Maxim ammo belt"
	icon_state = "maximbelt"
//	origin_tech = "combat=2"
	mag_type = MAGAZINE
	caliber = "a762x54"
	w_class = 4
	matter = list(DEFAULT_WALL_MATERIAL = 4500)
	ammo_type = /obj/item/ammo_casing/a127x108
	max_ammo = 250
	multiple_sprites = TRUE
	var/slot = "decor"
	var/obj/item/clothing/under/has_suit = null		//the suit the tie may be attached to
	var/image/inv_overlay = null	//overlay used when attached to clothing.
	var/image/mob_overlay = null
	var/overlay_state = null

/obj/item/ammo_magazine/maxim/proc/get_inv_overlay()
	if (!inv_overlay)
		if (!mob_overlay)
			get_mob_overlay()

		var/tmp_icon_state = "[overlay_state? "[overlay_state]" : "[icon_state]"]"
		if (icon_override)
			if ("[tmp_icon_state]_tie" in icon_states(icon_override))
				tmp_icon_state = "[tmp_icon_state]_tie"
		inv_overlay = image(icon = mob_overlay.icon, icon_state = tmp_icon_state, dir = SOUTH)
	return inv_overlay

/obj/item/ammo_magazine/maxim/proc/get_mob_overlay()
	if (!mob_overlay)
		var/tmp_icon_state = "[overlay_state? "[overlay_state]" : "[icon_state]"]"
		if (icon_override)
			if ("[tmp_icon_state]_mob" in icon_states(icon_override))
				tmp_icon_state = "[tmp_icon_state]_mob"
			mob_overlay = image("icon" = icon_override, "icon_state" = "[tmp_icon_state]")
		else
			mob_overlay = image("icon" = INV_ACCESSORIES_DEF_ICON, "icon_state" = "[tmp_icon_state]")
	return mob_overlay

//when user attached an accessory to S
/obj/item/ammo_magazine/maxim/proc/on_attached(obj/item/clothing/under/S, mob/user as mob)
	if (!istype(S))
		return
	has_suit = S
	loc = has_suit
	has_suit.overlays += get_inv_overlay()

	user << "<span class='notice'>You attach [src] to [has_suit].</span>"
	add_fingerprint(user)

/obj/item/ammo_magazine/maxim/proc/on_removed(mob/user as mob)
	if (!has_suit)
		return
	has_suit.overlays -= get_inv_overlay()
	has_suit = null
	usr.put_in_hands(src)
	add_fingerprint(user)

/obj/item/ammo_magazine/maxim/type92_belt
	name = "Type 92 Ammo Belt"
	caliber = "a77x58"
	ammo_type = /obj/item/ammo_casing/a77x58_weaker

/obj/item/ammo_magazine/c8mmnambu
	name = "Nambu magazine"
	icon_state = "lugermag"
//	origin_tech = "combat=2"
	mag_type = MAGAZINE
	matter = list(DEFAULT_WALL_MATERIAL = 600)
	caliber = "c8mmnambu"
	ammo_type = /obj/item/ammo_casing/c8mmnambu
	max_ammo = 8
	weight = 0.0143
	multiple_sprites = TRUE

//obj/item/ammo_magazine/c9x19mm_stenmk3
	//name = "magazine (9x19mm)"
	//icon_state = "stenmag"
	//mag_type = MAGAZINE
	//ammo_type = /obj/item/ammo_casing/c9x19mm_stenmk3
	//caliber = "9x19mm"
	//max_ammo = 32
	//multiple_sprites = TRUE

////////// NAGANT REVOLVER ///////////////
/obj/item/ammo_magazine/c762x38mmR
	name = "pouch of bullets (7.62x38mmR)"
	icon_state = "7.62x38mmRPouch"
	ammo_type = /obj/item/ammo_casing/c762x38mmR
	caliber = "7.62x38mmR"
	max_ammo = 21
	weight = 0.4
	multiple_sprites = TRUE

