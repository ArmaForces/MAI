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

params [
	["_logic", objNull],
	["_activationTriggers", []],
	["_groups", []],
	["_includeAir", false],
	["_forceActivate", true],
	["_checkBuildings", true],
	["_activateCondition", {true}],
	["_executionCodeUnit", {}],
	["_executionCodeGroup", {}],
	["_maxUnitsPerdistance", 1],
	["_tickets", 1]
];

if (_logic isEqualTo objNull) exitWith {};
_logic setVariable [QEGVAR(main, activationTriggers), _activationTriggers];
_logic setVariable [QGVAR(groups), _groups];
_logic setVariable [QEGVAR(main, includeAir), _includeAir];
_logic setVariable [QGVAR(forceActivate), _forceActivate];
_logic setVariable [QGVAR(checkBuildings), _checkBuildings];
_logic setVariable [QEGVAR(main, activateCondition), _activateCondition];
_logic setVariable [QGVAR(executionCodeUnit), _executionCodeUnit];
_logic setVariable [QGVAR(executionCodeGroup), _executionCodeGroup];
_logic setVariable [QGVAR(maxUnitsPerdistance), _maxUnitsPerdistance];
_logic setVariable [QGVAR(tickets), _tickets];

[_logic] call FUNC(loop);
