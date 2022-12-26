phx_loadout_sidearm_weapon = selectRandom ["CUP_hgun_Makarov","CUP_hgun_TT","CUP_hgun_PMM","CUP_hgun_SA61"];

if (phx_loadout_hasUGL) then {
  phx_loadout_rifle_weapon = selectRandom ["CUP_arifle_AK74M_GL","CUP_arifle_AK19_GP34_black","CUP_arifle_AK103_GL"];
  //phx_selector_weapons = [[""]];
} else {
  phx_loadout_rifle_weapon = selectRandom ["CUP_arifle_AK74M","CUP_arifle_AK19_AFG_black","CUP_arifle_AK103"];
};
if (pRole == ROLE_AR || pRole == ROLE_MG) then {
  phx_loadout_rifle_weapon = selectRandom ["CUP_lmg_PKM_B50_vfg","CUP_lmg_Pecheneg_B50_vfg","CUP_arifle_RPK74","CUP_arifle_RPK74M"];
};
//if (pRole == ROLE_MG) then {
//  phx_loadout_rifle_weapon = selectRandom ["","",""];
//};
if (pRole == ROLE_RAT) then {
  phx_loadout_antitank_weapon = selectRandom ["CUP_launch_RPG26","CUP_launch_RPG18","CUP_launch_RShG2"];
};
if (pRole == ROLE_MK) then {
  phx_loadout_rifle_weapon = selectRandom ["CUP_srifle_SVD_top_rail","CUP_SKS_rail","srifle_GM6_F"];
};
if (pRole == ROLE_CLS) then {
  phx_loadout_rifle_weapon = selectRandom ["CUP_arifle_AKS74U","CUP_arifle_OTS14_GROZA_762","CUP_smg_vityaz_vfg","CUP_sgun_Saiga12K","CUP_arifle_SR3M_Vikhr_VFG"];
};

phx_loadout_sidearm_mag = ([phx_loadout_sidearm_weapon] call CBA_fnc_compatibleMagazines select 0) + ":2";
phx_loadout_rifle_mag_tracer = ([phx_loadout_rifle_weapon] call CBA_fnc_compatibleMagazines select 1) + ":4";
phx_loadout_rifle_mag = ([phx_loadout_rifle_weapon] call CBA_fnc_compatibleMagazines select 0) + ":7";

switch (side player) do {
  case west: {phx_loadout_uglAmmoWest = ["CUP_1Rnd_HE_GP25_M:6", "CUP_1Rnd_SMOKE_GP25_M:3", "CUP_IlumFlareWhite_GP25_M:3"];};
  case independent: {phx_loadout_uglAmmoIndependent = ["CUP_1Rnd_HE_GP25_M:6", "CUP_1Rnd_SMOKE_GP25_M:3", "CUP_IlumFlareWhite_GP25_M:3"];};
  case east: {phx_loadout_uglAmmoEast = ["CUP_1Rnd_HE_GP25_M:6", "CUP_1Rnd_SMOKE_GP25_M:3", "CUP_IlumFlareWhite_GP25_M:3"];};
  default {};
};