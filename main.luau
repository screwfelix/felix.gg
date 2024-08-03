local Kavo = {}

local tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")

local Utility = {}
local Objects = {}
function Kavo:DraggingEnabled(frame, parent)

	parent = parent or frame

	-- stolen from wally or kiriot, kek
	local dragging = false
	local dragInput, mousePos, framePos

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			mousePos = input.Position
			framePos = parent.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	input.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - mousePos
			parent.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
		end
	end)
end

function Utility:TweenObject(obj, properties, duration, ...)
	tween:Create(obj, tweeninfo(duration, ...), properties):Play()
end


local themes = {
	SchemeColor = Color3.fromRGB(74, 99, 135),
	Background = Color3.fromRGB(36, 37, 43),
	Header = Color3.fromRGB(28, 29, 34),
	TextColor = Color3.fromRGB(255,255,255),
	ElementColor = Color3.fromRGB(32, 32, 38)
}
local themeStyles = {
	DarkTheme = {
		SchemeColor = Color3.fromRGB(64, 64, 64),
		Background = Color3.fromRGB(0, 0, 0),
		Header = Color3.fromRGB(0, 0, 0),
		TextColor = Color3.fromRGB(255,255,255),
		ElementColor = Color3.fromRGB(20, 20, 20)
	},
	LightTheme = {
		SchemeColor = Color3.fromRGB(150, 150, 150),
		Background = Color3.fromRGB(255,255,255),
		Header = Color3.fromRGB(200, 200, 200),
		TextColor = Color3.fromRGB(0,0,0),
		ElementColor = Color3.fromRGB(224, 224, 224)
	},
	BloodTheme = {
		SchemeColor = Color3.fromRGB(227, 27, 27),
		Background = Color3.fromRGB(10, 10, 10),
		Header = Color3.fromRGB(5, 5, 5),
		TextColor = Color3.fromRGB(255,255,255),
		ElementColor = Color3.fromRGB(20, 20, 20)
	},
	GrapeTheme = {
		SchemeColor = Color3.fromRGB(166, 71, 214),
		Background = Color3.fromRGB(64, 50, 71),
		Header = Color3.fromRGB(36, 28, 41),
		TextColor = Color3.fromRGB(255,255,255),
		ElementColor = Color3.fromRGB(74, 58, 84)
	},
	Ocean = {
		SchemeColor = Color3.fromRGB(86, 76, 251),
		Background = Color3.fromRGB(26, 32, 58),
		Header = Color3.fromRGB(38, 45, 71),
		TextColor = Color3.fromRGB(200, 200, 200),
		ElementColor = Color3.fromRGB(38, 45, 71)
	},
	Midnight = {
		SchemeColor = Color3.fromRGB(26, 189, 158),
		Background = Color3.fromRGB(44, 62, 82),
		Header = Color3.fromRGB(57, 81, 105),
		TextColor = Color3.fromRGB(255, 255, 255),
		ElementColor = Color3.fromRGB(52, 74, 95)
	},
	Sentinel = {
		SchemeColor = Color3.fromRGB(230, 35, 69),
		Background = Color3.fromRGB(32, 32, 32),
		Header = Color3.fromRGB(24, 24, 24),
		TextColor = Color3.fromRGB(119, 209, 138),
		ElementColor = Color3.fromRGB(24, 24, 24)
	},
	Synapse = {
		SchemeColor = Color3.fromRGB(46, 48, 43),
		Background = Color3.fromRGB(13, 15, 12),
		Header = Color3.fromRGB(36, 38, 35),
		TextColor = Color3.fromRGB(152, 99, 53),
		ElementColor = Color3.fromRGB(24, 24, 24)
	},
	Serpent = {
		SchemeColor = Color3.fromRGB(0, 166, 58),
		Background = Color3.fromRGB(31, 41, 43),
		Header = Color3.fromRGB(22, 29, 31),
		TextColor = Color3.fromRGB(255,255,255),
		ElementColor = Color3.fromRGB(22, 29, 31)
	}
}
local oldTheme = ""

local SettingsT = {

}

local Name = "KavoConfig.JSON"

pcall(function()

	if not pcall(function() readfile(Name) end) then
		writefile(Name, game:service'HttpService':JSONEncode(SettingsT))
	end

	Settings = game:service'HttpService':JSONEncode(readfile(Name))
end)

local LibName = tostring(math.random(1, 100))..tostring(math.random(1,50))..tostring(math.random(1, 100))

function Kavo:ToggleUI()
	if game.Players.LocalPlayer.PlayerGui[LibName].Enabled then
		game.Players.LocalPlayer.PlayerGui[LibName].Enabled = false
	else
		game.Players.LocalPlayer.PlayerGui[LibName].Enabled = true
	end
end

