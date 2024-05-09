#include "script_component.hpp"

params [["_mapBlacklist", []], ["_distance", 750]];
if (_mapBlacklist isEqualTo []) exitWith {
	_mapBlacklist = + AF_mapBlacklist;
	[
		{_this call AF_fnc_mapPosCleanup},
		[_mapBlacklist, _distance]
	] call CBA_fnc_execNextFrame;
};
private _posArray = _mapBlacklist select 0;
private _posX = _posArray select 0;
private _posYArray = _posArray select 1;
private _posY = _posYArray deleteAt 0;
if (count _posYArray <= 0) then {
	_mapBlacklist deleteAt 0;
};
private _posCenter = [[_posX, _posY]] call AF_fnc_mapPosUncompress;
private _nearPlayers = _posCenter nearEntities ["allVehicles", 750] select {isPlayer _x};
if (_nearPlayers isEqualTo []) then {
	[_posX, _posY] call AF_fnc_mapPosDelete;
};
[
	{_this call AF_fnc_mapPosCleanup},
	[_mapBlacklist, _distance]
] call CBA_fnc_execNextFrame;