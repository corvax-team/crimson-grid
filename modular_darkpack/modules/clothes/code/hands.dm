//GLOVES

//GLOVES

//GLOVES

/obj/item/clothing/gloves/vampire
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	undyeable = TRUE

/obj/item/clothing/gloves/vampire/Initialize(mapload)
	.=..()
	AddComponent(/datum/component/selling, 4, "gloves", FALSE)

/obj/item/clothing/gloves/vampire/leather
	name = "leather gloves"
	desc = "Выглядят грозно. Немного защищают."
	icon_state = "leather"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	resistance_flags = NONE
	armor_type = /datum/armor/leather_gloves

/datum/armor/leather_gloves
	acid = 30

/obj/item/clothing/gloves/vampire/work
	name = "work gloves"
	desc = "Защищают от огня при работе в экстремальных условиях."
	icon_state = "work"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	armor_type = /datum/armor/work_gloves

/datum/armor/work_gloves
	fire = 70
	acid = 30

/obj/item/clothing/gloves/vampire/investigator
	name = "investigator gloves"
	desc = "Штатные рабочие перчатки ФБР для следователей. Снаружи латекс, внутри подкладка, защищающая от кислоты и огня."
	icon_state = "work"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	armor_type = /datum/armor/investigator_gloves

/datum/armor/investigator_gloves
	fire = 70
	acid = 70

/obj/item/clothing/gloves/vampire/cleaning
	name = "cleaning gloves"
	desc = "Защищают от кислоты."
	icon_state = "cleaning"
	armor_type = /datum/armor/anti_acid_gloves

/datum/armor/anti_acid_gloves
	acid = 70

/obj/item/clothing/gloves/vampire/latex
	name = "latex gloves"
	desc = "Защищают от кислоты."
	icon_state = "latex"
	armor_type = /datum/armor/anti_acid_gloves
	siemens_coefficient = /obj/item/clothing/gloves/latex::siemens_coefficient
	clothing_traits = /obj/item/clothing/gloves/latex::clothing_traits
	resistance_flags = /obj/item/clothing/gloves/latex::resistance_flags
	equip_sound = /obj/item/clothing/gloves/latex::equip_sound

/obj/item/clothing/gloves/vampire/white
	name = "white gloves"
	desc = "Пара тонких белых перчаток: символ чистоты и качества, и больше ничего. Испачкаете - и сразу видно, какой из вас профессионал."
	icon_state = "white_gloves"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE

/obj/item/clothing/gloves/vampire/brassknuckles
	name = "brass knuckles"
	desc = "Потускневшие латунные кольца, спаянные в жестокое оружие для драк в подворотнях. Почти везде вне закона."
	icon_state = "brassknuckles"
	resistance_flags = FIRE_PROOF
	armor_type = /datum/armor/brassknuckles
	clothing_traits = list(TRAIT_BRASSKNUCKLES)

/datum/armor/brassknuckles
	acid = 50


/obj/item/clothing/gloves/vampire/brassknuckles/spiked
	name = "spiked steel knuckles"
	desc = "Потускневшие стальные кольца, спаянные воедино и увенчанные острыми шипами. Почти везде вне закона."
	icon_state = "spikedknuckles"

/obj/item/clothing/gloves/vampire/brassknuckles/spiked/equipped(mob/living/carbon/human/user, slot)
	..()
	if(ishuman(user) && slot == ITEM_SLOT_GLOVES)
		var/mob/living/carbon/carbon_owner = user
		for(var/obj/item/bodypart/limb as anything in carbon_owner.bodyparts)
			if(istype(limb, /obj/item/bodypart/arm))
				limb.unarmed_sharpness = SHARP_POINTY

/obj/item/clothing/gloves/vampire/brassknuckles/spiked/dropped(mob/living/carbon/human/user, slot)
	..()
	if(user.get_item_by_slot(ITEM_SLOT_GLOVES) == src)
		var/mob/living/carbon/carbon_owner = user
		for(var/obj/item/bodypart/limb as anything in carbon_owner.bodyparts)
			if(istype(limb, /obj/item/bodypart/arm))
				limb.unarmed_sharpness = initial(limb.unarmed_sharpness)
