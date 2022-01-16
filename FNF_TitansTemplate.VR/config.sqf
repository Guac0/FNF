//Uniforms
//phx_bluforUniform = "UNIFORM_MARPAT_WD";
//phx_opforUniform = "UNIFORM_EMR_SUMMER";
//phx_bluforUniform = "bluforUniform" call BIS_fnc_getParamValue;
//phx_opforUniform = "opforUniform" call BIS_fnc_getParamValue;

//BIS_fnc_getParam can only return a number, not a string, so we have to convert it into a string here via a switch statement that manually checks and assigns it
//I wonder if there's a better way to do this...
private _bluforUniformValue = "bluforUniform" call BIS_fnc_getParamValue;
systemchat str _bluforUniiformValue;
switch (_bluforUniformValue) do {
	default {
		phx_bluforUniform = "UNIFORM_MARPAT_WD";
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
};

private _opforUniformValue = "opforUniform" call BIS_fnc_getParamValue;
switch (_opforUniformValue) do {
	default {
		phx_bluforUniform = "UNIFORM_EMR_SUMMER";
	};
	case 0: { //default for the param in role select
		phx_bluforUniform = "UNIFORM_EMR_SUMMER";
	};
	case 1: {
		phx_bluforUniform = "UNIFORM_EMR_DESERT";
	};
	case 2: {
		phx_bluforUniform = "UNIFORM_FLORA";
	};
};


//Weapons
phx_bluforWeapons = "WEAPONS_US";
phx_opforWeapons = "WEAPONS_RU";

phx_magnifiedOptics = false; //Allow players to grab magnified optics from the gear selector
phx_addNVG = false; //Automatically add NVGs & lasers to players (Gen3, Black) - true for global add or side or array of sides
//Example: phx_addNVG = east will give side east NVGs, phx_addNVG = [east,west] will give sides east and west NVGs

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
UNIFORM_CTRG_WD                    --
UNIFORM_ION_BK
UNIFORM_ION_WD
UNIFORM_ISRAEL_TAN
UNIFORM_RANGER

=====OPFOR=====
UNIFORM_EMR_SUMMER
UNIFORM_EMR_DESERT
UNIFORM_FLORA
UNIFORM_MOUNTAIN_FLORA
UNIFORM_GORKA_GREEN
UNIFORM_GORKA_BEREZKA
UNIFORM_SOVIET_CSAT

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
