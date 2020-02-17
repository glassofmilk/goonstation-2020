/*
CONTAINS:
	- SCALPEL
	- CIRCULAR SAW
	- STAPLE GUN
	- DEFIBRILLATOR
	- SUTURE
	- BANDAGE
	- BLOOD BAG (unused)
	- BODY BAG
	- HEMOSTAT
	- REFLEX HAMMER
	- PENLIGHT
	- SURGERY TRAY
	- SURGICAL SCISSORS
*/
/* ================================================= */
/* -------------------- Scalpel -------------------- */
/* ================================================= */

/obj/item/scalpel
	name = "scalpel"
	desc = "A surgeon's tool, used to cut precisely into a subject's body."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "scalpel1"
	inhand_image_icon = 'icons/mob/inhand/hand_medical.dmi'
	item_state = "scalpel"
	flags = FPRINT | TABLEPASS | CONDUCT | ONBELT
	tool_flags = TOOL_CUTTING
	hit_type = DAMAGE_CUT
	hitsound = 'sound/impact_sounds/Flesh_Cut_1.ogg'
	force = 3.0
	w_class = 1.0
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	m_amt = 10000
	g_amt = 5000
	stamina_damage = 5
	stamina_cost = 5
	stamina_crit_chance = 35
	var/mob/Poisoner = null
	module_research = list("tools" = 3, "medicine" = 3, "weapons" = 0.25)

	New()
		..()
		if (src.icon_state == "scalpel1")
			icon_state = pick("scalpel1", "scalpel2")
		src.create_reagents(5)

	attack(mob/living/carbon/M as mob, mob/user as mob)
		if (src.reagents && src.reagents.total_volume)
			logTheThing("combat", user, M, "used [src] on %target% (<b>Intent</b>: <i>[user.a_intent]</i>) (<b>Targeting</b>: <i>[user.zone_sel.selecting]</i>) [log_reagents(src)]")
			src.reagents.trans_to(M,5)
		else
			logTheThing("combat", user, M, "used [src] on %target% (<b>Intent</b>: <i>[user.a_intent]</i>) (<b>Targeting</b>: <i>[user.zone_sel.selecting]</i>)")
		if (!scalpel_surgery(M, user))
			return ..()
		else return

	custom_suicide = 1
	suicide(var/mob/user as mob)
		if (!src.user_can_suicide(user))
			return 0
		user.visible_message("<span style='color:red'><b>[user] slashes [his_or_her(user)] own throat with [src]!</b></span>")
		blood_slash(user, 25)
		playsound(user.loc, src.hitsound, 50, 1)
		user.TakeDamage("head", 150, 0)
		user.updatehealth()
		SPAWN_DBG(500)
			if (user && !isdead(user))
				user.suiciding = 0
		return 1

/obj/item/scalpel/vr
	icon = 'icons/effects/VR.dmi'
	icon_state = "scalpel"

/* ====================================================== */
/* -------------------- Circular Saw -------------------- */
/* ====================================================== */

/obj/item/circular_saw
	name = "circular saw"
	desc = "A saw used to cut bone with precision."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "saw1"
	inhand_image_icon = 'icons/mob/inhand/hand_medical.dmi'
	item_state = "saw1"
	flags = FPRINT | TABLEPASS | CONDUCT | ONBELT
	tool_flags = TOOL_SAWING
	hit_type = DAMAGE_CUT
	hitsound = 'sound/impact_sounds/Flesh_Cut_1.ogg'
	force = 3
	w_class = 1.0
	throwforce = 3.0
	throw_speed = 3
	throw_range = 5
	m_amt = 20000
	g_amt = 10000
	stamina_damage = 5
	stamina_cost = 5
	stamina_crit_chance = 35
	var/mob/Poisoner = null
	module_research = list("tools" = 3, "medicine" = 3, "weapons" = 0.25)

	New()
		..()
		if (src.icon_state == "saw1")
			icon_state = pick("saw1", "saw2", "saw3")
		src.create_reagents(5)

	attack(mob/living/carbon/M as mob, mob/user as mob)
		if (src.reagents && src.reagents.total_volume)
			logTheThing("combat", user, M, "used [src] on %target% (<b>Intent</b>: <i>[user.a_intent]</i>) (<b>Targeting</b>: <i>[user.zone_sel.selecting]</i>) [log_reagents(src)]")
			src.reagents.trans_to(M,5)
		else
			logTheThing("combat", user, M, "used [src] on %target% (<b>Intent</b>: <i>[user.a_intent]</i>) (<b>Targeting</b>: <i>[user.zone_sel.selecting]</i>)")
		if (!saw_surgery(M, user))
			return ..()
		else return

	custom_suicide = 1
	suicide(var/mob/user as mob)
		if (!src.user_can_suicide(user))
			return 0
		user.visible_message("<span style='color:red'><b>[user] slashes [his_or_her(user)] own throat with [src]!</b></span>")
		blood_slash(user, 25)
		playsound(user.loc, src.hitsound, 50, 1)
		user.TakeDamage("head", 150, 0)
		user.updatehealth()
		SPAWN_DBG(500)
			if (user && !isdead(user))
				user.suiciding = 0
		return 1

/obj/item/circular_saw/vr
	icon = 'icons/effects/VR.dmi'
	icon_state = "saw"

/* =========================================================== */
/* -------------------- Enucleation Spoon -------------------- */
/* =========================================================== */

/obj/item/surgical_spoon
	name = "enucleation spoon"
	desc = "A surgeon's tool, used to protect the globe of the eye during eye removal surgery, and to lift the eye out of the socket. You could eat food with it too, I guess."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "spoon"
	inhand_image_icon = 'icons/mob/inhand/hand_medical.dmi'
	item_state = "scalpel"
	flags = FPRINT | TABLEPASS | CONDUCT | ONBELT
	hit_type = DAMAGE_STAB
	hitsound = 'sound/impact_sounds/Flesh_Stab_1.ogg'
	force = 3.0
	w_class = 1.0
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	m_amt = 10000
	g_amt = 5000
	stamina_damage = 5
	stamina_cost = 5
	stamina_crit_chance = 35
	var/mob/Poisoner = null
	module_research = list("tools" = 3, "medicine" = 3, "weapons" = 0.25)

	New()
		..()
		src.create_reagents(5)

	attack(mob/living/carbon/M as mob, mob/user as mob)
		if (src.reagents && src.reagents.total_volume)
			logTheThing("combat", user, M, "used [src] on %target% (<b>Intent</b>: <i>[user.a_intent]</i>) (<b>Targeting</b>: <i>[user.zone_sel.selecting]</i>) [log_reagents(src)]")
			src.reagents.trans_to(M,5)
		else
			logTheThing("combat", user, M, "used [src] on %target% (<b>Intent</b>: <i>[user.a_intent]</i>) (<b>Targeting</b>: <i>[user.zone_sel.selecting]</i>)")
		if (!spoon_surgery(M, user))
			return ..()
		else return

	custom_suicide = 1
	suicide(var/mob/user as mob)
		if (!src.user_can_suicide(user))
			return 0
		var/hisher = his_or_her(user)
		user.visible_message("<span style='color:red'><b>[user] jabs [src] straight through [hisher] eye and into [hisher] brain!</b></span>")
		blood_slash(user, 25)
		playsound(user.loc, src.hitsound, 50, 1)
		user.TakeDamage("head", 150, 0)
		user.updatehealth()
		SPAWN_DBG(500)
			if (user && !isdead(user))
				user.suiciding = 0
		return 1

