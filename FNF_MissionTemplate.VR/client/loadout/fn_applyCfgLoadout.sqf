if (!hasInterface || isDedicated) exitWith {};
waitUntil {!isNull player};

if (playerSide isEqualTo civilian) exitWith {
  phx_selector_optics = [];
  phx_selector_weapons = [];
  phx_selector_explosives = [];
  phx_selector_grenades = [];
  missionNamespace setVariable ["phx_loadoutAssigned",true];
  [
    "[%1] Player %2 loaded as civilian, loadout scripts cancelled",
    [(cba_missionTime),"HH:MM:SS"] call BIS_fnc_secondsToString,
    name player
  ] call BIS_fnc_logFormatServer;
};

player unlinkItem "ItemRadio";
{player unlinkItem _x} forEach (assignedItems player);
{
  player unassignItem _x;
  player removeItem _x;
} forEach [
"NVGoggles",
"NVGoggles_OPFOR",
"NVGoggles_INDEP"
];
removeAllItems player;
removeAllWeapons player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

params ["_LOADOUTROLE"];
if (!isNil {(player getVariable "phxLoadout")}) then {
  diag_log text format["[FNF] (loadout) INFO: Player role is %1.", (player getVariable "phxLoadout")];
};
if (isNil {_LOADOUTROLE}) exitWith {
  [{time > 2}, {
    ["<t align='center'>Error:<br/>Invalid role assignment. Please notify staff and select another slot.</t>", "error", 20] call phx_ui_fnc_notify;
    diag_log text format["[FNF] (loadout) ERROR: Slot has no role assigned."];
    [] spawn {
      sleep 10;
      endMission "END1";
    };
  }] call CBA_fnc_waitUntilAndExecute;
};

#define PLAYERLOADOUTVAR _LOADOUTROLE

private "_sideLabel";
switch (playerSide) do {
  case east: {_sideLabel = "opfor"};
  case west: {_sideLabel = "blufor"};
  case independent: {_sideLabel = "indfor"};
};
mySideUniformSelection = missionNamespace getVariable ("phx_" + _sideLabel + "Uniform");
mySideGearSelection = missionNamespace getVariable ("phx_" + _sideLabel + "Gear");
if (PLAYERLOADOUTVAR in ["MAT1","MATA1","MAT2","MATA2"]) then {
  [PLAYERLOADOUTVAR] call phx_fnc_setMAT;
  if (
    !phx_loadout_mediumantitank_isReloadable &&
    PLAYERLOADOUTVAR in ["MATA1","MATA2"]
  ) then {
    PLAYERLOADOUTVAR = "RI";
    player setVariable ["phxLoadout", "RI"];
  };
};


fnc_handleSHQAUX = {
  // handle the two members attached to squad HQs
  params [
    ["_unit", objNull],
    ["_role", "BASE"]
  ];

  private _settingStr = format[
    "phx_%1%2AuxRole",
    str(side (group _unit)),
    (
      ["Alpha","Bravo","Charlie","Delta"] select {
        [_x, roleDescription _unit] call BIS_fnc_inString
      }
    ) select 0
  ];
  private _setting = missionNamespace getVariable _settingStr;

  if (isNil "_setting") exitWith {
    [{time > 2}, {
      ["<t align='center'>Error:<br/>Failed to load AuxRole setting. Please notify the Missions team.</t>", "error", 20] call phx_ui_fnc_notify;
      diag_log text format["[FNF] (loadout) ERROR: Failed to load AuxRole setting. Please notify the Missions team."];
    }] call CBA_fnc_waitUntilAndExecute;
    true
  };

  if (_setting isEqualTo 0) exitWith {
    player setVariable ["phxLoadout", "CR"];
    ["CR"] call phx_fnc_applyCfgLoadout;
    diag_log text format["[FNF] (loadout) INFO: SHQAux setting is ""0"". Loading default crewman kit."];
    true
  };

  if (isNil "phx_cswItems") then {
    _setting params ["_weapon","_tripod","_mags"];
    missionNamespace setVariable ["phx_cswItems", [_weapon,_tripod]];
    missionNamespace setVariable ["phx_cswMags", _mags];

    {
      private _action = [
        "CSW_Selector",
        (if (_x isEqualTo "") then {"Ammo only"} else {getText (configFile >> "cfgWeapons" >> _x >> "displayName")}),
        "",
        { // statement (pass arg)
          (_this select 2) call phx_selector_fnc_csw;
        },
        { // condition
          phx_safetyEnabled &&
          (player getVariable "phxLoadout") isEqualTo "SHQAUX"
        },
        {},
        _x // arg to be used in param, arg is array
      ] call ace_interact_menu_fnc_createAction;
      [
        player,
        1,
        ["ACE_SelfActions","CSW_Selector"],
        _action
      ] call ace_interact_menu_fnc_addActionToObject;
    } forEach phx_cswItems;

    // KIT APPLIES HERE
    ["BASE"] call phx_fnc_applyCfgLoadout;

    private _mortarGear = (missionConfigFile >> "CfgLoadouts" >> "common" >> "mortarGear") call BIS_fnc_getCfgDataArray;

    // add hint to remind players to take their CSW gear
    [{time > 10}, {
      ["<t align='center'>Make sure you use ACE Self-interact to get your crew-served weapons gear!</t>", "info", 10] call phx_ui_fnc_notify;
      diag_log text format["[FNF] (loadout) DEBUG: Player notified about using ACE Self-interact to retrieve CSW gear."];
    }] call CBA_fnc_waitUntilAndExecute;
  };

  true
};

