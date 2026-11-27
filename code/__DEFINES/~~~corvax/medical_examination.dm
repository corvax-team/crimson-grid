/// Medicine dots from which limb damage, wounds and exhaustion are seen
#define MEDICAL_EXAM_TIER_DAMAGE 1
/// Medicine dots from which toxins, suffocation and aggravated damage are seen
#define MEDICAL_EXAM_TIER_SYSTEMIC 2
/// Medicine dots from which the examination needs no roll
#define MEDICAL_EXAM_AUTO_SUCCESS_LEVEL 3
/// Medicine dots from which organs, substance kinds and diseases are seen
#define MEDICAL_EXAM_TIER_INTERNAL 4
/// Medicine dots from which exact substances and rare findings are seen
#define MEDICAL_EXAM_TIER_EXPERT 5
/// Highest Medicine dots the examination report distinguishes
#define MEDICAL_EXAM_MAX_LEVEL 5
/// Examination parts, one examine link each
#define MEDICAL_EXAM_PART_STATE "state"
#define MEDICAL_EXAM_PART_WOUNDS "wounds"
#define MEDICAL_EXAM_PART_SUBSTANCES "substances"
/// Trait source for wounds studied during a medical examination
#define MEDICAL_EXAMINATION_TRAIT "medical_examination"
/// Sent to Kindred when their body destroys an incoming reagent: (reagent_type)
#define COMSIG_KINDRED_REAGENT_DESTROYED "kindred_reagent_destroyed"
