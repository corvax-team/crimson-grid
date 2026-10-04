// Surgical analog to manual dislocation treatment
/datum/surgery_operation/limb/repair_dislocation
	name = "Вправление вывиха"
	desc = "Вправление вывихнутого сустава. \
		То же, что делают в полевых условиях, только быстрее и безопаснее, потому что обстановка под контролем."
	operation_flags = OPERATION_PRIORITY_NEXT_STEP | OPERATION_NO_PATIENT_REQUIRED | OPERATION_AFFECTS_MOOD | OPERATION_STANDING_ALLOWED | OPERATION_IGNORE_CLOTHES
	implements = list(
		TOOL_BONESET = 1,
		TOOL_CROWBAR = 2,
		IMPLEMENT_HAND = 5,
	)
	time = 2.4 SECONDS

/datum/surgery_operation/limb/repair_dislocation/get_time_modifiers(obj/item/bodypart/limb, mob/living/surgeon, tool)
	. = ..()
	for(var/datum/wound/blunt/bone/bone_wound in limb.wounds)
		if(HAS_TRAIT(bone_wound, TRAIT_WOUND_SCANNED) && (TOOL_BONESET in bone_wound.treatable_tools))
			. *= 0.5

/datum/surgery_operation/limb/repair_dislocation/get_default_radial_image()
	return image(/obj/item/bonesetter)

/datum/surgery_operation/limb/repair_dislocation/all_required_strings()
	return list("конечность должна быть вывихнута") + ..()

/datum/surgery_operation/limb/repair_dislocation/state_check(obj/item/bodypart/limb)
	for(var/datum/wound/blunt/bone/bone_wound in limb.wounds)
		if(TOOL_BONESET in bone_wound.treatable_tools)
			return TRUE

	return FALSE

/datum/surgery_operation/limb/repair_dislocation/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("Вы начинаете вправлять вывих [FORMAT_LIMB_OWNER_RU(limb, GENITIVE)]..."),
		span_notice("[capitalize(surgeon.declent_ru(NOMINATIVE))] начинает вправлять вывих [FORMAT_LIMB_OWNER_RU(limb, GENITIVE)]."),
		span_notice("[capitalize(surgeon.declent_ru(NOMINATIVE))] начинает вправлять вывих [FORMAT_LIMB_OWNER_RU(limb, GENITIVE)]."),
	)
	display_pain(limb.owner, "[capitalize(limb.ru_plaintext_zone[NOMINATIVE] || limb.plaintext_zone)] ноет от боли!")

/datum/surgery_operation/limb/repair_dislocation/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	for(var/datum/wound/blunt/bone/bone_wound in limb.wounds)
		if(TOOL_BONESET in bone_wound.treatable_tools)
			qdel(bone_wound)

	display_results(
		surgeon,
		limb.owner,
		span_notice("Вы успешно вправляете вывих [FORMAT_LIMB_OWNER_RU(limb, GENITIVE)]."),
		span_notice("[capitalize(surgeon.declent_ru(NOMINATIVE))] успешно вправляет вывих [FORMAT_LIMB_OWNER_RU(limb, GENITIVE)]!"),
		span_notice("[capitalize(surgeon.declent_ru(NOMINATIVE))] успешно вправляет вывих [FORMAT_LIMB_OWNER_RU(limb, GENITIVE)]!"),
	)
	display_pain(limb.owner, "Боль отпускает: [limb.ru_plaintext_zone[NOMINATIVE] || limb.plaintext_zone] больше не беспокоит!")

