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

	//RHS USA
	_button5 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button5 ctrlSetPosition [0.275,0.03,0.45,0.05];
	_button5 ctrlSetText ("RHS USA");
	_button5 buttonSetAction 'phx_bluforWeapons = "WEAPONS_US"; publicVariable "phx_bluforWeapons";';
	_button5 ctrlCommit 0;

	//RHS RUSSIA
	_button5 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button5 ctrlSetPosition [0.275,0.03 + 0.08,0.45,0.05];
	_button5 ctrlSetText ("RHS RUSSIA");
	_button5 buttonSetAction 'phx_bluforWeapons = "WEAPONS_RU"; publicVariable "phx_bluforWeapons";';
	_button5 ctrlCommit 0;

	//RHS INDFOR
	_button5 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button5 ctrlSetPosition [0.275,0.03 + 0.08 * 2,0.45,0.05];
	_button5 ctrlSetText ("RHS INDFOR");
	_button5 buttonSetAction 'phx_bluforWeapons = "WEAPONS_IND"; publicVariable "phx_bluforWeapons";';
	_button5 ctrlCommit 0;

	//RHS G36
	_button5 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button5 ctrlSetPosition [0.275,0.03 + 0.08 * 3,0.45,0.05];
	_button5 ctrlSetText ("RHS G36");
	_button5 buttonSetAction 'phx_bluforWeapons = "WEAPONS_G36"; publicVariable "phx_bluforWeapons";';
	_button5 ctrlCommit 0;

	//RHS GUERILLA
	_button5 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button5 ctrlSetPosition [0.275,0.03 + 0.08 * 4,0.45,0.05];
	_button5 ctrlSetText ("RHS GUERILLA");
	_button5 buttonSetAction 'phx_bluforWeapons = "WEAPONS_GUERRILLA"; publicVariable "phx_bluforWeapons";';
	_button5 ctrlCommit 0;

	//RHS M21
	_button5 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button5 ctrlSetPosition [0.275,0.03 + 0.08 * 5,0.45,0.05];
	_button5 ctrlSetText ("RHS M21");
	_button5 buttonSetAction 'phx_bluforWeapons = "WEAPONS_M21"; publicVariable "phx_bluforWeapons";';
	_button5 ctrlCommit 0;

	//RHS SCAR
	_button5 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button5 ctrlSetPosition [0.275,0.03 + 0.08 * 6,0.45,0.05];
	_button5 ctrlSetText ("RHS SCAR");
	_button5 buttonSetAction 'phx_bluforWeapons = "WEAPONS_SCAR"; publicVariable "phx_bluforWeapons";';
	_button5 ctrlCommit 0;

	//RHS VHS
	_button5 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button5 ctrlSetPosition [0.275,0.03 + 0.08 * 7,0.45,0.05];
	_button5 ctrlSetText ("RHS VHS");
	_button5 buttonSetAction 'phx_bluforWeapons = "WEAPONS_VHS"; publicVariable "phx_bluforWeapons";';
	_button5 ctrlCommit 0;

} else {

	//RHS USA
	_button5 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button5 ctrlSetPosition [0.275,0.03,0.45,0.05];
	_button5 ctrlSetText ("RHS USA");
	_button5 buttonSetAction 'phx_opforWeapons = "WEAPONS_US"; publicVariable "phx_opforWeapons";';
	_button5 ctrlCommit 0;

	//RHS RUSSIA
	_button5 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button5 ctrlSetPosition [0.275,0.03 + 0.08,0.45,0.05];
	_button5 ctrlSetText ("RHS RUSSIA");
	_button5 buttonSetAction 'phx_opforWeapons = "WEAPONS_RU"; publicVariable "phx_opforWeapons";';
	_button5 ctrlCommit 0;

	//RHS INDFOR
	_button5 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button5 ctrlSetPosition [0.275,0.03 + 0.08 * 2,0.45,0.05];
	_button5 ctrlSetText ("RHS INDFOR");
	_button5 buttonSetAction 'phx_opforWeapons = "WEAPONS_IND"; publicVariable "phx_opforWeapons";';
	_button5 ctrlCommit 0;

	//RHS G36
	_button5 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button5 ctrlSetPosition [0.275,0.03 + 0.08 * 3,0.45,0.05];
	_button5 ctrlSetText ("RHS G36");
	_button5 buttonSetAction 'phx_opforWeapons = "WEAPONS_G36"; publicVariable "phx_opforWeapons";';
	_button5 ctrlCommit 0;

	//RHS GUERILLA
	_button5 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button5 ctrlSetPosition [0.275,0.03 + 0.08 * 4,0.45,0.05];
	_button5 ctrlSetText ("RHS GUERILLA");
	_button5 buttonSetAction 'phx_opforWeapons = "WEAPONS_GUERRILLA"; publicVariable "phx_opforWeapons";';
	_button5 ctrlCommit 0;

	//RHS M21
	_button5 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button5 ctrlSetPosition [0.275,0.03 + 0.08 * 5,0.45,0.05];
	_button5 ctrlSetText ("RHS M21");
	_button5 buttonSetAction 'phx_opforWeapons = "WEAPONS_M21"; publicVariable "phx_opforWeapons";';
	_button5 ctrlCommit 0;

	//RHS SCAR
	_button5 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button5 ctrlSetPosition [0.275,0.03 + 0.08 * 6,0.45,0.05];
	_button5 ctrlSetText ("RHS SCAR");
	_button5 buttonSetAction 'phx_opforWeapons = "WEAPONS_SCAR"; publicVariable "phx_opforWeapons";';
	_button5 ctrlCommit 0;

	//RHS VHS
	_button5 = (phx_weaponListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button5 ctrlSetPosition [0.275,0.03 + 0.08 * 7,0.45,0.05];
	_button5 ctrlSetText ("RHS VHS");
	_button5 buttonSetAction 'phx_opforWeapons = "WEAPONS_VHS"; publicVariable "phx_opforWeapons";';
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