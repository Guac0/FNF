phx_loadout_backpack = "B_AssaultPack_rgr";

if (pRole == ROLE_CLS) then {
  phx_loadout_backpack = "B_FieldPack_khk";
};
if (pRole == ROLE_AAR || pRole == ROLE_AM || pRole == ROLE_AAT) then {
  phx_loadout_backpack = "B_Carryall_oli";
};
if (pRole == ROLE_CE) then {
  phx_loadout_backpack = "B_Kitbag_rgr";
};

if (pRole == ROLE_P) then {
  phx_loadout_headgear = "H_PilotHelmetHeli_O";
  phx_loadout_vest = "V_TacVest_oli";
};
if (pRole == ROLE_CR) then {
  phx_loadout_headgear = "H_HelmetCrew_O";
};