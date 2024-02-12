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
 * [[bob, ted], false] call afmf_main_fnc_example
 *
 * Public: No
 */

params [["_unit", objNull]];
if !(alive _unit) exitWith {};

_unit addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];

	private _logic = _unit getVariable [QGVAR(logic), objNull];
	private _delaySpawnNearbyUnits = _logic getVariable [QGVAR(delaySpawnNearbyUnits), 5];
	_unit setVariable [QGVAR(delaySpawnNearbyUnits), time + random _delaySpawnNearbyUnits];

	private _tickets = _unit getVariable [QGVAR(tickets), 1];
	_tickets = _tickets - 1;
	if (_tickets <= 0) exitWith {};

	_unit setVariable [QGVAR(tickets), _tickets];

	private _respawnDelay = _logic getVariable [QGVAR(respawnDelay), [10, 20, 30]];
	[_unit, _logic, false, random _respawnDelay max 1] call FUNC(despawn);
}];
