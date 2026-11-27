## Medical examination

Module ID: MEDICAL_EXAMINATION

### Description:

Replaces the health analyzer with the Medicine ability. Any living character examining a carbon gets the line "Медицинский осмотр: состояние, раны, вещества" next to the Masquerade links, mirroring the analyzer's health, wound and chemical scans. Each link runs its own examination: the doctor must stand adjacent and keep still for 3 s minus 0.5 s per Medicine dot (0.5 s minimum). Bystanders see the examination start. Self-examination is allowed.

Medicine 0-2 rolls Intelligence + Medicine at difficulty 6 per link, shown only to the doctor. On a failure the doctor gets a vague line ("looks hurt" or "looks healthy"); for one minute that link on the same patient repeats the line without a new roll, while the other two links can still be tried. A botch also deals 1 brute to the patient. Medicine 3+ needs no roll.

- State: general status, body basics, damage table, vitals, organs, diseases, time of death, disabilities, rare findings.
- Wounds: wounds and embedded objects by body part; marks wounds as studied from level 3.
- Substances: blood alcohol, substances in blood and stomach, overdose, addictions, allergies; below level 4 it only says the doctor cannot tell.

Basic and simple mobs (animals) get what the health analyzer showed for them: the state link (general status; husking, exhaustion and damage totals from level 1; toxins and suffocation from 2; blood level and type and temperature from 3; diseases and time of death from 4; advanced-scanner findings at 5), plus the substances link when the mob has reagents. The analyzer's "no developed brain" line is left out on purpose.

What each line needs, by Medicine dots:

| Dots | Shown |
|---|---|
| 0 | General status in percent, missing limbs, prosthetic limbs and robotic organs |
| 1 | Brute and burn per limb, wound name and severity, husking, exhaustion; no pulse on a Kindred whose heart does not beat (`heart_is_beating()`, same rule as Auspex auras) |
| 2 | Total toxins and suffocation, aggravated damage per limb in purple words; a doctor with Obeah sees it as numbers |
| 3 | Blood level in words and blood type (Kindred blood carries a human group name), embedded objects, wound descriptions and recommended treatment, body temperature, quirks worth more than 4 points; marks every wound with `TRAIT_WOUND_SCANNED` (the wound analyzer treatment bonus); tend wounds surgery shows remaining damage as numbers |
| 4 | Organ status and appendices, blood alcohol, substance kinds in blood and stomach, overdose, addictions, diseases with cure, time of death, quirks worth 1 to 4 points |
| 5 | Exact substances with amounts, allergies, cause of husking, advanced-scanner findings (`COMSIG_LIVING_HEALTHSCAN` at `SCANPOWER_ADVANCED`, which covers hallucinations, and organ status at advanced power, which covers hazardous organs), "Раны затягиваются неестественно быстро" for a damaged Garou |

A Kindred whose heart beats shows a normal 37 °C at level 3. Substance kinds come from `/datum/reagent/var/medical_kind` set on the medicine, toxin, drug, consumable, ethanol and blood branches; `get_medical_kind()` checks analgesia and the opioid, stimulant and hallucinogen addiction types first. Consumables and blood are hidden.

Injecting a Kindred with a syringe or a hypospray (medipens included) at Medicine 5 tells the injector "Тело … странно реагирует на вещество." when the Kindred body destroyed what was injected.

The health analyzer and the wound analyzer are removed from the doctor's kit and the IFAK. The item types stay in tg code.

### TG Proc/File Changes:

- `code/modules/mob/living/carbon/examine.dm`: `/mob/living/carbon/examine()` adds the examination link.
- `modular_darkpack/modules/storage/code/firstaidkit.dm`: doctor's kit and IFAK no longer contain analyzers.
- `modular_darkpack/modules/vampire_the_masquerade/code/splats/kindred_splat/kindred_splat.dm`: `filter_reagent_intake()` sends `COMSIG_KINDRED_REAGENT_DESTROYED`.

### Modular Overrides:

- `code/kindred_injection.dm`: `/obj/item/reagent_containers/syringe/interact_with_atom()`, `/obj/item/reagent_containers/hypospray/inject()`.
- `code/tend_wounds.dm`: `/datum/surgery_operation/basic/tend_wounds/show_stats()`.
- `code/_medical_examination.dm`: `/mob/living/basic/examine()`, `/mob/living/simple_animal/examine()` add the examination link.

### Defines:

- `code/__DEFINES/~~~corvax/medical_examination.dm`: `MEDICAL_EXAM_TIER_*`, `MEDICAL_EXAM_AUTO_SUCCESS_LEVEL`, `MEDICAL_EXAM_MAX_LEVEL`, `MEDICAL_EXAM_PART_*`, `MEDICAL_EXAMINATION_TRAIT`, `COMSIG_KINDRED_REAGENT_DESTROYED`.

Each examine link has its own report file: `report_state.dm`, `report_wounds.dm`, `report_substances.dm`; animals use `report_animal.dm`. Disabilities come from `get_quirk_string()` exactly as on the health analyzer.

### Included files that are not contained in this module:

- N/A

### Credits:

Corvax team
