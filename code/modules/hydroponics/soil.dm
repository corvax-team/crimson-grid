
///////////////////////////////////////////////////////////////////////////////
/obj/machinery/hydroponics/soil //Not actually hydroponics at all! Honk!
	name = "soil"
	desc = "Клочок земли."
	icon = 'modular_darkpack/modules/drugs/icons/tray.dmi' // DARKPACK EDIT CHANGE
	icon_state = "soil"
	circuit = null
	density = FALSE
	use_power = NO_POWER_USE
	unwrenchable = FALSE
	self_sustaining_overlay_icon_state = null
	maxnutri = 15
	tray_flags = SOIL
	armor_type = /datum/armor/obj_soil
	custom_materials = list(/datum/material/sand = SHEET_MATERIAL_AMOUNT * 3)
	//which type of sack to create when shovled.
	var/sack_type = /obj/item/soil_sack
	var/wet_overlay = "soil_wet" // DARKPACK EDIT ADD

/obj/machinery/hydroponics/soil/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/tool_blocker, TOOL_SCREWDRIVER)
	AddElement(/datum/element/tool_blocker, TOOL_CROWBAR)

/obj/machinery/hydroponics/soil/update_icon(updates=ALL)
	. = ..()
	if(self_sustaining)
		add_atom_colour(rgb(255, 175, 0), FIXED_COLOUR_PRIORITY)

/obj/machinery/hydroponics/soil/update_status_light_overlays()
	// DARKPACK EDIT ADD START
	if(waterlevel > 10 && wet_overlay)
		. += mutable_appearance('modular_darkpack/modules/drugs/icons/tray.dmi', "soil_wet")
	// DARKPACK EDIT ADD END
	return // Has no lights

/obj/machinery/hydroponics/soil/item_interaction_secondary(mob/living/user, obj/item/tool, list/modifiers)
	if(tool.tool_behaviour != TOOL_SHOVEL) //Spades can still uproot plants on left click
		return ..()

	balloon_alert(user, "выкапываете грунт...")
	if(!tool.use_tool(src, user, 3 SECONDS, volume = 50))
		return ITEM_INTERACT_BLOCKING

	balloon_alert(user, "bagged")
	new sack_type(loc, src) //The bag handles sucking up the soil, stopping processing and setting relevants stats.
	return ITEM_INTERACT_SUCCESS

/obj/machinery/hydroponics/soil/click_ctrl(mob/user)
	return CLICK_ACTION_BLOCKING //Soil has no electricity.

/obj/machinery/hydroponics/soil/on_deconstruction(disassembled)
	new /obj/item/stack/ore/glass(drop_location(), 3)

///called when a soil is plopped down on the ground.
/obj/machinery/hydroponics/soil/proc/on_place()
	return

/datum/armor/obj_soil
	melee = 80
	bullet = 100
	laser = 90
	fire = 70
	acid = 30
	bomb = 15

/////////////// Advanced Soils //////////////

/obj/machinery/hydroponics/soil/vermaculite
	name = "vermaculite growing medium"
	desc = "Грядка из лёгких вспученных минеральных гранул.\n\nТакой грунт отлично пропускает воздух, что идёт растениям на пользу и особенно выручает при разведении черенков."
	icon = 'icons/obj/service/hydroponics/equipment.dmi' // DARKPACK EDIT ADD
	icon_state = "soil_verm"
	maxnutri = 20
	maxwater =  150
	tray_flags = SOIL | MULTIGRAFT | GRAFT_MEDIUM
	sack_type = /obj/item/soil_sack/vermaculite
	wet_overlay = null // DARKPACK EDIT ADD

/obj/machinery/hydroponics/soil/gel
	name = "hydrogel beads"
	desc = "Грядка из сверхвпитывающих полимерных шариков.\n\nТакие гелевые шарики удерживают невероятное количество воды и почти не дают ей испаряться."
	icon = 'icons/obj/service/hydroponics/equipment.dmi' // DARKPACK EDIT ADD
	icon_state = "soil_gel"
	gender = PLURAL
	maxwater = 300
	tray_flags = SOIL | HYDROPONIC | SUPERWATER
	plant_offset_y = 2
	sack_type = /obj/item/soil_sack/gel
	wet_overlay = null // DARKPACK EDIT ADD

