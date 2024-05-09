#include "script_component.hpp"

params [["_units", []]];
private _averagePos = [0,0,0];
Private _unitsAmount = count _units;
if (_unitsAmount == 0) exitWith {_averagePos};
{
	_averagePos = _averagePos vectorAdd getposATL _x;
} forEach _units;
_averagePos vectorMultiply (1/_unitsAmount);	