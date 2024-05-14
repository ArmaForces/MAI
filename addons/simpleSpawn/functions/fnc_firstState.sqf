 /*
	MAI_fnc_simpleSpawnFirstState

	Description:
		wait until Resp Point condition meet to start script

	Arguments:
		0: Logic <OBJECT>
		1: 

	Return Value:
		None

*/

params [
	["_logic", objNull],
	"_activationTriggers",
	["_groups", []],
	["_vehiclesInfo", []],
	["_interval", 0.1],
	["_unitsPerInterval", 1],
	["_deleteVehicles", false],
	["_activationDistance", 750],
	["_deactivation", -1],
	["_includeAir", false],
	["_forceActivate", true],
	["_checkBuildings", true],
	["_activateCondition", {true}],
	["_executionCodeUnit", {}],
	["_executionCodePatrol", {}],
	["_executionCodeVehicle", {}]
];

if (_logic isEqualTo objNull) exitWith {};
_logic setVariable [QGVAR(activationTriggers), _activationTriggers];
_logic setVariable [QGVAR(groups), _groups];
_logic setVariable [QGVAR(vehiclesInfo), _vehiclesInfo];
_logic setVariable [QGVAR(activationDistance), _activationDistance];
_logic setVariable [QGVAR(deactivation), _deactivation];
_logic setVariable [QGVAR(includeAir), _includeAir];
_logic setVariable [QGVAR(forceActivate), _forceActivate];
_logic setVariable [QGVAR(checkBuildings), _checkBuildings];
_logic setVariable [QGVAR(activateCondition), _activateCondition];
_logic setVariable [QGVAR(interval), _interval];
_logic setVariable [QGVAR(deleteVehicles), _deleteVehicles];
_logic setVariable [QGVAR(unitsPerInterval), _unitsPerInterval];
_logic setVariable [QGVAR(executionCodeUnit), _executionCodeUnit];
_logic setVariable [QGVAR(executionCodePatrol), _executionCodePatrol];
_logic setVariable [QGVAR(executionCodeVehicle), _executionCodeVehicle];

[_logic, _groups, _vehiclesInfo] call call FUNC(interval);