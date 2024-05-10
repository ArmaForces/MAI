#include "script_component.hpp"

params [["_projectile", objNull]];

_projectile addEventHandler ["Explode", {
	params ["_projectile", "_pos", "_velocity"];
	private _ammo = typeOf _projectile;
	private _indirectHit = getNumber (configfile >> "CfgAmmo" >> _ammo >> "indirectHit");
	private _indirectHitRange = getNumber (configfile >> "CfgAmmo" >> _ammo >> "indirectHitRange");
	private _killRadius = _indirectHitRange + _indirectHit * 0.35 min _indirectHitRange*4;
	if (_killRadius < 1) exitWith {};
	GVAR(explosionList) pushBack [_pos, _killRadius];

	// quick antispam failsafe
	if (count GVAR(explosionList) > 200) then {
		GVAR(explosionList) deleteAt 0;
	};

	// delete entry after _killRadius as seconds
	[
		{
			private _index = GVAR(explosionList) findIf {_x isEqualTo _this};
			if (_index <= -1) exitWith {};
			GVAR(explosionList) deleteAt _index;
		},
		[_pos, _killRadius],
		_killRadius
	] call CBA_fnc_waitAndExecute;
}];

// handle subammunition
_projectile addEventHandler ["SubmunitionCreated", {
	params ["_projectile", "_submunitionProjectile", "_pos", "_velocity"];
	_submunitionProjectile call FUNC(EHprojectileExploded);
}];