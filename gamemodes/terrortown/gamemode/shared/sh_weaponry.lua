---
-- This is the <code>WEPS</code> module
-- @module WEPS
-- @author BadKingUrgrain
-- @author Alf21
-- @author LeBroomer
WEPS = {}

local IsValid = IsValid

---
-- Get the type (<code>kind</code>) of a weapon class
-- @str class weapon class
-- @treturn boolean weapon type (<code>kind</code>)
function WEPS.TypeForWeapon(class)
	local tbl = util.WeaponForClass(class)

	return tbl and tbl.Kind or WEAPON_NONE
end

---
-- Checks whether the table is a valid equipment (weapon)
-- @tab wep table that needs to be checked
-- @treturn boolean whether the table is a valid equipment (weapon)
function WEPS.IsEquipment(wep)
	return wep and wep.Kind and wep.Kind >= WEAPON_EQUIP
end

---
-- Get the class of the weapon
-- @param wep (@{WEAPON})
-- @treturn nil|string weapon's class
function WEPS.GetClass(wep)
	if type(wep) == "table" then
		return wep.ClassName or wep.Classname or wep.id or wep.name
	elseif IsValid(wep) then
		return wep:GetClass()
	end
end

---
-- Toggles the <code>disguised</code>
-- @param ply (<a href="https://wiki.garrysmod.com/page/Category:Player">Player</a>)
function WEPS.DisguiseToggle(ply)
	if IsValid(ply) and ply:IsActiveTraitor() then
		if not ply:GetNWBool("disguised", false) then
			RunConsoleCommand("ttt_set_disguise", "1")
		else
			RunConsoleCommand("ttt_set_disguise", "0")
		end
	end
end
concommand.Add("ttt_toggle_disguise", WEPS.DisguiseToggle)
