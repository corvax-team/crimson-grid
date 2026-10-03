/obj/item/clothing/under/suit
	icon = 'icons/obj/clothing/under/suits.dmi'
	worn_icon = 'icons/mob/clothing/under/suits.dmi'
	can_adjust = FALSE
	female_sprite_flags = FEMALE_UNIFORM_NO_BREASTS
	inhand_icon_state = null

/obj/item/clothing/under/suit/red //Also used by the Curator's suit, /obj/item/clothing/under/rank/civilian/curator
	name = "red suit"
	desc = "A red suit and blue tie. Somewhat formal."
	icon_state = "red_suit"
	inhand_icon_state = "r_suit"

/obj/item/clothing/under/suit/charcoal
	name = "charcoal suit"
	desc = "Тёмно-серый костюм с красным галстуком. Очень по-деловому."
	icon_state = "charcoal_suit"

/obj/item/clothing/under/suit/navy
	name = "navy suit"
	desc = "Тёмно-синий костюм с красным галстуком. Для лучших людей города."
	icon_state = "navy_suit"

/obj/item/clothing/under/suit/burgundy
	name = "burgundy suit"
	desc = "Бордовый костюм с чёрным галстуком. Почти официально."
	icon_state = "burgundy_suit"

/obj/item/clothing/under/suit/checkered
	name = "checkered suit"
	desc = "Славный у вас костюмчик. Обидно будет, если с ним что-нибудь случится, а?"
	icon_state = "checkered_suit"

/obj/item/clothing/under/suit/beige
	name = "beige suit"
	desc = "Превосходный светлый костюм. Знатоки настаивают: не путать с куда менее достойным песочным."
	icon_state = "beige_suit"

/obj/item/clothing/under/suit/black
	name = "black two piece suit"
	desc = "Чёрный пиджак, тёмно-серые брюки и красный галстук. Строго официально."
	icon_state = "black_suit"

/obj/item/clothing/under/suit/black/skirt
	name = "black two piece suit"
	desc = "Чёрный пиджак, тёмно-серая юбка и красный галстук. Строго официально."
	icon_state = "black_suit_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/suit/white
	name = "white suit"
	desc = "Белый костюм с синей рубашкой. Хотите по-плохому? ЛАДНО!"
	icon_state = "white_suit"
	inhand_icon_state = "white_suit"

/obj/item/clothing/under/suit/white/skirt
	name = "white suitskirt"
	desc = "A white suitskirt, suitable for an excellent host."
	icon_state = "white_suit_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/suit/tan
	name = "tan suit"
	desc = "Песочный костюм. Элегантно, но без лишней строгости."
	icon_state = "tan_suit"
	inhand_icon_state = "tan_suit"

/obj/item/clothing/under/suit/waiter
	name = "waiter's outfit"
	desc = "Очень элегантная форма с особым кармашком для чаевых."
	icon_state = "waiter"
	inhand_icon_state = "waiter"

/obj/item/clothing/under/suit/black_really
	name = "executive suit"
	desc = "Строгий чёрный костюм. Для лучших людей города."
	icon_state = "really_black_suit"
	inhand_icon_state = null

/obj/item/clothing/under/suit/black_really/skirt
	name = "executive suitskirt"
	desc = "Строгий чёрный костюм с юбкой. Для лучших людей города."
	icon_state = "really_black_suit_skirt"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY|FEMALE_UNIFORM_NO_BREASTS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/suit/tuxedo
	name = "tuxedo"
	desc = "Строгий чёрный смокинг. От него так и веет шиком."
	icon_state = "tuxedo"
	inhand_icon_state = null

/obj/item/clothing/under/suit/tuxedo/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, 4) //You aren't going to fish with this are you?

/obj/item/clothing/under/suit/carpskin
	name = "carpskin suit"
	desc = "A luxurious suit made with only the finest scales, perfect for conducting dodgy business deals."
	icon_state = "carpskin_suit"
	inhand_icon_state = null
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR

/obj/item/clothing/under/suit/carpskin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -4)
