disableSerialization;

//create Admin Uniform GUI Display
_phx_uniformListGUI = findDisplay 46 createDisplay "RscDisplayEmpty"; //uses map screen as basis since activated via diary entry
phx_uniformListGUI = [_phx_uniformListGUI];

//Add pre defined buttons for each admin diary entry to be clicked on
//background
_background = (phx_uniformListGUI select 0) ctrlCreate ["IGUIBack", -1];
_background ctrlSetPosition [0.25,0,0.5,0.83]; //change last number for total length
_background ctrlSetBackgroundColor [0,0,0,0.5];
_background ctrlCommit 0;

//Change list of buttons depending on if we're editing blufor or opfor
//Maybe a better way of doing this than just doing the code twice?
//Example: "west call PHX_fnc_uniformListGUI" so "west" becomes _this
_side = _this;
if (_side == west) then {
	//RHS MARPAT WOODLAND
	_button1 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button1 ctrlSetPosition [0.275,0.03,0.45,0.05];
	_button1 ctrlSetText ("RHS MARPAT WOODLAND");
	_button1 buttonSetAction 'phx_bluforUniform = "UNIFORM_MARPAT_WD"; publicVariable "phx_bluforUniform";';
	_button1 ctrlCommit 0;

	//RHS MARPAT DESERT
	_button2 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button2 ctrlSetPosition [0.275,0.03 + 0.08,0.45,0.05];
	_button2 ctrlSetText ("RHS MARPAT DESERT");
	_button2 buttonSetAction 'phx_bluforUniform = "UNIFORM_MARPAT_D"; publicVariable "phx_bluforUniform";';
	_button2 ctrlCommit 0;

	//RHS OEF CP
	_button3 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button3 ctrlSetPosition [0.275,0.03 + 0.08 * 2,0.45,0.05];
	_button3 ctrlSetText ("RHS OEF CP");
	_button3 buttonSetAction 'phx_bluforUniform = "UNIFORM_OEF_CP"; publicVariable "phx_bluforUniform";';
	_button3 ctrlCommit 0;

	//RHS PMC
	_button4 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button4 ctrlSetPosition [0.275,0.03 + 0.08 * 3,0.45,0.05];
	_button4 ctrlSetText ("RHS PMC");
	_button4 buttonSetAction 'phx_bluforUniform = "UNIFORM_PMC"; publicVariable "phx_bluforUniform";';
	_button4 ctrlCommit 0;

	//RHS ION BLACK
	_button4 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button4 ctrlSetPosition [0.275,0.03 + 0.08 * 4,0.45,0.05];
	_button4 ctrlSetText ("RHS ION BLACK");
	_button4 buttonSetAction 'phx_bluforUniform = "UNIFORM_ION_BK"; publicVariable "phx_bluforUniform";';
	_button4 ctrlCommit 0;

	//RHS M93 DESERT
	_button4 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button4 ctrlSetPosition [0.275,0.03 + 0.08 * 5,0.45,0.05];
	_button4 ctrlSetText ("RHS M93 DESERT");
	_button4 buttonSetAction 'phx_bluforUniform = "UNIFORM_M93_DESERT"; publicVariable "phx_bluforUniform";';
	_button4 ctrlCommit 0;

	//RHS M93 WOODLAND
	_button4 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button4 ctrlSetPosition [0.275,0.03 + 0.08 * 6,0.45,0.05];
	_button4 ctrlSetText ("RHS M93 WOODLAND");
	_button4 buttonSetAction 'phx_bluforUniform = "UNIFORM_M93_WOODLAND"; publicVariable "phx_bluforUniform";';
	_button4 ctrlCommit 0;

	//RHS UCP
	_button4 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button4 ctrlSetPosition [0.275,0.03 + 0.08 * 7,0.45,0.05];
	_button4 ctrlSetText ("RHS UCP");
	_button4 buttonSetAction 'phx_bluforUniform = "UNIFORM_UCP"; publicVariable "phx_bluforUniform";';
	_button4 ctrlCommit 0;

	//RHS ISRAEL
	_button4 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button4 ctrlSetPosition [0.275,0.03 + 0.08 * 8,0.45,0.05];
	_button4 ctrlSetText ("RHS ISRAEL");
	_button4 buttonSetAction 'phx_bluforUniform = "UNIFORM_ISRAEL_TAN"; publicVariable "phx_bluforUniform";';
	_button4 ctrlCommit 0;

	//RHS RANGERS
	_button4 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button4 ctrlSetPosition [0.275,0.03 + 0.08 * 9,0.45,0.05];
	_button4 ctrlSetText ("RHS RANGERS");
	_button4 buttonSetAction 'phx_bluforUniform = "UNIFORM_RANGER"; publicVariable "phx_bluforUniform";';
	_button4 ctrlCommit 0;
} else {
	//RHS EMR SUMMER
	_button1 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button1 ctrlSetPosition [0.275,0.03,0.45,0.05];
	_button1 ctrlSetText ("RHS EMR SUMMER");
	_button1 buttonSetAction 'phx_bluforUniform = "UNIFORM_EMR_SUMMER"; publicVariable "phx_bluforUniform";';
	_button1 ctrlCommit 0;

	//RHS EMR DESERT
	_button2 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button2 ctrlSetPosition [0.275,0.03 + 0.08,0.45,0.05];
	_button2 ctrlSetText ("RHS EMR DESERT");
	_button2 buttonSetAction 'phx_bluforUniform = "UNIFORM_EMR_DESERT"; publicVariable "phx_bluforUniform";';
	_button2 ctrlCommit 0;

	//RHS FLORA
	_button3 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button3 ctrlSetPosition [0.275,0.03 + 0.08 * 2,0.45,0.05];
	_button3 ctrlSetText ("RHS FLORA");
	_button3 buttonSetAction 'phx_bluforUniform = "UNIFORM_FLORA"; publicVariable "phx_bluforUniform";';
	_button3 ctrlCommit 0;

	//RHS PMC
	_button4 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button4 ctrlSetPosition [0.275,0.03 + 0.08 * 3,0.45,0.05];
	_button4 ctrlSetText ("RHS PMC");
	_button4 buttonSetAction 'phx_bluforUniform = "UNIFORM_PMC"; publicVariable "phx_bluforUniform";';
	_button4 ctrlCommit 0;

	//RHS ION BLACK
	_button4 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button4 ctrlSetPosition [0.275,0.03 + 0.08 * 4,0.45,0.05];
	_button4 ctrlSetText ("RHS ION BLACK");
	_button4 buttonSetAction 'phx_bluforUniform = "UNIFORM_ION_BK"; publicVariable "phx_bluforUniform";';
	_button4 ctrlCommit 0;

	//RHS MOUNTAIN FLORA
	_button4 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button4 ctrlSetPosition [0.275,0.03 + 0.08 * 5,0.45,0.05];
	_button4 ctrlSetText ("RHS MOUNTAIN FLORA");
	_button4 buttonSetAction 'phx_bluforUniform = "UNIFORM_MOUNTAIN_FLORA"; publicVariable "phx_bluforUniform";';
	_button4 ctrlCommit 0;

	//RHS GORKA GREEN
	_button4 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button4 ctrlSetPosition [0.275,0.03 + 0.08 * 6,0.45,0.05];
	_button4 ctrlSetText ("RHS GORKA GREEN");
	_button4 buttonSetAction 'phx_bluforUniform = "UNIFORM_GORKA_GREEN"; publicVariable "phx_bluforUniform";';
	_button4 ctrlCommit 0;

	//RHS GORKA BEREZKA
	_button4 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button4 ctrlSetPosition [0.275,0.03 + 0.08 * 7,0.45,0.05];
	_button4 ctrlSetText ("RHS GORKA BEREZKA");
	_button4 buttonSetAction 'phx_bluforUniform = "UNIFORM_GORKA_BEREZKA"; publicVariable "phx_bluforUniform";';
	_button4 ctrlCommit 0;

	//RHS SOVIET CSAT
	_button4 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button4 ctrlSetPosition [0.275,0.03 + 0.08 * 8,0.45,0.05];
	_button4 ctrlSetText ("RHS SOVIET CSAT");
	_button4 buttonSetAction 'phx_bluforUniform = "UNIFORM_SOVIET_CSAT"; publicVariable "phx_bluforUniform";';
	_button4 ctrlCommit 0;

	//RHS ALTIS LIZARD
	_button4 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button4 ctrlSetPosition [0.275,0.03 + 0.08 * 9,0.45,0.05];
	_button4 ctrlSetText ("RHS ALTIS LIZARD");
	_button4 buttonSetAction 'phx_bluforUniform = "UNIFORM_ALTIS_LIZARD"; publicVariable "phx_bluforUniform";';
	_button4 ctrlCommit 0;
};

/*
//
_button = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
_button ctrlSetPosition [0.275,0.03 + 0.08 * 1,0.45,0.05];
_button ctrlSetText ("");
_button buttonSetAction 'phx_bluforUniform = ""; publicVariable "phx_bluforUniform";';
_button ctrlCommit 0;
*/