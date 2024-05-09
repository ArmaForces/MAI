#include "script_component.hpp"

[
	{
		params [["_unit", objNull], ["_tickets", 3]];
		{
			[_x, _tickets] call AF_fnc_hiddenPosEH;
		} forEach units group _unit;
	},
	_this,
	1
] call CBA_fnc_waitAndExecute;