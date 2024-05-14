 /*
	MAI_fnc_simpleSpawnDespawn

	Description:
		Despawn units

	Arguments:
		0: Logic <OBJECT>
		1: 

	Return Value:
		None

*/

params [
	["_logic", objNull, [objNull]]
];

if (_logic isEqualTo objNull) exitWith {};

private _spawnedGroups = _logic getVariable [QGVAR(spawnedGroups), []];
// check for every group if there are any allive units.
private _aliveGroupIndex = _spawnedGroups findIf {
	(units _x findIf {alive _x}) != -1
};
if (_aliveGroupIndex == -1) exitWith {}; // no alive units left.

private _activationDistance = _logic getVariable [QGVAR(activationDistance), 750];
private _deactivation = _logic getVariable [QGVAR(deactivation), 750];
private _deactivationDistance = _activationDistance + _deactivation;

private _nearUnits = _logic nearEntities ["AllVehicles", _deactivationDistance];

private _playersNear = (_nearUnits findIf {isPlayer _x && {alive _x}}) != -1;

private _activateByDistance = ((_nearUnits findIf {isPlayer _x}) != -1);

if !(_activateByDistance) exitWith {
	{
		{
			if (alive _x && stance _x == "STAND") then {
				[_x,"AmovPercMstpSrasWrflDnon_AinvPknlMstpSlayWrflDnon"] remoteExecCall ["switchMove", 0];
			};
		} forEach units _x;
	} forEach _spawnedGroups;
	[
		{
			params [["_logic", objNull, [objNull]]];
			private _spawnedGroups = _logic getVariable [QGVAR(spawnedGroups), []];
			private _groupsArray = [_spawnedGroups] call FUNC(getGroups);
			_groupsArray params ["_groups", "_vehiclesInfo", "_vehiclesToDelete"];
			_logic setVariable [QGVAR(groups), _groups];
			_logic setVariable [QGVAR(vehiclesInfo), _vehiclesInfo];
			private _vehicles = _logic getVariable [QGVAR(vehicles), []];
			{
				deleteVehicle _x;
			} forEach _vehicles;
			_logic setVariable [QGVAR(vehicles), nil];
			[
				{_this call FUNC(WaitUntil)},
				_this,
				random [0.9,1,1.1]
			] call CBA_fnc_waitAndExecute;
		},
		_this,
		0.5
	] call CBA_fnc_waitAndExecute;
};

[
	{_this call call FUNC(despawn)},
	_this,
	random [0.9,1,1.1]
] call CBA_fnc_waitAndExecute;

Nil