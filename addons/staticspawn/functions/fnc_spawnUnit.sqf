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
 * [[bob, ted], false] call afmai_main_fnc_example
 *
 * Public: No
 */

params [["_logic", objNull], ["_units", []], ["_group", grpNull]];
private _unit = objNull;
if (_units isEqualTo []) exitWith {objNull};
private _unitArray = _units deleteAt 0;
_unitArray params [
	"_type",
	"_loadout",
	"_pos",
	"_dir",
	"_stance",
	"_disabledAiFeatures",
	"_vehicleArray",
	"_building",
	"_buildingStatus",
	"_sphereSizeUnit",
	"_sphereBackDistanceUnit",
	"_sphereDespawnDistanceUnit",
	"_checkVisibilityUnit",
	"_forceSpawnDistanceUnit",
	["_tickets", 1]
];

private _maxUnitsPerDistance = _logic getVariable [QGVAR(maxUnitsPerdistance), 1];
private _unitsNear = 0;
{
	private _groupUnitsNearby = [_logic, _x, _pos, _dir] call FUNC(checkSpawnConditions);
	if (_groupUnitsNearby) then {
		_unitsNear = _unitsNear + 1;
	};
	if (_unitsNear >= _maxUnitsPerDistance) exitWith {};
} forEach  units _group;
if (_unitsNear >= _maxUnitsPerDistance) exitWith {
	_units pushBack _unitArray;
	objNull;
};

private _checkBuildings = _logic getVariable [QGVAR(checkBuildings), true];
private _executionCodeUnit = _logic getVariable [QGVAR(executionCodeUnit), {}];

private _spherePos = _pos getPos [_sphereSizeUnit - _sphereBackDistanceUnit, _dir];
private _spherePosASL = ATLtoASL _spherePos;
_spherePosASL set [2, (ATLtoASL _pos) select 2];
_spherePos = ASLToATL _spherePosASL;
private _nearplayers = _spherePos nearEntities ["allVehicles", _sphereSizeUnit];
private _playerIndex = -1;
if (_checkVisibilityUnit) then {
	private _eyePosCheck = (ATLToASL _pos) vectorAdd [0,0,1.35 + random 0.35];
	_playerIndex = _nearplayers findIf {
		isPlayer _x && {
		!(vehicle _x isKindOf "AIR") && {
		([_x, "VIEW"] checkVisibility [_eyePosCheck, eyepos _x]) > 0
	}}};
	if (_playerIndex == -1) then {
		private _sphereSizeForce = (_sphereSizeUnit * _forceSpawnDistanceUnit) max _sphereBackDistanceUnit*2;
		private _spherePosForce = _pos getPos [_sphereSizeForce - _sphereBackDistanceUnit, _dir];
		private _spherePosASLForce = ATLtoASL _spherePosForce;
		_spherePosASLForce set [2, (ATLtoASL _pos) select 2];
		_spherePosForce = ASLToATL _spherePosASLForce;
		private _nearplayers = _spherePosForce nearEntities ["allVehicles", _sphereSizeForce];
		_playerIndex = _nearplayers findIf {isPlayer _x && {!(vehicle _x isKindOf "AIR")}};
	};
} else {
	_playerIndex = _nearplayers findIf {isPlayer _x && {!(vehicle _x isKindOf "AIR")}};
};
if (_playerIndex == -1) exitWith {
	_units pushBack _unitArray;
	objNull
};
if !(_vehicleArray isEqualTo []) then {
	_vehicleArray params ["_vehicle", "_role", "_cargoIndex", "_vehicleIndex"];
	if (alive _vehicle) then {
		// check if vehicle is static and _checkBuildings option is set
		if (
			_checkBuildings && {
			_vehicle isKindOf "StaticWeapon" &&
			{!(alive _building isEqualTo _buildingStatus)}
		}) exitWith {};
		_unit = [_group, _type, _pos, _dir, 0, false] call EFUNC(common,spawnAI);
		_group addVehicle _vehicle;
		[_unit, _vehicle, _role, _cargoIndex] call EFUNC(common,moveInVehicleRole);
	};
} else {
	if (!_checkBuildings || alive _building isEqualTo _buildingStatus) then {
		_unit = [_group, _type, _pos, _dir] call EFUNC(common,spawnAI);
		_unit setUnitPos _stance;
	};
};

if !(_unit isEqualTo objNull) then {
	_unit setVariable [QGVAR(unitArray), _unitArray];
	_unit setVariable [QGVAR(groupID), _groupID];
	_unit setVariable [QGVAR(side), _side];
	_unit setVariable [QGVAR(logic), _logic];
	_unit setVariable [QGVAR(pos), _pos];
	_unit setVariable [QGVAR(dir), _dir];
	_unit setVariable [QGVAR(tickets), _tickets];

	[_unit] call FUNC(addEH);
	[_unit] call FUNC(despawnLoop);
	[_unit] call EFUNC(unitwiggle,init);
	[_unit] call EFUNC(supressHide,init);

	_unit setUnitLoadout _loadout;

	[_unit, "PATH"] remoteExecCall ["disableAI", 0, _unit];
	{
		[_unit, _x] remoteExecCall ["disableAI", 0, _unit];
	} forEach _disabledAiFeatures;

	[_unit] call _executionCodeUnit;
};

_unit
