phx_LoadoutChosen = false;

phx_term1HackingSide = sideEmpty;

call PHX_fnc_roles;
call phx_fnc_safety;

[false] call ace_spectator_fnc_setSpectator;
[{time > 0}, {call phx_fnc_restrictions;}] call CBA_fnc_waitUntilAndExecute;