/datum/surgery_operation/limb/repair_dislocation/on_failure(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("Вправить вывих [FORMAT_LIMB_OWNER_RU(limb, GENITIVE)] не удалось, вы только усугубили травму!"),
		span_notice("[capitalize(surgeon.declent_ru(NOMINATIVE))] не справляется с вывихом [FORMAT_LIMB_OWNER_RU(limb, GENITIVE)] и только усугубляет травму!"),
		span_notice("[capitalize(surgeon.declent_ru(NOMINATIVE))] не справляется с вывихом [FORMAT_LIMB_OWNER_RU(limb, GENITIVE)]!"),
	)
	display_pain(limb.owner, "Боль усиливается: [limb.ru_plaintext_zone[NOMINATIVE] || limb.plaintext_zone]!")
	limb.receive_damage(25, damage_source = tool)

/datum/surgery_operation/limb/repair_hairline
	name = "Сращивание трещины"
	desc = "Заживление трещины в кости пациента."
	operation_flags = OPERATION_PRIORITY_NEXT_STEP | OPERATION_NO_PATIENT_REQUIRED
	implements = list(
		TOOL_BONESET = 1,
		/obj/item/stack/medical/bone_gel = 1,
		/obj/item/stack/medical/wrap/sticky_tape/surgical = 1,
		/obj/item/stack/medical/wrap/sticky_tape/super = 2,
		/obj/item/stack/medical/wrap/sticky_tape = 3.33,
	)
	time = 4 SECONDS
	any_surgery_states_required = ALL_SURGERY_SKIN_STATES

/datum/surgery_operation/limb/repair_hairline/get_time_modifiers(obj/item/bodypart/limb, mob/living/surgeon, tool)
	. = ..()
	for(var/datum/wound/blunt/bone/critical/bone_wound in limb.wounds)
		if(HAS_TRAIT(bone_wound, TRAIT_WOUND_SCANNED))
			. *= 0.5

/datum/surgery_operation/limb/repair_hairline/get_default_radial_image()
	return image(/obj/item/bonesetter)

/datum/surgery_operation/limb/repair_hairline/all_required_strings()
	return list("конечность должна иметь трещину") + ..()

/datum/surgery_operation/limb/repair_hairline/state_check(obj/item/bodypart/limb)
	if(!(locate(/datum/wound/blunt/bone/severe) in limb.wounds))
		return FALSE
	return TRUE

/datum/surgery_operation/limb/repair_hairline/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("Вы начинаете устаранять трещину в [limb.ru_plaintext_zone[PREPOSITIONAL]][LIMB_OWNER_SUFFIX_RU(limb)]..."),
		span_notice("[surgeon] начинает устаранять трещину в [limb.ru_plaintext_zone[PREPOSITIONAL]][LIMB_OWNER_SUFFIX_RU(limb)] с помощью [tool.declent_ru(ACCUSATIVE)]."),
		span_notice("[surgeon] начинает устаранять трещину в [limb.ru_plaintext_zone[PREPOSITIONAL]][LIMB_OWNER_SUFFIX_RU(limb)]."),
	)
	display_pain(limb.owner, "Ваша [limb.ru_plaintext_zone[PREPOSITIONAL]] ноет от боли!")

/datum/surgery_operation/limb/repair_hairline/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/datum/wound/blunt/bone/fracture = locate() in limb.wounds
	qdel(fracture)

	display_results(
		surgeon,
		limb.owner,
		span_notice("Вы успешно устаранили трещину в [limb.ru_plaintext_zone[PREPOSITIONAL]][LIMB_OWNER_SUFFIX_RU(limb)]."),
		span_notice("[surgeon] успешно устаранил трещину в [limb.ru_plaintext_zone[PREPOSITIONAL]][LIMB_OWNER_SUFFIX_RU(limb)] с помощью [tool.declent_ru(ACCUSATIVE)]!"),
		span_notice("[surgeon] успешно устаранил трещину в [limb.ru_plaintext_zone[PREPOSITIONAL]][LIMB_OWNER_SUFFIX_RU(limb)]!"),
	)

