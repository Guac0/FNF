//sleep 0.5; //TODO check that this executes AFTER server changes the count. temp fix: sleep
//swap sides of player if it's time (server increments the round count itself)
if (TAS_doSwitchSides) then {
	private _debugMsg = format ["fn_newRoundClient: swapping sides of player %3 who previously had a value of %1 for phx_playerSide and an actual side value of %2",phx_playerSide, side player, name player];
	_debugMsg remoteExec ["diag_log",2];
	diag_log _debugMsg;
	//switch "sides" of player
	if (phx_playerSide == west) then
	{
		phx_playerSide = east;
	} else {
		if (phx_playerSide == east) then
		{
			phx_playerSide = west;
		};
	};
	systemChat "Teams have swapped sides!"; //the round score count is a hint and overrrides this, so use systemChat instead
	TAS_doSwitchSides = false; //only does it client side
};

//teleport player back to appropriate start
private _debugMsg = format ["fn_newRoundClient: teleported player %3 with phx_playerSide of %1 and actual side of %2 to their start zone",phx_playerSide, side player, name player];
_debugMsg remoteExec ["diag_log",2];
diag_log _debugMsg;
if (phx_playerSide == west) then
{
	player setpos ("bluforSafeMarker" call BIS_fnc_randomPosTrigger);
} else {
	if (phx_playerSide == east) then //check for this so that spectators and etc don't get teleported
	{
		player setpos ("opforSafeMarker" call BIS_fnc_randomPosTrigger);
	};
};

//close the terminal
[term1,0] remoteExec ["BIS_fnc_DataTerminalAnimate",0,true];

//call mid game init
call PHX_fnc_clientMidInit;