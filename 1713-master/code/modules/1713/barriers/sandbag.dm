// this now inherits from window as its an easy way to give it the same
// multidirectional collision behavior

/mob/living/carbon/human/var/crouching = FALSE

/obj/structure/window/sandbag
	name = "dirt wall"
	icon_state = "dirt_wall"
	layer = MOB_LAYER + 0.01 //just above mobs
	anchored = TRUE
	climbable = TRUE

/obj/structure/window/sandbag/attack_hand(var/mob/user as mob)
	if (locate(src) in get_step(user, user.dir))
		if (WWinput(user, "Dismantle this dirt wall?", "Dismantle dirt wall", "Yes", list("Yes", "No")) == "Yes")
			visible_message("<span class='danger'>[user] starts dismantling the dirt wall.</span>", "<span class='danger'>You start dismantling the dirt wall.</span>")
			if (do_after(user, 200, src))
				visible_message("<span class='danger'>[user] finishes dismantling the dirt wall.</span>", "<span class='danger'>You finish dismantling the dirt wall.</span>")
				var/turf = get_turf(src)
				/* it takes 6 sandbags to make a full sandbag.
				  * so:
				    * give people 4 to 6 sandbags back for full sandbags
				    * give people the amount of sandbags (-1 or -0) back
				     * that it took them to make the structure in the first
				     * place
				*/
				if (!istype(src, /obj/structure/window/sandbag/incomplete))
					for (var/v in TRUE to rand(4,6))
						new /obj/item/weapon/sandbag(turf)
				else
					var/obj/structure/window/sandbag/incomplete/I = src
					for (var/v in TRUE to (1 + pick(I.progress-1, I.progress)))
						new /obj/item/weapon/sandbag(turf)
				qdel(src)

/obj/structure/window/sandbag/ex_act(severity)
	switch(severity)
		if (1.0)
			qdel(src)
			return
		if (2.0)
			qdel(src)
			return
		else
			if (prob(50))
				return ex_act(2.0)
	return

/obj/structure/window/sandbag/New(location, var/mob/creator)
	loc = location
	flags |= ON_BORDER

	if (creator && ismob(creator))
		dir = creator.dir
	else
		var/ndir = creator
		dir = ndir

	set_dir(dir)

	switch (dir)
		if (NORTH)
			layer = MOB_LAYER - 0.01
			pixel_y = FALSE
		if (SOUTH)
			layer = MOB_LAYER + 0.01
			pixel_y = FALSE
		if (EAST)
			layer = MOB_LAYER - 0.05
			pixel_x = FALSE
		if (WEST)
			layer = MOB_LAYER - 0.05
			pixel_x = FALSE

//incomplete sandbag structures
/obj/structure/window/sandbag/incomplete
	name = "incomplete dirt barricade"
	icon_state = "dirt_wall_33%"
	var/progress = FALSE


/obj/structure/window/sandbag/incomplete/ex_act(severity)
	qdel(src)

/obj/structure/window/sandbag/incomplete/attackby(obj/O as obj, mob/user as mob)
	user.dir = get_dir(user, src)
	if (istype(O, /obj/item/weapon/sandbag))
		if (progress < 3)
			progress += 1
			if (progress == 2)
				icon_state = "dirt_wall_66%"
			if (progress >= 3)
				icon_state = "dirt_wall"
				new/obj/structure/window/sandbag(loc, dir)
				qdel(src)
			visible_message("<span class='danger'>[user] shovels dirt into [src].</span>")
			qdel(O)
	else
		return

/obj/structure/window/sandbag/set_dir(direction)
	dir = direction

// sandbag window overrides

/obj/structure/window/sandbag/attackby(obj/O as obj, mob/user as mob)
	return FALSE

/obj/structure/window/sandbag/examine(mob/user)
	user << "That's a dirt barricade."
	return TRUE

/obj/structure/window/sandbag/take_damage(var/damage = FALSE, var/sound_effect = TRUE)
	return FALSE

/obj/structure/window/sandbag/apply_silicate(var/amount)
	return FALSE

/obj/structure/window/sandbag/updateSilicate()
	return FALSE

/obj/structure/window/sandbag/shatter(var/display_message = TRUE)
	return FALSE

/obj/structure/window/sandbag/bullet_act(var/obj/item/projectile/Proj)
	return FALSE

/obj/structure/window/sandbag/ex_act(severity)
	switch(severity)
		if (1.0)
			qdel(src)
			return
		if (2.0)
			qdel(src)
			return
		if (3.0)
			if (prob(50))
				qdel(src)

/obj/structure/window/sandbag/is_full_window()
	return FALSE

/obj/structure/window/hitby(AM as mob|obj)
	return FALSE // don't move

/obj/structure/window/sandbag/attack_generic(var/mob/user, var/damage)
	return FALSE

/obj/structure/window/sandbag/rotate()
	return

/obj/structure/window/sandbag/revrotate()
	return

/obj/structure/window/sandbag/is_fulltile()
	return FALSE

/obj/structure/window/sandbag/update_verbs()
	verbs -= /obj/structure/window/proc/rotate
	verbs -= /obj/structure/window/proc/revrotate

//merges adjacent full-tile windows into one (blatant ripoff from game/smoothwall.dm)
/obj/structure/window/sandbag/update_icon()
	return

/obj/structure/window/sandbag/fire_act(temperature)
	return

/obj/item/weapon/sandbag
	name = "dirt"
	icon_state = "dirt_pile"
	icon = 'icons/obj/items.dmi'
	w_class = TRUE
	var/sand_amount = FALSE

/obj/item/weapon/sandbag/attack_self(mob/user)
	user << "You start building the dirt blocks wall..."
	if (do_after(user, 25, src))
		user << "You finish the placement of the dirt blocks wall foundation."
		new /obj/covers/dirt_wall/blocks/incomplete(user.loc)
		qdel(src)
		return
/obj/structure/window/sandbag/rock
	name = "rock wall"
	icon_state = "rock_barricade"
	layer = MOB_LAYER + 0.01 //just above mobs
	anchored = TRUE
	climbable = TRUE
	health = 30

/obj/structure/window/sandbag/railing
	name = "railing"
	icon = 'icons/obj/railing.dmi'
	icon_state = "sandstone"
	layer = MOB_LAYER + 0.01 //just above mobs
	anchored = TRUE
	climbable = FALSE
	health = 10000000

/obj/structure/window/sandbag/railing/stone
	name = "railing"
	icon = 'icons/obj/railing.dmi'
	icon_state = "stone"
	layer = MOB_LAYER + 0.01 //just above mobs
	anchored = TRUE
	climbable = FALSE
	health = 10000000

/obj/structure/window/sandbag/railing/New()
	..()
	//invisibility = 101