/datum/surgery_operation/limb/reset_compound
	name = "Вправление сложного перелома"
	desc = "Вправление сложного перелома кости пациента, для подготавливки её к правильному заживлению."
	operation_flags = OPERATION_PRIORITY_NEXT_STEP | OPERATION_NO_PATIENT_REQUIRED
	implements = list(
		TOOL_BONESET = 1,
		/obj/item/stack/medical/wrap/sticky_tape/surgical = 1.66,
		/obj/item/stack/medical/wrap/sticky_tape/super = 2.5,
		/obj/item/stack/medical/wrap/sticky_tape = 5,
	)
	time = 6 SECONDS
	all_surgery_states_required = SURGERY_SKIN_OPEN
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED

/datum/surgery_operation/limb/reset_compound/get_time_modifiers(obj/item/bodypart/limb, mob/living/surgeon, tool)
	. = ..()
	for(var/datum/wound/blunt/bone/severe/bone_wound in limb.wounds)
		if(HAS_TRAIT(bone_wound, TRAIT_WOUND_SCANNED))
			. *= 0.5

/datum/surgery_operation/limb/reset_compound/get_default_radial_image()
	return image(/obj/item/bonesetter)

/datum/surgery_operation/limb/reset_compound/all_required_strings()
	return list("конечность должна иметь сложный перелом") + ..()

/datum/surgery_operation/limb/reset_compound/state_check(obj/item/bodypart/limb)
	var/datum/wound/blunt/bone/critical/fracture = locate() in limb.wounds
	if(isnull(fracture) || fracture.reset)
		return FALSE
	return TRUE

/datum/surgery_operation/limb/reset_compound/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("Вы начинаете вправлять кость в [limb.ru_plaintext_zone[PREPOSITIONAL]][LIMB_OWNER_SUFFIX_RU(limb)]..."),
		span_notice("[surgeon] начинает вправлять кость в [limb.ru_plaintext_zone[PREPOSITIONAL]][LIMB_OWNER_SUFFIX_RU(limb)] с помощью [tool.declent_ru(ACCUSATIVE)]."),
		span_notice("[surgeon] начинает вправлять кость в [limb.ru_plaintext_zone[PREPOSITIONAL]][LIMB_OWNER_SUFFIX_RU(limb)]."),
	)
	display_pain(limb.owner, "Ноющая боль в вашей [limb.ru_plaintext_zone[PREPOSITIONAL]] невыносима!")

/datum/surgery_operation/limb/reset_compound/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/datum/wound/blunt/bone/critical/fracture = locate() in limb.wounds
	fracture?.reset = TRUE

	display_results(
		surgeon,
		limb.owner,
		span_notice("Вы успешно вправляете кость в [limb.ru_plaintext_zone[PREPOSITIONAL]][LIMB_OWNER_SUFFIX_RU(limb)]."),
		span_notice("[surgeon] успешно вправляет кость в [limb.ru_plaintext_zone[PREPOSITIONAL]][LIMB_OWNER_SUFFIX_RU(limb)] с помощью [tool.declent_ru(ACCUSATIVE)]!"),
		span_notice("[surgeon] успешно вправляет кость в [limb.ru_plaintext_zone[PREPOSITIONAL]][LIMB_OWNER_SUFFIX_RU(limb)]!"),
	)

/datum/surgery_operation/limb/repair_compound
	name = "Сращивание сложного перелома"
	desc = "Залечивание сложного перелома кости пациента."
	operation_flags = OPERATION_PRIORITY_NEXT_STEP | OPERATION_NO_PATIENT_REQUIRED
	implements = list(
		/obj/item/stack/medical/bone_gel = 1,
		/obj/item/stack/medical/wrap/sticky_tape/surgical = 1,
		/obj/item/stack/medical/wrap/sticky_tape/super = 2,
		/obj/item/stack/medical/wrap/sticky_tape = 3.33,
	)
	time = 4 SECONDS
	any_surgery_states_required = ALL_SURGERY_SKIN_STATES

