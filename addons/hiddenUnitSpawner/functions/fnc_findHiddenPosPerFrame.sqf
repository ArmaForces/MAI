#include "script_component.hpp"

params [["_pos", [0,0,0]], ["_group", grpNull], ["_type", "B_Soldier_F"], ["_loadout", []], ["_tickets", 1], ["_maxDistance", 500], ["_minDistance", 100], ["_nearObjects", [objNull]], ["_players", []]];
// check loop
if (_players isEqualTo [] || _nearObjects isEqualTo []) exitWith {
	//systemChat format ["retry, %1", _minDistance];
	[
		{_this call FUNC(findHiddenPos)},
		[_pos, _group, _type, _loadout, _tickets, _maxDistance, _minDistance + 50]
	] call CBA_fnc_execNextFrame;
};
private _objPos = getposATL (_nearObjects deleteAt floor random count _nearObjects);
private _posInBlacklist = [_objPos] call FUNC(mapPosCheck);

private _nextFrameParams = [_pos, _group,  _type, _loadout, _tickets, _maxDistance, _minDistance, _nearObjects, _players];

if (_posInBlacklist) exitWith {
	[
		{_this call FUNC(findHiddenPosPerFrame)},
		_nextFrameParams
	] call CBA_fnc_execNextFrame;
};
// check if there is dead unit from group nearby, if true check another locationNull
private _deadUnitsNearby = false;
{
	if ([_x] call FUNC(checkNearDeadUnit)) exitWith {
		_deadUnitsNearby = true;
	};
} forEach units _group;
if (_deadUnitsNearby) exitWith {
	[
		{_this call FUNC(findHiddenPosPerFrame)},
		_nextFrameParams
	] call CBA_fnc_execNextFrame;
};
// check if pos was under fire by explosive ammo

private _explosionsNearby = [_objPos] call FUNC(checkNearExplosions);
if (_explosionsNearby) exitWith {
	[
		{_this call FUNC(findHiddenPosPerFrame)},
		_nextFrameParams
	] call CBA_fnc_execNextFrame;
};

// check pos
private _averagePos = [_players] call FUNC(getAveragePos);
private _dirToUnit = _averagePos getDir _objPos;
_objPos = _objPos getPos [1, _dirToUnit];
private _position = _objPos findEmptyPosition [1,5,"B_Soldier_F"];
if (_position isEqualTo []) exitWith {
	[
		{_this call FUNC(findHiddenPosPerFrame)},
		_nextFrameParams
	] call CBA_fnc_execNextFrame;
};
private _eyePosition = _position vectorAdd [0,0,1];
private _posVisible = false;
{
	private _distance = _x distance _position;
	if (_distance < _minDistance) exitWith {_posVisible = true};
	private _visibility = [vehicle player, "VIEW"] checkVisibility [eyePos _x, _eyePosition];
	if (_visibility > 0.5) exitWith {_posVisible = true};
} forEach _players;
if (_posVisible) exitWith {
	[
		{_this call FUNC(findHiddenPosPerFrame)},
		_nextFrameParams
	] call CBA_fnc_execNextFrame;
};
// spawn unit
private _newUnit = [_group, _type, _position, _position getDir _averagePos] call MAI_fnc_spawnAI;
if !(_loadout isEqualTo []) then {
	_newUnit setUnitLoadout _loadout;
};
[_newUnit, _tickets - 1] call FUNC(hiddenPosEH);