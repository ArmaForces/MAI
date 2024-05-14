#include "script_component.hpp"

params [["_unit", objNull]];
if (!alive _unit) exitWith {};
private _hidden = _unit getVariable [QEGVAR(supressHide,unitHidden), false];
if (lifeState _unit isEqualTo "INCAPACITATED" ||
	behaviour _unit != "COMBAT" ||
	stance _unit == "PRONE" ||
	_hidden
	) exitWith {
	[
		{_this call FUNC(MainLoop)},
		_this,
		1 + random 1
	] call CBA_fnc_waitAndExecute;
};
private _canMove = _unit getVariable [QGVAR(allowMove), true];
if !(_canMove) exitWith {
	[
		{_this call FUNC(MainLoop)},
		_this,
		0.5
	] call CBA_fnc_waitAndExecute;
};

private _interval = _unit getVariable [QGVAR(interval), 5];
private _unitMovePos = _unit getVariable [QGVAR(unitMovePos), []];
private _moveToPos = selectRandom _unitMovePos;

_distance = _unit distance2D _moveToPos;

// private _unitDesiredDir = _unit getVariable ["AF_unitDir", 0];
// private _unitDir = getDir _unit;
// private _angleDelta = [_unitDesiredDir, _unitDir] call BIS_fnc_getAngleDelta;

if (_distance < 0.1) exitWith {
	[
		{_this call FUNC(MainLoop)},
		_this,
		random _interval max 1
	] call CBA_fnc_waitAndExecute;
};

private _reldir = _unit getRelDir _moveToPos;
private _dirToPos = _unit getdir _moveToPos;

// private _debug1 = createVehicle ["VR_3DSelector_01_default_F", _moveToPos, [], 0, "CAN_COLLIDE"];
// [
// 	{deleteVehicle _this},
// 	_debug1,
// 	2
// ] call CBA_fnc_waitAndExecute;
// private _debug1 = createVehicle ["Sign_Arrow_Direction_F", _moveToPos, [], 0, "CAN_COLLIDE"];
// _debug1 attachTo [_unit, [0, 0, 0]];


if (_reldir >= 60 && _reldir <= 120) exitWith {
	[_unit, _moveToPos, _dirToPos - 90,  "walkr"] call FUNC(Move);
};
if (_reldir >= 240 && _reldir  <= 300) exitWith {
	[_unit, _moveToPos, _dirToPos + 90,  "walkl"] call FUNC(Move);
};

if (_reldir >= 30 && _reldir <= 60) exitWith {
	[_unit, _moveToPos, _dirToPos - 45,  "WalkRF"] call FUNC(Move);
};
if (_reldir >= 300 && _reldir <= 330) exitWith {
	[_unit, _moveToPos, _dirToPos + 45,  "WalkLF"] call FUNC(Move);
};

if (_reldir >= 210 && _reldir <= 240) exitWith {
	[_unit, _moveToPos, _dirToPos + 135,  "WalkLB"] call FUNC(Move);
};
if (_reldir >= 120 && _reldir <= 150) exitWith {
	[_unit, _moveToPos, _dirToPos - 135,  "WalkRB"] call FUNC(Move);
};

[
	{_this call FUNC(MainLoop)},
	_this,
	random _interval max 1
] call CBA_fnc_waitAndExecute;