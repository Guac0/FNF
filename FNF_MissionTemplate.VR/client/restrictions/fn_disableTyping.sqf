/*
Disables typing in global, side and spectator chat if player is not staff
*/

[{!isNil "fnf_staffInfo"}, {
  if ((getPlayerUID player) in fnf_staffInfo) then {
    0 enableChannel true; //Make sure global is enabled if admin
  } else {

    _disableChannels = [
      0, // global
      1, // side
      2 // command
    ];

    {
      private _channelId = _x;
      _x enableChannel false;
    } forEach _disableChannels;

    _textOnlyChannels = [
      3, // group
      4, // vehicle
      5 // direct
    ];

    {
      private _channelId = _x;
      _x enableChannel [true, false];
    } forEach _textOnlyChannels;
  };
}] call CBA_fnc_waitUntilAndExecute;


[] spawn {
  while (true) {
    waitUntil {!isNil "ace_spectator_isSet"};
    waitUntil {ace_spectator_isSet};
      // TODO: Find what channel ID number ACE Spectator uses for spectator chat, to disable
      // # enableChannel false;
  };
};