ORBAT_Diary = player createDiarySubject ["ORBAT_Diary", "ORBAT", "\A3\ui_f\data\igui\cfg\simpleTasks\types\meet_ca.paa"];

// colors: https://imgur.com/a/AfimbU2
#define COLOR1 "#944509"
#define COLOR2 "#FF8E38"
#define COLOR3 "#E0701B"
#define COLOR4 "#008394"
#define COLOR5 "#1BCAE0"


// remove existing addon entries
[{player diarySubjectExists "Radio"}, {player removeDiarySubject "Radio"}] call cba_fnc_waitUntilAndExecute;
[{player diarySubjectExists "cba_help_docs"}, {player removeDiarySubject "cba_help_docs"}] call cba_fnc_waitUntilAndExecute;

_getName = {
  if (_this isEqualTo "") exitWith {""};
  getText (configFile >> "cfgWeapons" >> _this >> "displayName");
};

fnc_getItemInfo = {
  private _thisCfg = _this call CBA_fnc_getItemConfig;
  private _dispName = [_thisCfg] call BIS_fnc_displayName;
  private _desc = getText(_thisCfg >> "descriptionShort");
  private _pic = (_thisCfg >> "picture") call BIS_fnc_getCfgData;
  [
    ["config",_thisCfg],
    ["displayName",_dispName],
    ["description",_desc],
    ["picture",_pic]
  ]
};

_fnc_parseMATForBriefing = {
  params ["_side", "_bravoOption", "_deltaOption", ["_structText", false]];

  private "_gearLoadout";
  switch (_side) do {
    case east: {_gearLoadout = phx_opforGear};
    case west: {_gearLoadout = phx_bluforGear};
    case independent: {_gearLoadout = phx_indforGear};
  };

  private _textOut = [];
  {
    _x params ["_setting", "_role"];

    private "_MATData";

    // "debug_console" callExtension str(_x);
    if (count _setting > 0) then {
      if (_setting # 0 isEqualTo "GEARDEFAULT") then {
        // "debug_console" callExtension str([_gearLoadout,_role,phx_bluAT_Bravo]);
        _MATData = (missionConfigFile >> "CfgLoadouts" >> "GEAR" >> _gearLoadout >> _role >> "defaultMAT") call BIS_fnc_getCfgDataArray select 0;
        //  "debug_console" callExtension str(_data);
        // _textOut pushBack (_data # 0);
      } else {
        _MATData = _setting;
        // _textOut pushBack (_setting # 0);
      };
    } else {
      _textOut pushBack "";
    };

    // "debug_console" callExtension str(_x);
    // "debug_console" callExtension str(_MATData);

    _MATData params ["_launcher", "_ammo", "_optics", "_type"];
    private _launcherInfo = _launcher call fnc_getItemInfo;

    if (!_structText) then {
      _textOut pushBack format [
        "%1 %2: <font color='" + COLOR3 + "'>%3</font><br/><img width='120' image='%4'/><br/>%5<br/>%6",
        _side call BIS_fnc_sideName,
        _role,
        [_launcherInfo, "displayName"] call BIS_fnc_getFromPairs,
        [_launcherInfo, "picture"] call BIS_fnc_getFromPairs,
        (if (_type == "RELOAD") then {format["%1 (per person)", [_ammo, true] call phx_fnc_notesItems]} else {""}),
        [_launcherInfo, "description"] call BIS_fnc_getFromPairs
      ] + "<br/><br/>";
    } else {
      _textOut pushBack format [
        "%1 %2: <t color='" + COLOR3 + "'>%3</t><br/><img size='4' image='%4'/><br/>%5<br/>",
        _side call BIS_fnc_sideName,
        _role,
        [_launcherInfo, "displayName"] call BIS_fnc_getFromPairs,
        [_launcherInfo, "picture"] call BIS_fnc_getFromPairs,
        (if (_type == "RELOAD") then {format["%1 (per person)", [_ammo, true, true] call phx_fnc_notesItems]} else {""}),
        [_launcherInfo, "description"] call BIS_fnc_getFromPairs
      ];
    };

  } forEach [
    [_bravoOption, "MAT1"],
    [_deltaOption, "MAT2"]
  ];

  _textOut joinString "<br/>"
};


