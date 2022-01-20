//CUP xm8

phx_loadout_sidearm_weapon = "CUP_hgun_CZ75";
phx_loadout_sidearm_mag = "CUP_16Rnd_9x19_cz75:2";

phx_loadout_rifle_mag_tracer = "CUP_30Rnd_TE1_Yellow_Tracer_556x45_XM8:4";
phx_loadout_rifle_mag = "CUP_30Rnd_556x45_XM8:7";

if (phx_loadout_hasUGL) then {
  phx_loadout_rifle_weapon = "CUP_arifle_XM8_Carbine_GL";
  //phx_selector_weapons = [[""]];
} else {
  phx_loadout_rifle_weapon = "CUP_arifle_XM8_Carbine_FG";
  //phx_selector_weapons = [[""]];
};
if (pRole == ROLE_AR) then {
  phx_loadout_rifle_weapon = "CUP_arifle_xm8_SAW";
  phx_loadout_rifle_mag = "CUP_100Rnd_TE1_Yellow_Tracer_556x45_BetaCMag:7";
};
if (pRole == ROLE_MG) then {
  phx_loadout_rifle_weapon = "CUP_arifle_xm8_SAW";
  phx_loadout_rifle_mag = "CUP_100Rnd_TE1_Yellow_Tracer_556x45_BetaCMag:7";
};
if (pRole == ROLE_RAT) then {
  phx_loadout_antitank_weapon = "CUP_launch_M72A6";
};
if (pRole == ROLE_MK) then {
  phx_loadout_rifle_weapon = "CUP_arifle_xm8_sharpshooter";
  phx_loadout_rifle_mag = "CUP_30Rnd_556x45_XM8:7";
};
if (pRole == ROLE_CLS) then {
  phx_loadout_rifle_weapon = "CUP_arifle_XM8_Compact";
};
