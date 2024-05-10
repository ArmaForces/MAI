#include "script_component.hpp"

if (is3DENPreview || (!hasInterface && !isDedicated)) then {
	AF_debug = false;
	AF_mapBlacklist = missionNamespace getVariable [QGVAR(mapBlacklist), []];
	AF_debugMarkers = missionNamespace getVariable [QGVAR(debugMarkers), []];
	[] call AF_fnc_mapPosCheckPosLoop;
	[] call AF_fnc_mapPosCleanup;
};