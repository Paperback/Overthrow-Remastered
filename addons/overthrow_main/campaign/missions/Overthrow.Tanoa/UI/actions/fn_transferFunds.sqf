closeDialog 0;
private _idx = lbCurSel 1500;
inputData = lbData [1500,_idx];
inputHandler = {
	_val = parseNumber(ctrltext 1400);
	_cash = server getVariable ["money",0];
	if(_val > _cash) then {_val = _cash};
	if(_val > 0) then {
		[-_val] call OT_fnc_resistanceFunds;
		_player = objNull;
		private _uid = inputData;
		{
		    if(getplayeruid _x == _uid) exitWith {_player = _x};
		}foreach(allplayers);
		if !(isNull _player) then {
			[_val] remoteExec ["money",_player,false];
		}else{
			private _money = [_uid,"money"] call OT_fnc_getOfflinePlayerAttribute;
			[_uid,"money",_money+_val] call OT_fnc_setOfflinePlayerAttribute;
		};
		format["Transferred $%1 resistance funds to %2",[_val, 1, 0, true] call CBA_fnc_formatNumber,server getvariable [format["name%1",_uid],"player"]] call notify_minor;
	};
};

["How much to send to this player?",1000] spawn inputDialog;