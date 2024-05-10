#include "script_component.hpp"

params [["_posX", 0], ["_posY", 0], ["_pushback", false]];
private _findX = QGVAR(mapBlacklist) findIf {_x select 0 == _posX};
if (_findX == -1) exitWith {
	if (_pushback) then {
		QGVAR(mapBlacklist) pushBack [_posX, [_posY]];

		if (AF_debug) then {
			[_posX, _posY] call FUNC(markerDebug);
		};
	};
	false
};
private _posXarray = QGVAR(mapBlacklist) select _findX;
private _posYarray = _posXarray select 1;
private _findY = _posYarray findIf {_x == _posY};
if (_findY == -1) exitWith {
	if (_pushback) then {
		_posYarray pushBack _posY;

		if (AF_debug) then {
			[_posX, _posY] call FUNC(markerDebug);
		};
	};
	false
};
true