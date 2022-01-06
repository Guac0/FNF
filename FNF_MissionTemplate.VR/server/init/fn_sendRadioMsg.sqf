params ["_category", "_event", "_atkSide"];

#define LANGUAGES ["LEN","LRU"]
#define ACCENTS ["AUS","AUK","ADE","ARU"]
#define ACCENTSWEST ["AUS","AUK","ADE"]
#define SUBSTRING(_key, _srch) ([_key, _srch] call BIS_fnc_inString)

{
  // CATEGORY_EVENT_SIDEROLE_SIDESTR_LANGUAGE_ACCENT_X
  private ["_sideRole", "_sideStr", "_lang", "_accent"];

  private _thisSide = _x;
  if (_atkSide == sideEmpty) then {
    _sideRole = "ATT";
  } else {
    if (_thisSide == _atkSide) then {_sideRole = "ATT"};
    if (_thisSide != _atkSide) then {_sideRole = "DEF"};
  };

  _sideStr = toUpper ((_thisSide call BIS_fnc_sideName) select [0,3]);
  if (_thisSide == sideLogic) then {_sideStr = "BLU"};



  // check playerSide uniform set for nationality
  private "_configSQFSideLabel";
  switch (_thisSide) do {
    case east: {_configSQFSideLabel = "opfor"};
    case west: {_configSQFSideLabel = "blufor"};
    case independent: {_configSQFSideLabel = "indfor"};
    default {_configSQFSideLabel = "blufor"};
  };
  _thisSideUniformSelection = missionNamespace getVariable ("phx_" + _configSQFSideLabel + "Uniform");
  // _thisSideGearSelection = missionNamespace getVariable ("phx_" + _sideLabel + "Gear");
  _lang = "LEN";
  _accent = selectRandom ACCENTSWEST;

  if (SUBSTRING("_US_", _thisSideUniformSelection)) then {
    _lang = "LEN";
    _accent = "AUS";
  };
  if (SUBSTRING("_ID_", _thisSideUniformSelection)) then {
    _lang = "LEN";
    _accent = "AUK";
  };
  if (SUBSTRING("_BUNDESWEHR_", _thisSideUniformSelection)) then {
    _lang = "LEN";
    _accent = "ADE";
  };
  if (
    SUBSTRING("_RU_", _thisSideUniformSelection) ||
    SUBSTRING("_ANY_", _thisSideUniformSelection)
  ) then {
    _lang = selectRandom ["LEN", "LRU"];
    _accent = "ARU";
  };

  _searchCode = [_category, _event, _sideRole, _sideStr, _lang, _accent] joinString "_";
  "debug_console" callExtension _searchCode;

  private _num = random(12);
  private _timesTried = 0;
  while {
    !isClass (missionConfigFile >> "CfgRadio" >> (_searchCode + str(_num)))
  } do {
    _num = random(12);
    _timesTried = _timesTried + 1;
    if (_timesTried >= 12) exitWith {_timesTried = false};
  };
  if !(_timesTried isEqualTo false) then {
    if (_category in ["BEGIN", "END"]) then {
      phx_globalRadio_Start = ["FNF_PLAYRADIOMSG", [_thisSide, _searchCode + str(_num)]] call CBA_fnc_globalEventJIP;
    } else {
      ["FNF_PLAYRADIOMSG", [_thisSide, _searchCode + str(_num)]] call CBA_fnc_globalEvent;
    };
  } else {
    diag_log formatText["Failed to load radio message ""%1""", _searchCode];
  };
} forEach ([west, east, independent] select {playersNumber _x > 0});
