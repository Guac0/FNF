

_channelsArr_343 = [];
for "_i" from 1 to 80 do {_channelsArr_343 pushBack [(_i), (_i / 10)]};
missionNamespace setVariable ["channelsArr_343", _channelsArr_343, true];

missionNamespace setVariable ["channelsArr_152", [
	["PHQ", 1],
	["XRAY", 2],
	["ALPHA", 3],
	["BRAVO", 4],
	["CHARLIE", 5],
	["DELTA", 6],
	["GOLF", 7],
	["HOTEL", 8]
], true];
missionNamespace setVariable ["channelsArr_117", [
	["PHQ", 1]//,
	// ["XRAY", 2],
	// ["GOLF ASSETS", 3],
	// ["HOTEL AIR", 4]
], true];


// [
//     [west, "English"],
//     [east, "Russian"],
//     [independent, "Croatian"],
//     [civilian, "Latin"]
// ] call acre_api_fnc_babelSetupMission;

["en", "English"] call acre_api_fnc_babelAddLanguageType;
["ru", "Russian"] call acre_api_fnc_babelAddLanguageType;
["guer", "Croatian"] call acre_api_fnc_babelAddLanguageType;
["civ", "Latin"] call acre_api_fnc_babelAddLanguageType;


{
    private _thisSide = _x;
    private _thisSideStr = str(_x);
    private _thisSideFriendlyName = format["%1 ", toUpper (((_x call BIS_fnc_sideID) call BIS_fnc_sideName) select [0,3])];

    _freqPreset = switch (_thisSide) do {
        case west: {"default"}; 
        case east: {"default2"};
        case independent: {"default3"};
        default {"default4"};
    };

    // set default frequency packages, accounting for channels outside of those we manually configure per the ORBAT. ensuring they match per side allows players to use, for example, channel 95 and have their radio be on the same frequency
    ["ACRE_PRC343", _freqPreset, _thisSideStr] call acre_api_fnc_copyPreset;
    ["ACRE_PRC152", _freqPreset, _thisSideStr] call acre_api_fnc_copyPreset;
    ["ACRE_PRC117F", _freqPreset, _thisSideStr] call acre_api_fnc_copyPreset;


    _baseChannel = switch (_thisSide) do {
        case east: {phx_opforBaseChannel};
        case west: {phx_bluforBaseChannel};
        case independent: {phx_indforBaseChannel};
        case civilian: {phx_civilianBaseChannel};
    };
    _encryptionKey = switch (_thisSide) do {
        case east: {phx_opforRadioEncryption};
        case west: {phx_bluforRadioEncryption};
        case independent: {phx_indforRadioEncryption};
        case civilian: {phx_civilianRadioEncryption};
    };

    {
        private _chan = _x # 0;
        private _freq = _baseChannel - 10 + (_x # 1);

        ["ACRE_PRC343", _thisSideStr, _chan, "frequencyRX", _freq] call acre_api_fnc_setPresetChannelField;
        ["ACRE_PRC343", _thisSideStr, _chan, "frequencyTX", _freq] call acre_api_fnc_setPresetChannelField;
    } forEach channelsArr_343;

    {
        private _chan = _forEachIndex + 1;
        private _label = _x # 0;
        private _freq = _baseChannel + (_x # 1) - 1;

        ["ACRE_PRC152", _thisSideStr, _chan, "name", _thisSideFriendlyName + _label] call acre_api_fnc_setPresetChannelField;
        ["ACRE_PRC152", _thisSideStr, _chan, "frequencyRX", _freq] call acre_api_fnc_setPresetChannelField;
        ["ACRE_PRC152", _thisSideStr, _chan, "frequencyTX", _freq] call acre_api_fnc_setPresetChannelField;
        ["ACRE_PRC152", _thisSideStr, _chan, "encryption", _encryptionKey] call acre_api_fnc_setPresetChannelField;
    } forEach channelsArr_152;


    {
        private _chan = _forEachIndex + 1;
        private _label = _x # 0;
        private _freq = _baseChannel + 10 + (_x # 1) - 1;

        ["ACRE_PRC117F", _thisSideStr, _chan, "name", _thisSideFriendlyName + _label] call acre_api_fnc_setPresetChannelField;
        ["ACRE_PRC117F", _thisSideStr, _chan, "frequencyRX", _freq] call acre_api_fnc_setPresetChannelField;
        ["ACRE_PRC117F", _thisSideStr, _chan, "frequencyTX", _freq] call acre_api_fnc_setPresetChannelField;
        ["ACRE_PRC117F", _thisSideStr, _chan, "encryption", _encryptionKey] call acre_api_fnc_setPresetChannelField;
    } forEach channelsArr_117;

} forEach [east, west, independent, civilian];

missionNamespace setVariable ["phx_acreSetup", true];