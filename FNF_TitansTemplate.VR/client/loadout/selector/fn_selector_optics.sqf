if (pRole == ROLE_MK) exitWith {}; //don't want marksman to change optic

//Add magnified optics if enabled
if (phx_magnifiedOptics) then {
  phx_selector_optics append phx_selector_magOptics;
};

//diag_log format ["selector optics starting, list: %1",phx_selector_optics];

//optics actions
//condition is set to true because it keeps bugging out with the original code EXCEPT when using the official FNF optic list
{
  _action = ["Optic_Selector",getText (configFile >> "cfgWeapons" >> _x >> "displayName"),"",{
    _optic = _this select 2;
    player addPrimaryWeaponItem _optic;
    systemChat "If your optic didn't change, then it is incompatible with your current weapon!";
  },{true}, {}, _x] call ace_interact_menu_fnc_createAction;
  [(typeOf player), 1, ["ACE_SelfActions","Gear_Selector","Optic_Selector"], _action] call ace_interact_menu_fnc_addActionToClass;
} forEach phx_selector_optics; //(_this select 2) in ([primaryWeapon player, "optic"] call CBA_fnc_compatibleItems)

//first two were in forEach, removed now
//diag_log format ["added %1 to optic select",_x];
//diag_log format ["adding %1 to optic select...",_x];
//diag_log format ["selector optics finished, list: %1",phx_selector_optics];