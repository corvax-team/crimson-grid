/obj/structure/billboard/darkpack
	name = "billboard"
	desc = "Рекламный щит с огромным объявлением."
	icon = 'modular_darkpack/modules/billboard/icons/billboards.dmi'
	icon_state = "billboard_blank"

/obj/structure/billboard/darkpack/transam
	icon_state = "billboard_1"
	desc = "Реклама корпорации \"ТрансАмерика\" - холдинга, которому принадлежат страховые и инвестиционные компании."

/obj/structure/billboard/darkpack/endron
	icon_state = "billboard_2"
	desc = "Реклама \"Эндрон\" - нефтегазовой компании, основанной в 1916 году. \"Эндрон\": за зелёное завтра."

/obj/structure/billboard/darkpack/endronvandal
	icon_state = "billboard_3"
	desc = "Реклама \"Эндрон\" - нефтегазовой компании, основанной в 1916 году. Над щитом кто-то поработал: теперь там читается \"end times\" - \"конец времён\"."

/obj/structure/billboard/darkpack/king
	icon_state = "billboard_4"
	desc = "Реклама двух главных марок пивоварен \"Кингс\": Blue Stripe и King's Lager."

/obj/structure/billboard/darkpack/kingvandal
	icon_state = "billboard_5"
	desc = "Реклама двух главных марок пивоварен \"Кингс\": Blue Stripe и King's Lager. Над щитом кто-то поработал: поперёк рекламы намалёвано \"poison\" - \"яд\"."

/obj/structure/billboard/darkpack/bubway
	icon_state = "billboard_6"
	desc = "Реклама сэндвича \"Classic Bub\" от Bubway за 10 долларов."

/obj/structure/billboard/darkpack/starkist
	icon_state = "billboard_7"
	desc = "Реклама Starkist - апельсиновой газировки, которой жаждут люди. В ней есть электролиты!"

/obj/structure/billboard/darkpack/starkistvandal
	icon_state = "billboard_8"
	desc = "Реклама Starkist - апельсиновой газировки, которой жаждут люди. Над щитом кто-то поработал. Как грубо!"

/obj/structure/billboard/darkpack/redbat
	icon_state = "billboard_9"
	desc = "Реклама Redbat - лучшего энергетика для спортивных людей. Говорят, окрыляет."

/obj/structure/billboard/darkpack/magadon
	icon_state = "billboard_10"
	desc = "Реклама \"Магадон Инкорпорейтед\" - ведущей фармацевтической компании и поставщика больниц. \"Магадон\": строим лучшего вас."

/obj/structure/billboard/darkpack/rednews
	icon_state = "billboard_11"
	desc = "Реклама Red Network - новостного канала, который держит публику в курсе и не отпускает от экрана."

/obj/effect/spawner/random/structure/billboard/darkpack
	icon = 'modular_darkpack/modules/billboard/icons/billboards.dmi'
	icon_state = "billboard_random"
	loot = list(
		/obj/structure/billboard/darkpack/transam = 50,
		/obj/structure/billboard/darkpack/endron = 50,
		/obj/structure/billboard/darkpack/endronvandal = 20,
		/obj/structure/billboard/darkpack/king = 50,
		/obj/structure/billboard/darkpack/kingvandal = 20,
		/obj/structure/billboard/darkpack/bubway = 50,
		/obj/structure/billboard/darkpack/starkist = 50,
		/obj/structure/billboard/darkpack/starkistvandal = 20,
		/obj/structure/billboard/darkpack/redbat = 50,
		/obj/structure/billboard/darkpack/magadon = 50,
		/obj/structure/billboard/darkpack/rednews = 50,
	)
