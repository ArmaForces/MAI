#include "script_component.hpp"

params ["_unit", "_killer", "_instigator", "_useEffects"];
private _tickets = _unit getVariable [QGVAR(tickets), 1];
systemChat str _tickets;
if (_tickets <= 1) exitWith {};
private _unitLoadout = _unit getVariable [QGVAR(unitLoadout), []];
[getposATL _unit, group _unit, typeOf _unit, _unitLoadout, _tickets, 5000] call FUNC(findHiddenPos);