//Only run client-side
if (!hasInterface) exitWith {};

#include "script_component.hpp"
#include "..\..\mode_config\destroy.sqf"

GVAR(objectivesMeta) = [_obj1,_obj2,_obj3];
_objArr = GVAR(objectivesMeta);
GVAR(objectives) = _objArr apply {_x select 0};

if (playerSide != phx_defendingSide) exitWith {};

{
  _obj = _x select 0;
  _mark = _x select 1;
  if (!isNull _obj) then {
    _mark setMarkerAlphaLocal 0;
  };
} forEach _objArr;
