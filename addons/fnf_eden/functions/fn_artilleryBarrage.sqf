// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
_units = param [1,[],[[]]];
// True when the module was activated, false when it is deactivated (i.e., synced triggers are no longer active)
_activated = param [2,true,[true]];
// Module specific behavior. Function can extract arguments from logic and use them.

_targets = synchronizedObjects _logic;
if (_activated) then {
	// Attribute values are saved in module's object space under their class names
	if (count _targets isEqualTo 0) exitWith {false};

	private _startDelay = parseNumber(_logic getVariable ["StartDelay","300"]);
	private _duration = parseNumber(_logic getVariable ["Duration","300"]);
	private _interval = parseNumber(_logic getVariable ["Interval","10"]);
	private _shellType = _logic getVariable ["ShellType","Sh_155mm_AMOS"];

	_fnc_barrage = {
		params ["_target", "_startTime", "_duration", "_interval", "_shellType"];
		_barrageStartTime = diag_tickTime;

		while {diag_tickTime < _barrageStartTime + _duration} do {
			_pos = [[_target]] call BIS_fnc_randomPos;
			_pos = [_pos select 0, _pos select 1, 500];

			_shell = _shellType createVehicle _pos;
			_shell setVelocity [0,0,-10];

			sleep (random _interval);
		};
	};

	sleep (_startDelay + 0.001);

	{
		[_x, _startDelay, _duration, _interval, _shellType] spawn _fnc_barrage;
	} foreach _targets;
};
// Module function is executed by spawn command, so returned value is not necessary, but it is good practice.
true