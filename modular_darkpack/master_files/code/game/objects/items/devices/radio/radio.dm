/obj/item/radio
	/// If the radio is connected to a network via a transceiver.
	var/radio_network
	/// The ID used to identify the radio on the network.
	var/radio_id

/obj/item/radio/examine(mob/user)
	. = ..()
	. += radio_network ? span_notice("Подключено к сети [radio_network], идентификатор: [radio_id].") : span_warning("Не подключено ни к одной сети.")
