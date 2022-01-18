
phx_loadout_sidearm_weapon = selectRandom ["CUP_hgun_Glock17","CUP_hgun_M17_Black","CUP_hgun_M9A1"];

if (phx_loadout_hasUGL) then {
  phx_loadout_rifle_weapon = selectRandom ["CUP_arifle_M16A1E1GL","CUP_arifle_M4A1_BUIS_GL","CUP_arifle_Mk17_STD_EGLM"];
  //phx_selector_weapons = [[""]];
} else {
  phx_loadout_rifle_weapon = selectRandom ["CUP_arifle_M16A1E1","CUP_arifle_M4A3_black","CUP_arifle_Mk17_STD_AFG"];
  //phx_selector_weapons = [["CUP_arifle_M16A1E1"]];
};
if (pRole == ROLE_AR || pRole == ROLE_MG) then {
  phx_loadout_rifle_weapon = selectRandom ["CUP_lmg_M240_B","CUP_lmg_m249_pip2","CUP_lmg_M60E4_norail"];
};
//if (pRole == ROLE_MG) then {
//  phx_loadout_rifle_weapon = selectRandom ["","",""];
//};
if (pRole == ROLE_RAT) then {
  phx_loadout_antitank_weapon = selectRandom ["CUP_launch_M136","CUP_launch_M72A6"];
};
if (pRole == ROLE_MK) then {
  phx_loadout_rifle_weapon = selectRandom ["CUP_srifle_Mk12SPR","CUP_srifle_m110_kac_black","CUP_srifle_M14_DMR","CUP_srifle_M2010_blk"];
};
/*if (pRole == ROLE_CLS) then {
  phx_loadout_rifle_weapon = "";
  phx_loadout_rifle_mag = ":4";
};*/

phx_loadout_sidearm_mag = ([phx_loadout_sidearm_weapon] call CBA_fnc_compatibleMagazines select 0) + ":2";
phx_loadout_rifle_mag_tracer = ([phx_loadout_rifle_weapon] call CBA_fnc_compatibleMagazines select 1) + ":4";
phx_loadout_rifle_mag = ([phx_loadout_rifle_weapon] call CBA_fnc_compatibleMagazines select 0) + ":7";