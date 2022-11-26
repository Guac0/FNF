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

//Change list of buttons depending on if we're editing blufor or opfor
//Maybe a better way of doing this than just doing the code twice?
//Example: "west call PHX_fnc_weaponListGUI" so "west" becomes _this
_side = _this;
if (_side == west) then {
	//CUP SMAW SPOTTING
	_button1 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button1 ctrlSetPosition [0.275,0.03,0.45,0.05];
	_button1 ctrlSetText ("CUP SMAW SPOTTING RIFLE");
	_button1 buttonSetAction 'phx_bluforWeapons = "WEAPONS_CUP_SMAW_SPOTTING"; publicVariable "phx_bluforWeapons";';
	_button1 ctrlCommit 0;

	//CUP XM8
	_button2 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button2 ctrlSetPosition [0.275,0.03 + 0.08,0.45,0.05];
	_button2 ctrlSetText ("CUP XM8");
	_button2 buttonSetAction 'phx_bluforWeapons = "WEAPONS_CUP_XM8"; publicVariable "phx_bluforWeapons";';
	_button2 ctrlCommit 0;

	//CUP USA RANDOM
	_button3 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button3 ctrlSetPosition [0.275,0.03 + 0.08 * 2,0.45,0.05];
	_button3 ctrlSetText ("CUP USA RANDOM");
	_button3 buttonSetAction 'phx_bluforWeapons = "WEAPONS_CUP_USA_RANDOM"; publicVariable "phx_bluforWeapons";';
	_button3 ctrlCommit 0;

	//CUP RUSSIA RANDOM
	_button4 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button4 ctrlSetPosition [0.275,0.03 + 0.08 * 3,0.45,0.05];
	_button4 ctrlSetText ("CUP RUSSIA RANDOM");
	_button4 buttonSetAction 'phx_bluforWeapons = "WEAPONS_CUP_RUSSIA_RANDOM"; publicVariable "phx_bluforWeapons";';
	_button4 ctrlCommit 0;

	//RANDOM WEAPONS
	_button5 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button5 ctrlSetPosition [0.275,0.03 + 0.08 * 4,0.45,0.05];
	_button5 ctrlSetText ("RANDOM WEAPONS");
	_button5 buttonSetAction 'phx_bluforWeapons = "WEAPONS_RANDOM"; publicVariable "phx_bluforWeapons";';
	_button5 ctrlCommit 0;

	//RANDOM WEAPONS
	_button5 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button5 ctrlSetPosition [0.275,0.03 + 0.08 * 4,0.45,0.05];
	_button5 ctrlSetText ("UNSC WEAPONS");
	_button5 buttonSetAction 'phx_bluforWeapons = "WEAPONS_UNSC"; publicVariable "phx_bluforWeapons";';
	_button5 ctrlCommit 0;
} else {
	//CUP SMAW SPOTTING
	_button1 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button1 ctrlSetPosition [0.275,0.03,0.45,0.05];
	_button1 ctrlSetText ("CUP SMAW SPOTTING RIFLE");
	_button1 buttonSetAction 'phx_opforWeapons = "WEAPONS_CUP_SMAW_SPOTTING"; publicVariable "phx_opforWeapons";';
	_button1 ctrlCommit 0;

	//CUP XM8
	_button2 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button2 ctrlSetPosition [0.275,0.03 + 0.08,0.45,0.05];
	_button2 ctrlSetText ("CUP XM8");
	_button2 buttonSetAction 'phx_opforWeapons = "WEAPONS_CUP_XM8"; publicVariable "phx_opforWeapons";';
	_button2 ctrlCommit 0;

	//CUP USA RANDOM
	_button3 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button3 ctrlSetPosition [0.275,0.03 + 0.08 * 2,0.45,0.05];
	_button3 ctrlSetText ("CUP USA RANDOM");
	_button3 buttonSetAction 'phx_opforWeapons = "WEAPONS_CUP_USA_RANDOM"; publicVariable "phx_opforWeapons";';
	_button3 ctrlCommit 0;

	//CUP RUSSIA RANDOM
	_button4 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button4 ctrlSetPosition [0.275,0.03 + 0.08 * 3,0.45,0.05];
	_button4 ctrlSetText ("CUP RUSSIA RANDOM");
	_button4 buttonSetAction 'phx_opforWeapons = "WEAPONS_CUP_RUSSIA_RANDOM"; publicVariable "phx_opforWeapons";';
	_button4 ctrlCommit 0;

	//RANDOM WEAPONS
	_button5 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button5 ctrlSetPosition [0.275,0.03 + 0.08 * 4,0.45,0.05];
	_button5 ctrlSetText ("RANDOM WEAPONS");
	_button5 buttonSetAction 'phx_opforWeapons = "WEAPONS_RANDOM"; publicVariable "phx_opforWeapons";';
	_button5 ctrlCommit 0;

	//RANDOM WEAPONS
	_button5 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button5 ctrlSetPosition [0.275,0.03 + 0.08 * 4,0.45,0.05];
	_button5 ctrlSetText ("UNSC WEAPONS");
	_button5 buttonSetAction 'phx_opforWeapons = "WEAPONS_UNSC"; publicVariable "phx_opforWeapons";';
	_button5 ctrlCommit 0;
};

/*
//
_button = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
_button ctrlSetPosition [0.275,0.03 + 0.08 * 1,0.45,0.05];
_button ctrlSetText ("");
_button buttonSetAction 'phx_bluforWeapons = ""; publicVariable "phx_bluforWeapons";';
_button ctrlCommit 0;
*/