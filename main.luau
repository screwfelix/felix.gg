-- // Services
local DataModel = game
local Workspace = DataModel:GetService("Workspace")
local Players = DataModel:GetService("Players")
local RunService = DataModel:GetService("RunService")
local UIS = DataModel:GetService("UserInputService")
local ReplicatedStorage = DataModel:GetService("ReplicatedStorage")
local Lighting = DataModel:GetService("Lighting")

-- // Variables
local Self = Players.LocalPlayer

-- // Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("felix.gg", "Synapse")

-- // Combat
local Combat = Window:NewTab("Combat")
local Combat_Section1 = Combat:NewSection("Section Name")

local Combat_Button1 = Combat_Section1:NewButton("ButtonText", "ButtonInfo", function()
	print("Clicked")
end)

-- // Movement
local Movement = Window:NewTab("Movement")
local MovementSelf = Movement:NewSection("Self")

_G.SpeedToggled = false
local SpeedToggle = MovementSelf:NewToggle("Speed", "Toggles Speed On/Off.", function(state)
	if state then
		_G.SpeedToggled = true
	else
		_G.SpeedToggled = false
	end
end)

_G.SpeedValue = 0
local SpeedSlider = MovementSelf:NewSlider("Speed Modifier", "Adjusts how fast your character will be.", 100, 0, function(Value)
	_G.SpeedValue = Value
end)

_G.JumpToggled = false
local JumpToggle = MovementSelf:NewToggle("Jump", "Toggles Jump On/Off. INCLUDES INF JUMP.", function(state)
	if state then
		_G.JumpToggled = true
	else
		_G.JumpToggled = false
	end
end)

_G.JumpValue = 0
local JumpSlider = MovementSelf:NewSlider("Jump Modifier", "Adjusts how high your character will reach.", 100, 0, function(Value)
	_G.JumpValue = Value
end)

task.spawn(function(Speed)
	local SpeedConnection = RunService.PreRender:Connect(function()
		local Character = Self.Character
		if (Character and Character ~= nil) then
			local Humanoid = Character:FindFirstChildOfClass("Humanoid")
			if (Humanoid and Humanoid ~= nil) then
				if _G.SpeedToggled == true then
					local PrimaryPart = Character:FindFirstChild("HumanoidRootPart")
					if (PrimaryPart and PrimaryPart ~= nil) then
						if (Humanoid.MoveDirection.Magnitude > 0) then
							PrimaryPart.Velocity = Vector3.new(Humanoid.MoveDirection.X * _G.SpeedValue, PrimaryPart.Velocity.Y, Humanoid.MoveDirection.Z * _G.SpeedValue)
						end
					end
				end
			end
		end
	end)
end)

task.spawn(function(Jump)
	local JumpConnection = UIS.JumpRequest:Connect(function()
		local Character = Self.Character
		if (Character and Character ~= nil) then
			local Humanoid = Character:FindFirstChildOfClass("Humanoid")
			if (Humanoid and Humanoid ~= nil) then
				if _G.JumpToggled == true then
					local PrimaryPart = Character:FindFirstChild("HumanoidRootPart")
					if (PrimaryPart and PrimaryPart ~= nil) then
						PrimaryPart.Velocity = Vector3.new(PrimaryPart.Velocity.X, _G.JumpValue, PrimaryPart.Velocity.Z)
					end
				end
			end
		end
	end)
end)

-- // Visuals
local Visuals = Window:NewTab("Visuals")
local WorldSection = Visuals:NewSection("World")

local function lock(o: Instance, p, g)
	o[p]=g
	local connection = o:GetPropertyChangedSignal(p):Connect(function()
		o[p]=g
	end)
end

