/datum/round_event_control/darkpack/financial_crisis
	name = "Financial Crisis"
	typepath = /datum/round_event/financial_crisis
	weight = 2
	min_players = 5
	max_occurrences = 1
	earliest_start = 50 MINUTES
	category = EVENT_CATEGORY_BUREAUCRATIC
	description = "Wall Street has crashed catastrophically causing all of Bianchi Bank's accounts to tank as people lose their savings."
	darkpack_allowed = TRUE

/datum/round_event/financial_crisis
	start_when = 1
	announce_when = 3
	var/static/list/announcement_messages = list(
		"Из-за недавнего скачка напряжения у части клиентов банка Бьянки на счетах может отображаться неверный баланс.",
		"К сожалению, недавняя банковская ошибка затронула некоторых клиентов банка Бьянки в районе залива Сан-Франциско.",
		"После сбоя серверов банка Бьянки балансы счетов отображаются неверно.",
		"Банк Бьянки с сожалением сообщает: новейшие финансовые инструменты оказались мошенническими, и сбережения десятков тысяч вкладчиков сгорели за считаные секунды.",
	)

/datum/round_event/financial_crisis/announce(fake)
	var/chosen_announcement = "[pick(announcement_messages)] Просим клиентов обращаться в отделение в рабочие часы: с понедельника по пятницу, с 8:00 до 17:00."
	endpost_announce("[chosen_announcement]", "BianchiBank")

/datum/round_event/financial_crisis/start()
	for(var/account_id in SSeconomy.bank_accounts_by_id)
		var/datum/bank_account/bank = SSeconomy.bank_accounts_by_id[account_id]
		if(!istype(bank, /datum/bank_account))
			continue
		bank.adjust_money(-(round(bank.account_balance * (rand(85, 95) / 100))), "Финансовый кризис") // leaves them with 5-15% of their savings

