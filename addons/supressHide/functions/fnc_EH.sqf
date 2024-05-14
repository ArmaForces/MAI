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

params [["_unit", objNull], ["_suppressedTime", 30]];

// hide when fired at
_unit addEventHandler ["Suppressed", {
	params ["_unit", "_distance", "_shooter", "_instigator", "_ammoObject", "_ammoClassName", "_ammoConfig"];
	if !(local _unit) exitWith {};
	if (_unit distance _shooter < 25 + random 25) exitWith {};
	_unit lookAt _shooter;
	[_unit] call FUNC(Hide);

	_unit setVariable ["AF_suppressedTime", time + random _suppressedTime];
}];

// hide on reload
_unit addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	if (_unit ammo _muzzle > 0) exitWith {};
	[_unit] call FUNC(Hide);
	// [
	// 	{
	// 		_this ammo currentWeapon _this > 0
	// 	},
	// 	{
	// 		_this call FUNC(Unhide);
	// 	},
	// 	_unit,
	// 	10
	// ] call CBA_fnc_waitUntilAndExecute;
}];