if (PLAYERLOADOUTVAR == "SHQAUX") exitWith {
  [player, PLAYERLOADOUTVAR] call fnc_handleSHQAUX;
};














fnc_getWeaponMagazines = {
  params ["_toSearch", "_weapon", ["_allMuzzles", true]];
  private _out = [];
  {
    if ((_x splitString ':' select 0) in ([_weapon, _allMuzzles] call CBA_fnc_compatibleMagazines)) then {
      _out pushBack _x;
    };
  } forEach _toSearch;
  _out
};



fnc_addUniform = {
  params [
    ["_unit", objNull],
    ["_uniform", ""],
    ["_vest", ""],
    ["_backpack", ""],
    ["_headgear", ""]
  ];
  _unit forceAddUniform _uniform;
  diag_log text format["[FNF] (loadout) INFO: Equipped uniform ""%1""", _uniform];
  _unit addVest _vest;
  diag_log text format["[FNF] (loadout) INFO: Equipped vest ""%1""", _vest];
  _unit addBackpack _backpack;
  diag_log text format["[FNF] (loadout) INFO: Equipped backpack ""%1""", _backpack];
  _unit addHeadgear _headgear;
  diag_log text format["[FNF] (loadout) INFO: Equipped headgear ""%1""", _headgear];
  true
};


fnc_giveRadios = {
  // Radios
  params [["_unit", objNull], ["_srRadio", true], ["_lrRadio", false]];

  if (_srRadio) then {
    if (!(call TFAR_fnc_haveSWRadio)) then {
      _unit linkItem ([side (group _unit), 1] call TFAR_fnc_getSideRadio);
      diag_log text format["[FNF] (loadout) INFO: Equipped SW radio ""%1""", [side (group _unit), 1] call TFAR_fnc_getSideRadio];
    };
    missionNamespace setVariable ["phx_hasSW", true];
  } else {
    if (call TFAR_fnc_haveSWRadio) then {
      player unlinkItem (call TFAR_fnc_activeSwRadio);
    };
    missionNamespace setVariable ["phx_hasSW", false];
  };


  if (_lrRadio) then {
    // Compensation: if a role is configured in Gear Set to have a LR radio but their backpack config isn't classified as one to TFAR, it will replace their backpack with a default stand-in. Similarly, if they have a radio-enabled backpack but shouldn't, it's replaced with a general tactical backpack.
    if (!(call TFAR_fnc_haveLRRadio)) then {
      private _items = backpackItems _unit;
      removeBackpack _unit;
      _unit addBackpack ([side (group _unit), 0] call TFAR_fnc_getSideRadio);
      {
        _unit addItemToBackpack _x;
      } forEach _items;
      diag_log text format["[FNF] (loadout) INFO: Equipped LR radio ""%1""", [side (group _unit), 0] call TFAR_fnc_getSideRadio];
    };
    missionNamespace setVariable ["phx_hasLR", true];
  } else {
    if (call TFAR_fnc_haveLRRadio) then {
      private _items = backpackItems _unit;
      removeBackpack _unit;
      _unit addBackpack "B_TacticalPack_blk";
      {
        _unit addItemToBackpack _x;
      } forEach _items;
    };
    missionNamespace setVariable ["phx_hasLR", false];
  };
  true
};


fnc_giveGear = {
  // Items, grenades
  params [
    ["_unit", objNull],
    ["_mags", []],
    ["_items", []],
    ["_backpackItems", []],
    ["_linkedItems", []]
  ];
  {[_x, "vest", _unit] call phx_fnc_addGear} forEach _mags;
  diag_log text format["[FNF] (loadout) INFO: Equipped gear (magazines)."];
  diag_log text format["[FNF] (loadout) DEBUG: %1", _mags];
  {[_x, "uniform", _unit] call phx_fnc_addGear} forEach _items;
  diag_log text format["[FNF] (loadout) INFO: Equipped gear (items)."];
  diag_log text format["[FNF] (loadout) DEBUG: %1", _items];
  {[_x, "backpack", _unit] call phx_fnc_addGear} forEach _backpackItems;
  diag_log text format["[FNF] (loadout) INFO: Equipped gear (backpackitems)."];
  diag_log text format["[FNF] (loadout) DEBUG: %1", _backpackItems];
  {_unit linkItem _x} forEach _linkedItems;
  true
};