/datum/surgery_operation/limb/repair_compound/get_time_modifiers(obj/item/bodypart/limb, mob/living/surgeon, tool)
	. = ..()
	for(var/datum/wound/blunt/bone/critical/bone_wound in limb.wounds)
		if(HAS_TRAIT(bone_wound, TRAIT_WOUND_SCANNED))
			. *= 0.5

/datum/surgery_operation/limb/repair_compound/get_default_radial_image()
	return image(/obj/item/stack/medical/bone_gel)

/datum/surgery_operation/limb/repair_compound/all_required_strings()
	return list("сложный перелом конечности должен быть вправлен") + ..()

/datum/surgery_operation/limb/repair_compound/state_check(obj/item/bodypart/limb)
	var/datum/wound/blunt/bone/critical/fracture = locate() in limb.wounds
	if(isnull(fracture) || !fracture.reset)
		return FALSE
	return TRUE

/datum/surgery_operation/limb/repair_compound/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("Вы начинаете устранять перелом в [limb.ru_plaintext_zone[PREPOSITIONAL]][LIMB_OWNER_SUFFIX_RU(limb)]..."),
		span_notice("[surgeon] начинает устранять перелом в [limb.ru_plaintext_zone[PREPOSITIONAL]][LIMB_OWNER_SUFFIX_RU(limb)] с помощью [tool.declent_ru(ACCUSATIVE)]."),
		span_notice("[surgeon] начинает устранять перелом в [limb.ru_plaintext_zone[PREPOSITIONAL]][LIMB_OWNER_SUFFIX_RU(limb)]."),
	)
	display_pain(limb.owner, "Ноющая боль в вашей [limb.ru_plaintext_zone[PREPOSITIONAL]] невыносима!")

/datum/surgery_operation/limb/repair_compound/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/datum/wound/blunt/bone/critical/fracture = locate() in limb.wounds
	qdel(fracture)
	display_results(
		surgeon,
		limb.owner,
		span_notice("Вы успешно устраняете перелом в [limb.ru_plaintext_zone[PREPOSITIONAL]][LIMB_OWNER_SUFFIX_RU(limb)]."),
		span_notice("[surgeon] успешно устраняет перелом в [limb.ru_plaintext_zone[PREPOSITIONAL]][LIMB_OWNER_SUFFIX_RU(limb)] с помощью [tool.declent_ru(ACCUSATIVE)]!"),
		span_notice("[surgeon] успешно устраняет перелом в [limb.ru_plaintext_zone[PREPOSITIONAL]][LIMB_OWNER_SUFFIX_RU(limb)]!"),
	)

/datum/surgery_operation/limb/prepare_cranium_repair
	name = "Удаление осколков черепа"
	desc = "Удаление костных фрагментов и обломков из черепной щели пациента перед началом восстановления."
	operation_flags = OPERATION_PRIORITY_NEXT_STEP | OPERATION_NO_PATIENT_REQUIRED
	implements = list(
		TOOL_HEMOSTAT = 1,
		TOOL_WIRECUTTER = 2.5,
		TOOL_SCREWDRIVER = 2.5,
	)
	time = 2.4 SECONDS
	preop_sound = 'sound/items/handling/surgery/hemostat1.ogg'

/datum/surgery_operation/limb/prepare_cranium_repair/get_time_modifiers(obj/item/bodypart/limb, mob/living/surgeon, tool)
	. = ..()
	for(var/datum/wound/cranial_fissure/fissure in limb.wounds)
		if(HAS_TRAIT(fissure, TRAIT_WOUND_SCANNED))
			. *= 0.5

/datum/surgery_operation/limb/prepare_cranium_repair/get_default_radial_image()
	return image(/obj/item/hemostat)

/datum/surgery_operation/limb/prepare_cranium_repair/all_required_strings()
	return list("череп должен быть проломлен") + ..()

