/// Return from [COMSIG_REAGENTS_PRE_ADD_REAGENT]: the reagent leaves its source as if accepted, but is destroyed instead of being added.
/// Used where a refusal must not be told apart from a normal transfer.
#define COMPONENT_DESTROY_REAGENT_ADD (1<<1)
