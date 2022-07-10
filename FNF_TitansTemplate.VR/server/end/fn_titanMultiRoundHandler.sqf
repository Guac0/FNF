_sideWon = _this;
//set the hacking side of terminal to empty
missionNamespace setVariable ["phx_term1HackingSide", sideEmpty, true];
phx_term1HackingSide = sideEmpty;

//if there is a ticket PFH active delete it (what if this is called multiple times? may cause bug in future)
//maybe add check like on ticket PFH for multi calls?
[{!isNil "phx_ticketPFH"}, {[phx_ticketPFH] call CBA_fnc_removePerFrameHandler}] call CBA_fnc_waitUntilAndExecute;

//reset tickets per side
_bluScore = [west] call BIS_fnc_respawnTickets;
_opScore = [east] call BIS_fnc_respawnTickets;

_bluScore = _bluScore - (_bluScore * 2);
_opScore = _opScore - (_opScore * 2);

[west, _bluScore] call BIS_fnc_respawnTickets;
[east, _opScore] call BIS_fnc_respawnTickets;

//tells players if their sides should be swapped (done server side to avoid desync)
TAS_currentRoundCount = TAS_currentRoundCount + 1;
//publicVariable "TAS_currentRoundCount";
if (TAS_currentRoundCount == TAS_roundsBeforeSwitchingSides) then {
	TAS_currentRoundCount = 0;
	TAS_doSwitchSides = true;			//set to false client-side
	publicVariable "TAS_doSwitchSides";
};
/*TAS_incrementedRoundCount = true;
publicVariable "TAS_incrementedRoundCount";
[] spawn {
	sleep 30;
	TAS_incrementedRoundCount = false;
	publicVariable "TAS_incrementedRoundCount";
};*/

//wait for 3 seconds after round end for player comfort
[{
	//increase score of winning side
	switch (_this select 0) do {
		case west: {phx_blueTeamScore = phx_blueTeamScore + 1};
		case east: {phx_redTeamScore = phx_redTeamScore + 1};
		default {};
	};

	//tell all players the score
	[format ["Blue Team: %1\nRed Team: %2", phx_blueTeamScore, phx_redTeamScore]] remoteExec ["hint"];

	//delete all dead bodys
	{
		deleteVehicle _x;
	} forEach allDeadMen;

	//delete all items on floor
	{
		deleteVehicle _x; 
	} forEach nearestObjects [getpos term1,["WeaponHolder","GroundWeaponHolder"],500];

	//delete all Thrown Grenades
	{
		deleteVehicle _x; 
	} forEach ((getpos term1) nearObjects ["GrenadeHand", 500]);

	//switch safe start colours if sides have been swapped
	if (TAS_currentRoundCount == TAS_roundsBeforeSwitchingSides) then {
		if (markerColor "bluforSafeMarker" == "colorBLUFOR") then {
			"bluforSafeMarker" setMarkerColor "colorOPFOR";
			"opforSafeMarker" setMarkerColor "colorBLUFOR";
		} else {
			"bluforSafeMarker" setMarkerColor "colorBLUFOR";
			"opforSafeMarker" setMarkerColor "colorOPFOR";
		};
	};

	if (TAS_gamemode == "CTF") then { //various CTF resets
		TAS_flagPole setFlagOwner objNull;
		TAS_flagPole setFlagTexture "\A3\Data_F\Flags\flag_white_CO.paa";
		//TAS_oldFlagOwner = objNull; //probably isnt needed

		TAS_flagMarker setMarkerTypeLocal "hd_flag";
		TAS_flagMarker setMarkerPos getPos TAS_flagPole;
  		//TAS_flagMarker setMarkerColor "Flag";
	};

	//call further inits
	missionNamespace setVariable ["newRound", true, true];
	call PHX_fnc_serverMidInit;

}, [_sideWon], 3] call CBA_fnc_waitAndExecute;