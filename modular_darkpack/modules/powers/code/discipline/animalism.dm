/datum/discipline/animalism
	name = "Анимализм"
	desc = {"Призывает призрачных зверей и натравливает их на ваших врагов. Нарушает Маскарад.
● Призыв крысы: пассивно
●● Призыв кошки: пассивно
●●● Призыв волка: пассивно
●●●● Призыв летучей мыши: пассивно
●●●●● Крысиный облик: пассивно"}
	id = DISCIPLINE_ANIMALISM
	icon_state = "animalism"
	power_type = /datum/discipline_power/animalism

/datum/discipline_power/animalism
	name = "Animalism power name"
	desc = "Animalism power description"
	effect_sound = 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/gifts/wolves.ogg'

//SUMMON RAT
/datum/discipline_power/animalism/summon_rat
	name = "Призыв крысы"
	desc = "Призовите призрачную крысу, послушную вашей воле."
	level = 1
	violates_masquerade = TRUE
	cooldown_length = 8 SECONDS
	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE | DISC_CHECK_LYING

/datum/discipline_power/animalism/summon_rat/activate()
	. = ..()
	owner.add_beastmaster_minion(/mob/living/basic/mouse/vampire/summoned)

//SUMMON CAT
/datum/discipline_power/animalism/summon_cat
	name = "Призыв кошки"
	desc = "Призовите призрачную кошку, послушную вашей воле."
	level = 2
	violates_masquerade = TRUE
	cooldown_length = 8 SECONDS
	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE | DISC_CHECK_LYING

/datum/discipline_power/animalism/summon_cat/activate()
	. = ..()
	owner.add_beastmaster_minion(/mob/living/basic/pet/cat/darkpack/summoned)

//SUMMON WOLF
/datum/discipline_power/animalism/summon_wolf
	name = "Призыв волка"
	desc = "Призовите призрачного волка, послушного вашей воле."
	level = 3
	violates_masquerade = TRUE
	cooldown_length = 8 SECONDS
	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE | DISC_CHECK_LYING

/datum/discipline_power/animalism/summon_wolf/activate()
	. = ..()
	owner.add_beastmaster_minion(/mob/living/basic/pet/dog/wolf/summoned)

//SUMMON BAT
/datum/discipline_power/animalism/summon_bat
	name = "Призыв летучей мыши"
	desc = "Призовите призрачную летучую мышь, послушную вашей воле."
	level = 4
	violates_masquerade = TRUE
	cooldown_length = 8 SECONDS
	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE | DISC_CHECK_LYING

/datum/discipline_power/animalism/summon_bat/activate()
	. = ..()
	owner.add_beastmaster_minion(/mob/living/basic/bat/summoned)

/datum/action/cooldown/spell/shapeshift/animalism
	name = "Звериный облик"
	desc = "Примите облик крысы."
	button_icon_state = "shapeshift"
	cooldown_time = 5 SECONDS
	spell_requirements = NONE
	revert_on_death = TRUE
	die_with_shapeshifted_form = FALSE
	convert_damage = TRUE
	convert_damage_type = BRUTE
	shapeshift_type = /mob/living/basic/mouse/vampire
	possible_shapes = list(/mob/living/basic/mouse/vampire)

//RAT SHAPESHIFT
/datum/discipline_power/animalism/rat_shapeshift	// CORVAX EDIT FULL DISCIPLINE
	name = "Крысиный облик"
	desc = "Станьте одной из крыс, что снуют под городом."
	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE | DISC_CHECK_LYING
	level = 5
	violates_masquerade = TRUE

	// Как у Celerity: одна и та же схема снятия крови и таймера
	toggled = TRUE
	duration_length = 2 TURNS
	cooldown_length = 8 SECONDS

	var/mob/living/basic/mouse/vampire/rat_form
	var/obj/effect/rat_shapeshift_holder/holder

/datum/discipline_power/animalism/rat_shapeshift/pre_activation_checks(atom/target)
	. = ..()
	if(!.)
		return FALSE
	if(!ishuman(owner) || !owner.mind)
		if(owner)
			to_chat(owner, span_warning("Вы не можете принять крысиный облик сейчас!"))
		return FALSE
	if(rat_form || holder)
		return FALSE
	return TRUE

/datum/discipline_power/animalism/rat_shapeshift/activate(atom/target)
	. = ..()
	if(!. )
		return

	rat_form = new /mob/living/basic/mouse/vampire(get_turf(owner))
	rat_form.pass_flags = PASSTABLE|PASSGRILLE|PASSMOB|PASSSTRUCTURE
	ADD_TRAIT(rat_form, TRAIT_TRUE_NIGHT_VISION, SPECIES_TRAIT)

	holder = new /obj/effect/rat_shapeshift_holder(get_turf(owner))
	owner.forceMove(holder)
	animate(owner, color = "#000000", time = 3 SECONDS, loop = 1, alpha = 10)
	owner.invisibility = INVISIBILITY_ABSTRACT

	owner.mind.transfer_to(rat_form)
	transfer_actions(rat_form, owner)

	owner.clear_alert(DISCIPLINE_ACTIVE_ALERT(src))
	var/atom/movable/screen/alert/discipline_active/indicator = rat_form.throw_alert(DISCIPLINE_ACTIVE_ALERT(src), /atom/movable/screen/alert/discipline_active)
	if(istype(indicator))
		indicator.set_power(src)
	rat_form.update_action_buttons()

	RegisterSignal(rat_form, COMSIG_LIVING_DEATH, PROC_REF(on_rat_death))

/datum/discipline_power/animalism/rat_shapeshift/deactivate(atom/target, direct = FALSE)
	. = ..()

	if(!rat_form || QDELETED(rat_form))
		return

	UnregisterSignal(rat_form, COMSIG_LIVING_DEATH)
	rat_form.clear_alert(DISCIPLINE_ACTIVE_ALERT(src))

	var/turf/landing = get_turf(rat_form)

	if(rat_form.mind)
		rat_form.mind.transfer_to(owner)
	transfer_actions(rat_form, owner)
	QDEL_NULL(rat_form)

	if(!QDELETED(owner))
		if(landing)
			owner.forceMove(landing)
		else if(holder)
			owner.forceMove(get_turf(holder))

		owner.invisibility = 0
		owner.update_action_buttons()
		animate(owner, color = initial(owner.color), time = 1.5 SECONDS, loop = 1, alpha = 255)
		owner.Stun(1.5 SECONDS)

	if(holder)
		QDEL_NULL(holder)

/datum/discipline_power/animalism/rat_shapeshift/proc/on_rat_death()
	SIGNAL_HANDLER
	try_deactivate(direct = TRUE)

/datum/discipline_power/animalism/rat_shapeshift/proc/transfer_actions(mob/source_mob, mob/dest_mob)
	if(!source_mob || !dest_mob)
		return
	for(var/datum/action/A in source_mob.actions.Copy())
		A.Remove(source_mob)
		A.Grant(dest_mob)

/obj/effect/rat_shapeshift_holder
	name = "shapeshift holder"
	invisibility = INVISIBILITY_ABSTRACT
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	anchored = TRUE
// CORVAX EDIT END

/mob/living/basic/mouse/vampire/summoned
	name = "rat"
	desc = "Крыса, покорная воле хозяина."
	ai_controller = /datum/ai_controller/basic_controller/beastmaster_summon
	melee_damage_lower = 3
	melee_damage_upper = 8
	obj_damage = 10
	bloodpool = 2

/mob/living/basic/mouse/vampire/summoned/Initialize(mapload)
	AddElement(/datum/element/ai_retaliate)
	. = ..()

/mob/living/basic/pet/cat/darkpack/summoned
	name = "cat"
	desc = "Кошка, покорная воле хозяина."
	ai_controller = /datum/ai_controller/basic_controller/beastmaster_summon
	melee_damage_lower = 5
	melee_damage_upper = 12
	obj_damage = 15
	bloodpool = 2

/mob/living/basic/pet/dog/wolf/summoned
	name = "wolf"
	desc = "Волк, покорный воле хозяина."
	ai_controller = /datum/ai_controller/basic_controller/beastmaster_summon
	basic_mob_flags = DEL_ON_DEATH
	mob_biotypes = MOB_ORGANIC
	speed = 0.35
	maxHealth = 80
	health = 80
	melee_damage_lower = 10
	melee_damage_upper = 20
	obj_damage = 20
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'modular_darkpack/modules/deprecated/sounds/dog.ogg'
	random_wolf_color = FALSE
	bloodpool = 2

/mob/living/basic/bat/summoned
	name = "bat"
	desc = "Летучая мышь, покорная воле хозяина."
	ai_controller = /datum/ai_controller/basic_controller/beastmaster_summon
	melee_damage_lower = 4
	melee_damage_upper = 10
	obj_damage = 10
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	bloodpool = 2
