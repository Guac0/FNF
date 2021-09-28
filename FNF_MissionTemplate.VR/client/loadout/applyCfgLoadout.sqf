waitUntil {!isNull player};

[{
    params ["_args", "_handle"];
    _args params ["_addTime"];

    if !(missionNamespace getVariable ["phx_loadoutAssigned",false]) then {
        // After 30 seconds with no loadout being set, kick player back to the slotting screen
        if (diag_tickTime-30 > _addTime) then {
            diag_log format ["PHX [%1] checkLoadout - Waited 30 seconds and didn't get a loadout! Report this to the mission maker. - %2",diag_tickTime,_addTime];
            endMission "END1";
        };
    } else {
        // Loadout was set, stop PFH
        diag_log format ["PHX [%1] checkLoadout - Loadout set, took %2 seconds",diag_tickTime,(diag_tickTime - _addTime)];
        [_handle] call CBA_fnc_removePerFrameHandler;
    };
}, 0, [diag_tickTime]] call CBA_fnc_addPerFrameHandler;

uiSleep 5;
player unlinkItem "ItemRadio";
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

private _cfgPath = (missionConfigFile >> "CfgLoadouts" >> "west" >> (player getVariable "phxLoadout"));

private _cfgUniform = (_cfgPath >> "uniform") call BIS_fnc_getCfgData;
private _cfgVest = (_cfgPath >> "vest") call BIS_fnc_getCfgData;
private _cfgHeadgear = (_cfgPath >> "headgear") call BIS_fnc_getCfgData;
private _cfgBackpack = (_cfgPath >> "backpack") call BIS_fnc_getCfgData;
private _cfgBackpackItems = (_cfgPath >> "backpackItems") call BIS_fnc_getCfgData;
private _cfgWeapons = (_cfgPath >> "weapons") call BIS_fnc_getCfgData;
private _cfgLaunchers = (_cfgPath >> "launchers") call BIS_fnc_getCfgData;
private _cfgSidearms = (_cfgPath >> "sidearms") call BIS_fnc_getCfgData;
private _cfgMagazines = (_cfgPath >> "magazines") call BIS_fnc_getCfgData;
private _cfgItems = (_cfgPath >> "items") call BIS_fnc_getCfgData;
private _cfgLinkedItems = (_cfgPath >> "linkedItems") call BIS_fnc_getCfgData;
private _cfgAttachments = (_cfgPath >> "attachments") call BIS_fnc_getCfgData;
private _cfgLauncherAttachments = (_cfgPath >> "launcherAttachments") call BIS_fnc_getCfgData;
// private _cfgHandgunAttachments = getArray (_cfgPath >> "handgunAttachments");

private _headgear = if (_cfgHeadgear isEqualTo []) then { "" } else { selectRandom _cfgHeadgear };


_fnc_getWeaponMagazines = {
	params ["_toSearch", "_weapon"];
	private _out = [];
	{
		if ((_x splitString ':' select 0) in ([_weapon, true] call CBA_fnc_compatibleMagazines)) then {
			_out pushBack _x;
		};
	} forEach _toSearch;
	_out
};



player forceAddUniform selectRandom(_cfgUniform);
player addVest selectRandom(_cfgVest);
player addBackpack selectRandom(_cfgBackpack);
player addHeadgear selectRandom(_cfgHeadgear);

phx_loadout_weapon = if (count _cfgWeapons > 0) then {selectRandom(_cfgWeapons)} else {""};
player addWeapon phx_loadout_weapon;
phx_loadout_weaponMagazines = [_cfgMagazines, phx_loadout_weapon] call _fnc_getWeaponMagazines;
{[_x, "vest"] call phx_fnc_addGear; nil} count phx_loadout_weaponMagazines;

phx_loadout_sidearm = if (count _cfgSidearms > 0) then {selectRandom(_cfgSidearms)} else {""};
player addWeapon phx_loadout_sidearm;
phx_loadout_sidearmMagazines = [_cfgMagazines, phx_loadout_sidearm] call _fnc_getWeaponMagazines;
{[_x, "vest"] call phx_fnc_addGear; nil} count phx_loadout_sidearmMagazines;

phx_loadout_launcher = if (count _cfgLaunchers > 0) then {selectRandom(_cfgLaunchers)} else {""};
player addWeapon phx_loadout_launcher;

{[_x, "backpack"] call phx_fnc_addGear} forEach _cfgBackpackItems;
{[_x, "uniform"] call phx_fnc_addGear} forEach _cfgItems;
{player linkItem _x} forEach _cfgLinkedItems;

// NVGs/laser accessory
_giveNVG = {player linkItem phx_loadout_nvg};
_addLaser = {{player addPrimaryWeaponItem _x} forEach ["rhs_acc_perst1ik", "rhsusf_acc_anpeq15A"];};
switch (typeName phx_addNVG) do {
  case "BOOL": {if (phx_addNVG) then {call _giveNVG; call _addLaser};};
  case "SIDE": {if (playerSide == phx_addNVG) then {call _giveNVG; call _addLaser};};
  case "ARRAY": {if (playerSide in phx_addNVG) then {call _giveNVG; call _addLaser};};
};




// MAT
if (player getVariable "phxLoadout" == "MAT") then {player addWeapon phx_loadout_mediumantitank_weapon};
if (player getVariable "phxLoadout" in ["MAT", "MATA"]) then {phx_loadout_mediumantitank_mag call phx_fnc_addGear};
if (
	player getVariable "phxLoadout" in ["MAT", "MATA"] &&
	!isNil "phx_loadout_mediumantitank_mag_1"
) then {phx_loadout_mediumantitank_mag_1 call phx_fnc_addGear};

