#include "script_component.hpp"

params [["_pos", [0,0,0]]];
_pos = _pos vectorMultiply 50;
[(_pos select 0) + 25, (_pos select 1) + 25]