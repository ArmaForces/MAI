#include "script_component.hpp"

params [["_unit", objNull]];

_unit setVariable [QGVAR(unitLoadout), getUnitLoadout _unit];
[
	{
		_this setVariable [QGVAR(unitLoadout), getUnitLoadout _this];
	},
	_unit,
	1
] call CBA_fnc_waitAndExecute;