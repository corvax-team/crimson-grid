#define ANTEDILUVIAN_SCORE "Antediluvians Killed"
#define BOSS_MEDAL_ANTEDILUVIAN "Antediluvian Killer"
/mob/living/simple_animal/hostile/megafauna/wendigo/antediluvian
	name = "Unknown Methuselah"
	desc = "Легендарный Сородич, о каких рассказывают в мифах. Вряд ли вы это переживёте."
	health = 2500
	maxHealth = 2500
	icon_state = "eva"
	icon_living = "eva"
	icon_dead = "eva_dead"
	icon = 'modular_darkpack/modules/antediluvian_sarcophagus/icons/the_antediluvian.dmi'
	pixel_x = 0
	base_pixel_x = 0
	guaranteed_butcher_results = list()
	crusher_loot = null
	death_message = "падает, и земля вокруг содрогается"
	achievement_type = /datum/award/achievement/boss/antediluvian_kill
	score_achievement_type = /datum/award/score/antediluvian_score

/mob/living/simple_animal/hostile/megafauna/colossus/antediluvian
	name = "Unknown Methuselah"
	desc = "Легендарный Сородич, о каких рассказывают в мифах. Вряд ли вы это переживёте."
	health = 2500
	maxHealth = 2500
	icon_state = "eva"
	icon_living = "eva"
	icon_dead = "eva_dead"
	icon = 'modular_darkpack/modules/antediluvian_sarcophagus/icons/the_antediluvian.dmi'
	pixel_x = 0
	base_pixel_x = 0
	achievement_type = /datum/award/achievement/boss/antediluvian_kill
	score_achievement_type = /datum/award/score/antediluvian_score

/datum/award/achievement/boss/antediluvian_kill
	name = "Убийца мафусаила"
	desc = "Чем они больше... тем богаче добыча"
	database_id = BOSS_MEDAL_ANTEDILUVIAN
	icon_state = "firstboss"

/datum/award/score/antediluvian_score
	name = "Убито мафусаилов"
	desc = "Вы убили СКОЛЬКО?"
	database_id = ANTEDILUVIAN_SCORE

#undef ANTEDILUVIAN_SCORE
#undef BOSS_MEDAL_ANTEDILUVIAN
