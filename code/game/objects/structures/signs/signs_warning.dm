//warning signs


///////DANGEROUS THINGS

/obj/structure/sign/warning
	name = "\improper WARNING sign"
	sign_change_name = "Warning"
	desc = "Предупреждающий знак."
	icon_state = "securearea"
	is_editable = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning, 32)
MAPPING_DIAGONAL_HELPERS(/obj/structure/sign/warning, 32)

/obj/structure/sign/warning/secure_area
	name = "\improper SECURE AREA sign"
	sign_change_name = "Warning - Secure Area"
	desc = "Предупреждающий знак с надписью \"ОХРАНЯЕМАЯ ЗОНА\"."

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/secure_area, 32)
MAPPING_DIAGONAL_HELPERS(/obj/structure/sign/warning/secure_area, 32)

/obj/structure/sign/warning/docking
	name = "\improper KEEP CLEAR: DOCKING AREA sign"
	sign_change_name = "Warning - Docking Area"
	desc = "Предупреждающий знак с надписью \"НЕ ЗАГРОМОЖДАТЬ: ЗОНА ПОГРУЗКИ\"."

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/docking, 32)

/obj/structure/sign/warning/biohazard
	name = "\improper BIOHAZARD sign"
	sign_change_name = "Warning - Biohazard"
	desc = "Предупреждающий знак с надписью \"БИОЛОГИЧЕСКАЯ ОПАСНОСТЬ\"."
	icon_state = "bio"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/biohazard, 32)

/obj/structure/sign/warning/electric_shock
	name = "\improper HIGH VOLTAGE sign"
	sign_change_name = "Warning - High Voltage"
	desc = "Предупреждающий знак с надписью \"ВЫСОКОЕ НАПРЯЖЕНИЕ\"."
	icon_state = "shock"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/electric_shock, 32)

/obj/structure/sign/warning/vacuum
	name = "\improper HARD VACUUM AHEAD sign"
	sign_change_name = "Warning - Hard Vacuum"
	desc = "Предупреждающий знак с надписью \"ВПЕРЕДИ ВАКУУМ\"."
	icon_state = "space"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/vacuum, 32)

/obj/structure/sign/warning/vacuum/external
	name = "\improper EXTERNAL AIRLOCK sign"
	sign_change_name = "Warning - External Airlock"
	desc = "Предупреждающий знак с надписью \"ВНЕШНИЙ ШЛЮЗ\"."
	layer = MOB_LAYER

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/vacuum/external, 32)

/obj/structure/sign/warning/deathsposal
	name = "\improper DISPOSAL: LEADS TO SPACE sign"
	sign_change_name = "Warning - Disposals: Leads to Space"
	desc = "Предупреждающий знак с надписью \"МУСОРОПРОВОД: ВЫХОД НАРУЖУ\"."
	icon_state = "deathsposal"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/deathsposal, 32)

/obj/structure/sign/warning/bodysposal
	name = "\improper DISPOSAL: LEADS TO MORGUE sign"
	sign_change_name = "Warning - Disposals: Leads to Morgue"
	desc = "Предупреждающий знак с надписью \"МУСОРОПРОВОД: ВЕДЁТ В МОРГ\"."
	icon_state = "bodysposal"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/bodysposal, 32)

/obj/structure/sign/warning/fire
	name = "\improper DANGER: FIRE sign"
	sign_change_name = "Warning - Fire Hazard"
	desc = "Предупреждающий знак с надписью \"ОГНЕОПАСНО\"."
	icon_state = "fire"
	resistance_flags = FIRE_PROOF

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/fire, 32)

/obj/structure/sign/warning/no_smoking
	name = "\improper NO SMOKING sign"
	sign_change_name = "Warning - No Smoking"
	desc = "Знак с надписью \"НЕ КУРИТЬ\"."
	icon_state = "nosmoking2"
	resistance_flags = FLAMMABLE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/no_smoking, 32)

/obj/structure/sign/warning/no_smoking/circle
	name = "\improper NO SMOKING sign"
	sign_change_name = "Warning - No Smoking Alt"
	desc = "Знак с надписью \"НЕ КУРИТЬ\"."
	icon_state = "nosmoking"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/no_smoking/circle, 32)

/obj/structure/sign/warning/yes_smoking/circle
	name = "\improper YES SMOKING sign"
	sign_change_name = "Warning - Yes Smoking"
	desc = "Знак с надписью \"КУРИТЬ МОЖНО\"."
	icon_state = "yessmoking"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/yes_smoking/circle, 32)

