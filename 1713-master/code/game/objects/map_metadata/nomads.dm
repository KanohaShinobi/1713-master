#define NO_WINNER "The round is proceeding normally."
/obj/map_metadata/nomads
	ID = MAP_NOMADS
	title = "Nomads (225x225x2)"
	lobby_icon_state = "civilizations"
	caribbean_blocking_area_types = list(/area/caribbean/no_mans_land/invisible_wall/)
	respawn_delay = 6000 // 10 minutes!
	squad_spawn_locations = FALSE
//	min_autobalance_players = 90
	faction_organization = list(
		CIVILIAN,)
	available_subfactions = list(
		)
	roundend_condition_sides = list(
		list(CIVILIAN) = /area/caribbean/british
		)
	age = "5000 B.C."
	civilizations = TRUE
	var/tribes_nr = 1
	faction_distribution_coeffs = list(CIVILIAN = 1)
	battle_name = "the civilizations"
	mission_start_message = "<big>After ages as hunter-gatherers, people are starting to form groups and settling down. Will they be able to work together?</big><br><b>Wiki Guide: http://1713.eu/wiki/index.php/Civilizations</b>"
	ambience = list('sound/ambience/jungle1.ogg')
	faction1 = CIVILIAN
	availablefactions = list("Nomad")
	songs = list(
		"Empire Earth Intro:1" = 'sound/music/empire_earth_intro.ogg',)
	var/age1_lim = 110
	var/age1_done = 0
	var/age2_lim = 170
	var/age2_done = 0
	var/age3_lim = 300
	var/age3_done = 0

/obj/map_metadata/nomads/New()
	..()
	spawn(18000)
		seasons()


/obj/map_metadata/nomads/faction2_can_cross_blocks()
	return (processes.ticker.playtime_elapsed >= 0 || admin_ended_all_grace_periods)

/obj/map_metadata/nomads/faction1_can_cross_blocks()
	return (processes.ticker.playtime_elapsed >= 0 || admin_ended_all_grace_periods)

/obj/map_metadata/nomads/cross_message(faction)
	return ""

/obj/map_metadata/nomads/proc/seasons()
	if (season == "WINTER")
		season = "SPRING"
		world << "<big>The weather is getting warmer. It is now <b>Spring</b>.</big>"
		for (var/obj/structure/wild/tree/live_tree/TREES)
			TREES.update_icon()
		for (var/turf/floor/dirt/winter/D)
			if (prob(60))
				D.ChangeTurf(/turf/floor/dirt)
		for (var/turf/floor/winter/grass/G)
			if (prob(60))
				G.ChangeTurf(/turf/floor/plating/grass/wild)
		spawn(150)
			change_weather(WEATHER_NONE)
		spawn(1500)
		for (var/turf/floor/plating/beach/water/ice/W)
			W.ChangeTurf(/turf/floor/plating/beach/water)
		spawn(3000)
			for (var/turf/floor/dirt/D)
				if (istype(D, /turf/floor/dirt/winter))
					D.ChangeTurf(/turf/floor/dirt)
			for (var/turf/floor/winter/grass/G)
				if (istype(G, /turf/floor/winter/grass))
					G.ChangeTurf(/turf/floor/plating/grass/wild)
	else if (season == "SUMMER")
		season = "FALL"
		world << "<big>The leaves start to fall and the weather gets colder. It is now <b>Fall</b>.</big>"
		for (var/obj/structure/wild/tree/live_tree/TREES)
			TREES.update_icon()
		for (var/turf/floor/dirt/D)
			D.update_icon()
		for (var/turf/floor/plating/grass/wild/G)
			G.update_icon()
		spawn(100)
			change_weather(WEATHER_RAIN)
		spawn(15000)
			change_weather(WEATHER_SNOW)
			for (var/turf/floor/dirt/D)
				var/area/A = get_area(D)
				if (prob(40) && A.location != AREA_INSIDE && A.z > 1)
					D.ChangeTurf(/turf/floor/dirt/winter)
			for (var/turf/floor/plating/grass/wild/G)
				if (prob(40))
					G.ChangeTurf(/turf/floor/winter/grass)
			spawn(1200)
				for (var/turf/floor/dirt/D)
					var/area/A = get_area(D)
					if (!istype(D,/turf/floor/dirt/winter))
						if (prob(50) && A.location != AREA_INSIDE && A.z > 1)
							D.ChangeTurf(/turf/floor/dirt/winter)
				for (var/turf/floor/plating/grass/wild/G)
					if (prob(50))
						G.ChangeTurf(/turf/floor/winter/grass)
	else if (season == "FALL")
		season = "WINTER"
		world << "<big>The weather gets very cold. <b>Winter</b> has arrived.</big>"
		for (var/obj/structure/wild/tree/live_tree/TREES)
			TREES.update_icon()
		for (var/turf/floor/dirt/D)
			if (!istype(D,/turf/floor/dirt/winter))
				var/area/A = get_area(D)
				if  (A.location != AREA_INSIDE && A.z > 1)
					D.ChangeTurf(/turf/floor/dirt/winter)
		for (var/turf/floor/plating/grass/wild/G)
			G.ChangeTurf(/turf/floor/winter/grass)
		spawn(100)
			change_weather(WEATHER_SNOW)
		spawn(800)
		for (var/turf/floor/plating/beach/water/W)
			if (W.water_level <= 50 && W.z > 1)
				W.ChangeTurf(/turf/floor/plating/beach/water/ice)

		spawn(12000)
			for (var/turf/floor/dirt/winter/D)
				if (prob(20))
					D.ChangeTurf(/turf/floor/dirt)
			for (var/turf/floor/winter/grass/G)
				if (prob(20))
					G.ChangeTurf(/turf/floor/plating/grass/wild)
	else if (season == "SPRING")
		season = "SUMMER"
		world << "<big>The weather is warm. It is now <b>Summer</b>.</big>"
		for (var/obj/structure/wild/tree/live_tree/TREES)
			TREES.update_icon()
		for (var/turf/floor/dirt/winter/D)
			if (istype(D, /turf/floor/dirt/winter))
				D.ChangeTurf(/turf/floor/dirt)
		for (var/turf/floor/winter/grass/G)
			if (istype(G, /turf/floor/winter/grass))
				G.ChangeTurf(/turf/floor/plating/grass/wild)
		spawn(100)
			change_weather(WEATHER_NONE)
	spawn(18000)
		seasons()

