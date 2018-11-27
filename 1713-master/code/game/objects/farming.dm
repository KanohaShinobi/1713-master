/obj/item/stack/farming/seeds
	name = "seeds"
	desc = "Some seeds."
	icon = 'icons/farming/plants.dmi'
	icon_state = "seeds"
	w_class = 1
	value = 1
	amount = 1
	max_amount = 100
	singular_name = "seed"

/obj/item/stack/farming/seeds/tomato
	name = "tomato seeds"
	plant = "tomato"

/obj/item/stack/farming/seeds/tobacco
	name = "tobacco seeds"
	plant = "tobacco"

/obj/item/stack/farming/seeds/sugarcane
	name = "sugarcane seeds"
	plant = "sugarcane"

/obj/item/stack/farming/seeds/wheat
	name = "wheat seeds"
	plant = "wheat"

/obj/item/stack/farming/seeds/apple
	name = "apple seeds"
	plant = "apple"

/obj/item/stack/farming/seeds/orange
	name = "orange seeds"
	plant = "orange"

/obj/item/stack/farming/seeds/cabbage
	name = "cabbage seeds"
	plant = "cabbage"

/obj/item/stack/farming/seeds/hemp
	name = "hemp seeds"
	plant = "hemp"

/obj/item/stack/farming/seeds/tea
	name = "tea seeds"
	plant = "tea"

/obj/item/stack/farming/seeds/potato
	name = "seed potato"
	desc = "a potato selected for breeding because of its characteristics."
	plant = "potato"
	icon_state = "potato"

/obj/item/stack/farming/seeds/corn
	name = "corn seeds"
	plant = "corn"

/obj/item/stack/farming/seeds/poppy
	name = "poppy seeds"
	desc = "Seeds of the opium poppy."
	plant = "poppy"

/obj/item/stack/farming/seeds/peyote
	name = "peyote seeds"
	plant = "peyote"


/obj/item/stack/farming/seeds/coffee
	name = "coffee seeds"
	plant = "coffee"

/obj/item/stack/farming/seeds/tree
	name = "tree seeds"
	plant = "tree"

/obj/item/stack/farming/seeds/cotton
	name = "cotton seeds"
	plant = "cotton"

/obj/structure/farming/plant
	name = "plant"
	desc = "a generic plant."
	icon = 'icons/farming/plants.dmi'
	icon_state = "tomato-grow1"
	anchored = TRUE
	opacity = FALSE
	density = FALSE
	var/stage = 1
	var/counter = 0

/obj/structure/farming/plant/tomato
	name = "tomato plant"
	desc = "a tomato plant."
	icon_state = "tomato-grow1"
	plant = "tomato"

/obj/structure/farming/plant/hemp
	name = "hemp plant"
	desc = "a hemp plant. Good to make ropes and uh, other things."
	icon_state = "hemp-grow1"
	plant = "hemp"

/obj/structure/farming/plant/corn
	name = "corn plant"
	desc = "a corn plant."
	icon_state = "corn-grow1"
	plant = "corn"

/obj/structure/farming/plant/wheat
	name = "wheat plant"
	desc = "a wheat plant."
	icon_state = "wheat-grow1"
	plant = "wheat"

/obj/structure/farming/plant/potato
	name = "potato plant"
	desc = "a potato plant."
	icon_state = "potato-grow1"
	plant = "potato"

/obj/structure/farming/plant/poppy
	name = "poppy plant"
	desc = "a opium poppy plant."
	icon_state = "poppy-grow1"
	plant = "poppy"

/obj/structure/farming/plant/cabbage
	name = "cabbage plant"
	desc = "a cabbage plant."
	icon_state = "cabbage-grow1"
	plant = "cabbage"

/obj/structure/farming/plant/apple
	name = "apple tree"
	desc = "an apple tree."
	icon_state = "orange-grow1"
	plant = "apple"

/obj/structure/farming/plant/orange
	name = "orange tree"
	desc = "an orange tree."
	icon_state = "orange-grow1"
	plant = "orange"

