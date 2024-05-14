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

params [["_unit", objNull]];
if !(alive _unit) exitWith {};

_unit addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];

	private _logic = _unit getVariable [QGVAR(logic), objNull];
	if !(alive _logic) exitWith {};
	private _delaySpawnNearbyUnits = _logic getVariable [QGVAR(delaySpawnNearbyUnits), 5];
	_unit setVariable [QGVAR(delaySpawnNearbyUnits), time + random _delaySpawnNearbyUnits];

	private _tickets = _unit getVariable [QGVAR(tickets), 1];
	_tickets = _tickets - 1;
	if (_tickets <= 0) exitWith {};

	private _unitArray = _unit getVariable [QGVAR(unitArray), []];
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
	private _pos = _unitArray select 2;

	private _sphereBackDistance = _logic getVariable [QGVAR(sphereBackDistance), 30];
	private _nearplayers = _pos nearEntities ["allVehicles", _sphereBackDistance];
	private _playerIndex = _nearplayers findIf {isPlayer _x};
	// stop spawn near units if player nearby
	if (_playerIndex > -1) exitWith {};

	_unit setVariable [QGVAR(tickets), _tickets];

	private _respawnDelay = _logic getVariable [QGVAR(respawnDelay), [10, 20, 30]];
	[_unit, _logic, false, random _respawnDelay max 1] call FUNC(despawn);
}];