local FullbrightButton = WorldSection:NewButton("Fullbright", "Enables fullbright into the game. Not reversable.", function()
	lock(Lighting, "Ambient", Color3.new(1,1,1))
	lock(Lighting, "OutdoorAmbient", Color3.new(1,1,1))
	lock(Lighting, "ColorShift_Bottom", Color3.new(1,1,1))
	lock(Lighting, "ColorShift_Top", Color3.new(1,1,1))
	lock(Lighting, "Brightness", 0)
	lock(Lighting, "EnvironmentDiffuseScale", 0)
	lock(Lighting, "EnvironmentSpecularScale", 0)
	lock(Lighting, "GlobalShadows", false)
	lock(Lighting, "TimeOfDay", 12)
	lock(Lighting, "GeographicLatitude", 23.5)
	lock(Lighting, "ExposureCompensation", 0)
	lock(Lighting, "FogEnd", math.huge)
	lock(Lighting, "FogStart", math.huge)
	lock(Lighting, "FogColor", Color3.new(1,1,1))
end)

-- // Rage
local Rage = Window:NewTab("Rage")
local SelfSection = Rage:NewSection("Self")

_G.SpinbotToggled = false
local SpinbotToggle = SelfSection:NewToggle("Spinbot", "Toggles Spinbot On/Off.", function(state)
	if state then
		_G.SpinbotToggled = true
	else
		_G.SpinbotToggled = false
	end
end)

_G.SpinbotSpeed = 0
local Rage_Slider1 = SelfSection:NewSlider("Spinbot Speed", "Adjusts how much degrees the spinbot will rotate your character per step.", 180, -180, function(Value)
	_G.SpinbotSpeed = Value
end)


_G.AngleEnabled = false
local AngleToggle = SelfSection:NewToggle("Angle", "Toggles angle on/off.", function(state)
	if state then
		_G.AngleEnabled = true
	else
		_G.AngleEnabled = false
	end
end)

_G.AngleSelected = ""
local AngleList = {"Mouse", "Camera"}
local AngleDropdown = SelfSection:NewDropdown("Angle","Select the angle you want. Use spinbot for an offset.", AngleList, function(Value)
	_G.AngleSelected = Value
end)

_G.NoAnimsToggled = false
local NoAnimsToggle = SelfSection:NewToggle("No Animations", "Toggles your animations on/off", function(state)
	if state then
		_G.NoAnimsToggled = true
	else
		_G.NoAnimsToggled = false
	end
end)

_G.NoDownedToggled = false
local NoDownedToggle = SelfSection:NewToggle("No Downed", "Toggles your downed state on/off", function(state)
	if state then
		_G.NoDownedToggled = true
	else
		_G.NoDownedToggled = false
	end
end)

_G.NoRagdollToggled = false
local NoRagdollToggle = SelfSection:NewToggle("No Ragdoll", "Toggles your ragdoll state on/off", function(state)
	if state then
		_G.NoRagdollToggled = true
	else
		_G.NoRagdollToggled = false
	end
end)

_G.NoGrabbedToggled = false
local NoGrabbedToggle = SelfSection:NewToggle("No Grabbed", "Makes the game think no one is carrying you.", function(state)
	if state then
		_G.NoGrabbedToggled = true
	else
		_G.NoGrabbedToggled = false
	end
end)

_G.NoRunStaminaReductionToggled = false
local NoRunStaminaReductionToggle = SelfSection:NewToggle("No Run Stamina Decrease", "Your stamina won't decrease when running.", function(state)
	if state then
		_G.NoRunStaminaReductionToggled = true
	else
		_G.NoRunStaminaReductionToggled = false
	end
end)

_G.UnbreakableLimbsToggled = false
local UnbreakableLimbsToggle = SelfSection:NewToggle("Unbreakable Limbs", "Your limbs will never break.", function(state)
	if state then
		_G.UnbreakableLimbsToggled = true
	else
		_G.UnbreakableLimbsToggled = false
	end
end)

