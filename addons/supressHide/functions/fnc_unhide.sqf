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

_unit setVariable ["AF_unitHidden", false];
private _unitPos = _unit getVariable ["AF_unitStanceHide", "Up"];
_unit setUnitPos _unitPos;