fnc_givePrimaryWeapon = {
  // Primary weapon and appropriate magazines
  params [
    ["_unit", objNull],
    ["_cfgChoices", []]
  ];

  private _category = selectRandom(_cfgChoices);
  if (isNil "_category") exitWith {
    [{time > 2}, {
      ["<t align='center'>Error:<br/>Failed to process primary weapon settings.</t>", "error", 20] call phx_ui_fnc_notify;
      diag_log text "[FNF] (loadout) ERROR: Failed to process primary weapon settings.";
      diag_log text format["[FNF] (loadout) DEBUG: Choices: %1", _cfgChoices];
    }] call CBA_fnc_waitUntilAndExecute;
    nil
  };
  _category params ["_weapons","_mags"];
  phx_loadout_weapon = selectRandom(_weapons);
  phx_loadout_weaponMagazines = [_mags, phx_loadout_weapon] call fnc_getWeaponMagazines;

  if !(phx_loadout_weapon isEqualTo "" || (count phx_loadout_weaponMagazines) isEqualTo 0) then {
    _unit addWeapon phx_loadout_weapon;
    {[_x, "vest", _unit] call phx_fnc_addGear} forEach phx_loadout_weaponMagazines;
    diag_log text format["[FNF] (loadout) INFO: Equipped primary weapon ""%1""", phx_loadout_weapon];
    diag_log text format["[FNF] (loadout) INFO: Equipped primary weapon magazines"];
    diag_log text format["[FNF] (loadout) DEBUG: %1", phx_loadout_weaponMagazines];
    true
  } else {
    nil
  };
};
fnc_prepWeaponsSelector = {
  // iterate through _cfgWeaponChoices and add each weapon and appropriate mags to phx_selector_weapons so they can be chosen from
  params [
    ["_unit", objNull],
    ["_cfgChoices", []]
  ];

  private _weaponChoices = [];
  {
    _x params ["_weapons", "_mags"];
    {
      private _weapon = _x;
      private _compatMags = [_mags, _weapon] call fnc_getWeaponMagazines;
      _weaponChoices pushBack [_weapon, _compatMags];
    } forEach _weapons;
  } forEach _cfgChoices;

  // "debug_console" callExtension str(_weaponChoices);
  missionNamespace setVariable ["phx_selector_weapons", _weaponChoices];
  true
};


fnc_giveSidearmWeapon = {
  // Sidearm and appropriate magazines
  params [
    ["_unit", objNull],
    ["_cfgChoices", []]
  ];

  private _category = selectRandom(_cfgChoices);
  if (isNil "_category") exitWith {
    [{time > 2}, {
      ["<t align='center'>Error:<br/>Failed to process sidearm weapon settings.</t>", "error", 20] call phx_ui_fnc_notify;
      diag_log text "[FNF] (loadout) ERROR: Failed to process sidearm weapon settings.";
      diag_log text format["[FNF] (loadout) DEBUG: Choices %1", _cfgChoices];
    }] call CBA_fnc_waitUntilAndExecute;
  };
  _category params ["_sidearms","_mags"];
  phx_loadout_sidearm = selectRandom(_sidearms);
  phx_loadout_sidearmMagazines = [_mags, phx_loadout_sidearm] call fnc_getWeaponMagazines;

  if !(phx_loadout_sidearm isEqualTo "" || (count phx_loadout_sidearmMagazines) isEqualTo 0) then {
    _unit addWeapon phx_loadout_sidearm;
    {[_x, "uniform", _unit] call phx_fnc_addGear} forEach phx_loadout_sidearmMagazines;
    diag_log text format["[FNF] (loadout) INFO: Equipped secondary weapon ""%1""", phx_loadout_sidearm];
    diag_log text format["[FNF] (loadout) INFO: Equipped secondary weapon magazines"];
    diag_log text format["[FNF] (loadout) DEBUG: %1", phx_loadout_sidearmMagazines];
  };
  true
};


