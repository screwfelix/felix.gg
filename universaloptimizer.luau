-- // Services
local Workspace = game:FindService("Workspace") or game:GetService("Workspace");
local Terrain = Workspace:FindFirstChildOfClass("Terrain") or Workspace:WaitForChild("Terrain", 5);
local Lighting = game:FindService("Lighting") or game:GetService("Lighting");

-- // Functions
local lock = function(Object, Property, Goal)
	if Object[Property] then
		Object[Property] = Goal
		local propertyChanged = Object:GetPropertyChangedSignal(Property):Connect(function()
			Object[Property] = Goal
		end)
	else
		error("Object \"".. Object.Name.. "\" has no property called \"".. Property.. "\"?");
	end
end

local analyseType = function(classTable, service, callback)
	local newAnalyse = function(obj)
		if type(classTable) == "table" then
			for index, class in ipairs(classTable) do
				if obj:IsA(class) then
					task.defer(callback, obj)
				end
			end
		elseif type(classTable) == "string" then
			if (obj:IsA(classTable)) then
				task.defer(callback, obj)
			end
		else
			error("Invalid class format?");
		end
	end
	for _, obj in pairs(service:GetDescendants()) do newAnalyse(obj) end
	local newAdded = service.DescendantAdded:Connect(newAnalyse)
end

local optimizeTerrain = function()
	if (Terrain and Terrain ~= nil) then
		lock(Terrain, "WaterTransparency", 1);
		lock(Terrain, "WaterReflectance", 0);
		lock(Terrain, "WaterWaveSize", 0);
		lock(Terrain, "WaterWaveSpeed", 0);
		lock(Terrain, "WaterColor", Color3.fromRGB(255, 255, 255));
	else
		error("Terrain is missing?");
	end
end

local optimizeLighting = function()
	if (Lighting and Lighting ~= nil) then
		lock(Lighting, "Ambient", Color3.new(1,1,1))
		lock(Lighting, "OutdoorAmbient", Color3.new(1,1,1))
		lock(Lighting, "ColorShift_Top", Color3.new(1,1,1))
		lock(Lighting, "ColorShift_Bottom", Color3.new(1,1,1))
		lock(Lighting, "EnvironmentSpecularScale", 0)
		lock(Lighting, "EnvironmentDiffuseScale", 0)
		lock(Lighting, "Brightness", 0)
		lock(Lighting, "GlobalShadows", false)
		lock(Lighting, "ShadowSoftness", 0)
		lock(Lighting, "ClockTime", 12)
		lock(Lighting, "GeographicLatitude", 23.5)
		lock(Lighting, "ExposureCompensation", 0)
	else
		error("Lighting is missing?");
	end
end

local removePostEffects = function()
	analyseType({"PostEffect", "Sky", "Atmosphere", "Clouds"}, game, function(obj)
		task.defer(obj.Destroy, obj)
	end)
end

local optimizeMaterials = function()
	analyseType("BasePart", game, function(obj)
		lock(obj, "Material", Enum.Material.SmoothPlastic)
		lock(obj, "CastShadow", false)
		lock(obj, "Reflectance", 0)
	end)
end

local removeSurfaces = function()
	analyseType({"Decal", "Texture"}, game, function(obj)
		lock(obj, "Transparency", 1)
	end)
end

local optimizePlayers = function()
	analyseType({"Shirt", "Pants", "ShirtGraphic", "Hat", "Accessory"}, game, function(obj)
		task.defer(obj.Destroy, obj)
	end)
	analyseType({"Humanoid"}, game, function(obj)
		for index, track in ipairs(obj:GetPlayingAnimationTracks()) do
			track:Stop(0)
		end
	end)
	analyseType({"Animator"}, game, function(obj)
		for index, track in ipairs(obj:GetPlayingAnimationTracks()) do
			track:Stop(0)
		end
		task.defer(obj.Destroy, obj)
	end)
	analyseType({"BaseScript"}, game, function(obj)
		if (obj.Name == "Animate") then
			lock(obj, "Enabled", false)
		end
	end)
end

local optimize3DSurfaces = function()
	analyseType({"GuiObject"}, game, function(obj)
		if (obj:FindFirstAncestorOfClass("BillboardGui") or obj:FindFirstAncestorOfClass("SurfaceGui")) then
			lock(obj, "Visible", false)
		end
	end)
end

local optimizeMeshes = function()
	analyseType({"SpecialMesh", "BlockMesh", "FileMesh", "CharacterMesh", "CylinderMesh"}, game, function(obj)
		task.defer(obj.Destroy, obj)
	end)
end

local disableWind = function()
	lock(Workspace, "GlobalWind", Vector3.zero)
end

-- // Script
optimizeTerrain()
optimizeLighting()
removePostEffects()
optimizeMaterials()
removeSurfaces()
optimizePlayers()
optimize3DSurfaces()
optimizeMeshes()
disableWind()
