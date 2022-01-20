
phx_loadout_sidearm_weapon = "";
phx_loadout_sidearm_mag = ":2";

phx_loadout_rifle_mag_tracer = ":4";
phx_loadout_rifle_mag = ":7";

if (phx_loadout_hasUGL) then {
  phx_loadout_rifle_weapon = "";
  //Optional weapon switcher (currently bugged):
  //phx_loadout_rifle_weapon = selectRandom ["weapon1","weapon2"];
  //phx_selector_weapons = [["weapon1","weapon2"]]; //Make sure this is a two-dimensional array
} else {
  phx_loadout_rifle_weapon = "";
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
/*if (pRole == ROLE_CLS) then { //optional special guns for medics
  phx_loadout_rifle_weapon = "";
  phx_loadout_rifle_mag = ":4";
};*/

//include this if you use randomized weapons so that it'll detect the mags for you. Comment out the mag code at the very top if using this.
//phx_loadout_sidearm_mag = ([phx_loadout_sidearm_weapon] call CBA_fnc_compatibleMagazines select 0) + ":2";
//phx_loadout_rifle_mag_tracer = ([phx_loadout_rifle_weapon] call CBA_fnc_compatibleMagazines select 1) + ":4";
//phx_loadout_rifle_mag = ([phx_loadout_rifle_weapon] call CBA_fnc_compatibleMagazines select 0) + ":7";