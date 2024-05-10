#include "script_component.hpp"

params [["_unit", objNull]];
_unit addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	[_projectile] call FUNC(EHprojectileExploded);
}];