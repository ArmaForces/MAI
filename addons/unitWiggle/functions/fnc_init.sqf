#include "script_component.hpp"

params [["_unit", objNull], ["_distance", 1], ["_interval", 3], ["_adjustInterval", 3], ["_respawnDelay", [5,30,60]], ["_minDistance", 35]];
if (!alive _unit) exitWith {};

_unit disableAI "PATH";
_unit disableAI "FSM";
// disable lambs
_unit setVariable ["lambs_danger_disableAI", true];
if (isFormationLeader _unit) then {
	group _unit setVariable ["lambs_danger_disableGroupAI", true];
};

private _unitPos = getposATL _unit;
_unit setVariable [QGVAR(unitPos), _unitPos];

private _unitDir = getDir _unit;
_unit setVariable [QGVAR(unitDir), _unitDir];

private _unitPosL = _unit modelToWorld [- _distance, 0, 0];
private _unitPosR = _unit modelToWorld [_distance, 0, 0];
_unit setVariable [QGVAR(unitMovePos), [_unitPosL, _unitPosR]];

_unit setVariable [QGVAR(stance), unitPos _unit];
_unit setVariable [QGVAR(distance), _distance];
_unit setVariable [QGVAR(minDistance), _minDistance];
_unit setVariable [QGVAR(adjustInterval), _adjustInterval];
_unit setVariable [QGVAR(interval), _interval];
_unit setVariable [QGVAR(respawnDelay), _respawnDelay];

_unit setVariable [QGVAR(group), group _unit];
_unit setVariable [QGVAR(loadout), getUnitLoadout _unit];

if (_distance >= 0.1) then {
	[_unit] call FUNC(mainLoop);
};

if (_adjustInterval > 0) then {
	[_unit] call FUNC(adjustStanceLoop);
};