//set current grenades to default from laodout init
phx_selector_currentGrenades = phx_loadout_thermite;

phx_selector_fnc_grenades = {
  private _expArr = _this;

  if (_expArr isEqualTo phx_selector_currentGrenades) exitWith {};

  private _missing = false;

  {
    private ["_expClass","_expCount"];

    //make sure player has all old grenades to be able to add new ones
    if (_forEachIndex != 0) then {
      if (_x find ":" != -1) then {
        _expClass = _x splitString ":" select 0;
        _expCount = parseNumber (_x splitString ":" select 1);
      } else {
        _expClass = _x;
        _expCount = 1;
      };

      if ({_x == _expClass} count magazines player < _expCount) then {
        _missing = true;
      };
    };
  } forEach phx_selector_currentGrenades;

  //removes old grenades and adds new ones if player still has old ones
  if (!_missing) then {
    {
      player removeMagazines (_x splitString ":" select 0);
    } forEach phx_selector_currentGrenades;

    {
      if (_forEachIndex != 0) then {
        _x call phx_fnc_addGear;
      };
    } forEach _expArr;

    format ["Grenade loadout changed to:\n %1", _expArr select 0] call phx_fnc_hintThenClear;

    phx_selector_currentGrenades = _expArr;
  } else {
    "Missing items" call phx_fnc_hintThenClear;
  };
};

//grenades actions
{
  _action = ["Grenades_Selector",_x select 0,"",{
    (_this select 2) call phx_selector_fnc_grenades;
  },{true}, {}, _x] call ace_interact_menu_fnc_createAction;
  [(typeOf player), 1, ["ACE_SelfActions","Gear_Selector","Grenades_Selector"], _action] call ace_interact_menu_fnc_addActionToClass;
} forEach phx_selector_grenades;
