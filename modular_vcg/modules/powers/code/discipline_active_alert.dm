/atom/movable/screen/alert/discipline_active
	clickable_glow = TRUE
	var/datum/weakref/power_ref

/atom/movable/screen/alert/discipline_active/proc/set_power(datum/discipline_power/power)
	if(!power?.discipline)
		return

	power_ref = WEAKREF(power)
	name = "Действует: [power.name]"
	desc = "Способность действует за счёт вашей крови. Нажмите, чтобы отключить."
	icon = power.discipline.icon
	icon_state = power.discipline.icon_state

/atom/movable/screen/alert/discipline_active/Click(location, control, params)
	. = ..()
	if(!.)
		return

	var/datum/discipline_power/power = power_ref?.resolve()
	if(!power)
		return

	power.try_deactivate(direct = TRUE, alert = TRUE)
