#include "radioOffsets.hpp"

phx_groups = [
  //Platoon
  [["Blue_PHQ","PLTHQ","Platoon HQ", 2, [Platoon, Platoon.1, Alpha, Bravo, Charlie, Delta, Golf, Hotel]],
  [blu_pl_1,"Platoon Leader"],
  [blu_pl_2,"Platoon Sergeant"],
  [blu_pl_3,"Medic"]],
  //XRAY
  [["Blue_X","XRAY","X-Ray (Recon)", 1, [Platoon.2, Platoon]],
  [blu_x_1,"Team Leader"],
  [blu_x_2,"Sniper"],
  [blu_x_3,"Grenadier"],
  [blu_x_4,"Medic"],
  [blu_x_5,"Rifleman (suppressor)"],
  [blu_x_6,"Rifleman (suppressor)"]],

  //Alpha
  [["Blue_A","A HQ","Alpha Squad", 1, [Alpha, Platoon]],
  [blu_a_1,"Squad Leader"],
  [blu_a_2,"Crew/Wpn Operator"],
  [blu_a_3,"Crew/Wpn Operator"]],
  //A1
  [["Blue_A1","A1","Alpha One", 0, [Alpha.1, Alpha]],
  [blu_a1_1,"Team Leader"],
  [blu_a1_2,"Autorifleman"],
  [blu_a1_3,"Asst. Autorifleman"],
  [blu_a1_4,"AT Rifleman"],
  [blu_a1_5,"Marksman"],
  [blu_a1_6,"Combat Engineer"],
  [blu_a1_7,"Medic"]],
  //A2
  [["Blue_A2","A2","Alpha Two", 0, [Alpha.2, Alpha]],
  [blu_a2_1,"Team Leader"],
  [blu_a2_2,"Machine Gunner"],
  [blu_a2_3,"Asst. Machine Gunner"],
  [blu_a2_4,"AT Rifleman"],
  [blu_a2_5,"Grenadier"],
  [blu_a2_6,"Combat Engineer"],
  [blu_a2_7,"Medic"]],

  //Bravo
  [["Blue_B","B HQ","Bravo Squad", 1, [Bravo, Platoon]],
  [blu_b_1,"Squad Leader"],
  [blu_b_2,"Crew/Wpn Operator"],
  [blu_b_3,"Crew/Wpn Operator"]],
  //B1
  [["Blue_B1","B1","Bravo One", 0, [Bravo.1, Bravo]],
  [blu_b1_1,"Team Leader"],
  [blu_b1_2,"AT Specialist"],
  [blu_b1_3,"Asst. AT Specialist"],
  [blu_b1_4,"Asst. AT Specialist"],
  [blu_b1_5,"Rifleman"],
  [blu_b1_6,"Grenadier"],
  [blu_b1_7,"Medic"]],
  //B2
  [["Blue_B2","B2","Bravo Two", 0, [Bravo.2, Bravo]],
  [blu_b2_1,"Team Leader"],
  [blu_b2_2,"Machine Gunner"],
  [blu_b2_3,"Asst. Machine Gunner"],
  [blu_b2_4,"Machine Gunner"],
  [blu_b2_5,"Asst. Machine Gunner"],
  [blu_b2_6,"Combat Engineer"],
  [blu_b2_7,"Medic"]],

  //Charlie
  [["Blue_C","C HQ","Charlie Squad", 1, [Charlie, Platoon]],
  [blu_c_1,"Squad Leader"],
  [blu_c_2,"Crew/Wpn Operator"],
  [blu_c_3,"Crew/Wpn Operator"]],
  //C1
  [["Blue_C1","C1","Charlie One", 0, [Charlie.1, Charlie]],
  [blu_c1_1,"Team Leader"],
  [blu_c1_2,"Autorifleman"],
  [blu_c1_3,"Asst. Autorifleman"],
  [blu_c1_4,"AT Rifleman"],
  [blu_c1_5,"Marksman"],
  [blu_c1_6,"Combat Engineer"],
  [blu_c1_7,"Medic"]],
  //C2
  [["Blue_C2","C2","Charlie Two", 0, [Charlie.2, Charlie]],
  [blu_c2_1,"Team Leader"],
  [blu_c2_2,"Machine Gunner"],
  [blu_c2_3,"Asst. Machine Gunner"],
  [blu_c2_4,"AT Rifleman"],
  [blu_c2_5,"Grenadier"],
  [blu_c2_6,"Combat Engineer"],
  [blu_c2_7,"Medic"]],

  //Delta
  [["Blue_D","D HQ","Delta Squad", 1, [Delta, Platoon]],
  [blu_d_1,"Squad Leader"],
  [blu_d_2,"Crew/Wpn Operator"],
  [blu_d_3,"Crew/Wpn Operator"]],
  //D1
  [["Blue_D1","D1","Delta One", 0, [Delta.1, Delta]],
  [blu_d1_1,"Team Leader"],
  [blu_d1_2,"AT Specialist"],
  [blu_d1_3,"Asst. AT Specialist"],
  [blu_d1_4,"Asst. AT Specialist"],
  [blu_d1_5,"Rifleman"],
  [blu_d1_6,"Grenadier"],
  [blu_d1_7,"Medic"]],
  //D2
  [["Blue_D2","D2","Delta Two", 0, [Delta.2, Delta]],
  [blu_d2_1,"Team Leader"],
  [blu_d2_2,"Machine Gunner"],
  [blu_d2_3,"Asst. Machine Gunner"],
  [blu_d2_4,"Machine Gunner"],
  [blu_d2_5,"Asst. Machine Gunner"],
  [blu_d2_6,"Combat Engineer"],
  [blu_d2_7,"Medic"]],

  //G1
  [["Blue_G1","G1","Golf One (Vic)", 0, [Golf.1, Platoon]],
  [blu_g1_1,"Vehicle Cmdr"],
  [blu_g1_2,"Crewman"],
  [blu_g1_3,"Crewman"]],
  //G2
  [["Blue_G2","G2","Golf Two (Vic)", 0, [Golf.2, Platoon]],
  [blu_g2_1,"Vehicle Cmdr"],
  [blu_g2_2,"Crewman"],
  [blu_g2_3,"Crewman"]],
  //G3
  [["Blue_G3","G3","Golf Three (Vic)", 0, [Golf.3, Platoon]],
  [blu_g3_1,"Vehicle Cmdr"],
  [blu_g3_2,"Crewman"],
  [blu_g3_3,"Crewman"]],
  //G4
  [["Blue_G4","G4","Golf Four (Vic)", 0, [Golf.4, Platoon]],
  [blu_g4_1,"Vehicle Cmdr"],
  [blu_g4_2,"Crewman"],
  [blu_g4_3,"Crewman"]],

  //H1
  [["Blue_H1","H1","Hotel One (Air)", 0, [Hotel.1, Platoon]],
  [blu_h1_1,"Pilot"],
  [blu_h1_2,"Pilot"],
  [blu_h1_3,"Pilot"]],
  //H2
  [["Blue_H2","H2","Hotel Two (Air)", 0, [Hotel.2, Platoon]],
  [blu_h2_1,"Pilot"],
  [blu_h2_2,"Pilot"],
  [blu_h2_3,"Pilot"]],
  //H3
  [["Blue_H3","H3","Hotel Three (Air)", 0, [Hotel.3, Platoon]],
  [blu_h3_1,"Pilot"],
  [blu_h3_2,"Pilot"],
  [blu_h3_3,"Pilot"]]
];

playerGroup = grpNull;
playerGroupStr = "";
playerGroupArray = [];

_groupIndex = ([phx_groups, player] call BIS_fnc_findNestedElement);
if (count _groupIndex > 0) then {
  playerGroupArray = [phx_groups, [_groupIndex select 0, 0]] call BIS_fnc_returnNestedElement;
  playerGroupStr = playerGroupArray select 0;
  playerGroup = missionNamespace getVariable [playerGroupStr,grpNull];
};
