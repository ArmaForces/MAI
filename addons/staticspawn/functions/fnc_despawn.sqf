#include "script_component.hpp"
/*
 * Author: <author>
 * Function description
 *
 * Arguments:
 * 0: Objects <ARRAY>
 * 1: All <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[bob, ted], false] call afmai_main_fnc_example
 *
 * Public: No
 */

params [["_unit", objNull], ["_logic", objNull], ["_deleteBody", true], ["_waitTime", 0]];
private _unitArray = _unit getVariable [QGVAR(unitArray), []];
private _groupID = _unit getVariable [QGVAR(groupID), -1];
private _groups = _logic getVariable [QGVAR(groups), []];
private _side = _unit getVariable [QGVAR(side), side _unit];
private _active = _logic getVariable [QGVAR(active), true];
private _group = group _unit;

if (_deleteBody) then {
	deleteVehicle _unit;
};

// _unitArray params [
// 	"_type",
// 	"_loadout",
// 	"_pos",
// 	"_dir",
// 	"_stance",
// 	"_disabledAiFeatures",
// 	"_vehicleArray",
// 	"_building",
// 	"_buildingStatus",
// 	"_sphereSizeUnit",
// 	"_sphereBackDistanceUnit",
// 	"_sphereDespawnDistanceUnit",
// 	"_checkVisibilityUnit",
// 	"_forceSpawnDistanceUnit",
// 	["_tickets", 1]
// ];

private _tickets = _unit getVariable [QGVAR(tickets), 1];
_unitArray set [14, _tickets];

if (_waitTime <= 0) exitWith {
	[_logic, _unitArray, _groupID, _group, _groups, _side] call FUNC(despawnAddToLogic);
};

private _pos = _unitArray select 2;
private _waitUntil = time + _waitTime;

[
	{_this call FUNC(checkRespawnConditionLoop)},
	[_logic, _unitArray, _groupID, _group, _groups, _side, _pos, _waitUntil],
	_waitTime
] call CBA_fnc_waitAndExecute;