/obj/structure/farming/plant/tobacco
	name = "tobacco plant"
	desc = "a tobacco plant."
	icon_state = "tobacco-grow1"
	plant = "tobacco"

/obj/structure/farming/plant/sugarcane
	name = "sugarcane"
	desc = "a sugar cane. You can extract sugar from it."
	icon_state = "sugarcane-grow1"
	plant = "sugarcane"

/obj/structure/farming/plant/tea
	name = "tea"
	desc = "a tea plant."
	icon_state = "tea-grow1"
	plant = "tea"

/obj/structure/farming/plant/peyote
	name = "peyote"
	desc = "a peyote cactus plant."
	icon_state = "peyote-grow1"
	plant = "peyote"

/obj/structure/farming/plant/coffee
	name = "coffee"
	desc = "a coffee plant."
	icon_state = "coffee-grow1"
	plant = "coffee"

/obj/structure/farming/plant/cotton
	name = "cotton"
	desc = "a cotton plant."
	icon_state = "cotton-grow1"
	plant = "cotton"

/obj/structure/farming/plant/tree
	name = "tree"
	desc = "a tree, grown for wood."
	icon_state = "tree-grow1"
	plant = "tree"

//stages: 1-6 growth, 7 harvest, 8 dead
/obj/structure/farming/plant/New()
	..()
	growth()

/obj/structure/farming/plant/proc/growth()
	if (stage < 12)
		if (stage <= 6)
			icon_state = "[plant]-grow[stage]"
			desc = "A young [plant] plant."
			name = "young [plant] plant"
		else if (stage == 7 || stage == 8 || stage == 9 || stage == 10)
			icon_state = "[plant]-harvest"
			desc = "A ready to harvest [plant] plant."
			name = "ready [plant] plant"
		else if (stage >= 11)
			icon_state = "[plant]-dead"
			desc = "A dead [plant] plant."
			name = "dead [plant] plant"
		spawn(600)
			if ((map.civilizations && !(season == "WINTER")) || !(map.civilizations))
				stage += 1
			growth()

/obj/structure/farming/plant/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/material/knife) || istype(W, /obj/item/weapon/attachment/bayonet) || istype(W, /obj/item/weapon/material/kitchen/utensil/knife))
		if (stage <=6) // destroy
			user << "<span class = 'warning'>You uproot the [name].</span>"
			qdel(src)
		else if (stage == 7 || stage == 8 || stage == 9 || stage == 10) // harvest
			var/fruitpath = "/obj/item/weapon/reagent_containers/food/snacks/grown/[plant]"
			new fruitpath(loc)
			var/seedpath = "/obj/item/stack/farming/seeds/[plant]"
			new seedpath(loc)
			new seedpath(loc)
			user << "<span class = 'warning'>You harvest the [name].</span>"
			qdel(src)
		else // destroy
			user << "<span class = 'warning'>You uproot the dead [name].</span>"
			qdel(src)

//some specific, non-food plants
/obj/structure/farming/plant/hemp/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/material/knife) || istype(W, /obj/item/weapon/attachment/bayonet) || istype(W, /obj/item/weapon/material/kitchen/utensil/knife))
		if (stage <=6) // destroy
			user << "<span class = 'warning'>You uproot the [name].</span>"
			qdel(src)
		else if (stage == 7) // harvest
			new/obj/item/stack/material/rope(loc)
			var/seedpath = "/obj/item/stack/farming/seeds/[plant]"
			new seedpath(loc)
			new seedpath(loc)
			user << "<span class = 'warning'>You harvest the [name].</span>"
			qdel(src)
		else // destroy
			user << "<span class = 'warning'>You uproot the dead [name].</span>"
			qdel(src)



/obj/structure/farming/plant/tobacco/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/material/knife) || istype(W, /obj/item/weapon/attachment/bayonet) || istype(W, /obj/item/weapon/material/kitchen/utensil/knife))
		if (stage <=6) // destroy
			user << "<span class = 'warning'>You uproot the [name].</span>"
			qdel(src)
		else if (stage == 7) // harvest
			new/obj/item/stack/material/tobacco(loc)
			var/seedpath = "/obj/item/stack/farming/seeds/[plant]"
			new seedpath(loc)
			new seedpath(loc)
			user << "<span class = 'warning'>You harvest the [name].</span>"
			qdel(src)
		else // destroy
			user << "<span class = 'warning'>You uproot the dead [name].</span>"
			qdel(src)

