#include "script_component.hpp"

params [["_unit", objNull]];
if (!alive _unit) exitWith {};

private _adjustInterval = _unit getVariable [QGVAR(adjustInterval), 3];
[
	{_this call  FUNC(AdjustStanceLoop)},
	_this,
	random _adjustInterval max 0.5
] call CBA_fnc_waitAndExecute;
if (behaviour _unit != "COMBAT") exitWith {};
if (lifeState _unit isEqualTo "INCAPACITATED") exitWith {};
if (speed _unit > 0) exitWith {};

private _currentStance = [_unit] call  FUNC(CheckAdjust);
if (_currentStance == "LEFT") exitWith {
	[_unit, "AdjustR"] call  FUNC(AdjustStanceMove);
};
if (_currentStance == "RIGHT") exitWith {
	[_unit, "AdjustL"] call  FUNC(AdjustStanceMove);
};

if (stance _unit == "PRONE") exitWith {};

private _unitDefaultPos = _unit getVariable [QGVAR(unitPos), [0,0,0]];

private _unitDir = getDir _unit;
private _unitDesiredDir = _unit getVariable [QGVAR(unitDir), 0];
private _angleDelta = [_unitDesiredDir, _unitDir] call BIS_fnc_getAngleDelta;

if (abs _angleDelta > 22.5) exitWith {};

private _reldir = _unit getRelDir _unitDefaultPos;
private _dirToPos = _unit getdir _unitDefaultPos;

if (_reldir >= 67.5 && _reldir <= 112.5) exitWith {
	[_unit, "AdjustR"] call  FUNC(AdjustStanceMove);
};
if (_reldir >= 247.5 && _reldir  <= 292.5) exitWith {
	[_unit, "AdjustL"] call  FUNC(AdjustStanceMove);
};