function Kavo.CreateLib(kavName, themeList)
	if not themeList then
		themeList = themes
	end
	if themeList == "DarkTheme" then
		themeList = themeStyles.DarkTheme
	elseif themeList == "LightTheme" then
		themeList = themeStyles.LightTheme
	elseif themeList == "BloodTheme" then
		themeList = themeStyles.BloodTheme
	elseif themeList == "GrapeTheme" then
		themeList = themeStyles.GrapeTheme
	elseif themeList == "Ocean" then
		themeList = themeStyles.Ocean
	elseif themeList == "Midnight" then
		themeList = themeStyles.Midnight
	elseif themeList == "Sentinel" then
		themeList = themeStyles.Sentinel
	elseif themeList == "Synapse" then
		themeList = themeStyles.Synapse
	elseif themeList == "Serpent" then
		themeList = themeStyles.Serpent
	else
		if themeList.SchemeColor == nil then
			themeList.SchemeColor = Color3.fromRGB(74, 99, 135)
		elseif themeList.Background == nil then
			themeList.Background = Color3.fromRGB(36, 37, 43)
		elseif themeList.Header == nil then
			themeList.Header = Color3.fromRGB(28, 29, 34)
		elseif themeList.TextColor == nil then
			themeList.TextColor = Color3.fromRGB(255,255,255)
		elseif themeList.ElementColor == nil then
			themeList.ElementColor = Color3.fromRGB(32, 32, 38)
		end
	end

	themeList = themeList or {}
	local selectedTab 
	kavName = kavName or "Library"
	table.insert(Kavo, kavName)
	for i,v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
		if v:IsA("ScreenGui") and v.Name == kavName then
			v:Destroy()
		end
	end
	local ScreenGui = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local MainCorner = Instance.new("UICorner")
	local MainHeader = Instance.new("Frame")
	local headerCover = Instance.new("UICorner")
	local coverup = Instance.new("Frame")
	local title = Instance.new("TextLabel")
	local close = Instance.new("ImageButton")
	local MainSide = Instance.new("Frame")
	local sideCorner = Instance.new("UICorner")
	local coverup_2 = Instance.new("Frame")
	local tabFrames = Instance.new("Frame")
	local tabListing = Instance.new("UIListLayout")
	local pages = Instance.new("Frame")
	local Pages = Instance.new("Folder")
	local infoContainer = Instance.new("Frame")

	local blurFrame = Instance.new("Frame")

	Kavo:DraggingEnabled(MainHeader, Main)

	blurFrame.Name = "blurFrame"
	blurFrame.Parent = pages
	blurFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	blurFrame.BackgroundTransparency = 1
	blurFrame.BorderSizePixel = 0
	blurFrame.Position = UDim2.new(-0.0222222228, 0, -0.0371747203, 0)
	blurFrame.Size = UDim2.new(0, 376, 0, 289)
	blurFrame.ZIndex = 999

	ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui
	ScreenGui.Name = LibName
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.ResetOnSpawn = false

	Main.Name = "Main"
	Main.Parent = ScreenGui
	Main.BackgroundColor3 = themeList.Background
	Main.ClipsDescendants = true
	Main.Position = UDim2.new(0.336503863, 0, 0.275485456, 0)
	Main.Size = UDim2.new(0, 525, 0, 318)

	MainCorner.CornerRadius = UDim.new(0, 4)
	MainCorner.Name = "MainCorner"
	MainCorner.Parent = Main

	MainHeader.Name = "MainHeader"
	MainHeader.Parent = Main
	MainHeader.BackgroundColor3 = themeList.Header
	Objects[MainHeader] = "BackgroundColor3"
	MainHeader.Size = UDim2.new(0, 525, 0, 29)
	headerCover.CornerRadius = UDim.new(0, 4)
	headerCover.Name = "headerCover"
	headerCover.Parent = MainHeader

	coverup.Name = "coverup"
	coverup.Parent = MainHeader
	coverup.BackgroundColor3 = themeList.Header
	Objects[coverup] = "BackgroundColor3"
	coverup.BorderSizePixel = 0
	coverup.Position = UDim2.new(0, 0, 0.758620679, 0)
	coverup.Size = UDim2.new(0, 525, 0, 7)

	title.Name = "title"
	title.Parent = MainHeader
	title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title.BackgroundTransparency = 1.000
	title.BorderSizePixel = 0
	title.Position = UDim2.new(0.0171428565, 0, 0.344827592, 0)
	title.Size = UDim2.new(0, 204, 0, 8)
	title.Font = Enum.Font.Gotham
	title.RichText = true
	title.Text = kavName
	title.TextColor3 = Color3.fromRGB(245, 245, 245)
	title.TextSize = 16.000
	title.TextXAlignment = Enum.TextXAlignment.Left

	close.Name = "close"
	close.Parent = MainHeader
	close.BackgroundTransparency = 1.000
	close.Position = UDim2.new(0.949999988, 0, 0.137999997, 0)
	close.Size = UDim2.new(0, 21, 0, 21)
	close.ZIndex = 2
	close.Image = "rbxassetid://3926305904"
	close.ImageRectOffset = Vector2.new(284, 4)
	close.ImageRectSize = Vector2.new(24, 24)
	close.MouseButton1Click:Connect(function()
		game.TweenService:Create(close, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			ImageTransparency = 1
		}):Play()
		wait()
		game.TweenService:Create(Main, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(0,0,0,0),
			Position = UDim2.new(0, Main.AbsolutePosition.X + (Main.AbsoluteSize.X / 2), 0, Main.AbsolutePosition.Y + (Main.AbsoluteSize.Y / 2))
		}):Play()
		wait(1)
		ScreenGui:Destroy()
	end)

	MainSide.Name = "MainSide"
	MainSide.Parent = Main
	MainSide.BackgroundColor3 = themeList.Header
	Objects[MainSide] = "Header"
	MainSide.Position = UDim2.new(-7.4505806e-09, 0, 0.0911949649, 0)
	MainSide.Size = UDim2.new(0, 149, 0, 289)

	sideCorner.CornerRadius = UDim.new(0, 4)
	sideCorner.Name = "sideCorner"
	sideCorner.Parent = MainSide

	coverup_2.Name = "coverup"
	coverup_2.Parent = MainSide
	coverup_2.BackgroundColor3 = themeList.Header
	Objects[coverup_2] = "Header"
	coverup_2.BorderSizePixel = 0
	coverup_2.Position = UDim2.new(0.949939311, 0, 0, 0)
	coverup_2.Size = UDim2.new(0, 7, 0, 289)

	tabFrames.Name = "tabFrames"
	tabFrames.Parent = MainSide
	tabFrames.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	tabFrames.BackgroundTransparency = 1.000
	tabFrames.Position = UDim2.new(0.0438990258, 0, -0.00066378375, 0)
	tabFrames.Size = UDim2.new(0, 135, 0, 283)

	tabListing.Name = "tabListing"
	tabListing.Parent = tabFrames
	tabListing.SortOrder = Enum.SortOrder.LayoutOrder

	pages.Name = "pages"
	pages.Parent = Main
	pages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	pages.BackgroundTransparency = 1.000
	pages.BorderSizePixel = 0
	pages.Position = UDim2.new(0.299047589, 0, 0.122641519, 0)
	pages.Size = UDim2.new(0, 360, 0, 269)

	Pages.Name = "Pages"
	Pages.Parent = pages

	infoContainer.Name = "infoContainer"
	infoContainer.Parent = Main
	infoContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	infoContainer.BackgroundTransparency = 1.000
	infoContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
	infoContainer.ClipsDescendants = true
	infoContainer.Position = UDim2.new(0.299047619, 0, 0.874213815, 0)
	infoContainer.Size = UDim2.new(0, 368, 0, 33)


	coroutine.wrap(function()
		while wait() do
			Main.BackgroundColor3 = themeList.Background
			MainHeader.BackgroundColor3 = themeList.Header
			MainSide.BackgroundColor3 = themeList.Header
			coverup_2.BackgroundColor3 = themeList.Header
			coverup.BackgroundColor3 = themeList.Header
		end
	end)()

	function Kavo:ChangeColor(prope,color)
		if prope == "Background" then
			themeList.Background = color
		elseif prope == "SchemeColor" then
			themeList.SchemeColor = color
		elseif prope == "Header" then
			themeList.Header = color
		elseif prope == "TextColor" then
			themeList.TextColor = color
		elseif prope == "ElementColor" then
			themeList.ElementColor = color
		end
	end
	local Tabs = {}

	local first = true

	function Tabs:NewTab(tabName)
		tabName = tabName or "Tab"
		local tabButton = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")
		local page = Instance.new("ScrollingFrame")
		local pageListing = Instance.new("UIListLayout")

		local function UpdateSize()
			local cS = pageListing.AbsoluteContentSize

			game.TweenService:Create(page, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				CanvasSize = UDim2.new(0,cS.X,0,cS.Y)
			}):Play()
		end

		page.Name = "Page"
		page.Parent = Pages
		page.Active = true
		page.BackgroundColor3 = themeList.Background
		page.BorderSizePixel = 0
		page.Position = UDim2.new(0, 0, -0.00371747208, 0)
		page.Size = UDim2.new(1, 0, 1, 0)
		page.ScrollBarThickness = 5
		page.Visible = false
		page.ScrollBarImageColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 16, themeList.SchemeColor.g * 255 - 15, themeList.SchemeColor.b * 255 - 28)

		pageListing.Name = "pageListing"
		pageListing.Parent = page
		pageListing.SortOrder = Enum.SortOrder.LayoutOrder
		pageListing.Padding = UDim.new(0, 5)

		tabButton.Name = tabName.."TabButton"
		tabButton.Parent = tabFrames
		tabButton.BackgroundColor3 = themeList.SchemeColor
		Objects[tabButton] = "SchemeColor"
		tabButton.Size = UDim2.new(0, 135, 0, 28)
		tabButton.AutoButtonColor = false
		tabButton.Font = Enum.Font.Gotham
		tabButton.Text = tabName
		tabButton.TextColor3 = themeList.TextColor
		Objects[tabButton] = "TextColor3"
		tabButton.TextSize = 14.000
		tabButton.BackgroundTransparency = 1

		if first then
			first = false
			page.Visible = true
			tabButton.BackgroundTransparency = 0
			UpdateSize()
		else
			page.Visible = false
			tabButton.BackgroundTransparency = 1
		end

		UICorner.CornerRadius = UDim.new(0, 5)
		UICorner.Parent = tabButton
		table.insert(Tabs, tabName)

		UpdateSize()
		page.ChildAdded:Connect(UpdateSize)
		page.ChildRemoved:Connect(UpdateSize)

		tabButton.MouseButton1Click:Connect(function()
			UpdateSize()
			for i,v in next, Pages:GetChildren() do
				v.Visible = false
			end
			page.Visible = true
			for i,v in next, tabFrames:GetChildren() do
				if v:IsA("TextButton") then
					if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
						Utility:TweenObject(v, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
					end 
					if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
						Utility:TweenObject(v, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
					end 
					Utility:TweenObject(v, {BackgroundTransparency = 1}, 0.2)
				end
			end
			if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
				Utility:TweenObject(tabButton, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
			end 
			if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
				Utility:TweenObject(tabButton, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
			end 
			Utility:TweenObject(tabButton, {BackgroundTransparency = 0}, 0.2)
		end)
		local Sections = {}
		local focusing = false
		local viewDe = false

		coroutine.wrap(function()
			while wait() do
				page.BackgroundColor3 = themeList.Background
				page.ScrollBarImageColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 16, themeList.SchemeColor.g * 255 - 15, themeList.SchemeColor.b * 255 - 28)
				tabButton.TextColor3 = themeList.TextColor
				tabButton.BackgroundColor3 = themeList.SchemeColor
			end
		end)()

		function Sections:NewSection(secName, hidden)
			secName = secName or "Section"
			local sectionFunctions = {}
			local modules = {}
			hidden = hidden or false
			local sectionFrame = Instance.new("Frame")
			local sectionlistoknvm = Instance.new("UIListLayout")
			local sectionHead = Instance.new("Frame")
			local sHeadCorner = Instance.new("UICorner")
			local sectionName = Instance.new("TextLabel")
			local sectionInners = Instance.new("Frame")
			local sectionElListing = Instance.new("UIListLayout")

			if hidden then
				sectionHead.Visible = false
			else
				sectionHead.Visible = true
			end

			sectionFrame.Name = "sectionFrame"
			sectionFrame.Parent = page
			sectionFrame.BackgroundColor3 = themeList.Background--36, 37, 43
			sectionFrame.BorderSizePixel = 0

			sectionlistoknvm.Name = "sectionlistoknvm"
			sectionlistoknvm.Parent = sectionFrame
			sectionlistoknvm.SortOrder = Enum.SortOrder.LayoutOrder
			sectionlistoknvm.Padding = UDim.new(0, 5)

			for i,v in pairs(sectionInners:GetChildren()) do
				while wait() do
					if v:IsA("Frame") or v:IsA("TextButton") then
						function size(pro)
							if pro == "Size" then
								UpdateSize()
								updateSectionFrame()
							end
						end
						v.Changed:Connect(size)
					end
				end
			end
			sectionHead.Name = "sectionHead"
			sectionHead.Parent = sectionFrame
			sectionHead.BackgroundColor3 = themeList.SchemeColor
			Objects[sectionHead] = "BackgroundColor3"
			sectionHead.Size = UDim2.new(0, 352, 0, 33)

			sHeadCorner.CornerRadius = UDim.new(0, 4)
			sHeadCorner.Name = "sHeadCorner"
			sHeadCorner.Parent = sectionHead

			sectionName.Name = "sectionName"
			sectionName.Parent = sectionHead
			sectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			sectionName.BackgroundTransparency = 1.000
			sectionName.BorderColor3 = Color3.fromRGB(27, 42, 53)
			sectionName.Position = UDim2.new(0.0198863633, 0, 0, 0)
			sectionName.Size = UDim2.new(0.980113626, 0, 1, 0)
			sectionName.Font = Enum.Font.Gotham
			sectionName.Text = secName
			sectionName.RichText = true
			sectionName.TextColor3 = themeList.TextColor
			Objects[sectionName] = "TextColor3"
			sectionName.TextSize = 14.000
			sectionName.TextXAlignment = Enum.TextXAlignment.Left
			if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
				Utility:TweenObject(sectionName, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
			end 
			if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
				Utility:TweenObject(sectionName, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
			end 

			sectionInners.Name = "sectionInners"
			sectionInners.Parent = sectionFrame
			sectionInners.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			sectionInners.BackgroundTransparency = 1.000
			sectionInners.Position = UDim2.new(0, 0, 0.190751448, 0)

			sectionElListing.Name = "sectionElListing"
			sectionElListing.Parent = sectionInners
			sectionElListing.SortOrder = Enum.SortOrder.LayoutOrder
			sectionElListing.Padding = UDim.new(0, 3)


			coroutine.wrap(function()
				while wait() do
					sectionFrame.BackgroundColor3 = themeList.Background
					sectionHead.BackgroundColor3 = themeList.SchemeColor
					tabButton.TextColor3 = themeList.TextColor
					tabButton.BackgroundColor3 = themeList.SchemeColor
					sectionName.TextColor3 = themeList.TextColor
				end
			end)()

			local function updateSectionFrame()
				local innerSc = sectionElListing.AbsoluteContentSize
				sectionInners.Size = UDim2.new(1, 0, 0, innerSc.Y)
				local frameSc = sectionlistoknvm.AbsoluteContentSize
				sectionFrame.Size = UDim2.new(0, 352, 0, frameSc.Y)
			end
			updateSectionFrame()
			UpdateSize()
			local Elements = {}
			function Elements:NewButton(bname,tipINf, callback)
				showLogo = showLogo or true
				local ButtonFunction = {}
				tipINf = tipINf or "Tip: Clicking this nothing will happen!"
				bname = bname or "Click Me!"
				callback = callback or function() end

				local buttonElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local btnInfo = Instance.new("TextLabel")
				local viewInfo = Instance.new("ImageButton")
				local touch = Instance.new("ImageLabel")
				local Sample = Instance.new("ImageLabel")

				table.insert(modules, bname)

				buttonElement.Name = bname
				buttonElement.Parent = sectionInners
				buttonElement.BackgroundColor3 = themeList.ElementColor
				buttonElement.ClipsDescendants = true
				buttonElement.Size = UDim2.new(0, 352, 0, 33)
				buttonElement.AutoButtonColor = false
				buttonElement.Font = Enum.Font.SourceSans
				buttonElement.Text = ""
				buttonElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				buttonElement.TextSize = 14.000
				Objects[buttonElement] = "BackgroundColor3"

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = buttonElement

				viewInfo.Name = "viewInfo"
				viewInfo.Parent = buttonElement
				viewInfo.BackgroundTransparency = 1.000
				viewInfo.LayoutOrder = 9
				viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				viewInfo.Size = UDim2.new(0, 23, 0, 23)
				viewInfo.ZIndex = 2
				viewInfo.Image = "rbxassetid://3926305904"
				viewInfo.ImageColor3 = themeList.SchemeColor
				Objects[viewInfo] = "ImageColor3"
				viewInfo.ImageRectOffset = Vector2.new(764, 764)
				viewInfo.ImageRectSize = Vector2.new(36, 36)

				Sample.Name = "Sample"
				Sample.Parent = buttonElement
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1.000
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = themeList.SchemeColor
				Objects[Sample] = "ImageColor3"
				Sample.ImageTransparency = 0.600

				local moreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")

				moreInfo.Name = "TipMore"
				moreInfo.Parent = infoContainer
				moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
				moreInfo.Position = UDim2.new(0, 0, 2, 0)
				moreInfo.Size = UDim2.new(0, 353, 0, 33)
				moreInfo.ZIndex = 9
				moreInfo.Font = Enum.Font.GothamSemibold
				moreInfo.Text = "  "..tipINf
				moreInfo.RichText = true
				moreInfo.TextColor3 = themeList.TextColor
				Objects[moreInfo] = "TextColor3"
				moreInfo.TextSize = 14.000
				moreInfo.TextXAlignment = Enum.TextXAlignment.Left
				Objects[moreInfo] = "BackgroundColor3"

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = moreInfo

				touch.Name = "touch"
				touch.Parent = buttonElement
				touch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				touch.BackgroundTransparency = 1.000
				touch.BorderColor3 = Color3.fromRGB(27, 42, 53)
				touch.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				touch.Size = UDim2.new(0, 21, 0, 21)
				touch.Image = "rbxassetid://3926305904"
				touch.ImageColor3 = themeList.SchemeColor
				Objects[touch] = "SchemeColor"
				touch.ImageRectOffset = Vector2.new(84, 204)
				touch.ImageRectSize = Vector2.new(36, 36)
				touch.ImageTransparency = 0

				btnInfo.Name = "btnInfo"
				btnInfo.Parent = buttonElement
				btnInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				btnInfo.BackgroundTransparency = 1.000
				btnInfo.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				btnInfo.Size = UDim2.new(0, 314, 0, 14)
				btnInfo.Font = Enum.Font.GothamSemibold
				btnInfo.Text = bname
				btnInfo.RichText = true
				btnInfo.TextColor3 = themeList.TextColor
				Objects[btnInfo] = "TextColor3"
				btnInfo.TextSize = 14.000
				btnInfo.TextXAlignment = Enum.TextXAlignment.Left

				if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
					Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
				end 
				if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
					Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
				end 

				updateSectionFrame()
				UpdateSize()

				local ms = game.Players.LocalPlayer:GetMouse()

				local btn = buttonElement
				local sample = Sample

				btn.MouseButton1Click:Connect(function()
					if not focusing then
						callback()
						local c = sample:Clone()
						c.Parent = btn
						local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
						c.Position = UDim2.new(0, x, 0, y)
						local len, size = 0.35, nil
						if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
							size = (btn.AbsoluteSize.X * 1.5)
						else
							size = (btn.AbsoluteSize.Y * 1.5)
						end
						c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
						for i = 1, 10 do
							c.ImageTransparency = c.ImageTransparency + 0.05
							wait(len / 12)
						end
						c:Destroy()
					else
						for i,v in next, infoContainer:GetChildren() do
							Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							focusing = false
						end
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
					end
				end)
				local hovering = false
				btn.MouseEnter:Connect(function()
					if not focusing then
						game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
						}):Play()
						hovering = true
					end
				end)
				btn.MouseLeave:Connect(function()
					if not focusing then 
						game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = themeList.ElementColor
						}):Play()
						hovering = false
					end
				end)
				viewInfo.MouseButton1Click:Connect(function()
					if not viewDe then
						viewDe = true
						focusing = true
						for i,v in next, infoContainer:GetChildren() do
							if v ~= moreInfo then
								Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							end
						end
						Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
						Utility:TweenObject(btn, {BackgroundColor3 = themeList.ElementColor}, 0.2)
						wait(1.5)
						focusing = false
						Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
						wait(0)
						viewDe = false
					end
				end)
				coroutine.wrap(function()
					while wait() do
						if not hovering then
							buttonElement.BackgroundColor3 = themeList.ElementColor
						end
						viewInfo.ImageColor3 = themeList.SchemeColor
						Sample.ImageColor3 = themeList.SchemeColor
						moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
						moreInfo.TextColor3 = themeList.TextColor
						touch.ImageColor3 = themeList.SchemeColor
						btnInfo.TextColor3 = themeList.TextColor
					end
				end)()

				function ButtonFunction:UpdateButton(newTitle)
					btnInfo.Text = newTitle
				end
				return ButtonFunction
			end

			function Elements:NewTextBox(tname, tTip, callback)
				tname = tname or "Textbox"
				tTip = tTip or "Gets a value of Textbox"
				callback = callback or function() end
				local textboxElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local viewInfo = Instance.new("ImageButton")
				local write = Instance.new("ImageLabel")
				local TextBox = Instance.new("TextBox")
				local UICorner_2 = Instance.new("UICorner")
				local togName = Instance.new("TextLabel")

				textboxElement.Name = "textboxElement"
				textboxElement.Parent = sectionInners
				textboxElement.BackgroundColor3 = themeList.ElementColor
				textboxElement.ClipsDescendants = true
				textboxElement.Size = UDim2.new(0, 352, 0, 33)
				textboxElement.AutoButtonColor = false
				textboxElement.Font = Enum.Font.SourceSans
				textboxElement.Text = ""
				textboxElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				textboxElement.TextSize = 14.000

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = textboxElement

				viewInfo.Name = "viewInfo"
				viewInfo.Parent = textboxElement
				viewInfo.BackgroundTransparency = 1.000
				viewInfo.LayoutOrder = 9
				viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				viewInfo.Size = UDim2.new(0, 23, 0, 23)
				viewInfo.ZIndex = 2
				viewInfo.Image = "rbxassetid://3926305904"
				viewInfo.ImageColor3 = themeList.SchemeColor
				viewInfo.ImageRectOffset = Vector2.new(764, 764)
				viewInfo.ImageRectSize = Vector2.new(36, 36)

				write.Name = "write"
				write.Parent = textboxElement
				write.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				write.BackgroundTransparency = 1.000
				write.BorderColor3 = Color3.fromRGB(27, 42, 53)
				write.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				write.Size = UDim2.new(0, 21, 0, 21)
				write.Image = "rbxassetid://3926305904"
				write.ImageColor3 = themeList.SchemeColor
				write.ImageRectOffset = Vector2.new(324, 604)
				write.ImageRectSize = Vector2.new(36, 36)

				TextBox.Parent = textboxElement
				TextBox.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 - 6, themeList.ElementColor.g * 255 - 6, themeList.ElementColor.b * 255 - 7)
				TextBox.BorderSizePixel = 0
				TextBox.ClipsDescendants = true
				TextBox.Position = UDim2.new(0.488749921, 0, 0.212121218, 0)
				TextBox.Size = UDim2.new(0, 150, 0, 18)
				TextBox.ZIndex = 99
				TextBox.ClearTextOnFocus = false
				TextBox.Font = Enum.Font.Gotham
				TextBox.PlaceholderColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 19, themeList.SchemeColor.g * 255 - 26, themeList.SchemeColor.b * 255 - 35)
				TextBox.PlaceholderText = "Type here!"
				TextBox.Text = ""
				TextBox.TextColor3 = themeList.SchemeColor
				TextBox.TextSize = 12.000

				UICorner_2.CornerRadius = UDim.new(0, 4)
				UICorner_2.Parent = TextBox

				togName.Name = "togName"
				togName.Parent = textboxElement
				togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				togName.BackgroundTransparency = 1.000
				togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				togName.Size = UDim2.new(0, 138, 0, 14)
				togName.Font = Enum.Font.GothamSemibold
				togName.Text = tname
				togName.RichText = true
				togName.TextColor3 = themeList.TextColor
				togName.TextSize = 14.000
				togName.TextXAlignment = Enum.TextXAlignment.Left

				local moreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")

				moreInfo.Name = "TipMore"
				moreInfo.Parent = infoContainer
				moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
				moreInfo.Position = UDim2.new(0, 0, 2, 0)
				moreInfo.Size = UDim2.new(0, 353, 0, 33)
				moreInfo.ZIndex = 9
				moreInfo.Font = Enum.Font.GothamSemibold
				moreInfo.RichText = true
				moreInfo.Text = "  "..tTip
				moreInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
				moreInfo.TextSize = 14.000
				moreInfo.TextXAlignment = Enum.TextXAlignment.Left

				if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
					Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
				end 
				if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
					Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
				end 

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = moreInfo


				updateSectionFrame()
				UpdateSize()

				local btn = textboxElement
				local infBtn = viewInfo

				btn.MouseButton1Click:Connect(function()
					if focusing then
						for i,v in next, infoContainer:GetChildren() do
							Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							focusing = false
						end
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
					end
				end)
				local hovering = false
				btn.MouseEnter:Connect(function()
					if not focusing then
						game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
						}):Play()
						hovering = true
					end 
				end)

				btn.MouseLeave:Connect(function()
					if not focusing then
						game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = themeList.ElementColor
						}):Play()
						hovering = false
					end
				end)

				TextBox.FocusLost:Connect(function(EnterPressed)
					if focusing then
						for i,v in next, infoContainer:GetChildren() do
							Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							focusing = false
						end
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
					end
					if not EnterPressed then 
						return
					else
						callback(TextBox.Text)
						wait(0.18)
						TextBox.Text = ""  
					end
				end)

				viewInfo.MouseButton1Click:Connect(function()
					if not viewDe then
						viewDe = true
						focusing = true
						for i,v in next, infoContainer:GetChildren() do
							if v ~= moreInfo then
								Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							end
						end
						Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
						Utility:TweenObject(btn, {BackgroundColor3 = themeList.ElementColor}, 0.2)
						wait(1.5)
						focusing = false
						Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
						wait(0)
						viewDe = false
					end
				end)
				coroutine.wrap(function()
					while wait() do
						if not hovering then
							textboxElement.BackgroundColor3 = themeList.ElementColor
						end
						TextBox.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 - 6, themeList.ElementColor.g * 255 - 6, themeList.ElementColor.b * 255 - 7)
						viewInfo.ImageColor3 = themeList.SchemeColor
						moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
						moreInfo.TextColor3 = themeList.TextColor
						write.ImageColor3 = themeList.SchemeColor
						togName.TextColor3 = themeList.TextColor
						TextBox.PlaceholderColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 19, themeList.SchemeColor.g * 255 - 26, themeList.SchemeColor.b * 255 - 35)
						TextBox.TextColor3 = themeList.SchemeColor
					end
				end)()
			end 

			function Elements:NewToggle(tname, nTip, callback)
				local TogFunction = {}
				tname = tname or "Toggle"
				nTip = nTip or "Prints Current Toggle State"
				callback = callback or function() end
				local toggled = false
				table.insert(SettingsT, tname)

				local toggleElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local toggleDisabled = Instance.new("ImageLabel")
				local toggleEnabled = Instance.new("ImageLabel")
				local togName = Instance.new("TextLabel")
				local viewInfo = Instance.new("ImageButton")
				local Sample = Instance.new("ImageLabel")

				toggleElement.Name = "toggleElement"
				toggleElement.Parent = sectionInners
				toggleElement.BackgroundColor3 = themeList.ElementColor
				toggleElement.ClipsDescendants = true
				toggleElement.Size = UDim2.new(0, 352, 0, 33)
				toggleElement.AutoButtonColor = false
				toggleElement.Font = Enum.Font.SourceSans
				toggleElement.Text = ""
				toggleElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				toggleElement.TextSize = 14.000

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = toggleElement

				toggleDisabled.Name = "toggleDisabled"
				toggleDisabled.Parent = toggleElement
				toggleDisabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				toggleDisabled.BackgroundTransparency = 1.000
				toggleDisabled.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				toggleDisabled.Size = UDim2.new(0, 21, 0, 21)
				toggleDisabled.Image = "rbxassetid://3926309567"
				toggleDisabled.ImageColor3 = themeList.SchemeColor
				toggleDisabled.ImageRectOffset = Vector2.new(628, 420)
				toggleDisabled.ImageRectSize = Vector2.new(48, 48)

				toggleEnabled.Name = "toggleEnabled"
				toggleEnabled.Parent = toggleElement
				toggleEnabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				toggleEnabled.BackgroundTransparency = 1.000
				toggleEnabled.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				toggleEnabled.Size = UDim2.new(0, 21, 0, 21)
				toggleEnabled.Image = "rbxassetid://3926309567"
				toggleEnabled.ImageColor3 = themeList.SchemeColor
				toggleEnabled.ImageRectOffset = Vector2.new(784, 420)
				toggleEnabled.ImageRectSize = Vector2.new(48, 48)
				toggleEnabled.ImageTransparency = 1.000

				togName.Name = "togName"
				togName.Parent = toggleElement
				togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				togName.BackgroundTransparency = 1.000
				togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				togName.Size = UDim2.new(0, 288, 0, 14)
				togName.Font = Enum.Font.GothamSemibold
				togName.Text = tname
				togName.RichText = true
				togName.TextColor3 = themeList.TextColor
				togName.TextSize = 14.000
				togName.TextXAlignment = Enum.TextXAlignment.Left

				viewInfo.Name = "viewInfo"
				viewInfo.Parent = toggleElement
				viewInfo.BackgroundTransparency = 1.000
				viewInfo.LayoutOrder = 9
				viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				viewInfo.Size = UDim2.new(0, 23, 0, 23)
				viewInfo.ZIndex = 2
				viewInfo.Image = "rbxassetid://3926305904"
				viewInfo.ImageColor3 = themeList.SchemeColor
				viewInfo.ImageRectOffset = Vector2.new(764, 764)
				viewInfo.ImageRectSize = Vector2.new(36, 36)

				Sample.Name = "Sample"
				Sample.Parent = toggleElement
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1.000
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = themeList.SchemeColor
				Sample.ImageTransparency = 0.600

				local moreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")

				moreInfo.Name = "TipMore"
				moreInfo.Parent = infoContainer
				moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
				moreInfo.Position = UDim2.new(0, 0, 2, 0)
				moreInfo.Size = UDim2.new(0, 353, 0, 33)
				moreInfo.ZIndex = 9
				moreInfo.Font = Enum.Font.GothamSemibold
				moreInfo.RichText = true
				moreInfo.Text = "  "..nTip
				moreInfo.TextColor3 = themeList.TextColor
				moreInfo.TextSize = 14.000
				moreInfo.TextXAlignment = Enum.TextXAlignment.Left

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = moreInfo

				local ms = game.Players.LocalPlayer:GetMouse()

				if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
					Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
				end 
				if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
					Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
				end 

				local btn = toggleElement
				local sample = Sample
				local img = toggleEnabled
				local infBtn = viewInfo

				updateSectionFrame()
				UpdateSize()

				btn.MouseButton1Click:Connect(function()
					if not focusing then
						if toggled == false then
							game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
								ImageTransparency = 0
							}):Play()
							local c = sample:Clone()
							c.Parent = btn
							local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
							c.Position = UDim2.new(0, x, 0, y)
							local len, size = 0.35, nil
							if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
								size = (btn.AbsoluteSize.X * 1.5)
							else
								size = (btn.AbsoluteSize.Y * 1.5)
							end
							c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
							for i = 1, 10 do
								c.ImageTransparency = c.ImageTransparency + 0.05
								wait(len / 12)
							end
							c:Destroy()
						else
							game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
								ImageTransparency = 1
							}):Play()
							local c = sample:Clone()
							c.Parent = btn
							local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
							c.Position = UDim2.new(0, x, 0, y)
							local len, size = 0.35, nil
							if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
								size = (btn.AbsoluteSize.X * 1.5)
							else
								size = (btn.AbsoluteSize.Y * 1.5)
							end
							c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
							for i = 1, 10 do
								c.ImageTransparency = c.ImageTransparency + 0.05
								wait(len / 12)
							end
							c:Destroy()
						end
						toggled = not toggled
						pcall(callback, toggled)
					else
						for i,v in next, infoContainer:GetChildren() do
							Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							focusing = false
						end
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
					end
				end)
				local hovering = false
				btn.MouseEnter:Connect(function()
					if not focusing then
						game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
						}):Play()
						hovering = true
					end 
				end)
				btn.MouseLeave:Connect(function()
					if not focusing then
						game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = themeList.ElementColor
						}):Play()
						hovering = false
					end
				end)

				coroutine.wrap(function()
					while wait() do
						if not hovering then
							toggleElement.BackgroundColor3 = themeList.ElementColor
						end
						toggleDisabled.ImageColor3 = themeList.SchemeColor
						toggleEnabled.ImageColor3 = themeList.SchemeColor
						togName.TextColor3 = themeList.TextColor
						viewInfo.ImageColor3 = themeList.SchemeColor
						Sample.ImageColor3 = themeList.SchemeColor
						moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
						moreInfo.TextColor3 = themeList.TextColor
					end
				end)()
				viewInfo.MouseButton1Click:Connect(function()
					if not viewDe then
						viewDe = true
						focusing = true
						for i,v in next, infoContainer:GetChildren() do
							if v ~= moreInfo then
								Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							end
						end
						Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
						Utility:TweenObject(btn, {BackgroundColor3 = themeList.ElementColor}, 0.2)
						wait(1.5)
						focusing = false
						Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
						wait(0)
						viewDe = false
					end
				end)
				function TogFunction:UpdateToggle(newText, isTogOn)
					isTogOn = isTogOn or toggle
					if newText ~= nil then 
						togName.Text = newText
					end
					if isTogOn then
						toggled = true
						game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
							ImageTransparency = 0
						}):Play()
						pcall(callback, toggled)
					else
						toggled = false
						game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
							ImageTransparency = 1
						}):Play()
						pcall(callback, toggled)
					end
				end
				return TogFunction
			end

			function Elements:NewSlider(slidInf, slidTip, maxvalue, minvalue, callback)
				slidInf = slidInf or "Slider"
				slidTip = slidTip or "Slider tip here"
				maxvalue = maxvalue or 500
				minvalue = minvalue or 16
				startVal = startVal or 0
				callback = callback or function() end

				local sliderElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local togName = Instance.new("TextLabel")
				local viewInfo = Instance.new("ImageButton")
				local sliderBtn = Instance.new("TextButton")
				local UICorner_2 = Instance.new("UICorner")
				local UIListLayout = Instance.new("UIListLayout")
				local sliderDrag = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local write = Instance.new("ImageLabel")
				local val = Instance.new("TextLabel")

				sliderElement.Name = "sliderElement"
				sliderElement.Parent = sectionInners
				sliderElement.BackgroundColor3 = themeList.ElementColor
				sliderElement.ClipsDescendants = true
				sliderElement.Size = UDim2.new(0, 352, 0, 33)
				sliderElement.AutoButtonColor = false
				sliderElement.Font = Enum.Font.SourceSans
				sliderElement.Text = ""
				sliderElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				sliderElement.TextSize = 14.000

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = sliderElement

				togName.Name = "togName"
				togName.Parent = sliderElement
				togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				togName.BackgroundTransparency = 1.000
				togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				togName.Size = UDim2.new(0, 138, 0, 14)
				togName.Font = Enum.Font.GothamSemibold
				togName.Text = slidInf
				togName.RichText = true
				togName.TextColor3 = themeList.TextColor
				togName.TextSize = 14.000
				togName.TextXAlignment = Enum.TextXAlignment.Left

				viewInfo.Name = "viewInfo"
				viewInfo.Parent = sliderElement
				viewInfo.BackgroundTransparency = 1.000
				viewInfo.LayoutOrder = 9
				viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				viewInfo.Size = UDim2.new(0, 23, 0, 23)
				viewInfo.ZIndex = 2
				viewInfo.Image = "rbxassetid://3926305904"
				viewInfo.ImageColor3 = themeList.SchemeColor
				viewInfo.ImageRectOffset = Vector2.new(764, 764)
				viewInfo.ImageRectSize = Vector2.new(36, 36)

				sliderBtn.Name = "sliderBtn"
				sliderBtn.Parent = sliderElement
				sliderBtn.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 5, themeList.ElementColor.g * 255 + 5, themeList.ElementColor.b * 255  + 5)
				sliderBtn.BorderSizePixel = 0
				sliderBtn.Position = UDim2.new(0.488749951, 0, 0.393939406, 0)
				sliderBtn.Size = UDim2.new(0, 149, 0, 6)
				sliderBtn.AutoButtonColor = false
				sliderBtn.Font = Enum.Font.SourceSans
				sliderBtn.Text = ""
				sliderBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
				sliderBtn.TextSize = 14.000

				UICorner_2.Parent = sliderBtn

				UIListLayout.Parent = sliderBtn
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

				sliderDrag.Name = "sliderDrag"
				sliderDrag.Parent = sliderBtn
				sliderDrag.BackgroundColor3 = themeList.SchemeColor
				sliderDrag.BorderColor3 = Color3.fromRGB(74, 99, 135)
				sliderDrag.BorderSizePixel = 0
				sliderDrag.Size = UDim2.new(-0.671140969, 100,1,0)

				UICorner_3.Parent = sliderDrag

				write.Name = "write"
				write.Parent = sliderElement
				write.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				write.BackgroundTransparency = 1.000
				write.BorderColor3 = Color3.fromRGB(27, 42, 53)
				write.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				write.Size = UDim2.new(0, 21, 0, 21)
				write.Image = "rbxassetid://3926307971"
				write.ImageColor3 = themeList.SchemeColor
				write.ImageRectOffset = Vector2.new(404, 164)
				write.ImageRectSize = Vector2.new(36, 36)

				val.Name = "val"
				val.Parent = sliderElement
				val.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				val.BackgroundTransparency = 1.000
				val.Position = UDim2.new(0.352386296, 0, 0.272727281, 0)
				val.Size = UDim2.new(0, 41, 0, 14)
				val.Font = Enum.Font.GothamSemibold
				val.Text = minvalue
				val.TextColor3 = themeList.TextColor
				val.TextSize = 14.000
				val.TextTransparency = 1.000
				val.TextXAlignment = Enum.TextXAlignment.Right

				local moreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")

				moreInfo.Name = "TipMore"
				moreInfo.Parent = infoContainer
				moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
				moreInfo.Position = UDim2.new(0, 0, 2, 0)
				moreInfo.Size = UDim2.new(0, 353, 0, 33)
				moreInfo.ZIndex = 9
				moreInfo.Font = Enum.Font.GothamSemibold
				moreInfo.Text = "  "..slidTip
				moreInfo.TextColor3 = themeList.TextColor
				moreInfo.TextSize = 14.000
				moreInfo.RichText = true
				moreInfo.TextXAlignment = Enum.TextXAlignment.Left

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = moreInfo

				if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
					Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
				end 
				if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
					Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
				end 


				updateSectionFrame()
				UpdateSize()
				local mouse = game:GetService("Players").LocalPlayer:GetMouse();

				local ms = game.Players.LocalPlayer:GetMouse()
				local uis = game:GetService("UserInputService")
				local btn = sliderElement
				local infBtn = viewInfo
				local hovering = false
				btn.MouseEnter:Connect(function()
					if not focusing then
						game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
						}):Play()
						hovering = true
					end 
				end)
				btn.MouseLeave:Connect(function()
					if not focusing then
						game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = themeList.ElementColor
						}):Play()
						hovering = false
					end
				end)        

				coroutine.wrap(function()
					while wait() do
						if not hovering then
							sliderElement.BackgroundColor3 = themeList.ElementColor
						end
						moreInfo.TextColor3 = themeList.TextColor
						moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
						val.TextColor3 = themeList.TextColor
						write.ImageColor3 = themeList.SchemeColor
						togName.TextColor3 = themeList.TextColor
						viewInfo.ImageColor3 = themeList.SchemeColor
						sliderBtn.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 5, themeList.ElementColor.g * 255 + 5, themeList.ElementColor.b * 255  + 5)
						sliderDrag.BackgroundColor3 = themeList.SchemeColor
					end
				end)()

				local Value
				sliderBtn.MouseButton1Down:Connect(function()
					if not focusing then
						game.TweenService:Create(val, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							TextTransparency = 0
						}):Play()
						Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 149) * sliderDrag.AbsoluteSize.X) + tonumber(minvalue)) or 0
						pcall(function()
							callback(Value)
						end)
						sliderDrag:TweenSize(UDim2.new(0, math.clamp(mouse.X - sliderDrag.AbsolutePosition.X, 0, 149), 0, 6), "InOut", "Linear", 0.05, true)
						moveconnection = mouse.Move:Connect(function()
							val.Text = Value
							Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 149) * sliderDrag.AbsoluteSize.X) + tonumber(minvalue))
							pcall(function()
								callback(Value)
							end)
							sliderDrag:TweenSize(UDim2.new(0, math.clamp(mouse.X - sliderDrag.AbsolutePosition.X, 0, 149), 0, 6), "InOut", "Linear", 0.05, true)
						end)
						releaseconnection = uis.InputEnded:Connect(function(Mouse)
							if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
								Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 149) * sliderDrag.AbsoluteSize.X) + tonumber(minvalue))
								pcall(function()
									callback(Value)
								end)
								val.Text = Value
								game.TweenService:Create(val, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
									TextTransparency = 1
								}):Play()
								sliderDrag:TweenSize(UDim2.new(0, math.clamp(mouse.X - sliderDrag.AbsolutePosition.X, 0, 149), 0, 6), "InOut", "Linear", 0.05, true)
								moveconnection:Disconnect()
								releaseconnection:Disconnect()
							end
						end)
					else
						for i,v in next, infoContainer:GetChildren() do
							Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							focusing = false
						end
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
					end
				end)
				viewInfo.MouseButton1Click:Connect(function()
					if not viewDe then
						viewDe = true
						focusing = true
						for i,v in next, infoContainer:GetChildren() do
							if v ~= moreInfo then
								Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							end
						end
						Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
						Utility:TweenObject(btn, {BackgroundColor3 = themeList.ElementColor}, 0.2)
						wait(1.5)
						focusing = false
						Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
						wait(0)
						viewDe = false
					end
				end)        
			end

			function Elements:NewDropdown(dropname, dropinf, list, callback)
				local DropFunction = {}
				dropname = dropname or "Dropdown"
				list = list or {}
				dropinf = dropinf or "Dropdown info"
				callback = callback or function() end   

				local opened = false
				local DropYSize = 33


				local dropFrame = Instance.new("Frame")
				local dropOpen = Instance.new("TextButton")
				local listImg = Instance.new("ImageLabel")
				local itemTextbox = Instance.new("TextLabel")
				local viewInfo = Instance.new("ImageButton")
				local UICorner = Instance.new("UICorner")
				local UIListLayout = Instance.new("UIListLayout")
				local Sample = Instance.new("ImageLabel")

				local ms = game.Players.LocalPlayer:GetMouse()
				Sample.Name = "Sample"
				Sample.Parent = dropOpen
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1.000
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = themeList.SchemeColor
				Sample.ImageTransparency = 0.600

				dropFrame.Name = "dropFrame"
				dropFrame.Parent = sectionInners
				dropFrame.BackgroundColor3 = themeList.Background
				dropFrame.BorderSizePixel = 0
				dropFrame.Position = UDim2.new(0, 0, 1.23571432, 0)
				dropFrame.Size = UDim2.new(0, 352, 0, 33)
				dropFrame.ClipsDescendants = true
				local sample = Sample
				local btn = dropOpen
				dropOpen.Name = "dropOpen"
				dropOpen.Parent = dropFrame
				dropOpen.BackgroundColor3 = themeList.ElementColor
				dropOpen.Size = UDim2.new(0, 352, 0, 33)
				dropOpen.AutoButtonColor = false
				dropOpen.Font = Enum.Font.SourceSans
				dropOpen.Text = ""
				dropOpen.TextColor3 = Color3.fromRGB(0, 0, 0)
				dropOpen.TextSize = 14.000
				dropOpen.ClipsDescendants = true
				dropOpen.MouseButton1Click:Connect(function()
					if not focusing then
						if opened then
							opened = false
							dropFrame:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
							wait(0.1)
							updateSectionFrame()
							UpdateSize()
							local c = sample:Clone()
							c.Parent = btn
							local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
							c.Position = UDim2.new(0, x, 0, y)
							local len, size = 0.35, nil
							if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
								size = (btn.AbsoluteSize.X * 1.5)
							else
								size = (btn.AbsoluteSize.Y * 1.5)
							end
							c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
							for i = 1, 10 do
								c.ImageTransparency = c.ImageTransparency + 0.05
								wait(len / 12)
							end
							c:Destroy()
						else
							opened = true
							dropFrame:TweenSize(UDim2.new(0, 352, 0, UIListLayout.AbsoluteContentSize.Y), "InOut", "Linear", 0.08, true)
							wait(0.1)
							updateSectionFrame()
							UpdateSize()
							local c = sample:Clone()
							c.Parent = btn
							local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
							c.Position = UDim2.new(0, x, 0, y)
							local len, size = 0.35, nil
							if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
								size = (btn.AbsoluteSize.X * 1.5)
							else
								size = (btn.AbsoluteSize.Y * 1.5)
							end
							c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
							for i = 1, 10 do
								c.ImageTransparency = c.ImageTransparency + 0.05
								wait(len / 12)
							end
							c:Destroy()
						end
					else
						for i,v in next, infoContainer:GetChildren() do
							Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							focusing = false
						end
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
					end
				end)

				listImg.Name = "listImg"
				listImg.Parent = dropOpen
				listImg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				listImg.BackgroundTransparency = 1.000
				listImg.BorderColor3 = Color3.fromRGB(27, 42, 53)
				listImg.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				listImg.Size = UDim2.new(0, 21, 0, 21)
				listImg.Image = "rbxassetid://3926305904"
				listImg.ImageColor3 = themeList.SchemeColor
				listImg.ImageRectOffset = Vector2.new(644, 364)
				listImg.ImageRectSize = Vector2.new(36, 36)

				itemTextbox.Name = "itemTextbox"
				itemTextbox.Parent = dropOpen
				itemTextbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				itemTextbox.BackgroundTransparency = 1.000
				itemTextbox.Position = UDim2.new(0.0970000029, 0, 0.273000002, 0)
				itemTextbox.Size = UDim2.new(0, 138, 0, 14)
				itemTextbox.Font = Enum.Font.GothamSemibold
				itemTextbox.Text = dropname
				itemTextbox.RichText = true
				itemTextbox.TextColor3 = themeList.TextColor
				itemTextbox.TextSize = 14.000
				itemTextbox.TextXAlignment = Enum.TextXAlignment.Left

				viewInfo.Name = "viewInfo"
				viewInfo.Parent = dropOpen
				viewInfo.BackgroundTransparency = 1.000
				viewInfo.LayoutOrder = 9
				viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				viewInfo.Size = UDim2.new(0, 23, 0, 23)
				viewInfo.ZIndex = 2
				viewInfo.Image = "rbxassetid://3926305904"
				viewInfo.ImageColor3 = themeList.SchemeColor
				viewInfo.ImageRectOffset = Vector2.new(764, 764)
				viewInfo.ImageRectSize = Vector2.new(36, 36)

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = dropOpen

				local Sample = Instance.new("ImageLabel")

				Sample.Name = "Sample"
				Sample.Parent = dropOpen
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1.000
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = themeList.SchemeColor
				Sample.ImageTransparency = 0.600

				UIListLayout.Parent = dropFrame
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.Padding = UDim.new(0, 3)

				updateSectionFrame() 
				UpdateSize()

				local ms = game.Players.LocalPlayer:GetMouse()
				local uis = game:GetService("UserInputService")
				local infBtn = viewInfo

				local moreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")

				moreInfo.Name = "TipMore"
				moreInfo.Parent = infoContainer
				moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
				moreInfo.Position = UDim2.new(0, 0, 2, 0)
				moreInfo.Size = UDim2.new(0, 353, 0, 33)
				moreInfo.ZIndex = 9
				moreInfo.RichText = true
				moreInfo.Font = Enum.Font.GothamSemibold
				moreInfo.Text = "  "..dropinf
				moreInfo.TextColor3 = themeList.TextColor
				moreInfo.TextSize = 14.000
				moreInfo.TextXAlignment = Enum.TextXAlignment.Left

				local hovering = false
				btn.MouseEnter:Connect(function()
					if not focusing then
						game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
						}):Play()
						hovering = true
					end 
				end)
				btn.MouseLeave:Connect(function()
					if not focusing then
						game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = themeList.ElementColor
						}):Play()
						hovering = false
					end
				end)        
				coroutine.wrap(function()
					while wait() do
						if not hovering then
							dropOpen.BackgroundColor3 = themeList.ElementColor
						end
						Sample.ImageColor3 = themeList.SchemeColor
						dropFrame.BackgroundColor3 = themeList.Background
						listImg.ImageColor3 = themeList.SchemeColor
						itemTextbox.TextColor3 = themeList.TextColor
						viewInfo.ImageColor3 = themeList.SchemeColor
						moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
						moreInfo.TextColor3 = themeList.TextColor
					end
				end)()
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = moreInfo

				if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
					Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
				end 
				if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
					Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
				end 

				viewInfo.MouseButton1Click:Connect(function()
					if not viewDe then
						viewDe = true
						focusing = true
						for i,v in next, infoContainer:GetChildren() do
							if v ~= moreInfo then
								Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							end
						end
						Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
						Utility:TweenObject(btn, {BackgroundColor3 = themeList.ElementColor}, 0.2)
						wait(1.5)
						focusing = false
						Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
						wait(0)
						viewDe = false
					end
				end)     

				for i,v in next, list do
					local optionSelect = Instance.new("TextButton")
					local UICorner_2 = Instance.new("UICorner")
					local Sample1 = Instance.new("ImageLabel")

					local ms = game.Players.LocalPlayer:GetMouse()
					Sample1.Name = "Sample1"
					Sample1.Parent = optionSelect
					Sample1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Sample1.BackgroundTransparency = 1.000
					Sample1.Image = "http://www.roblox.com/asset/?id=4560909609"
					Sample1.ImageColor3 = themeList.SchemeColor
					Sample1.ImageTransparency = 0.600

					local sample1 = Sample1
					DropYSize = DropYSize + 33
					optionSelect.Name = "optionSelect"
					optionSelect.Parent = dropFrame
					optionSelect.BackgroundColor3 = themeList.ElementColor
					optionSelect.Position = UDim2.new(0, 0, 0.235294119, 0)
					optionSelect.Size = UDim2.new(0, 352, 0, 33)
					optionSelect.AutoButtonColor = false
					optionSelect.Font = Enum.Font.GothamSemibold
					optionSelect.Text = "  "..v
					optionSelect.TextColor3 = Color3.fromRGB(themeList.TextColor.r * 255 - 6, themeList.TextColor.g * 255 - 6, themeList.TextColor.b * 255 - 6)
					optionSelect.TextSize = 14.000
					optionSelect.TextXAlignment = Enum.TextXAlignment.Left
					optionSelect.ClipsDescendants = true
					optionSelect.MouseButton1Click:Connect(function()
						if not focusing then
							opened = false
							callback(v)
							itemTextbox.Text = v
							dropFrame:TweenSize(UDim2.new(0, 352, 0, 33), 'InOut', 'Linear', 0.08)
							wait(0.1)
							updateSectionFrame()
							UpdateSize()
							local c = sample1:Clone()
							c.Parent = optionSelect
							local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
							c.Position = UDim2.new(0, x, 0, y)
							local len, size = 0.35, nil
							if optionSelect.AbsoluteSize.X >= optionSelect.AbsoluteSize.Y then
								size = (optionSelect.AbsoluteSize.X * 1.5)
							else
								size = (optionSelect.AbsoluteSize.Y * 1.5)
							end
							c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
							for i = 1, 10 do
								c.ImageTransparency = c.ImageTransparency + 0.05
								wait(len / 12)
							end
							c:Destroy()         
						else
							for i,v in next, infoContainer:GetChildren() do
								Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
								focusing = false
							end
							Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
						end
					end)

					UICorner_2.CornerRadius = UDim.new(0, 4)
					UICorner_2.Parent = optionSelect

					local oHover = false
					optionSelect.MouseEnter:Connect(function()
						if not focusing then
							game.TweenService:Create(optionSelect, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
								BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
							}):Play()
							oHover = true
						end 
					end)
					optionSelect.MouseLeave:Connect(function()
						if not focusing then
							game.TweenService:Create(optionSelect, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
								BackgroundColor3 = themeList.ElementColor
							}):Play()
							oHover = false
						end
					end)   
					coroutine.wrap(function()
						while wait() do
							if not oHover then
								optionSelect.BackgroundColor3 = themeList.ElementColor
							end
							optionSelect.TextColor3 = Color3.fromRGB(themeList.TextColor.r * 255 - 6, themeList.TextColor.g * 255 - 6, themeList.TextColor.b * 255 - 6)
							Sample1.ImageColor3 = themeList.SchemeColor
						end
					end)()
				end

				function DropFunction:Refresh(newList)
					newList = newList or {}
					for i,v in next, dropFrame:GetChildren() do
						if v.Name == "optionSelect" then
							v:Destroy()
						end
					end
					for i,v in next, newList do
						local optionSelect = Instance.new("TextButton")
						local UICorner_2 = Instance.new("UICorner")
						local Sample11 = Instance.new("ImageLabel")
						local ms = game.Players.LocalPlayer:GetMouse()
						Sample11.Name = "Sample11"
						Sample11.Parent = optionSelect
						Sample11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						Sample11.BackgroundTransparency = 1.000
						Sample11.Image = "http://www.roblox.com/asset/?id=4560909609"
						Sample11.ImageColor3 = themeList.SchemeColor
						Sample11.ImageTransparency = 0.600

						local sample11 = Sample11
						DropYSize = DropYSize + 33
						optionSelect.Name = "optionSelect"
						optionSelect.Parent = dropFrame
						optionSelect.BackgroundColor3 = themeList.ElementColor
						optionSelect.Position = UDim2.new(0, 0, 0.235294119, 0)
						optionSelect.Size = UDim2.new(0, 352, 0, 33)
						optionSelect.AutoButtonColor = false
						optionSelect.Font = Enum.Font.GothamSemibold
						optionSelect.Text = "  "..v
						optionSelect.TextColor3 = Color3.fromRGB(themeList.TextColor.r * 255 - 6, themeList.TextColor.g * 255 - 6, themeList.TextColor.b * 255 - 6)
						optionSelect.TextSize = 14.000
						optionSelect.TextXAlignment = Enum.TextXAlignment.Left
						optionSelect.ClipsDescendants = true
						UICorner_2.CornerRadius = UDim.new(0, 4)
						UICorner_2.Parent = optionSelect
						optionSelect.MouseButton1Click:Connect(function()
							if not focusing then
								opened = false
								callback(v)
								itemTextbox.Text = v
								dropFrame:TweenSize(UDim2.new(0, 352, 0, 33), 'InOut', 'Linear', 0.08)
								wait(0.1)
								updateSectionFrame()
								UpdateSize()
								local c = sample11:Clone()
								c.Parent = optionSelect
								local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
								c.Position = UDim2.new(0, x, 0, y)
								local len, size = 0.35, nil
								if optionSelect.AbsoluteSize.X >= optionSelect.AbsoluteSize.Y then
									size = (optionSelect.AbsoluteSize.X * 1.5)
								else
									size = (optionSelect.AbsoluteSize.Y * 1.5)
								end
								c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
								for i = 1, 10 do
									c.ImageTransparency = c.ImageTransparency + 0.05
									wait(len / 12)
								end
								c:Destroy()         
							else
								for i,v in next, infoContainer:GetChildren() do
									Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
									focusing = false
								end
								Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
							end
						end)
						updateSectionFrame()
						UpdateSize()
						local hov = false
						optionSelect.MouseEnter:Connect(function()
							if not focusing then
								game.TweenService:Create(optionSelect, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
									BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
								}):Play()
								hov = true
							end 
						end)
						optionSelect.MouseLeave:Connect(function()
							if not focusing then
								game.TweenService:Create(optionSelect, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
									BackgroundColor3 = themeList.ElementColor
								}):Play()
								hov = false
							end
						end)   
						coroutine.wrap(function()
							while wait() do
								if not oHover then
									optionSelect.BackgroundColor3 = themeList.ElementColor
								end
								optionSelect.TextColor3 = Color3.fromRGB(themeList.TextColor.r * 255 - 6, themeList.TextColor.g * 255 - 6, themeList.TextColor.b * 255 - 6)
								Sample11.ImageColor3 = themeList.SchemeColor
							end
						end)()
					end
					if opened then 
						dropFrame:TweenSize(UDim2.new(0, 352, 0, UIListLayout.AbsoluteContentSize.Y), "InOut", "Linear", 0.08, true)
						wait(0.1)
						updateSectionFrame()
						UpdateSize()
					else
						dropFrame:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
						wait(0.1)
						updateSectionFrame()
						UpdateSize()
					end
				end
				return DropFunction
			end
			function Elements:NewKeybind(keytext, keyinf, first, callback)
				keytext = keytext or "KeybindText"
				keyinf = keyinf or "KebindInfo"
				callback = callback or function() end
				local oldKey = first.Name
				local keybindElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local togName = Instance.new("TextLabel")
				local viewInfo = Instance.new("ImageButton")
				local touch = Instance.new("ImageLabel")
				local Sample = Instance.new("ImageLabel")
				local togName_2 = Instance.new("TextLabel")

				local ms = game.Players.LocalPlayer:GetMouse()
				local uis = game:GetService("UserInputService")
				local infBtn = viewInfo

				local moreInfo = Instance.new("TextLabel")
				local UICorner1 = Instance.new("UICorner")

				local sample = Sample

				keybindElement.Name = "keybindElement"
				keybindElement.Parent = sectionInners
				keybindElement.BackgroundColor3 = themeList.ElementColor
				keybindElement.ClipsDescendants = true
				keybindElement.Size = UDim2.new(0, 352, 0, 33)
				keybindElement.AutoButtonColor = false
				keybindElement.Font = Enum.Font.SourceSans
				keybindElement.Text = ""
				keybindElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				keybindElement.TextSize = 14.000
				keybindElement.MouseButton1Click:connect(function(e) 
					if not focusing then
						togName_2.Text = ". . ."
						local a, b = game:GetService('UserInputService').InputBegan:wait();
						if a.KeyCode.Name ~= "Unknown" then
							togName_2.Text = a.KeyCode.Name
							oldKey = a.KeyCode.Name;
						end
						local c = sample:Clone()
						c.Parent = keybindElement
						local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
						c.Position = UDim2.new(0, x, 0, y)
						local len, size = 0.35, nil
						if keybindElement.AbsoluteSize.X >= keybindElement.AbsoluteSize.Y then
							size = (keybindElement.AbsoluteSize.X * 1.5)
						else
							size = (keybindElement.AbsoluteSize.Y * 1.5)
						end
						c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
						for i = 1, 10 do
							c.ImageTransparency = c.ImageTransparency + 0.05
							wait(len / 12)
						end
					else
						for i,v in next, infoContainer:GetChildren() do
							Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							focusing = false
						end
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
					end
				end)

				game:GetService("UserInputService").InputBegan:connect(function(current, ok) 
					if not ok then 
						if current.KeyCode.Name == oldKey then 
							callback()
						end
					end
				end)

				moreInfo.Name = "TipMore"
				moreInfo.Parent = infoContainer
				moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
				moreInfo.Position = UDim2.new(0, 0, 2, 0)
				moreInfo.Size = UDim2.new(0, 353, 0, 33)
				moreInfo.ZIndex = 9
				moreInfo.RichText = true
				moreInfo.Font = Enum.Font.GothamSemibold
				moreInfo.Text = "  "..keyinf
				moreInfo.TextColor3 = themeList.TextColor
				moreInfo.TextSize = 14.000
				moreInfo.TextXAlignment = Enum.TextXAlignment.Left

				Sample.Name = "Sample"
				Sample.Parent = keybindElement
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1.000
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = themeList.SchemeColor
				Sample.ImageTransparency = 0.600


				togName.Name = "togName"
				togName.Parent = keybindElement
				togName.BackgroundColor3 = themeList.TextColor
				togName.BackgroundTransparency = 1.000
				togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				togName.Size = UDim2.new(0, 222, 0, 14)
				togName.Font = Enum.Font.GothamSemibold
				togName.Text = keytext
				togName.RichText = true
				togName.TextColor3 = themeList.TextColor
				togName.TextSize = 14.000
				togName.TextXAlignment = Enum.TextXAlignment.Left

				viewInfo.Name = "viewInfo"
				viewInfo.Parent = keybindElement
				viewInfo.BackgroundTransparency = 1.000
				viewInfo.LayoutOrder = 9
				viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				viewInfo.Size = UDim2.new(0, 23, 0, 23)
				viewInfo.ZIndex = 2
				viewInfo.Image = "rbxassetid://3926305904"
				viewInfo.ImageColor3 = themeList.SchemeColor
				viewInfo.ImageRectOffset = Vector2.new(764, 764)
				viewInfo.ImageRectSize = Vector2.new(36, 36)
				viewInfo.MouseButton1Click:Connect(function()
					if not viewDe then
						viewDe = true
						focusing = true
						for i,v in next, infoContainer:GetChildren() do
							if v ~= moreInfo then
								Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							end
						end
						Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
						Utility:TweenObject(keybindElement, {BackgroundColor3 = themeList.ElementColor}, 0.2)
						wait(1.5)
						focusing = false
						Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
						wait(0)
						viewDe = false
					end
				end)  
				updateSectionFrame()
				UpdateSize()
				local oHover = false
				keybindElement.MouseEnter:Connect(function()
					if not focusing then
						game.TweenService:Create(keybindElement, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
						}):Play()
						oHover = true
					end 
				end)
				keybindElement.MouseLeave:Connect(function()
					if not focusing then
						game.TweenService:Create(keybindElement, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = themeList.ElementColor
						}):Play()
						oHover = false
					end
				end)        

				UICorner1.CornerRadius = UDim.new(0, 4)
				UICorner1.Parent = moreInfo

				if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
					Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
				end 
				if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
					Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
				end 

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = keybindElement

				touch.Name = "touch"
				touch.Parent = keybindElement
				touch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				touch.BackgroundTransparency = 1.000
				touch.BorderColor3 = Color3.fromRGB(27, 42, 53)
				touch.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				touch.Size = UDim2.new(0, 21, 0, 21)
				touch.Image = "rbxassetid://3926305904"
				touch.ImageColor3 = themeList.SchemeColor
				touch.ImageRectOffset = Vector2.new(364, 284)
				touch.ImageRectSize = Vector2.new(36, 36)

				togName_2.Name = "togName"
				togName_2.Parent = keybindElement
				togName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				togName_2.BackgroundTransparency = 1.000
				togName_2.Position = UDim2.new(0.727386296, 0, 0.272727281, 0)
				togName_2.Size = UDim2.new(0, 70, 0, 14)
				togName_2.Font = Enum.Font.GothamSemibold
				togName_2.Text = oldKey
				togName_2.TextColor3 = themeList.SchemeColor
				togName_2.TextSize = 14.000
				togName_2.TextXAlignment = Enum.TextXAlignment.Right   

				coroutine.wrap(function()
					while wait() do
						if not oHover then
							keybindElement.BackgroundColor3 = themeList.ElementColor
						end
						togName_2.TextColor3 = themeList.SchemeColor
						touch.ImageColor3 = themeList.SchemeColor
						viewInfo.ImageColor3 = themeList.SchemeColor
						togName.BackgroundColor3 = themeList.TextColor
						togName.TextColor3 = themeList.TextColor
						Sample.ImageColor3 = themeList.SchemeColor
						moreInfo.TextColor3 = themeList.TextColor
						moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)

					end
				end)()
			end

			function Elements:NewColorPicker(colText, colInf, defcolor, callback)
				colText = colText or "ColorPicker"
				callback = callback or function() end
				defcolor = defcolor or Color3.fromRGB(1,1,1)
				local h, s, v = Color3.toHSV(defcolor)
				local ms = game.Players.LocalPlayer:GetMouse()
				local colorOpened = false
				local colorElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local colorHeader = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local touch = Instance.new("ImageLabel")
				local togName = Instance.new("TextLabel")
				local viewInfo = Instance.new("ImageButton")
				local colorCurrent = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local UIListLayout = Instance.new("UIListLayout")
				local colorInners = Instance.new("Frame")
				local UICorner_4 = Instance.new("UICorner")
				local rgb = Instance.new("ImageButton")
				local UICorner_5 = Instance.new("UICorner")
				local rbgcircle = Instance.new("ImageLabel")
				local darkness = Instance.new("ImageButton")
				local UICorner_6 = Instance.new("UICorner")
				local darkcircle = Instance.new("ImageLabel")
				local toggleDisabled = Instance.new("ImageLabel")
				local toggleEnabled = Instance.new("ImageLabel")
				local onrainbow = Instance.new("TextButton")
				local togName_2 = Instance.new("TextLabel")

				--Properties:
				local Sample = Instance.new("ImageLabel")
				Sample.Name = "Sample"
				Sample.Parent = colorHeader
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1.000
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = themeList.SchemeColor
				Sample.ImageTransparency = 0.600

				local btn = colorHeader
				local sample = Sample

				colorElement.Name = "colorElement"
				colorElement.Parent = sectionInners
				colorElement.BackgroundColor3 = themeList.ElementColor
				colorElement.BackgroundTransparency = 1.000
				colorElement.ClipsDescendants = true
				colorElement.Position = UDim2.new(0, 0, 0.566834569, 0)
				colorElement.Size = UDim2.new(0, 352, 0, 33)
				colorElement.AutoButtonColor = false
				colorElement.Font = Enum.Font.SourceSans
				colorElement.Text = ""
				colorElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				colorElement.TextSize = 14.000
				colorElement.MouseButton1Click:Connect(function()
					if not focusing then
						if colorOpened then
							colorOpened = false
							colorElement:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
							wait(0.1)
							updateSectionFrame()
							UpdateSize()
							local c = sample:Clone()
							c.Parent = btn
							local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
							c.Position = UDim2.new(0, x, 0, y)
							local len, size = 0.35, nil
							if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
								size = (btn.AbsoluteSize.X * 1.5)
							else
								size = (btn.AbsoluteSize.Y * 1.5)
							end
							c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
							for i = 1, 10 do
								c.ImageTransparency = c.ImageTransparency + 0.05
								wait(len / 12)
							end
							c:Destroy()
						else
							colorOpened = true
							colorElement:TweenSize(UDim2.new(0, 352, 0, 141), "InOut", "Linear", 0.08, true)
							wait(0.1)
							updateSectionFrame()
							UpdateSize()
							local c = sample:Clone()
							c.Parent = btn
							local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
							c.Position = UDim2.new(0, x, 0, y)
							local len, size = 0.35, nil
							if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
								size = (btn.AbsoluteSize.X * 1.5)
							else
								size = (btn.AbsoluteSize.Y * 1.5)
							end
							c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
							for i = 1, 10 do
								c.ImageTransparency = c.ImageTransparency + 0.05
								wait(len / 12)
							end
							c:Destroy()
						end
					else
						for i,v in next, infoContainer:GetChildren() do
							Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							focusing = false
						end
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
					end
				end)
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = colorElement

				colorHeader.Name = "colorHeader"
				colorHeader.Parent = colorElement
				colorHeader.BackgroundColor3 = themeList.ElementColor
				colorHeader.Size = UDim2.new(0, 352, 0, 33)
				colorHeader.ClipsDescendants = true

				UICorner_2.CornerRadius = UDim.new(0, 4)
				UICorner_2.Parent = colorHeader

				touch.Name = "touch"
				touch.Parent = colorHeader
				touch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				touch.BackgroundTransparency = 1.000
				touch.BorderColor3 = Color3.fromRGB(27, 42, 53)
				touch.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				touch.Size = UDim2.new(0, 21, 0, 21)
				touch.Image = "rbxassetid://3926305904"
				touch.ImageColor3 = themeList.SchemeColor
				touch.ImageRectOffset = Vector2.new(44, 964)
				touch.ImageRectSize = Vector2.new(36, 36)

				togName.Name = "togName"
				togName.Parent = colorHeader
				togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				togName.BackgroundTransparency = 1.000
				togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				togName.Size = UDim2.new(0, 288, 0, 14)
				togName.Font = Enum.Font.GothamSemibold
				togName.Text = colText
				togName.TextColor3 = themeList.TextColor
				togName.TextSize = 14.000
				togName.RichText = true
				togName.TextXAlignment = Enum.TextXAlignment.Left

				local moreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")

				moreInfo.Name = "TipMore"
				moreInfo.Parent = infoContainer
				moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
				moreInfo.Position = UDim2.new(0, 0, 2, 0)
				moreInfo.Size = UDim2.new(0, 353, 0, 33)
				moreInfo.ZIndex = 9
				moreInfo.Font = Enum.Font.GothamSemibold
				moreInfo.Text = "  "..colInf
				moreInfo.TextColor3 = themeList.TextColor
				moreInfo.TextSize = 14.000
				moreInfo.RichText = true
				moreInfo.TextXAlignment = Enum.TextXAlignment.Left

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = moreInfo

				viewInfo.Name = "viewInfo"
				viewInfo.Parent = colorHeader
				viewInfo.BackgroundTransparency = 1.000
				viewInfo.LayoutOrder = 9
				viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				viewInfo.Size = UDim2.new(0, 23, 0, 23)
				viewInfo.ZIndex = 2
				viewInfo.Image = "rbxassetid://3926305904"
				viewInfo.ImageColor3 = themeList.SchemeColor
				viewInfo.ImageRectOffset = Vector2.new(764, 764)
				viewInfo.ImageRectSize = Vector2.new(36, 36)
				viewInfo.MouseButton1Click:Connect(function()
					if not viewDe then
						viewDe = true
						focusing = true
						for i,v in next, infoContainer:GetChildren() do
							if v ~= moreInfo then
								Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							end
						end
						Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
						Utility:TweenObject(colorElement, {BackgroundColor3 = themeList.ElementColor}, 0.2)
						wait(1.5)
						focusing = false
						Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
						wait(0)
						viewDe = false
					end
				end)   

				colorCurrent.Name = "colorCurrent"
				colorCurrent.Parent = colorHeader
				colorCurrent.BackgroundColor3 = defcolor
				colorCurrent.Position = UDim2.new(0.792613626, 0, 0.212121218, 0)
				colorCurrent.Size = UDim2.new(0, 42, 0, 18)

				UICorner_3.CornerRadius = UDim.new(0, 4)
				UICorner_3.Parent = colorCurrent

				UIListLayout.Parent = colorElement
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.Padding = UDim.new(0, 3)

				colorInners.Name = "colorInners"
				colorInners.Parent = colorElement
				colorInners.BackgroundColor3 = themeList.ElementColor
				colorInners.Position = UDim2.new(0, 0, 0.255319148, 0)
				colorInners.Size = UDim2.new(0, 352, 0, 105)

				UICorner_4.CornerRadius = UDim.new(0, 4)
				UICorner_4.Parent = colorInners

				rgb.Name = "rgb"
				rgb.Parent = colorInners
				rgb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				rgb.BackgroundTransparency = 1.000
				rgb.Position = UDim2.new(0.0198863633, 0, 0.0476190485, 0)
				rgb.Size = UDim2.new(0, 211, 0, 93)
				rgb.Image = "http://www.roblox.com/asset/?id=6523286724"

				UICorner_5.CornerRadius = UDim.new(0, 4)
				UICorner_5.Parent = rgb

				rbgcircle.Name = "rbgcircle"
				rbgcircle.Parent = rgb
				rbgcircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				rbgcircle.BackgroundTransparency = 1.000
				rbgcircle.Size = UDim2.new(0, 14, 0, 14)
				rbgcircle.Image = "rbxassetid://3926309567"
				rbgcircle.ImageColor3 = Color3.fromRGB(0, 0, 0)
				rbgcircle.ImageRectOffset = Vector2.new(628, 420)
				rbgcircle.ImageRectSize = Vector2.new(48, 48)

				darkness.Name = "darkness"
				darkness.Parent = colorInners
				darkness.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				darkness.BackgroundTransparency = 1.000
				darkness.Position = UDim2.new(0.636363626, 0, 0.0476190485, 0)
				darkness.Size = UDim2.new(0, 18, 0, 93)
				darkness.Image = "http://www.roblox.com/asset/?id=6523291212"

				UICorner_6.CornerRadius = UDim.new(0, 4)
				UICorner_6.Parent = darkness

				darkcircle.Name = "darkcircle"
				darkcircle.Parent = darkness
				darkcircle.AnchorPoint = Vector2.new(0.5, 0)
				darkcircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				darkcircle.BackgroundTransparency = 1.000
				darkcircle.Size = UDim2.new(0, 14, 0, 14)
				darkcircle.Image = "rbxassetid://3926309567"
				darkcircle.ImageColor3 = Color3.fromRGB(0, 0, 0)
				darkcircle.ImageRectOffset = Vector2.new(628, 420)
				darkcircle.ImageRectSize = Vector2.new(48, 48)

				toggleDisabled.Name = "toggleDisabled"
				toggleDisabled.Parent = colorInners
				toggleDisabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				toggleDisabled.BackgroundTransparency = 1.000
				toggleDisabled.Position = UDim2.new(0.704659104, 0, 0.0657142699, 0)
				toggleDisabled.Size = UDim2.new(0, 21, 0, 21)
				toggleDisabled.Image = "rbxassetid://3926309567"
				toggleDisabled.ImageColor3 = themeList.SchemeColor
				toggleDisabled.ImageRectOffset = Vector2.new(628, 420)
				toggleDisabled.ImageRectSize = Vector2.new(48, 48)

				toggleEnabled.Name = "toggleEnabled"
				toggleEnabled.Parent = colorInners
				toggleEnabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				toggleEnabled.BackgroundTransparency = 1.000
				toggleEnabled.Position = UDim2.new(0.704999983, 0, 0.0659999996, 0)
				toggleEnabled.Size = UDim2.new(0, 21, 0, 21)
				toggleEnabled.Image = "rbxassetid://3926309567"
				toggleEnabled.ImageColor3 = themeList.SchemeColor
				toggleEnabled.ImageRectOffset = Vector2.new(784, 420)
				toggleEnabled.ImageRectSize = Vector2.new(48, 48)
				toggleEnabled.ImageTransparency = 1.000

				onrainbow.Name = "onrainbow"
				onrainbow.Parent = toggleEnabled
				onrainbow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				onrainbow.BackgroundTransparency = 1.000
				onrainbow.Position = UDim2.new(2.90643607e-06, 0, 0, 0)
				onrainbow.Size = UDim2.new(1, 0, 1, 0)
				onrainbow.Font = Enum.Font.SourceSans
				onrainbow.Text = ""
				onrainbow.TextColor3 = Color3.fromRGB(0, 0, 0)
				onrainbow.TextSize = 14.000

				togName_2.Name = "togName"
				togName_2.Parent = colorInners
				togName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				togName_2.BackgroundTransparency = 1.000
				togName_2.Position = UDim2.new(0.779999971, 0, 0.100000001, 0)
				togName_2.Size = UDim2.new(0, 278, 0, 14)
				togName_2.Font = Enum.Font.GothamSemibold
				togName_2.Text = "Rainbow"
				togName_2.TextColor3 = themeList.TextColor
				togName_2.TextSize = 14.000
				togName_2.TextXAlignment = Enum.TextXAlignment.Left

				if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
					Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
				end 
				if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
					Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
				end 
				local hovering = false

				colorElement.MouseEnter:Connect(function()
					if not focusing then
						game.TweenService:Create(colorElement, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
						}):Play()
						hovering = true
					end 
				end)
				colorElement.MouseLeave:Connect(function()
					if not focusing then
						game.TweenService:Create(colorElement, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = themeList.ElementColor
						}):Play()
						hovering = false
					end
				end)        

				if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
					Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
				end 
				if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
					Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
				end 
				coroutine.wrap(function()
					while wait() do
						if not hovering then
							colorElement.BackgroundColor3 = themeList.ElementColor
						end
						touch.ImageColor3 = themeList.SchemeColor
						colorHeader.BackgroundColor3 = themeList.ElementColor
						togName.TextColor3 = themeList.TextColor
						moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
						moreInfo.TextColor3 = themeList.TextColor
						viewInfo.ImageColor3 = themeList.SchemeColor
						colorInners.BackgroundColor3 = themeList.ElementColor
						toggleDisabled.ImageColor3 = themeList.SchemeColor
						toggleEnabled.ImageColor3 = themeList.SchemeColor
						togName_2.TextColor3 = themeList.TextColor
						Sample.ImageColor3 = themeList.SchemeColor
					end
				end)()
				updateSectionFrame()
				UpdateSize()
				local plr = game.Players.LocalPlayer
				local mouse = plr:GetMouse()
				local uis = game:GetService('UserInputService')
				local rs = game:GetService("RunService")
				local colorpicker = false
				local darknesss = false
				local dark = false
				local rgb = rgb    
				local dark = darkness    
				local cursor = rbgcircle
				local cursor2 = darkcircle
				local color = {1,1,1}
				local rainbow = false
				local rainbowconnection
				local counter = 0
				--
				local function zigzag(X) return math.acos(math.cos(X*math.pi))/math.pi end
				counter = 0
				local function mouseLocation()
					return plr:GetMouse()
				end
				local function cp()
					if colorpicker then
						local ml = mouseLocation()
						local x,y = ml.X - rgb.AbsolutePosition.X,ml.Y - rgb.AbsolutePosition.Y
						local maxX,maxY = rgb.AbsoluteSize.X,rgb.AbsoluteSize.Y
						if x<0 then x=0 end
						if x>maxX then x=maxX end
						if y<0 then y=0 end
						if y>maxY then y=maxY end
						x = x/maxX
						y = y/maxY
						local cx = cursor.AbsoluteSize.X/2
						local cy = cursor.AbsoluteSize.Y/2
						cursor.Position = UDim2.new(x,-cx,y,-cy)
						color = {1-x,1-y,color[3]}
						local realcolor = Color3.fromHSV(color[1],color[2],color[3])
						colorCurrent.BackgroundColor3 = realcolor
						callback(realcolor)
					end
					if darknesss then
						local ml = mouseLocation()
						local y = ml.Y - dark.AbsolutePosition.Y
						local maxY = dark.AbsoluteSize.Y
						if y<0 then y=0 end
						if y>maxY then y=maxY end
						y = y/maxY
						local cy = cursor2.AbsoluteSize.Y/2
						cursor2.Position = UDim2.new(0.5,0,y,-cy)
						cursor2.ImageColor3 = Color3.fromHSV(0,0,y)
						color = {color[1],color[2],1-y}
						local realcolor = Color3.fromHSV(color[1],color[2],color[3])
						colorCurrent.BackgroundColor3 = realcolor
						callback(realcolor)
					end
				end

				local function setcolor(tbl)
					local cx = cursor.AbsoluteSize.X/2
					local cy = cursor.AbsoluteSize.Y/2
					color = {tbl[1],tbl[2],tbl[3]}
					cursor.Position = UDim2.new(color[1],-cx,color[2]-1,-cy)
					cursor2.Position = UDim2.new(0.5,0,color[3]-1,-cy)
					local realcolor = Color3.fromHSV(color[1],color[2],color[3])
					colorCurrent.BackgroundColor3 = realcolor
				end
				local function setrgbcolor(tbl)
					local cx = cursor.AbsoluteSize.X/2
					local cy = cursor.AbsoluteSize.Y/2
					color = {tbl[1],tbl[2],color[3]}
					cursor.Position = UDim2.new(color[1],-cx,color[2]-1,-cy)
					local realcolor = Color3.fromHSV(color[1],color[2],color[3])
					colorCurrent.BackgroundColor3 = realcolor
					callback(realcolor)
				end
				local function togglerainbow()
					if rainbow then
						game.TweenService:Create(toggleEnabled, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							ImageTransparency = 1
						}):Play()
						rainbow = false
						rainbowconnection:Disconnect()
					else
						game.TweenService:Create(toggleEnabled, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							ImageTransparency = 0
						}):Play()
						rainbow = true
						rainbowconnection = rs.PreRender:Connect(function()
							setrgbcolor({zigzag(counter),1,1})
							counter = counter + 0.01
						end)
					end
				end

				onrainbow.MouseButton1Click:Connect(togglerainbow)
				--
				mouse.Move:connect(cp)
				rgb.MouseButton1Down:connect(function()colorpicker=true end)
				dark.MouseButton1Down:connect(function()darknesss=true end)
				uis.InputEnded:Connect(function(input)
					if input.UserInputType.Name == 'MouseButton1' then
						if darknesss then darknesss = false end
						if colorpicker then colorpicker = false end
					end
				end)
				setcolor({h,s,v})
			end

			function Elements:NewLabel(title)
				local labelFunctions = {}
				local label = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				label.Name = "label"
				label.Parent = sectionInners
				label.BackgroundColor3 = themeList.SchemeColor
				label.BorderSizePixel = 0
				label.ClipsDescendants = true
				label.Text = title
				label.Size = UDim2.new(0, 352, 0, 33)
				label.Font = Enum.Font.Gotham
				label.Text = "  "..title
				label.RichText = true
				label.TextColor3 = themeList.TextColor
				Objects[label] = "TextColor3"
				label.TextSize = 14.000
				label.TextXAlignment = Enum.TextXAlignment.Left

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = label

				if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
					Utility:TweenObject(label, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
				end 
				if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
					Utility:TweenObject(label, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
				end 

				coroutine.wrap(function()
					while wait() do
						label.BackgroundColor3 = themeList.SchemeColor
						label.TextColor3 = themeList.TextColor
					end
				end)()
				updateSectionFrame()
				UpdateSize()
				function labelFunctions:UpdateLabel(newText)
					if label.Text ~= "  "..newText then
						label.Text = "  "..newText
					end
				end	
				return labelFunctions
			end	
			return Elements
		end
		return Sections
	end  
	return Tabs
end


-- // Services
local DataModel = game
local Workspace = DataModel:GetService("Workspace")
local Terrain = Workspace:WaitForChild("Terrain")
local Players = DataModel:GetService("Players")
local RunService = DataModel:GetService("RunService")
local UIS = DataModel:GetService("UserInputService")
local ReplicatedStorage = DataModel:GetService("ReplicatedStorage")
local Lighting = DataModel:GetService("Lighting")

-- // Variables
local Self = Players.LocalPlayer

local definitiveCharacter = Self.Character
task.spawn(function()
	RunService.PreRender:Connect(function()
		definitiveCharacter = Self.Character
	end)
end)

-- // Library
local Library = Kavo
local LibraryThemes = {
	SchemeColor = Color3.fromRGB(100,0,0),
	Background = Color3.fromRGB(10,10,10),
	Header = Color3.fromRGB(15,15,15),
	TextColor = Color3.fromRGB(255,255,255),
	ElementColor = Color3.fromRGB(20, 20, 20)
}
local Window = Library.CreateLib("felix.gg", "Synapse")

-- // Tabs

local Combat = Window:NewTab("Combat")
local Combat_Section1 = Combat:NewSection("Melees")
local Combat_Section2 = Combat:NewSection("Projectiles")

local Visuals = Window:NewTab("Visuals")
local WorldSection = Visuals:NewSection("World")
local VisualsSelfSection = Visuals:NewSection("Self")
local VisualsViewmodelSection = Visuals:NewSection("Viewmodel")

local Misc = Window:NewTab("Misc")
local MiscSection = Misc:NewSection("Misc")

local Movement = Window:NewTab("Movement")
local MovementSelf = Movement:NewSection("Self")

local AntiAim = Window:NewTab("Anti-Aim")
local AntiAim_Section1 = AntiAim:NewSection("Self")

local Rage = Window:NewTab("Rage")
local SelfSection = Rage:NewSection("Self")


local Map = Window:NewTab("Map")
local MapSection = Map:NewSection("Map")

local Settings = Window:NewTab("Settings")
local Settings_UI = Settings:NewSection("UI")
for theme, color in pairs(LibraryThemes) do
	Settings_UI:NewColorPicker(theme, "Change your "..theme, color, function(color3)
		Library:ChangeColor(theme, color3)
	end)
end
Settings_UI:NewKeybind("Toggle UI", "Defines a keybind for toggling the UI's visibility.", Enum.KeyCode.Insert, function()
	Library:ToggleUI()
end)

-- // Combat

_G.MeleeAuraToggled = false
local MeleeAuraToggler = Combat_Section1:NewToggle("Melee Kill Aura", "REALLY OP || only works if ur near someone", function(state)
	if state then
		_G.MeleeAuraToggled = true
	else
		_G.MeleeAuraToggled = false
	end
end)
_G.MeleeAuraHitpart = "Head"
local MeleeAuraHitpartDropdown = Combat_Section1:NewDropdown("Melee Aura Hitpart", "Defines which limb you want the aura to hit.", {"Head", "Torso", "Right Arm", "Left Arm", "Right Leg", "Left Leg", "Random"}, function(currentOption)
	_G.MeleeAuraHitpart = currentOption
end)

--[[local function findNearestLimb(player, partname)
	local charactersFolder = workspace:WaitForChild("Characters")
	if not charactersFolder then
		return nil
	end

	local character = charactersFolder:FindFirstChild(player.Name)
	if not character then
		return nil
	end

	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return nil
	end

	local nearestHead = nil
	local minDistance = math.huge  -- Start with a large number
	local targetedlimb
	if partname == "Random" then
		local limbs = {"Head", "Torso", "Left Leg", "Right Leg", "Left Arm", "Right Arm"}
		targetedlimb = limbs[math.random(1,#limbs)]
	end
	
	for _, player in pairs(workspace:WaitForChild("Characters"):GetChildren()) do
		for i, part in pairs(player:GetChildren()) do
			if partname == "Random" then
				if part:IsA("BasePart") and part.Name == targetedlimb and not (part.Parent == character) then
					local distance = (part.Position - humanoidRootPart.Position).magnitude
					if distance < minDistance then
						minDistance = distance
						nearestHead = part
					end
				end
			else
				if part:IsA("BasePart") and part.Name == partname and not (part.Parent == character) then
					local distance = (part.Position - humanoidRootPart.Position).magnitude
					if distance < minDistance then
						minDistance = distance
						nearestHead = part
					end
				end
			end
		end
	end

	return nearestHead
end]]--

local function findNearestLimb(player, partname, maxdistance)
	local c = player.Character
	local nearestPart
	if c then
		local hrp = c:FindFirstChild("HumanoidRootPart")
		if hrp then
			for i, part in pairs(Workspace:GetPartBoundsInBox(hrp.CFrame, Vector3.new(maxdistance,maxdistance,maxdistance))) do
				if partname == "Random" then
					local limbs = {"Head", "Torso", "Right Arm", "Left Arm", "Right Leg", "Left Leg"}
					local selectedlimb = limbs[math.random(1,#limbs)]
					if part.Name == selectedlimb then
						if not (part.Parent.Name == c.Name) then
							if part.Parent then
								local h = part.Parent:FindFirstChildOfClass("Humanoid")
								if h then
									if h.Health > 0 then
										nearestPart = part
										return nearestPart
									end
								end
							end
						end
					end
				else
					if part.Name == partname then
						if not (part.Parent.Name == c.Name) then
							if part.Parent then
								local h = part.Parent:FindFirstChildOfClass("Humanoid")
								if h then
									if h.Health > 0 then
										nearestPart = part
										return nearestPart
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

local meleedmgpoints = {}

--[[task.spawn(function()
	RunService.PreRender:Connect(function()
		if _G.MeleeAuraToggled == true then
			local c = Self.Character
			if c then
				local hrp = c:FindFirstChild("HumanoidRootPart")
				local t = c:FindFirstChildOfClass("Tool")
				if t then
					local h = t:FindFirstChild("Handle") or t:FindFirstChild("WeaponHandle")
					if h then
						for i,v in pairs(h:GetChildren()) do
							if v:IsA("Attachment") and v.Name == "DmgPoint" then
								table.insert(meleedmgpoints, v)
							end
						end
						for i,v in pairs(meleedmgpoints) do
							if hrp then
								local nearestHead = findNearestLimb(Self, _G.MeleeAuraHitpart, 25)

								if nearestHead then
									print("Nearest 'Head' part is at:", nearestHead.Position)
									v.WorldPosition = nearestHead.Position
								else
									print("No 'Head' part found.")
								end
							end
						end
					else
						local rarm = c:FindFirstChild("Right Arm")
						local larm = c:FindFirstChild("Left Arm")
						local rleg = c:FindFirstChild("Right Leg")
						if rarm then
							for i,v in pairs(rarm:GetChildren()) do
								if v:IsA("Attachment") and v.Name == "DmgPoint" then
									table.insert(meleedmgpoints, v)
								end
							end
						end
						if larm then
							for i,v in pairs(larm:GetChildren()) do
								if v:IsA("Attachment") and v.Name == "DmgPoint" then
									table.insert(meleedmgpoints, v)
								end
							end
						end
						if rleg then
							for i,v in pairs(rleg:GetChildren()) do
								if v:IsA("Attachment") and v.Name == "DmgPoint" then
									table.insert(meleedmgpoints, v)
								end
							end
						end
						for i,v in pairs(meleedmgpoints) do
							if hrp then
								local nearestHead = findNearestLimb(Self, _G.MeleeAuraHitpart, 25)

								if nearestHead then
									print("Nearest 'Head' part is at:", nearestHead.Position)
									v.WorldPosition = nearestHead.Position
								else
									print("No 'Head' part found.")
								end
							end
						end
					end
				end
			end
		end
	end)
end)]]--

task.spawn(function()
	local function analyse(tool: Tool)
		task.spawn(function()
			task.wait(2)
			if tool:IsA("Tool") then
				print("Tool added: ".. tool.Name)
				local handle = tool:FindFirstChild("Handle") or tool:FindFirstChild("WeaponHandle")
				if handle then
					print("Tool has a handle.")
					for i, v in pairs(handle:GetChildren()) do
						if v:IsA("Attachment") and v.Name == "DmgPoint" then
							table.insert(meleedmgpoints, v)
						end
					end
				else
					print("Tool does not have a handle.")
					local c = Self.Character
					if c then
						local arm1 = c:FindFirstChild("Right Arm")
						local arm2 = c:FindFirstChild("Left Arm")
						local leg1 = c:FindFirstChild("Right Leg")
						for i, v in pairs(arm1:GetChildren()) do
							if v:IsA("Attachment") and v.Name == "DmgPoint" then
								table.insert(meleedmgpoints, v)
							end
						end
						for i, v in pairs(arm2:GetChildren()) do
							if v:IsA("Attachment") and v.Name == "DmgPoint" then
								table.insert(meleedmgpoints, v)
							end
						end
						for i, v in pairs(leg1:GetChildren()) do
							if v:IsA("Attachment") and v.Name == "DmgPoint" then
								table.insert(meleedmgpoints, v)
							end
						end
					end
				end
			end
		end)
	end
	
	Self.CharacterAdded:Connect(function(c)
		local tooladded = c.ChildAdded:Connect(analyse)
	end)
	
	RunService.PreRender:Connect(function()
		local c = Self.Character
		if c then
			local hrp = c:FindFirstChild("HumanoidRootPart")
			if hrp then
				if _G.MeleeAuraToggled == true then
					for i,v in pairs(meleedmgpoints) do
						local nearestLimb = findNearestLimb(Self, _G.MeleeAuraHitpart, 25)

						if nearestLimb then
							v.Position = Vector3.zero
							v.WorldCFrame = nearestLimb.CFrame
						end
					end
				end
			end
		end
	end)
end)

_G.ProjectileControlToggled = false
local ProjectileControlToggler = Combat_Section2:NewToggle("Projectile Control", "Lets you control projectiles.", function(state)
	if state then
		_G.ProjectileControlToggled = true
	else
		_G.ProjectileControlToggled = false
	end
end)

_G.ProjectileSpeed = 0
local ProjectileSpeedBox = Combat_Section2:NewTextBox("Projectile Control Speed", "Defines how fast you will fly with projectiles.", function(txt)
	_G.ProjectileSpeed = tonumber(txt)
end)

_G.ProjectileAuraToggled = false
local ProjectileAuraToggler = Combat_Section2:NewToggle("Projectile Aura", "Works just like a silent aim, re-directs projectiles to the nearest player.", function(state)
	if state then
		_G.ProjectileAuraToggled = true
	else
		_G.ProjectileAuraToggled = false
	end
end)


_G.ProjectileAuraHitpart = "Head"
local ProjectileAuraHitpartDropdown = Combat_Section2:NewDropdown("Projectile Aura Hitpart", "Defines which limb you want the aura to hit.", {"Head", "Torso", "Right Arm", "Left Arm", "Right Leg", "Left Leg", "Random"}, function(currentOption)
	_G.ProjectileAuraHitpart = currentOption
end)

local UserInputService = game:GetService("UserInputService")
local camera = Workspace.CurrentCamera

local forward = 0
local sideways = 0

UserInputService.InputBegan:Connect(function(inp)
	inp = inp.KeyCode
	if inp == Enum.KeyCode.W then
		forward = 1
	elseif inp == Enum.KeyCode.S then
		forward = -1
	elseif inp == Enum.KeyCode.D then
		sideways = 1
	elseif inp == Enum.KeyCode.A then
		sideways = -1	
	end
end)
UserInputService.InputEnded:Connect(function(inp)
	inp = inp.KeyCode
	if inp == Enum.KeyCode.W then
		forward = 0
	elseif inp == Enum.KeyCode.S then
		forward = 0
	elseif inp == Enum.KeyCode.D then
		sideways = 0
	elseif inp == Enum.KeyCode.A then
		sideways = 0	
	end
end)

local function controlProjectile(projectile: Part)
	local char = Self.Character

	if char then
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if hrp then
			hrp.Anchored = true
		end
	end

	for i,v:Instance in pairs(projectile:GetDescendants()) do
		if v:IsA("LinearVelocity") or v:IsA("AngularVelocity") or v:IsA("BodyVelocity") or v:IsA("BodyGyro") or v:IsA("BodyForce") or v:IsA("BodyThrust") or v:IsA("BodyPosition") or v:IsA("BodyAngularVelocity") or v:IsA("BodyMover") then
			task.defer(v.Destroy, v)
		end
	end

	local BV = Instance.new("BodyVelocity", projectile)
	BV.MaxForce = Vector3.new(1e9, 1e9, 1e9)
	BV.Velocity = Vector3.new()

	local BG = Instance.new("BodyGyro", projectile)
	BG.P = 9e4
	BG.MaxTorque = Vector3.new(1e9, 1e9, 1e9)

	print("controlling ".. projectile.Name)
	task.spawn(function()
		camera.CameraSubject = projectile
		if char then
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum then
				projectile.Destroying:Connect(function()
					camera.CameraSubject = hum
					if char then
						local hrp = char:FindFirstChild("HumanoidRootPart")
						if hrp then
							hrp.Anchored = false
						end
					end
				end)
			end
		end

		RunService.PreRender:Connect(function()
			BG.CFrame = camera.CoordinateFrame
			BV.Velocity = ((camera.CFrame.LookVector * forward) + (camera.CFrame.RightVector * sideways)) * _G.ProjectileSpeed
		end)
	end)
end

local function auraProjectile(projectile: Part)
	for i,v:Instance in pairs(projectile:GetDescendants()) do
		if v:IsA("LinearVelocity") or v:IsA("AngularVelocity") or v:IsA("BodyVelocity") or v:IsA("BodyGyro") or v:IsA("BodyForce") or v:IsA("BodyThrust") or v:IsA("BodyPosition") or v:IsA("BodyAngularVelocity") or v:IsA("BodyMover") then
			task.defer(v.Destroy, v)
		end
	end

	local BV = Instance.new("BodyVelocity", projectile)
	BV.MaxForce = Vector3.new(1e9, 1e9, 1e9)
	BV.Velocity = Vector3.new()

	local BG = Instance.new("BodyGyro", projectile)
	BG.P = 9e4
	BG.MaxTorque = Vector3.new(1e9, 1e9, 1e9)

	print("controlling ".. projectile.Name)
	task.spawn(function()
		RunService.PreRender:Connect(function()
			BG.CFrame = camera.CoordinateFrame
			BV.Velocity = ((camera.CFrame.LookVector * forward) + (camera.CFrame.RightVector * sideways)) * _G.ProjectileSpeed
			local part = findNearestLimb(Self, _G.ProjectileAuraHitpart, 30)
			if part then
				projectile.CFrame = part.CFrame
			end
		end)
	end)
end


task.spawn(function()
	Workspace:WaitForChild("Debris").DescendantAdded:Connect(function(v)
		if (v.Name == "Snowball" or v.Name == "RPG_Rocket" or v.Name == "FireworkLauncher_Rocket" or v.Name == "Hallowsw_Rocket2" or v.Name == "Panzer_Rocket" or v.Name == "TransIgnore" or v.Name == "GrenadeLauncherGrenade" or v.Name == "SBL_Rocket" or v.Name == "SpitBall" or v.Name == "Effect") and v:IsA("BasePart") then
			if _G.ProjectileControlToggled == true then
				controlProjectile(v)
			end
		end
	end)
end)

task.spawn(function()
	Workspace:WaitForChild("Debris").DescendantAdded:Connect(function(v)
		if (v.Name == "Snowball" or v.Name == "RPG_Rocket" or v.Name == "FireworkLauncher_Rocket" or v.Name == "Hallowsw_Rocket2" or v.Name == "Panzer_Rocket" or v.Name == "TransIgnore" or v.Name == "GrenadeLauncherGrenade" or v.Name == "SBL_Rocket" or v.Name == "SpitBall" or v.Name == "Effect") and v:IsA("BasePart") then
			if _G.ProjectileAuraToggled == true then
				auraProjectile(v)
			end
		end
	end)
end)

-- // Movement

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

local Highlight = Instance.new("Highlight", Workspace)
Highlight.Name = "CharacterHighlight"
local ViewmodelHighlight = Instance.new("Highlight", Workspace)
ViewmodelHighlight.Name = "ViewmodelHighlight"
local WorldHighlight = Instance.new("Highlight", Workspace)
WorldHighlight.Name = "WorldHighlight"
WorldHighlight.DepthMode = Enum.HighlightDepthMode.Occluded



_G.SelfHighlightToggled = false
local SelfHighlightToggle = VisualsSelfSection:NewToggle("Highlight", "Highlights your character, with customizable appearance.", function(state)
	if state then
		_G.SelfHighlightToggled = true
	else
		_G.SelfHighlightToggled = false
	end
end)
_G.HighlightFillTransparency = 0
local HighlightFillTransparencyBox = VisualsSelfSection:NewTextBox("Highlight Fill Transparency", "Defines the transparency of the highlight's fill.", function(txt)
	_G.HighlightFillTransparency = tonumber(txt)
end)
_G.HighlightOutlineTransparency = 0
local HighlightOutlineTransparencyBox = VisualsSelfSection:NewTextBox("Highlight Outline Transparency", "Defines the transparency of the highlight's outline.", function(txt)
	_G.HighlightOutlineTransparency = tonumber(txt)
end)
_G.HighlightFillColor = Color3.fromRGB(0,0,0)
local HighlightFillColorPicker = VisualsSelfSection:NewColorPicker("Highlight Fill Color", "Defines the color of the highlight's fill.", Color3.fromRGB(0,0,0), function(color)
	_G.HighlightFillColor = color
end)
_G.HighlightOutlineColor = Color3.fromRGB(0,0,0)
local HighlightOutlineColorPicker = VisualsSelfSection:NewColorPicker("Highlight Outline Color", "Defines the color of the highlight's outline.", Color3.fromRGB(0,0,0), function(color)
	_G.HighlightOutlineColor = color
end)

task.spawn(function(selfHighlight)
	local highlightConnection = RunService.PreRender:Connect(function()
		local Character = Self.Character
		if (Character and Character ~= nil) then
			if (_G.SelfHighlightToggled == true) then
				Highlight.Enabled = true
				Highlight.Adornee = Character
				Highlight.FillTransparency = _G.HighlightFillTransparency
				Highlight.OutlineTransparency = _G.HighlightOutlineTransparency
				Highlight.FillColor = _G.HighlightFillColor
				Highlight.OutlineColor = _G.HighlightOutlineColor
			else
				Highlight.Enabled = false
			end
		else
			Highlight.Enabled = false
		end
	end)
end)

_G.ViewmodelHighlightToggled = false
local ViewmodelHighlightToggle = VisualsViewmodelSection:NewToggle("Highlight", "Highlights your viewmodel, with customizable appearance.", function(state)
	if state then
		_G.ViewmodelHighlightToggled = true
	else
		_G.ViewmodelHighlightToggled = false
	end
end)
_G.ViewmodelHighlightFillTransparency = 0
local ViewmodelHighlightFillTransparencyBox = VisualsViewmodelSection:NewTextBox("Highlight Fill Transparency", "Defines the transparency of the highlight's fill.", function(txt)
	_G.ViewmodelHighlightFillTransparency = tonumber(txt)
end)
_G.ViewmodelHighlightOutlineTransparency = 0
local ViewmodelHighlightOutlineTransparencyBox = VisualsViewmodelSection:NewTextBox("Highlight Outline Transparency", "Defines the transparency of the highlight's outline.", function(txt)
	_G.ViewmodelHighlightOutlineTransparency = tonumber(txt)
end)
_G.ViewmodelHighlightFillColor = Color3.fromRGB(0,0,0)
local ViewmodelHighlightFillColorPicker = VisualsViewmodelSection:NewColorPicker("Highlight Fill Color", "Defines the color of the highlight's fill.", Color3.fromRGB(0,0,0), function(color)
	_G.ViewmodelHighlightFillColor = color
end)
_G.ViewmodelHighlightOutlineColor = Color3.fromRGB(0,0,0)
local ViewmodelHighlightOutlineColorPicker = VisualsViewmodelSection:NewColorPicker("Highlight Outline Color", "Defines the color of the highlight's outline.", Color3.fromRGB(0,0,0), function(color)
	_G.ViewmodelHighlightOutlineColor = color
end)

task.spawn(function(viewmodelHighlight)
	local ViewmodelHighlightConnection = RunService.PreRender:Connect(function()
		local Viewmodel = Workspace:WaitForChild("Camera"):FindFirstChild("ViewModel", true)
		if (Viewmodel and Viewmodel ~= nil) then
			if (_G.ViewmodelHighlightToggled == true) then
				ViewmodelHighlight.Enabled = true
				ViewmodelHighlight.Adornee = Viewmodel
				ViewmodelHighlight.FillTransparency = _G.ViewmodelHighlightFillTransparency
				ViewmodelHighlight.OutlineTransparency = _G.ViewmodelHighlightOutlineTransparency
				ViewmodelHighlight.FillColor = _G.ViewmodelHighlightFillColor
				ViewmodelHighlight.OutlineColor = _G.ViewmodelHighlightOutlineColor
			else
				ViewmodelHighlight.Enabled = false
			end
		else
			ViewmodelHighlight.Enabled = false
		end
	end)
end)

_G.WorldHighlightToggled = false
local WorldHighlightToggle = WorldSection:NewToggle("Highlight", "Highlights the map, with customizable appearance.", function(state)
	if state then
		_G.WorldHighlightToggled = true
	else
		_G.WorldHighlightToggled = false
	end
end)
_G.WorldHighlightFillTransparency = 0
local WorldHighlightFillTransparencyBox = WorldSection:NewTextBox("Highlight Fill Transparency", "Defines the transparency of the highlight's fill.", function(txt)
	_G.WorldHighlightFillTransparency = tonumber(txt)
end)
_G.WorldHighlightOutlineTransparency = 0
local WorldHighlightOutlineTransparencyBox = WorldSection:NewTextBox("Highlight Outline Transparency", "Defines the transparency of the highlight's outline.", function(txt)
	_G.WorldHighlightOutlineTransparency = tonumber(txt)
end)
_G.WorldHighlightFillColor = Color3.fromRGB(0,0,0)
local WorldHighlightFillColorPicker = WorldSection:NewColorPicker("Highlight Fill Color", "Defines the color of the highlight's fill.", Color3.fromRGB(0,0,0), function(color)
	_G.WorldHighlightFillColor = color
end)
_G.WorldHighlightOutlineColor = Color3.fromRGB(0,0,0)
local WorldHighlightOutlineColorPicker = WorldSection:NewColorPicker("Highlight Outline Color", "Defines the color of the highlight's outline.", Color3.fromRGB(0,0,0), function(color)
	_G.WorldHighlightOutlineColor = color
end)

task.spawn(function(WorldHighlightFunction)
	local WorldHighlightConnection = RunService.PreRender:Connect(function()
		if (_G.WorldHighlightToggled == true) then
			WorldHighlight.Enabled = true
			WorldHighlight.Adornee = nil
			WorldHighlight.FillTransparency = _G.WorldHighlightFillTransparency
			WorldHighlight.OutlineTransparency = _G.WorldHighlightOutlineTransparency
			WorldHighlight.FillColor = _G.WorldHighlightFillColor
			WorldHighlight.OutlineColor = _G.WorldHighlightOutlineColor
		else
			WorldHighlight.Enabled = false
		end
	end)
end)

-- player esp

_G.PlayerESP = false
local PlayerESPToggle = WorldSection:NewToggle("Player Chams", "Draws chams around players, to easily spot them.", function(state)
	if state then
		_G.PlayerESP = true
	else
		_G.PlayerESP = false
	end
end)

_G.PlayerESPTransparency = 0
local PlayerESPTransparencyBox = WorldSection:NewTextBox("Player Chams Transparency", "Defines the transparency of the player chams.", function(txt)
	_G.PlayerESPTransparency = tonumber(txt)
end)
_G.PlayerESPColor = Color3.fromRGB(0,0,0)
local PlayerESPColorPicker = WorldSection:NewColorPicker("Player Chams Color", "Defines the color of the player chams.", Color3.fromRGB(0,0,0), function(color)
	_G.PlayerESPColor = color
end)

task.spawn(function()
	RunService.PreRender:Connect(function()
		local charactersfolder = Workspace:FindFirstChild("Characters")
		for _, plr in pairs(charactersfolder:GetChildren()) do
			if not (plr:HasTag("chams")) and not (plr.Name == Self.Name) then
				plr:AddTag("chams")
				for i,v in pairs(plr:GetDescendants()) do
					if v:IsA("BasePart") then
						local newcham = Instance.new("BoxHandleAdornment", v)
						newcham.Adornee = v
						newcham.Visible = false
						newcham.AlwaysOnTop = true
						newcham.ZIndex = 1
						task.spawn(function()
							RunService.PreRender:Connect(function()
								if newcham then
									newcham.Visible = _G.PlayerESP
									newcham.Color3 = _G.PlayerESPColor
									newcham.Transparency = _G.PlayerESPTransparency
									newcham.Size = v.Size
								end
							end)
						end)
					end
				end
			end
		end
	end)
end)

-- rebel dealer esp

_G.RebelESP = false
local RebelESPToggle = WorldSection:NewToggle("Rebel Dealer Chams", "Draws chams around the Rebel Dealer, to easily spot him.", function(state)
	if state then
		_G.RebelESP = true
	else
		_G.RebelESP = false
	end
end)

_G.RebelChamsTransparency = 0
local RebelChamsTransparencyBox = WorldSection:NewTextBox("Rebel Dealer Chams Transparency", "Defines the transparency of the rebel dealer chams.", function(txt)
	_G.RebelChamsTransparency = tonumber(txt)
end)
_G.RebelChamsColor = Color3.fromRGB(0,0,0)
local RebelChamsColorPicker = WorldSection:NewColorPicker("Rebel Dealer Chams Color", "Defines the color of the rebel dealer chams.", Color3.fromRGB(0,0,0), function(color)
	_G.RebelChamsColor = color
end)

task.spawn(function(rebeldealeresp)
	RunService.PreRender:Connect(function()
		local mapfolder = Workspace:FindFirstChild("Map")
		if (mapfolder) then
			local Shopz = mapfolder:FindFirstChild("Shopz")
			if (Shopz) then
				local RebelDealer = Shopz:FindFirstChild("RebelDealer")
				if (RebelDealer) then
					local DealerMan = RebelDealer:FindFirstChild("DealerMan")
					if (DealerMan) then
						if not (DealerMan:HasTag("chams")) then
							DealerMan:AddTag("chams")
							for i,v in pairs(DealerMan:GetDescendants()) do
								if v:IsA("BasePart") then
									local newcham = Instance.new("BoxHandleAdornment", v)
									newcham.Adornee = v
									newcham.Visible = false
									newcham.AlwaysOnTop = true
									newcham.ZIndex = 1
									task.spawn(function()
										RunService.PreRender:Connect(function()
											if newcham then
												newcham.Visible = _G.RebelESP
												newcham.Color3 = _G.RebelChamsColor
												newcham.Transparency = _G.RebelChamsTransparency
												newcham.Size = v.Size
											end
										end)
									end)
								end
							end
						end
					end
				end
			end
		end
	end)
end)

-- dealers esp

_G.DealerESP = false
local DealerESPToggle = WorldSection:NewToggle("Dealer Chams", "Draws chams around any Dealer, to easily spot them.", function(state)
	if state then
		_G.DealerESP = true
	else
		_G.DealerESP = false
	end
end)

_G.DealerESPTransparency = 0
local DealerESPTransparencyBox = WorldSection:NewTextBox("Dealer Chams Transparency", "Defines the transparency of the dealer chams.", function(txt)
	_G.DealerESPTransparency = tonumber(txt)
end)
_G.DealerChamsColor = Color3.fromRGB(0,0,0)
local DealerChamsColorPicker = WorldSection:NewColorPicker("Dealer Chams Color", "Defines the color of the dealer chams.", Color3.fromRGB(0,0,0), function(color)
	_G.DealerChamsColor = color
end)

local Dealers = {}

for i,v in pairs(Workspace:WaitForChild("Map"):WaitForChild("Shopz"):GetChildren()) do
	if v.Name == "ArmoryDealer" or v.Name == "Dealer" then
		table.insert(Dealers, v)
	end
end


Workspace:WaitForChild("Map"):WaitForChild("Shopz").ChildAdded:Connect(function(v)
	if v.Name == "ArmoryDealer" or v.Name == "Dealer" then
		table.insert(Dealers, v)
	end
end)

task.spawn(function()
	RunService.PreRender:Connect(function()
		for i,v in pairs(Dealers) do
			if not (v:HasTag("chams")) then
				v:AddTag("chams")
				for _, z in pairs(v:GetDescendants()) do
					if z:IsA("BasePart") then
						local newcham = Instance.new("BoxHandleAdornment", z)
						newcham.Adornee = z
						newcham.Visible = false
						newcham.AlwaysOnTop = true
						newcham.ZIndex = 1
						task.spawn(function()
							RunService.PreRender:Connect(function()
								if newcham then
									newcham.Visible = _G.DealerESP
									newcham.Color3 = _G.DealerChamsColor
									newcham.Transparency = _G.DealerESPTransparency
									newcham.Size = z.Size
								end
							end)
						end)
					end
				end
			end
		end
	end)
end)

-- atm esp

_G.ATMChams = false
local ATMChamsToggle = WorldSection:NewToggle("ATM Chams", "Draws chams around any ATM, to easily spot them.", function(state)
	if state then
		_G.ATMChams = true
	else
		_G.ATMChams = false
	end
end)

_G.ATMChamsTransparency = 0
local ATMChamsTransparencyBox = WorldSection:NewTextBox("ATM Chams Transparency", "Defines the transparency of the ATM chams.", function(txt)
	_G.ATMChamsTransparency = tonumber(txt)
end)
_G.ATMChamsColor = Color3.fromRGB(0,0,0)
local ATMChamsColor = WorldSection:NewColorPicker("ATM Chams Color", "Defines the color of the ATM chams.", Color3.fromRGB(0,0,0), function(color)
	_G.ATMChamsColor = color
end)

local ATMS = {}

for i,v in pairs(Workspace:WaitForChild("Map"):WaitForChild("ATMz"):GetChildren()) do
	if v.Name == "ATM" then
		table.insert(ATMS, v)
	end
end


Workspace:WaitForChild("Map"):WaitForChild("ATMz").ChildAdded:Connect(function(v)
	if v.Name == "ATM" then
		table.insert(ATMS, v)
	end
end)

task.spawn(function()
	RunService.PreRender:Connect(function()
		for i,v in pairs(ATMS) do
			if not (v:HasTag("chams")) then
				v:AddTag("chams")
				for _, z in pairs(v:GetDescendants()) do
					if z:IsA("BasePart") then
						local newcham = Instance.new("BoxHandleAdornment", z)
						newcham.Adornee = z
						newcham.Visible = false
						newcham.AlwaysOnTop = true
						newcham.ZIndex = 1
						task.spawn(function()
							RunService.PreRender:Connect(function()
								if newcham then
									newcham.Visible = _G.ATMChams
									newcham.Color3 = _G.ATMChamsColor
									newcham.Transparency = _G.ATMChamsTransparency
									newcham.Size = z.Size
								end
							end)
						end)
					end
				end
			end
		end
	end)
end)

-- money esp

_G.MoneyChams = false
local MoneyChamsToggle = WorldSection:NewToggle("Money Chams", "Draws chams around any dropped money, to easily spot them.", function(state)
	if state then
		_G.MoneyChams = true
	else
		_G.MoneyChams = false
	end
end)

_G.MoneyChamsTransparency = 0
local MoneyChamsTransparencyBox = WorldSection:NewTextBox("Money Chams Transparency", "Defines the transparency of the money chams.", function(txt)
	_G.MoneyChamsTransparency = tonumber(txt)
end)
_G.MoneyChamsColor = Color3.fromRGB(0,0,0)
local MoneyChamsColorPicker = WorldSection:NewColorPicker("Money Chams Color", "Defines the color of the money chams.", Color3.fromRGB(0,0,0), function(color)
	_G.MoneyChamsColor = color
end)

local Money = {}

for i,v in pairs(Workspace:WaitForChild("Filter"):WaitForChild("SpawnedBread"):GetChildren()) do
	if string.find(v.Name, "Drop") then
		table.insert(Money, v)
	end
end


Workspace:WaitForChild("Filter"):WaitForChild("SpawnedBread").ChildAdded:Connect(function(v)
	if string.find(v.Name, "Drop") then
		table.insert(Money, v)
	end
end)

task.spawn(function()
	RunService.PreRender:Connect(function()
		for i,v in pairs(Money) do
			if not (v:HasTag("chams")) then
				v:AddTag("chams")
				local newcham = Instance.new("BoxHandleAdornment", v)
				newcham.Adornee = v
				newcham.Visible = false
				newcham.AlwaysOnTop = true
				newcham.ZIndex = 1
				task.spawn(function()
					RunService.PreRender:Connect(function()
						if newcham then
							newcham.Visible = _G.MoneyChams
							newcham.Color3 = _G.MoneyChamsColor
							newcham.Transparency = _G.MoneyChamsTransparency
							newcham.Size = v.Size
						end
					end)
				end)
			end
		end
	end)
end)

-- safe/register esp

_G.SafeRegisterESP = false
local SafeRegisterESPToggle = WorldSection:NewToggle("Safe/Register Chams", "Draws chams around any safe/register, to easily spot them.", function(state)
	if state then
		_G.SafeRegisterESP = true
	else
		_G.SafeRegisterESP = false
	end
end)

_G.SafeRegisterESPTransparency = 0
local SafeRegisterESPTransparencyBox = WorldSection:NewTextBox("Safe/Register Chams Transparency", "Defines the transparency of the safe/register chams.", function(txt)
	_G.SafeRegisterESPTransparency = tonumber(txt)
end)
_G.SafeRegisterESPColor = Color3.fromRGB(0,0,0)
local SafeRegisterESPColorPicker = WorldSection:NewColorPicker("Safe/Register Chams Color", "Defines the color of the safe/register chams.", Color3.fromRGB(0,0,0), function(color)
	_G.SafeRegisterESPColor = color
end)

local SafeRegister = {}

for i,v in pairs(Workspace:WaitForChild("Map"):WaitForChild("BredMakurz"):GetChildren()) do
	if v:IsA("Model") then
		table.insert(SafeRegister, v)
	end
end


Workspace:WaitForChild("Map"):WaitForChild("BredMakurz").ChildAdded:Connect(function(v)
	if v:IsA("Model") then
		table.insert(SafeRegister, v)
	end
end)

task.spawn(function()
	RunService.PreRender:Connect(function()
		for i,v in pairs(SafeRegister) do
			if not (v:HasTag("chams")) then
				v:AddTag("chams")
				for _, z in pairs(v:GetDescendants()) do
					if z:IsA("BasePart") then
						local newcham = Instance.new("BoxHandleAdornment", z)
						newcham.Adornee = z
						newcham.Visible = false
						newcham.AlwaysOnTop = true
						newcham.ZIndex = 1
						task.spawn(function()
							RunService.PreRender:Connect(function()
								if newcham then
									newcham.Visible = _G.SafeRegisterESP
									newcham.Color3 = _G.SafeRegisterESPColor
									newcham.Transparency = _G.SafeRegisterESPTransparency
									newcham.Size = z.Size
								end
							end)
						end)
					end
				end
			end
		end
	end)
end)

-- tools esp

_G.ToolsESP = false
local ToolsESPToggle = WorldSection:NewToggle("Dropped Tools Chams", "Draws chams around any dropped tool, to easily spot them.", function(state)
	if state then
		_G.ToolsESP = true
	else
		_G.ToolsESP = false
	end
end)

_G.ToolsESPTransparency = 0
local ToolsESPTransparencyBox = WorldSection:NewTextBox("Dropped Tools Chams Transparency", "Defines the transparency of the dropped tools chams.", function(txt)
	_G.ToolsESPTransparency = tonumber(txt)
end)
_G.ToolsESPColor = Color3.fromRGB(0,0,0)
local ToolsESPColorPicker = WorldSection:NewColorPicker("Droped Tools Chams Color", "Defines the color of the droped tools chams.", Color3.fromRGB(0,0,0), function(color)
	_G.ToolsESPColor = color
end)

local DroppedTools = {}

for i,v in pairs(Workspace:WaitForChild("Filter"):WaitForChild("SpawnedTools"):GetChildren()) do
	if v:IsA("Model") then
		table.insert(DroppedTools, v)
	end
end


Workspace:WaitForChild("Filter"):WaitForChild("SpawnedTools").ChildAdded:Connect(function(v)
	if v:IsA("Model") then
		table.insert(DroppedTools, v)
	end
end)

task.spawn(function()
	RunService.PreRender:Connect(function()
		for i,v in pairs(DroppedTools) do
			if not (v:HasTag("chams")) then
				v:AddTag("chams")
				for _, z in pairs(v:GetDescendants()) do
					if z:IsA("BasePart") then
						local newcham = Instance.new("BoxHandleAdornment", z)
						newcham.Adornee = z
						newcham.Visible = false
						newcham.AlwaysOnTop = true
						newcham.ZIndex = 1
						task.spawn(function()
							RunService.PreRender:Connect(function()
								if newcham then
									newcham.Visible = _G.ToolsESP
									newcham.Color3 = _G.ToolsESPColor
									newcham.Transparency = _G.ToolsESPTransparency
									newcham.Size = z.Size
								end
							end)
						end)
					end
				end
			end
		end
	end)
end)

-- scrap esp

_G.ScrapESP = false
local ScrapESPToggle = WorldSection:NewToggle("Scrap Chams", "Draws chams around any scrap, to easily spot them.", function(state)
	if state then
		_G.ScrapESP = true
	else
		_G.ScrapESP = false
	end
end)

_G.ScrapESPTransparency = 0
local ScrapESPTransparencyBox = WorldSection:NewTextBox("Scrap Chams Transparency", "Defines the transparency of the scrap chams.", function(txt)
	_G.ScrapESPTransparency = tonumber(txt)
end)
_G.ScrapESPColor = Color3.fromRGB(0,0,0)
local ScrapESPColorPicker = WorldSection:NewColorPicker("Scrap Chams Color", "Defines the color of the scrap chams.", Color3.fromRGB(0,0,0), function(color)
	_G.ScrapESPColor = color
end)

local Scraps = {}

for i,v in pairs(Workspace:WaitForChild("Filter"):WaitForChild("SpawnedPiles"):GetChildren()) do
	if v:IsA("Model") then
		table.insert(Scraps, v)
	end
end


Workspace:WaitForChild("Filter"):WaitForChild("SpawnedPiles").ChildAdded:Connect(function(v)
	if v:IsA("Model") then
		table.insert(Scraps, v)
	end
end)

task.spawn(function()
	RunService.PreRender:Connect(function()
		for i,v in pairs(Scraps) do
			if not (v:HasTag("chams")) then
				v:AddTag("chams")
				for _, z in pairs(v:GetDescendants()) do
					if z:IsA("BasePart") then
						local newcham = Instance.new("BoxHandleAdornment", z)
						newcham.Adornee = z
						newcham.Visible = false
						newcham.AlwaysOnTop = true
						newcham.ZIndex = 1
						task.spawn(function()
							RunService.PreRender:Connect(function()
								if newcham then
									newcham.Visible = _G.ScrapESP
									newcham.Color3 = _G.ScrapESPColor
									newcham.Transparency = _G.ScrapESPTransparency
									newcham.Size = z.Size
								end
							end)
						end)
					end
				end
			end
		end
	end)
end)


-- // Anti-Aim

_G.SpinbotToggled = false
local SpinbotToggle = AntiAim_Section1:NewToggle("Spinbot", "Toggles Spinbot On/Off.", function(state)
	if state then
		_G.SpinbotToggled = true
	else
		_G.SpinbotToggled = false
	end
end)

_G.SpinbotSpeed = 0
local Rage_Slider1 = AntiAim_Section1:NewSlider("Spinbot Speed", "Adjusts how much degrees the spinbot will rotate your character per step.", 360, 0, function(Value)
	_G.SpinbotSpeed = Value
end)


_G.AngleEnabled = false
local AngleToggle = AntiAim_Section1:NewToggle("Angle", "Toggles angle on/off.", function(state)
	if state then
		_G.AngleEnabled = true
	else
		_G.AngleEnabled = false
	end
end)

_G.AngleSelected = ""
local AngleList = {"Mouse", "Camera"}
local AngleDropdown = AntiAim_Section1:NewDropdown("Angle","Select the angle you want. Use spinbot for an offset.", AngleList, function(Value)
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

_G.NearLock = false
local NearLockToggle = AntiAim_Section1:NewToggle("LookAt Near Players", "Makes your character point toward the nearest player.", function(state)
	if state then
		_G.NearLock = true
	else
		_G.NearLock = false
	end
end)

task.spawn(function(nearlockk)
	task.spawn(function(nearlockk)
		RunService.PreRender:Connect(function()
			if _G.NearLock == true then
				local char = Self.Character
				if (char and char ~= nil) then
					local nearplayer = findNearestLimb(Self, "Torso", 25)
					if nearplayer then
						local hrp = char:FindFirstChild("HumanoidRootPart")
						if hrp then
							hrp.CFrame = CFrame.lookAt(hrp.CFrame.Position, Vector3.new(nearplayer.CFrame.Position.X, hrp.Position.Y, nearplayer.CFrame.Position.Z))
						end
					end
				end
			end
		end)
	end)
end)

local RemoveAnimator = SelfSection:NewButton("Remove Animator", "[RISKY] Removes your animator, freezing your character's animations.", function()
	local Character = Self.Character
	if (Character and Character ~= nil) then
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		if (Humanoid and Humanoid ~= nil) then
			local Animator = Humanoid:FindFirstChildOfClass("Animator")
			if (Animator and Animator ~= nil) then
				task.defer(Animator.Remove, Animator)
			end
		end
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

_G.InfStaminaToggled = false
local InfStaminaToggle = MiscSection:NewToggle("Infinite Stamina", "Grants you infinite stamina.", function(state)
	if state then
		_G.InfStaminaToggled = true
	else
		_G.InfStaminaToggled = false
	end
end)


task.spawn(function(infstam)
	local infstamconnection = RunService.PreRender:Connect(function()
		if _G.InfStaminaToggled == true then
			local r = game:GetService("ReplicatedStorage")
			if r then
				local ev2 = r:FindFirstChild("Events2")
				if ev2 then
					local staminachange = ev2:FindFirstChild("StaminaChange")
					if staminachange then
						staminachange:Fire(100, 100)
					end
				end
			end
		end
	end)
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

-- // Map

_G.NoDebrisToggled = false
local NoDebrisToggle = MapSection:NewToggle("No Debris", "Visually removes all type of debris.", function(state)
	if state then
		_G.NoDebrisToggled = true
	else
		_G.NoDebrisToggled = false
	end
end)

local RemoveWater = MapSection:NewButton("Remove Water", "Removes water from the map.", function()
	task.defer(Terrain.Clear, Terrain)
	local Filter = Workspace:FindFirstChild("Filter")
	if (Filter and Filter ~= nil) then
		local WaterCurrents = Filter:FindFirstChild("WaterCurrents")
		if (WaterCurrents and WaterCurrents ~= nil) then
			task.defer(WaterCurrents.Remove, WaterCurrents)
		end
	end
end)

local RemoveCombatZones = MapSection:NewButton("Remove Combat Zones", "Removes combat zones from the map.", function()
	local Filter = Workspace:FindFirstChild("Filter")
	if (Filter and Filter ~= nil) then
		local CombatZones = Filter:FindFirstChild("CombatZones")
		if (CombatZones and CombatZones ~= nil) then
			task.defer(CombatZones.Remove, CombatZones)
		end
	end
end)

local RemoveInvisibleParts = MapSection:NewButton("Remove Invisible Parts", "Removes invisible parts from the map.", function()
	local Filter = Workspace:FindFirstChild("Filter")
	if (Filter and Filter ~= nil) then
		local Parts = Filter:FindFirstChild("Parts")
		if (Parts and Parts ~= nil) then
			local Invis = Parts:FindFirstChild("Invis")
			if (Invis and Invis ~= nil) then
				task.defer(Invis.Remove, Invis)
			end
		end
	end
end)

local RemoveMapping = MapSection:NewButton("Remove Mapping", "Allows you to reach restricted places.", function()
	local Filter = Workspace:FindFirstChild("Filter")
	if (Filter and Filter ~= nil) then
		local Parts = Filter:FindFirstChild("Parts")
		if (Parts and Parts ~= nil) then
			local Mapping = Parts:FindFirstChild("Mapping")
			if (Mapping and Mapping ~= nil) then
				task.defer(Mapping.Remove, Mapping)
			end
		end
	end
end)

local RemoveLights = MapSection:NewButton("Remove Lights", "Remove useless lights, if you have fullbright on.", function()
	local Filter = Workspace:FindFirstChild("Filter")
	if (Filter and Filter ~= nil) then
		local Parts = Filter:FindFirstChild("Parts")
		if (Parts and Parts ~= nil) then
			local Lights = Parts:FindFirstChild("Lights")
			if (Lights and Lights ~= nil) then
				task.defer(Lights.Remove, Lights)
			end
		end
	end
end)

local RemoveMeshes = MapSection:NewButton("Remove Meshes", "Remove useless meshes.", function()
	local Filter = Workspace:FindFirstChild("Filter")
	if (Filter and Filter ~= nil) then
		local Parts = Filter:FindFirstChild("Parts")
		if (Parts and Parts ~= nil) then
			local Meshes = Parts:FindFirstChild("Meshes")
			if (Meshes and Meshes ~= nil) then
				task.defer(Meshes.Remove, Meshes)
			end
		end
	end
end)

local RemoveJunk = MapSection:NewButton("Remove Junk", "Remove useless parts.", function()
	local Filter = Workspace:FindFirstChild("Filter")
	if (Filter and Filter ~= nil) then
		local Parts = Filter:FindFirstChild("Parts")
		if (Parts and Parts ~= nil) then
			local Parts2 = Parts:FindFirstChild("Parts")
			if (Parts2 and Parts2 ~= nil) then
				task.defer(Parts2.Remove, Parts2)
			end
		end
	end
end)

local RemoveSecurity = MapSection:NewButton("Remove Security", "Removes alarms & cameras.", function()
	local MapFolder = Workspace:FindFirstChild("Map")
	if (MapFolder and MapFolder ~= nil) then
		local Security = MapFolder:FindFirstChild("Security")
		if (Security and Security ~= nil) then
			task.defer(Security.Remove, Security)
		end
	end
end)

local RemoveStreetLights = MapSection:NewButton("Remove Street Lights", "Removes street lights.", function()
	local MapFolder = Workspace:FindFirstChild("Map")
	if (MapFolder and MapFolder ~= nil) then
		local StreetLights = MapFolder:FindFirstChild("StreetLights")
		if (StreetLights and StreetLights ~= nil) then
			task.defer(StreetLights.Remove, StreetLights)
		end
	end
end)

local RemoveDoors = MapSection:NewButton("Remove Doors", "Removes doors.", function()
	local MapFolder = Workspace:FindFirstChild("Map")
	if (MapFolder and MapFolder ~= nil) then
		local Doors = MapFolder:FindFirstChild("Doors")
		if (Doors and Doors ~= nil) then
			task.defer(Doors.Remove, Doors)
		end
	end
end)


local RemoveProps = MapSection:NewButton("Remove Props", "Removes props.", function()
	local MapFolder = Workspace:FindFirstChild("Map")
	if (MapFolder and MapFolder ~= nil) then
		local MParts = MapFolder:FindFirstChild("MParts")
		if (MParts and MParts ~= nil) then
			local MParts2 = MParts:FindFirstChild("M_Parts")
			if (MParts2 and MParts2 ~= nil) then
				local Props = MParts2:FindFirstChild("Props")
				if (Props and Props ~= nil) then
					task.defer(Props.Remove, Props)
				end
			end
		end
	end
end)





task.spawn(function(NoDebris)
	local NoDebrisConnection = RunService.PreRender:Connect(function()
		if _G.NoDebrisToggled == true then
			local Debris = Workspace:FindFirstChild("Debris")
			if (Debris and Debris ~= nil) then
				local VParts = Debris:FindFirstChild("VParts")
				local NParts = Debris:FindFirstChild("NParts")
				local BloodInstances = Debris:FindFirstChild("BloodInstances")
				local ToClear = Debris:FindFirstChild("ToClear")
				if (NParts and NParts ~= nil) then
					task.defer(NParts.Remove, NParts)
				end
				if (VParts and VParts ~= nil) then
					task.defer(VParts.Remove, VParts)
				end
				if (BloodInstances and BloodInstances ~= nil) then
					task.defer(BloodInstances.Remove, BloodInstances)
				end
				if (ToClear and ToClear ~= nil) then
					task.defer(ToClear.Remove, ToClear)
				end

			end
		end
	end)
end)