task.spawn(function(Spinbot)
	local SpinbotConnection = RunService.PreRender:Connect(function()
		local Character = Self.Character
		if (Character and Character ~= nil) then
			local Humanoid = Character:FindFirstChildOfClass("Humanoid")
			if (Humanoid and Humanoid ~= nil) then
				if _G.SpinbotToggled == true then
					Humanoid.AutoRotate = false
					local PrimaryPart = Character:FindFirstChild("HumanoidRootPart")
					if (PrimaryPart and PrimaryPart ~= nil) then
						PrimaryPart.CFrame *= CFrame.Angles(0,math.rad(_G.SpinbotSpeed),0)
					end
				else
					Humanoid.AutoRotate = true
				end
			end
		end
	end)
end)

task.spawn(function(Angle)
	local AngleConnection = RunService.PreRender:Connect(function()
		local Character = Self.Character
		if (Character and Character ~= nil) then
			local Humanoid = Character:FindFirstChildOfClass("Humanoid")
			if (Humanoid and Humanoid ~= nil) then
				if _G.AngleEnabled == true then
					local PrimaryPart = Character:FindFirstChild("HumanoidRootPart")
					if (PrimaryPart and PrimaryPart ~= nil) then
						if _G.AngleSelected == "Mouse" then
							PrimaryPart.CFrame = CFrame.lookAt(PrimaryPart.CFrame.Position, Vector3.new(Self:GetMouse().Hit.X, PrimaryPart.Position.Y, Self:GetMouse().Hit.Z))
						elseif _G.AngleSelected == "Camera" then
							PrimaryPart.CFrame = CFrame.lookAt(PrimaryPart.CFrame.Position, Vector3.new(Workspace.CurrentCamera.CFrame.Position.X, PrimaryPart.Position.Y, Workspace.CurrentCamera.CFrame.Position.Z))
						end
					end
				end
			end
		end
	end)
end)

task.spawn(function(NoAnims)
	local NoAnimsConnection = RunService.PreRender:Connect(function()
		local Character = Self.Character
		if (Character and Character ~= nil) then
			local Humanoid = Character:FindFirstChildOfClass("Humanoid")
			if (Humanoid and Humanoid ~= nil) then
				if _G.NoAnimsToggled == true then
					for _, track in ipairs(Humanoid:GetPlayingAnimationTracks()) do
						track:Stop()
					end
				end
			end
		end
	end)
end)

task.spawn(function(NoDowned)
	local NoDownedConnection = RunService.PreRender:Connect(function()
		if _G.NoDownedToggled == true then
			local CharStats = ReplicatedStorage:FindFirstChild("CharStats")
			if (CharStats and CharStats ~= nil) then
				local MyStats = CharStats:FindFirstChild(Self.Name)
				if (MyStats and MyStats ~= nil) then
					local DownedStat = MyStats:FindFirstChild("Downed")
					if (DownedStat and DownedStat ~= nil) then
						DownedStat.Value = false
					end
				end
			end
		end
	end)
end)

task.spawn(function(NoRagdoll)
	local NoRagdollConnection = RunService.PreRender:Connect(function()
		if _G.NoRagdollToggled == true then
			local CharStats = ReplicatedStorage:FindFirstChild("CharStats")
			if (CharStats and CharStats ~= nil) then
				local MyStats = CharStats:FindFirstChild(Self.Name)
				if (MyStats and MyStats ~= nil) then
					local RagdollStat = MyStats:FindFirstChild("RagdollTime")
					if (RagdollStat and RagdollStat ~= nil) then
						local RagdollStat1 = RagdollStat:FindFirstChild("RagdollSwitch")
						if (RagdollStat1 and RagdollStat1 ~= nil) then
							RagdollStat1.Value = false
						end
						local RagdollStat2 = RagdollStat:FindFirstChild("SRagdolled")
						if (RagdollStat2 and RagdollStat2 ~= nil) then
							RagdollStat2.Value = false
						end
					end
				end
			end
		end
	end)
end)

task.spawn(function(NoGrabbed)
	local NoGrabbedConnection = RunService.PreRender:Connect(function()
		if _G.NoGrabbedTogled == true then
			local CharStats = ReplicatedStorage:FindFirstChild("CharStats")
			if (CharStats and CharStats ~= nil) then
				local MyStats = CharStats:FindFirstChild(Self.Name)
				if (MyStats and MyStats ~= nil) then
					local DownedStat = MyStats:FindFirstChild("Grabbed")
					if (DownedStat and DownedStat ~= nil) then
						DownedStat.Value = false
					end
				end
			end
		end
	end)
end)

