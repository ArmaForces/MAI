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
if (!alive _unit) exitWith {};
private _logic = _unit getVariable [QGVAR(logic), objNull];
if (!alive _logic) exitWith {};
_unitArray = _unit getVariable [QGVAR(unitArray), []];
if (_unitArray isEqualTo []) exitWith {};
_unitArray params ["_type", "_loadout", "_pos", "_dir", "_stance", "_disabledAiFeatures", "_vehicleArray", "_building", "_buildingStatus", "_sphereSizeUnit", "_sphereBackDistanceUnit", "_sphereDespawnDistanceUnit", "_tickets"];
if (_sphereDespawnDistanceUnit < 0) exitWith {};
private _spherePos = _pos getPos [_sphereSizeUnit - _sphereBackDistanceUnit + _sphereDespawnDistanceUnit*0.9, _dir];
private _nearplayers = _spherePos nearEntities ["allVehicles", _sphereSizeUnit + _sphereDespawnDistanceUnit];
private _playerIndex = _nearplayers findIf {isPlayer _x && !(vehicle _x isKindOf "AIR")};
// despawn unit
if (_playerIndex == -1) exitWith {
	[_unit, _logic, true, 0] call FUNC(despawn);
};

[
	{
		_this call FUNC(despawnLoop);
	},
	_this,
	0.75 + random 0.5
] call CBA_fnc_waitAndExecute;