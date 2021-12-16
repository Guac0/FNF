private _colors = [
    "#8080FF", // light blue
    "#80FF80", // light green
    "#FF8080", // light red
    "#FFFF80", // light yellow
    "#FF80FF", // light pink
    "#00FFE5", //turquoise
    "#FFC080", // light orange
    "#00FF87", //aquamarine
    "#B960FF", //light purple
    "#FF8181" //beige red
];

//private _players = call phx_fnc_getSameSidePlayers;
private _players = allUnits; //ai test
private _realGroups = [];

{
  private _groupStr = _x select 0;
  private _group = missionNamespace getVariable [_groupStr, grpNull];

  if !(_group isEqualTo grpNull) then {
    _realGroups pushBack [_group,[]];
  } else {
    [format ["An ORBAT group doesn't match a mission group: %1", _groupStr], "error", 10] call phx_ui_fnc_notify;
  };
} forEach phx_groups;

{
  private _player = _x;
  private _group = _player getVariable ["phx_startGroup",objNull];
  private _playerGroupIndex = [_realGroups, _group] call BIS_fnc_findNestedElement;

  if (count _playerGroupIndex > 0) then {
    _realGroups apply {
      if (_x select 0 == _group) then { //group element
        (_x select 1) pushBack _player; //player array
      };
    };
  };
} forEach _players;

balls = _realGroups;
