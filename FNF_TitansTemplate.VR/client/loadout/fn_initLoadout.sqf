_roleChosen = _this;

call phx_fnc_loadout_vars; //sets the variables the loadout system uses

//Set player role from class of their unit
pRole = _rolechosen;

if (isNil "pRole") exitWith {
  hint "Player role not set correctly. Alert the mission maker and join another slot.";
  player enableSimulation false;
  endMission "END1"
};
player linkItem "ItemMap";

if (pRole in [ROLE_PL,ROLE_SL,ROLE_TL,ROLE_MGTL]) then {phx_loadout_hasUGL = true} else {phx_loadout_hasUGL = false};
if (pRole in [ROLE_AR,ROLE_MG,ROLE_MK,ROLE_P]) then {phx_loadout_hasSpecial = true} else {phx_loadout_hasSpecial = false};

if (pRole == ROLE_CIV) exitWith {};

phx_loadout_unitLevel = 0;
if (pRole in [ROLE_PL,ROLE_SL]) then {phx_loadout_unitLevel = 2};
if (pRole in [ROLE_TL,ROLE_MGTL]) then {phx_loadout_unitLevel = 1};
//Shared
phx_loadout_aid = "FirstAidKit:4";
phx_loadout_smoke = "SmokeShell:2";
phx_loadout_grenade = "HandGrenade:2";
phx_loadout_thermite = "ACE_M14:2";
phx_loadout_maptools = "ACE_MapTools";
phx_loadout_cableTie = "ACE_CableTie:2";
phx_loadout_nvg = "NVGoggles_OPFOR";
//phx_loadout_uglAmmoEast = ["rhs_VOG25:6", "rhs_GRD40_White:3", "rhs_VG40OP_white:3"];
phx_loadout_uglAmmoEast = ["1Rnd_HE_Grenade_shell:6", "1Rnd_Smoke_Grenade_shell:3", "UGL_FlareWhite_F:3"];
phx_loadout_uglAmmoWest = ["1Rnd_HE_Grenade_shell:6", "1Rnd_Smoke_Grenade_shell:3", "UGL_FlareWhite_F:3"];
//CE
phx_loadout_explosives = ["1x Satchel","SatchelCharge_Remote_Mag:1"];
phx_loadout_defusalkit = "ACE_DefusalKit";
phx_loadout_trigger = "ACE_M26_Clacker";
phx_loadout_entrenching = "ACE_EntrenchingTool";
phx_loadout_detector = "MineDetector";
//Medic
phx_loadout_PAK = "ACE_personalAidKit";
phx_loadout_bandage = "ACE_fieldDressing:32";
phx_loadout_morphine = "ACE_morphine:16";
phx_loadout_epinephrine = "ACE_epinephrine:8";
phx_loadout_blood_1 = "ACE_bloodIV_500:12";
phx_loadout_blood_2 = "ACE_bloodIV_250:4";
//Range
phx_loadout_binocular = "Binocular";
phx_loadout_vector = "ACE_VectorDay";
phx_loadout_rifle_optic = "optic_DMS";
//rhs
//phx_selector_optics = ["optic_Holosight_blk_F", "rhsusf_acc_eotech_xps3", "rhsusf_acc_compm4", "rhsusf_acc_T1_high", "rhs_acc_1p63", "rhs_acc_ekp1", "rhs_acc_ekp8_02", "rhs_acc_okp7_dovetail", "rhs_acc_pkas"];
//phx_selector_magOptics = ["rhsusf_acc_ACOG", "rhsusf_acc_ACOG_RMR", "rhsusf_acc_su230", "rhsusf_acc_su230_mrds", "optic_MRCO", "optic_Hamr", "optic_Arco_blk_F", "rhsusf_acc_ELCAN", "rhs_acc_1p29", "rhs_acc_1p78", "rhs_acc_nita", "rhs_acc_pso1m2_ak"];
//vanilla
//phx_selector_optics = ["optic_holosight", "optic_aco_grn", "optic_aco"];
//phx_selector_magOptics = ["optic_mrco","optic_hamr","optic_arco"];
//now has some CUP western optics
phx_selector_optics = ["optic_holosight", "optic_aco_grn", "optic_aco", "cup_optic_aimpoint_5000", "cup_optic_ac11704_black", "cup_optic_mars"];
phx_selector_magOptics = ["optic_mrco","optic_hamr","optic_arco", "optic_erco_blk_f", "cup_optic_acog_ta01b_rmr_black", "cup_optic_g33_hws_blk", "cup_optic_elcan_specterdr_rmr_black"];

phx_selector_explosives = [
phx_loadout_explosives,
["2x Demo charge", "DemoCharge_Remote_Mag:2"]
];

call phx_fnc_setUniform;
call phx_fnc_setWeapons;