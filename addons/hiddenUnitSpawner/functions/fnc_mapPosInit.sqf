#include "script_component.hpp"

if (is3DENPreview || (!hasInterface && !isDedicated)) then {
	AF_debug = false;
	GVAR(mapBlacklist) = missionNamespace getVariable [QGVAR(mapBlacklist), []];
	GVAR(explosionList) = missionNamespace getVariable [QGVAR(explosionList), []];
	GVAR(AF_debugMarkers) = missionNamespace getVariable [QGVAR(AF_debugMarkers), []];
	[] call FUNC(mapPosCheckPosLoop);
	[] call FUNC(mapPosCleanup);
};