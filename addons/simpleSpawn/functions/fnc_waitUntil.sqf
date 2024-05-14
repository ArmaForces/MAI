#include "script_component.hpp"
 /*
	mai_fnc_simpleSpawnWaitUntil

	Description:
		wait until Resp Point condition meet to start script

	Arguments:
		0: Logic <OBJECT>
		1: 

	Return Value:
		None

*/
params [["_logic",objNull]];

if (_logic isEqualTo objNull) exitWith {};

private _activate = [_logic] call FUNC(checkActivateConditions);

if !(_activate) exitWith {
	[{_this call FUNC(waitUntil)},
	_this,
	0.9 + random 0.2
	] call CBA_fnc_waitAndExecute;
};

private _groups = _logic getVariable [QGVAR(groups), []];
private _vehiclesInfo = _logic getVariable [QGVAR(vehiclesInfo) ,[]];

// if (!isServer && !hasInterface) exitWith {
// 	[_logic, _groups, _vehiclesInfo] call FUNC(interval);
// };

private _activationTriggers = _logic getVariable [QGVAR(activationTriggers) ,[]];
private _interval = _logic getVariable [QGVAR(interval) ,[]];
private _unitsPerInterval = _logic getVariable [QGVAR(unitsPerInterval), []];
private _deleteVehicles = _logic getVariable [QGVAR(deleteVehicles), false];
private _activationDistance = _logic getVariable [QGVAR(activationDistance), 750];
private _deactivation = _logic getVariable [QGVAR(deactivation), -1];
private _includeAir = _logic getVariable [QGVAR(includeAir), false];
private _forceActivate = _logic getVariable [QGVAR(forceActivate), false];
private _checkBuildings = _logic getVariable [QGVAR(checkBuildings), true];
private _activateCondition = _logic getVariable [QGVAR(activateCondition), {true}];
private _executionCodeUnit = _logic getVariable [QGVAR(executionCodeUnit), {}];
private _executionCodePatrol = _logic getVariable [QGVAR(executionCodePatrol), {}];
private _executionCodeVehicle = _logic getVariable [QGVAR(executionCodeVehicle), {}];

private _owner = call EFUNC(common,HCfind);

[
	_logic,
	_activationTriggers,
	_groups,
	_vehiclesInfo,
	_interval,
	_unitsPerInterval,
	_deleteVehicles,
	_activationDistance,
	_deactivation,
	_includeAir,
	_forceActivate,
	_checkBuildings,
	_activateCondition,
	_executionCodeUnit,
	_executionCodePatrol,
	_executionCodeVehicle
] remoteExecCall [QFUNC(FirstState),_owner, false];
Nil