disableSerialization;

//create Admin GUI Display
_phx_adminGUI = findDisplay 60000 createDisplay "RscDisplayEmpty";
phx_adminGUI = [_phx_adminGUI];

//Add pre defined buttons for each admin diary entry to be clicked on
_background = (phx_adminGUI select 0) ctrlCreate ["IGUIBack", -1];
_background ctrlSetPosition [0.25,-0.33,0.5,1.63]; //add 0.08 to last number for each new button
_background ctrlSetBackgroundColor [0,0,0,0.5];
_background ctrlCommit 0;

_essButton = (phx_adminGUI select 0) ctrlCreate ["RscButton", -1]; 
_essbutton ctrlSetPosition [0.275,0.03 - 0.33,0.45,0.05];
_essbutton ctrlSetText ("End Safe Start");
_essbutton buttonSetAction 'f_var_mission_timer = -1; publicVariableServer "f_var_mission_timer"; systemChat "Ending Safe Start";';
_essbutton ctrlCommit 0;

_mssButton = (phx_adminGUI select 0) ctrlCreate ["RscButton", -1]; 
_mssButton ctrlSetPosition [0.275,0.03 - 0.33 + 0.08,0.45,0.05];
_mssButton ctrlSetText ("-15 Seconds to Safe Start");
_mssButton buttonSetAction 'if !(f_var_mission_timer <= 15) then { f_var_mission_timer = f_var_mission_timer - 15; publicVariableServer "f_var_mission_timer";};
  systemChat format ["New safe start time: %1 Seconds", f_var_mission_timer];';
_mssButton ctrlCommit 0;

_pssButton = (phx_adminGUI select 0) ctrlCreate ["RscButton", -1]; 
_pssButton ctrlSetPosition [0.275,0.03 - 0.33 + 0.08 * 2,0.45,0.05];
_pssButton ctrlSetText ("+15 Seconds to Safe Start");
_pssButton buttonSetAction 'f_var_mission_timer = f_var_mission_timer + 15; publicVariableServer "f_var_mission_timer"; systemChat format ["New safe start time: %1 Seconds", f_var_mission_timer];';
_pssButton ctrlCommit 0;

_btwButton = (phx_adminGUI select 0) ctrlCreate ["RscButton", -1]; 
_btwButton ctrlSetPosition [0.275,0.03 - 0.33 + 0.08 * 3,0.45,0.05];
_btwButton ctrlSetText ("Blue Team Wins");
_btwButton buttonSetAction '1 remoteExec ["PHX_fnc_adminCommandHandeler", 2];';
_btwButton ctrlCommit 0;

_rtwButton = (phx_adminGUI select 0) ctrlCreate ["RscButton", -1]; 
_rtwButton ctrlSetPosition [0.275,0.03 - 0.33 + 0.08 * 4,0.45,0.05];
_rtwButton ctrlSetText ("Red Team Wins");
_rtwButton buttonSetAction '2 remoteExec ["PHX_fnc_adminCommandHandeler", 2];';
_rtwButton ctrlCommit 0;

_btpButton = (phx_adminGUI select 0) ctrlCreate ["RscButton", -1]; 
_btpButton ctrlSetPosition [0.275,0.03 - 0.33 + 0.08 * 5,0.45,0.05];
_btpButton ctrlSetText ("Blue Team +1");
_btpButton buttonSetAction '3 remoteExec ["PHX_fnc_adminCommandHandeler", 2];';
_btpButton ctrlCommit 0;

_btmButton = (phx_adminGUI select 0) ctrlCreate ["RscButton", -1]; 
_btmButton ctrlSetPosition [0.275,0.03 - 0.33 + 0.08 * 6,0.45,0.05];
_btmButton ctrlSetText ("Blue Team -1");
_btmButton buttonSetAction '4 remoteExec ["PHX_fnc_adminCommandHandeler", 2];';
_btmButton ctrlCommit 0;

_rtpButton = (phx_adminGUI select 0) ctrlCreate ["RscButton", -1]; 
_rtpButton ctrlSetPosition [0.275,0.03 - 0.33 + 0.08 * 7,0.45,0.05];
_rtpButton ctrlSetText ("Red Team +1");
_rtpButton buttonSetAction '5 remoteExec ["PHX_fnc_adminCommandHandeler", 2];';
_rtpButton ctrlCommit 0;

_rtmButton = (phx_adminGUI select 0) ctrlCreate ["RscButton", -1]; 
_rtmButton ctrlSetPosition [0.275,0.03 - 0.33 + 0.08 * 8,0.45,0.05];
_rtmButton ctrlSetText ("Red Team -1");
_rtmButton buttonSetAction '6 remoteExec ["PHX_fnc_adminCommandHandeler", 2];';
_rtmButton ctrlCommit 0;

