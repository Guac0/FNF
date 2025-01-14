params [["_data", []], ["_structTxt", false]];
_data params [["_meta", []], ["_loadout", []]];

if (_loadout isEqualTo []) exitWith {"Failed to generate loadout summary."};

private _rifles = [_loadout, "rifle"] call BIS_fnc_getFromPairs;
private _sidearm = [_loadout, "sidearm"] call BIS_fnc_getFromPairs;
private _AR = [_loadout, "AR"] call BIS_fnc_getFromPairs;
private _MG = [_loadout, "MG"] call BIS_fnc_getFromPairs;
private _AT = [_loadout, "AT"] call BIS_fnc_getFromPairs;
private _SNP = [_loadout, "SNP"] call BIS_fnc_getFromPairs;
private _RIS = [_loadout, "RIS"] call BIS_fnc_getFromPairs;
private _CR = [_loadout, "CR"] call BIS_fnc_getFromPairs;

private _output = [];

switch (_structTxt) do {
  case false: {
    _output pushBack format["<font size='14'>%1</font>",_meta # 1];
    _output pushBack format["Author: %1<br/>", _meta # 2];

    _output pushBack "<font size='18' color='#e1701a' face='PuristaBold'>PRIMARY</font>";
    _output append ([_rifles, false] call phx_fnc_briefingWeaponDetails);
    _output append ([_sidearm, false] call phx_fnc_briefingWeaponDetails);
    _output pushBack "<font size='18' color='#e1701a' face='PuristaBold'>SUPPORT</font>";
    _output append ([_AR, false] call phx_fnc_briefingWeaponDetails);
    _output append ([_MG, false] call phx_fnc_briefingWeaponDetails);
    if !(_AT isEqualTo []) then {
      _output pushBack "<font size='18' color='#e1701a' face='PuristaBold'>LAT</font>";
      _output append ([_AT, false] call phx_fnc_briefingWeaponDetails);
    };
    _output pushBack "<font size='18' color='#e1701a' face='PuristaBold'>RECON</font>";
    _output append ([_SNP, false] call phx_fnc_briefingWeaponDetails);
    _output append ([_RIS, false] call phx_fnc_briefingWeaponDetails);
    _output pushBack "<font size='18' color='#e1701a' face='PuristaBold'>CREW/AVIATION</font>";
    _output append ([_CR, false] call phx_fnc_briefingWeaponDetails);
  };
  case true: {
    _output pushBack format["<t size='1.1'>%1</t>",_meta # 1];
    _output pushBack format["Author: %1<br/>", _meta # 2];

    _output pushBack "<t size='1.1' color='#e1701a' face='PuristaBold'>PRIMARY</t>";
    _output append ([_rifles, true] call phx_fnc_briefingWeaponDetails);
    _output append ([_sidearm, true] call phx_fnc_briefingWeaponDetails);
    _output pushBack "<t size='1.1' color='#e1701a' face='PuristaBold'>SUPPORT</t>";
    _output append ([_AR, true] call phx_fnc_briefingWeaponDetails);
    _output append ([_MG, true] call phx_fnc_briefingWeaponDetails);
    if !(_AT isEqualTo []) then {
      _output pushBack "<t size='1.1' color='#e1701a' face='PuristaBold'>LAT</t>";
      _output append ([_AT, true] call phx_fnc_briefingWeaponDetails);
    };
    _output pushBack "<t size='1.1' color='#e1701a' face='PuristaBold'>RECON</t>";
    _output append ([_SNP, true] call phx_fnc_briefingWeaponDetails);
    _output append ([_RIS, true] call phx_fnc_briefingWeaponDetails);
    _output pushBack "<t size='1.1' color='#e1701a' face='PuristaBold'>CREW/AVIATION</t>";
    _output append ([_CR, true] call phx_fnc_briefingWeaponDetails);
  };
};
_output joinString '<br/>'
