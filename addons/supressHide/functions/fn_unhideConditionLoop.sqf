params [["_unit", objNull]];

if !(alive _unit) exitWith {};

private _suppressedTime = _unit getVariable ["AF_suppressedTime", 30];
private _currentAmmo = _unit ammo currentWeapon _unit;

if (time < _suppressedTime || _currentAmmo == 0) exitWith {
	[
		{_this call FUNC(unhideConditionLoop)},
		_this,
		0
	] call CBA_fnc_waitAndExecute;
};
_unit call AF_fnc_suppressUnhide;