/obj/structure/farming/plant/sugarcane/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/material/knife) || istype(W, /obj/item/weapon/attachment/bayonet) || istype(W, /obj/item/weapon/material/kitchen/utensil/knife))
		if (stage <=6) // destroy
			user << "<span class = 'warning'>You uproot the [name].</span>"
			qdel(src)
		else if (stage == 7) // harvest
			new/obj/item/weapon/reagent_containers/food/condiment/bsugar(loc)
			var/seedpath = "/obj/item/stack/farming/seeds/[plant]"
			new seedpath(loc)
			new seedpath(loc)
			user << "<span class = 'warning'>You harvest the [name].</span>"
			qdel(src)
		else // destroy
			user << "<span class = 'warning'>You uproot the dead [name].</span>"
			qdel(src)

/obj/structure/farming/plant/tea/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/material/knife) || istype(W, /obj/item/weapon/attachment/bayonet) || istype(W, /obj/item/weapon/material/kitchen/utensil/knife))
		if (stage <=6) // destroy
			user << "<span class = 'warning'>You uproot the [name].</span>"
			qdel(src)
		else if (stage == 7) // harvest
			new/obj/item/weapon/reagent_containers/food/condiment/tealeaves(loc)
			var/seedpath = "/obj/item/stack/farming/seeds/[plant]"
			new seedpath(loc)
			new seedpath(loc)
			user << "<span class = 'warning'>You harvest the [name].</span>"
			qdel(src)
		else // destroy
			user << "<span class = 'warning'>You uproot the dead [name].</span>"
			qdel(src)


/obj/structure/farming/plant/poppy/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/material/knife) || istype(W, /obj/item/weapon/attachment/bayonet) || istype(W, /obj/item/weapon/material/kitchen/utensil/knife))
		if (stage <=6) // destroy
			user << "<span class = 'warning'>You uproot the [name].</span>"
			qdel(src)
		else if (stage == 7) // harvest
			new/obj/item/stack/material/poppy(loc)
			var/seedpath = "/obj/item/stack/farming/seeds/[plant]"
			new seedpath(loc)
			new seedpath(loc)
			user << "<span class = 'warning'>You harvest the [name].</span>"
			qdel(src)
		else // destroy
			user << "<span class = 'warning'>You uproot the dead [name].</span>"
			qdel(src)


/obj/structure/farming/plant/tree/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/material/knife) || istype(W, /obj/item/weapon/attachment/bayonet) || istype(W, /obj/item/weapon/material/kitchen/utensil/knife))
		if (stage <=6) // destroy
			user << "<span class = 'warning'>You uproot the tree.</span>"
			qdel(src)
		else if (stage == 7) // harvest
			new/obj/item/stack/material/wood(loc)
			var/seedpath = "/obj/item/stack/farming/seeds/tree"
			new seedpath(loc)
			new seedpath(loc)
			user << "<span class = 'warning'>You cut some logs from the tree.</span>"
			qdel(src)
		else // destroy
			user << "<span class = 'warning'>You uproot the dead tree.</span>"
			qdel(src)


/obj/structure/farming/plant/cotton/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/material/knife) || istype(W, /obj/item/weapon/attachment/bayonet) || istype(W, /obj/item/weapon/material/kitchen/utensil/knife))
		if (stage <=6) // destroy
			user << "<span class = 'warning'>You uproot the cotton plant.</span>"
			qdel(src)
		else if (stage == 7) // harvest
			new/obj/item/stack/material/cotton(loc)
			var/seedpath = "/obj/item/stack/farming/seeds/cotton"
			new seedpath(loc)
			new seedpath(loc)
			user << "<span class = 'warning'>You pick the cotton.</span>"
			qdel(src)
		else // destroy
			user << "<span class = 'warning'>You uproot the dead cotton plant.</span>"
			qdel(src)