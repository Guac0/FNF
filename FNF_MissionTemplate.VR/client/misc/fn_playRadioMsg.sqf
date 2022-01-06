params ["_tgtSide", "_radioCode"];

if (playerSide != _tgtSide) exitWith {};

if !(getClientStateNumber >= 9) then {
  [{getClientStateNumber >= 9}, {
    params ["_tgtSide", "_radioCode"];
    _radioConfig = (missionconfigFile >> "CfgRadio" >> _searchCode);
    _name = configName _message;
    _subtitle = getText(_message >> "title");

    [_side, "HQ"] sideRadio _name;
    [_side, "HQ"] sideChat _subtitle;
  }, _this] call CBA_fnc_waitUntilAndExecute;
};

// _message = selectRandom ("true" configClasses (missionconfigFile >> "CfgRadio"));
_radioConfig = (missionconfigFile >> "CfgRadio" >> _searchCode);
_name = configName _message;
_subtitle = getText(_message >> "title");

[_side, "HQ"] sideRadio _name;
[_side, "HQ"] sideChat _subtitle;
