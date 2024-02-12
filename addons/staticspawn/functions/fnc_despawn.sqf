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

private _tickets = _unit getVariable [QGVAR(tickets), 1];
_unitArray set [14, _tickets];

if (_waitTime <= 0) exitWith {
	[_logic, _unitArray, _groupID, _group, _groups, _side] call FUNC(despawnAddToLogic);
};
[
	{_this call FUNC(despawnAddToLogic)},
	[_logic, _unitArray, _groupID, _group, _groups, _side],
	_waitTime
] call CBA_fnc_waitAndExecute;