/obj/structure/sign/warning/radiation
	name = "\improper HAZARDOUS RADIATION sign"
	sign_change_name = "Warning - Radiation"
	desc = "Знак, предупреждающий о радиационной опасности."
	icon_state = "radiation"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/radiation, 32)

/obj/structure/sign/warning/radiation/rad_area
	name = "\improper RADIOACTIVE AREA sign"
	sign_change_name = "Warning - Radioactive Area"
	desc = "Предупреждающий знак с надписью \"РАДИОАКТИВНАЯ ЗОНА\"."

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/radiation/rad_area, 32)

/obj/structure/sign/warning/xeno_mining
	name = "\improper DANGEROUS ALIEN LIFE sign"
	sign_change_name = "Warning - Xenos"
	desc = "Знак предупреждает путников о враждебных формах жизни поблизости."
	icon = 'icons/obj/signs.dmi'
	icon_state = "xeno_warning"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/xeno_mining, 32)

/obj/structure/sign/warning/engine_safety
	name = "\improper ENGINEERING SAFETY sign"
	sign_change_name = "Warning - Engineering Safety Protocols"
	desc = "Стенд с правилами техники безопасности на объекте: всё ради того, чтобы смена прошла без происшествий."
	icon_state = "safety"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/engine_safety, 32)

/obj/structure/sign/warning/explosives
	name = "\improper HIGH EXPLOSIVES sign"
	sign_change_name = "Warning - Explosives"
	desc = "Предупреждающий знак с надписью \"ВЗРЫВООПАСНО\"."
	icon_state = "explosives"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/explosives, 32)

/obj/structure/sign/warning/explosives/alt
	name = "\improper HIGH EXPLOSIVES sign"
	sign_change_name = "Warning - Explosives Alt"
	desc = "Предупреждающий знак с надписью \"ВЗРЫВООПАСНО\"."
	icon_state = "explosives2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/explosives/alt, 32)

/obj/structure/sign/warning/test_chamber
	name = "\improper TESTING AREA sign"
	sign_change_name = "Warning - Testing Area"
	desc = "Знак предупреждает, что рядом работает мощное испытательное оборудование."
	icon_state = "testchamber"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/test_chamber, 32)

/obj/structure/sign/warning/firing_range
	name = "\improper FIRING RANGE sign"
	sign_change_name = "Warning - Firing Range"
	desc = "Знак напоминает: не выходите за огневой рубеж и надевайте наушники."
	icon_state = "firingrange"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/firing_range, 32)

/obj/structure/sign/warning/cold_temp
	name = "\improper FREEZING AIR sign"
	sign_change_name = "Warning - Temp: Cold"
	desc = "Знак предупреждает, что поблизости очень холодный воздух."
	icon_state = "cold"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/cold_temp, 32)

/obj/structure/sign/warning/hot_temp
	name = "\improper SUPERHEATED AIR sign"
	sign_change_name = "Warning - Temp: Hot"
	desc = "Знак предупреждает, что поблизости очень горячий воздух."
	icon_state = "heat"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/hot_temp, 32)

/obj/structure/sign/warning/gas_mask
	name = "\improper CONTAMINATED AIR sign"
	sign_change_name = "Warning - Contaminated Air"
	desc = "Знак предупреждает об опасных взвесях или газах в воздухе и требует надеть средства защиты дыхания."
	icon_state = "gasmask"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/gas_mask, 32)

/obj/structure/sign/warning/chem_diamond
	name = "\improper REACTIVE CHEMICALS sign"
	sign_change_name = "Warning - Hazardous Chemicals sign"
	desc = "Знак предупреждает, что рядом химически активные вещества: взрывчатые, горючие или едкие."
	icon_state = "chemdiamond"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/chem_diamond, 32)

/obj/structure/sign/warning/doors
	name = "\improper BLAST DOORS sign"
	sign_change_name = "Warning - Blast Doors"
	desc = "Знак сообщает, что здесь есть ворота. Ворота повсюду!"
	icon_state = "doors"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/doors, 32)

////MISC LOCATIONS

/obj/structure/sign/warning/pods
	name = "\improper ESCAPE PODS sign"
	sign_change_name = "Location - Escape Pods"
	desc = "Указатель с надписью \"СПАСАТЕЛЬНЫЕ КАПСУЛЫ\"."
	icon_state = "pods"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/pods, 32)

/obj/structure/sign/warning/rad_shelter
	name = "\improper RADSTORM SHELTER sign"
	sign_change_name = "Location - Radstorm Shelter"
	desc = "Указатель с надписью \"УКРЫТИЕ ОТ РАДИАЦИИ\"."
	icon_state = "radshelter"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/rad_shelter, 32)
