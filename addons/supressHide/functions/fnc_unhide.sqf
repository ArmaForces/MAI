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

params [["_unit", objNull]];

_unit setVariable [QGVAR(unitHidden), false];
private _unitPos = _unit getVariable [QGVAR(unitStanceHide), "Up"];
_unit setUnitPos _unitPos;