/* ==================================================== */
/* -------------------- Staple Gun -------------------- */
/* ==================================================== */

/obj/item/staple_gun
	name = "staple gun"
	desc = "A medical staple gun for securely reattaching limbs."
	icon = 'icons/obj/gun.dmi'
	icon_state = "staplegun"
	w_class = 1
	throw_speed = 4
	throw_range = 20
	force = 5
	flags = ONBELT
	object_flags = NO_ARM_ATTACH
	var/datum/projectile/staple = new/datum/projectile/bullet/staple
	var/ammo = 20
	stamina_damage = 15
	stamina_cost = 15
	stamina_crit_chance = 15
	module_research = list("tools" = 1, "medicine" = 1, "weapons" = 1)

	// Every bit of usability helps (Convair880).
	examine()
		src.desc = "A medical staple gun for securely reattaching limbs. There are [src.ammo] staples left."
		..()
		return

	attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
		if (!ismob(M))
			return

		src.add_fingerprint(user)

		if (src.ammo < 1)
			user.show_text("*click* *click*", "red")
			playsound(user, "sound/weapons/Gunclick.ogg", 50, 1)
			return ..()

		if (user.a_intent != "help" && ishuman(M))
			var/mob/living/carbon/human/H = M
			H.visible_message("<span style='color:red'><B>[user] shoots [H] point-blank with [src]!</B></span>")
			hit_with_projectile(user, staple, H)
			src.ammo--
			if (H && isalive(H))
				H.lastgasp()
			return

		if (!ishuman(M) || !(user.zone_sel && user.zone_sel.selecting in list("l_arm","r_arm","l_leg","r_leg", "head")))
			return ..()

		var/mob/living/carbon/human/H = M

		//Attach butt to head
		if (user.zone_sel.selecting == "head" && istype(H.head, /obj/item/clothing/head/butt))
			var/obj/item/clothing/head/butt/B = H.head
			B.staple()
			if (src.staple.shot_sound)
				playsound(user, src.staple.shot_sound, 50, 1)
			if (user == H)
				user.visible_message("<span style='color:red'><b>[user] staples \the [B.name] to their own head! [prob(10) ? pick("Woah!", "What a goof!", "Wow!", "WHY!?"): null]</span>")
			else
				user.visible_message("<span style='color:red'><b>[user] staples \the [B.name] to [H.name]'s head!</span>")
			if (H.stat!=2)
				H.emote(pick("cry", "wail", "weep", "sob", "shame", "twitch"))
			src.ammo--
			logTheThing("combat",user, H, "staples a butt to %target%'s head")
			return

		if (!surgeryCheck(H, user))
			return ..()

		// Marq fix for undefined variable /datum/human_limbs/var/head
		if (user.zone_sel.selecting in H.limbs.vars)
			var/obj/item/parts/surgery_limb = H.limbs.vars[user.zone_sel.selecting]
			if (istype(surgery_limb))
				src.ammo--
				surgery_limb.surgery(src)
			return

	attackby(obj/item/W, mob/user)
		..()
		if (istype(W,/obj/item/pipebomb/frame))
			var/obj/item/pipebomb/frame/F = W
			if (F.state < 2)
				user.show_text("This might work better if [F] was hollowed out.")
			else if (F.state == 2)
				user.show_text("You combine [F] and [src]. This looks pretty unsafe!")
				user.u_equip(F)
				user.u_equip(src)
				var/turf/T = get_turf(src)
				playsound(T, "sound/items/Deconstruct.ogg", 50, 1)
				new/obj/item/gun/kinetic/zipgun(T)
				qdel(F)
				qdel(src)

			else
				user.show_text("You can't seem to combine these two items this way.")
		return

// a mostly decorative thing from z2 areas I want to add to office closets
/obj/item/staple_gun/red
	name = "stapler"
	desc = "A red stapler.  No, not THAT red stapler."
	icon = 'icons/obj/items.dmi'
	icon_state = "stapler"
	item_state = "stapler"

/* =============================================== */
/* -------------------- Defib -------------------- */
/* =============================================== */

/obj/item/robodefibrillator
	name = "defibrillator"
	desc = "Used to resuscitate critical patients."
	flags = FPRINT | TABLEPASS | CONDUCT
	icon = 'icons/obj/surgery.dmi'
	inhand_image_icon = 'icons/mob/inhand/hand_medical.dmi'
	icon_state = "defib-on"
	item_state = "defib"
	var/icon_base = "defib"
	var/charged = 1
	var/charge_time = 100
	var/emagged = 0
	var/makeshift = 0
	var/obj/item/cell/cell = null
	mats = 10

	emag_act(var/mob/user)
		if (src.makeshift)
			if (user)
				user.show_text("You prod at [src], but it doesn't do anything.", "red")
			return 0
		if (!src.emagged)
			if (user)
				user.show_text("You short out the on board medical scanner!", "blue")
			src.desc += " The screen only shows the word KILL flashing over and over."
			src.emagged = 1
			return 1
		else
			if (user)
				user.show_text("This has already been tampered with.", "red")
			return 0

	demag(var/mob/user)
		if (!src.emagged)
			return 0
		if (user)
			user.show_text("You reapair the on board medical scanner.", "blue")
			src.desc = null
			src.desc = "Used to resuscitate critical patients."
		src.emagged = 0
		return 1

	attack(mob/living/M as mob, mob/user as mob)
		if (!ishuman(M))
			return ..()
		if (src.charged == 0)
			user.show_text("[src] is still charging!", "red")
			return
		if (src.defibrillate(M, user, src.emagged, src.makeshift, src.cell))
			src.charged = 0
			set_icon_state("[src.icon_base]-shock")
			SPAWN_DBG(10)
				set_icon_state("[src.icon_base]-off")
			SPAWN_DBG(src.charge_time)
				src.charged = 1
				set_icon_state("[src.icon_base]-on")
				playsound(user.loc, "sound/weapons/flash.ogg", 75, 1)

	proc/do_the_shocky_thing(mob/user as mob)
		if (src.charged == 0)
			user.show_text("[src] is still charging!", "red")
			return 0
		playsound(src.loc, "sound/impact_sounds/Energy_Hit_3.ogg", 75, 1)
		src.charged = 0
		set_icon_state("[src.icon_base]-shock")
		SPAWN_DBG(10)
			set_icon_state("[src.icon_base]-off")
		SPAWN_DBG(src.charge_time)
			src.charged = 1
			set_icon_state("[src.icon_base]-on")
			playsound(src.loc, "sound/weapons/flash.ogg", 75, 1)
		return 1

	disposing()
		..()
		if (src.cell)
			src.cell.dispose()
			src.cell = null

	get_desc(dist)
		..()
		if (istype(src.cell))
			if (src.cell.artifact)
				return
			else
				. += "The charge meter reads [round(src.cell.percent())]%."

	custom_suicide = 1
	suicide(var/mob/user as mob)
		if (!src.user_can_suicide(user))
			return 0
		if (src.defibrillate(user, user, src.emagged, src.makeshift, src.cell, 1))
			SPAWN_DBG(500)
				if (user && !isdead(user))
					user.suiciding = 0
		else
			user.suiciding = 0
		return 1

