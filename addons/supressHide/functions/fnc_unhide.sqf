params [["_unit", objNull]];

_unit setVariable ["AF_unitHidden", false];
private _unitPos = _unit getVariable ["AF_unitStanceHide", "Up"];
_unit setUnitPos _unitPos;