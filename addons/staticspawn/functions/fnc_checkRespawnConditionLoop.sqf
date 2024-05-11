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

params [["_logic", objNull], ["_unitArray", []], ["_groupID", objNull], ["_group", grpNull], ["_groups", []], ["_side", []], ["_pos", [0,0,0]], ["_waitUntil", 0]];

private _sphereBackDistance = _logic getVariable [QGVAR(sphereBackDistance), 30];
private _nearplayers = _pos nearEntities ["allVehicles", _sphereBackDistance];
private _playerIndex = _nearplayers findIf {isPlayer _x};
// stop spawn near units if player nearby
if (_playerIndex > -1) exitWith {};

if (_waitUntil <= time) exitWith {
	[_logic, _unitArray, _groupID, _group, _groups, _side] call FUNC(despawnAddToLogic);
};

[
	{_this call FUNC(checkRespawnConditionLoop)},
	_this,
	0.9 + random 0.2
] call CBA_fnc_waitAndExecute;