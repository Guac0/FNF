
phx_loadout_sidearm_weapon = "";
phx_loadout_sidearm_mag = ":2";

phx_loadout_rifle_mag_tracer = ":4";
phx_loadout_rifle_mag = ":7";

if (phx_loadout_hasUGL) then {
  phx_loadout_rifle_weapon = "";
  //phx_selector_weapons = [[""]];
} else {
  phx_loadout_rifle_weapon = "";
  //phx_selector_weapons = [[""]];
};
if (pRole == ROLE_AR) then {
  phx_loadout_rifle_weapon = "";
  phx_loadout_rifle_mag = ":7";
};
if (pRole == ROLE_MG) then {
  phx_loadout_rifle_weapon = "";
  phx_loadout_rifle_mag = ":7";
};
if (pRole == ROLE_RAT) then {
  phx_loadout_antitank_weapon = "";
};
if (pRole == ROLE_MK) then {
  phx_loadout_rifle_weapon = "";
  phx_loadout_rifle_mag = ":7";
};
/*if (pRole == ROLE_CLS) then {
  phx_loadout_rifle_weapon = "";
  phx_loadout_rifle_mag = ":4";
};*/
