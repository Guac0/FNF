#include "WEAPONS_US.sqf"

if (!phx_loadout_hasSpecial) then {
  phx_loadout_rifle_weapon = "rhs_weap_m21a";
  phx_loadout_rifle_mag = "rhsgref_30rnd_556x45_m21:7";
  phx_loadout_rifle_mag_tracer = "rhsgref_30rnd_556x45_m21_t:4";
};

if (phx_loadout_hasUGL) then {
  phx_loadout_rifle_weapon = "rhs_weap_m21a_pbg40";
};

phx_selector_weapons = [];

//TODO unsure if M21 is opfor or blufor ammo
switch (side player) do {
  case west: {phx_loadout_uglAmmoWest = ["rhs_VOG25:6", "rhs_GRD40_White:3", "rhs_VG40OP_white:3"];};
  case independent: {phx_loadout_uglAmmoIndependent = ["rhs_VOG25:6", "rhs_GRD40_White:3", "rhs_VG40OP_white:3"];};
  case east: {phx_loadout_uglAmmoEast = ["rhs_VOG25:6", "rhs_GRD40_White:3", "rhs_VG40OP_white:3"];};
  default {};
};