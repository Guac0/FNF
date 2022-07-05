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
	//Dominos Zimbabwe
	_button1 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button1 ctrlSetPosition [0.275,0.03,0.45,0.05];
	_button1 ctrlSetText ("DOMINOS ZIMBABWE");
	_button1 buttonSetAction 'phx_bluforUniform = "UNIFORM_DOMINOS"; publicVariable "phx_bluforUniform";';
	_button1 ctrlCommit 0;

	//Papa Jhons
	_button2 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button2 ctrlSetPosition [0.275,0.03 + 0.08,0.45,0.05];
	_button2 ctrlSetText ("PAPA JHONS");
	_button2 buttonSetAction 'phx_bluforUniform = "UNIFORM_PAPAJHONS"; publicVariable "phx_bluforUniform";';
	_button2 ctrlCommit 0;

	//AAF (Vanilla)
	_button3 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button3 ctrlSetPosition [0.275,0.03 + 0.08 * 2,0.45,0.05];
	_button3 ctrlSetText ("AAF (Vanilla)");
	_button3 buttonSetAction 'phx_bluforUniform = "UNIFORM_AAF"; publicVariable "phx_bluforUniform";';
	_button3 ctrlCommit 0;

	//Guerillas (Vanilla)
	_button4 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button4 ctrlSetPosition [0.275,0.03 + 0.08 * 3,0.45,0.05];
	_button4 ctrlSetText ("GUERILLAS (Vanilla)");
	_button4 buttonSetAction 'phx_bluforUniform = "UNIFORM_GUERRILLA_VANILLA"; publicVariable "phx_bluforUniform";';
	_button4 ctrlCommit 0;
} else {
	//Dominos Zimbabwe
	_button1 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button1 ctrlSetPosition [0.275,0.03,0.45,0.05];
	_button1 ctrlSetText ("DOMINOS ZIMBABWE");
	_button1 buttonSetAction 'phx_opforUniform = "UNIFORM_DOMINOS"; publicVariable "phx_opforUniform";';
	_button1 ctrlCommit 0;

	//Papa Jhons
	_button2 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button2 ctrlSetPosition [0.275,0.03 + 0.08,0.45,0.05];
	_button2 ctrlSetText ("PAPA JHONS");
	_button2 buttonSetAction 'phx_opforUniform = "UNIFORM_PAPAJHONS"; publicVariable "phx_opforUniform";';
	_button2 ctrlCommit 0;

	//AAF (Vanilla)
	_button3 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button3 ctrlSetPosition [0.275,0.03 + 0.08 * 2,0.45,0.05];
	_button3 ctrlSetText ("AAF (Vanilla)");
	_button3 buttonSetAction 'phx_opforUniform = "UNIFORM_AAF"; publicVariable "phx_opforUniform";';
	_button3 ctrlCommit 0;

	//Guerillas (Vanilla)
	_button4 = (phx_uniformListGUI select 0) ctrlCreate ["RscButton", -1]; 
	_button4 ctrlSetPosition [0.275,0.03 + 0.08 * 3,0.45,0.05];
	_button4 ctrlSetText ("GUERILLAS (Vanilla)");
	_button4 buttonSetAction 'phx_opforUniform = "UNIFORM_GUERRILLA_VANILLA"; publicVariable "phx_opforUniform";';
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