/obj/structure/anvil
	name = "anvil"
	desc = "A heavy iron anvil. The blacksmith's main work tool. It has 0 hot iron bars on it."
	icon = 'icons/obj/structures.dmi'
	icon_state = "anvil1"
	density = TRUE
	anchored = TRUE
	var/iron_amt = 0
	var/steel_amt = 0

obj/structure/anvil/New()
	..()
	desc = "A heavy iron anvil. The blacksmith's main work tool. It has [iron_amt] hot iron bars on it."

/obj/structure/anvil/attackby(obj/item/P as obj, mob/user as mob)
	var/mob/living/carbon/human/H = user
	if (H.getStatCoeff("crafting") < 1.7 && map.civilizations)
		user << "You don't have the skills to use this."
		return
	if (!map.civilizations && (user.original_job_title != "Blacksmith" && user.original_job_title != "Ferreiro" && user.original_job_title != "Ferrero" && user.original_job_title != "Grofsmid" && user.original_job_title != "Forgeron" && user.original_job_title != "British Blacksmith" && user.original_job_title != "Marooned Pirate Crew"))
		user << "You don't have the skills to use this. Ask a blacksmith."
		return
	else
		if (istype(P, /obj/item/stack/material/iron) && steel_amt == 0)
			user << "You begin smithing the iron..."
			icon_state = "anvil2"
			playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
			if (do_after(user,30*P.amount,src))
				user << "<span class='notice'>You smite the iron.</span>"
				iron_amt += P.amount
				desc = "A heavy iron anvil. The blacksmith's main work tool. It has [iron_amt] hot iron bars on it."
				icon_state = "anvil3"
				qdel(P)
		else if (istype(P, /obj/item/stack/material/iron) && steel_amt > 0)
			user << "<span class='notice'>You can't smelt iron while there is steel on the anvil! Finish the steel first.</span>"
			return
		else if (istype(P, /obj/item/stack/material/steel) && iron_amt == 0 && map.ordinal_age >= 2)
			user << "You begin smithing the steel..."
			icon_state = "anvil2"
			playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
			if (do_after(user,35*P.amount,src))
				user << "<span class='notice'>You smite the steel.</span>"
				steel_amt += P.amount
				desc = "A heavy iron anvil. The blacksmith's main work tool. It has [steel_amt] hot steel bars on it."
				icon_state = "anvil3"
				qdel(P)
		else if (istype(P, /obj/item/stack/material/steel) && iron_amt > 0)
			user << "<span class='notice'>You can't smelt steel while there is iron on the anvil! Finish the iron first.</span>"
			return

