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

private _players = call phx_fnc_getSameSidePlayers;
private _occupiedGroups = [];

{
  _group = _x getVariable ["phx_startGroup",objNull];
  if !(_group in _occupiedGroups) then {_occupiedGroups pushBack _group};
} forEach _players;
