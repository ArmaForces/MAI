#include "script_component.hpp"
/*
 * Author: Madin5
 * <Description>
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * <Example>
 *
 * Public: No
 */

params [["_unit", objNull]];
private _hidden = _unit getVariable ["AF_unitHidden", false];
if (_hidden) exitWith {};

private _unitPos = unitPos _unit;
if (_unitPos isEqualTo "Down") exitWith {};

if (_unitPos isEqualTo "Middle") then {
	_unit playActionNow "PlayerProne";
	_unit setUnitPos "Down";
	_unit setVariable ["AF_unitStanceHide", _unitPos];
} else {
	_unit playActionNow "PlayerCrouch";
	_unit setUnitPos "Middle";
	// _unit setUnitPos "Down";
	_unit setVariable ["AF_unitStanceHide", "Up"];
};

_unit setVariable ["AF_unitHidden", true];

private _suppressedTime = _unit getVariable ["AF_suppressedTime", 30];

[
	{
		_this call FUNC(unhideConditionLoop);
	},
	_unit,
	random _suppressedTime max 2
] call CBA_fnc_waitAndExecute;