/obj/item/robodefibrillator/emagged
	emagged = 1
	desc = "Used to resuscitate critical patients.  The screen only shows the word KILL flashing over and over."

/obj/item/robodefibrillator/vr
	icon = 'icons/effects/VR.dmi'

/obj/item/robodefibrillator/makeshift
	name = "shoddy-looking makeshift defibrillator"
	desc = "It might restart your heart, I guess, or it might barbeque your insides."
	icon_state = "cell-on"
	inhand_image_icon = 'icons/mob/inhand/hand_medical.dmi'
	item_state = "cell"
	icon_base = "cell"
	makeshift = 1

	New(var/location, var/obj/item/cell/newcell)
		..()
		if (!istype(newcell))
			newcell = new /obj/item/cell/charged(src)
		src.cell = newcell
		newcell.set_loc(src)

/* ================================================ */
/* -------------------- Suture -------------------- */
/* ================================================ */

/obj/item/suture
	name = "suture"
	desc = "A fine, curved needle with a length of absorbable polyglycolide suture thread."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "suture"
	inhand_image_icon = 'icons/mob/inhand/hand_medical.dmi'
	item_state = "suture"
	flags = FPRINT | TABLEPASS | CONDUCT
	hit_type = DAMAGE_STAB
	object_flags = NO_ARM_ATTACH
	w_class = 1.0
	force = 1
	throwforce = 1.0
	throw_speed = 4
	throw_range = 20
	m_amt = 5000
	stamina_damage = 1
	stamina_cost = 1
	stamina_crit_chance = 0
	var/in_use = 0
	hide_attack = 2

	attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
		if (!suture_surgery(M,user))
			if (ishuman(M))
				var/mob/living/carbon/human/H = M
				var/zone = user.zone_sel.selecting
				var/surgery_status = H.get_surgery_status(zone)
				if (surgery_status && H.organHolder)
					actions.start(new /datum/action/bar/icon/medical_suture_bandage(H, src, 10, zone, surgery_status, rand(1,2), "sutur"), user)
					src.in_use = 1
				else if (H.bleeding)
					actions.start(new /datum/action/bar/icon/medical_suture_bandage(H, src, 15, 0, 0, 5, "sutur"), user)
					src.in_use = 1
				else
					user.show_text("[H == user ? "You have" : "[H] has"] no wounds or incisions on [H == user ? "your" : his_or_her(H)] [zone_sel2name[zone]] to close!", "red")
					H.organHolder.chest.op_stage = 0.0
					src.in_use = 0
					return
		else
			return

	custom_suicide = 1
	suicide(var/mob/user as mob)
		if (!src.user_can_suicide(user))
			return 0
		user.visible_message("<span style='color:red'><b>[user] rapidly sews [his_or_her(user)] mouth and nose closed with [src]! Holy shit, how?!</b></span>")
		user.take_oxygen_deprivation(160)
		user.updatehealth()
		SPAWN_DBG(500)
			if (user && !isdead(user))
				user.suiciding = 0
		return 1

/obj/item/suture/vr
	icon = 'icons/effects/VR.dmi'

/* ================================================= */
/* -------------------- Bandage -------------------- */
/* ================================================= */

/obj/item/bandage
	name = "bandage"
	desc = "A length of gauze that will help stop bleeding."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "bandage-item-3"
	uses_multiple_icon_states = 1
	inhand_image_icon = 'icons/mob/inhand/hand_medical.dmi'
	item_state = "bandage"
	flags = FPRINT | TABLEPASS
	object_flags = NO_ARM_ATTACH
	w_class = 1.0
	force = 0
	throwforce = 1.0
	throw_speed = 4
	throw_range = 20
	stamina_damage = 0
	stamina_cost = 0
	stamina_crit_chance = 0
	var/uses = 6
	var/in_use = 0
	hide_attack = 2

	get_desc(dist)
		..()
		if (src.uses >= 0)
			switch (src.uses)
				if (-INFINITY to 0)
					. += "<span style='color:red'>There's none left.</span>"
				if (1 to 5)
					. += "<span style='color:red'>There's enough left to bandage about [src.uses] wound[s_es(src.uses)].</span>"
				if (6 to INFINITY)
					. += "None of it has been used."

	attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
		if (!src.uses || src.icon_state == "bandage-item-0")
			user.show_text("There's nothing left of [src]!", "red")
			return
		if (src.in_use)
			return
		if (ishuman(M))
			var/mob/living/carbon/human/H = M
			var/zone = user.zone_sel.selecting
			var/surgery_status = H.get_surgery_status(zone)
			if (surgery_status && H.organHolder)
				actions.start(new /datum/action/bar/icon/medical_suture_bandage(H, src, 10, zone, surgery_status, rand(2,5), "bandag"), user)
				src.in_use = 1
			else if (H.bleeding)
				actions.start(new /datum/action/bar/icon/medical_suture_bandage(H, src, 15, zone, 0, rand(3,5), "bandag"), user)
				src.in_use = 1
			else
				user.show_text("[H == user ? "You have" : "[H] has"] no wounds or incisions on [H == user ? "your" : his_or_her(H)] [zone_sel2name[zone]] to bandage!", "red")
				src.in_use = 0
				return
		else
			return ..()

	proc/update_icon()
		switch (src.uses)
			if (0 to -INFINITY)
				src.icon_state = "bandage-item-0"
			if (1 to 2)
				src.icon_state = "bandage-item-1"
			if (3 to 4)
				src.icon_state = "bandage-item-2"
			if (5 to INFINITY)
				src.icon_state = "bandage-item-3"

/obj/item/bandage/vr
	icon = 'icons/effects/VR.dmi'

/* =============================================================== */
/* -------------------- Suture/Bandage Action -------------------- */
/* =============================================================== */

