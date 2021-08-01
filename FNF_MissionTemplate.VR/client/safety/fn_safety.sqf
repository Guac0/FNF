/*
Creates a safety for the player. Restricts shooting and throwing grenades.
Removed at safe start end.
*/

if (isNil "phx_clientSafetyRan") then {
  phx_clientSafetyRan = true;
  phx_clientSafetyException = false;
  phx_clientSafety = true;

  phx_safetyMuzzles = getArray (configFile >> "CfgWeapons" >> "Throw" >> "muzzles");

  phx_clientSafetyStatePFH = [{
    if ((vehicle player inArea phx_clientStartZone || phx_safetyEnabled) && alive player) then {
      phx_clientSafety = true;
    } else {
      phx_clientSafety = false;
    };
  } , 1] call CBA_fnc_addPerFrameHandler;
};

if (phx_safetyEnabled) then {[player] call ace_medical_treatment_fnc_fullHealLocal};

player allowDamage false;
call phx_fnc_handleSafetyVics;
phx_safeStartNoFire = player addAction ["", {}, nil, 0, false, true, "defaultAction", "!phx_clientSafetyException"];
[{missionNamespace getVariable ["ace_advanced_throwing_enabled",false]}, {ace_advanced_throwing_enabled = false}] call CBA_fnc_waitUntilAndExecute;

//Allow ACE placing and other actions that rely on left mouse button
phx_clientSafetyPFH = [{
  if (
    (missionNamespace getVariable ["ace_explosives_placeaction",0] == -1) ||
    (missionNamespace getVariable ["acex_fortify_isPlacing",0] == -1) ||
    (player getVariable ["ace_dragging_iscarrying",false]) ||
    (player getVariable ["ace_dragging_isdragging",false]) ||
    (player getVariable ["ace_trenches_isplacing",false]) ||
    (player getVariable ["ace_tripod_adjusting",false])
  ) then {phx_clientSafetyException = true} else {phx_clientSafetyException = false};

  if (isManualFire vehicle player) then {
    player action ["manualFireCancel", vehicle player];
  };

  {player setWeaponReloadingTime [player, _x, 1]} forEach phx_safetyMuzzles;

  if (!phx_clientSafety) then {[_handle] call CBA_fnc_removePerFrameHandler};
} , 0] call CBA_fnc_addPerFrameHandler;

"Safety Enabled" call phx_fnc_hintThenClear;

[{!phx_clientSafety}, {
  [phx_clientSafetyPFH] call CBA_fnc_removePerFrameHandler;
  player removeAction phx_safeStartNoFire;
  ace_advanced_throwing_enabled = true;
  player allowDamage true;
  phx_clientSafetyEndTime = diag_tickTime;
  if (alive player) then {"Safety Disabled" call phx_fnc_hintThenClear};

  [{phx_clientSafety && diag_tickTime > (phx_clientSafetyEndTime + 15)}, {call phx_fnc_safety}] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_waitUntilAndExecute;
