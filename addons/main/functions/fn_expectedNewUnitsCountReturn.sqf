 /*
	MAI_fnc_expectedNewUnitsCountReturn

	Description:
		

	Arguments:
		0: Number	<GROUP>

	Return Value:

*/
params [["_unitsCountChange", 0]];
private _expectedNewUnitsCount = missionNameSpace getVariable [QGVAR(expectedNewUnitsCount), 0];
GVAR(expectedNewUnitsCount) = _expectedNewUnitsCount + _unitsCountChange;