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

params [["_logic", objNull], ["_unit", objNull], ["_pos", [0,0,0]], ["_dir", 0]];

// check if spawn pos of other units in group is more than set in module
private _unitPos = _unit getVariable [QGVAR(pos), getposATL _unit];
private _distance = _unitPos distance _pos;
private _minDistance = _logic getVariable [QGVAR(minDistance), 10];
if (_distance > _minDistance) exitWith {false};

// check if new bot will be facing same direction
private _unitDir = _unit getVariable [QGVAR(dir), getDir _unit];
private _deltaAngle = [_unitDir, _dir] call BIS_fnc_getAngleDelta;
private _maxAngle = _logic getVariable [QGVAR(maxAngle), 22.5];
if (abs _deltaAngle > _maxAngle) exitWith {false};

// var added at EH killed
private _DelaySpawnNearbyUnits = _unit getVariable [QGVAR(delaySpawnNearbyUnits), time];
if (_DelaySpawnNearbyUnits < time) exitWith {false};
true