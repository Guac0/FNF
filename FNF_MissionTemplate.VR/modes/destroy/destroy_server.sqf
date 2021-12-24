//Only run server-side
if (!isServer) exitWith {};

#include "script_component.hpp"
#include "..\..\mode_config\destroy.sqf"

//Init vars
_taskCount = 1;
GVAR(aliveObjectives) = 0;

//Create array of objectives and global var for use in other scripts
GVAR(objectivesMeta) = [_obj1,_obj2,_obj3];
_objArr = GVAR(objectivesMeta);
GVAR(objectives) = _objArr apply {_x select 0};

//Delete pre-made objectives if not using
{
  _obj = _x;
  if (_objArr findIf {_x select 0 == _obj} == -1) then {
    deleteVehicle _x;
    deleteMarker ((str _x) + "_mark");
  };
} forEach [destroy_obj_1, destroy_obj_2];

//Set objective marker to defending side color
{
  _marker = _x select 1;

  switch (phx_defendingSide) do {
    case east: {_marker setMarkerColor "ColorEAST"};
    case west: {_marker setMarkerColor "ColorWEST"};
    case independent: {_marker setMarkerColor "ColorGUER"};
    default {_marker setMarkerColor "ColorCIV"};
  };
} forEach _objArr;

//Increase FNF_gamemode_destroy_aliveObjectives for each active objective
{
  if !(isNull (_x select 0)) then {
    INC(GVAR(aliveObjectives));

    //Reduce damage if obj is default cache
    if (typeOf (_x select 0) isEqualTo "Box_FIA_Ammo_F") then {
      (_x select 0) addEventHandler ["HandleDamage", {
        _unit = _this select 0;
        _selection = _this select 1;
        _damage = _this select 2;

        if (_selection == "?") exitWith {};

        _curDamage = damage _unit;
        if (_selection != "") then {_curDamage = _unit getHit _selection};
        _newDamage = _damage - _curDamage;

        _damage - _newDamage * 0.9;
      }];
    };
  };
} forEach _objArr;

//Tasks and task handlers
{
  if !(isNull (_x select 0)) then {
    _attackersTaskText = "Search for and destroy the ";

    _defendTaskID = "defendTask" + str _taskCount;
    _attackTaskID = "attackTask" + str _taskCount;

    private _itemConfig = [_x # 0] call CBA_fnc_getObjectConfig;
    private _itemPic = [_itemConfig >> "editorPreview", "STRING", "\A3\EditorPreviews_F\Data\CfgVehicles\Box_FIA_Ammo_F.jpg"] call CBA_fnc_getConfigEntry;

    [phx_defendingSide,_defendTaskID,[format["<img image='%1' width='300'>", _itemPic],format ["Defend the %1",_x select 2],_x select 1],_x select 0,"CREATED"] call BIS_fnc_taskCreate;
    [phx_attackingSide,_attackTaskID,[format["<img image='%1' width='300'>", _itemPic],format [_attackersTaskText + "%1",_x select 2],_x select 1],getMarkerPos (_x select 1),"CREATED"] call BIS_fnc_taskCreate;

    [(_x select 0), -1] call ace_cargo_fnc_setSize;

    //Check for alive objective
    [_x select 0, _x select 1, _defendTaskID, _attackTaskID] spawn {
      params ["_object","_markerName","_defendTaskID","_attackTaskID"];

      waitUntil {!alive _object};

      [_defendTaskID, "FAILED", true] call BIS_fnc_taskSetState;
      [_attackTaskID, "SUCCEEDED", true] call BIS_fnc_taskSetState;

      DEC(GVAR(aliveObjectives));
      [_markerName] remoteExec ["deleteMarkerLocal",0,true];
    };

    //Handle moving objective
    [_x select 0,_x select 1,_attackTaskID] spawn {
      _obj = _this select 0;
      _marker = _this select 1;
      _attackTaskID = _this select 2;
      _objMarkerUpdateTime = 10; //Change this value to however often you want the objective markers to update (seconds)
      _objMaxDistance = selectMin (getMarkerSize _marker);

      //Sets marker position to a random area around the objective, keeping the objective inside the marker
      if !(_obj inArea _marker) then {
        _marker setMarkerPos ([[[position _obj,(_objMaxDistance * random [0.1,0.7,1])]],[]] call BIS_fnc_randomPos);
      };
      [_attackTaskID, _marker] call BIS_fnc_taskSetDestination;

      //Loop over objective position every _objMarkerUpdateTime
      //If objective moves more than _objMaxDistance meters away from it's last known position, the objective marker will update
      while {alive _obj} do {
        if !(_obj inArea _marker) then {
          //Move the objective marker to a random position around the objective, while keeping the objective inside the marker's area
          _newPos = ([[[position _obj,(_objMaxDistance * random [0.1,0.7,1])]],[]] call BIS_fnc_randomPos);
          _marker setMarkerPosLocal _newPos;

          [_marker,_newPos] remoteExec ["setMarkerPosLocal",phx_attackingSide,_obj];
          [_attackTaskID, _marker] call BIS_fnc_taskSetDestination;
        };
        sleep _objMarkerUpdateTime;
      };
    };

    _taskCount = _taskCount + 1;
  };
} forEach _objArr;

//Check for win condition and end game if all objectives are destroyed
waitUntil {uiSleep 1; GVAR(aliveObjectives) < 1 && !phx_gameEnd};

//Send var to other scripts and clients to signal that the game has ended
phx_gameEnd = true;
publicVariable "phx_gameEnd";

[phx_attackingSide, "has successfully destroyed all objectives and won!"] spawn phx_fnc_gameEnd;
