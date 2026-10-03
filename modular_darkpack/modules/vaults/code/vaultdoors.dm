/obj/structure/vaultdoor
	name = "vault door"
	desc = "Массивная дверь. С виду такая выдержит что угодно."
	icon = 'modular_darkpack/modules/vaults/icons/vault.dmi'
	icon_state = "vault-1"
	base_icon_state = "vault"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	pixel_w = -16
	anchored = TRUE
	density = TRUE
	opacity = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

	var/id = ""
	var/brokenicon = "vault_broken"
	var/pincode
	var/closed = TRUE
	var/lock_id = ""
	var/door_moving = FALSE
	var/is_broken = FALSE
	var/door_health = 100

	var/open_sound = 'modular_darkpack/modules/vaults/sounds/vault_door_opening.ogg'
	var/close_sound = 'modular_darkpack/modules/vaults/sounds/vault_door_closing.ogg'
	var/lock_sound = 'modular_darkpack/modules/vaults/sounds/vault_door_lock.ogg'

	var/is_locked = FALSE

/obj/structure/vaultdoor/pincode
	name = "vault door"
	desc = "Массивная дверь. С виду такая выдержит что угодно."

/obj/structure/vaultdoor/pincode/bank
	name = "bank vault door"
	desc = "Огромная бронированная дверь, за которой хранятся запасы банка."
	lock_id = "bank_vault"

/obj/structure/vaultdoor/Initialize(mapload)
	. = ..()
	pincode = create_unique_pincode()
	GLOB.vault_doors += src
	is_locked = TRUE

/obj/structure/vaultdoor/Destroy()
	GLOB.vault_doors -= src
	return ..()

/obj/structure/vaultdoor/attack_hand(mob/user)
	. = ..()
	if(is_broken)
		return

	if(is_locked)
		ui_interact(user)
		return

	if(closed && !door_moving)
		open_door(user)
	else if (!door_moving)
		close_door(user)

/obj/structure/vaultdoor/proc/break_open()
	if(is_broken)
		return
	is_broken = TRUE
	is_locked = FALSE
	icon_state = "[brokenicon]-1"
	set_density(FALSE)
	opacity = FALSE
	layer = OPEN_DOOR_LAYER
	visible_message("<span class='warning' style='color:red; font-size:20px;'><b>[capitalize(declent_ru(NOMINATIVE))] вскрыта!</b></span>")

/obj/structure/vaultdoor/proc/open_door(mob/user)
	playsound(src, open_sound, 75, TRUE)
	door_moving = TRUE
	if(do_after(user, 4 SECONDS))
		icon_state = "[base_icon_state]-0"
		set_density(FALSE)
		opacity = FALSE
		layer = OPEN_DOOR_LAYER
		to_chat(user, span_notice("Вы открываете [declent_ru(ACCUSATIVE)]."))
		closed = FALSE
	door_moving = FALSE

/obj/structure/vaultdoor/proc/close_door(mob/user)
	for(var/atom/movable/door_blocker in src.loc)
		if(door_blocker.density)
			to_chat(user, span_warning("[capitalize(door_blocker.declent_ru(NOMINATIVE))] не даёт закрыть [declent_ru(ACCUSATIVE)]."))
			return
	playsound(src, close_sound, 75, TRUE)
	door_moving = TRUE
	if(do_after(user, 4 SECONDS))
		icon_state = "[base_icon_state]-1"
		set_density(TRUE)
		opacity = TRUE
		layer = ABOVE_ALL_MOB_LAYER
		to_chat(user, span_notice("Вы закрываете [declent_ru(ACCUSATIVE)]."))
		closed = TRUE
		is_locked = TRUE
		to_chat(user, span_notice("Замок защёлкивается сам."))
		playsound(src, lock_sound, 50, TRUE)
	door_moving = FALSE

/obj/structure/vaultdoor/examine(mob/user)
	. = ..()
	. += span_notice("Прочность двери: [door_health]/100.")

	if(is_locked)
		. += span_warning("Дверь заперта.")

	. += span_notice("Запирается на электронный кодовый замок.")

/obj/structure/vaultdoor/ui_interact(mob/user, datum/tgui/ui)
	if(is_broken || !is_locked)
		return

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "VaultDoor", capitalize(declent_ru(NOMINATIVE)))
		ui.open()

/obj/structure/vaultdoor/ui_data(mob/user)
	var/list/data = list()
	data["pincode"] = pincode
	return data

/obj/structure/vaultdoor/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(action == "submit_pincode")
		if(params["pincode"] == pincode)
			to_chat(usr, span_notice("ДОСТУП РАЗРЕШЁН."))
			is_locked = FALSE
			playsound(src, 'sound/machines/terminal/terminal_success.ogg', 50, TRUE)
		else
			to_chat(usr, span_warning("ДОСТУП ЗАПРЕЩЁН."))
			playsound(src, 'sound/machines/terminal/terminal_error.ogg', 50, TRUE)
		. = TRUE

