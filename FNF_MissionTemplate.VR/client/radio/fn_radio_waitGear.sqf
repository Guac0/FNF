[{
  !isNil "phx_bluforBaseChannel" &&
  !isNil "phx_opforBaseChannel" &&
  !isNil "phx_indforBaseChannel" &&
  !isNil "phx_groupIDset"
}, {[] spawn phx_fnc_radio_getChannels}] call CBA_fnc_waitUntilAndExecute;
