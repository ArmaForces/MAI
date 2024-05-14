#include "script_component.hpp"

params [["_unit", objNull], ["_stance", ""]];
_unit playActionNow _stance;
_unit setVariable [QGVAR(allowMove), false];
[
	{_this setVariable [QGVAR(allowMove), true]},
	_unit,
	0.4
] call CBA_fnc_waitAndExecute;