// Attributes
if (player getVariable "phxLoadout" == "MED") then {player setVariable ["ace_medical_medicClass", 1, true]};
if (player getVariable "phxLoadout" in ["CE","CR","PI"]) then {player setVariable ["ace_isEngineer", 1, true]};



// load weapons
[] spawn {
	waitUntil {count weapons player >= 2};
	sleep 2;
	reload player;
	private _toReload = [];
	{
		private _type = _x;
		// player selectWeapon _type;
		// sleep 0.5;
		// check for multiple muzzles (eg: GL)
		private _muzzles = getArray (configFile >> "cfgWeapons" >> _type >> "muzzles") select {!(["SAFE", _x] call BIS_fnc_inString)};
		
		{
			private _thisMuzzle = _x;
			player selectWeapon _type;
			player selectWeapon _thisMuzzle;
			// sleep 2;
			if ((weaponState player) select 4 == 0) then {
				reload player;
				waitUntil {(weaponState player) select 4 > 0};
			};
		} forEach _muzzles;
	} forEach (weapons player select {!(_x isEqualTo secondaryWeapon player)});

	player selectWeapon (primaryWeapon player);
};



// show hint
_fnc_hintDetails = {
	private _thisCfg = _this call CBA_fnc_getItemConfig;
	private _dispName = [_thisCfg] call BIS_fnc_displayName;
	private _desc = getText(_thisCfg >> "descriptionShort");
	private _pic = getText(_thisCfg >> "picture");

	_textArr = [
		format["<t align='center'><img size='3' image='%1'/>", _pic],
		format["<t size='1'>%1</t>", _dispName],
		_desc,
		"</t>"
	];
	// [_textArr joinString '<br/>', "success", 5] call phx_ui_fnc_notify;
	_textArr joinString '<br/>'
};

#define LOADOUTROLE(_str) (player getVariable ["phxLoadout", ""] isEqualTo _str)

private _strRole = "";
if (LOADOUTROLE("PL")) then {_strRole = " Platoon Leader"};
if (LOADOUTROLE("SL") || LOADOUTROLE("SGT")) then {_strRole = " Squad Leader"};
if (LOADOUTROLE("TL")) then {_strRole = " Team Leader"};
if (LOADOUTROLE("AR")) then {_strRole = "n Automatic Rifleman"};
if (LOADOUTROLE("ARA")) then {_strRole = "n Asst. Automatic Rifleman"};
if (LOADOUTROLE("GR")) then {_strRole = " Grenadier"};
if (LOADOUTROLE("GRIR")) then {_strRole = " Grenadier w/ HuntIR"};
if (LOADOUTROLE("MG")) then {_strRole = " Machine Gunner"};
if (LOADOUTROLE("MGA")) then {_strRole = "n Asst. Machine Gunner"};
if (LOADOUTROLE("CE")) then {_strRole = " Combat Engineer"};
if (LOADOUTROLE("LAT")) then {_strRole = " Light Anti-Tank Rifleman"};
if (LOADOUTROLE("MAT")) then {_strRole = " Medium Anti-Tank Specialist"};
if (LOADOUTROLE("MATA")) then {_strRole = " Medium Anti-Tank Assistant"};
if (LOADOUTROLE("RI")) then {_strRole = " Rifleman"};
if (LOADOUTROLE("RIS")) then {_strRole = " Senior Rifleman"};
if (LOADOUTROLE("DM")) then {_strRole = " Designated Marksman"};
if (LOADOUTROLE("SNP")) then {_strRole = " Sniper"};
if (LOADOUTROLE("CR")) then {_strRole = " Crewman"};
if (LOADOUTROLE("PI")) then {_strRole = " Pilot"};
if (LOADOUTROLE("MED")) then {_strRole = " Medic"};

private _notifyString = [];
_notifyString pushBack ("<t align='center' size='1.4' color='#e1701a' face='PuristaBold'>ROLE</t>");
_notifyString pushBack ("<t align='center' face='PuristaLight'>You are a" + _strRole + "<br/>in " + (roleDescription player splitString '@' select 1) + "</t>");
_notifyString pushBack ("<br/>");
_notifyString pushBack ("<t align='center' size='1.4' color='#e1701a' face='PuristaBold'>Primary Weapon</t>");
_notifyString pushBack (primaryWeapon player call _fnc_hintDetails);
// _notifyString pushBack ("<br/>");
_notifyString pushBack ("<t align='center' size='1.4' color='#e1701a' face='PuristaBold'>Handgun Weapon</t>");
_notifyString pushBack (handgunWeapon player call _fnc_hintDetails);
// _notifyString pushBack ("<br/>");

if (secondaryWeapon player != "") then {
	_notifyString pushBack ("<t align='center' size='14' color='#e1701a' face='PuristaBold'>Launcher</t>");
	_notifyString pushBack (secondaryWeapon player call _fnc_hintDetails)
};
[_notifyString joinString '<br/>'] call phx_ui_fnc_notify;



missionNamespace setVariable ["phx_loadoutAssigned",true];






// configProperties [missionConfigFile >> "CfgLoadoutWeapons" >> "west" >> "PL"];
// (missionConfigFile >> "CfgLoadoutWeapons" >> "west") call BIS_fnc_getCfgSubClasses;
// (missionConfigFile >> "CfgLoadoutWeapons" >> "west" >> "PL" >> "vest") call BIS_fnc_getCfgData;