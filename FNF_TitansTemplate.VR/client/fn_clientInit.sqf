//god this function got messy

//add diary entry for crediting FNF
//setup diary subject
player createDiarySubject ["fnfCredit","Mission Template","fnfLogo.paa"];
player createDiaryRecord ["fnfCredit", ["Titans Framework by FNF Tech Team", "Many thanks to the developers and staff of Friday Night Fights who made and allowed us to use the FNF Titans template that this mission is based on! Go check them out if you're interested in more PVP stuff like this!<br></br><br></br>https://www.fridaynightfight.org/<br></br><br></br><img image='fnfLogo.paa' />"]];

//add PFH to show objective marker when in spectator
phx_iconHandle = [{
  if (ace_spectator_isset) then {
    drawIcon3D ["a3\ui_f\data\map\Markers\Military\objective_CA.paa", [1,0,0,0.8], ASLToAGL getPosASL term1, 0.6, 0.6, 45];
  };
} , 0, []] call CBA_fnc_addPerFrameHandler;

//if player is killed open spectator
player addEventHandler ["Killed", {call phx_fnc_spectatorInit;}];

phx_keyDownEHId = -1;
//used to account for JIP players
if !(call phx_fnc_clientCanPlay) exitWith {
	call phx_fnc_spectatorInit;
	if (didJIP && typeOf player != "ace_spectator_virtual") then {
		//if player is actual player and not spectator send player to debug zone
		player setPos [-1000, -1000, 0];
		//wait until safe start is started
		[{phx_safetyEnabled},{
			//remove spectator
			[false,false,false] call ace_spectator_fnc_setSpectator;
			//removes PFH and EH as these will be reinitialised on client init
			[phx_iconHandle] call CBA_fnc_removePerFrameHandler;
			player removeEventHandler ["Killed", 0];

			//if sides are not currently swapped teleport player back to gamezone
			if (markerColor "opforSafeMarker" == "colorOPFOR") then	{
				if (phx_playerSide == west) then
				{
					player setpos ("bluforSafeMarker" call BIS_fnc_randomPosTrigger)
				} else {
					if (phx_playerSide == east) then
					{
						player setpos ("opforSafeMarker" call BIS_fnc_randomPosTrigger)
					};
				};
			};
			call PHX_fnc_clientInit;
		}] call CBA_fnc_waitUntilAndExecute;
	};
};

//get initial player side
phx_playerSide = playerSide;

player linkItem "ItemMap";

//null out initial loadout variables for IF statements later
phx_LoadoutChosen = false;
phx_loadoutGUI = [displayNull];

//if player joined in progress and sides are swapped, tp to new side
if (didJIP) then {
	TAS_doSwitchSides = false; //to avoid any wacky desync since server only sets this to true and clients set it to false AFTER swapping
	if (markerColor "bluforSafeMarker" == "colorOPFOR") then	{
		if (phx_playerSide == west) then
		{
			phx_playerSide = east;
			player setpos ("opforSafeMarker" call BIS_fnc_randomPosTrigger)
		} else {
			if (phx_playerSide == east) then
			{
				phx_playerSide = west;
				player setpos ("bluforSafeMarker" call BIS_fnc_randomPosTrigger)
			};
		};
	};
};

//standard calls
call PHX_fnc_roles;
call phx_fnc_safety;
call PHX_fnc_adminDiary;
call PHX_fnc_terminalClientSetup;

//disable vanilla stamina since ace stamina > vanilla (if ace is active it'll override vanilla, but may as well disable vanilla stamina anyways in case we remove ace stamina later for a more relaxed experience)
player enableStamina false;

//limit view distance for FPS. The standard Titans arena is 225 meters long, but there's buffer for different sizes/if spectators want to zoom out some
setViewDistance 400;
//CH View Distance is popular and I think it overrides vanilla view distance, so force it to render cross and cap view distance at 300 like vanilla if client has it loaded
if (isClass(configFile >> "CfgPatches" >> "CHVD")) then {
	CHVD_allowNoGrass = false; //false for disabling client's ability to set 'low' terrain detail (which doesn't render grass)
	CHVD_maxView = 400; //max terrain view distance client can set
	CHVD_maxObj = 400; //max object view distance client can set
};

[{!(isNull findDisplay 46) && !(isNull player)}, {46 call phx_fnc_disableTyping}] call CBA_fnc_waitUntilAndExecute;

[{time > 0}, {call phx_fnc_restrictions;}] call CBA_fnc_waitUntilAndExecute;

//create PFH for loadout selection screen
_handle = [{
	//if no loadout GUI is open, open it
	if ((phx_loadoutGUI select 0) isEqualTo displayNull) then {
		call PHX_fnc_loadoutGUI;
	};
	//if loadout is not chosen disable roles as they are taken
	if !(phx_LoadoutChosen) then
	{

		_i = 0;

		{
			_temp = _x;
			_currentInRole = 0;
			//get players in current role
			{
				if (side _x == playerSide) then
				{
					_friendlyRole = _x getVariable["role", "None"];
					if (_temp select 0 == _friendlyRole) then
					{
						_currentInRole = _currentInRole + 1;
					};
				};
			} forEach allPlayers;
			//if players in role is equal to or more than allowed disable that role button
			if !((phx_loadoutGUI select 0) isEqualTo displayNull) then {
				_dialogControl = (phx_loadoutGUI select 0) displayCtrl _i + 1000;
				if (_currentInRole >= _x select 1) then 
				{
					if (ctrlEnabled _dialogControl) then {
						_dialogControl ctrlEnable false;
					};
				} else {
					if !(ctrlEnabled _dialogControl) then {
						_dialogControl ctrlEnable true;
					};
				};
			};
			_i = _i + 1;

		} forEach phx_roleList;
	};
}, 0, []] call CBA_fnc_addPerFrameHandler;

//Marking
[] execVM "client\icons\QS_icons.sqf";