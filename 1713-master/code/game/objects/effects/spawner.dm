/obj/effect/spawner
	name = "object spawner"

/obj/effect/spawner/objective_spawner
	name = "objective spawner"
	icon = 'icons/mob/screen/1713Style.dmi'
	icon_state = "x2"
	var/activated = 1

/obj/effect/spawner/objective_spawner/New()
	..()
	invisibility = 101
	spawnerproc()

/obj/effect/spawner/objective_spawner/proc/spawnerproc()
	if (activated)
		spawn(100)
			var/obj/item/cursedtreasure/targetobjective = new/obj/item/cursedtreasure(src.loc)
			var/locationtomove = pick(latejoin_turfs["treasure-mark"])
			targetobjective.loc = locationtomove
			world.log << "DEBUG: Created treasure at [targetobjective.x], [targetobjective.y]"
			activated = 0
			qdel(src)
			return

/obj/effect/spawner/mobspawner
	name = "mob spawner"
	icon = 'icons/mob/screen/1713Style.dmi'
	icon_state = "x2"
	var/activated = 1
	var/current_number = 0
	var/max_number = 10
	var/max_range = 10
	var/create_path = /mob/living/simple_animal/hostile/skeleton
	var/timer = 400
	var/scalable = 0 // when 1, it will only get active above x players
	var/scalable_nr = 10
	var/scalable_multiplyer = 1 //after how many times the scalable_nr it activates
	invisibility = 101

/obj/effect/spawner/mobspawner/skeletons
	name = "skeleton spawner"
	create_path = /mob/living/simple_animal/hostile/skeleton
	timer = 400

/obj/effect/spawner/mobspawner/attacker
	name = "attacking skeleton spawner"
	create_path = /mob/living/simple_animal/hostile/skeleton/attacker

/obj/effect/spawner/mobspawner/New()
	..()
	invisibility = 101
	icon_state = "invisible"
	spawnerproc()

/obj/effect/spawner/mobspawner/proc/spawnerproc()
	if (activated)
		if ((map.civilizations && !(season == "WINTER")) || !(map.civilizations))
			if ((current_number < max_number) && (scalable == 0 || (clients.len > (scalable_nr*scalable_multiplyer))))
				spawn(rand(timer,timer + (timer/2)))
					var/mob/living/simple_animal/newmob = new create_path(src.loc)
					newmob.origin = src
					newmob.x=src.x+(rand(-max_range,max_range))
					newmob.y=src.y+(rand(-max_range,max_range))
					current_number += 1
					if (istype(get_turf(newmob), /turf/wall) || istype (get_turf(newmob), /turf/floor/dirt/underground) || istype (get_turf(newmob), /turf/floor/plating/beach/water/deep))
						while (istype(get_turf(newmob), /turf/wall) || istype (get_turf(newmob), /turf/floor/dirt/underground) || istype (get_turf(newmob), /turf/floor/plating/beach/water/deep))
							newmob.x=src.x+(rand(-max_range,max_range))
							newmob.y=src.y+(rand(-max_range,max_range))
					spawnerproc()
			else
				spawn(rand(timer,timer + (timer/2)))
					spawnerproc()
		else
			spawn(rand(timer,timer + (timer/2)))
				spawnerproc()
	else
		spawn(rand(timer,timer + (timer/2)))
			spawnerproc()


/obj/effect/spawner/mobspawner/turkeys
	name = "turkey spawner"
	max_number = 2
	max_range = 10
	create_path = /mob/living/simple_animal/turkey_m
	timer = 3000

/obj/effect/spawner/mobspawner/turkeys_f
	name = "turkey spawner"
	max_number = 2
	max_range = 10
	create_path = /mob/living/simple_animal/turkey_f
	timer = 3000


/obj/effect/spawner/mobspawner/bears
	name = "bear spawner"
	max_number = 2
	max_range = 10
	create_path = /mob/living/simple_animal/hostile/bear
	timer = 3000

/obj/effect/spawner/mobspawner/monkeys
	name = "monkey spawner"
	max_number = 2
	max_range = 10
	create_path = /mob/living/simple_animal/monkey
	timer = 3000


/obj/effect/spawner/mobspawner/pirates
	name = "pirate spawner"
	create_path = /mob/living/simple_animal/hostile/pirate
	timer = 750

/obj/effect/spawner/mobspawner/british
	name = "redcoat spawner"
	max_number = 5
	max_range = 10
	create_path = /mob/living/simple_animal/hostile/british
	timer = 750

/obj/effect/spawner/mobspawner/townmilitia
	name = "townmilitia spawner"
	max_number = 5
	max_range = 10
	create_path = /mob/living/simple_animal/hostile/townmilitia
	timer = 750

/obj/effect/spawner/mobspawner/frogpoisonous
	name = "poisonous frog spawner"
	max_number = 1
	max_range = 12
	create_path = /mob/living/simple_animal/frog/poisonous
	timer = 4800

/obj/effect/spawner/mobspawner/mouse
	name = "mouse spawner"
	max_number = 2
	max_range = 12
	create_path = /mob/living/simple_animal/mouse/gray
	timer = 3600

/obj/effect/spawner/mobspawner/snake
	name = "snake spawner"
	max_number = 1
	max_range = 5
	create_path = /mob/living/simple_animal/hostile/poison/snake
	timer = 5000
/obj/effect/spawner/mobspawner/deer_m
	name = "stag spawner"
	max_number = 2
	max_range = 10
	create_path = /mob/living/simple_animal/deer/male
	timer = 3000

/obj/effect/spawner/mobspawner/deer_f
	name = "doe spawner"
	max_number = 2
	max_range = 10
	create_path = /mob/living/simple_animal/deer/female
	timer = 3000


/obj/effect/spawner/mobspawner/alligator
	name = "alligator spawner"
	max_number = 2
	max_range = 5
	create_path = /mob/living/simple_animal/hostile/alligator
	timer = 5000