_emnButton = (phx_adminGUI select 0) ctrlCreate ["RscButton", -1]; 
_emnButton ctrlSetPosition [0.275,0.03 - 0.33 + 0.08 * 9,0.45,0.05];
_emnButton ctrlSetText ("End Mission");
_emnButton buttonSetAction '"end1" remoteExec ["bis_fnc_endmissionserver", 2];';
_emnButton ctrlCommit 0;

_weaponsButton = (phx_adminGUI select 0) ctrlCreate ["RscButton", -1]; 
_weaponsButton ctrlSetPosition [0.275,0.03 - 0.33 + 0.08 * 10,0.45,0.05];
_weaponsButton ctrlSetText ("Open Weapons GUI for BLUFOR");
_weaponsButton buttonSetAction 'west call PHX_fnc_weaponListGUI;';
_weaponsButton ctrlCommit 0;

_weaponsButton = (phx_adminGUI select 0) ctrlCreate ["RscButton", -1]; 
_weaponsButton ctrlSetPosition [0.275,0.03 - 0.33 + 0.08 * 11,0.45,0.05];
_weaponsButton ctrlSetText ("Open Weapons GUI for OPFOR");
_weaponsButton buttonSetAction 'east call PHX_fnc_weaponListGUI;';
_weaponsButton ctrlCommit 0;

_weaponsButton = (phx_adminGUI select 0) ctrlCreate ["RscButton", -1]; 
_weaponsButton ctrlSetPosition [0.275,0.03 - 0.33 + 0.08 * 12,0.45,0.05];
_weaponsButton ctrlSetText ("Open Weapons GUI [RHS] for BLUFOR");
_weaponsButton buttonSetAction 'west call PHX_fnc_weaponListGUIRHS;';
_weaponsButton ctrlCommit 0;

_weaponsButton = (phx_adminGUI select 0) ctrlCreate ["RscButton", -1]; 
_weaponsButton ctrlSetPosition [0.275,0.03 - 0.33 + 0.08 * 13,0.45,0.05];
_weaponsButton ctrlSetText ("Open Weapons GUI [RHS] for OPFOR");
_weaponsButton buttonSetAction 'east call PHX_fnc_weaponListGUIRHS;';
_weaponsButton ctrlCommit 0;

_weaponsButton = (phx_adminGUI select 0) ctrlCreate ["RscButton", -1]; 
_weaponsButton ctrlSetPosition [0.275,0.03 - 0.33 + 0.08 * 14,0.45,0.05];
_weaponsButton ctrlSetText ("Open Uniforms GUI for BLUFOR");
_weaponsButton buttonSetAction 'west call PHX_fnc_uniformListGUI;';
_weaponsButton ctrlCommit 0;

_weaponsButton = (phx_adminGUI select 0) ctrlCreate ["RscButton", -1]; 
_weaponsButton ctrlSetPosition [0.275,0.03 - 0.33 + 0.08 * 15,0.45,0.05];
_weaponsButton ctrlSetText ("Open Uniforms GUI for OPFOR");
_weaponsButton buttonSetAction 'east call PHX_fnc_uniformListGUI;';
_weaponsButton ctrlCommit 0;

_weaponsButton = (phx_adminGUI select 0) ctrlCreate ["RscButton", -1]; 
_weaponsButton ctrlSetPosition [0.275,0.03 - 0.33 + 0.08 * 16,0.45,0.05];
_weaponsButton ctrlSetText ("Open Uniforms GUI [RHS] for BLUFOR");
_weaponsButton buttonSetAction 'west call PHX_fnc_uniformListGUIRHS;';
_weaponsButton ctrlCommit 0;

_weaponsButton = (phx_adminGUI select 0) ctrlCreate ["RscButton", -1]; 
_weaponsButton ctrlSetPosition [0.275,0.03 - 0.33 + 0.08 * 17,0.45,0.05];
_weaponsButton ctrlSetText ("Open Uniforms GUI [RHS] for OPFOR");
_weaponsButton buttonSetAction 'east call PHX_fnc_uniformListGUIRHS;';
_weaponsButton ctrlCommit 0;

_weaponsButton = (phx_adminGUI select 0) ctrlCreate ["RscButton", -1]; 
_weaponsButton ctrlSetPosition [0.275,0.03 - 0.33 + 0.08 * 18,0.45,0.05];
_weaponsButton ctrlSetText ("Open NVG GUI");
_weaponsButton buttonSetAction 'east call PHX_fnc_nvgGUI;';
_weaponsButton ctrlCommit 0;

_weaponsButton = (phx_adminGUI select 0) ctrlCreate ["RscButton", -1]; 
_weaponsButton ctrlSetPosition [0.275,0.03 - 0.33 + 0.08 * 19,0.45,0.05];
_weaponsButton ctrlSetText ("Open Magnified Optics GUI");
_weaponsButton buttonSetAction 'east call PHX_fnc_adminOpticsGUI;';
_weaponsButton ctrlCommit 0;