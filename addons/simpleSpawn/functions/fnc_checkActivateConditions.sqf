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
#include "script_component.hpp"

params [["_logic",objNull]];

private _activationDistance = _logic getVariable [QGVAR(activationDistance), 750];
private _includeAir = _logic getVariable [QGVAR(includeAir), false];
private _activationTriggers = _logic getVariable [QGVAR(activationTriggers) ,[]];
private _activateCondition = _logic getVariable [QGVAR(activateCondition), {true}];
private _deleteTrigger = _logic getVariable [QGVAR(deleteTrigger), false];

private _activate = [
	_logic,
	_activationDistance,
	_includeAir,
	_activationTriggers,
	_activateCondition,
	_deleteTrigger
] call EFUNC(common,checkActivateConditions);
_activate