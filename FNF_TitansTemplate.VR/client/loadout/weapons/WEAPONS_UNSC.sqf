
phx_loadout_sidearm_weapon = "OPTRE_M6G";
phx_loadout_sidearm_mag = "OPTRE_8Rnd_127x40_Mag_Tracer:2";

phx_loadout_rifle_mag_tracer = "OPTRE_32Rnd_762x51_Mag_Tracer:4";
phx_loadout_rifle_mag = "OPTRE_32Rnd_762x51_Mag:7";

if (phx_loadout_hasUGL) then {
  //phx_loadout_rifle_weapon = "OPTRE_MA5CGL";
  //Optional weapon switcher (currently bugged):
  phx_loadout_rifle_weapon = selectRandom ["OPTRE_MA5CGL","OPTRE_MA37GL"];
  //phx_selector_weapons = [["OPTRE_MA5CGL","OPTRE_MA32GL"]]; //Make sure this is a two-dimensional array
 // phx_loadout_rifle_mag = ([phx_loadout_rifle_weapon] call CBA_fnc_compatibleMagazines select 0) + ":7";
  //phx_loadout_rifle_mag_tracer = ([phx_loadout_rifle_weapon] call CBA_fnc_compatibleMagazines select 1) + ":4";
} else {
  phx_loadout_rifle_weapon = selectRandom ["OPTRE_MA5C","OPTRE_MA37","OPTRE_BR55","OPTRE_HMG38"];
  //phx_selector_weapons = [["OPTRE_MA5C","OPTRE_MA32"]];
  //phx_loadout_rifle_mag = ([phx_loadout_rifle_weapon] call CBA_fnc_compatibleMagazines select 0) + ":7";
  //phx_loadout_rifle_mag_tracer = ([phx_loadout_rifle_weapon] call CBA_fnc_compatibleMagazines select 1) + ":4";
};
if (pRole == ROLE_AR) then {
  phx_loadout_rifle_weapon = "OPTRE_M73";
  phx_loadout_rifle_mag = "OPTRE_200Rnd_95x40_Box_Tracer:7";
};
if (pRole == ROLE_MG) then {
  phx_loadout_rifle_weapon = "OPTRE_M247";
  phx_loadout_rifle_mag = "OPTRE_100Rnd_762x51_Box_Tracer:7";
};
if (pRole == ROLE_RAT) then {
  //phx_loadout_antitank_weapon = "OPTRE_M41_SSR"; 
  phx_loadout_antitank_weapon = "DMNS_M96_LAW"; //not treb btw
};
if (pRole == ROLE_MK) then {
  phx_loadout_rifle_weapon = selectRandom ["OPTRE_BR37","OPTRE_SRS99D","OPTRE_M295_BMR","OPTRE_M392_DMR","OPTRE_M393_DMR"];
  //phx_loadout_rifle_mag = "OPTRE_4Rnd_145x114_APFSDS_Mag:5";
};
if (pRole == ROLE_CLS) then { //optional special guns for medics
  phx_loadout_rifle_weapon = selectRandom ["OPTRE_M7","OPTRE_M12_SOC","OPTRE_Commando"];
  //phx_loadout_rifle_mag = "OPTRE_48Rnd_5x23mm_FMJ_Mag:7";
};
if (pRole == ROLE_CR) then {
  phx_loadout_rifle_weapon = selectRandom ["OPTRE_M45E","OPTRE_M45","OPTRE_M45ATAC"];
};

//OPTRE_MA32
//OPTRE_MA32GL
//OPTRE_32Rnd_762x51_Mag
//OPTRE_BR55
//OPTRE_36Rnd_95x40_Mag
//OPTRE_M295_BMR
//OPTRE_25Rnd_762x51_Mag
//OPTRE_M392_DMR
//OPTRE_15Rnd_762x51_Mag
//OPTRE_M45
//OPTRE_6Rnd_8Gauge_Pellets
//OPTRE_M45ATAC
//OPTRE_6Rnd_8Gauge_Pellets
//OPTRE_Commando
//Commando_20Rnd_65_Mag

//include this if you use randomized weapons so that it'll detect the mags for you. Comment out the mag code at the very top if using this.
//phx_loadout_sidearm_mag = ([phx_loadout_sidearm_weapon] call CBA_fnc_compatibleMagazines select 0) + ":2";
phx_loadout_rifle_mag_tracer = ([phx_loadout_rifle_weapon] call CBA_fnc_compatibleMagazines select 1) + ":4";
phx_loadout_rifle_mag = ([phx_loadout_rifle_weapon] call CBA_fnc_compatibleMagazines select 0) + ":7";