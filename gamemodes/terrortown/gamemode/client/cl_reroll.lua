-- Credit transfer tab for equipment menu
local GetTranslation = LANG.GetTranslation
local player = player
local ipairs = ipairs
local IsValid = IsValid

function CreateRerollMenu(parent)
	local client = LocalPlayer()

	local dform = vgui.Create("DForm", parent)
	dform:SetName(GetTranslation("reroll_menutitle"))
	dform:StretchToParent(0, 0, 0, 0)
	dform:SetAutoSize(false)

	local cost = GetGlobalInt("ttt2_random_shop_reroll_cost")

	if client:GetCredits() <= 0 then
		dform:Help(LANG.GetParamTranslation("reroll_no_credits", {amount = cost}))

		return dform
	end

	local bw, bh = 100, 20

	local dsubmit = vgui.Create("DButton", dform)
	dsubmit:SetSize(bw, bh)
	dsubmit:SetDisabled(false)
	dsubmit:SetText(GetTranslation("reroll_button"))

	dsubmit.DoClick = function(s)
		RunConsoleCommand("ttt2_reroll_shop")
		RunConsoleCommand("ttt_cl_traitorpopup")
		timer.Simple(0.1, function()
			RunConsoleCommand("ttt_cl_traitorpopup")
		end)
	end

	dsubmit.Think = function(s)
		if client:GetCredits() < cost or not GetGlobalBool("ttt2_random_shop_reroll") then
			s:SetDisabled(true)
		end
	end

	dform:AddItem(dsubmit)

	dform:Help(LANG.GetParamTranslation("reroll_help", {amount = cost}))

	return dform
end
