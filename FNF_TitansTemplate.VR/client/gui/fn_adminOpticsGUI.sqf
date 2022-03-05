disableSerialization;

//create Admin Weapons GUI Display
_phx_adminOpticsGUI = findDisplay 46 createDisplay "RscDisplayEmpty"; //uses map screen as basis since activated via diary entry
phx_adminOpticsGUI = [_phx_adminOpticsGUI];

//Add pre defined buttons for each admin diary entry to be clicked on
//background
_background = (phx_adminOpticsGUI select 0) ctrlCreate ["IGUIBack", -1];
_background ctrlSetPosition [0.25,0,0.5,0.83]; //change last number for total length
_background ctrlSetBackgroundColor [0,0,0,0.5];
_background ctrlCommit 0;

//No magnified optics
_button1 = (phx_adminOpticsGUI select 0) ctrlCreate ["RscButton", -1]; 
_button1 ctrlSetPosition [0.275,0.03,0.45,0.05];
_button1 ctrlSetText ("No Magnified Optics");
_button1 buttonSetAction 'phx_magnifiedOptics = "false"; publicVariable "phx_magnifiedOptics";';
_button1 ctrlCommit 0;

//Magnified optics for all
_button2 = (phx_adminOpticsGUI select 0) ctrlCreate ["RscButton", -1]; 
_button2 ctrlSetPosition [0.275,0.03 + 0.08,0.45,0.05];
_button2 ctrlSetText ("Magnified Optics for all");
_button2 buttonSetAction 'phx_magnifiedOptics = "true"; publicVariable "phx_magnifiedOptics";';
_button2 ctrlCommit 0;