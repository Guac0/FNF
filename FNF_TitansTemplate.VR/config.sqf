if (!isServer) exitWith { diag_log format ["FNF Titans Framework: Exiting config.sqf due to being on client!"]; }; //this throws an error on client

//Uniforms
//phx_bluforUniform = "UNIFORM_MARPAT_WD";
//phx_opforUniform = "UNIFORM_EMR_SUMMER";
if (isServer) then {
	diag_log text "FNF Titans Framework: Breakpoint 1 — Executed config.sqf on Server.";
	systemChat "FNF Titans Framework: Breakpoint 1 — Executed config.sqf on Server.";
} else {
	diag_log text "FNF Titans Framework: Breakpoint 1 — Executed config.sqf on Client.";
	systemChat "FNF Titans Framework: Breakpoint 1 — Executed config.sqf on Client.";
};

if (isNil serverTitansConfigRan) then {
	serverTitansConfigRan = false;
	systemchat format ["FNF Titans Framework: Set serverTitansConfigRan to false!"];
	hint format ["FNF Titans Framework: Set serverTitansConfigRan to false!"];
	diag_log format ["FNF Titans Framework: Set serverTitansConfigRan to false!"];
};

if (isServer) then {
	
	systemchat format ["FNF Titans Framework: Server reached Breakpoint 2"];
	hint format ["FNF Titans Framework: Server reached Breakpoint 2"];
	diag_log format ["FNF Titans Framework: Server reached Breakpoint 2"];
	
	waitUntil { ("debug" call BIS_fnc_getParamValue) == 1 }; //maybe unneccessary since moved to server

	systemchat format ["FNF Titans Framework: Breakpoint 3 — Debug value on Server: %1", ("debug" call BIS_fnc_getParamValue)];
	hint format ["FNF Titans Framework: Breakpoint 3 — Debug value on Server: %1", ("debug" call BIS_fnc_getParamValue)];
	diag_log format ["FNF Titans Framework: Breakpoint 3 — Debug value on Server: %1", ("debug" call BIS_fnc_getParamValue)];

	bluforUniformValue = "bluforUniform" call BIS_fnc_getParamValue;
	opforUniformValue = "opforUniform" call BIS_fnc_getParamValue;
	bluforWeaponsValue = "bluforWeapons" call BIS_fnc_getParamValue;
	opforWeaponsValue = "opforWeapons" call BIS_fnc_getParamValue;

	systemchat format ["FNF Titans Framework: Breakpoint 4 — Blufor uniform value on Server: %1", bluforUniformValue];
	hint format ["FNF Titans Framework: Breakpoint 4 — Blufor uniform value on Server: %1", bluforUniformValue];
	diag_log format ["FNF Titans Framework: Breakpoint 4 — Blufor uniform value on Server: %1", bluforUniformValue];
	systemchat format ["FNF Titans Framework: Breakpoint 4 — Blufor uniform check 2: %1",("bluforUniform" call BIS_fnc_getParamValue)];

	//publicVariable "bluforUniformValue";
	//publicVariable "opforUniformValue";
	//publicVariable "bluforWeaponsValue";
	//publicVariable "opforWeaponsValue";
	//serverTitansConfigRan = true;
	//publicVariable "serverTitansConfigRan";

	systemchat format ["FNF Titans Framework: Breakpoint 5 — serverTitansConfigRan value on Server: %1", serverTitansConfigRan];
	hint format ["FNF Titans Framework: Breakpoint 5 — serverTitansConfigRan value on Server: %1", serverTitansConfigRan];
	diag_log format ["FNF Titans Framework: Breakpoint 5 — serverTitansConfigRan value on Server: %1", serverTitansConfigRan];

} else { //client
	
	systemchat format ["FNF Titans Framework: Breakpoint 6 — serverTitansConfigRan value on Client: %1", serverTitansConfigRan];
	hint format ["FNF Titans Framework: Breakpoint 6 — serverTitansConfigRan value on Client: %1", serverTitansConfigRan];
	diag_log format ["FNF Titans Framework: Breakpoint 6 — serverTitansConfigRan value on Client: %1", serverTitansConfigRan];

	waitUntil { serverTitansConfigRan == true };

	systemchat format ["FNF Titans Framework: Breakpoint 7 — serverTitansConfigRan value on Client: %1", serverTitansConfigRan];
	hint format ["FNF Titans Framework: Breakpoint 7 — serverTitansConfigRan value on Client: %1", serverTitansConfigRan];
	diag_log format ["FNF Titans Framework: Breakpoint 7 — serverTitansConfigRan value on Client: %1", serverTitansConfigRan];

};

diag_log text "FNF Titans Framework: Breakpoint 8 — Config.sqf passed waitUntil check.";
systemChat "FNF Titans Framework: Breakpoint 8 — Config.sqf passed waitUntil check.";

//BIS_fnc_getParam can only return a number, not a string, so we have to convert it into a string here via a switch statement that manually checks and assigns it
//I wonder if there's a better way to do this...

//debug
systemchat format ["FNF Titans Framework: Breakpoint 9 — Blufor uniform value: %1", bluforUniformValue];
hint format ["FNF Titans Framework: Breakpoint 9 — Blufor uniform value: %1", bluforUniformValue];
diag_log format ["FNF Titans Framework: Breakpoint 9 — Blufor uniform value: %1", bluforUniformValue];

