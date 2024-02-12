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

params [["_logic", objNull], ["_unitArray", []], ["_groupID", objNull], ["_group", grpNull], ["_groups", []], ["_side", []]];

private _active = _logic getVariable [QGVAR(active), true];
if (_groups isEqualTo []) exitWith {
	_groups pushBack [_groupID, _side, [_unitArray], _group];
	if !(_active) then {
		_logic setVariable [QGVAR(active), true];
		_logic call FUNC(loop);
	};
};
private _groupIndex = _groups findIf {_x select 0 isEqualTo _groupID};
if (_groupIndex isEqualTo -1) exitWith {
	_groups pushBack [_groupID, _side, [_unitArray], _group];
	if !(_active) then {
		_logic setVariable [QGVAR(active), true];
		_logic call FUNC(loop);
	};
};
private _groupArray = _groups select _groupIndex;
_groupArray params ["_groupID", "_side", "_units", ["_group", grpNull]];
_units pushBack _unitArray;