/datum/surgery_operation/limb/prepare_cranium_repair/state_check(obj/item/bodypart/limb)
	var/datum/wound/cranial_fissure/fissure = locate() in limb.wounds
	if(isnull(fissure) || fissure.prepped)
		return FALSE
	return TRUE

/datum/surgery_operation/limb/prepare_cranium_repair/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("Вы начинаете удалять мелкие осколки черепа в [limb.ru_plaintext_zone[PREPOSITIONAL]][LIMB_OWNER_SUFFIX_RU(limb)]..."),
		span_notice("[surgeon] начинает удалять мелкие осколки черепа в [limb.ru_plaintext_zone[PREPOSITIONAL]][LIMB_OWNER_SUFFIX_RU(limb)]..."),
		span_notice("[surgeon] начинает копошиться в [limb.ru_plaintext_zone[PREPOSITIONAL]][LIMB_OWNER_SUFFIX_RU(limb)]..."),
	)
	display_pain(limb.owner, "Ваш мозг словно пронзают маленькие осколки стекла!")

/datum/surgery_operation/limb/prepare_cranium_repair/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	var/datum/wound/cranial_fissure/fissure = locate() in limb.wounds
	fissure?.prepped = TRUE

/datum/surgery_operation/limb/repair_cranium
	name = "Восстановление черепа"
	desc = "Закрытие трещины в черепе пациента."
	operation_flags = OPERATION_PRIORITY_NEXT_STEP | OPERATION_NO_PATIENT_REQUIRED
	implements = list(
		/obj/item/stack/medical/bone_gel = 1,
		/obj/item/stack/medical/wrap/sticky_tape/surgical = 1,
		/obj/item/stack/medical/wrap/sticky_tape/super = 2,
		/obj/item/stack/medical/wrap/sticky_tape = 3.33,
	)
	time = 4 SECONDS

/datum/surgery_operation/limb/repair_cranium/get_time_modifiers(obj/item/bodypart/limb, mob/living/surgeon, tool)
	. = ..()
	for(var/datum/wound/cranial_fissure/fissure in limb.wounds)
		if(HAS_TRAIT(fissure, TRAIT_WOUND_SCANNED))
			. *= 0.5

/datum/surgery_operation/limb/repair_cranium/get_default_radial_image()
	return image(/obj/item/stack/medical/bone_gel)

/datum/surgery_operation/limb/repair_cranium/all_required_strings()
	return list("обломки были удалены из черепной щели") + ..()

/datum/surgery_operation/limb/repair_cranium/state_check(obj/item/bodypart/limb)
	var/datum/wound/cranial_fissure/fissure = locate() in limb.wounds
	if(isnull(fissure) || !fissure.prepped)
		return FALSE
	return TRUE

/datum/surgery_operation/limb/repair_cranium/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("Вы начинаете восстанавливать череп[LIMB_OWNER_SUFFIX_RU(limb)], насколько это возможно..."),
		span_notice("[surgeon] начинает восстанавливать череп[LIMB_OWNER_SUFFIX_RU(limb)] с помощью [tool.declent_ru(ACCUSATIVE)]."),
		span_notice("[surgeon] начинает восстанавливать череп[LIMB_OWNER_SUFFIX_RU(limb)]."),
	)

	display_pain(limb.owner, "Вы можете почувствовать, как осколки вашего черепа трутся о ваш мозг!")

/datum/surgery_operation/limb/repair_cranium/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/datum/wound/cranial_fissure/fissure = locate() in limb.wounds
	qdel(fissure)

	display_results(
		surgeon,
		limb.owner,
		span_notice("Вы успешно восстанавливаете череп[LIMB_OWNER_SUFFIX_RU(limb)]."),
		span_notice("[surgeon] успешно восстанавливает череп[LIMB_OWNER_SUFFIX_RU(limb)] с помощью [tool.declent_ru(ACCUSATIVE)]."),
		span_notice("[surgeon] успешно восстанавливает череп[LIMB_OWNER_SUFFIX_RU(limb)].")
	)
