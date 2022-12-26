
//background
_background = (phx_weaponListGUI select 0) ctrlCreate ["IGUIBack", -1];
_background ctrlSetPosition [0.25,0,0.5,0.83]; //change last number for total length
_background ctrlSetBackgroundColor [0,0,0,0.5];
_background ctrlCommit 0;

_button1 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
_button1 ctrlSetPosition [0.275,0.03,0.45,0.05];
_button1 ctrlSetText ("0.25 Seconds");
_button1 buttonSetAction 'TAS_pointAddTime = .25; publicVariable "TAS_pointAddTime";';
_button1 ctrlCommit 0;

_button2 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
_button2 ctrlSetPosition [0.275,0.03 + 0.08,0.45,0.05];
_button2 ctrlSetText ("0.33 Seconds");
_button2 buttonSetAction 'TAS_pointAddTime = .33; publicVariable "TAS_pointAddTime";';
_button2 ctrlCommit 0;

_button3 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
_button3 ctrlSetPosition [0.275,0.03 + 0.08 * 2,0.45,0.05];
_button3 ctrlSetText ("0.5 Seconds");
_button3 buttonSetAction 'TAS_pointAddTime = .5; publicVariable "TAS_pointAddTime";';
_button3 ctrlCommit 0;

_button3 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
_button3 ctrlSetPosition [0.275,0.03 + 0.08 * 3,0.45,0.05];
_button3 ctrlSetText ("0.67 Seconds");
_button3 buttonSetAction 'TAS_pointAddTime = .67; publicVariable "TAS_pointAddTime";';
_button3 ctrlCommit 0;

_button3 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
_button3 ctrlSetPosition [0.275,0.03 + 0.08 * 4,0.45,0.05];
_button3 ctrlSetText ("0.75 Seconds");
_button3 buttonSetAction 'TAS_pointAddTime = .75; publicVariable "TAS_pointAddTime";';
_button3 ctrlCommit 0;

_button3 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
_button3 ctrlSetPosition [0.275,0.03 + 0.08 * 5,0.45,0.05];
_button3 ctrlSetText ("1 Seconds");
_button3 buttonSetAction 'TAS_pointAddTime = 1; publicVariable "TAS_pointAddTime";';
_button3 ctrlCommit 0;

_button3 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
_button3 ctrlSetPosition [0.275,0.03 + 0.08 * 6,0.45,0.05];
_button3 ctrlSetText ("1.25 Seconds");
_button3 buttonSetAction 'TAS_pointAddTime = 1.25; publicVariable "TAS_pointAddTime";';
_button3 ctrlCommit 0;

_button3 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
_button3 ctrlSetPosition [0.275,0.03 + 0.08 * 7,0.45,0.05];
_button3 ctrlSetText ("1.33 Seconds");
_button3 buttonSetAction 'TAS_pointAddTime = 1.33; publicVariable "TAS_pointAddTime";';
_button3 ctrlCommit 0;

_button3 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
_button3 ctrlSetPosition [0.275,0.03 + 0.08 * 8,0.45,0.05];
_button3 ctrlSetText ("1.5 Seconds");
_button3 buttonSetAction 'TAS_pointAddTime = 1.5; publicVariable "TAS_pointAddTime";';
_button3 ctrlCommit 0;

_button3 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
_button3 ctrlSetPosition [0.275,0.03 + 0.08 * 9,0.45,0.05];
_button3 ctrlSetText ("1.67 Seconds");
_button3 buttonSetAction 'TAS_pointAddTime = 1.67; publicVariable "TAS_pointAddTime";';
_button3 ctrlCommit 0;

_button3 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
_button3 ctrlSetPosition [0.275,0.03 + 0.08 * 10,0.45,0.05];
_button3 ctrlSetText ("1.75 Seconds");
_button3 buttonSetAction 'TAS_pointAddTime = 1.75; publicVariable "TAS_pointAddTime";';
_button3 ctrlCommit 0;

_button3 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
_button3 ctrlSetPosition [0.275,0.03 + 0.08 * 11,0.45,0.05];
_button3 ctrlSetText ("2 Seconds");
_button3 buttonSetAction 'TAS_pointAddTime = 2; publicVariable "TAS_pointAddTime";';
_button3 ctrlCommit 0;