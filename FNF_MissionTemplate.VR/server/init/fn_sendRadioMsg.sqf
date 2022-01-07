params ["_category", "_event", ["_atkSide", [sideEmpty], [[]]]];

#define LANGUAGES ["LEN","LRU"]
#define ACCENTS ["AUS","AUK","ADE","ARU"]
#define ACCENTSWEST ["AUS","AUK","ADE"]
#define SUBSTRING(_key, _srch) ([_key, _srch] call BIS_fnc_inString)

{
  // CATEGORY_EVENT_SIDEROLE_SIDESTR_LANGUAGE_ACCENT_X
  private ["_sideRole", "_sideStr", "_lang", "_accent"];

  private _thisSide = _x;

  // let _event be determined by player's side, since it isn't a universal thing
  // _atkSide should be used to indicate the WINNING side
  if (_category == "END") then {
    if (_thisSide in _atkSide) then {_event = "WIN"} else {_event = "LOSS"};
  };

  if (_atkSide select 0 == sideEmpty) then {
    _sideRole = "ATT";
  } else {
    if (_thisSide in _atkSide) then {_sideRole = "ATT"};
    if !(_thisSide in _atkSide) then {_sideRole = "DEF"};
  };
  _sideStr = toUpper ((_thisSide call BIS_fnc_sideName) select [0,3]);

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
    _lang = "LEN";
    _accent = "ARU";
  };

  _searchCode = ([_category, _event, _sideRole, _sideStr, _lang, _accent] joinString "_") + "_";
  // "debug_console" callExtension ("searchCode: " + _searchCode);

  private _matchingRadioMsgs = format["[""%1"", configName _x] call BIS_fnc_inString", _searchCode] configClasses (configFile >> "CfgRadio");
  // "debug_console" callExtension ("found messages: " + str(_matchingRadioMsgs));

  if (count _matchingRadioMsgs > 0) then {
    _thisRadioMsg = configName (selectRandom _matchingRadioMsgs);

    // "debug_console" callExtension ("server picked " + _thisRadioMsg);

    if (_category in ["BEGIN", "END"]) then {
      phx_globalRadio_Start = ["FNF_PLAYRADIOMSG", [_thisSide, _thisRadioMsg]] call CBA_fnc_globalEventJIP;
      // "debug_console" callExtension ("Server sent global JIP event with args: " + str([_thisSide, _thisRadioMsg]));
    } else {
      ["FNF_PLAYRADIOMSG", [_thisSide, _thisRadioMsg]] call CBA_fnc_globalEvent;
      // "debug_console" callExtension ("Server sent global event with args: " + str([_thisSide, _thisRadioMsg]));
    };
  };
} forEach [west, east, independent];
// } forEach ([west, east, independent] select {playersNumber _x > 0});
