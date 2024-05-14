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
if !(alive _unit) exitWith {};

private _suppressedTime = _unit getVariable [QGVAR(suppressedTime), 30];
private _currentAmmo = _unit ammo currentWeapon _unit;

if (time < _suppressedTime || _currentAmmo == 0) exitWith {
	[
		{_this call FUNC(unhideConditionLoop)},
		_this,
		1
	] call CBA_fnc_waitAndExecute;
};
[_unit] call FUNC(unhide);
