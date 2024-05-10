#include "script_component.hpp"

params [["_pos", [0,0,0]]];
_pos = _pos vectorMultiply 1/50;
[floor (_pos select 0), floor (_pos select 1)]