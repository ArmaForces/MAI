#include "script_component.hpp"

params [["_unit", objNull]];
private _posVisual = getPosATLVisual _unit;
private _interval = _unit getVariable [QGVAR(interval), 3];
_unit playActionNow "stop";

[
	{_this enableAI "MOVE";},
	_unit,
	1
] call CBA_fnc_waitAndExecute;

[
	{_this call FUNC(MainLoop)},
	_this,
	random _interval max 1.5
] call CBA_fnc_waitAndExecute;