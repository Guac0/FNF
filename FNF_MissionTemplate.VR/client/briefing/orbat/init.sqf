player setVariable ["phx_startGroup", group player, true]; //todo server handle this?
phx_orbat_playersSet = false;

{
  _x setVariable ["phx_startGroup", group _x, true];
} forEach allUnits; //ai test

call compile preprocessFileLineNumbers "client\briefing\orbat\blue.sqf";

phx_fnc_getSameSidePlayers = {
  //(call BIS_fnc_listPlayers) select {(_x call BIS_fnc_objectSide) isEqualTo playerSide};
  allUnits select {(_x call BIS_fnc_objectSide) isEqualTo playerSide}; //ai test
};

[{
  params ["_time","_handle"];

  private _sidePlayers = call phx_fnc_getSameSidePlayers;

  phx_orbat_playersSet = {
    if ((_x getVariable ["phx_startGroup",grpNull]) isEqualTo grpNull) exitWith {false}; true;
  } forEach _sidePlayers;

  //Exit if timeout or all players on player's side have their starting group set
  if ((diag_tickTime + 5 > _time) || phx_orbat_playersSet) exitWith {_handle call CBA_fnc_removePerFrameHandler; phx_orbat_playersSet = true};
}, 1, diag_tickTime] call CBA_fnc_addPerFrameHandler;

[{missionNamespace getVariable ["phx_orbat_playersSet",false]}, {call compile preprocessFileLineNumbers "client\briefing\orbat\createOrbat.sqf"}] call CBA_fnc_waitUntilAndExecute;
