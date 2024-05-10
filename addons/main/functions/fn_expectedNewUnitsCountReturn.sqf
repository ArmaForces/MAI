 /*
	MAI_fnc_expectedNewUnitsCountReturn

	Description:
		

	Arguments:
		0: Number	<GROUP>

	Return Value:

*/
params [["_unitsCountChange", 0]];
private _expectedNewUnitsCount = missionNameSpace getVariable [QGWAR(expectedNewUnitsCount), 0];
GWAR(expectedNewUnitsCount) = _expectedNewUnitsCount + _unitsCountChange;