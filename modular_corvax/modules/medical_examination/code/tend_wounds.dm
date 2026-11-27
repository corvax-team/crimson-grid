// A trained doctor tracks how much damage is left without an analyzer
/datum/surgery_operation/basic/tend_wounds/show_stats(mob/living/surgeon, mob/living/patient)
	if(surgeon.st_get_stat(STAT_MEDICINE) >= MEDICAL_EXAM_AUTO_SUCCESS_LEVEL)
		return TRUE
	return ..()
