#include "script_component.hpp"
/*
 * Author: Madin5
 * <Description>
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * <Example>
 *
 * Public: No
 */

params [["_unit", objNull], ["_suppressedTime", 30]];
_unit setVariable ["AF_suppressedTime", _suppressedTime];

// disable lambs
_unit setVariable ["lambs_danger_disableAI", true];
if (isFormationLeader _unit) then {
	group _unit setVariable ["lambs_danger_disableGroupAI", true];
};

if (unitPos _unit == "Auto") then {
	_unit setUnitPos "Up";
};

[_unit, _suppressedTime] call FUNC(EH);