_fnc_parseCSWForBriefing = {
  params ["_side", ["_structText", false]];

  private _sideStr = str(_side);
  private _squads = ["Alpha", "Bravo", "Charlie", "Delta"];
  private _textOut = [];
  {
    private _setting = _x;
    if (_x isEqualTo 0 || typeName _x != "ARRAY") then {
      if (!_structText) then {
        _textOut pushBack format["<font size='16' color='" + COLOR5 + "'>%1</font><br/>    Crewmen", _squads select _forEachIndex];
      } else {
        _textOut pushBack format["<t size='1.4' color='" + COLOR5 + "'>%1</t><br/>    Crewmen", _squads select _forEachIndex];
      };
    } else {
      if (count _setting > 0) then {
        private _cswPrimaryInfo = (_setting # 0) call fnc_getItemInfo;

        private _mags = [];
        {
          _mags pushBack ([_x, true] call phx_fnc_notesItems);
        } forEach (_setting select {typeName _x == "ARRAY"});

        private _cswSecondaryName = "Ammo only";
        if (_setting # 1 != "") then {
          private _temp = (_setting # 1) call fnc_getItemInfo;
          _cswSecondaryName = [_temp, "displayName"] call BIS_fnc_getFromPairs;
        };

        if (!_structText) then {
          _textOut pushBack format [
            "<font size='16' color='" + COLOR5 + "'>%2</font><br/>    <font color='" + COLOR3 + "'>%3</font><br/>    <img width='120' image='%4'/><br/>    + %5<br/>    + %6",
            _side call BIS_fnc_sideName,
            _squads select _forEachIndex,
            [_cswPrimaryInfo, "displayName"] call BIS_fnc_getFromPairs,
            [_cswPrimaryInfo, "picture"] call BIS_fnc_getFromPairs,
            _cswSecondaryName,
            _mags joinString " "
          ];
        } else {
          _textOut pushBack format [
            "<t size='1.4' color='" + COLOR5 + "'>%2</t><br/>    <t color='" + COLOR3 + "'>%3</t><br/>    <img width='120' image='%4'/><br/>    + %5<br/>    + %6",
            _side call BIS_fnc_sideName,
            _squads select _forEachIndex,
            [_cswPrimaryInfo, "displayName"] call BIS_fnc_getFromPairs,
            [_cswPrimaryInfo, "picture"] call BIS_fnc_getFromPairs,
            _cswSecondaryName,
            _mags joinString " "
          ];
        };
      };
    };
  } forEach [
    missionNamespace getVariable [format["phx_%1AlphaAuxRole",_sideStr], 0],
    missionNamespace getVariable [format["phx_%1BravoAuxRole",_sideStr], 0],
    missionNamespace getVariable [format["phx_%1CharlieAuxRole",_sideStr], 0],
    missionNamespace getVariable [format["phx_%1DeltaAuxRole",_sideStr], 0]
  ];

  _textOut pushBack "<br/>";
  _textOut joinString "<br/>"
};


phx_safetyEndExpression = {
  [] spawn {
    private _result = true;

    if (!isServer) then {
      _result = ["Are you sure you want to end safestart?", "Confirm", true, true] call BIS_fnc_guiMessage;
    };

    if (_result) then {
      f_var_mission_timer = -1;
      publicVariableServer "f_var_mission_timer";
      systemChat "Ending Safe Start";
    };
  };
};

//Admin end start trigger
// if (serverCommandAvailable "#kick") then {
if (getPlayerUID player in (missionNamespace getVariable ["fnf_staffInfo",[]]) || serverCommandAvailable "#kick") then {
  PHX_Diary = player createDiarySubject ["PHX_Diary_Admin_Safestart", "Admin", "\A3\ui_f\data\igui\cfg\simpleTasks\types\defend_ca.paa"];

  //display template version
  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin",format ["Template Version: %1", phx_templateVersion]]];
  //end safety
  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='call phx_safetyEndExpression'>End Safe Start</execute>"]];

  //-1 minute to safety
  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='
    if !(f_var_mission_timer / 60 <= 1) then {
      f_var_mission_timer = f_var_mission_timer - 60;
      publicVariableServer ""f_var_mission_timer"";
    };
    systemChat format [""New safe start time: %1 mins"", [f_var_mission_timer, ""MM:SS""] call BIS_fnc_secondsToString];
  '>-1 Minute to Safe Start</execute>"]];

  //+1 minute to safety
  player createDiaryRecord ["PHX_Diary_Admin_Safestart", ["Admin","<execute expression='
    f_var_mission_timer = f_var_mission_timer + 60;
    publicVariableServer ""f_var_mission_timer"";
    systemChat format [""New safe start time: %1 mins"", [f_var_mission_timer, ""MM:SS""] call BIS_fnc_secondsToString];
  '>+1 Minute to Safe Start</execute>"]];

  //remove admin diary subject once safety ends
  [{!(missionNamespace getVariable ["phx_safetyEnabled",true])}, {player removeDiarySubject "PHX_Diary_Admin_Safestart"}] call CBA_fnc_waitUntilAndExecute;

};


// PHX_Diary_Details = player createDiarySubject ["PHX_Diary_Details", "Mission Details", "\A3\ui_f\data\igui\cfg\simpleTasks\types\documents_ca.paa"];


private _MATDataString = "";
_varStr = "";
_varStrStruct = [];

//show blufor uniform and headgear if side is present
if (!isNil "phx_briefing_west_uniform" || !isNil "phx_briefing_west_headgear" || !isNil "phx_briefing_west_uniformMeta" && !isNil "phx_briefing_west_loadout") then {

  _MATDataString = _MATDataString + ([west, phx_bluAT_Bravo, phx_bluAT_Delta] call _fnc_parseMATForBriefing) + "---------------------------------------------<br/>";

  // show BLUFOR loadout
  phx_briefing_loadoutBLU = {
    _helmetImg = [];
    _vestImg = [];
    _uniformImg = [];
    {
      _helmetImg pushBack format["<img width='110' image='%1'/>", [_x call fnc_getItemInfo, "picture"] call BIS_fnc_getFromPairs];
    } forEach phx_briefing_west_headgear;
    {
      _vestImg pushBack format["<img width='110' image='%1'/>", [_x call fnc_getItemInfo, "picture"] call BIS_fnc_getFromPairs];
    } forEach phx_briefing_west_vest;
    {
      _uniformImg pushBack format["<img width='110' image='%1'/>", [_x call fnc_getItemInfo, "picture"] call BIS_fnc_getFromPairs];
    } forEach phx_briefing_west_uniform;

    private _meta = +phx_briefing_west_uniformMeta;

    player createDiaryRecord [
      "Diary",
      [
        "BLUFOR CSW Settings",
        [west] call _fnc_parseCSWForBriefing
      ]
    ];

    player createDiaryRecord [
      "Diary",
      [
        "BLUFOR Loadout",
        format [
          "<font size='18' shadow='1' color='" + COLOR2 + "' face='PuristaBold'>%1</font><br/>%2",
          phx_briefing_west_loadout # 0 # 0,
          [phx_briefing_west_loadout] call phx_fnc_briefingParseLoadout
        ]
      ]
    ];
      player createDiaryRecord [
      "Diary",
      [
        "BLUFOR Uniform",
        format ["<font size='18' shadow='1' color='" + COLOR2 + "' face='PuristaBold'>%4</font><br/>
<font size='14'>%5</font><br/>
Author: %6<br/><br/>
%1<br/>
%2<br/>
%3
",
          _helmetImg joinString "",
          _vestImg joinString "",
          _uniformImg joinString "",
          _meta # 0,
          _meta # 1,
          _meta # 2
        ]
      ]
    ];
  };
};



//show opfor uniform and headgear if side is present
if (!isNil "phx_briefing_east_uniform" || !isNil "phx_briefing_east_headgear" || !isNil "phx_briefing_east_uniformMeta" && !isNil "phx_briefing_east_loadout") then {

  _MATDataString = _MATDataString + ([east, phx_redAT_Bravo, phx_redAT_Delta] call _fnc_parseMATForBriefing) + "---------------------------------------------<br/>";

  // show OPFOR loadout
  phx_briefing_loadoutOPF = {
    _helmetImg = [];
    _vestImg = [];
    _uniformImg = [];
    {
      _helmetImg pushBack format["<img width='110' image='%1'/>", [_x call fnc_getItemInfo, "picture"] call BIS_fnc_getFromPairs];
    } forEach phx_briefing_east_headgear;
    {
      _vestImg pushBack format["<img width='110' image='%1'/>", [_x call fnc_getItemInfo, "picture"] call BIS_fnc_getFromPairs];
    } forEach phx_briefing_east_vest;
    {
      _uniformImg pushBack format["<img width='110' image='%1'/>", [_x call fnc_getItemInfo, "picture"] call BIS_fnc_getFromPairs];
    } forEach phx_briefing_east_uniform;

    private _meta = +phx_briefing_east_uniformMeta;

    player createDiaryRecord [
      "Diary",
      [
        "OPFOR CSW Settings",
        [east] call _fnc_parseCSWForBriefing
      ]
    ];

    player createDiaryRecord [
      "Diary",
      [
        "OPFOR Loadout",
        format [
          "<font size='18' shadow='1' color='" + COLOR2 + "' face='PuristaBold'>%1</font><br/>%2",
          phx_briefing_east_loadout # 0 # 0,
          [phx_briefing_east_loadout] call phx_fnc_briefingParseLoadout
        ]
      ]
    ];
    player createDiaryRecord [
      "Diary",
      [
        "OPFOR Uniform",
        format ["<font size='18' shadow='1' color='" + COLOR2 + "' face='PuristaBold'>%4</font><br/>
<font size='14'>%5</font><br/>
Author: %6<br/><br/>
%1<br/>
%2<br/>
%3
",
          _helmetImg joinString "",
          _vestImg joinString "",
          _uniformImg joinString "",
          _meta # 0,
          _meta # 1,
          _meta # 2
        ]
      ]
    ];
  };
};



//show indfor uniform and headgear if side is present
if (!isNil "phx_briefing_ind_uniform" || !isNil "phx_briefing_ind_headgear" || !isNil "phx_briefing_ind_uniformMeta" && !isNil "phx_briefing_ind_loadout") then {

  _MATDataString = _MATDataString + ([independent, phx_grnAT_Bravo, phx_grnAT_Delta] call _fnc_parseMATForBriefing) + "---------------------------------------------<br/>";

  // show INDFOR loadout
  phx_briefing_loadoutIND = {
    _helmetImg = [];
    _vestImg = [];
    _uniformImg = [];
    {
      _helmetImg pushBack format["<img width='110' image='%1'/>", [_x call fnc_getItemInfo, "picture"] call BIS_fnc_getFromPairs];
    } forEach phx_briefing_ind_headgear;
    {
      _vestImg pushBack format["<img width='110' image='%1'/>", [_x call fnc_getItemInfo, "picture"] call BIS_fnc_getFromPairs];
    } forEach phx_briefing_ind_vest;
    {
      _uniformImg pushBack format["<img width='110' image='%1'/>", [_x call fnc_getItemInfo, "picture"] call BIS_fnc_getFromPairs];
    } forEach phx_briefing_ind_uniform;

    private _meta = +phx_briefing_ind_uniformMeta;

    player createDiaryRecord [
      "Diary",
      [
        "INDFOR CSW Settings",
        [independent] call _fnc_parseCSWForBriefing
      ]
    ];

    player createDiaryRecord [
      "Diary",
      [
        "INDFOR Loadout",
        format [
          "<font size='18' shadow='1' color='" + COLOR2 + "' face='PuristaBold'>%1</font><br/>%2",
          phx_briefing_ind_loadout # 0 # 0,
          [phx_briefing_ind_loadout] call phx_fnc_briefingParseLoadout
        ]
      ]
    ];
    player createDiaryRecord [
      "Diary",
      [
        "INDFOR Uniform",
        format ["<font size='18' shadow='1' color='" + COLOR2 + "' face='PuristaBold'>%4</font><br/>
<font size='14'>%5</font><br/>
Author: %6<br/><br/>
%1<br/>
%2<br/>
%3
",
          _helmetImg joinString "",
          _vestImg joinString "",
          _uniformImg joinString "",
          _meta # 0,
          _meta # 1,
          _meta # 2
        ]
      ]
    ];
  };
};






//list some pertinent variables
// _varStr = _varStr + format ["<font ><font size='16' color='" + COLOR3 + "' face='PuristaBold'>%1</font><br/>%2", briefingName, [missionConfigFile] call BIS_fnc_overviewAuthor];
// _varStr = _varStr + "<br/>";
// _varStr = _varStr + "<br/>";

_varStr = _varStr + format ["Safe start time: %1 minutes", phx_safeStartTime];
_varStr = _varStr + "<br/>";
_varStr = _varStr + format ["Time limit: %1 minutes", phx_missionTimeLimit];
_varStr = _varStr + "<br/>";
_varStr = _varStr + "<br/>";

_varStr = _varStr + format ["Maximum view distance: %1m", phx_maxViewDistance];
_varStr = _varStr + "<br/>";

private _magOpticsStr = "";
switch (phx_magnifiedOptics) do {
  case 1: {_magOpticsStr = "Yes"};
  case 0: {_magOpticsStr = "No"};
};
_varStr = _varStr + format ["Magnified optics: %1", _magOpticsStr];
_varStr = _varStr + "<br/>";

if (phx_defendingSide != sideEmpty) then {
  _varStr = _varStr + format ["Defender fortify points: %1", phx_fortifyPoints];
  _varStr = _varStr + "<br/>";
};

private _addNVGStr = "";
switch (phx_addNVG) do {
  case 1: {_addNVGStr = "Yes"};
  case 0: {_addNVGStr = "No"};
};
_varStr = _varStr + format ["NVGs equipped: %1", _addNVGStr];
_varStr = _varStr + "<br/>";
_varStr = _varStr + "<br/>";

phx_briefing_MMNotes = {
  // MM briefing notes
  private _systemTimeFormat = ["%1-%2-%3 %4:%5:%6"];
  _systemTimeFormat append (systemTimeUTC apply {if (_x < 10) then {"0" + str _x} else {str _x}});

  _mmNotes = [format["<font size='16' color='" + COLOR3 + "' face='PuristaBold'>%1</font><br/>%2", briefingName, [missionConfigFile] call BIS_fnc_overviewAuthor]];
  _mmNotes pushBack "<br/>";
  _mmNotes pushBack "<br/>";

  (date call BIS_fnc_sunriseSunsetTime) params ["_sunriseTime", "_sunsetTime"];
  _mmNotes pushBack format ["Temperature ASL: %1 C", 0 call ace_weather_fnc_calculateTemperatureAtHeight];
  _mmNotes pushBack "<br/>";
  _mmNotes pushBack format ["Wind: %1 at %2", windDir, windStr];
  _mmNotes pushBack "<br/>";
  _mmNotes pushBack format ["Sunrise: %1 | Sunset: %2", [_sunriseTime, "HH:MM"] call BIS_fnc_timeToString, [_sunsetTime, "HH:MM"] call BIS_fnc_timeToString];
  _mmNotes pushBack "<br/>";
  _mmNotes pushBack format ["Moon Fullness: %1%2", ceil(moonPhase date* 100), "%"];
  _mmNotes pushBack "<br/>";
  _mmNotes pushBack "<br/>";

  if (count phx_briefingBackground > 0) then {
    _mmNotes pushBack "<font size='18' color='" + COLOR3 + "' face='PuristaBold'>BACKGROUND</font>";
    _mmNotes pushBack "<br/>";
    _mmNotes pushBack (phx_briefingBackground call CBA_fnc_sanitizeHTML);
    _mmNotes pushBack "<br/>";
  };

  if (count phx_briefingWorldInfo > 0) then {
    _mmNotes pushBack "<font size='18' color='" + COLOR3 + "' face='PuristaBold'>AREA OF OPERATIONS</font>";
    _mmNotes pushBack "<br/>";
    _mmNotes pushBack (phx_briefingWorldInfo call CBA_fnc_sanitizeHTML);
    _mmNotes pushBack "<br/>";
  };

  if (count phx_briefingNotes > 0) then {
    _mmNotes pushBack "<font size='18' color='" + COLOR3 + "' face='PuristaBold'>NOTES</font>";
    _mmNotes pushBack "<br/>";
    _mmNotes pushBack (phx_briefingNotes call CBA_fnc_sanitizeHTML);
    _mmNotes pushBack "<br/>";
  };

  if (count phx_briefingRules > 0) then {
    _mmNotes pushBack "<font size='18' color='" + COLOR3 + "' face='PuristaBold'>MISSION RULES</font>";
    _mmNotes pushBack "<br/>";
    _mmNotes pushBack phx_briefingRules;
    _mmNotes pushBack "<br/>";
    _mmNotes pushBack "<br/>";
    _mmNotes pushBack "<br/>";
  };

  // game mode details
  _mmNotes pushBack format ["<font size='16' color='" + COLOR3 + "' face='PuristaBold'>GAMEMODE: %1</font>", toUpper phx_gameMode];
  _mmNotes pushBack "<br/>";
  _mmNotes pushBack "<br/>";

  if (!isNil "phx_overTimeConStr") then {
    _mmNotes pushBack "OVERTIME CONDITIONS:<br/>" + phx_overTimeConStr;
    _mmNotes pushBack "<br/>";
    _mmNotes pushBack "<br/>";
  } else {
    _mmNotes pushBack "<br/>";
    _mmNotes pushBack "<br/>";
  };

  switch (phx_gameMode) do {
    case "destroy": {
      #include "..\..\mode_config\destroy.sqf";
      _objArr = [_obj1,_obj2,_obj3];
      _objects = [_obj1 select 0, _obj2 select 0, _obj3 select 0] select {!isNull _x};
      _mmNotes pushBack format ["Destroy objectives: %1", count _objects];
      _mmNotes pushBack "<br/>";
      {
        _mmNotes pushBack format[
          "Objective %1:<br/><img image='%2' height=200/><br/>",
          _forEachIndex + 1,
          getText(configFile >> "CfgVehicles" >> (typeOf _x) >> "EditorPreview")
        ];
      } forEach _objects;
    };
    case "uplink": {
      #include "..\..\mode_config\uplink.sqf";

      _mmNotes pushBack format ["Terminal count: %1", _numberOfTerminals];
      _mmNotes pushBack "<br/>";

      if (_terminalHackTime isEqualType []) then {
        _mmNotes pushBack "Hack time:";
        _mmNotes pushBack "<br/>";
        for "_i" from 0 to _numberOfTerminals do {
          _mmNotes pushBack format ["  Terminal %1: %2", _i + 1, _terminalHackTime # _i];
          _mmNotes pushBack "<br/>";
        };
      } else {
        _mmNotes pushBack format ["Hack time: %1", _terminalHackTime];
        _mmNotes pushBack "<br/>";
      };
    };
    case "rush": {
      #include "..\..\mode_config\rush.sqf";
      _mmNotes pushBack format ["Terminal count: %1", _numberOfTerminals];
      _mmNotes pushBack "<br/>";

      if (_terminalHackTime isEqualType []) then {
        _mmNotes pushBack "Hack time:";
        for "_i" from 0 to _numberOfTerminals do {
          _mmNotes pushBack format ["Terminal %1: %2", _i + 1, _terminalHackTime # _i];
          _mmNotes pushBack "<br/>";
        };
      } else {
        _mmNotes pushBack format ["Hack time: %1", _terminalHackTime];
        _mmNotes pushBack "<br/>";
      };
    };
    case "connection": {
      #include "..\..\mode_config\connection.sqf";
      _mmNotes pushBack format ["Terminal count: %1", _numberOfTerminals];
      _mmNotes pushBack "<br/>";

      _mmNotes pushBack format ["One point accrued per terminal every %1 seconds", _pointAddTime];
      _mmNotes pushBack "<br/>";
    };
    case "captureTheFlag": {
      #include "..\..\mode_config\ctf.sqf";

      private _capZoneShown = "";
      switch (_showCapZoneGlobal) do {
        case true: {_capZoneShown = "to all players at mission start"};
        case false: {_capZoneShown = "only to attackers until flag is touched"};
      };
      _mmNotes pushBack format ["Capture zone visible %1", _capZoneShown];
      _mmNotes pushBack "<br/>";

      _mmNotes pushBack format ["Flag marker updated every %1 seconds", _flagMarkUpdateTime];
      _mmNotes pushBack "<br/>";

      _mmNotes pushBack format ["Attackers must hold the flag in capture zone for %1 seconds to achieve victory", _flagCaptureTime];
      _mmNotes pushBack "<br/>";
    };
    case "adSector": {
      #include "..\..\mode_config\adSector.sqf";

      private _isSequential = "";
      switch (_inOrder) do {
        case true: {_isSequential = "Yes"};
        case false: {_isSequential = "No"};
      };
      _mmNotes pushBack format ["Sector count: %1", _numberOfSectors];
      _mmNotes pushBack "<br/>";
      _mmNotes pushBack format ["Sequential: %1", _isSequential];
      _mmNotes pushBack "<br/>";
    };
    case "neutralSector": {
      #include "..\..\mode_config\neutralSector.sqf";
      _mmNotes pushBack format ["Sector count: %1", _numberOfSectors];
      _mmNotes pushBack "<br/>";

      _mmNotes pushBack format ["One point accrued per sector every %1 seconds", _pointAddTime];
      _mmNotes pushBack "<br/>";
    };
    case "scavHunt": {
      #include "..\..\mode_config\scavHunt.sqf";
      _mmNotes pushBack format ["Objective count: %1", _numberOfObjectives];
      _mmNotes pushBack "<br/>";

      _mmNotes pushBack format ["Specialized transports per side: %1", _numberOfTransportsPerSide];
      _mmNotes pushBack "<br/>";
    };
    case "assassin": {
      ["REFRESH_BRIEF_GAMEMODE", {
        #include "..\..\mode_config\assassin.sqf";

        private _mmNotes = [];
        private _mmNotesStructGamemode = [];

        _mmNotes pushBack format ["<font size='16' color='" + COLOR3 + "' face='PuristaBold'>GAMEMODE: %1</font>", toUpper phx_gameMode];
        _mmNotes pushBack "<br/>";
        _mmNotes pushBack "<br/>";

        if (!isNil "phx_overTimeConStr") then {
          _mmNotes pushBack "OVERTIME CONDITIONS:<br/>" + phx_overTimeConStr;
          _mmNotes pushBack "<br/>";
          _mmNotes pushBack "<br/>";
        } else {
          _mmNotes pushBack "<br/>";
          _mmNotes pushBack "<br/>";
        };

        _mmNotes pushBack format ["HVT Count: %1<br/>", count _targets];
        _mmNotes pushBack format ["%1 needs to kill %2 of them to win.<br/>", phx_attackingSide call BIS_fnc_sideName, _requiredKills];
        _mmNotes pushBack "<br/><br/>";
        _mmNotes pushBack "Jammers are in place to secure 1 or more specifically marked areas in which the HVTs can safely hide. If an HVT moves outside of any protected zone, their position will be revealed on the enemy's map until they return to safety. HVT locations will ALWAYS be revealed to their allies to aid them in tactical defense.";
        _mmNotes pushBack "<br/><br/>";

        _mmNotes pushBack format ["<font color='%1' size='16'>HVTs</font><br/>", COLOR3];

        {
          (_x # 0) params ["_targetHeader"];
          (_x # 1) params ["_role", "_name", "_obj"];
          if (!isNil "_obj") then {
            _mmNotes pushBack format ["<font color='%1'>  %2:</font> %3 (%4, played by %5)<br/>", COLOR3, _targetHeader, _name, _role, name _obj];
          } else {
            _mmNotes pushBack format ["<font color='%1'>  %2:</font> %3 (%4, played by [NOT FILLED])</font><br/>", COLOR3, _targetHeader, _name, _role, name _obj];
          };
        } forEach phx_assassinationTargets;

        player setDiaryRecordText [["Diary", phx_diary_gamemode], [
          format["Gamemode - %1", toUpper phx_gameMode],
          _mmNotes joinString ""
          ]
        ];
      }] call CBA_fnc_addEventHandler;

      phx_diary_gamemode = player createDiaryRecord ["Diary",
        [
          // getText(missionConfigFile >> "Author"),
          "Gamemode",
          ""
        ]
      ];

      ["REFRESH_BRIEF_GAMEMODE"] call CBA_fnc_localEvent;
    };
  };

  phx_diary_briefing = player createDiaryRecord ["Diary",
    [
      // getText(missionConfigFile >> "Author"),
      "Briefing",
      _mmNotes joinString ""
    ]
  ];

};


call phx_fnc_briefNews;

PHX_Diary_UpdateInfo = player createDiarySubject ["PHX_Diary_UpdateInfo", "Framework Info", "\A3\ui_f\data\igui\cfg\simpleTasks\types\box_ca.paa"];
player createDiaryRecord [
  "PHX_Diary_UpdateInfo",
  [
    "Changelog",
    format [
      "<font size='18' shadow='1' color='" + COLOR2 + "'>Changelog</font><br/>Template Version: %1<br/><br/>%2<br/><br/><font size='18' shadow='1' color='" + COLOR2 + "'>Credits</font><br/>%3",
      phx_templateVersion,
      phx_ui_changelogText,
      phx_ui_frameworkCreditsText
    ]
  ]
];

PHX_Diary_Credits = player createDiarySubject ["PHX_Diary_Credits", "Credits"];
player createDiaryRecord [
  "PHX_Diary_Credits",
  [
    "Credits",
    [phx_ui_structTextRef, "Credits"] call BIS_fnc_getFromPairs
  ]
];


if (!isNil "phx_briefing_loadoutIND") then {
  call phx_briefing_loadoutIND;
};
if (!isNil "phx_briefing_loadoutOPF") then {
  call phx_briefing_loadoutOPF;
};
if (!isNil "phx_briefing_loadoutBLU") then {
  call phx_briefing_loadoutBLU;
};

MAT_Diary = player createDiaryRecord ["Diary",["MAT Selection",_MATDataString]];

player setDiarySubjectPicture ["Diary", "\A3\ui_f\data\igui\cfg\simpleTasks\types\documents_ca.paa"];

[{
  getClientStateNumber >= 8 &&
  !isNil "phx_templateGroupsList" &&
  !isNil "phx_playerBaseChannel" &&
  !isNil "phx_briefing_startingRadios" &&
  missionNamespace getVariable ["phx_groupIDset", false]
}, {
  params ["_varStr"];
  call phx_briefing_startingRadios;
  [false] call phx_fnc_briefingGear;
  player createDiaryRecord ["Diary",["Mission Variables",_varStr]];
  call phx_briefing_MMNotes;
  call phx_fnc_createOrbat;
  [{
    [] spawn phx_fnc_createOrbat;
    if (getClientStateNumber >= 10) then {[_handle] call CBA_fnc_removePerFrameHandler};
  }, 7] call CBA_fnc_addPerFrameHandler;

  private _briefingEntry = (allDiarySubjects player) select {_x # 0 == "Diary"};
  private _briefingEntryCount = _briefingEntry # 0 # 3;
  player selectDiarySubject format["Diary:Record%1", _briefingEntryCount - 2];
},[_varStr]] call CBA_fnc_waitUntilAndExecute;


// player createDiarySubject ["Utilities", "Utilities"];
// player createDiaryRecord [
//   "Utilities",
//   [
//     "Screenshots/UI",
//     "<font face='PuristaMedium'><executeClose expression='showHUD [false,false,false,false,false,false,false,false,false,false,false]; diwako_dui_main_toggled_off=true; showChat false;'>Hide HUD</executeClose><br/><executeClose expression='showHUD [true,true,true,true,true,true,false,true,true,true,false]; diwako_dui_main_toggled_off=false; showChat true;'>Show HUD</executeClose></font>"
//   ]
// ];

//call phx_fnc_objectiveRecon;

phx_briefCreated = true; //let phx_fnc_briefInit know the briefing is created
