#include "script_component.hpp"

params [["_unit", objNull], ["_moveToPos", [0,0,0]], ["_direction", 0], ["_walkType", ""]];
_unit setDir _direction;
_unit disableAI "MOVE";
_unit playActionNow _walkType;
private _distance = (getposATL _unit) distance2D _moveToPos;
[
	{
		_this call FUNC(MoveStop);
	},
	[_unit],
	(random _distance * 0.75) min 2
] call CBA_fnc_waitAndExecute;