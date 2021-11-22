if (!isServer) exitWith {};

phx_adminChannelId = radioChannelCreate [
	[1,1,0,1], // RGBA color
	"Staff Channel", // channel name
	"[STAFF] %UNIT_SIDE %UNIT_GRP_NAME %UNIT_NAME", // callsign
  []
];
publicVariable "phx_adminChannelId";

missionNamespace setVariable [
  "TFAR_DefaultRadio_Personal_Guer",
  TFAR_DefaultRadio_Personal_Independent,
  true
];
missionNamespace setVariable [
  "TFAR_DefaultRadio_Backpack_Guer",
  TFAR_DefaultRadio_Backpack_Independent,
  true
];

// call phx_fnc_serverSafety;
call phx_fnc_radio_genFreqs;
call phx_fnc_sendUniforms;
// call phx_fnc_fortifyServer;
// call phx_fnc_markCustomObjs;
// call phx_fnc_server_setupGame;
call phx_admin_fnc_adminPatch;
// call phx_fnc_webhook_roundPrep;

call phx_fnc_populateORBATs;
// call phx_fnc_keyVehicles;
call phx_fnc_vehicleRadios;


// [{!(missionNamespace getVariable ["phx_safetyEnabled",true])}, {call phx_fnc_checkAlive}] call CBA_fnc_waitUntilAndExecute;
// [{!isNil "phx_safetyEndTime"}, {call phx_fnc_checkTime}] call CBA_fnc_waitUntilAndExecute;

//Create map cover for zone boundary
// private _zoneArea = triggerArea zoneTrigger;
// zoneTrigger setVariable ["objectArea", [_zoneArea select 0, _zoneArea select 1, _zoneArea select 2]];
// [zoneTrigger,[],true] call BIS_fnc_moduleCoverMap;
phx_safeZone_BLUFOR_marker = ["safeZone_BLUFOR_marker", safeZone_BLUFOR] call BIS_fnc_markerToTrigger;
phx_safeZone_OPFOR_marker = ["safeZone_OPFOR_marker", safeZone_OPFOR] call BIS_fnc_markerToTrigger;

phx_safeZone_BLUFOR_marker setMarkerColor "ColorBLUFOR";
phx_safeZone_BLUFOR_marker setMarkerBrush "FDiagonal";

phx_safeZone_OPFOR_marker setMarkerColor "ColorOPFOR";
phx_safeZone_OPFOR_marker setMarkerBrush "FDiagonal";


// get config groups to potentially spawn
_vnAirGroups = [];

