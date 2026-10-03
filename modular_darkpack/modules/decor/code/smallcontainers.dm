/obj/effect/spawner/random/structure/shipping_container/darkpack
	name = "random darkpack shipping container spawner"
	icon = 'modular_darkpack/modules/decor/icons/smallcontainers.dmi'
	icon_state = "random_container"
	loot = list(
		/obj/structure/shipping_container/darkpack/endron = 3,
		/obj/structure/shipping_container/darkpack/endron/alt = 3,
		/obj/structure/shipping_container/darkpack/endron/gas = 3,
		/obj/structure/shipping_container/darkpack/magadon = 3,
		/obj/structure/shipping_container/darkpack/kings = 3,
		/obj/structure/shipping_container/darkpack/kings/alt = 3,
		/obj/structure/shipping_container/darkpack/avalon = 3,
		/obj/structure/shipping_container/darkpack/tellus = 3,
		/obj/structure/shipping_container/darkpack/otolleys = 3,
		/obj/structure/shipping_container/darkpack/gateway = 3,
		/obj/structure/shipping_container/darkpack/gateway/alt = 3,
	)

/obj/structure/shipping_container/darkpack
	name = "shipping container"
	desc = "DONT PLACE THIS !! ITS FAKE AS HELL !!"
	icon = 'modular_darkpack/modules/decor/icons/smallcontainers.dmi'
	icon_state = "random_container"
	abstract_type = /obj/structure/shipping_container/darkpack

/obj/structure/shipping_container/darkpack/endron
	name = "\improper Endron shipping container"
	desc = "Стандартный контейнер для перевозки крупных партий товара. На этом логотип \"Эндрон\"."
	icon_state = "endron1"

/obj/structure/shipping_container/darkpack/endron/alt
	icon_state = "endron2"

/obj/structure/shipping_container/darkpack/endron/gas
	name = "\improper Endron bulk gas tank"
	desc = "Стандартная цистерна для перевозки газа. На ней логотип \"Эндрон\", а что за газ внутри - не указано."
	icon_state = "endron3"

/obj/structure/shipping_container/darkpack/magadon
	name = "\improper Magadon shipping container"
	desc = "Стандартный контейнер для перевозки крупных партий товара. На этом логотип \"Магадон Фармасьютикалс\"."
	icon_state = "magadon"

/obj/structure/shipping_container/darkpack/kings
	name = "\improper Kings Breweries shipping container"
	desc = "Стандартный контейнер для перевозки крупных партий товара. На этом логотип \"Кинг Брюэрис\"."
	icon_state = "kings1"

/obj/structure/shipping_container/darkpack/kings/alt
	icon_state = "kings2"

/obj/structure/shipping_container/darkpack/avalon
	name = "\improper Avalon Incorporated shipping container"
	desc = "Стандартный контейнер для перевозки крупных партий товара. На этом логотип \"Авалон Инкорпорейтед\"."
	icon_state = "avalon"

/obj/structure/shipping_container/darkpack/tellus
	name = "\improper Tellus Enterprises shipping container"
	desc = "Стандартный контейнер для перевозки крупных партий товара. На этом логотип \"Теллус Энтерпрайзис\"."
	icon_state = "tellus"

/obj/structure/shipping_container/darkpack/otolleys
	name = "\improper O'Tolley's shipping container"
	desc = "Стандартный контейнер для перевозки крупных партий товара. На этом логотип \"O'Tolley's\"."
	icon_state = "otolleys"

// I just made these up because I needed some filler containers.
/obj/structure/shipping_container/darkpack/gateway
	name = "\improper Gateway Logistics shipping container"
	desc = "Стандартный контейнер для перевозки крупных партий товара. На этом логотип \"Гейтвэй Лоджистикс\"."
	icon_state = "gateway1"

/obj/structure/shipping_container/darkpack/gateway/alt
	icon_state = "gateway2"
