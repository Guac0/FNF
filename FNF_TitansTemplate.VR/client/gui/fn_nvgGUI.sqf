disableSerialization;

//create Admin Weapons GUI Display
_phx_weaponListGUI = findDisplay 46 createDisplay "RscDisplayEmpty"; //uses map screen as basis since activated via diary entry
phx_weaponListGUI = [_phx_weaponListGUI];

//Add pre defined buttons for each admin diary entry to be clicked on
//background
_background = (phx_weaponListGUI select 0) ctrlCreate ["IGUIBack", -1];
_background ctrlSetPosition [0.25,0,0.5,0.83]; //change last number for total length
_background ctrlSetBackgroundColor [0,0,0,0.5];
_background ctrlCommit 0;

//No nvgs
_button1 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
_button1 ctrlSetPosition [0.275,0.03,0.45,0.05];
_button1 ctrlSetText ("No NVGs");
_button1 buttonSetAction 'phx_addNVG = "false"; publicVariable "phx_addNVG";';
_button1 ctrlCommit 0;

//NVGs for all
_button2 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
_button2 ctrlSetPosition [0.275,0.03 + 0.08,0.45,0.05];
_button2 ctrlSetText ("NVGs for all");
_button2 buttonSetAction 'phx_addNVG = "true"; publicVariable "phx_addNVG";';
_button2 ctrlCommit 0;

//NVGs for west only
_button3 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
_button3 ctrlSetPosition [0.275,0.03 + 0.08 * 2,0.45,0.05];
_button3 ctrlSetText ("NVGs for BLUFOR only");
_button3 buttonSetAction 'phx_addNVG = "west"; publicVariable "phx_addNVG";';
_button3 ctrlCommit 0;

//NVGs for east only
_button4 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
_button4 ctrlSetPosition [0.275,0.03 + 0.08 * 3,0.45,0.05];
_button4 ctrlSetText ("NVGs for OPFOR only");
_button4 buttonSetAction 'phx_addNVG = "east"; publicVariable "phx_addNVG";';
_button4 ctrlCommit 0;