/obj/machinery/hydroponics/soil/coir
	name = "coconut coir" // DARKPACK EDIT CHANGE
	desc = "Традиционный субстрат из кокосовой кожуры.\nВ нём много органики, поэтому любые грибы растут как на дрожжах и созревают быстрее." // DARKPACK EDIT CHANGE
	icon = 'icons/obj/service/hydroponics/equipment.dmi' // DARKPACK EDIT ADD
	icon_state = "soil_coir"
	maxnutri = 20
	tray_flags = SOIL | FAST_MUSHROOMS
	sack_type = /obj/item/soil_sack/coir
	wet_overlay = null // DARKPACK EDIT ADD

/obj/machinery/hydroponics/soil/worm
	name = "worm castings"
	desc = "Компост, который получается, когда скромный червь прилежно трудится над почвой.\n\nВ нём полно питательных веществ, высвобожденных пищеварением этих созданий. Скажите червю спасибо!"
	// icon_state = "soil_worm" // DARKPACK EDIT REMOVAL
	maxnutri = 35
	maxwater = 200
	tray_flags = SOIL | WORM_HABITAT | SLOW_RELEASE
	plant_offset_y = 4
	sack_type = /obj/item/soil_sack/worm

/* // DARKPACK EDIT REMOVAL
/obj/machinery/hydroponics/soil/worm/on_place()
	. = ..()
	flick("soil_worm_wiggle", src)
*/

/obj/machinery/hydroponics/soil/rich
	name = "rich soil"
	desc = "Клочок плодородной земли, какую обычно используют в садах."
	//icon_state = "rich_soil" // DARKPACK EDIT REMOVAL
	maxnutri = 20
	sack_type = /obj/item/soil_sack/rich

/////////////////// Soil Sacks ///////////////////////
/// Holder items that store the soils until deployed.
/obj/item/soil_sack
	name = "soil sack"
	desc = "Большой пластиковый мешок с покупным садовым грунтом: песок, торф и навоз. Вам такая смесь вряд ли по душе, но у растений свои вкусы."
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "soil_sack"
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	base_icon_state =  "soil_sack"
	force = 7
	throwforce = 17
	attack_speed = 1.2 SECONDS
	damtype = STAMINA
	block_sound = 'sound/effects/bodyfall/bodyfall1.ogg'
	w_class = WEIGHT_CLASS_HUGE
	item_flags = SLOWS_WHILE_IN_HAND
	resistance_flags = ACID_PROOF
	hitsound = 'sound/items/pillow/pillow_hit.ogg'
	drop_sound = 'sound/effects/footstep/woodbarefoot3.ogg' //could use better sounds in the future.
	throw_drop_sound = 'sound/effects/bodyfall/bodyfall3.ogg'
	custom_premium_price = PAYCHECK_CREW
	throw_range =  3
	throw_speed = 1
	slowdown = 1
	drag_slowdown = 1
	var/obj/machinery/hydroponics/soil/stored_soil = /obj/machinery/hydroponics/soil
	var/placement_sound = 'sound/effects/soil_plop.ogg'

/obj/item/soil_sack/Initialize(mapload, obj/machinery/hydroponics/soil/outside_soil)
	. = ..()
	AddComponent(/datum/component/two_handed, force_multiplier = 2, wield_callback = CALLBACK(src, PROC_REF(on_wield)), unwield_callback = CALLBACK(src, PROC_REF(on_unwield)))

	if(outside_soil)
		stored_soil = outside_soil
		stored_soil.remove_plant()
		stored_soil.forceMove(src)
		STOP_PROCESSING(SSmachines, stored_soil)
		animate(src, 100 MILLISECONDS, pixel_z = 4, easing = QUAD_EASING | EASE_OUT)
		animate(time = 100 MILLISECONDS, pixel_z = 0, easing = QUAD_EASING | EASE_IN)
		animate(time = 250 MILLISECONDS, pixel_x = rand(-6, 6), pixel_y = rand(-4, 4), flags = ANIMATION_PARALLEL)

/obj/item/soil_sack/Exited(atom/movable/gone)
	. = ..()
	if(gone == stored_soil)
		stored_soil = null
		qdel(src)

/obj/item/soil_sack/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isopenturf(interacting_with) || isgroundlessturf(interacting_with))
		return ..()

	if(locate(/obj/machinery/hydroponics/soil) in interacting_with)
		to_chat(user, span_alert("Здесь уже есть грядка!"))
		return ITEM_INTERACT_BLOCKING

	if(!do_after(user, 1 SECONDS, interacting_with))
		return ITEM_INTERACT_BLOCKING

	transfer_soil(interacting_with)
	return ITEM_INTERACT_SUCCESS

