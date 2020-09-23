waitUntil {missionNamespace getVariable ["phx_loadoutAssigned",false]};

ORBAT_Diary = player createDiarySubject ["ORBAT_Diary", "ORBAT"];

//Admin end start trigger
if (serverCommandAvailable "#kick") then {
  PHX_Diary = player createDiarySubject ["PHX_Diary", "Misc"];
  player createDiaryRecord ["PHX_Diary", ["Admin","<execute expression='f_var_mission_timer = -1; publicVariableServer ""f_var_mission_timer""; [false] remoteExec [""phx_fnc_serverSafety"",2,false];'>End Safe Start</execute>"]];
};

PHX_Diary_Details = player createDiarySubject ["PHX_Diary_Details", "Mission Details"];

_units = allUnits;

_varStr = "";

if ((west countSide _units) > 0) then {
  _incStr = "client\loadout\uniforms\" + phx_bluforUniform + ".sqf";
  call compile preprocessFileLineNumbers _incStr;

  _uniformImg = getText (configFile >> "cfgWeapons" >> phx_loadout_uniform >> "picture");
  _helmetImg = getText (configFile >> "cfgWeapons" >> phx_loadout_headgear >> "picture");

  player createDiaryRecord ["PHX_Diary_Details",["BLUFOR Uniform",
  format ["BLUFOR Helmet:<br/><br/>
  <img width='178' height='178' image='%2'/>
  <br/><br/>
  BLUFOR Uniform:<br/><br/>
  <img width='356' height='356' image='%1'/>
  ", _uniformImg, _helmetImg]
  ]];

  _varStr = _varStr + format ["BLUFOR Weapons: %1", phx_bluforWeapons select [8, count phx_bluforWeapons]] + "<br/>";
  _varStr = _varStr + format ["BLUFOR MAT: %1", phx_bluAT] + "<br/>";
};

if ((east countSide _units) > 0) then {
  _incStr = "client\loadout\uniforms\" + phx_opforUniform + ".sqf";
  call compile preprocessFileLineNumbers _incStr;

  _uniformImg = getText (configFile >> "cfgWeapons" >> phx_loadout_uniform >> "picture");
  _helmetImg = getText (configFile >> "cfgWeapons" >> phx_loadout_headgear >> "picture");

  player createDiaryRecord ["PHX_Diary_Details",["OPFOR Uniform",
  format ["OPFOR Helmet:<br/><br/>
  <img width='178' height='178' image='%2'/>
  <br/><br/>
  OPFOR Uniform:<br/><br/>
  <img width='356' height='356' image='%1'/>
  ", _uniformImg, _helmetImg]
  ]];

  _varStr = _varStr + format ["OPFOR Weapons: %1", phx_opforWeapons select [8, count phx_opforWeapons]] + "<br/>";
  _varStr = _varStr + format ["OPFOR MAT: %1", phx_redAT] + "<br/>";
};

if ((independent countSide _units) > 0) then {
  _incStr = "client\loadout\uniforms\" + phx_indforUniform + ".sqf";
  call compile preprocessFileLineNumbers _incStr;

  _uniformImg = getText (configFile >> "cfgWeapons" >> phx_loadout_uniform >> "picture");
  _helmetImg = getText (configFile >> "cfgWeapons" >> phx_loadout_headgear >> "picture");

  player createDiaryRecord ["PHX_Diary_Details",["INDFOR Uniform",
  format ["INDFOR Helmet:<br/><br/>
  <img width='178' height='178' image='%2'/>
  <br/><br/>
  INDFOR Uniform:<br/><br/>
  <img width='356' height='356' image='%1'/>
  ", _uniformImg, _helmetImg]
  ]];

  _varStr = _varStr + format ["INDFOR Weapons: %1", phx_indforWeapons select [8, count phx_indforWeapons]] + "<br/>";
  _varStr = _varStr + format ["INDFOR MAT: %1", phx_grnAT] + "<br/>";
};

_varStr = _varStr + "<br/>";
_varStr = _varStr + format ["Time limit: %1 minutes", phx_missionTimeLimit];
_varStr = _varStr + "<br/>";
_varStr = _varStr + format ["Defenders fortify allowed: %1", phx_allowFortify];

player createDiaryRecord ["PHX_Diary_Details",["Vars",_varStr]];

phx_loadout_uniform = nil;
phx_loadout_headgear = nil;
