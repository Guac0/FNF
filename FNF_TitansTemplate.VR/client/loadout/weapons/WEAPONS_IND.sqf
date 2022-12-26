#include "WEAPONS_RU.sqf"

if (!phx_loadout_hasSpecial) then {
  phx_loadout_rifle_weapon = "rhs_weap_akmn";
  
  phx_loadout_rifle_mag_tracer = "rhs_30Rnd_762x39mm_polymer_tracer:4";
  phx_loadout_rifle_mag = "rhs_30Rnd_762x39mm_polymer:7";

  if (phx_loadout_hasUGL) then {phx_loadout_rifle_weapon = "rhs_weap_akmn_gp25"};
};

switch (side player) do {
  case west: {phx_loadout_uglAmmoWest = ["rhs_VOG25:6", "rhs_GRD40_White:3", "rhs_VG40OP_white:3"];};
  case independent: {phx_loadout_uglAmmoIndependent = ["rhs_VOG25:6", "rhs_GRD40_White:3", "rhs_VG40OP_white:3"];};
  case east: {phx_loadout_uglAmmoEast = ["rhs_VOG25:6", "rhs_GRD40_White:3", "rhs_VG40OP_white:3"];};
  default {};
};