//Proc responsible for placing the soil inside track onto the turf or inside a hydroponic tray
/obj/item/soil_sack/proc/transfer_soil(atom/target, inside_tray = FALSE)
	if(ispath(stored_soil))
		stored_soil = new stored_soil(src)
		if(inside_tray)
			STOP_PROCESSING(SSmachines, stored_soil)
		stored_soil.reagents.add_reagent(/datum/reagent/plantnutriment/eznutriment, stored_soil.maxnutri / 2)
		stored_soil.waterlevel = stored_soil.maxwater
	else if(!inside_tray)
		START_PROCESSING(SSmachines, stored_soil)

	playsound(target, placement_sound, 65, vary = TRUE)
	if(!inside_tray)
		stored_soil.on_place()
	var/obj/machinery/hydroponics/soil_ref = stored_soil
	stored_soil.forceMove(target) //stored_soil is set to null at this point, and the soil sack is deleted when that happens
	return soil_ref

/obj/item/soil_sack/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == OVERWHELMING_ATTACK)
		return FALSE
	return ..()

///Remove slowdown and add block chance when wielded.
/obj/item/soil_sack/proc/on_wield()
	slowdown = 0
	if(ismob(loc))
		var/mob/wearer = loc
		wearer.update_equipment_speed_mods()
	block_chance = 25
	inhand_icon_state = "[base_icon_state]_w"

///Reapply slowdown and remove block chance when unwielded.
/obj/item/soil_sack/proc/on_unwield()
	slowdown = initial(slowdown)
	if(ismob(loc))
		var/mob/wearer = loc
		wearer.update_equipment_speed_mods()
	block_chance = initial(block_chance)
	inhand_icon_state = base_icon_state


/obj/item/soil_sack/vermaculite
	name = "NT vermaculite sack"
	desc = "Мешок вспученных минеральных гранул, которые заменяют растениям почву.\n\nВам нравится думать, что это мешок каменного попкорна, который даёт корням дышать."
	icon_state = "soil_sack_verm"
	base_icon_state = "soil_sack_verm"
	custom_premium_price = PAYCHECK_CREW * 2
	stored_soil = /obj/machinery/hydroponics/soil/vermaculite
	slowdown = 0

/obj/item/soil_sack/gel
	name = "hydrogel bead sack"
	desc = "Мешок сверхвпитывающих гелевых шариков по последнему слову техники! Интересно, какой смысл возить их уже напитанными водой..."
	icon_state = "soil_sack_gel"
	base_icon_state = "soil_sack_gel"
	custom_premium_price = PAYCHECK_CREW * 2
	placement_sound = 'sound/effects/meatslap.ogg'
	stored_soil = /obj/machinery/hydroponics/soil/gel

/obj/item/soil_sack/coir
	name = "#1™ coconut coir sack" // DARKPACK EDIT CHANGE
	desc = "Мешок кокосового субстрата. Волокнистую кожуру компостируют, пока она не распадётся на отдельные волокна.\n\nОтличная питательная среда для грибов." // DARKPACK EDIT CHANGE
	icon_state = "soil_sack_coir"
	base_icon_state = "soil_sack_coir"
	custom_premium_price = PAYCHECK_CREW * 3
	stored_soil = /obj/machinery/hydroponics/soil/coir

/obj/item/soil_sack/worm
	name = "worm castings sack"
	desc = "Мешок вермикомпоста, он же биогумус.\n\nВ этом навозе беспозвоночных есть не только питательные вещества и непереваренная органика, но и богатая флора полезных микроорганизмов."
	icon_state = "soil_sack_worm"
	base_icon_state = "soil_sack_worm"
	custom_premium_price = PAYCHECK_CREW * 4
	stored_soil = /obj/machinery/hydroponics/soil/worm

/obj/item/soil_sack/rich
	name = "rich soil sack"
	desc = "Мешок жирного чернозёма.\nСтоит на него взглянуть, и вы ощущаете чуть более тесную связь с землёй."
	custom_premium_price = PAYCHECK_CREW * 1.5
	stored_soil = /obj/machinery/hydroponics/soil/rich
