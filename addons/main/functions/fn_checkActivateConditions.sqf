 /*
	MAI_fnc_checkActivateConditions

	Description:
		

	Arguments:
		0: 

	Return Value:
		

*/

params [
	["_logic",objNull,[objNull]]
];

if (_logic isEqualTo objNull) exitWith {
	diag_log text "[MAI - checkActiveConditions] logic is objNull, exit script";
	false
};

// check if player is in minimal distance
private _activationDistance = _logic getVariable [QGVAR(activationDistance), 0];
private _includeAir = _logic getVariable [QGVAR(includeAir), false];
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
private _activationTriggers = _logic getVariable [QGVAR(activationTriggers),[]];
if !((_activationTriggers select {!triggerActivated _x}) isEqualTo []) exitWith {false};

// check custom activation code
private _activateCondition = _logic getVariable [QGVAR(activateCondition), {true}];
if !(call _activateCondition) exitWith {false};

// ????
// private _forceActivate = _logic getVariable [QGVAR(forceActivate), false];

// all checks done, activate script

// check if delete triggers after activation
private _deleteTrigger = _logic getVariable [QGVAR(deleteTrigger), false];
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
