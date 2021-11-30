disableSerialization;

params [
["_unit", objNull, [objNull], 1]
];

_rList = uiNamespace getVariable (["BIS_RscRespawnControlsMap_ctrlRoleList", "BIS_RscRespawnControlsSpectate_ctrlRoleList"] select (uiNamespace getVariable ["BIS_RscRespawnControlsSpectate_shown", false]));
_rName = _rList lbText (lbCurSel _rList);
_unit setVariable ["phxLoadout", (toUpper _rName), true];
// [_unit getVariable "phxLoadout"] call phx_fnc_applyCfgLoadout;

true
