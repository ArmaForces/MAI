#include "script_component.hpp"

params [["_posX", 0], ["_posY", 0], ["_offsetX", -1], ["_offsetY", -1], ["_players", []]];
[_posX + _offsetX, _posY + _offsetY, true] call AF_fnc_mapPosPushback;
_offsetY = _offsetY + 1;
if (_offsetY > 1) then {
	_offsetY = -1;
	_offsetX = _offsetX + 1;
};
if (_offsetX > 1) exitWith {
	[
		{_this call AF_fnc_mapPosCheckLoop},
		[_players]
	] call CBA_fnc_execNextFrame;
};
[
	{_this call AF_fnc_mapPosCheckPosLoop},
	[_posX, _posY, _offsetX, _offsetY, _players]
] call CBA_fnc_execNextFrame;