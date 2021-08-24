/*
Disables typing in global, side and spectator chat if player is not staff
*/

[{!isNil "fnf_staffInfo"}, {
  if ((getPlayerUID player) in fnf_staffInfo) then {
    0 enableChannel true; //Make sure global is enabled if admin
  } else {
    // if not admin, disable global entirely (doesn't block incoming )
    _disableChannels = [
      0, // global
      2 // command
    ];

    {
      private _channelId = _x;
      _channelId enableChannel false;
    } forEach _disableChannels;
  };

  // make these channels Text Only for all for marker placement purposes
   _textOnlyChannels = [
      1, // side
      3, // group
      4, // vehicle
      5 // direct
    ];

    {
      private _channelId = _x;
      _channelId enableChannel [true, false];
    } forEach _textOnlyChannels;
}] call CBA_fnc_waitUntilAndExecute;

//Disable chat typing if channel is side
[{
  params ["_display","_handle"];
  if (!isNull (findDisplay _display)) exitWith {
    _handle call CBA_fnc_removePerFrameHandler;
    phx_sideChatRestrict = (findDisplay _display) displayAddEventHandler ["KeyDown", "if (_this select 1 in actionKeys 'Chat' && currentChannel == 1) then { true } else { false };"];
  };
}, 1, 46] call CBA_fnc_addPerFrameHandler; //Mission display

[{
  params ["_display","_handle"];
  if (!isNull (findDisplay _display)) exitWith {
    _handle call CBA_fnc_removePerFrameHandler;
    phx_spectatorChatRestrict = (findDisplay _display) displayAddEventHandler ["KeyDown", "if (_this select 1 in actionKeys 'Chat') then { true } else { false };"];
  };
}, 1, 60000] call CBA_fnc_addPerFrameHandler; //ACE spectator display


[{!isNil "ace_spectator_channel"}, {
  // set Spectator channel available while dead to text-only
  ace_spectator_channel enableChannel [true, false];
}] call CBA_fnc_waitUntilAndExecute;