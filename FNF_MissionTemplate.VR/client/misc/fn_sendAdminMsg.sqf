disableSerialization;
private _display = findDisplay 46 createDisplay "RscDisplayEmpty";
private _ctrlGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
private _ctrlBackground = _display ctrlCreate ["RscTextMulti", -1, _ctrlGroup];
IDD_EDIT_BOX = 123;
private _ctrlEdit = _display ctrlCreate ["RscEditMulti", IDD_EDIT_BOX, _ctrlGroup];
private _ctrlButton = _display ctrlCreate ["RscShortcutButton", -1, _ctrlGroup];
_ctrlGroup ctrlSetPosition [0.5, 0.5, 0, 0];
_ctrlGroup ctrlCommit 0;
_ctrlBackground ctrlSetPosition [0, 0, 0.5, 0.5];
_ctrlBackground ctrlSetBackgroundColor [0.5, 0.5, 0.5, 0.9];
_ctrlBackground ctrlSetText "Contact Connected Staff";
_ctrlBackground ctrlSetFont "PuristaMedium";
_ctrlBackground ctrlEnable false;
_ctrlBackground ctrlCommit 0;
_ctrlEdit ctrlSetPosition [0.01, 0.05, 0.48, 0.34];
_ctrlEdit ctrlSetBackgroundColor [0, 0, 0, 0.5];
_ctrlEdit ctrlCommit 0;
_ctrlButton ctrlSetPosition [0.185, 0.42, 0.13, 0.05];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "SUBMIT";
_ctrlButton ctrlAddEventHandler ["ButtonClick", 
{
	params ["_ctrl"];
	_display = ctrlParent _ctrl;
	_text = ctrlText (_display displayCtrl IDD_EDIT_BOX);

	_sendMsg = {
		params ["_message", "_first"];
		private _prefix = "";

		if (_first) then {
			private _grid = mapGridPosition player;
			_prefix = format ["I'm %1 at GRID %2: ",
				(playerSide call BIS_fnc_sideID) call BIS_fnc_sideName,
				_grid
			];
		};

		_message = _prefix + _message;
		["phxAdminMessageSent", [player, _message]] call CBA_fnc_globalEvent;
	};

	if (_text == "") then {
		_display closeDisplay 1;
	} else {

		private _msgLength = count _text;
		
		if (_msgLength > 300) then {

			private _index = 0;
			private _thisPart = "";

			while {_msgLength > 0} do {
				private _first = false;
				if (_index isEqualTo 0) then {_first = true};
				_thisPart = _text select [_index * 300, 300];
				[_thisPart, _first] call _sendMsg;
				_msgLength = _msgLength - 300;
				_index = _index + 1;
			};
		} else {
			[_text, true] call _sendMsg;
		};
		
		_display closeDisplay 1;
	};
}];
ctrlSetFocus _ctrlEdit;
_ctrlGroup ctrlSetPosition [0.25, 0.25, 0.5, 0.5];
_ctrlGroup ctrlCommit 0.1;
