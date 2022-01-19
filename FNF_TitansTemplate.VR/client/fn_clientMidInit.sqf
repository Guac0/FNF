phx_LoadoutChosen = false;

phx_term1HackingSide = sideEmpty;

call PHX_fnc_roles;
call phx_fnc_safety;

//disable stamina after 'respawn' (new round)
player enableStamina false;

//sometimes client gets stuck in spectator so make sure to remove it with this
[false] call ace_spectator_fnc_setSpectator;

[{time > 0}, {call phx_fnc_restrictions;}] call CBA_fnc_waitUntilAndExecute;