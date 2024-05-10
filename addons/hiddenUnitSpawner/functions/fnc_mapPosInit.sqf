#include "script_component.hpp"

if (is3DENPreview || (!hasInterface && !isDedicated)) then {
	AF_debug = false;
	QGVAR(mapBlacklist) = missionNamespace getVariable [QGVAR(mapBlacklist), []];
	QGVAR(explosionList) = missionNamespace getVariable [QGVAR(explosionList), []];
	QGVAR(AF_debugMarkers) = missionNamespace getVariable [QGVAR(AF_debugMarkers), []];
	[] call FUNC(mapPosCheckPosLoop);
	[] call FUNC(mapPosCleanup);
};