switch (bluforUniformValue) do {
	default {
		phx_bluforUniform = "UNIFORM_MARPAT_WD";
		diag_log text "FNF Titans Framework: Blufor Uniform Fallback Initiated!";
	};
	case 0: { //default for the param in role select
		phx_bluforUniform = "UNIFORM_MARPAT_WD";
	};
	case 1: {
		phx_bluforUniform = "UNIFORM_MARPAT_D";
	};
	case 2: {
		phx_bluforUniform = "UNIFORM_OEF_CP";
	};
	case 3: {
		phx_bluforUniform = "UNIFORM_DOMINOS";
	};
	case 4: {
		phx_bluforUniform = "UNIFORM_AAF";
	};
	case 5: {
		phx_bluforUniform = "UNIFORM_GUERRILLA_VANILLA";
	};
};

switch (opforUniformValue) do {
	default {
		phx_opforUniform = "UNIFORM_EMR_SUMMER";
		diag_log text "FNF Titans Framework: Opfor Uniform Fallback Initiated!";
	};
	case 0: { //default for the param in role select
		phx_opforUniform = "UNIFORM_EMR_SUMMER";
	};
	case 1: {
		phx_opforUniform = "UNIFORM_EMR_DESERT";
	};
	case 2: {
		phx_opforUniform = "UNIFORM_FLORA";
	};
	case 3: {
		phx_opforUniform = "UNIFORM_PAPAJHONS";
	};
	case 4: {
		phx_opforUniform = "UNIFORM_AAF";
	};
	case 5: {
		phx_opforUniform = "UNIFORM_GUERRILLA_VANILLA";
	};
};


//Weapons
//phx_bluforWeapons = "WEAPONS_US";
//phx_opforWeapons = "WEAPONS_RU";

//debug
systemchat format ["FNF Titans Framework: Blufor weapons value: %1", bluforWeaponsValue];
hint format ["FNF Titans Framework: Blufor weapons value: %1", bluforWeaponsValue];
diag_log format ["FNF Titans Framework: Blufor weapons value: %1", bluforWeaponsValue];

switch (bluforWeaponsValue) do {
	default {
		phx_bluforWeapons = "WEAPONS_CUP_SMAW_SPOTTING";
		diag_log text "FNF Titans Framework: Blufor Weapons Fallback Initiated!";
	};
	case 0: { //default for the param in role select
		phx_bluforWeapons = "WEAPONS_CUP_SMAW_SPOTTING";
	};
	case 1: {
		phx_bluforWeapons = "WEAPONS_CUP_XM8";
	};
	case 2: {
		phx_bluforWeapons = "WEAPONS_CUP_USA_RANDOM";
	};
};

switch (opforWeaponsValue) do {
	default {
		phx_opforWeapons = "WEAPONS_CUP_SMAW_SPOTTING";
		diag_log text "FNF Titans Framework: Opfor Weapons Fallback Initiated!";
	};
	case 0: { //default for the param in role select
		phx_opforWeapons = "WEAPONS_CUP_SMAW_SPOTTING";
	};
	case 1: {
		phx_opforWeapons = "WEAPONS_CUP_XM8";
	};
	case 2: {
		phx_opforWeapons = "WEAPONS_CUP_USA_RANDOM";
	};
};

phx_magnifiedOptics = false; //Allow players to grab magnified optics from the gear selector
phx_addNVG = false; //Automatically add NVGs & lasers to players (Gen3, Black) - true for global add or side or array of sides
//Example: phx_addNVG = east will give side east NVGs, phx_addNVG = [east,west] will give sides east and west NVGs

publicVariable "phx_bluforUniform";
publicVariable "phx_opforUniform";
publicVariable "phx_bluforWeapons";
publicVariable "phx_opforWeapons";
publicVariable "phx_magnifiedOptics";
publicVariable "phx_addNVG";

/*
==========UNIFORM VALUES========== -- ==========WEAPON VALUES==========

=====BLUFOR=====                                =====ANY=====
UNIFORM_MARPAT_WD                  --   WEAPONS_US
UNIFORM_MARPAT_D                   --   WEAPONS_RU
UNIFORM_OEF_CP                     --   WEAPONS_IND
UNIFORM_PMC                        --   WEAPONS_G36
UNIFORM_M93_DESERT                 --   WEAPONS_GUERRILLA
UNIFORM_M93_WOODLAND               --   WEAPONS_M21
UNIFORM_ARMY_OCP                   --   WEAPONS_SCAR
UNIFORM_UCP                        --   WEAPONS_VHS
UNIFORM_CTRG_WD                    --	WEAPONS_CUP_SMAW_SPOTTING
UNIFORM_ION_BK
UNIFORM_ION_WD
UNIFORM_ISRAEL_TAN
UNIFORM_RANGER
UNIFORM_DOMINOS

=====OPFOR=====
UNIFORM_EMR_SUMMER
UNIFORM_EMR_DESERT
UNIFORM_FLORA
UNIFORM_MOUNTAIN_FLORA
UNIFORM_GORKA_GREEN
UNIFORM_GORKA_BEREZKA
UNIFORM_SOVIET_CSAT
UNIFORM_PAPAJHONS

=====INDFOR=====
UNIFORM_M93_OAKLEAF
UNIFORM_M93_TIGER
UNIFORM_M93_GREEN
UNIFORM_M93_FLECKTARN
UNIFORM_M10_DESERT
UNIFORM_M10_MOUNTAIN
UNIFORM_GUERRILLA
UNIFORM_AAF
UNIFORM_ALTIS_LIZARD
=========================================================================================================================
*/
