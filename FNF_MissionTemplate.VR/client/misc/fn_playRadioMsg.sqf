// called by client-side listener CBA EH. will play appropriate radio message from config
// does not work with spectators or dead players

params ["_tgtSide", "_radioCode"];
// "debug_console" callExtension format["Client began processing event FNF_PLAYRADIOMSG with args: %1 , %2", _tgtSide, _radioCode];
if !(playerSide == _tgtSide || !hasInterface) exitWith {};


if !(getClientStateNumber >= 9) then {
  [{getClientStateNumber >= 9}, {
    params ["_tgtSide", "_radioCode"];
    _radioConfig = (configFile >> "CfgRadio" >> _radioCode);
    _name = configName _radioConfig;
    _subtitle = getText(_radioConfig >> "title");

    [playerSide, "HQ"] commandRadio _name;
    [playerSide, "HQ"] commandRadio _subtitle;
  }] call CBA_fnc_waitUntilAndExecute;
};

// _message = selectRandom ("true" configClasses (missionconfigFile >> "CfgRadio"));
_radioConfig = (configFile >> "CfgRadio" >> _radioCode);
_name = configName _radioConfig;
_subtitle = getText(_radioConfig >> "title");

[playerSide, "Base"] commandRadio _name;
[playerSide, "Base"] commandRadio _subtitle;
