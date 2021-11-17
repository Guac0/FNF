// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
_units = param [1,[],[[]]];
// True when the module was activated, false when it is deactivated (i.e., synced triggers are no longer active)
_activated = param [2,true,[true]];
// Module specific behavior. Function can extract arguments from logic and use them.
if (_activated) then {
	// Attribute values are saved in module's object space under their class names
	private _spawnCount = _logic getVariable ["SpawnCount",-1]; // (as per the previous example, but you can define your own.)
	private _typeToSpawn = _logic getVariable ["SpawnType",-1];
	private _typeToSpawn = "RHS_M2StaticMG_D";
	private _buildings = nearestObjects [_logic, ["house"], 100];
	for "_i" from 1 to _spawnCount do {
		private _positions = [];
		while {count _positions == 0} do {
			_positions = selectRandom(_buildings) buildingPos -1;
		};
		private _posToSpawn = selectRandom(_positions);
		_posToSpawn vectorAdd [0,0,0.5]; 
		private _wep = _typeToSpawn createVehicle _posToSpawn;
		_wep setPosATL _posToSpawn;
		_wep setVectorUp surfaceNormal _posToSpawn;
		_markerstr = createMarker [str(_wep), position _wep, -1]; 
		_markerstr setMarkerType "mil_dot";
		_markerstr setMarkerColor "ColorORANGE";
		_markerStr setMarkerAlpha 0.2; 
	};
};
// Module function is executed by spawn command, so returned value is not necessary, but it is good practice.
true