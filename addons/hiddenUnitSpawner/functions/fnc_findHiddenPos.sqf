#include "script_component.hpp"

params [["_pos", [0,0,0]], ["_group", grpNull], ["_type", "B_Soldier_F"], ["_loadout", []], ["_tickets", 1], ["_maxDistance", 500], ["_minDistance", 50]];
if (units _group isEqualTo []) exitWith {
	// no group or no units in group, exit
};
private _players = allPlayers select {_x distance _pos < _maxDistance};
if (_players isEqualTo []) then {_players = allPlayers};
private _averagePosUnitGroup = [units _group] call FUNC(getAveragePos);
if (_averagePosUnitGroup isEqualTo [0,0,0]) then {_averagePosUnitGroup = _pos};
private _averagePosPlayers = [_players] call FUNC(getAveragePos);
private _dirToUnit = _averagePosPlayers getDir _averagePosUnitGroup;
private _centerPos = _averagePosUnitGroup getPos [_minDistance , _dirToUnit];
_centerPos = _centerPos vectorAdd [_minDistance/2 - random _minDistance, _minDistance/2 - random _minDistance, 0];
_nearObjects = nearestTerrainObjects [_centerPos, ["Tree", "Bush", "ROCK"], 75, false];
// if (_nearObjects isEqualTo []) exitWith {};
[_pos, _group,  _type, _loadout, _tickets, _maxDistance, _minDistance, _nearObjects, _players] call FUNC(findHiddenPosPerFrame);
