//sleep 0.5; //TODO check that this executes AFTER server changes the count. temp fix: sleep
//swap sides of player if it's time (server increments the round count itself)
if (TAS_currentRoundCount == TAS_roundsBeforeSwitchingSides) then {
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
};

//teleport player back to appropriate start
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