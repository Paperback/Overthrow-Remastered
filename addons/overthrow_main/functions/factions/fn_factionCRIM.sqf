["faction_crim_loop","_counter%10 isEqualTo 0","
{
    _pop = server getVariable [format[""population%1"",_x],0];
    _stability = server getVariable [format[""stability%1"",_x],0];
    _idents = OT_civilians getVariable [format[""civs%1"",_x],[]];
    _town = _x;
    _townpos = server getVariable _town;
    {
        _civ = OT_civilians getVariable [format[""%1"",_x],[]];
        _civid = _x;
        if(count _civ isEqualTo 0) then {
            _cash = round(random 200);
            _civ = [call OT_fnc_randomLocalIdentity,true,_cash,-1];
            OT_civilians setVariable [format[""%1"",_civid],_civ,true];
        }else{
            _civ params [""_identity"",""_hasjob"",""_cash"",""_superior""];
            if(isNil ""_superior"") then {_superior = -1};
            if (!_hasjob && _cash < 15 && _superior isEqualTo -1) then {
                [_civid,_town] call OT_fnc_formOrJoinGang;
            };
        };
    }foreach(_idents);
}foreach(OT_allTowns);
"] call OT_fnc_addActionLoop;