task.spawn(function(NoStaminaRed)
	local NoStaminaRedConnection = RunService.PreRender:Connect(function()
		if _G.NoRunStaminaReductionToggled == true then
			local CharStats = ReplicatedStorage:FindFirstChild("CharStats")
			if (CharStats and CharStats ~= nil) then
				local MyStats = CharStats:FindFirstChild(Self.Name)
				if (MyStats and MyStats ~= nil) then
					local DownedStat = MyStats:FindFirstChild("Sprinting")
					if (DownedStat and DownedStat ~= nil) then
						DownedStat.Value = false
					end
				end
			end
		end
	end)
end)

task.spawn(function(UnbreakableLimbs)
	local UnbreakableLimbsConnection = RunService.PreRender:Connect(function()
		if _G.UnbreakableLimbsToggled == true then
			local CharStats = ReplicatedStorage:FindFirstChild("CharStats")
			if (CharStats and CharStats ~= nil) then
				local MyStats = CharStats:FindFirstChild(Self.Name)
				if (MyStats and MyStats ~= nil) then
					local DownedStat = MyStats:FindFirstChild("HealthValues")
					if (DownedStat and DownedStat ~= nil) then
						for i,v in pairs(DownedStat:GetDescendants()) do
							if v.Name == "Broken" or v.Name == "Destroyed" then
								v.Value = false
							elseif v.Name == "Head" or v.Name == "Right Arm" or v.Name == "Left Arm" or v.Name == "Right Leg" or v.Name == "Left Leg" then
								v.MaxValue = math.huge
								v.MinValue = math.huge
								v.Value = math.huge
							end
						end
					end
				end
			end
		end
	end)
end)

-- // Misc
local Misc = Window:NewTab("Misc")
local MiscSection = Misc:NewSection("Misc")
_G.InfPepperToggled = false
local InfPepperToggle = MiscSection:NewToggle("Infinite Pepper Spray", "Grants you infinite pepper fuel. Useful for trolling.", function(state)
	if state then
		_G.InfPepperToggled = true
	else
		_G.InfPepperToggled = false
	end
end)

_G.InfInvSlotsToggled = false
local InfInvSlotsToggle = MiscSection:NewToggle("Infinite Inventory Slots", "Grants you infinite inventory slots.", function(state)
	if state then
		_G.InfInvSlotsToggled = true
	else
		_G.InfInvSlotsToggled = false
	end
end)

task.spawn(function(InfPepper)
	local InfPepperConnection = RunService.PreRender:Connect(function()
		if _G.InfPepperToggled == true then
			local Character = Self.Character
			if (Character and Character ~= nil) then
				local Pepperspray = Character:FindFirstChild("Pepper-spray")
				if (Pepperspray and Pepperspray ~= nil) then
					local Ammo = Pepperspray:FindFirstChild("Ammo")
					if (Ammo and Ammo ~= nil) then
						Ammo.MaxValue = math.huge
						Ammo.MinValue = math.huge
						Ammo.Value = math.huge
					end
				end
			end
		end
	end)
end)

task.spawn(function(InfInvSlots)
	local InfInvSlotsConnection = RunService.PreRender:Connect(function()
		if _G.InfInvSlotsToggled == true then
			local CharStats = ReplicatedStorage:FindFirstChild("CharStats")
			if (CharStats and CharStats ~= nil) then
				local MyStats = CharStats:FindFirstChild(Self.Name)
				if (MyStats and MyStats ~= nil) then
					local DownedStat = MyStats:FindFirstChild("InventorySlots")
					if (DownedStat and DownedStat ~= nil) then
						DownedStat.MaxValue = math.huge
						DownedStat.MinValue = math.huge
						DownedStat.Value = math.huge
					end
				end
			end
		end
	end)
end)
