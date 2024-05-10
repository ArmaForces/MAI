#include "script_component.hpp"

params [["_pos", [0,0,0]], ["_pushback", false]];
private _posCompressed = [_pos] call FUNC(mapPosCompress);
private _posX = _posCompressed select 0;
private _posY = _posCompressed select 1;
[_posX, _posY, _pushback] call FUNC(mapPosPushback);