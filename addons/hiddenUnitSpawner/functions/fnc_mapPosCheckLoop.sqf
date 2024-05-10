#include "script_component.hpp"

params [["_players", []]];
if (_players isEqualTo []) then {
	_players = allPlayers
};

private _player = _players deleteAt 0;
private _posCompressed = [getposATL _player] call FUNC(mapPosCompress);
private _posX = _posCompressed select 0;
private _posY = _posCompressed select 1;
[_posX, _posY, -1, -1, _players] call FUNC(mapPosCheckPosLoop);