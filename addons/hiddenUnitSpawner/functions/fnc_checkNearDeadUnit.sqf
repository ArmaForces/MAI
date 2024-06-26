#include "script_component.hpp"

// return true if unit is dead and closer than 25m
params [["_pos", [0,0,0]], ["_unit", objNull]];
if (alive _unit) exitWith {false};
if (_pos distance _unit < 25) exitWith {true};
false