/datum/action/bar/icon/medical_suture_bandage
	id = "medical_suture_bandage"
	interrupt_flags = INTERRUPT_MOVE | INTERRUPT_ACT | INTERRUPT_STUNNED | INTERRUPT_ACTION
	duration = 15
	icon = 'icons/obj/surgery.dmi'
	icon_state = "suture"
	var/mob/living/carbon/human/target
	var/obj/item/tool
	var/zone
	var/surgery_status
	var/repair_amount
	var/vrb

	New(Target, Tool, Time, Zone, Status, Repair, Vrb)
		target = Target
		tool = Tool
		duration = Time
		zone = Zone
		surgery_status = Status
		repair_amount = Repair
		vrb = Vrb
		if (zone && surgery_status)
			duration = CLAMP((duration * surgery_status), 5, 50)
		else if (ishuman(target))
			duration = CLAMP((duration * target.bleeding), 5, 50)
		if (tool)
			icon = tool.icon
			icon_state = tool.icon_state
		..()

	onUpdate()
		..()
		if (get_dist(owner, target) > 1 || target == null || owner == null || tool == null)
			interrupt(INTERRUPT_ALWAYS)
			return

	onInterrupt(var/flag)
		..()
		boutput(owner, "<span style='color:red'>You were interrupted!</span>")
		if (tool)
			tool:in_use = 0

	onStart()
		..()
		if (get_dist(owner, target) > 1 || !ishuman(target) || owner == null || tool == null)
			interrupt(INTERRUPT_ALWAYS)
			return

		if (zone && surgery_status)
			duration = duration * surgery_status
			target.visible_message("<span style='color:blue'>[owner] begins [vrb]ing the surgical incisions on [owner == target ? his_or_her(owner) : "[target]'s"] [zone_sel2name[zone]] closed with [tool].</span>",\
			"<span style='color:blue'>[owner == target ? "You begin" : "[owner] begins"] [vrb]ing the surgical incisions on your [zone_sel2name[zone]] closed with [tool].</span>")
		else
			duration = duration * target.bleeding
			target.visible_message("<span style='color:blue'>[owner] begins [vrb]ing [owner == target ? his_or_her(owner) : "[target]'s"] wounds closed with [tool].</span>",\
			"<span style='color:blue'>[owner == target ? "You begin" : "[owner] begins"] [vrb]ing your wounds closed with [tool].</span>")

	onEnd()
		..()
		var/mob/ownerMob = owner
		if (owner && ownerMob && target && tool && tool == ownerMob.equipped() && get_dist(owner, target) <= 1)
			if (zone && surgery_status)
				target.visible_message("<span style='color:green'>[owner] [vrb]es the surgical incisions on [owner == target ? his_or_her(owner) : "[target]'s"] [zone_sel2name[zone]] closed with [tool].</span>",\
				"<span style='color:green'>[owner == target ? "You [vrb]e" : "[owner] [vrb]es"] the surgical incisions on your [zone_sel2name[zone]] closed with [tool].</span>")
				if (target.organHolder)
					if (zone == "chest")
						if (target.organHolder.heart)
							target.organHolder.heart.op_stage = 0.0
						if (target.organHolder.chest)
							target.organHolder.chest.op_stage = 0.0
						if (target.butt_op_stage)
							target.butt_op_stage = 0.0
						target.TakeDamage("chest", 2, 0)
					else if (zone == "head")
						if (target.organHolder.head)
							target.organHolder.head.op_stage = 0.0
						if (target.organHolder.skull)
							target.organHolder.skull.op_stage = 0.0
						if (target.organHolder.brain)
							target.organHolder.brain.op_stage = 0.0
				if (target.bleeding)
					repair_bleeding_damage(target, 100, repair_amount)
			else
				target.visible_message("<span style='color:green'>[owner] [vrb]es [owner == target ? "[his_or_her(owner)]" : "[target]'s"] wounds closed with [tool].</span>",\
				"<span style='color:green'>[owner == target ? "You [vrb]e" : "[owner] [vrb]es"] your wounds closed with [tool].</span>")
				repair_bleeding_damage(target, 100, repair_amount)
			if (zone && vrb == "bandag" && !target.bandaged.Find(zone))
				target.bandaged += zone
				target.update_body()
			if (istype(tool, /obj/item/suture))
				var/obj/item/suture/S = tool
				S.in_use = 0
			else if (istype(tool, /obj/item/bandage))
				var/obj/item/bandage/B = tool
				B.in_use = 0
				B.uses --
				B.update_icon()
			else if (istype(tool, /obj/item/material_piece/cloth))
				ownerMob.u_equip(tool)
				pool(tool)

/* =================================================== */
/* -------------------- Blood Bag -------------------- */
/* =================================================== */
/*
/obj/item/bloodbag
	name = "blood bag"
	desc = "A bag filled with donated O- blood. There's a fine needle at the end that can be used to transfer the blood to someone."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "bloodbag-10"
	inhand_image_icon = 'icons/mob/inhand/hand_medical.dmi'
	item_state = "bloodbag"
	flags = FPRINT | TABLEPASS
	w_class = 1.0
	force = 0
	throwforce = 1.0
	throw_speed = 4
	throw_range = 20
	stamina_damage = 0
	stamina_cost = 0
	stamina_crit_chance = 0
	var/volume = 100 // aaa why did they hold SO MUCH BLOOD??  500 IS THE SAME AS A PERSON WHY DID THEY HAVE A PERSON WORTH OF BLOOD IN THEM
	var/in_use = 0

	get_desc(dist)
		..()
		if (src.volume >= 0)
			switch (src.volume)
				if (-INFINITY to 0)
					. += "<span style='color:red'>It's empty.</span>"
				if (1 to 29)
					. += "<span style='color:red'>It's getting low.</span>"
				if (30 to 69)
					. += "Some of it's been used."
				if (70 to 99)
					. += "<span style='color:blue'>It's nearly full.</span>"
				if (100 to INFINITY)
					. += "<span style='color:blue'>It's full.</span>"

	attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
		if (volume <= 0)
			user.show_text("There's nothing left in [src]!", "red")
			return
		if (in_use)
			return
		if (ishuman(M))
			var/mob/living/carbon/human/H = M
			if (H.blood_volume < 500)
				H.tri_message("<span style='color:blue'><b>[user]</b> attaches [src]'s needle to [H == user ? </span>"[H.gender == "male" ? "his" : "her"]" : "[H]'s"] arm and begins transferring blood.",\
				user, "<span style='color:blue'>You attach [src]'s needle to [H == user ? </span>"your" : "[H]'s"] arm and begin transferring blood.",\
				H, "<span style='color:blue'>[H == user ? </span>"You attach" : "<b>[user]</b> attaches"] [src]'s needle to your arm and begin transferring blood.")
				src.in_use = 1
				for (var/i)
					if (H.blood_volume >= 500)
						H.visible_message("<span style='color:blue'><b>[H]</b>'s blood transfusion finishes.</span>", \
						"<span style='color:blue'>Your blood transfusion finishes.</span>")
						src.in_use = 0
						break
					if (src.volume <= 0)
						H.visible_message("<span style='color:red'><b>[src] runs out of blood!</b></span>")
						src.in_use = 0
						break
					if (get_dist(src, H) > 1)
						var/fluff = pick("pulled", "yanked", "ripped")
						H.visible_message("<span style='color:red'><b>[src]'s needle gets [fluff] out of [H]'s arm!</b></span>", \
						"<span style='color:red'><b>[src]'s needle gets [fluff] out of your arm!</b></span>")
						src.in_use = 0
						break
					else
						H.blood_volume ++
						src.volume --
						src.update_icon()
						if (prob(5))
							var/fluff = pick("better", "a little better", "a bit better", "warmer", "a little warmer", "a bit warmer", "less cold")
							H.visible_message("<span style='color:blue'><b>[H]</b> looks [fluff].</span>", \
							"<span style='color:blue'>You feel [fluff].</span>")
						sleep(5)
			else
				user.show_text("[H] already has enough blood!", "red")
				return
		else
			return ..()

	attackby(obj/item/W, mob/user)
		if (istype(W, /obj/item/reagent_containers/hypospray) || istype(W, /obj/item/reagent_containers/syringe) || istype(W, /obj/item/reagent_containers/emergency_injector))
			if (W.reagents && W.reagents.has_reagent("blood"))
				var/blood_volume = W.reagents.get_reagent_amount("blood")
				if (blood_volume < W.reagents.total_volume)
					user.show_text("This blood is impure!", "red")
					return
				else
					if (src.volume > 100 - W:amount_per_transfer_from_this)
						user.show_text("[src] is too full!", "red")
						return
					user.visible_message("<span style='color:blue'><b>[user]</b> transfers blood to [src].</span>", \
					"<span style='color:blue'>You transfer blood from [W] to [src].</span>")
					W.reagents.remove_reagent("blood", W:amount_per_transfer_from_this)
					src.volume += W:amount_per_transfer_from_this
					return
		else
			return ..()

	proc/update_icon()
		var/iv_state = max(min(round(src.volume, 10) / 10, 100), 0)
		icon_state = "bloodbag-[iv_state]"
/*		switch (src.volume)
			if (90 to INFINITY)
				src.icon_state = "bloodbag-10"
			if (80 to 89)
				src.icon_state = "bloodbag-9"
			if (70 to 79)
				src.icon_state = "bloodbag-8"
			if (60 to 69)
				src.icon_state = "bloodbag-7"
			if (50 to 59)
				src.icon_state = "bloodbag-6"
			if (40 to 49)
				src.icon_state = "bloodbag-5"
			if (30 to 39)
				src.icon_state = "bloodbag-4"
			if (20 to 29)
				src.icon_state = "bloodbag-3"
			if (10 to 19)
				src.icon_state = "bloodbag-2"
			if (1 to 9)
				src.icon_state = "bloodbag-1"
			if (-INFINITY to 0)
				src.icon_state = "bloodbag-0"
*/
*/
/* ================================================== */
/* -------------------- Body Bag -------------------- */
/* ================================================== */

/obj/item/body_bag
	name = "body bag"
	desc = "A heavy bag, used for carrying stuff around. The stuff is usually dead bodies. Hence the name."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "bodybag"
	uses_multiple_icon_states = 1
	flags = FPRINT | TABLEPASS
	w_class = 1.0
	force = 0
	throwforce = 1.0
	throw_speed = 4
	throw_range = 20
	stamina_damage = 0
	stamina_cost = 0
	stamina_crit_chance = 0
	var/open = 0
	var/image/open_image = null
	var/sound_zipper = 'sound/items/zipper.ogg'

	New()
		..()
		src.open_image = image(src.icon, src, "bodybag-open1", EFFECTS_LAYER_BASE)

	disposing()
		for(var/atom/movable/AM in src)
			AM.set_loc(src.loc)
		..()

	proc/update_icon()
		if (src.open && src.open_image)
			src.overlays += src.open_image
			src.icon_state = "bodybag-open"
			src.w_class = 4.0
		else if (!src.open)
			src.overlays -= src.open_image
			if (src.contents && src.contents.len)
				src.icon_state = "bodybag-closed1"
			else
				src.icon_state = "bodybag-closed0"
			src.w_class = 4.0
		else
			src.overlays -= src.open_image
			src.icon_state = "bodybag"
			src.w_class = 1.0

	attack_self(mob/user as mob)
		if (src.icon_state == "bodybag" && src.w_class == 1.0)
			user.visible_message("<b>[user]</b> unfolds [src].",\
			"You unfold [src].")
			user.drop_item()
			src.update_icon()
		else
			return

	attack_hand(mob/user as mob)
		add_fingerprint(user)
		if (src.icon_state == "bodybag" && src.w_class == 1.0)
			return ..()
		else
			if (src.open)
				src.close()
			else
				src.open()
			return

	relaymove(mob/user as mob)
		if (user.stat)
			return
		if (prob(75))
			user.show_text("You fuss with [src], trying to find the zipper, but it's no use!", "red")
			for (var/mob/M in hearers(src, null))
				M.show_text("<FONT size=[max(0, 5 - get_dist(src, M))]>...rustle...</FONT>")
			return
		src.open()
		src.visible_message("<span style='color:red'><b>[user]</b> unzips themselves from [src]!</span>")

	MouseDrop(mob/user as mob)
		..()
		if (!(src.contents && src.contents.len) && (usr == user && !usr.restrained() && !usr.stat && in_range(src, usr) && !issilicon(usr)))
			if (src.icon_state != "bodybag")
				usr.visible_message("<b>[usr]</b> folds up [src].",\
				"You fold up [src].")
			src.overlays -= src.open_image
			src.icon_state = "bodybag"
			src.w_class = 1.0
			src.attack_hand(usr)

	proc/open()
		playsound(get_turf(src), src.sound_zipper, 100, 1, , 6)
		for (var/obj/O in src)
			O.set_loc(get_turf(src))
		for (var/mob/M in src)
			M.changeStatus("weakened", 2 SECONDS)
			SPAWN_DBG(3)
				M.set_loc(get_turf(src))
		src.open = 1
		src.update_icon()

	proc/close()
		playsound(get_turf(src), src.sound_zipper, 100, 1, , 6)
		for (var/obj/O in get_turf(src))
			if (O.density || O.anchored || O == src)
				continue
			O.set_loc(src)
		for (var/mob/M in get_turf(src))
			if (!M.lying || M.anchored || M.buckled)
				continue
			M.set_loc(src)
		src.open = 0
		src.update_icon()

/* ================================================== */
/* -------------------- Hemostat -------------------- */
/* ================================================== */

/obj/item/hemostat
	name = "hemostat"
	desc = "A surgical tool used for the control and reduction of bleeding during surgery."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "hemostat"
	inhand_image_icon = 'icons/mob/inhand/hand_medical.dmi'
	item_state = "hemostat"
	flags = FPRINT | TABLEPASS | CONDUCT | ONBELT
	hit_type = DAMAGE_STAB
	hitsound = 'sound/impact_sounds/Flesh_Stab_1.ogg'
	force = 1.5
	w_class = 1.0
	throwforce = 3.0
	throw_speed = 3
	throw_range = 6
	m_amt = 7000
	g_amt = 3500
	stamina_damage = 2
	stamina_cost = 2
	stamina_crit_chance = 15
	module_research = list("tools" = 2, "medicine" = 3, "weapons" = 0.1)
	hide_attack = 2

	attack(mob/M as mob, mob/user as mob)
		if (!ishuman(M))
			if (user.a_intent == INTENT_HELP)
				return
			return ..()
		var/mob/living/carbon/human/H = M
		var/surgery_status = H.get_surgery_status(user.zone_sel.selecting)
		if (!surgery_status)
			if (user.a_intent == INTENT_HELP)
				return
			return ..()
		if (!surgeryCheck(H, user))
			if (user.a_intent == INTENT_HELP)
				return
			return ..()
		H.tri_message("<span style='color:red'><b>[user]</b> begins clamping the bleeders in [H == user ? "[his_or_her(H)]" : "[H]'s"] incision with [src].</span>",\
		user, "<span style='color:red'>You begin clamping the bleeders in [user == H ? "your" : "[H]'s"] incision with [src].</span>",\
		H, "<span style='color:red'>[H == user ? "You begin" : "<b>[user]</b> begins"] clamping the bleeders in your incision with [src].</span>")

		if (!do_mob(user, H, CLAMP(surgery_status * 4, 0, 100)))
			user.visible_message("<span style='color:red'><b>[user]</b> was interrupted!</span>",\
			"<span style='color:red'>You were interrupted!</span>")
			return

		H.tri_message("<span style='color:blue'><b>[user]</b> clamps the bleeders in [H == user ? "[his_or_her(H)]" : "[H]'s"] incision with [src].</span>",\
		user, "<span style='color:blue'>You clamp the bleeders in [user == H ? "your" : "[H]'s"] incision with [src].</span>",\
		H, "<span style='color:blue'>[H == user ? "You clamp" : "<b>[user]</b> clamps"] the bleeders in your incision with [src].</span>")

		if (H.bleeding)
			repair_bleeding_damage(H, 50, rand(2,5))
		return

/* ======================================================= */
/* -------------------- Reflex Hammer -------------------- */
/* ======================================================= */
/*
/obj/item/tinyhammer/attack(mob/M as mob, mob/user as mob, def_zone) // the rest of this is defined in shipalert.dm
	// todo: give people's limbs the ol' tappa tappa
	// also make sure intent, force and armor matter
	if (!def_zone)
		def_zone = (user && user.zone_sel && user.zone_sel.selecting) ? user.zone_sel.selecting : "chest" // may as well default to head idk

	var/my_damage = src.force
	var/my_sound = "sound/impact_sounds/Generic_Stab_1.ogg"
	var/clumsy = 0 // time to be rude :T
	var/doctor = 0

	if (user.bioHolder)
		if (user.bioHolder.HasEffect("clumsy"))
			clumsy = 1
		if (user.get_brain_damage() >= 60) // little bit of a gibbering mess
			clumsy = 1
		if (user.traitHolder.hasTrait("training_medical") && user.a_intent != INTENT_HARM)
			doctor = 1

	if (ishuman(M)) // tappa tappa
		var/mob/living/carbon/human/H = M
		switch (def_zone)
			if ("head")
				if (!H.get_organ("head")) // ain't got NO HEAD TO TAP, WHAT YOU TRYIN TO PULL HERE SON
					H.visible_message("[user][doctor ? " gently" : null] swings [src] at [H == user ? "[his_or_her(H)] own" : "[H]'s"] head, <span style='color:red;font-weight:bold'>but [H == user ? he_or_she(H) : H] has no head to tap!</span>[H == user ? " How did [he_or_she(H)] even pull that off?!" : null]")
					my_damage = 0
					my_sound = "sound/impact_sounds/Generic_Swing_1.ogg"

				else if (clumsy && !doctor && prob(1)) // extreme clumsiness can lead to extremely unintended examination results
					var/obj/item/organ/head/head = H.drop_organ("head")
					H.visible_message("<span style='color:red;font-weight:bold'>[user] swings [src] way too hard at [H == user ? "[his_or_her(H)] own" : "[H]'s"] head and hits it clean off [H == user ? "[his_or_her(H)] own" : "[H]'s"] shoulders!</span>")
					playsound(get_turf(H), "sound/impact_sounds/Flesh_Stab_1.ogg", 80, 1)
					if (head)
						head.throw_at(get_dir(user, H), 3, 3)
					return

				else if (clumsy && prob(33)) // WHACK
					H.visible_message("<span style='color:red;font-weight:bold'>[user] swings [src] way too hard at [H == user ? "[his_or_her(H)] own" : "[H]'s"] head!</span>")
					playsound(get_turf(H), "sound/impact_sounds/Generic_Hit_1.ogg", 80, 1)
					my_damage = (max(my_damage, 2) * 3)

				else if (!headSurgeryCheck(H))
					H.visible_message("[user][doctor ? " gently" : null] taps [H == user ? "[him_or_her(H)]self" : H] on the head with [src].<br>&emsp;You can't tell how [H]'s head sounds because of [H]'s headgear!")
					my_damage = 0

				else if (!H.get_organ("brain")) // no brain, hollow head
					H.visible_message("[user][doctor ? " gently" : null] taps [H == user ? "[him_or_her(H)]self" : H] on the head with [src].<br>&emsp;[H]'s head sounds hollow.")

				else // all is normal
					H.visible_message("[user][doctor ? " gently" : null] taps [H == user ? "[him_or_her(H)]self" : H] on the head with [src].<br>&emsp;[H]'s head sounds normal.")
/*
			if ("l_arm","r_arm")
				var/obj/item/parts/my_arm
				if (H.limbs)

				if (!H.limbs || !H.
*/
		H.TakeDamage(def_zone, my_damage)
		playsound(get_turf(H), my_sound, 80, 1)
		return

	//else if (isrobot(M)) // clonk clonk
		//var/mob/living/silicon/robot/R = M
*/
/obj/item/tinyhammer/reflex
	name = "reflex hammer"
	desc = "A tiny hammer used for testing deep tendon reflexes."
	force = 0
	throwforce = 1
	stamina_damage = 1
	stamina_cost = 1
	stamina_crit_chance = 1
	module_research = list("tools" = 2, "medicine" = 2, "weapons" = 0.1)

	New()
		..()
		src.setMaterial(getMaterial("synthrubber"))

/* ================================================== */
/* -------------------- Penlight -------------------- */
/* ================================================== */

/obj/item/device/light/flashlight/penlight
	name = "penlight"
	desc = "A small light used for testing photopupillary reflexes."
	icon_state = "penlight0"
	item_state = "pen"
	icon_on = "penlight1"
	icon_off = "penlight0"
	w_class = 1.0
	throwforce = 0
	throw_speed = 7
	throw_range = 15
	m_amt = 50
	g_amt = 10
	mats = 1
	col_r = 0.9
	col_g = 0.8
	col_b = 0.7
	brightness = 0.5
	module_research = list("science" = 1, "devices" = 1, "medicine" = 2)
	var/anim_duration = 10 // testing var so I can adjust in-game to see what looks nice

	attack(mob/M as mob, mob/user as mob, def_zone)
		// todo: check zone, make sure people are shining the light 1) at a human 2) in the eyes, clauses for whatever else
		if (!def_zone && user && user.zone_sel && user.zone_sel.selecting)
			def_zone = user.zone_sel.selecting
		else if (!def_zone)
			return ..()

		if (user.bioHolder && user.bioHolder.HasEffect("clumsy") && prob(33))
			M = user // hold the pen the right way, dingus!

		if (!src.on || def_zone != "head")
			M.tri_message("[user] wiggles [src] at [M == user ? "[his_or_her(user)] own" : "[M]'s"] [zone_sel2name[def_zone]].[!src.on ? " \The [src] isn't on, so it doesn't do much." : null]",\
			user, "You wiggle [src] at [M == user ? "your own" : "[M]'s"] [zone_sel2name[def_zone]].[!src.on ? " \The [src] isn't on, so it doesn't do much." : null]",\
			M, "[M == user ? "You wiggle" : "<b>[user]</b> wiggles"] [src] at your[M == user ? " own" : null] [zone_sel2name[def_zone]].[!src.on ? " \The [src] isn't on, so it doesn't do much." : null]")
			return

		var/results_msg = "&emsp;Nothing happens." // shown to everyone but the target (you can't see your own eyes!! also we have no mirrors)

		if (ishuman(M))
			var/mob/living/carbon/human/H = M

			if (!H.blinded) // can't see the light if you can't see shit else!!
				H.vision.flash(src.anim_duration)

			if (istype(H.glasses) && !istype(H.glasses, /obj/item/clothing/glasses/regular) && H.glasses.c_flags & COVERSEYES) // check all the normal things that could cover eyes
				results_msg = "&emsp;<span style='color:red'>It's hard to accurately judge how [H]'s eyes reacted through [his_or_her(H)] [H.glasses.name]!</span>"
			else if (istype(H.wear_mask) && H.wear_mask.c_flags & COVERSEYES)
				results_msg = "&emsp;<span style='color:red'>It's hard to accurately judge how [H]'s eyes reacted through [his_or_her(H)] [H.wear_mask.name]!</span>"
			else if (istype(H.head) && H.head.c_flags & COVERSEYES)
				results_msg = "&emsp;<span style='color:red'>It's hard to accurately judge how [H]'s eyes reacted through [his_or_her(H)] [H.head.name]!</span>"
			else if (istype(H.wear_suit) && H.wear_suit.c_flags & COVERSEYES)
				results_msg = "&emsp;<span style='color:red'>It's hard to accurately judge how [H]'s eyes reacted through [his_or_her(H)] [H.wear_suit.name]!</span>"

			else // okay move on to actual diagnostic stuff
				var/obj/item/organ/eye/leye = H.get_organ("left_eye")
				var/obj/item/organ/eye/reye = H.get_organ("right_eye")
				var/His_Her = capitalize(his_or_her(H))
				var/He_She = capitalize(he_or_she(H))

				if (!leye && !reye) // oops, we uhh can't test reflexes if there's no eyes
					results_msg = "&emsp;<span style='color:red'>Nothing happens because [he_or_she(H)] <b>has no eyes!</b></span>"
				else
					var/lmove = null // left movement
					//var/lpupil = null // left pupil dialation/constriction
					var/lpstatus = null // left pupil dialation/constriction
					var/lpreact = null // left pupil light reaction
					var/rmove = null // right movement
					//var/rpupil = null // right pupil dialation/constriction
					var/rpstatus = null // right pupil dialation/constriction
					var/rpreact = null // right pupil light reaction

					if (H.reagents)
						var/list/con_reagents = list("morphine", "space_drugs") // drugs that cause pupil constriction
						var/list/dia_reagents = list("atropine", "antihistamine", "methamphetamine", "crank", "bathsalts", "catdrugs") // drugs that cause pupil dialation (todo: finish cocaine and add it here)
						var/list/both_reagents = con_reagents + dia_reagents

						var/datum/reagent/BIGR = null // the for() below will look for the BIGGEST CHEM from the lists, and we'll use that to determine the messages given
						for (var/current_id in H.reagents.reagent_list)
							if (!H || !H.reagents || !H.reagents.reagent_list)
								break
							if (!both_reagents.Find(current_id)) // not something we care about
								continue
							var/datum/reagent/R = H.reagents.reagent_list[current_id]
							if (!istype(R))
								continue
							if (!BIGR || BIGR.volume < R.volume)
								BIGR = R
						if (BIGR)
							var/con_or_dia = con_reagents.Find(BIGR.id) ? "constricted" : "dialated"
							if (BIGR.overdose <= BIGR.volume) // we're oding, messages should be more severe
								con_or_dia = "very " + con_or_dia
							if (leye)
								lpstatus = " The pupil is [con_or_dia] and "
								lpreact = "doesn't react to the light much."
							if (reye)
								rpstatus = " The pupil is [con_or_dia] and "
								rpreact = "doesn't react to the light much."

					// unilateral mydriasis (blown pupil) can be a sign of abnormally high intracranial pressure, aka brain has an ouchie :(
					// will show up for active bloot clots (stroke) as an injury to the right side of the brain, and left for brain damage (since injuries to the left side can cause slurring, or in our case, gibbering)
					// irl these things can affect either side of the brain but this will help differentiate them in a video game context I think
					// (also: injuries to the brain show up as issues on the opposite side of the body, so a left injury affects the right eye, etc)
					var/datum/ailment_data/malady/AD = H.find_ailment_by_type(/datum/ailment/malady/bloodclot)
					if (AD && AD.state == "Active" && AD.affected_area == "head") // having a stroke!!
						if (leye)
							lmove = "[His_Her] left eye doesn't follow the light at all!"
							lpreact = "doesn't react to the light at all!"

					var/the_brain = H.get_organ("brain") // don't need to know anything about it other than "is it there?"
					var/braind = H.get_brain_damage()
					if (!the_brain || isnum(braind))
						if (!the_brain || braind >= 100) // braindead as heck
							if (leye) lmove = "[His_Her] left eye doesn't follow the light at all!"
							if (reye) rmove = "[His_Her] right eye doesn't follow the light at all!"
							if (!the_brain)
								if (leye) lpreact = "doesn't react to the light at all!"
								if (reye) rpreact = "doesn't react to the light at all!"
						else if (braind >= 60) // when one becomes a gibbering mess
							if (reye)
								rmove = "[His_Her] right eye doesn't follow the light at all!"
								rpstatus = " The pupil is very dialated and "
								rpreact = "doesn't react to the light at all!"
						else if (braind >= 35) // mid point where things are gettin serious
							if (reye)
								rmove = "[His_Her] right eye doesn't follow the light well."
								rpstatus = " The pupil is dialated and "
								rpreact = "doesn't react to the light much."
						else if (braind >= 10) // mild damage like a concussion
							if (reye) rpstatus = " The pupil is slightly dialated and "

					if (!leye)
						lmove = "<span style='color:red'>[He_She] has no left eye!</span>"
						lpstatus = null
						lpreact = null
					else
						if (!lmove) lmove = "[His_Her] left eye follows the light easily."
						if (!lpstatus) lpstatus = " The pupil "
						if (!lpreact) lpreact = "constricts normally."

					if (!reye)
						rmove = "<span style='color:red'>[He_She] has no right eye!</span>"
						rpstatus = null
						rpreact = null
					else
						if (!rmove) rmove = "[His_Her] right eye follows the light easily."
						if (!rpstatus) rpstatus = " The pupil "
						if (!rpreact) rpreact = "constricts normally."

					results_msg = "&emsp;[lmove][lpstatus][lpreact]<br>&emsp;[rmove][rpstatus][rpreact]"

		else if (isliving(M)) // other mooooooobs
			var/mob/living/L = M
			L.vision.flash(src.anim_duration)

		M.tri_message("[user] shines [src] in [M == user ? "[his_or_her(user)] own" : "[M]'s"] eyes.[results_msg ? "<br>[results_msg]" : null]",\
		user, "You shine [src] in [M == user ? "your own" : "[M]'s"] eyes.[(M != user && results_msg) ? "<br>[results_msg]" : null]",\
		M, "[M == user ? "You shine" : "<b>[user]</b> shines"] [src] in your[M == user ? " own" : null] eyes.")

/* ====================================================== */
/* -------------------- Surgery Tray -------------------- */
/* ====================================================== */

/obj/surgery_tray
	name = "tray"
	desc = "A lightweight tray with little wheels on it. You can place stuff on this and then move the stuff elsewhere! Isn't that totally amazing??"
	icon = 'icons/obj/surgery.dmi'
	icon_state = "tray"
	density = 1
	anchored = 0
	var/list/stuff_to_move = null
	var/max_to_move = 10
	p_class = 1.5

/* this worked but it kinda scooped things up when the tray passed over them (which was hilarious but also not so great, gameplay-wise)
keeping this here because I want to make something else with it eventually
	Move(NewLoc,Dir)
		var/list/bring_this_stuff
		if (isturf(src.loc))
			bring_this_stuff = src.loc.contents.Copy()
		. = ..()
		if (.)
			if (prob(75))
				playsound(get_turf(src), "sound/misc/chair/office/scoot[rand(1,5)].ogg", 40, 1)
			if (islist(bring_this_stuff) && bring_this_stuff.len)
				var/stuff_moved = 0
				for (var/obj/item/I in bring_this_stuff)
					LAGCHECK(LAG_HIGH)
					if (I.anchored || I.layer < src.layer)
						continue
					stuff_moved++
					I.Move(NewLoc,Dir)
					if (stuff_moved >= src.max_to_move)
						break
*/

	New()
		..()
		if (!ticker) // pre-roundstart, this is a thing made on the map so we want to grab whatever's been placed on top of us automatically
			SPAWN_DBG(0)
				var/stuff_added = 0
				for (var/obj/item/I in src.loc.contents)
					if (I.anchored || I.layer < src.layer)
						continue
					else
						src.contents += I
						src.vis_contents += I
						stuff_added++
						if (stuff_added >= src.max_to_move)
							break

 	//this might not be necessary, I'm not sure. but it can't hurt
	Del()
		src.vis_contents = null
		src.contents = null

	Move(NewLoc,Dir)
		. = ..()
		if (.)
			if (prob(75))
				playsound(get_turf(src), "sound/misc/chair/office/scoot[rand(1,5)].ogg", 40, 1)

			//if we're over the max amount a table can fit, have a chance to drop an item. Chance increases with items on tray
			if (prob((src.contents.len-max_to_move)*1.1))
				var/obj/item/falling = pick(src.contents)
				// src.visible_message("[falling] falls off of [src]!")
				var/target = get_offset_target_turf(get_turf(src), rand(5)-rand(5), rand(5)-rand(5))
				falling.set_loc(get_turf(src))
				src.vis_contents -= falling

				SPAWN_DBG(1)
					if(falling)
						falling.throw_at(target, 1, 1)


	attackby(obj/item/W as obj, mob/user as mob, params)
		if (iswrenchingtool(W))
			actions.start(new /datum/action/bar/icon/furniture_deconstruct(src, W, 30), user)
			return
		else if (src.place_on(W, user, params))
			user.show_text("You place [W] on [src].")
			src.vis_contents += W
			W.set_loc(src)
			return
		else
			return ..()

	hitby(atom/movable/AM as mob|obj)
		..()
		if (isitem(AM))
			src.visible_message("[AM] lands on [src]!")
			src.vis_contents += AM
			AM.set_loc(src)


	proc/deconstruct()
		var/obj/item/furniture_parts/surgery_tray/P = new /obj/item/furniture_parts/surgery_tray(src.loc)
		if (P && src.material)
			P.setMaterial(src.material)
		for (var/obj/i in src.contents)
			i.set_loc(src.loc)
		qdel(src)
		return

/* ---------- Surgery Tray Parts ---------- */
/obj/item/furniture_parts/surgery_tray
	name = "tray parts"
	desc = "A collection of parts that can be used to make a tray."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "tray_parts"
	stamina_damage = 15
	stamina_cost = 15
	furniture_type = /obj/surgery_tray
	furniture_name = "tray"
	build_duration = 30

/* ================================================== */
/* -------------- Surgical Scissors ----------------- */
/* ================================================== */

/obj/item/scissors/surgical_scissors
	// name = "Garden Snips"
	name = "Surgical Scissors"
	desc = "Used for precisely cutting up people in surgery. I guess you could use them on paper too."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "surgical-scissors-base"
	inhand_image_icon = 'icons/mob/inhand/hand_medical.dmi'
	item_state = "surgical_scissors"

	flags = FPRINT | TABLEPASS | CONDUCT
	tool_flags = TOOL_SNIPPING
	force = 8.0
	stamina_damage = 5
	stamina_cost = 5
	stamina_crit_chance = 35
	w_class = 1.0
	hit_type = DAMAGE_STAB
	hitsound = 'sound/impact_sounds/Flesh_Cut_1.ogg'

	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	var/mob/Poisoner = null
	module_research = list("tools" = 3, "medicine" = 3, "weapons" = 0.25)
	var/image/handle = null

	New()
		..()
		src.create_reagents(5)
		handle = image('icons/obj/surgery.dmi', "")
		if (prob(1) && prob(10))	// 1:1000 chance
			handle.icon_state = "surgical-scissors-handle-c"
			desc = "Used for precisely cutting up people in surgery. I guess you could use them on paper too... There's something off about this pair."
		else
			handle.icon_state = "surgical-scissors-handle"
			handle.color = "#[random_hex(6)]"

		src.overlays += handle

	disposing()
		handle = null
		Poisoner = null
		..()