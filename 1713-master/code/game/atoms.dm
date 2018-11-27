/atom
	layer = 2
	appearance_flags = TILE_BOUND
	var/level = 2
	var/flags = FALSE

	var/list/fingerprints
	var/list/fingerprintshidden
	var/fingerprintslast = null

	var/list/blood_DNA
	var/was_bloodied
	var/blood_color
	var/last_bumped = FALSE
	var/pass_flags = FALSE
	var/throwpass = FALSE
	var/germ_level = GERM_LEVEL_AMBIENT // The higher the germ level, the more germ on the atom.
	var/simulated = TRUE //filter for actions - used by lighting overlays
//	var/fluorescent // Shows up under a UV light.
	var/allow_spin = TRUE

	///Chemistry.
	var/datum/reagents/reagents = null

	//var/chem_is_open_container = FALSE
	// replaced by OPENCONTAINER flags and atom/proc/is_open_container()
	///Chemistry.

	//Detective Work, used for the duplicate data points kept in the scanners
	var/list/original_atom

	// supply trains

	var/uses_initial_density = FALSE

	var/initial_density = FALSE

	var/uses_initial_opacity = FALSE

	var/initial_opacity = FALSE

/atom/Destroy()
	if (reagents)
		qdel(reagents)
		reagents = null
	. = ..()

/atom/proc/CanPass(atom/movable/mover, turf/target, height=1.5, air_group = FALSE)
	//Purpose: Determines if the object (or airflow) can pass this atom.
	//Called by: Movement, airflow.
	//Inputs: The moving atom (optional), target turf, "height" and air group
	//Outputs: Boolean if can pass.

	return (!density || !height || air_group)


/atom/proc/reveal_blood()
	return

/atom/proc/assume_air(datum/gas_mixture/giver)
	return null

/atom/proc/remove_air(amount)
	return null

/atom/proc/return_air()
	if (loc)
		return loc.return_air()
	else
		return null

//return flags that should be added to the viewer's sight var.
//Otherwise return a negative number to indicate that the view should be cancelled.
/atom/proc/check_eye(user as mob)
	return -1

/atom/proc/on_reagent_change()
	return

/atom/proc/Bumped(AM as mob|obj)
	return

// Convenience proc to see if a container is open for chemistry handling
// returns true if open
// false if closed
/atom/proc/is_open_container()
	return flags & OPENCONTAINER

/*//Convenience proc to see whether a container can be accessed in a certain way.

	proc/can_subract_container()
		return flags & EXTRACT_CONTAINER

	proc/can_add_container()
		return flags & INSERT_CONTAINER
*/

/atom/proc/CheckExit()
	return TRUE

// If you want to use this, the atom must have the PROXMOVE flag, and the moving
// atom must also have the PROXMOVE flag currently to help with lag. ~ ComicIronic
/atom/proc/HasProximity(atom/movable/AM as mob|obj)
	return

/atom/proc/emp_act(var/severity)
	return

/atom/proc/pre_bullet_act(var/obj/item/projectile/P)

/atom/proc/bullet_act(var/obj/item/projectile/P, def_zone)
	P.on_hit(src, FALSE, def_zone)
	. = FALSE

/atom/proc/in_contents_of(container)//can take class or object instance as argument
	if (ispath(container))
		if (istype(loc, container))
			return TRUE
	else if (src in container)
		return TRUE
	return

/*
 *	atom/proc/search_contents_for (path,list/filter_path=null)
 * Recursevly searches all atom contens (including contents contents and so on).
 *
 * ARGS: path - search atom contents for atoms of this type
 *	   list/filter_path - if set, contents of atoms not of types in this list are excluded from search.
 *
 * RETURNS: list of found atoms
 */

/atom/proc/search_contents_for (path,list/filter_path=null)
	var/list/found = list()
	for (var/atom/A in src)
		if (istype(A, path))
			found += A
		if (filter_path)
			var/pass = FALSE
			for (var/type in filter_path)
				pass |= istype(A, type)
			if (!pass)
				continue
		if (A.contents.len)
			found += A.search_contents_for (path,filter_path)
	return found





//All atoms
/atom/proc/examine(mob/user, var/distance = -1, var/infix = "", var/suffix = "")
	//This reformat names to get a/an properly working on item descriptions when they are bloody
	var/f_name = "\a [src][infix]."
	if (blood_DNA && !istype(src, /obj/effect/decal))
		if (gender == PLURAL)
			f_name = "some "
		else
			f_name = "a "
		if (blood_color != "#030303")
			f_name += "<span class='danger'>blood-stained</span> [name][infix]!"
		else
			f_name += "oil-stained [name][infix]."
	if (!isobserver(user))
		user.visible_message("<font size=1>[user.name] looks at [src].</font>")
	user << "\icon[src] That's [f_name] [suffix]"
	user << desc

	return distance == -1 || (get_dist(src, user) <= distance)

