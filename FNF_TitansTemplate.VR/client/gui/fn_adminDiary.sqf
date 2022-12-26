if (serverCommandAvailable "#kick") then {
  PHX_Diary = player createDiarySubject ["PHX_Diary_Admin_Safestart", "Admin", "\A3\ui_f\data\igui\cfg\simpleTasks\types\defend_ca.paa"];
  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='""end1"" remoteExec [""bis_fnc_endmissionserver"", 2];'>End Mission</execute>"]];
  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='f_var_mission_timer = -1; publicVariableServer ""f_var_mission_timer""; systemChat ""Ending Safe Start"";'>End Safe Start</execute>"]];
  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='
  if !(f_var_mission_timer <= 15) then {
    f_var_mission_timer = f_var_mission_timer - 15;
    publicVariableServer ""f_var_mission_timer"";
  };
  systemChat format [""New safe start time: %1 seconds"", f_var_mission_timer];
  '>-15 Seconds to Safe Start</execute>"]];
  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='
  f_var_mission_timer = f_var_mission_timer + 15;
  publicVariableServer ""f_var_mission_timer"";
  systemChat format [""New safe start time: %1 seconds"", f_var_mission_timer];
  '>+15 Seconds to Safe Start</execute>"]];
  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='1 remoteExec [""PHX_fnc_adminCommandHandeler"", 2];'>Blue Team Wins</execute>"]];
  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='2 remoteExec [""PHX_fnc_adminCommandHandeler"", 2];'>Red Team Wins</execute>"]];
  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='3 remoteExec [""PHX_fnc_adminCommandHandeler"", 2];'>Blue Team +1</execute>"]];
  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='4 remoteExec [""PHX_fnc_adminCommandHandeler"", 2];'>Blue Team -1</execute>"]];
  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='5 remoteExec [""PHX_fnc_adminCommandHandeler"", 2];'>Red Team +1</execute>"]];
  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='6 remoteExec [""PHX_fnc_adminCommandHandeler"", 2];'>Red Team -1</execute>"]];
  
  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='west call PHX_fnc_weaponListGUI;'>Open Weapons GUI for BLUFOR</execute>"]];
  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='east call PHX_fnc_weaponListGUI;'>Open Weapons GUI for OPFOR</execute>"]];
  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='west call PHX_fnc_weaponListGUIRHS;'>Open Weapons GUI [RHS] for BLUFOR</execute>"]];
  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='east call PHX_fnc_weaponListGUIRHS;'>Open Weapons GUI [RHS] for OPFOR</execute>"]];

  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='west call PHX_fnc_uniformListGUI;'>Open Uniform GUI for BLUFOR</execute>"]];
  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='east call PHX_fnc_uniformListGUI;'>Open Uniform GUI for OPFOR</execute>"]];
   player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='west call PHX_fnc_uniformListGUIRHS;'>Open Uniform GUI [RHS] for BLUFOR</execute>"]];
  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='east call PHX_fnc_uniformListGUIRHS;'>Open Uniform GUI [RHS] for OPFOR</execute>"]];

  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='call PHX_fnc_nvgGUI;'>Open NVG GUI</execute>"]];

  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='east call PHX_fnc_adminOpticsGUI;'>Open Admin Optics GUI</execute>"]];

  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='call PHX_fnc_swapSides;'>Swap sides on next round start</execute>"]];
};