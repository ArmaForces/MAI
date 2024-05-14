#include "script_component.hpp"

params [["_unit", objNull]];
private _animationState = animationState _unit;
private _animsLeft = [
	"aadjpercmstpsraswrfldleft",
	"aadjpknlmstpsraswrfldleft",
	"aadjppnemstpsraswrfldleft",
	"aadjpercmstpsraswpstdleft",
	"aadjpknlmstpsraswpstdleft",
	"aadjppnemstpsraswpstdleft"
];
private _animsRight = [
	"aadjpercmstpsraswrfldright",
	"aadjpknlmstpsraswrfldright",
	"aadjppnemstpsraswrfldright",
	"aadjpercmstpsraswpstdright",
	"aadjpknlmstpsraswpstdright",
	"aadjppnemstpsraswpstdright"
];
if (_animationState in _animsLeft) exitWith {
	"LEFT"
};
if (_animationState in _animsRight) exitWith {
	"RIGHT"
};
""