//called to set the atom's dir and used to add behaviour to dir-changes
/atom/proc/set_dir(new_dir)
	var/old_dir = dir
	if (new_dir == old_dir)
		return FALSE

	dir = new_dir
	dir_set_event.raise_event(src, old_dir, new_dir)
	return TRUE

/atom/proc/ex_act()
	return


/atom/proc/fire_act()
	return

/atom/proc/melt()
	return

/atom/proc/hitby(atom/movable/AM as mob|obj)
	if (density)
		AM.throwing = FALSE
	return

/atom/proc/add_hiddenprint(mob/living/M as mob)
	if (isnull(M)) return
	if (isnull(M.key)) return
	if (ishuman(M))
		var/mob/living/carbon/human/H = M
		if (!istype(H.dna, /datum/dna))
			return FALSE
		if (H.gloves)
			if (fingerprintslast != H.key)
				fingerprintshidden += text("\[[time_stamp()]\] (Wearing gloves). Real name: [], Key: []",H.real_name, H.key)
				fingerprintslast = H.key
			return FALSE
		if (!( fingerprints ))
			if (fingerprintslast != H.key)
				fingerprintshidden += text("\[[time_stamp()]\] Real name: [], Key: []",H.real_name, H.key)
				fingerprintslast = H.key
			return TRUE
	else
		if (fingerprintslast != M.key)
			fingerprintshidden += text("\[[time_stamp()]\] Real name: [], Key: []",M.real_name, M.key)
			fingerprintslast = M.key
	return

/atom/proc/add_fingerprint(mob/living/M as mob, ignoregloves = FALSE)
	if (isnull(M)) return
	if (isnull(M.key)) return
	if (ishuman(M))
		//Add the list if it does not exist.
		if (!fingerprintshidden)
			fingerprintshidden = list()

		//First, make sure their DNA makes sense.
		var/mob/living/carbon/human/H = M
		if (!istype(H.dna, /datum/dna) || !H.dna.uni_identity || (length(H.dna.uni_identity) != 32))
			if (!istype(H.dna, /datum/dna))
				H.dna = new /datum/dna(null)
				H.dna.real_name = H.real_name
		H.check_dna()

		//Now, deal with gloves.
		if (H.gloves && H.gloves != src)
			if (fingerprintslast != H.key)
				fingerprintshidden += text("\[[]\](Wearing gloves). Real name: [], Key: []",time_stamp(), H.real_name, H.key)
				fingerprintslast = H.key
			H.gloves.add_fingerprint(M)

		//Deal with gloves the pass finger/palm prints.
		if (!ignoregloves)
			if (H.gloves != src)
				if (prob(75) && istype(H.gloves))
					return FALSE
				else if (H.gloves)
					return FALSE

		//More adminstuffz
		if (fingerprintslast != H.key)
			fingerprintshidden += text("\[[]\]Real name: [], Key: []",time_stamp(), H.real_name, H.key)
			fingerprintslast = H.key

		//Make the list if it does not exist.
		if (!fingerprints)
			fingerprints = list()

		//Hash this shit.
		var/full_print = H.get_full_print()

		// Add the fingerprints
		//
		if (fingerprints[full_print])
			switch(stringpercent(fingerprints[full_print]))		//tells us how many stars are in the current prints.

				if (28 to 32)
					if (prob(1))
						fingerprints[full_print] = full_print 		// You rolled a one buddy.
					else
						fingerprints[full_print] = stars(full_print, rand(0,40)) // 24 to 32

				if (24 to 27)
					if (prob(3))
						fingerprints[full_print] = full_print     	//Sucks to be you.
					else
						fingerprints[full_print] = stars(full_print, rand(15, 55)) // 20 to 29

				if (20 to 23)
					if (prob(5))
						fingerprints[full_print] = full_print		//Had a good run didn't ya.
					else
						fingerprints[full_print] = stars(full_print, rand(30, 70)) // 15 to 25

				if (16 to 19)
					if (prob(5))
						fingerprints[full_print] = full_print		//Welp.
					else
						fingerprints[full_print]  = stars(full_print, rand(40, 100))  // FALSE to 21

				if (0 to 15)
					if (prob(5))
						fingerprints[full_print] = stars(full_print, rand(0,50)) 	// small chance you can smudge.
					else
						fingerprints[full_print] = full_print

		else
			fingerprints[full_print] = stars(full_print, rand(0, 20))	//Initial touch, not leaving much evidence the first time.


		return TRUE
	else
		//Smudge up dem prints some
		if (fingerprintslast != M.key)
			fingerprintshidden += text("\[[]\]Real name: [], Key: []",time_stamp(), M.real_name, M.key)
			fingerprintslast = M.key

	//Cleaning up shit.
	if (fingerprints && !fingerprints.len)
		qdel(fingerprints)
	return


