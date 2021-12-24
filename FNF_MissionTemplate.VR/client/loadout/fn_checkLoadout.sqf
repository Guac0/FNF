if !(hasInterface) exitWith {};

#include "script_component.hpp"

[{
    params ["_args", "_handle"];
    _args params ["_addTime"];

    if !(missionNamespace getVariable ["phx_loadoutAssigned",false]) then {
        // After 30 seconds with no loadout being set, kick player back to the slotting screen
        if (diag_tickTime-30 > _addTime) then {
            ERROR("Waited 30 seconds and didn't get a loadout! Report this to the mission maker. - " + _addTime);
            endMission "END1";
        };
    } else {
        // Loadout was set, stop PFH
        INFO("Loadout set in " + str(diag_tickTime - _addTime) + " seconds");
        [_handle] call CBA_fnc_removePerFrameHandler;
    };
}, 0, [diag_tickTime]] call CBA_fnc_addPerFrameHandler;
