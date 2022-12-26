/*
Creates a safety for the player. Restricts shooting and throwing grenades.
Removed at safe start end.
*/

phx_loadoutAction = player addAction
[
	"Select Loadout",
	{
		phx_LoadoutChosen = false;
	},
	nil,
	1.5,
	true,
	false,
	"",
	"_originalTarget == _this"
];
TAS_tpSafeAction = player addAction
[
	"TP into Safe Start area",
	{
		private _debugMsg = format ["fn_safety: teleported player %3 with phx_playerSide of %1 and actual side of %2 to their start zone",phx_playerSide, side player, name player];
    _debugMsg remoteExec ["diag_log",2];
    diag_log _debugMsg;
    if (phx_playerSide == west) then
    {
      player setpos ("bluforSafeMarker" call BIS_fnc_randomPosTrigger);
    } else {
      if (phx_playerSide == east) then //check for this so that spectators and etc don't get teleported
      {
        player setpos ("opforSafeMarker" call BIS_fnc_randomPosTrigger);
      };
    };
	},
	nil,
	1,
	true,
	false,
	"",
	"_originalTarget == _this"
];


phx_safeStartNoFire = nil;

//Make player invincible
player allowDamage false;

//Heal player if they were damaged on start
[player] call ace_medical_treatment_fnc_fullHealLocal;

//Stop player from being able to fire weapon and throw grenades
phx_safetyMuzzles = getArray (configFile >> "CfgWeapons" >> "Throw" >> "muzzles");

[{missionNamespace getVariable ["ace_advanced_throwing_enabled",false]}, {ace_advanced_throwing_enabled = false}] call CBA_fnc_waitUntilAndExecute;

//Allow ACE placing and other actions that rely on left mouse button
phx_acePlacing = [{
  if (
    (missionNamespace getVariable ["ace_explosives_placeaction",0] == -1) ||
    (missionNamespace getVariable ["acex_fortify_isPlacing",0] == -1) ||
    (player getVariable ["ace_dragging_iscarrying",false]) ||
    (player getVariable ["ace_dragging_isdragging",false]) ||
    (player getVariable ["ace_trenches_isplacing",false]) ||
    (player getVariable ["ace_tripod_adjusting",false])
  ) then {
    if (!isNil "phx_safeStartNoFire") then {
      player removeAction phx_safeStartNoFire;
      phx_safeStartNoFire = nil;
    };
  } else {
    if (isNil "phx_safeStartNoFire") then {
      phx_safeStartNoFire = player addAction ["", {}, nil, 0, false, true, "defaultAction", "
      {
        _this setWeaponReloadingTime [_this, _x, 1];
      } forEach phx_safetyMuzzles;
      "];
    };
  };

  if (!phx_safetyEnabled) then {[_this select 1] call CBA_fnc_removePerFrameHandler};
} , 0] call CBA_fnc_addPerFrameHandler;

[{!phx_safetyEnabled}, {
  [phx_acePlacing] call CBA_fnc_removePerFrameHandler;
  player removeAction phx_loadoutAction;
  player removeAction TAS_tpSafeAction;
  player removeAction phx_safeStartNoFire;
  ace_advanced_throwing_enabled = true;
  player allowDamage true;
  call PHX_fnc_selector_remove;

  //prevent player from firing UBGLs for first 5 seconds of round
  phx_grenadeFiringPFH = [{
  if (CBA_missionTime - phx_safetyEndTime <= 5) then
  {
    _tempWeaponState = weaponState player;
    if (_tempWeaponState select 0 != _tempWeaponState select 1) then {
      if (isNil "phx_grenadeNoFire") then {
        phx_grenadeNoFire = player addAction ["", {}, nil, 0, false, true, "defaultAction", "
        {
          _this setWeaponReloadingTime [_this, _x, 1];
        } forEach phx_safetyMuzzles;
        "];
      };
    } else {
      if !(isNil "phx_grenadeNoFire") then {
        player removeAction phx_grenadeNoFire;
      };
    };
  } else {
    player removeAction phx_grenadeNoFire;
    _tempWeaponState = weaponState player;
    if (_tempWeaponState select 0 != _tempWeaponState select 1) then {
      hint "Grenade Launcher can now be fired";
    };
    [phx_grenadeFiringPFH] call CBA_fnc_removePerFrameHandler;
  };
  }] call CBA_fnc_addPerFrameHandler;

  //wait until round has ended and new round has been created and call client actions for new round items
  [{missionNamespace getVariable "newRound"},{call PHX_fnc_newRoundClient}] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_waitUntilAndExecute;
