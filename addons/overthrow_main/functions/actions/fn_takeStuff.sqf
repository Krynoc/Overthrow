// _unit may be non-local
private ["_unit","_t"];

_unit = _this select 0;
_t = _this select 1;

if(vest _unit != "") then {
	_t addVest vest _unit;
};
if(headgear _unit != "") then {
	_t addHeadgear headgear _unit;
};
if(backpack _unit != "") then {
	_t addBackpack (backpack _unit) call BIS_fnc_basicBackpack;
};
if(hmd _unit != "") then {
	_t linkItem hmd _unit;
};

{
	_count = 0;
	_cls = _x select 0;
	while {_count < (_x select 1)} do {
		[_t, _cls] call {
			params ["_t", "_cls"];
			if(_cls isKindOf ["Rifle",configFile >> "CfgWeapons"]) exitWith {
				_unit removeWeaponGlobal _cls;
				_t addWeaponGlobal _cls;
			};
			if(_cls isKindOf ["Launcher",configFile >> "CfgWeapons"]) exitWith {
				_unit removeWeaponGlobal _cls;
				_t addWeaponGlobal _cls;
			};
			if(_cls isKindOf ["Pistol",configFile >> "CfgWeapons"]) exitWith {
				_unit removeWeaponGlobal _cls;
				_t addWeaponGlobal _cls;
			};
			if(_cls isKindOf ["Binocular",configFile >> "CfgWeapons"]) exitWith {
				_unit unassignItem _cls;
				_unit removeWeaponGlobal _cls;
				_t addWeaponGlobal _cls;
			};
			if(_cls isKindOf ["Default",configFile >> "CfgMagazines"]) exitWith {
				_unit removeMagazineGlobal _cls;
				_t addMagazine _cls;
			};
			_unit removeItem _cls;
			_t addItem _cls;
		};
		_count = _count + 1;
	};
}foreach(_unit call OT_fnc_unitStock);

if(vest _unit != "") then {
	removeVest _unit;
};
if(headgear _unit != "") then {
	removeHeadgear _unit;
};
if(backpack _unit != "") then {
	removeBackpackGlobal _unit;
};
if(hmd _unit != "") then {
	_t unlinkItem hmd _unit;
};
if(goggles _unit != "") then {
	_t addGoggles goggles _unit;
	removeGoggles _unit;
};
if(handgunWeapon _unit != "") then {
	_t addWeaponGlobal handgunWeapon _unit;
	{
		_t addItem _x;
	}foreach(handgunItems _unit);
	_unit removeWeaponGlobal handgunWeapon _unit;
};
{
	if(_x != "ItemMap") then {
		if (([(configFile >> "CfgWeapons" >> _x),"useAsBinocular",0] call BIS_fnc_returnConfigEntry) > 0) then {
			_unit unassignItem _x;
			_unit removeWeaponGlobal _x;
			_t addWeaponGlobal _x;
			_t assignItem _x;
		}else{
			_unit unlinkItem _x;
			_t linkItem _x;
		};
	};
}foreach(assignedItems _unit);