/obj/map_metadata/nomads/tick()
	..()
	if (age1_done == FALSE)
		if ((civa_research[1]+civa_research[2]+civa_research[3]) >= age1_lim || (civb_research[1]+civb_research[2]+civb_research[3]) >= age1_lim   || (civc_research[1]+civc_research[2]+civc_research[3]) >= age1_lim   || (civd_research[1]+civd_research[2]+civd_research[3]) >= age1_lim   || (cive_research[1]+cive_research[2]+cive_research[3]) >= age1_lim   || (civf_research[1]+civf_research[2]+civf_research[3]) >= age1_lim )
			world << "<big>The world has advanced into the Bronze Age!</big>"
			age = "313 B.C."
			set_ordinal_age()
			age1_done = TRUE
	if (age2_done == FALSE)
		if ((civa_research[1]+civa_research[2]+civa_research[3]) >= age2_lim || (civb_research[1]+civb_research[2]+civb_research[3]) >= age2_lim    || (civc_research[1]+civc_research[2]+civc_research[3]) >= age2_lim    || (civd_research[1]+civd_research[2]+civd_research[3]) >= age2_lim    || (cive_research[1]+cive_research[2]+cive_research[3]) >= age2_lim    || (civf_research[1]+civf_research[2]+civf_research[3]) >= age2_lim  )
			world << "<big>The world has advanced into the Medieval Age!</big>"
			age = "1013"
			set_ordinal_age()
			age2_done = TRUE
	if (age3_done == FALSE)
		if ((civa_research[1]+civa_research[2]+civa_research[3]) >= age3_lim|| (civb_research[1]+civb_research[2]+civb_research[3]) >= age3_lim    || (civc_research[1]+civc_research[2]+civc_research[3]) >= age3_lim    || (civd_research[1]+civd_research[2]+civd_research[3]) >= age3_lim    || (cive_research[1]+cive_research[2]+cive_research[3]) >= age3_lim    || (civf_research[1]+civf_research[2]+civf_research[3]) >= age3_lim  )
			world << "<big>The world has advanced into the Imperial Age!</big>"
			age = "1713"
			set_ordinal_age()
			age3_done = TRUE

/obj/map_metadata/nomads/job_enabled_specialcheck(var/datum/job/J)
	if (J.is_nomad == TRUE)
		. = TRUE
	else
		. = FALSE
#undef NO_WINNER