fnc_giveSilencer = {
  params [
    ["_unit", objNull],
    ["_giveSilencer", 0]
  ];

  if (_giveSilencer > 0 && !isNil "phx_loadout_weapon") then {
    _muzzleAcc = [phx_loadout_weapon, "muzzle"] call CBA_fnc_compatibleItems;
    _silencers = _muzzleAcc select {getNumber(configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "soundTypeIndex") > 0};
    if (count _silencers > 0) then {
      _unit addPrimaryWeaponItem (_silencers select 0);
      diag_log text format["[FNF] (loadout) INFO: Equipped silencer ""%1""", _silencers # 0];
    } else {
      diag_log text format["[FNF] (loadout) WARNING: Tried to equip silencer, but none compatible with ""%1""", phx_loadout_weapon];
    };
  };
  true
};


fnc_giveNVG = {
  // NVGs/laser accessory
  params [
    ["_unit", objNull],
    ["_giveNVG", 0],
    ["_NVGType", "NVGoggles_OPFOR"]
  ];

  switch (typeName phx_addNVG) do {
    case "SCALAR": {
      if (phx_addNVG == 1) then {
        _unit linkItem _NVGType;
        {_unit addPrimaryWeaponItem _x} forEach ["rhs_acc_perst1ik", "rhsusf_acc_anpeq15A"];
        diag_log text format["[FNF] (loadout) INFO: Gave NVGs ""%1""", _NVGType];
      };
    };
    case "ARRAY": {
      if (side (group _unit) in phx_addNVG) then {
        _unit linkItem _NVGType;
        {_unit addPrimaryWeaponItem _x} forEach ["rhs_acc_perst1ik", "rhsusf_acc_anpeq15A"];
        diag_log text format["[FNF] (loadout) INFO: Gave NVGs ""%1""", _NVGType];
      };
    };
  };
  true
};


fnc_giveAT = {
  // MAT AND LAUNCHERS
  params [
    ["_unit", objNull],
    ["_role", "BASE"]
  ];

  private _matRoleVarArr = ["MATA1","MAT1","MATA2","MAT2"];
  private _matGunnerVarArr = ["MAT1","MAT2"];
  if (_role in _matRoleVarArr) then {
    if (isNil "phx_loadout_mediumantitank_weapon") exitWith {
      [{time > 2}, {
        ["<t align='center'>Error:<br/>Failed to process MAT settings.</t>", "error", 20] call phx_ui_fnc_notify;
        diag_log text "[FNF] (loadout) ERROR: Failed to process MAT settings.";
      }] call CBA_fnc_waitUntilAndExecute;
      nil
    };

    // add mags & load one
    // "debug_console" callExtension str(phx_loadout_mediumantitank_mag);
    private "_compatMag";
    if (!isNil "phx_loadout_mediumantitank_mag") then {
      if (phx_loadout_mediumantitank_isReloadable) then {
        {
          // "debug_console" callExtension ("Adding " + _x + " to inventory");
          [_x, "backpack", _unit] call phx_fnc_addGear;
        } forEach phx_loadout_mediumantitank_mag;
        diag_log text format["[FNF] (loadout) INFO: Equipped AT weapon magazines"];
        diag_log text format["[FNF] (loadout) DEBUG: %1", phx_loadout_mediumantitank_mag];
      };

      _compatMag = (phx_loadout_mediumantitank_mag # 0) splitString ':';
    };

    if (_role in _matGunnerVarArr) then {
      // for gunner, add MAT weapon, then optic to it
      _unit addWeapon phx_loadout_mediumantitank_weapon;
      diag_log text format["[FNF] (loadout) INFO: Equipped AT weapon ""%1""", phx_loadout_mediumantitank_weapon];
      if (!isNil "phx_loadout_mediumantitank_optic") then {
        private _thisOptic = selectRandom(phx_loadout_mediumantitank_optic);
        _unit addSecondaryWeaponItem _thisOptic;
        diag_log text format["[FNF] (loadout) INFO: Equipped AT optic ""%1""", _thisOptic];
      };
      if (!isNil "_compatMag") then {
        // if we found a mag, try pre-loading the launcher
        _compatMag params ["_magClass", "_magCount"];
        _magCount = parseNumber(_magCount);
        _numOfMags = count ([_unit, _magClass] call CBA_fnc_getMagazineIndex);
        // some MAT rounds, when given to a player's inventory, will autoload into the launcher
        // if this DOESN'T happen, we need to do it manually. otherwise we want to leave it alone so the proper number given
        if (_numOfMags == _magCount) then {
          // _unit removeMagazine _magClass;
          [_unit, _magClass] call CBA_fnc_removeMagazine;
          _unit addSecondaryWeaponItem _magClass;
        };
      };
    };
    true
  } else {

    // LAUNCHERS
    // if not MAT or MATA role, check normal launchers[] array from config
    if (count _cfgLaunchers > 0) then {
      phx_loadout_launcher = selectRandom(_cfgLaunchers);
    } else {
      phx_loadout_launcher = "";
    };
    // "debug_console" callExtension str(phx_loadout_launcher);
    if (phx_loadout_launcher isEqualType []) then {
      phx_loadout_launcher params ["_launcher", "_mags", "_optics"];
      _unit addWeapon _launcher;
      diag_log text format["[FNF] (loadout) INFO: Equipped AT weapon ""%1""", _launcher];

      if (count _mags > 0) then {
        {
          [_x, "backpack", _unit] call phx_fnc_addGear;
        } forEach _mags;
        diag_log text format["[FNF] (loadout) INFO: Equipped AT weapon magazines"];
        diag_log text format["[FNF] (loadout) DEBUG: %1", _mags];
      };

      if (count (secondaryWeaponMagazine player) == 0) then {
        private _loadThisMag = (_mags # 0 splitString ':' select 0);
        if (!isNil "_loadThisMag") then {
          _unit removeMagazine _loadThisMag;
          _unit addSecondaryWeaponItem _loadThisMag;
        };
      };

      if (count _optics > 0) then {
        private _thisOptic = selectRandom(_optics);
        _unit addSecondaryWeaponItem _thisOptic;
        diag_log text format["[FNF] (loadout) INFO: Equipped AT optic ""%1""", _thisOptic];
      };
    };
    true
  };
};

fnc_prepOpticsSelector = {
  params [
    ["_unit", objNull],
    ["_role", "BASE"],
    ["_cfgOptics", (missionConfigFile >> "CfgLoadouts" >> "optics")]
  ];

  // Optic selections based on phx_magnifiedOptics setting
  private "_cfgOpticChoices";
  switch (phx_magnifiedOptics) do {
    // Nobody should have optics
    case -1: {_cfgOpticChoices = []};
    // All should have magnified
    case 1: {
      _cfgOpticChoices = (_cfgOptics >> "standard") call BIS_fnc_getCfgDataArray;
      if !(_role in ["MG"]) then { // ensures MMGs never get magnified optics
        _cfgOpticChoices = (_cfgOptics >> "magnified") call BIS_fnc_getCfgDataArray;
      };
      if (_role in ["SNP"]) then {
        _cfgOpticChoices = (_cfgOptics >> "sniper") call BIS_fnc_getCfgDataArray;
      };
    };
      // 0 OR default: DM magnified, sniper special
    default {
      _cfgOpticChoices = (_cfgOptics >> "standard") call BIS_fnc_getCfgDataArray;
      if (_role in ["DM"]) then {
        _cfgOpticChoices = (_cfgOptics >> "magnified") call BIS_fnc_getCfgDataArray;
      };
      if (_role in ["SNP"]) then {
        _cfgOpticChoices = (_cfgOptics >> "sniper") call BIS_fnc_getCfgDataArray;
      };
    };
  };
  // "debug_console" callExtension ("Optics choices: " + str(_cfgOpticChoices));
  if (count _cfgOpticChoices > 0 && !isNil "phx_loadout_weapon") then {
    // private _optic = selectRandom(_cfgOpticChoices select {_x in ([phx_loadout_weapon, "optic"] call CBA_fnc_compatibleItems)});
    // if (!isNil "_optic") then {
      // _unit addPrimaryWeaponItem _optic;
      // player setVariable ["phx_ChosenOptic", _optic];
      // diag_log text format["[FNF] (loadout) INFO: Equipped optic ""%1""", _optic];
    // };
    player setVariable ["phx_ChosenOptic", ""];
    missionNamespace setVariable ["phx_selector_optics", _cfgOpticChoices];
  };
  true
};


fnc_giveCECharges = {
  // CE Explosives
  params [
    ["_unit", objNull],
    ["_cfgExplosiveChoices", (missionConfigFile >> "CfgLoadouts" >> "GEAR" >> mySideGearSelection >> (player getVariable "phxLoadout") >> "explosiveChoices") call BIS_fnc_getCfgDataArray]
  ];

  if (count _cfgExplosiveChoices > 0) then {
    phx_selector_currentExplosives = selectRandom(_cfgExplosiveChoices);
    // "debug_console" callExtension str(phx_loadout_explosives);
    {
      [_x, "backpack", _unit] call phx_fnc_addGear;
    } forEach (phx_selector_currentExplosives select [1, 2]);
    diag_log text format["[FNF] (loadout) INFO: Equipped CE explosive %1", phx_selector_currentExplosives # 0];
    phx_selector_explosives = _cfgExplosiveChoices;
  } else {phx_selector_explosives = []};
  true
};

fnc_giveCEGrenades = {
  // CE Grenades
  params [
    ["_unit", objNull],
    ["_cfgGrenadeChoices", (missionConfigFile >> "CfgLoadouts" >> "GEAR" >> mySideGearSelection >> (player getVariable "phxLoadout") >> "grenadeChoices") call BIS_fnc_getCfgDataArray]
  ];

  if (count _cfgGrenadeChoices > 0) then {
    phx_selector_currentGrenades = selectRandom(_cfgGrenadeChoices);
    // "debug_console" callExtension str(phx_loadout_explosives);
    {
      [_x, "vest", _unit] call phx_fnc_addGear;
    } forEach (phx_selector_currentGrenades select [1, 2]);
    diag_log text format["[FNF] (loadout) INFO: Equipped CE grenade %1", phx_selector_currentGrenades # 0];
    phx_selector_grenades = _cfgGrenadeChoices;
  } else {phx_selector_grenades = []};
  true
};


fnc_setAttributes = {
  // Attributes
  params [
    ["_unit", objNull],
    ["_role", "BASE"]
  ];

  if (_role == "MED") then {
    _unit setVariable ["ace_medical_medicClass", 1, true];
    _unit setUnitTrait ["medic", true, true];
  };
  if (_role in ["CE","CR","PI"]) then {
    _unit setVariable ["ace_isEngineer", 1, true];
    _unit setUnitTrait ["engineer", true, true];
  };
  if (_role == "SGT" && side (group _unit) isEqualTo phx_vnArtillerySide) then {
    _unit setUnitTrait ["vn_artillery", true, true];
  };
  true
};

fnc_giveSideKey = {
  // ACE Side key
  params [
    ["_unit", objNull],
    ["_cfgGiveSideKey", 0]
  ];

  if (_cfgGiveSideKey == 1) then {
    switch (side (group _unit)) do {
      case west: {
          _unit addItem "ACE_key_west";
      };
      case east: {
          _unit addItem "ACE_key_east";
      };
      case independent: {
          _unit addItem "ACE_key_indp";
      };
    };
  };
  if (_cfgGiveSideKey == 2) then {
    _unit addItem "ACE_key_master";
  };
  true
};

fnc_giveBinoculars = {
  // Give binocular items
  params [
    ["_unit", objNull],
    ["_role", "BASE"]
  ];

  private _binocs = (missionConfigFile >> "CfgLoadouts" >> "common" >> "binoculars");

  private _hasBinoc = (((assigneditems _unit) findIf {getText(configFile >> "CfgWeapons" >> _x >> "simulation") == "Binocular"}) > -1);
  if (_hasBinoc) exitWith {true};

  private _binocRolesStandard = ["ARA", "MGA", "CR"];
  private _binocRolesRangefinder = ["TL", "MATA1", "MATA2"];
  private _binocRolesVector = ["SL", "SGT", "PL", "CRL"];
  private "_thisBinoc";

  if (
    mySideGearSelection select [0,2] isEqualTo "VN" &&
    _role in flatten([_binocRolesStandard,_binocRolesRangefinder,_binocRolesVector])
  ) then {
    // Vietnam should receive reg binocs only
    _thisBinoc = "vn_mk21_binocs";
  } else {
    // Modern should receive differing types
    if (_role in _binocRolesStandard) then {
      _thisBinoc = getText(_binocs >> "standard");
    };
    if (_role in _binocRolesRangefinder) then {
      _thisBinoc = getText(_binocs >> "rangefinder");
    };
    if (_role in _binocRolesVector) then {
      _thisBinoc = getText(_binocs >> "vector21");
    };
  };

  if (!isNil "_thisBinoc") then {
    _unit addWeapon _thisBinoc;
    diag_log text format["[FNF] (loadout) INFO: Equipped binoculars ""%1""", _thisBinoc];
  };

  true
};


fnc_loadWeapons = {
  // load weapons
  params [
    ["_unit", objNull],
    ["_role", "BASE"]
  ];

  {
    _x params ["_weaponClass", "_mags"];
    private _cfgWeapon = _weaponClass call CBA_fnc_getItemConfig;

    // check for multiple muzzles (eg: GL)
    private _muzzles = getArray (configFile >> "cfgWeapons" >> _weaponClass >> "muzzles") select {!(["SAFE", _x] call BIS_fnc_inString) && !(["melee", _x] call BIS_fnc_inString)};
    // "debug_console" callExtension str([_weaponClass, _muzzles]);

    {
      private _thisMuzzle = _x;
      private "_compatMag";
      // "debug_console" callExtension str([_weaponClass, _mags, configName(_cfgWeapon >> _thisMuzzle), [_mags, _cfgWeapon >> _thisMuzzle, false] call fnc_getWeaponMagazines]);

      if (_thisMuzzle == "this") then {
        _compatMag = ([_mags, _cfgWeapon, false] call fnc_getWeaponMagazines) select 0;
      } else {
        _compatMag = ([_mags, _cfgWeapon >> _thisMuzzle, false] call fnc_getWeaponMagazines) select 0;
      };
      _compatMag = _compatMag splitString ':' select 0;
      // "debug_console" callExtension str([_weaponClass, _thisMuzzle, _compatMag]);

      _unit removeMagazine _compatMag;
      switch (_weaponClass) do {
        case (primaryWeapon _unit): {
          _unit addPrimaryWeaponItem _compatMag;
        };
        case (handgunWeapon player): {
          _unit addHandgunItem _compatMag;
        };
      };
    } forEach _muzzles;
  } forEach [
    [primaryWeapon _unit, phx_loadout_weaponMagazines],
    [handgunWeapon _unit, phx_loadout_sidearmMagazines]
  ];
  true
};








#define LOADOUTROLE(_str) (PLAYERLOADOUTVAR isEqualTo _str)
#define CFGUNIFORM missionConfigFile >> "CfgLoadouts" >> "UNIFORMS" >> mySideUniformSelection >> PLAYERLOADOUTVAR
#define CFGGEAR missionConfigFile >> "CfgLoadouts" >> "GEAR" >> mySideGearSelection >> PLAYERLOADOUTVAR
#define CFGCOMMON missionConfigFile >> "CfgLoadouts" >> "common"
#define CFGOPTICS missionConfigFile >> "CfgLoadouts" >> "optics"

// "debug_console" callExtension format["
// ----- LOADED -----
// ROLE: %1
// UNIFORM: %2
// GEAR: %3
// COMMON: %4
// CFGOPTICS: %5
// ",
//   PLAYERLOADOUTVAR,
//   call {private _t = [CFGUNIFORM, true] call BIS_fnc_returnParents; reverse _t; _t},
//   call {private _t = [CFGGEAR, true] call BIS_fnc_returnParents; reverse _t; _t},
//   call {private _t = [CFGCOMMON, true] call BIS_fnc_returnParents; reverse _t; _t},
//   call {private _t = [CFGOPTICS, true] call BIS_fnc_returnParents; reverse _t; _t}
// ];

private _cfgUniform = (CFGUNIFORM >> "uniform") call BIS_fnc_getCfgDataArray;
private _cfgVest = (CFGUNIFORM >> "vest") call BIS_fnc_getCfgDataArray;
private _cfgHeadgear = (CFGUNIFORM >> "headgear") call BIS_fnc_getCfgDataArray;
private _cfgBackpack = (CFGUNIFORM >> "backpack") call BIS_fnc_getCfgDataArray;
private _cfgBackpackItems = (CFGGEAR >> "backpackItems") call BIS_fnc_getCfgDataArray;
private _cfgLaunchers = (CFGGEAR >> "launchers") call BIS_fnc_getCfgDataArray;
private _cfgSidearms = (CFGGEAR >> "sidearms") call BIS_fnc_getCfgDataArray;
private _cfgMagazines = (CFGGEAR >> "magazines") call BIS_fnc_getCfgDataArray;
private _cfgItems = (CFGGEAR >> "items") call BIS_fnc_getCfgDataArray;
private _cfgLinkedItems = (CFGGEAR >> "linkedItems") call BIS_fnc_getCfgDataArray;
private _cfgWeaponChoices = (CFGGEAR >> "weaponChoices") call BIS_fnc_getCfgDataArray;
private _cfgAttachments = (CFGGEAR >> "attachments") call BIS_fnc_getCfgDataArray;
private _cfgExplosiveChoices = (CFGGEAR >> "explosiveChoices") call BIS_fnc_getCfgDataArray;
private _cfgGrenadeChoices = (CFGGEAR >> "grenadeChoices") call BIS_fnc_getCfgDataArray;
// Side key - 0 = no, 1 = side, 2 = global
private _cfgGiveSideKey = (CFGGEAR >> "giveSideKey") call BIS_fnc_getCfgData;
private _cfgGiveSRRadio = (CFGGEAR >> "giveSRRadio") call BIS_fnc_getCfgDataBool;
private _cfgGiveLRRadio = (CFGGEAR >> "giveLRRadio") call BIS_fnc_getCfgDataBool;
// private _cfgHandgunAttachments = getArray (_cfgPath >> "handgunAttachments");

_pairs = [
  ["uniform", _cfgUniform],
  ["vest", _cfgVest],
  ["headgear", _cfgHeadgear],
  ["backpack", _cfgBackpack],
  ["backpackItems", _cfgBackpackItems],
  ["launchers", _cfgLaunchers],
  ["sidearms", _cfgSidearms],
  ["magazines", _cfgMagazines],
  ["items", _cfgItems],
  ["linkedItems", _cfgLinkedItems],
  ["weaponChoices", _cfgWeaponChoices],
  ["attachments", _cfgAttachments],
  ["explosiveChoices", _cfgExplosiveChoices],
  ["grenadeChoices", _cfgGrenadeChoices],
  ["giveSideKey", _cfgGiveSideKey],
  ["giveSRRadio", _cfgGiveSRRadio],
  ["giveLRRadio", _cfgGiveLRRadio]
];
_cfgLoaded = [_pairs, []] call CBA_fnc_hashCreate;
phx_loadout = [_cfgLoaded, false] call CBA_fnc_deserializeNamespace;

// Wearable
phx_loadout_uniform = if (_cfgUniform isEqualTo []) then { "" } else { selectRandom _cfgUniform };
phx_loadout_vest = if (_cfgVest isEqualTo []) then { "" } else { selectRandom _cfgVest };
phx_loadout_backpack = if (_cfgBackpack isEqualTo []) then { "" } else { selectRandom _cfgBackpack };
phx_loadout_headgear = if (_cfgHeadgear isEqualTo []) then { "" } else { selectRandom _cfgHeadgear };





if (isNil {
  [
    player,
    phx_loadout_uniform,
    phx_loadout_vest,
    phx_loadout_backpack,
    phx_loadout_headgear
  ] call fnc_addUniform
}) exitWith {
  [{time > 2}, {
    ["<t align='center'>Error:<br/>Failed to process uniform settings.</t>", "error", 20] call phx_ui_fnc_notify;
    diag_log text format["[FNF] (loadout) ERROR: Failed to process uniform settings."];
  }] call CBA_fnc_waitUntilAndExecute;
};



if (isNil {
  [
    player,
    _cfgGiveSRRadio,
    _cfgGiveLRRadio
  ] call fnc_giveRadios
}) exitWith {
  [{time > 2}, {
    ["<t align='center'>Error:<br/>Failed to process radio assignment settings.</t>", "error", 20] call phx_ui_fnc_notify;
    diag_log text format["[FNF] (loadout) ERROR: Failed to process radio assignment settings."];
  }] call CBA_fnc_waitUntilAndExecute;
};


if (isNil {
  [
    player,
    _cfgMagazines,
    _cfgItems,
    _cfgBackpackItems,
    _cfgLinkedItems
  ] call fnc_giveGear
}) exitWith {
  [{time > 2}, {
    ["<t align='center'>Error:<br/>Failed to process gear settings.</t>", "error", 20] call phx_ui_fnc_notify;
    diag_log text format["[FNF] (loadout) ERROR: Failed to process gear settings."];
  }] call CBA_fnc_waitUntilAndExecute;
};


if (isNil {[player, _cfgWeaponChoices] call fnc_givePrimaryWeapon}) exitWith {
  [{time > 2}, {
    ["<t align='center'>Error:<br/>Failed to process primary weapon settings.</t>", "error", 20] call phx_ui_fnc_notify;
    diag_log text format["[FNF] (loadout) ERROR: Failed to process primary weapon settings."];
  }] call CBA_fnc_waitUntilAndExecute;
};

if (isNil {[player, _cfgWeaponChoices] call fnc_prepWeaponsSelector}) exitWith {
  [{time > 2}, {
    ["<t align='center'>Error:<br/>Failed to process weapon selector settings.</t>", "error", 20] call phx_ui_fnc_notify;
    diag_log text format["[FNF] (loadout) ERROR: Failed to process weapon selector settings."];
  }] call CBA_fnc_waitUntilAndExecute;
};



if (isNil {[player, _cfgSidearms] call fnc_giveSidearmWeapon}) exitWith {
  [{time > 2}, {
    ["<t align='center'>Error:<br/>Failed to process sidearm weapon settings.</t>", "error", 20] call phx_ui_fnc_notify;
    diag_log text format["[FNF] (loadout) ERROR: Failed to process sidearm weapon settings."];
  }] call CBA_fnc_waitUntilAndExecute;
};

if (isNil {[player, getNumber(CFGGEAR >> "giveSilencer")] call fnc_giveSilencer}) exitWith {
  [{time > 2}, {
    ["<t align='center'>Error:<br/>Failed to process silencer settings.</t>", "error", 20] call phx_ui_fnc_notify;
    diag_log text format["[FNF] (loadout) ERROR: Failed to process silencer settings."];
  }] call CBA_fnc_waitUntilAndExecute;
};

if (isNil {[player, phx_addNVG, getText(CFGCOMMON >> "NVG")] call fnc_giveNVG}) exitWith {
  [{time > 2}, {
    ["<t align='center'>Error:<br/>Failed to process NVG settings.</t>", "error", 20] call phx_ui_fnc_notify;
    diag_log text format["[FNF] (loadout) ERROR: Failed to process NVG settings."];
  }] call CBA_fnc_waitUntilAndExecute;
};


if (isNil {[player, PLAYERLOADOUTVAR] call fnc_giveAT}) exitWith {
  [{time > 2}, {
    ["<t align='center'>Error:<br/>Failed to process AT settings.</t>", "error", 20] call phx_ui_fnc_notify;
    diag_log text format["[FNF] (loadout) ERROR: Failed to process AT settings."];
  }] call CBA_fnc_waitUntilAndExecute;
};


if (isNil {[player, PLAYERLOADOUTVAR, CFGOPTICS] call fnc_prepOpticsSelector}) exitWith {
  [{time > 2}, {
    ["<t align='center'>Error:<br/>Failed to process optics settings.</t>", "error", 20] call phx_ui_fnc_notify;
    diag_log text format["[FNF] (loadout) ERROR: Failed to process optics settings."];
  }] call CBA_fnc_waitUntilAndExecute;
};


if (isNil {[player, _cfgExplosiveChoices] call fnc_giveCECharges}) exitWith {
  [{time > 2}, {
    ["<t align='center'>Error:<br/>Failed to process CE explosives settings.</t>", "error", 20] call phx_ui_fnc_notify;
    diag_log text format["[FNF] (loadout) ERROR: Failed to process CE explosives settings."];
  }] call CBA_fnc_waitUntilAndExecute;
};

if (isNil {[player, _cfgGrenadeChoices] call fnc_giveCEGrenades}) exitWith {
  [{time > 2}, {
    ["<t align='center'>Error:<br/>Failed to process CE grenade settings.</t>", "error", 20] call phx_ui_fnc_notify;
    diag_log text format["[FNF] (loadout) ERROR: Failed to process CE grenade settings."];
  }] call CBA_fnc_waitUntilAndExecute;
};

if (isNil {[player, PLAYERLOADOUTVAR] call fnc_setAttributes}) exitWith {
  [{time > 2}, {
    ["<t align='center'>Error:<br/>Failed to process ACE attribute settings.</t>", "error", 20] call phx_ui_fnc_notify;
    diag_log text format["[FNF] (loadout) ERROR: Failed to process ACE attribute settings."];
  }] call CBA_fnc_waitUntilAndExecute;
};


if (isNil {[player, _cfgGiveSideKey] call fnc_giveSideKey}) exitWith {
  [{time > 2}, {
    ["<t align='center'>Error:<br/>Failed to process ACE vehicle key settings.</t>", "error", 20] call phx_ui_fnc_notify;
    diag_log text format["[FNF] (loadout) ERROR: Failed to process ACE vehicle key settings."];
  }] call CBA_fnc_waitUntilAndExecute;
};

if (isNil {[player, PLAYERLOADOUTVAR] call fnc_giveBinoculars}) exitWith {
  [{time > 2}, {
    ["<t align='center'>Error:<br/>Failed to process gear settings.</t>", "error", 20] call phx_ui_fnc_notify;
    diag_log text format["[FNF] (loadout) ERROR: Failed to process binocular settings."];
  }] call CBA_fnc_waitUntilAndExecute;
};

// get this before loading, so Diary displays /all/ of them
_playerMagazines = magazines player;


if (isNil {[player, PLAYERLOADOUTVAR] call fnc_loadWeapons}) then {
  [{time > 2}, {
    // ["<t align='center'>Error:<br/>Failed to auto-load weapons.</t>", "error", 20] call phx_ui_fnc_notify;
    diag_log text format["[FNF] (loadout) ERROR: Failed to auto-load weapons."];
  }] call CBA_fnc_waitUntilAndExecute;
};


if (uniform player != "") then {
  player setVariable ["phx_lastLoadout", PLAYERLOADOUTVAR];
  [true] call phx_fnc_briefingGear;
  missionNamespace setVariable ["phx_loadoutAssigned",true];

  // set rank from phx_loadout_roles (for Nametags)
  _rank = [phx_loadout_roles, PLAYERLOADOUTVAR, "PRIVATE"] call BIS_fnc_getFromPairs;
  if (typeName _rank isEqualTo "ARRAY") then {_rank = _rank select 1};
  player setUnitRank _rank;

  [
    "[%1] Loadout assigned",
    [(cba_missionTime),"HH:MM:SS"] call BIS_fnc_secondsToString,
    name player
  ] call BIS_fnc_logFormatServer;
} else {
  [{time > 2}, {
    ["<t align='center'>Error:<br/>Failed to process uniform settings.</t>", "error", 20] call phx_ui_fnc_notify;
    diag_log text format["[FNF] (loadout) ERROR: Failed to process uniform settings."];
  }] call CBA_fnc_waitUntilAndExecute;
};






// configProperties [missionConfigFile >> "CfgLoadoutWeapons" >> "west" >> "PL"];
// (missionConfigFile >> "CfgLoadoutWeapons" >> "west") call BIS_fnc_getCfgSubClasses;
// (missionConfigFile >> "CfgLoadoutWeapons" >> "west" >> "PL" >> "vest") call BIS_fnc_getCfgData;