/obj/structure/anvil/attack_hand(var/mob/user as mob)
	var/mob/living/carbon/human/H = user
	if (H.getStatCoeff("crafting") < 1.7 && map.civilizations)
		user << "You don't have the skills to use this."
		return
	if (!map.civilizations && (user.original_job_title != "Blacksmith" && user.original_job_title != "Ferreiro" && user.original_job_title != "Ferrero" && user.original_job_title != "Grofsmid" && user.original_job_title != "Forgeron" && user.original_job_title != "British Blacksmith" && user.original_job_title != "Marooned Pirate Crew"))
		user << "You don't have the skills to use this. Ask a blacksmith."
		return

	else if (steel_amt > 0)
		var/list/display2 = list("Cancel")
		if (map.ordinal_age >= 3)
			display2 = list("Small Sword (10)", "Sabre (15)", "Cutlass (12)", "Spadroon (15)", "Rapier (18)", "Longsword (18)", "Cancel")
		else if (map.ordinal_age <= 2)
			display2 = list("Small Sword (10)", "Spadroon (15)", "Cancel")

		var/choice2 = WWinput(user, "What do you want to make?", "Blacksmith - [steel_amt] steel", "Cancel", display2)
		if (choice2 == "Cancel")
			return
		if (choice2 == "Small Sword (10)")
			if (steel_amt >= 10)
				user << "You begin crafting a small sword..."
				playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
				if (do_after(user,90,src) && steel_amt >= 10)
					user << "You craft a small sword."
					steel_amt -= 10
					if (steel_amt <= 0)
						icon_state = "anvil1"
					new/obj/item/weapon/material/sword/smallsword(user.loc)
					return
			else
				user << "<span class='notice'>You need more steel to make this!</span>"
				return
		if (choice2 == "Sabre (15)")
			if (steel_amt >= 15)
				user << "You begin crafting a sabre..."
				playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
				if (do_after(user,120,src) && steel_amt >= 15)
					user << "You craft a sabre."
					steel_amt -= 15
					if (steel_amt <= 0)
						icon_state = "anvil1"
					new/obj/item/weapon/material/sword/sabre(user.loc)
					return
			else
				user << "<span class='notice'>You need more steel to make this!</span>"
				return
		if (choice2 == "Cutlass (12)")
			if (steel_amt >= 12)
				user << "You begin crafting a cutlass..."
				playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
				if (do_after(user,100,src) && steel_amt >= 12)
					user << "You craft a cutlass."
					steel_amt -= 12
					if (steel_amt <= 0)
						icon_state = "anvil1"
					new/obj/item/weapon/material/sword/cutlass(user.loc)
					return
			else
				user << "<span class='notice'>You need more steel to make this!</span>"
				return
		if (choice2 == "Rapier (18)")
			if (steel_amt >= 18)
				user << "You begin crafting a rapier..."
				playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
				if (do_after(user,150,src) && steel_amt >= 18)
					user << "You craft a rapier."
					steel_amt -= 18
					if (steel_amt <= 0)
						icon_state = "anvil1"
					new/obj/item/weapon/material/sword/rapier(user.loc)
					return
			else
				user << "<span class='notice'>You need more steel to make this!</span>"
				return
		if (choice2 == "Spadroon (15)")
			if (steel_amt >= 15)
				user << "You begin crafting a spadroon..."
				playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
				if (do_after(user,120,src) && steel_amt >= 15)
					user << "You craft a spadroon."
					steel_amt -= 15
					if (steel_amt <= 0)
						icon_state = "anvil1"
					new/obj/item/weapon/material/sword/spadroon(user.loc)
					return
			else
				user << "<span class='notice'>You need more steel to make this!</span>"
				return
		if (choice2 == "Longsword (18)")
			if (steel_amt >= 18)
				user << "You begin crafting a longsword..."
				playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
				if (do_after(user,150,src) && steel_amt >= 18)
					user << "You craft a longsword."
					steel_amt -= 18
					if (steel_amt <= 0)
						icon_state = "anvil1"
					new/obj/item/weapon/material/sword/longsword(user.loc)
					return
			else
				user << "<span class='notice'>You need more steel to make this!</span>"
				return

	else if (iron_amt > 0)
		var/list/display = list("Swords", "Armor", "Cancel")
		if (map.ordinal_age >= 3)
			display = list("Swords","Guns", "Armor", "Cancel")
		else
			display = list("Swords", "Armor", "Cancel")
		var/choice = WWinput(user, "What do you want to make?", "Blacksmith - [iron_amt] iron", "Cancel", display)
		if (choice == "Cancel")
			return
		else if (choice == "Swords")
			var/list/display2 = list("Cancel")
			if (map.ordinal_age == 3)
				display2 = list("Small Sword (10)", "Sabre (15)", "Cutlass (12)", "Spadroon (15)", "Rapier (18)", "Cancel")
			else if (map.ordinal_age == 2)
				display2 = list("Small Sword (10)", "Spadroon (15)", "Longsword (18)", "Cancel")
			else if (map.ordinal_age == 1)
				display2 = list("Gladius (10)", "Xiphos (14)", "Cancel")
			else if (map.ordinal_age == 0)
				display2 = list("Cancel")

			var/choice2 = WWinput(user, "What do you want to make?", "Blacksmith - [iron_amt] iron", "Cancel", display2)
			if (choice2 == "Cancel")
				return
			if (choice2 == "Small Sword (10)")
				if (iron_amt >= 10)
					user << "You begin crafting a small sword..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,90,src) && iron_amt >= 10)
						user << "You craft a small sword."
						iron_amt -= 10
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/weapon/material/sword/smallsword/iron(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice2 == "Gladius (10)")
				if (iron_amt >= 10)
					user << "You begin crafting a gladius..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,90,src) && iron_amt >= 10)
						user << "You craft a gladius."
						iron_amt -= 10
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/weapon/material/sword/gladius(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice2 == "Xiphos (10)")
				if (iron_amt >= 14)
					user << "You begin crafting a xiphos..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,110,src) && iron_amt >= 14)
						user << "You craft a xiphos."
						iron_amt -= 14
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/weapon/material/sword/xiphos(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice2 == "Sabre (15)")
				if (iron_amt >= 15)
					user << "You begin crafting a sabre..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,120,src) && iron_amt >= 15)
						user << "You craft a sabre."
						iron_amt -= 15
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/weapon/material/sword/sabre/iron(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice2 == "Cutlass (12)")
				if (iron_amt >= 12)
					user << "You begin crafting a cutlass..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,100,src) && iron_amt >= 12)
						user << "You craft a cutlass."
						iron_amt -= 12
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/weapon/material/sword/cutlass/iron(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice2 == "Rapier (18)")
				if (iron_amt >= 18)
					user << "You begin crafting a rapier..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,150,src) && iron_amt >= 18)
						user << "You craft a rapier."
						iron_amt -= 18
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/weapon/material/sword/rapier/iron(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice2 == "Spadroon (15)")
				if (iron_amt >= 15)
					user << "You begin crafting a spadroon..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,120,src) && iron_amt >= 15)
						user << "You craft a spadroon."
						iron_amt -= 15
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/weapon/material/sword/spadroon/iron(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice2 == "Longsword (18)")
				if (iron_amt >= 18)
					user << "You begin crafting a longsword..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,150,src) && iron_amt >= 18)
						user << "You craft a longsword."
						iron_amt -= 18
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/weapon/material/sword/longsword/iron(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return

		else if (choice == "Guns")
			var/list/display3 = list("Crude Musket (15)", "Flintlock Pistol (20)", "Flintlock Musketoon (25)", "Flintlock Musket (30)", "Flintlock Blunderbuss (25)", "Cancel")
			var/choice3 = WWinput(user, "What do you want to make?", "Blacksmith - [iron_amt] iron", "Cancel", display3)
			if (choice3 == "Crude Musket (15)")
				if (iron_amt >= 15)
					user << "You begin crafting a crude musket..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,150,src) && iron_amt >= 15)
						user << "You craft a crude musket."
						iron_amt -= 15
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/weapon/gun/projectile/flintlock/crude(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice3 == "Flintlock Musket (30)")
				if (iron_amt >= 30)
					user << "You begin crafting a musket..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,200,src) && iron_amt >= 30)
						user << "You craft a musket."
						iron_amt -= 30
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/weapon/gun/projectile/flintlock/musket(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice3 == "Flintlock Musketoon (25)")
				if (iron_amt >= 25)
					user << "You begin crafting a musketoon..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,170,src) && iron_amt >= 25)
						user << "You craft a musketoon."
						iron_amt -= 25
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/weapon/gun/projectile/flintlock/musketoon(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice3 == "Flintlock Blunderbuss (25)")
				if (iron_amt >= 25)
					user << "You begin crafting a blunderbuss..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,170,src) && iron_amt >= 25)
						user << "You craft a blunderbuss."
						iron_amt -= 25
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/weapon/gun/projectile/flintlock/blunderbuss(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice3 == "Flintlock Pistol (20)")
				if (iron_amt >= 20)
					user << "You begin crafting a pistol..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,130,src) && iron_amt >= 20)
						user << "You craft a pistol."
						iron_amt -= 20
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/weapon/gun/projectile/flintlock/pistol(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice3 == "Cancel")
				return
		else if (choice == "Armor")
			var/list/display4 = list("Cancel")
			if (map.ordinal_age >= 2)
				display4 = list("Chainmail (10)", "Iron Chestplate (12)", "Plated Armor (16)", "Conical Helmet (6)", "Kettle Helmet (8)", "Coif (10)", "Protective Conical Helmet (10)", "Coif and Helmet (12)", "Knight Helmet (15)","Cancel")
			else
				display4 = list("Chainmail (10)", "Iron Chestplate (12)", "Roman Helmet (10)", "Greek Helmet (13)", "Gladiator Helmet (12)", "Horned Helmet (9)", "Cancel")
			var/choice4 = WWinput(user, "What do you want to make?", "Blacksmith - [iron_amt] iron", "Cancel", display4)
			if (choice4 == "Roman Helmet (10)")
				if (iron_amt >= 10)
					user << "You begin crafting the roman helmet..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,130,src) && iron_amt >= 10)
						user << "You craft the roman helmet."
						iron_amt -= 10
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/clothing/head/helmet/roman(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice4 == "Greek Helmet (13)")
				if (iron_amt >= 13)
					user << "You begin crafting the greek helmet..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,150,src) && iron_amt >= 13)
						user << "You craft the greek helmet."
						iron_amt -= 13
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/clothing/head/helmet/greek(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice4 == "Horned Helmet (9)")
				if (iron_amt >= 9)
					user << "You begin crafting the horned helmet..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,130,src) && iron_amt >= 9)
						user << "You craft the horned helmet."
						iron_amt -= 9
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/clothing/head/helmet/horned(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice4 == "Gladiator Helmet (12)")
				if (iron_amt >= 12)
					user << "You begin crafting the gladiator helmet..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,130,src) && iron_amt >= 12)
						user << "You craft the gladiator helmet."
						iron_amt -= 12
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/clothing/head/helmet/gladiator(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return


			if (choice4 == "Chainmail (10)")
				if (iron_amt >= 10)
					user << "You begin crafting the chainmail..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,130,src) && iron_amt >= 10)
						user << "You craft the chainmail."
						iron_amt -= 10
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/clothing/suit/armor/medieval/chainmail(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice4 == "Iron Chestplate (12)")
				if (iron_amt >= 12)
					user << "You begin crafting the iron chestplate..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,160,src) && iron_amt >= 12)
						user << "You craft the iron chestplate."
						iron_amt -= 12
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/clothing/suit/armor/medieval/iron_chestplate(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice4 == "Plated Armor (16)")
				if (iron_amt >= 16)
					user << "You begin crafting the plated armor..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,210,src) && iron_amt >= 16)
						user << "You craft the plated armor."
						iron_amt -= 16
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/clothing/suit/armor/medieval(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice4 == "Conical Helmet (6)")
				if (iron_amt >= 6)
					user << "You begin crafting the conical helmet..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,150,src) && iron_amt >= 6)
						user << "You craft the conical helmet."
						iron_amt -= 6
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/clothing/head/helmet/medieval/helmet3(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice4 == "Kettle Helmet (8)")
				if (iron_amt >= 8)
					user << "You begin crafting the kettle helmet..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,150,src) && iron_amt >= 8)
						user << "You craft the kettle helmet."
						iron_amt -= 8
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/clothing/head/helmet/medieval/helmet2(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice4 == "Protective Conical Helmet (10)")
				if (iron_amt >= 10)
					user << "You begin crafting the protective conical helmet..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,150,src) && iron_amt >= 10)
						user << "You craft the protective conical helmet."
						iron_amt -= 10
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/clothing/head/helmet/medieval/helmet1(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice4 == "Coif (10)")
				if (iron_amt >= 10)
					user << "You begin crafting the iron coif..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,150,src) && iron_amt >= 10)
						user << "You craft the iron coif."
						iron_amt -= 10
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/clothing/head/helmet/medieval/coif(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice4 == "Coif and Helmet (12)")
				if (iron_amt >= 12)
					user << "You begin crafting the iron coif and helmet..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,150,src) && iron_amt >= 12)
						user << "You craft the iron coif."
						iron_amt -= 12
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/clothing/head/helmet/medieval/coif_helmet(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
			if (choice4 == "Knight Helmet (15)")
				if (iron_amt >= 15)
					user << "You begin crafting the knight helmet..."
					playsound(loc, 'sound/effects/clang.ogg', 100, TRUE)
					if (do_after(user,150,src) && iron_amt >= 15)
						user << "You craft the knight helmet."
						iron_amt -= 15
						if (iron_amt <= 0)
							icon_state = "anvil1"
						new/obj/item/clothing/head/helmet/medieval(user.loc)
						return
				else
					user << "<span class='notice'>You need more iron to make this!</span>"
					return
	else if (iron_amt <= 0 || steel_amt <= 0)
		user << "There is no hot iron or steel on top of this anvil. Smite some first."
		return


/obj/structure/anvil/verb/empty()
	set category = null
	set name = "Empty"
	set src in range(1, usr)
	if (iron_amt > 0)
		var/obj/item/stack/material/iron/emptyediron = new/obj/item/stack/material/iron(src.loc)
		emptyediron.amount = iron_amt
		iron_amt = 0
	if (steel_amt > 0)
		var/obj/item/stack/material/steel/emptyedsteel = new/obj/item/stack/material/steel(src.loc)
		emptyedsteel.amount = steel_amt
		steel_amt = 0
	return