/atom/proc/transfer_fingerprints_to(var/atom/A)

	if (!istype(A.fingerprints,/list))
		A.fingerprints = list()

	if (!istype(A.fingerprintshidden,/list))
		A.fingerprintshidden = list()

	if (!istype(fingerprintshidden, /list))
		fingerprintshidden = list()

	//skytodo
	//A.fingerprints |= fingerprints            //detective
	//A.fingerprintshidden |= fingerprintshidden    //admin
	if (A.fingerprints && fingerprints)
		A.fingerprints |= fingerprints.Copy()            //detective
	if (A.fingerprintshidden && fingerprintshidden)
		A.fingerprintshidden |= fingerprintshidden.Copy()    //admin	A.fingerprintslast = fingerprintslast


//returns TRUE if made bloody, returns FALSE otherwise
/atom/proc/add_blood(mob/living/carbon/human/M as mob)

	if (flags & NOBLOODY)
		return FALSE

	if (!blood_DNA || !istype(blood_DNA, /list))	//if our list of DNA doesn't exist yet (or isn't a list) initialise it.
		blood_DNA = list()

	was_bloodied = TRUE
	blood_color = "#A10808"
	if (istype(M))
		if (!istype(M.dna, /datum/dna))
			M.dna = new /datum/dna(null)
			M.dna.real_name = M.real_name
		M.check_dna()
		if (M.species)
			blood_color = M.species.blood_color
	. = TRUE
	return TRUE

/atom/proc/add_vomit_floor(mob/living/carbon/M as mob, var/toxvomit = FALSE)
	if ( istype(src, /turf) )
		var/obj/effect/decal/cleanable/vomit/this = new /obj/effect/decal/cleanable/vomit(src)

		// Make toxins vomit look different
		if (toxvomit)
			this.icon_state = "vomittox_[pick(1,4)]"

/atom/proc/clean_blood()
	if (!simulated)
		return
//	fluorescent = FALSE
	germ_level = FALSE
	if (istype(blood_DNA, /list))
		blood_DNA = null
		return TRUE
/*
/atom/proc/get_global_map_pos()
	if (!islist(global_map) || isemptylist(global_map)) return
	var/cur_x = null
	var/cur_y = null
	var/list/y_arr = null
	for (cur_x=1,cur_x<=global_map.len,cur_x++)
		y_arr = global_map[cur_x]
		cur_y = y_arr.Find(z)
		if (cur_y)
			break
//	world << "X = [cur_x]; Y = [cur_y]"
	if (cur_x && cur_y)
		return list("x"=cur_x,"y"=cur_y)
	else
		return FALSE
*/
/atom/proc/checkpass(passflag)
	return pass_flags&passflag

/atom/proc/isinspace()
	return FALSE

// Show a message to all mobs and objects in sight of this atom
// Use for objects performing visible actions
// message is output to anyone who can see, e.g. "The [src] does something!"
// blind_message (optional) is what blind people will hear e.g. "You hear something!"
/atom/proc/visible_message(var/message, var/blind_message)

	var/list/see = get_mobs_or_objects_in_view(world.view,src) | viewers(get_turf(src), null)

	for (var/I in see)
		if (isobj(I))
			spawn(0)
				if (I) //It's possible that it could be deleted in the meantime.
					var/obj/O = I
					O.show_message( message, TRUE, blind_message, 2)
		else if (ismob(I))
			var/mob/M = I
			if (M.see_invisible >= invisibility) // Cannot view the invisible
				M.show_message( message, TRUE, blind_message, 2)
			else if (blind_message)
				M.show_message(blind_message, 2)

// Show a message to all mobs and objects in earshot of this atom
// Use for objects performing audible actions
// message is the message output to anyone who can hear.
// deaf_message (optional) is what deaf people will see.
// hearing_distance (optional) is the range, how many tiles away the message can be heard.
/atom/proc/audible_message(var/message, var/deaf_message, var/hearing_distance)

	var/range = world.view
	if (hearing_distance)
		range = hearing_distance
	var/list/hear = get_mobs_or_objects_in_view(range,src)

	for (var/I in hear)
		if (isobj(I))
			spawn(0)
				if (I) //It's possible that it could be deleted in the meantime.
					var/obj/O = I
					O.show_message( message, 2, deaf_message, TRUE)
		else if (ismob(I))
			var/mob/M = I
			M.show_message( message, 2, deaf_message, TRUE)

/atom/Entered(var/atom/movable/AM, var/atom/old_loc, var/special_event)
	if (loc && special_event == MOVED_DROP)
		AM.forceMove(loc, MOVED_DROP)
		return CANCEL_MOVE_EVENT
	return ..()

/turf/Entered(var/atom/movable/AM, var/atom/old_loc, var/special_event)
	return ..(AM, old_loc, FALSE)