if (!isServer) exitWith {};

[west, 1] call BIS_fnc_respawnTickets;
[east, 1] call BIS_fnc_respawnTickets;
[west, -1] call BIS_fnc_respawnTickets;
[east, -1] call BIS_fnc_respawnTickets;

call phx_fnc_serverSafety;
//call phx_fnc_markCustomObjs;

phx_blueTeamScore = 0;
phx_redTeamScore = 0;
phx_terminalScoreWaiting = false;

"bluforSafeMarker" setMarkerColor "colorBLUFOR";
"opforSafeMarker" setMarkerColor "colorOPFOR";

//Create map cover for zone boundary
private _zoneArea = triggerArea zoneTrigger;
zoneTrigger setVariable ["objectArea", [_zoneArea select 0, _zoneArea select 1, _zoneArea select 2]];
[zoneTrigger,[],true] call BIS_fnc_moduleCoverMap;

// Create respawn markers in bottom left corner of map
{
    private _marker = createMarker [_x, [-1000,-1000,0]];
    _marker setMarkerShape "ICON";
    _marker setMarkerType "Empty";
} forEach ["respawn","respawn_west","respawn_east","respawn_guerrila","respawn_civilian"];

//Delete player bodies during safe start
[{if (phx_safetyEnabled) then {
  {
		deleteVehicle _x;
	} forEach allDeadMen;
}},1] call CBA_fnc_addPerFrameHandler;

[{!isNil "phx_safetyEndTime"}, {call phx_fnc_checkTime}] call CBA_fnc_waitUntilAndExecute;

if (TAS_gamemode == "TDM") then {
  call PHX_fnc_terminalServerSetup;
};

if (TAS_gamemode == "CTF") then {

  //stuff we need to do for cleanup: everything with marker, flag texture
  //TODO phx hint then clear, flag map delay, overtime, take from uncon
  hideObjectGlobal term1;

  TAS_flagPole = createVehicle ["FlagPole_F", getPosAtl term1, [], 0, "CAN_COLLIDE"];
  TAS_flagPole setFlagTexture "\A3\Data_F\Flags\flag_white_CO.paa"; //"\A3\Data_F\Flags\Flag_CSAT_CO.paa"; "\A3\Data_F\Flags\flag_NATO_CO.paa";
  TAS_flagPole setFlagSide independent;

  TAS_flagMarker = createMarkerLocal ["flagMarker",position TAS_flagPole];
  TAS_flagMarker setMarkerTypeLocal "hd_flag";
  TAS_flagMarker setMarkerText "Flag";

  //todo make marker
  _handle = [{
    params ["_flagMarker", "_handle"];
    private _flagHolder = flagOwner TAS_flagPole;
    if (phx_gameEnd) exitWith {/*[_handle] call CBA_fnc_removePerFrameHandler*/};

    if ( _flagHolder isEqualTo objNull ) exitWith { TAS_oldFlagOwner = _flagHolder; }; //skip if on flagpole (resets to flagpole are handled elsewhere or not done at all)

    if (TAS_oldFlagOwner != _flagHolder) then {  //flag has been taken
      switch (side _flagHolder) do {
        case west: {
          //private _ownerSide = west;
          "Blue Team has taken the flag!" remoteExec ["hint"];
          _flagMarker setMarkerType "Faction_BLUFOR_EP1";
          TAS_flagPole setFlagTexture "\A3\Data_F\Flags\flag_blue_CO.paa"; //\A3\Data_F\Flags\flag_NATO_CO.paa
          //_flag setFlagSide west; //do not update side so that any player can take it once current holder dies
        };
        case east: {
          //private _ownerSide = east;
          "Red Team has taken the flag!" remoteExec ["hint"];
          _flagMarker setMarkerType "Faction_OPFOR_EP1";
          TAS_flagPole setFlagTexture "\A3\Data_F\Flags\flag_red_CO.paa"; //\A3\Data_F\Flags\flag_CSAT_CO.paa
          //_flag setFlagSide east; //do not update side so that any player can take it once current holder dies
        };
        default { //does NOT get shown when unit dies! in fact, should never get shown!
          "The flag has been dropped!" remoteExec ["hint"];
          _flagMarker setMarkerType "hd_flag"; //TODO
          //_flagMarker setMarkerColor "ColorBlack";
          TAS_flagPole setFlagTexture "\A3\Data_F\Flags\flag_white_CO.paa";
        };
      };
    };

    if (!(alive _flagHolder) || myUnit getVariable ["ACE_isUnconscious", false];) then { //TODO check if you can take from uncon
      "The flag has been dropped!" remoteExec ["hint"];
      _flagMarker setMarkerType "hd_flag";
      //_flagMarker setMarkerColor "ColorBlack";
      TAS_flagPole setFlagTexture "\A3\Data_F\Flags\flag_white_CO.paa";
    };

    if (((_flagHolder) inArea "opforSafeMarker") && (side (_flagHolder) != east)) then { 
      "Blue Team has delivered the flag!" remoteExec ["hint"];
      phx_gameEnd = true;
      publicVariable "phx_gameEnd";
      west call PHX_fnc_titanMultiRoundHandler;
    };
    if (((_flagHolder) inArea "bluforSafeMarker") && (side (_flagHolder) != west)) then {
      "Red Team has delivered the flag!" remoteExec ["hint"];
      phx_gameEnd = true;
      publicVariable "phx_gameEnd";
      east call PHX_fnc_titanMultiRoundHandler;
    };

    _flagMarker setMarkerPos getPos _flagHolder; //remains at starting point if still on pole. TODO reset position.

    TAS_oldFlagOwner = _flagHolder;
  }, 0.25, TAS_flagMarker] call CBA_fnc_addPerFrameHandler;
};