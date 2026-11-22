#ifndef COMSIG_MASQUERADE_LEVEL_DECREASED
#define COMSIG_MASQUERADE_LEVEL_DECREASED "masquerade_level_decreased"
#endif

SUBSYSTEM_DEF(ert_deployment)
	name = "ERT Deployment"
	ss_flags = SS_NO_FIRE

	var/list/deployed_tiers = list()

	var/list/failed_tiers = list()

	var/deploying = FALSE

	var/deployment_delay = 15 SECONDS

	var/deployment_cooldown = 20 MINUTES

	var/next_deployment_allowed = 0

	var/static/list/ert_tiers = list(
		"swat" = list(
			"min_level" = 10,
			"max_level" = 14,
			"template"  = /datum/ert/darkpack/swat,
		),
		"national_guard" = list(
			"min_level" = 1,
			"max_level" = 9,
			"template"  = /datum/ert/darkpack/national_guard,
		),
	)

/datum/controller/subsystem/ert_deployment/Initialize()
	deployed_tiers = list()
	failed_tiers = list()
	deploying = FALSE
	next_deployment_allowed = 0
	RegisterSignal(SSmasquerade, COMSIG_MASQUERADE_LEVEL_DECREASED, PROC_REF(on_masquerade_level_decreased))
	return SS_INIT_SUCCESS

/datum/controller/subsystem/ert_deployment/proc/on_masquerade_level_decreased(datum/source, new_level, old_level)
	SIGNAL_HANDLER
	check_and_deploy(new_level)

/datum/controller/subsystem/ert_deployment/proc/check_and_deploy(level)
	if(deploying)
		return
	if(world.time < next_deployment_allowed)
		return
	if(!get_tier_for_level(level))
		return

	deploying = TRUE
	message_admins("Уровень Маскарада достиг [level]. Отряд будет выбран по актуальному уровню через [deployment_delay / 10] секунд.")
	addtimer(CALLBACK(src, PROC_REF(try_deploy)), deployment_delay)

/datum/controller/subsystem/ert_deployment/proc/get_tier_for_level(level)
	for(var/tier_id in ert_tiers)
		if(tier_id in deployed_tiers || tier_id in failed_tiers)
			continue
		var/list/tier = ert_tiers[tier_id]
		if(level >= tier["min_level"] && level <= tier["max_level"])
			return tier_id
	return null

/datum/controller/subsystem/ert_deployment/proc/try_deploy()
	var/current_level = SSmasquerade.masquerade_level
	var/tier_id = get_tier_for_level(current_level)

	if(!tier_id)
		deploying = FALSE
		message_admins("Отправка отряда отменена: текущий уровень Маскарада ([current_level]) не требует высылки. Кулдаун не применён.")
		return

	var/template_path = ert_tiers[tier_id]["template"]
	var/datum/ert/ertemplate = new template_path

	if(!launch_emergency_response_team(ertemplate))
		failed_tiers += tier_id
		deploying = FALSE
		message_admins("Не удалось отправить отряд ([tier_id]): нет свободных гостов. Автоматический повтор не будет выполнен. Кулдаун не применён.")
		return

	deployed_tiers += tier_id
	next_deployment_allowed = world.time + deployment_cooldown
	deploying = FALSE
	message_admins("Отряд ([tier_id]) отправлен. Следующая отправка будет доступна через [deployment_cooldown / 600] минут.")
