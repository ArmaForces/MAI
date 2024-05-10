#include "script_component.hpp"

params [["_unit", objNull]];
systemChat str _this;
_unit setVariable [QGVAR(unitLoadout), getUnitLoadout _unit];