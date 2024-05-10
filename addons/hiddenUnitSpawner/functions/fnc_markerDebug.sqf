#include "script_component.hpp"

params [["_posX", 0], ["_posY", 0]]; 
private _markerPos = [[_posX, _posY]] call FUNC(mapPosUncompress);
//_markerPos = _markerPos vectorAdd [25,25,0];
private _marker = createMarkerLocal [format ["%1-%2", _posX, _posY], _markerPos];
_marker setMarkerColorLocal "ColorBlack";
_marker setMarkerShapeLocal "RECTANGLE";
_marker setMarkerSizeLocal [23, 23];
_marker setMarkerAlphaLocal 0.5;
//QGVAR(AF_debugMarkers) pushBack _marker;