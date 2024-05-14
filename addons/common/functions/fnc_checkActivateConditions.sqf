 /*
	MAI_fnc_checkActivateConditions

	Description:
		

	Arguments:
		0: 

	Return Value:
		

*/
#include "script_component.hpp"

params [
	["_logic",objNull,[objNull]],
	["_activationDistance", 0],
	["_includeAir", false],
	["_activationTriggers", []],
	["_activateCondition", {true}],
	["_deleteTrigger", false]
];

if (_logic isEqualTo objNull) exitWith {
	diag_log text "[MAI - checkActiveConditions] logic is objNull, exit script";
	false
};

// check if players are is in minimal distance
private _activateByDistance = true;

if (_activationDistance > 0) then {
	private _nearUnits = _logic nearEntities ["AllVehicles", _activationDistance];
	if (_includeAir) then {
		_activateByDistance = ((_nearUnits findIf {isPlayer _x}) != -1);
	} else {
		_activateByDistance = ((_nearUnits findIf {isPlayer _x && {!(_x isKindOf "Air")}}) != -1);
	};
};
if !(_activateByDistance) exitWith {false};

// check synchronized triggers
if !((_activationTriggers select {!triggerActivated _x}) isEqualTo []) exitWith {false};

// check custom activation code
if !(call _activateCondition) exitWith {false};

// all checks done, activate script

// check if delete triggers after activation
if (_deleteTrigger) then {
	[
		{
			{deleteVehicle _x} forEach _this;
		},
		_activationTriggers,
		5
	] call CBA_fnc_waitAndExecute;
};

true