{
  private _base = _x;
  private _configNames = (_x  call Bis_fnc_getCfgSubClasses);
  {
    _vnAirGroups pushBack (_base >> _x);
  } forEach _configNames;
} forEach [
  (configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_air_army"),
  (configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_air_navy"),
  (configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_air_usaf"),
  (configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_air_usmc")
];

#define BOTTOM_LEFT (markerPos "ambient_helispawn_1")
#define TOP_LEFT (markerPos "ambient_helispawn_2")
#define TOP_RIGHT (markerPos "ambient_helispawn_3")
#define BOTTOM_RIGHT (markerPos "ambient_helispawn_4")

fnf_ambient_randomFlyby = [{
  _args spawn {
    params ["_cfgGroups","_paths"];
    selectRandom(_paths) params ["_startPos","_endPos"];
    private _thisGroup = [
      _startPos,
      civilian,
      selectRandom _cfgGroups,
      [],
      [],
      [],
      [],
      [],
      270, false, 50
    ] call BIS_fnc_spawnGroup;
    {
      switch (true) do {
        case (_x isKindOf "Plane"): {
          _x flyInHeightASL[500,500,500];
          // _x flyInHeight 100;
        };
        default {
          // _x flyInHeightASL[100,100,100];
          // _x flyInHeight 50;
          _x limitSpeed 200;
        };
      };

    } forEach (units _thisGroup);
    private _wpt = _thisGroup addWaypoint [_endPos, 300];
    _wpt setWaypointType "MOVE";
    _wpt setWaypointForceBehaviour true;
    _wpt setWaypointSpeed "NORMAL";
    _wpt setWaypointCompletionRadius 100;
    _wpt setWaypointFormation selectRandom([
      "STAG COLUMN",
      "FILE",
      "ECH LEFT",
      "WEDGE",
      "DIAMOND"
    ]);
    _thisGroup deleteGroupWhenEmpty true;
    waitUntil {currentWaypoint _thisGroup != 1};
    {deleteVehicle _x} count (units _thisGroup);
  };
}, random(120) + 120, [
  _vnAirGroups,
  [
    [BOTTOM_LEFT,TOP_RIGHT],
    [TOP_LEFT,BOTTOM_RIGHT],
    [TOP_RIGHT,BOTTOM_LEFT],
    [BOTTOM_RIGHT,TOP_LEFT]
  ]
]] call CBA_fnc_addPerFrameHandler;



// spawn flares at night
[{daytime >= 18 || daytime <= 6}, {
  [getPos fnf_sector_1] call vn_fnc_artillery_dawn_1;
  [{daytime < 18 && daytime > 6}, {
    [{daytime >= 18 || daytime <= 6}, {
      [getPos fnf_sector_1] call vn_fnc_artillery_dawn_1;
      [{daytime < 18 && daytime > 6}, {
        [{daytime >= 18 || daytime <= 6}, {
          [getPos fnf_sector_1] call vn_fnc_artillery_dawn_1;
        }] call CBA_fnc_waitUntilAndExecute;
      }] call CBA_fnc_waitUntilAndExecute;
    }] call CBA_fnc_waitUntilAndExecute;
  }] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_waitUntilAndExecute;


// Create respawn markers in bottom left corner of map
// {
//     private _marker = createMarker [_x, [-1000,-1000,0]];
//     _marker setMarkerShape "ICON";
//     _marker setMarkerType "Empty";
// } forEach ["respawn","respawn_west","respawn_east","respawn_guerrila","respawn_civilian"];

//Clear vehicle inventories
// ["AllVehicles", "init", {
//   private _vic = (_this select 0);
//   if (_vic isKindOf "Man") exitWith {}; //Exit so the code below doesn't run for infantry units

//   if (_vic getVariable ["fnf_clearInventory", true]) then {
//     clearBackpackCargoGlobal _vic;
//     clearWeaponCargoGlobal _vic;
//     clearItemCargoGlobal _vic;
//     clearMagazineCargoGlobal _vic;
//   };
// }, true, [], true] call CBA_fnc_addClassEventHandler;

//Delete player bodies during safe start
// phx_server_disconnectBodies = addMissionEventHandler ["HandleDisconnect", {
// 	params ["_unit", "_id", "_uid", "_name"];

//   if (phx_safetyEnabled) then {
//     deleteVehicle _unit;
//   } else {
//     //Not needed with ace_respawn_removeDeadBodiesDisconnected = false
//     //After safety ends, keep player bodies by transfering ownership of the unit to the server and then killing it
//     //[{owner (_this select 0) == 2}, {(_this select 0) setDamage 1;}, [_unit], 15] call CBA_fnc_waitUntilAndExecute;
//     //true;
//   };
// }];

// Receives event when a player submits a report
// Determines logged-in admin and sends Discord embed with contents of report and the admin @'ed
phxAdminMessageReceiver = ["phxAdminMessageServer", {
  private _arr = +_this;

  _loggedInAdmins = allPlayers select {
    (admin owner _x) isEqualTo 2 &&
    (getPlayerUID _x) in fnf_staffInfo;
  };
  private _adminDiscordID = "";
  if (count _loggedInAdmins > 0) then {
    _loggedInAdmin = fnf_staffInfo get (getPlayerUID (_loggedInAdmins # 0));
    _adminDiscordID = _loggedInAdmin # 2;
    _arr set [0, _adminDiscordID];
  };

  ["AdminMsg", _arr] call DiscordEmbedBuilder_fnc_buildCfg;
}] call CBA_fnc_addEventHandler;

//Let clients know that server is done setting up
missionNamespace setVariable ["phx_serverGameSetup",true,true];
