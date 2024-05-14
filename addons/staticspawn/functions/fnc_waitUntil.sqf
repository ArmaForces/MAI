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

params [["_logic",objNull]];

if (_logic isEqualTo objNull) exitWith {};

private _activate = [_logic] call MAI_fnc_checkActivateConditions;

if (_activate) then {
	private _groups = _logic getVariable [QEGVAR(main,groups), []];

	// if (!isServer && !hasInterface) exitWith {
	// 	[_logic, _groups] call FUNC(staticspawnInterval);
	// };

	private _activationTriggers = _logic getVariable [QEGVAR(main,activationTriggers) ,[]];
	private _includeAir = _logic getVariable [QEGVAR(main,includeAir), false];
	private _forceActivate = _logic getVariable [QGVAR(forceActivate), false];
	private _checkBuildings = _logic getVariable [QGVAR(checkBuildings), true];
	private _activateCondition = _logic getVariable [QEGVAR(main,activateCondition), {true}];
	private _executionCodeUnit = _logic getVariable [QGVAR(executionCodeUnit), {}];
	private _executionCodeGroup = _logic getVariable [QGVAR(executionCodeGroup), {}];
	private _maxUnitsPerdistance = _logic getVariable [QGVAR(maxUnitsPerdistance), 1];
	private _tickets = _logic getVariable [QGVAR(tickets), 1];

	private _owner = call MAI_fnc_HCfind;
	[
		_logic,
		_activationTriggers,
		_groups,
		_includeAir,
		_forceActivate,
		_checkBuildings,
		_activateCondition,
		_executionCodeUnit,
		_executionCodeGroup,
		_maxUnitsPerdistance,
		_tickets
	] remoteExecCall [QFUNC(firstState),_owner,false];
} else {
	[{_this call QFUNC(WaitUntil)},
	_this,
	0.9 + random 0.2
	] call CBA_fnc_waitAndExecute;
};

Nil
