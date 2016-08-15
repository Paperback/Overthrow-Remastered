private ["_handled","_player","_civ","_pos","_rnd","_txt"];

_player = _this select 0;
_civ = _this select 1;

_pos = getpos _player;

_rnd = random 100;
_txt = "";
_handled = false;
call {
	if(_rnd > 95) exitWith {
		//Release the vehicle garrison of a nearby objective
		_objective = _pos call nearestObjective;
		_loc = _objective select 0;
		_name = _objective select 1;
		_handled = true;
		
		_garrison = server getvariable format["vehgarrison%1",_name];
		if(count _garrison > 0) then{
			_cls = _garrison call BIS_fnc_selectRandom;
			_vehname = _cls call ISSE_Cfg_Vehicle_GetName;
			_txt = format["I saw a %1 at %2.",_vehname,_name];
		}else{
			_txt = format["I don't know what happened to all the tanks they had over at %1.",_name];
		};	
		_name setMarkerAlpha 1;		
	};
	if(_rnd > 80) exitWith {
		//Release the garrison size of a nearby objective
		_objective = _pos call nearestObjective;
		_loc = _objective select 0;
		_name = _objective select 1;
		_handled = true;
		
		_garrison = server getvariable format["garrison%1",_name];
		
		_txt = format["I saw %1 military guys over at %2.",_garrison,_name];
		_name setMarkerAlpha 1;		
	};
	if(_rnd > 60) exitWith {
		//Release the location of a nearby objective
		_objective = _pos call nearestObjective;
		_loc = _objective select 0;
		_name = _objective select 1;
		_handled = true;
		
		_txt = format["I saw a bunch of military guys over at %1. I'll put it on your map.",_name];
		_name setMarkerAlpha 1;		
	};
	if(_rnd > 40) exitWith {
		//Release the garrison size of this town
		_handled = true;
		_town = _pos call nearestTown;
		_garrison = server getvariable format["garrison%1",_town];
		if(_garrison > 0) then {
			_txt = format["I've seen about %1 Gendarmerie in %2 recently",_garrison,_town];
		}else{
			_txt = "I haven't seen any of those guys in blue for a while";
		};
	};
	//Release the approximate location of a nearby gendarm
	{
		if(side _x == west) exitWith {
			_handled = true;
			_txt = "I saw a guy just now, I'll put it on your map";
			player reveal [(leader group _x),1.5];
		};
	}foreach(_pos nearentities ["Man",250]);
	
};

if !(_handled) then {
	_txt = "I'd love to help you, but I just can't";
};

_civ globalChat _txt;