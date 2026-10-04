/obj/item/storage/belt/police/swat
	name = "swat belt"
	desc = "Вмещает снаряжение SWAT - например, наручники."
	icon_state = "security"
	inhand_icon_state = "security"
	worn_icon_state = "security"
	content_overlays = TRUE
	storage_type = /datum/storage/security_belt

/obj/item/storage/belt/police/swat/full

/obj/item/storage/belt/police/swat/full/PopulateContents()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/melee/baton/vamp(src)

/obj/item/card/swat
	name = "Dogtags"
	desc = "Жетоны бойца элитного полицейского подразделения. На них выбито имя владельца - на случай, если он попадёт в плен или погибнет."
	icon = 'modular_darkpack/modules/ert/icons/badges.dmi'
	icon_state = "dogtags"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/ert/icons/badges_onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/jobs/icons/id_worn.dmi'
	worn_icon_state = "police_badge"

/obj/item/card/lieutenant
	name = "Officer Badge"
	desc = "Блестящий значок офицера элитного полицейского подразделения. Сияет золотом власти."
	icon = 'modular_darkpack/modules/ert/icons/badges.dmi'
	icon_state = "leader"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/ert/icons/badges_onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/jobs/icons/id_worn.dmi'
	worn_icon_state = "police_badge"

/obj/item/card/first_aid
	name = "First Aid Officer Card"
	desc = "Ламинированное удостоверение полевого медика. А вы знали, что намеренно стрелять по полевым медикам - военное преступление?"
	icon = 'modular_darkpack/modules/ert/icons/badges.dmi'
	icon_state = "first_aid"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/ert/icons/badges_onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/jobs/icons/id_worn.dmi'
	worn_icon_state = "grey_id"

/obj/item/clothing/suit/vampire/darkpack_ert/swat_armor
	name = "\improper SWAT vest"
	desc = "Бронежилет высокого класса защиты с маркировкой SWAT. Не забудьте бросить светошумовую гранату ДО того, как войдёте в комнату."
	icon_state = "swatvest"
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_BULKY
	armor_type = /datum/armor/highly_protective_vest
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	clothing_traits = list(TRAIT_BRAWLING_KNOCKDOWN_BLOCKED)

/obj/item/clothing/suit/vampire/darkpack_ert/swat_armor/fbi
	name = "\improper FBI SWAT vest"
	icon_state = "fbivest"

/obj/item/clothing/head/vampire/darkpack_ert/swat_helmet
	name = "\improper SWAT Helmet"
	desc = "Доработанный шлем полиции Сан-Франциско с улучшенными характеристиками. Здорово оказаться на правильной стороне милитаризации полиции, правда?"
	icon_state = "swathelmet"
	armor_type = /datum/armor/army_helmet
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR
	visor_flags_inv = HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF

/obj/item/clothing/head/vampire/darkpack_ert/swat_helmet/fbi
	name = "\improper FBI SWAT Helmet"
	icon_state = "fbihelmet"
