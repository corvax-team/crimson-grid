/datum/bank_account
	var/times_used_without_pin = 0
	var/paycheck_amount = 0

/datum/bank_account/payday(amount_of_paychecks, free = FALSE, skippable = FALSE, event = "Paycheck")
	if(!paycheck_amount)
		return FALSE
	log_econ("[paycheck_amount] [MONEY_NAME] were given to [src.account_holder]'s account from income.")
	adjust_money(paycheck_amount, "Зарплата")
	bank_card_talk("На счёте теперь [MONEY_SYMBOL][account_balance].")
	return TRUE

/datum/bank_account/proc/check_pin(mob/living/user, amount, obj/item/source)
	//purchases over $20 require a pin, you have to use one eventually
	if(amount > 20 || times_used_without_pin > 5)
		if(ishuman(user))
			var/mob/living/carbon/human/human_user = user
			var/datum/bank_account/account = human_user.account_id ? SSeconomy.bank_accounts_by_id["[human_user.account_id]"] : null
			if(account && (bank_pin == account.bank_pin))
				to_chat(user, span_notice("Вы по памяти вводите верный ПИН-код от [source.declent_ru(GENITIVE)]."))
				times_used_without_pin = 0
				return TRUE

		if(tgui_input_text(user, "Введите ПИН-код этой карты:", "Ввод ПИН-кода", max_length=4, multiline=FALSE) != bank_pin)
			to_chat(user, span_alert("Вы ввели неверный ПИН-код от [source.declent_ru(GENITIVE)]."))
			return FALSE
		else
			to_chat(user, span_notice("Вы вводите верный ПИН-код от [source.declent_ru(GENITIVE)]."))
			times_used_without_pin = 0
	else
		times_used_without_pin += 1
	return TRUE

// Modifyied pin check for when you cannot sleep/wait for input. This is missing behavoir and means it will have to be YOUR card to acctually use it.
/datum/bank_account/proc/check_pin_async(mob/living/user, amount, obj/item/source)
	//purchases over $20 require a pin, you have to use one eventually
	if(amount > 20 || times_used_without_pin > 5)
		if(ishuman(user))
			var/mob/living/carbon/human/human_user = user
			var/datum/bank_account/account = human_user.account_id ? SSeconomy.bank_accounts_by_id["[human_user.account_id]"] : null
			if(account && (bank_pin == account.bank_pin))
				to_chat(user, span_notice("Вы по памяти вводите верный ПИН-код от [source.declent_ru(GENITIVE)]."))
				times_used_without_pin = 0
				return TRUE

		to_chat(user, span_notice("Вы не знаете ПИН-код от [source.declent_ru(GENITIVE)] или не представляете, как его ввести."))
		return FALSE
	else
		times_used_without_pin += 1
	return TRUE

/// Your bank account ID, can't get into it without it
/datum/memory/key/bank_pin
	var/remembered_id

/datum/memory/key/bank_pin/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	remembered_id,
)
	src.remembered_id = remembered_id
	return ..()

/datum/memory/key/bank_pin/get_names()
	return list("Банковский ПИН-код [protagonist_name]: [remembered_id].")

/datum/memory/key/bank_pin/get_starts()
	return list(
		"[protagonist_name], напрягая последние извилины, гордо показывает свои счастливые числа: [remembered_id].",
		"[remembered_id]. Числа, Мейсон! Что они значат?!",
	)
