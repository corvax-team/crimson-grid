## Hidden Places

Module ID: HIDDEN_PLACES

### Description:

Secret places can't be pinpointed by tracking. While someone is in one, the Blood Hunt, the Camarilla scroll (`masquerade_contract`), the Inquisition intel report (`intel_report`) and the Garou pocketwatch (`veil_contract`) give "Неизвестное расположение" instead of the area name, coordinates included. The Blood Hunt alert keeps the trail but shows the still `runed_sense1` icon instead of the direction arrow; the arrow returns once the target leaves.

A place is hidden by `hidden_from_tracking = TRUE` on its area type; subtypes inherit it. Hidden now:

- FBI hideout: `/area/vtm/interior/police/fed`
- Sabbat cave: `/area/vtm/interior/sabbat_lair`
- Millennium Tower floor 1 (the basement) and floors 3 and up: `/area/vtm/interior/millennium_tower` and its subtypes except `f2`, the public floor. The prince's elevator stays visible.
- Giovanni basement: `/area/vtm/interior/giovanni/basement`
- Anarch basement: `/area/vtm/interior/anarch/basement`
- All of the sewers: `/area/vtm/interior/sewer` and subtypes
- Triad basement: `/area/vtm/interior/laundromat/basement`, painted onto the basement under the laundromat on `sanfangsisco.dmm` (it used to be plain `/area/vtm/interior`).

### TG Proc/File Changes:

- `modular_darkpack/modules/masquerade/code/subsystem/bloodhunt.dm`: `/atom/movable/screen/alert/bloodhunt/Click`, `/atom/movable/screen/alert/bloodhunt/process`.
- `modular_darkpack/modules/masquerade/code/masquerade_contract.dm`: `attack_self` of `/obj/item/masquerade_contract`, `/obj/item/veil_contract`, `/obj/item/intel_report`.
- `_maps/map_files/Vampire/san_fangsisco/sanfangsisco.dmm`: the Triad basement painted with `/area/vtm/interior/laundromat/basement`.
- `tgstation.dme`: include.

### Modular Overrides:

- `modular_corvax/modules/hidden_places/code/hidden_places.dm`: `var/hidden_from_tracking` on `/area` and its values on the area types above; new area `/area/vtm/interior/laundromat/basement`; procs `is_hidden_from_tracking`, `get_tracked_location`.

### Defines:

- N/A

### Included files that are not contained in this module:

- `modular_corvax/modules/translations/public/ru_names/Прачечная_-_подвал.toml`: Russian name of the Triad basement area.

### Credits:

Corvax.
