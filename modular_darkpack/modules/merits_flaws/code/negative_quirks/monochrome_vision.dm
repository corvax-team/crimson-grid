/datum/quirk/darkpack/monochrome_vision
	name = "Monochrome Vision"
	ru_name = "Чёрно-белое зрение"
	desc = "Вы не различаете цвета и видите мир в оттенках чёрного, белого и серого. Это не дальтонизм в привычном смысле, при котором путают лишь некоторые цвета (например, красный и зелёный). Этот недостаток часто встречается у гару-люпусов."
	ttrpg_sources = list(/datum/source_book/wta20 = 473)
	icon = FA_ICON_ADJUST
	allowed_splats = list(SPLAT_GAROU)
	value = -1
	medical_record_text = "Пациент страдает почти полной цветовой слепотой."

/datum/quirk/darkpack/monochrome_vision/add(client/client_source)
	quirk_holder.add_client_colour(/datum/client_colour/monochrome, QUIRK_TRAIT)

/datum/quirk/darkpack/monochrome_vision/remove()
	quirk_holder.remove_client_colour(QUIRK_TRAIT)
