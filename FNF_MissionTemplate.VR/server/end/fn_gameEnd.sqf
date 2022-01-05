params ["_sideWon", "_condition"];

phx_gameEnd = true;
// publicVariable "phx_gameEnd";

private _sideWonStr = str _sideWon;
private _sideWonName = _sideWon call BIS_fnc_sideName;

[{
  if (isClass (configFile >> "CfgPatches" >> "OCAP")) then {
    [_sideWon, format["%1 %2", _sideWonName, _condition]] call ocap_fnc_exportData;
  };

  if (count allPlayers > 14) then {
    [format["%1 %2", _sideWonName, _condition]] call phx_fnc_webhook_roundEnd;
  };

  "end1" call BIS_fnc_endMissionServer;
}, [], 10] call CBA_fnc_waitAndExecute;
