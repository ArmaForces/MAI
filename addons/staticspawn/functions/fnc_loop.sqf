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

params [
	["_logic", objNull]
];
if (_logic isEqualTo objNull) exitWith {};
private _groups = _logic getVariable [QGVAR(groups), []];
if (_groups isEqualTo []) exitWith {
	// systemChat "loop groups isEqualTo []";
	_logic setVariable [QGVAR(active), false];
};

[
	{
		_this call FUNC(loop);
	},
	_this,
	0.01
] call CBA_fnc_waitAndExecute;

private _executionCodeGroup = _logic getVariable [QGVAR(executionCodeGroup), {}];
// private _checkedUnits = 0;

{
	_x params ["_groupID", "_side", "_units", ["_group", grpNull]];
	
	// just break the loop, continue it on next frame
	if (_units isEqualTo []) exitWith {
		_groups deleteAt _forEachIndex;
	};

	// create group when not present
	if (_group isEqualTo grpNull) then {
		_group = createGroup [_side, true];
		_x set [3, _group];
		[_group] call _executionCodeGroup;
	};
	// _checkedUnits = _checkedUnits + 1;

	private _unitsPerFrame = count _units / diag_fpsMin;
	private _maxUnits = ceil _unitsPerFrame min count _units min 10;

	for "_i" from 1 to _maxUnits do {
		private _unit = [_logic, _units, _group] call FUNC(spawnUnit);
	};

} forEach _groups;

_logic setVariable [QGVAR(groups), _groups];

Nil