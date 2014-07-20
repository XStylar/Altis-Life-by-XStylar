/*
	File: fn_wantedAdd.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Adds or appends a unit to the wanted list.
*/
private["_uid","_type","_index","_data","_crimes","_val","_customBounty","_name"];
_uid = [_this,0,"",[""]] call BIS_fnc_param;
_name = [_this,1,"",[""]] call BIS_fnc_param;
_type = [_this,2,"",[""]] call BIS_fnc_param;
_customBounty = [_this,3,-1,[0]] call BIS_fnc_param;
if(_uid == "" OR _type == "" OR _name == "") exitWith {}; //Bad data passed.

//What is the crime?
switch(_type) do
{
	case "187V": {_type = ["Menschen überfahren",25000]};
	case "187": {_type = ["Mord",75000]};
	case "901": {_type = ["Gefaengnis ausbruch",30000]};
	case "261": {_type = ["Raub",15000]};
	case "261A": {_type = ["Versuchter Raub",7500]};
	case "215": {_type = ["Versuchter Autodiebstahl",1500]};
	case "213": {_type = ["Benutzen von Sprengstoff",10000]};
	case "211": {_type = ["Spieler_ausgeraubt",15000]};
	case "207": {_type = ["Kidnapping",30000]};
	case "207A": {_type = ["Versuchtes Kidnapping",25000]};
	case "487": {_type = ["Autodiebstahl",7500]};
	case "488": {_type = ["Tankstelle_ausgeraubt",7500]};
	case "480": {_type = ["Fahrerflucht",12500]};
	case "481": {_type = ["Drogenbesitz",100000]};
	case "482": {_type = ["Drogenbesitz",20000]};
	case "483": {_type = ["Drogenhandel",30000]};
	case "800": {_type = ["Foltern",4000]};
	case "459": {_type = ["Burglary",6500]};
	
	case "1": {_type = ["Fahren ohne Führerschein/B",1000]};
	case "2": {_type = ["Fahren ohne Führerschein/C",8000]};
    case "3": {_type = ["Fahren ohne Licht",1500]};
    case "4": {_type = ["Gefährliche Fahrweise",2500]};
    case "5": {_type = ["Landen in einer Flugverbotszone",5000]};
    case "6": {_type = ["Fahren von illegalen Fahrzeugen",50000]};
    case "7": {_type = ["Unfallverursacher/Fahrerflucht nach Unfall",2000]};
    case "8": {_type = ["Fahrerflucht vor der Polizei",1500]};
    case "9": {_type = ["Überfahren eines Zivilisten",25000]};
	case "10": {_type = ["Überfahren eines Polizisten",45000]};
    case "11": {_type = ["Widerstand gegen die Staatsgewalt",10000]};
    case "12": {_type = ["Beamtenbeleidigung",2000]};
    case "13": {_type = ["Belästigung eines Polizisten",2500]};
    case "14": {_type = ["Waffenbesitz ohne Lizenz",10000]};
    case "15": {_type = ["Mit gez.Waffe durch Stadt",2500]};
    case "16": {_type = ["Besitz einer verbotenen Waffe",30000]};
    case "17": {_type = ["Schusswaffengebrauch innerhalb Stadt",5000]};
    case "18": {_type = ["Geiselnahme",50000]};
    case "19": {_type = ["Überfall auf Personen/Fahrzeuge",10000]};
    case "20": {_type = ["Bankraub",150000]};
    case "21": {_type = ["Fliegen/Schweben unterhalb 150m ü.Stadt",10000]};
    case "22": {_type = ["Fliegen ohne Fluglizenz",20000]};
	default {_type = [];};
};

if(count _type == 0) exitWith {}; //Not our information being passed...
//Is there a custom bounty being sent? Set that as the pricing.
if(_customBounty != -1) then {_type set[1,_customBounty];};
//Search the wanted list to make sure they are not on it.
_index = [_uid,life_wanted_list] call fnc_index;

if(_index != -1) then
{
	_data = life_wanted_list select _index;
	_crimes = _data select 2;
	_crimes set[count _crimes,(_type select 0)];
	_val = _data select 3;
	life_wanted_list set[_index,[_name,_uid,_crimes,(_type select 1) + _val]];
}
	else
{
	life_wanted_list set[count life_wanted_list,[_name,_uid,[(_type select 0)],(_type select 1)]];
};