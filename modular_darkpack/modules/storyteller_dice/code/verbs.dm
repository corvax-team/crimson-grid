ADMIN_VERB_ONLY_CONTEXT_MENU(roll_storyteller_dice, R_FUN, "Roll storyteller dice", /mob/living)
	VERB_ARG_TYPED(roller, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob/living)

	roller.roll_dice_custom()

	BLACKBOX_LOG_ADMIN_VERB("Storyteller dice")

GAME_VERB(/mob/living, do_roll_dice_custom, "Roll custom dice", null)
	roll_dice_custom()

/mob/living/proc/roll_dice_custom(atom/movable/roll_target)
	var/list/allowed_stats = list()
	var/list/stat_labels = list()
	for(var/stat_path, dots_in in storyteller_stats)
		var/datum/st_stat/stat = stat_path
		if(!ispath(stat))
			continue
		if(stat == stat::abstract_type)
			continue
		allowed_stats += stat
		stat_labels += stat::name
		//allowed_stats[stat] = "[stat::name]: [dots_in]"
	var/list/stats_to_use = tgui_input_checkboxes(usr, "Выберите параметры для проверки.", "Параметры", stat_labels, min_checked = 0, max_checked = 5)
	var/list/output_stats = list()
	if(length(stats_to_use))
		for(var/list/stat as anything in stats_to_use)
			output_stats += allowed_stats[stat[2]]

	var/bonus_dice = tgui_input_number(usr, "Сколько дополнительных кубиков добавить?", "Кубики", 0, 20, -20)
	if(isnull(bonus_dice))
		return

	var/difficulty = tgui_input_number(usr, "Укажите сложность проверки.", "Сложность", 6, 10, 1)
	if(isnull(difficulty))
		return

	var/successes_needed = tgui_input_number(usr, "Сколько успехов нужно для прохождения?", "Нужно успехов", 1, 20, 1)
	if(isnull(successes_needed))
		return

	var/static/list/roll_type_labels = list(
		"Всем вокруг" = ROLL_PUBLIC,
		"Только мне" = ROLL_PRIVATE,
		"Мне и администрации" = ROLL_PRIVATE_ADMIN,
		"Только администрации" = ROLL_ADMIN,
	)
	var/roll_type = roll_type_labels[tgui_input_list(usr, "Кому показать результат проверки?", "Тип проверки", roll_type_labels, "Всем вокруг")]
	if(isnull(roll_type))
		return

	var/datum/storyteller_roll/custom_roll/custom_roll = new()
	custom_roll.applicable_stats = output_stats
	custom_roll.difficulty = difficulty
	custom_roll.successes_needed = successes_needed
	custom_roll.roll_output_type = roll_type
	return custom_roll.st_roll(src, roll_target, bonus_dice)


/datum/storyteller_roll/custom_roll
	bumper_text = "произвольная проверка"

#define UI_MOB_DICE_ROLL "EAST-4:22,SOUTH+1:24"

/atom/movable/screen/dice_roll
	name = "Произвольная проверка"
	icon = 'icons/hud/screen_midnight.dmi'
	icon_state = "dice"
	screen_loc = UI_MOB_DICE_ROLL
	mouse_over_pointer = MOUSE_HAND_POINTER

/atom/movable/screen/dice_roll/Click()
	. = ..()

	var/mob/living/roller = astype(usr)
	roller?.roll_dice_custom()

#undef UI_MOB_DICE_ROLL
