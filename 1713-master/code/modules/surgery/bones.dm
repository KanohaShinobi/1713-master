//Procedures in this file: Fracture repair surgery
//////////////////////////////////////////////////////////////////
//						BONE SURGERY							//
//////////////////////////////////////////////////////////////////
/datum/surgery_step/set_bone
	allowed_tools = list(
	/obj/item/weapon/surgery/bonesetter = 100,	\
	/obj/item/weapon/wrench = 75		\
	)

	min_duration = 60
	max_duration = 70

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		if (!hasorgans(target))
			return FALSE
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		return affected && affected.name != "head" && affected.open >= 2 && affected.stage == FALSE

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		user.visible_message("[user] is beginning to set the bone in [target]'s [affected.name] in place with \the [tool]." , \
			"You are beginning to set the bone in [target]'s [affected.name] in place with \the [tool].")
		target.custom_pain("The pain in your [affected.name] is going to make you pass out!",1)
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		if (affected.status & ORGAN_BROKEN)
			user.visible_message("<span class = 'notice'>[user] sets the bone in [target]'s [affected.name] in place with \the [tool].</span>", \
				"<span class = 'notice'>You set the bone in [target]'s [affected.name] in place with \the [tool].</span>")
			affected.status &= ~ORGAN_BROKEN
			affected.status &= ~ORGAN_SPLINTED
			affected.stage = 0
			affected.perma_injury = 0
			affected.damage = 0
			affected.stage = TRUE
		else
			user.visible_message("<span class = 'notice'>[user] sets the bone in [target]'s [affected.name]<span class = 'red'>in the WRONG place with \the [tool].</span></span>", \
				"<span class = 'notice'>You set the bone in [target]'s [affected.name]<span class = 'red'> in the WRONG place with \the [tool].</span></span>")
			affected.fracture()

	fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		user.visible_message("<span class = 'red'>[user]'s hand slips, damaging the bone in [target]'s [affected.name] with \the [tool]!</span>" , \
			"<span class = 'red'>Your hand slips, damaging the bone in [target]'s [affected.name] with \the [tool]!</span>")
		affected.createwound(BRUISE, 5)

/datum/surgery_step/mend_skull
	allowed_tools = list(
	/obj/item/weapon/surgery/bonesetter = 100,	\
	/obj/item/weapon/wrench = 75		\
	)

	min_duration = 60
	max_duration = 70

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		if (!hasorgans(target))
			return FALSE
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		return affected && affected.name == "head" && affected.open >= 2 && affected.stage == FALSE

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		user.visible_message("[user] is beginning to piece together [target]'s skull with \the [tool]."  , \
			"You are beginning to piece together [target]'s skull with \the [tool].")
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		user.visible_message("<span class = 'notice'>[user] sets [target]'s skull with \the [tool].</span>" , \
			"<span class = 'notice'>You set [target]'s skull with \the [tool].</span>")
		affected.status &= ~ORGAN_BROKEN
		affected.status &= ~ORGAN_SPLINTED
		affected.stage = 0
		affected.perma_injury = 0
		affected.damage = 0
		affected.stage = TRUE

	fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		user.visible_message("<span class = 'red'>[user]'s hand slips, damaging [target]'s face with \the [tool]!</span>"  , \
			"<span class = 'red'>Your hand slips, damaging [target]'s face with \the [tool]!</span>")
		var/obj/item/organ/external/head/h = affected
		h.createwound(BRUISE, 10)
		h.disfigured = TRUE