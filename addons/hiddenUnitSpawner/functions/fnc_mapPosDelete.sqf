#include "script_component.hpp"

params [["_posX", 0], ["_posY", 0]];
private _findX = GVAR(mapBlacklist) findIf {_x select 0 == _posX};
if (_findX == -1) exitWith {};
private _posXarray = GVAR(mapBlacklist) select _findX;
private _posYarray = _posXarray select 1;
private _findY = _posYarray findIf {_x == _posY};
_posYarray deleteAt _findY;
if (_posYarray isEqualTo []) then {
	GVAR(mapBlacklist) deleteAt _findX;
};

if (AF_debug) then {
	deleteMarkerLocal format ["%1-%2", _posX, _posY];
};