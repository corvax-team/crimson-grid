#define CHOICE_15 "15 минут"
#define CHOICE_30 "30 минут"
#define CHOICE_60 "1 час"
#define CHOICE_NO "Не продлевать"

/datum/vote/extend_night
	name = "Продлить ночь"
	default_choices = list(
		CHOICE_15,
		CHOICE_30,
		CHOICE_60,
		CHOICE_NO
	)
	default_message = "Голосование за продление ночи на выбранное время."

/datum/vote/extend_night/can_be_initiated(forced)
	. = ..()
	if(. != VOTE_AVAILABLE)
		return .

	if(forced)
		return VOTE_AVAILABLE

	if(SScity_time.daytime_started)
		return "Ночь уже закончилась."

	return VOTE_AVAILABLE

/datum/vote/extend_night/finalize_vote(winning_option)
	switch(winning_option)
		if(CHOICE_NO)
			return
		if(CHOICE_15)
			SScity_time.extend_round(15 MINUTES)
		if(CHOICE_30)
			SScity_time.extend_round(30 MINUTES)
		if(CHOICE_60)
			SScity_time.extend_round(1 HOURS)

#undef CHOICE_15
#undef CHOICE_30
#undef CHOICE_60
#undef CHOICE_NO
