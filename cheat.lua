--==============================================================
-- CYBER ADMIN HUB
-- Roblox Studio / Luau
-- LocalScript -> StarterPlayer > StarterPlayerScripts
-- OPEN / CLOSE: 0
--==============================================================

--// SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Camera = Workspace.CurrentCamera

--==============================================================
-- SAFE CALL
--==============================================================

local function pcallSafe(fn, ...)
	local ok, result = pcall(fn, ...)
	if not ok then
		warn("[CyberHub]", result)
	end
	return ok, result
end

--==============================================================
-- CONFIG
--==============================================================

local Config = {
	MenuKey = Enum.KeyCode.Zero,

	AimAssist = false,
	AimFOV = 100,
	AimSmooth = 0.2,
	WallCheck = true,

	ESP = false,
	ESPNames = true,
	ESPDistance = true,
	ESPHealth = true,

	Fly = false,
	FlySpeed = 60,

	Speed = false,
	WalkSpeed = 32,

	Jump = false,
	JumpPower = 65,

	Noclip = false,
	InfiniteJump = false,
	BunnyHop = false,

	Fullbright = false,
	Freecam = false,
	CameraFOV = 70,

	SpinBot = false,
	SpinSpeed = 10,
}

_G.CyberAdminConfig = Config

--==============================================================
-- CHARACTER
--==============================================================

local Character
local Humanoid
local Root

local function updateCharacter()
	local char = Player.Character

	if not char then
		return
	end

	Character = char
	Humanoid = char:FindFirstChildOfClass("Humanoid")
	Root = char:FindFirstChild("HumanoidRootPart")

	if not Humanoid then
		Humanoid = char:WaitForChild("Humanoid", 5)
	end

	if not Root then
		Root = char:WaitForChild("HumanoidRootPart", 5)
	end
end

updateCharacter()

Player.CharacterAdded:Connect(function(char)
	Character = char
	Humanoid = char:WaitForChild("Humanoid", 5)
	Root = char:WaitForChild("HumanoidRootPart", 5)
end)

Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	Camera = Workspace.CurrentCamera
end)

--==============================================================
-- REMOVE OLD GUI
--==============================================================

local oldGui = PlayerGui:FindFirstChild("CyberAdminHub")

if oldGui then
	oldGui:Destroy()
end

--==============================================================
-- SCREEN GUI
--==============================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CyberAdminHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

--==============================================================
-- MAIN
--==============================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(850, 540)
Main.Position = UDim2.new(0.5, -425, 0.5, -270)
Main.BackgroundColor3 = Color3.fromRGB(8, 10, 17)
Main.BorderSizePixel = 0
Main.Visible = true
Main.ZIndex = 10
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 210, 255)
MainStroke.Thickness = 1.5
MainStroke.Parent = Main

--==============================================================
-- HEADER
--==============================================================

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 65)
Header.BackgroundColor3 = Color3.fromRGB(13, 17, 27)
Header.BorderSizePixel = 0
Header.ZIndex = 11
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 14)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.BackgroundTransparency = 1
Title.Position = UDim2.fromOffset(20, 8)
Title.Size = UDim2.fromOffset(400, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "CYBER"
Title.TextSize = 24
Title.TextColor3 = Color3.fromRGB(0, 225, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 12
Title.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.fromOffset(22, 38)
Subtitle.Size = UDim2.fromOffset(500, 18)
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "ADMIN / DEBUG HUB  •  PRESS 0"
Subtitle.TextSize = 11
Subtitle.TextColor3 = Color3.fromRGB(120, 135, 155)
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.ZIndex = 12
Subtitle.Parent = Header

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(38, 38)
Close.Position = UDim2.new(1, -50, 0, 13)
Close.BackgroundColor3 = Color3.fromRGB(25, 29, 42)
Close.BorderSizePixel = 0
Close.Text = "×"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 24
Close.TextColor3 = Color3.fromRGB(255, 80, 105)
Close.AutoButtonColor = false
Close.ZIndex = 13
Close.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 9)
CloseCorner.Parent = Close

Close.MouseButton1Click:Connect(function()
	Main.Visible = false
end)

--==============================================================
-- SIDEBAR
--==============================================================

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Position = UDim2.fromOffset(12, 77)
Sidebar.Size = UDim2.fromOffset(170, 450)
Sidebar.BackgroundColor3 = Color3.fromRGB(11, 14, 23)
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 11
Sidebar.Parent = Main

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 11)
SidebarCorner.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 10)
SidebarPadding.PaddingLeft = UDim.new(0, 8)
SidebarPadding.PaddingRight = UDim.new(0, 8)
SidebarPadding.Parent = Sidebar

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Padding = UDim.new(0, 5)
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Parent = Sidebar

--==============================================================
-- CONTENT
--==============================================================

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Position = UDim2.fromOffset(193, 77)
Content.Size = UDim2.new(1, -205, 1, -90)
Content.BackgroundTransparency = 1
Content.ZIndex = 11
Content.Parent = Main

--==============================================================
-- TABS
--==============================================================

local Pages = {}
local Buttons = {}

local function createTab(tabName)

	local Button = Instance.new("TextButton")
	Button.Name = tabName .. "Button"
	Button.Size = UDim2.new(1, 0, 0, 42)
	Button.BackgroundColor3 = Color3.fromRGB(17, 21, 32)
	Button.BorderSizePixel = 0
	Button.Text = tabName
	Button.Font = Enum.Font.GothamMedium
	Button.TextSize = 13
	Button.TextColor3 = Color3.fromRGB(155, 165, 180)
	Button.AutoButtonColor = false
	Button.ZIndex = 12
	Button.Parent = Sidebar

	local ButtonCorner = Instance.new("UICorner")
	ButtonCorner.CornerRadius = UDim.new(0, 8)
	ButtonCorner.Parent = Button

	local Page = Instance.new("ScrollingFrame")
	Page.Name = tabName .. "Page"
	Page.Size = UDim2.fromScale(1, 1)
	Page.BackgroundTransparency = 1
	Page.BorderSizePixel = 0
	Page.ScrollBarThickness = 3
	Page.ScrollBarImageColor3 = Color3.fromRGB(0, 210, 255)
	Page.CanvasSize = UDim2.new(0, 0, 0, 0)
	Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	Page.Visible = false
	Page.ZIndex = 12
	Page.Parent = Content

	local PageLayout = Instance.new("UIListLayout")
	PageLayout.Padding = UDim.new(0, 8)
	PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
	PageLayout.Parent = Page

	local PagePadding = Instance.new("UIPadding")
	PagePadding.PaddingBottom = UDim.new(0, 15)
	PagePadding.PaddingRight = UDim.new(0, 8)
	PagePadding.Parent = Page

	Pages[tabName] = Page
	Buttons[tabName] = Button

	Button.MouseButton1Click:Connect(function()

		for name, page in pairs(Pages) do
			page.Visible = name == tabName
		end

		for name, btn in pairs(Buttons) do
			if name == tabName then
				btn.BackgroundColor3 = Color3.fromRGB(0, 105, 140)
				btn.TextColor3 = Color3.fromRGB(255, 255, 255)
			else
				btn.BackgroundColor3 = Color3.fromRGB(17, 21, 32)
				btn.TextColor3 = Color3.fromRGB(155, 165, 180)
			end
		end
	end)

	return Page
end

local Combat = createTab("Combat")
local Visuals = createTab("Visuals")
local Movement = createTab("Movement")
local Teleports = createTab("Teleports")
local World = createTab("World / Misc")
local Fun = createTab("Troll / Fun")
local Settings = createTab("Settings")

--==============================================================
-- UI HELPERS
--==============================================================

local function createSection(parent, text)

	local Label = Instance.new("TextLabel")
	Label.Size = UDim2.new(1, 0, 0, 32)
	Label.BackgroundTransparency = 1
	Label.Text = "  " .. text
	Label.Font = Enum.Font.GothamBold
	Label.TextSize = 13
	Label.TextColor3 = Color3.fromRGB(0, 220, 255)
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.ZIndex = 13
	Label.Parent = parent

	return Label
end

local function createButton(parent, text, callback)

	local Button = Instance.new("TextButton")
	Button.Size = UDim2.new(1, 0, 0, 40)
	Button.BackgroundColor3 = Color3.fromRGB(18, 22, 34)
	Button.BorderSizePixel = 0
	Button.Text = text
	Button.Font = Enum.Font.GothamMedium
	Button.TextSize = 13
	Button.TextColor3 = Color3.fromRGB(225, 230, 240)
	Button.AutoButtonColor = false
	Button.ZIndex = 13
	Button.Parent = parent

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 8)
	Corner.Parent = Button

	Button.MouseEnter:Connect(function()
		Button.BackgroundColor3 = Color3.fromRGB(25, 43, 58)
	end)

	Button.MouseLeave:Connect(function()
		Button.BackgroundColor3 = Color3.fromRGB(18, 22, 34)
	end)

	Button.MouseButton1Click:Connect(function()
		pcallSafe(callback)
	end)

	return Button
end

local function createToggle(parent, text, initial, callback)

	local State = initial

	local Button = Instance.new("TextButton")
	Button.Size = UDim2.new(1, 0, 0, 42)
	Button.BackgroundColor3 = Color3.fromRGB(18, 22, 34)
	Button.BorderSizePixel = 0
	Button.Text = ""
	Button.AutoButtonColor = false
	Button.ZIndex = 13
	Button.Parent = parent

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 8)
	Corner.Parent = Button

	local Label = Instance.new("TextLabel")
	Label.BackgroundTransparency = 1
	Label.Position = UDim2.fromOffset(14, 0)
	Label.Size = UDim2.new(1, -75, 1, 0)
	Label.Text = text
	Label.Font = Enum.Font.GothamMedium
	Label.TextSize = 13
	Label.TextColor3 = Color3.fromRGB(220, 225, 235)
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.ZIndex = 14
	Label.Parent = Button

	local Switch = Instance.new("Frame")
	Switch.Size = UDim2.fromOffset(40, 21)
	Switch.Position = UDim2.new(1, -53, 0.5, -10)
	Switch.BorderSizePixel = 0
	Switch.ZIndex = 14
	Switch.Parent = Button

	local SwitchCorner = Instance.new("UICorner")
	SwitchCorner.CornerRadius = UDim.new(1, 0)
	SwitchCorner.Parent = Switch

	local Dot = Instance.new("Frame")
	Dot.Size = UDim2.fromOffset(17, 17)
	Dot.Position = UDim2.fromOffset(2, 2)
	Dot.BorderSizePixel = 0
	Dot.ZIndex = 15
	Dot.Parent = Switch

	local DotCorner = Instance.new("UICorner")
	DotCorner.CornerRadius = UDim.new(1, 0)
	DotCorner.Parent = Dot

	local function refresh()

		if State then
			Switch.BackgroundColor3 = Color3.fromRGB(0, 155, 195)
			Dot.BackgroundColor3 = Color3.fromRGB(235, 255, 255)
			Dot.Position = UDim2.fromOffset(21, 2)
		else
			Switch.BackgroundColor3 = Color3.fromRGB(48, 52, 65)
			Dot.BackgroundColor3 = Color3.fromRGB(135, 140, 155)
			Dot.Position = UDim2.fromOffset(2, 2)
		end

		pcallSafe(callback, State)
	end

	Button.MouseButton1Click:Connect(function()
		State = not State
		refresh()
	end)

	refresh()

	return {
		Set = function(value)
			State = value
			refresh()
		end,

		Get = function()
			return State
		end
	}
end

local function createSlider(parent, text, minimum, maximum, default, callback)

	local Holder = Instance.new("Frame")
	Holder.Size = UDim2.new(1, 0, 0, 60)
	Holder.BackgroundColor3 = Color3.fromRGB(18, 22, 34)
	Holder.BorderSizePixel = 0
	Holder.ZIndex = 13
	Holder.Parent = parent

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 8)
	Corner.Parent = Holder

	local Label = Instance.new("TextLabel")
	Label.BackgroundTransparency = 1
	Label.Position = UDim2.fromOffset(13, 5)
	Label.Size = UDim2.new(1, -80, 0, 20)
	Label.Text = text
	Label.Font = Enum.Font.GothamMedium
	Label.TextSize = 12
	Label.TextColor3 = Color3.fromRGB(210, 215, 225)
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.ZIndex = 14
	Label.Parent = Holder

	local Value = Instance.new("TextLabel")
	Value.BackgroundTransparency = 1
	Value.Position = UDim2.new(1, -65, 0, 5)
	Value.Size = UDim2.fromOffset(55, 20)
	Value.Text = tostring(default)
	Value.Font = Enum.Font.GothamBold
	Value.TextSize = 12
	Value.TextColor3 = Color3.fromRGB(0, 220, 255)
	Value.TextXAlignment = Enum.TextXAlignment.Right
	Value.ZIndex = 14
	Value.Parent = Holder

	local Bar = Instance.new("Frame")
	Bar.Position = UDim2.new(0, 13, 1, -19)
	Bar.Size = UDim2.new(1, -26, 0, 5)
	Bar.BackgroundColor3 = Color3.fromRGB(43, 48, 61)
	Bar.BorderSizePixel = 0
	Bar.ZIndex = 14
	Bar.Parent = Holder

	local BarCorner = Instance.new("UICorner")
	BarCorner.CornerRadius = UDim.new(1, 0)
	BarCorner.Parent = Bar

	local Fill = Instance.new("Frame")
	Fill.Size = UDim2.fromScale(
		math.clamp((default - minimum) / (maximum - minimum), 0, 1),
		1
	)
	Fill.BackgroundColor3 = Color3.fromRGB(0, 205, 240)
	Fill.BorderSizePixel = 0
	Fill.ZIndex = 15
	Fill.Parent = Bar

	local FillCorner = Instance.new("UICorner")
	FillCorner.CornerRadius = UDim.new(1, 0)
	FillCorner.Parent = Fill

	local Dragging = false
	local Current = default

	local function setValue(mouseX)

		local percent = math.clamp(
			(mouseX - Bar.AbsolutePosition.X)
				/ math.max(Bar.AbsoluteSize.X, 1),
			0,
			1
		)

		Current = minimum + (maximum - minimum) * percent

		if maximum - minimum <= 10 then
			Current = math.floor(Current * 100) / 100
		else
			Current = math.floor(Current)
		end

		Fill.Size = UDim2.fromScale(percent, 1)
		Value.Text = tostring(Current)

		pcallSafe(callback, Current)
	end

	Bar.InputBegan:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			Dragging = true
			setValue(input.Position.X)
		end
	end)

	UIS.InputChanged:Connect(function(input)

		if Dragging
			and input.UserInputType == Enum.UserInputType.MouseMovement then

			setValue(input.Position.X)
		end
	end)

	UIS.InputEnded:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			Dragging = false
		end
	end)

	return {
		Get = function()
			return Current
		end,

		Set = function(value)

			Current = math.clamp(value, minimum, maximum)

			local percent =
				(Current - minimum)
				/ (maximum - minimum)

			Fill.Size = UDim2.fromScale(percent, 1)
			Value.Text = tostring(Current)

			pcallSafe(callback, Current)
		end
	}
end

--==============================================================
-- COMBAT
--==============================================================

createSection(Combat, "AIM ASSIST")

createToggle(Combat, "Aim Assist", false, function(value)
	Config.AimAssist = value
end)

createToggle(Combat, "Wall Check", true, function(value)
	Config.WallCheck = value
end)

createSlider(
	Combat,
	"FOV",
	30,
	300,
	Config.AimFOV,
	function(value)
		Config.AimFOV = value
	end
)

createSlider(
	Combat,
	"Smoothness",
	0.01,
	1,
	Config.AimSmooth,
	function(value)
		Config.AimSmooth = value
	end
)

--==============================================================
-- FOV CIRCLE
--==============================================================

local FOVCircle = Instance.new("Frame")
FOVCircle.Name = "FOVCircle"
FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
FOVCircle.Position = UDim2.fromScale(0.5, 0.5)
FOVCircle.Size = UDim2.fromOffset(
	Config.AimFOV * 2,
	Config.AimFOV * 2
)
FOVCircle.BackgroundTransparency = 1
FOVCircle.BorderSizePixel = 0
FOVCircle.Visible = false
FOVCircle.ZIndex = 5
FOVCircle.Parent = ScreenGui

local FOVCorner = Instance.new("UICorner")
FOVCorner.CornerRadius = UDim.new(1, 0)
FOVCorner.Parent = FOVCircle

local FOVStroke = Instance.new("UIStroke")
FOVStroke.Color = Color3.fromRGB(0, 220, 255)
FOVStroke.Thickness = 1
FOVStroke.Transparency = 0.2
FOVStroke.Parent = FOVCircle

--==============================================================
-- VISUALS
--==============================================================

createSection(Visuals, "VISUAL ESP")

createToggle(Visuals, "ESP / Highlight", false, function(value)
	Config.ESP = value
end)

createToggle(Visuals, "Names", true, function(value)
	Config.ESPNames = value
end)

createToggle(Visuals, "Distance", true, function(value)
	Config.ESPDistance = value
end)

createToggle(Visuals, "Health", true, function(value)
	Config.ESPHealth = value
end)

--==============================================================
-- ESP
--==============================================================

local ESPObjects = {}

local function removeESP(model)

	local data = ESPObjects[model]

	if not data then
		return
	end

	if data.Highlight then
		pcallSafe(function()
			data.Highlight:Destroy()
		end)
	end

	if data.Billboard then
		pcallSafe(function()
			data.Billboard:Destroy()
		end)
	end

	ESPObjects[model] = nil
end

local function createESP(model)

	if not model or not model:IsA("Model") then
		return
	end

	if model == Character then
		return
	end

	if ESPObjects[model] then
		return
	end

	local humanoid = model:FindFirstChildOfClass("Humanoid")

	if not humanoid then
		return
	end

	local head = model:FindFirstChild("Head")
	local root = model:FindFirstChild("HumanoidRootPart")

	local adornee = head or root

	if not adornee or not adornee:IsA("BasePart") then
		return
	end

	--==========================================================
	-- HIGHLIGHT
	--==========================================================

	local highlight = Instance.new("Highlight")
	highlight.Name = "CyberESP"
	highlight.Adornee = model
	highlight.FillColor = Color3.fromRGB(0, 170, 255)
	highlight.OutlineColor = Color3.fromRGB(0, 240, 255)
	highlight.FillTransparency = 0.65
	highlight.OutlineTransparency = 0
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Enabled = Config.ESP
	highlight.Parent = model

	--==========================================================
	-- BILLBOARD
	--==========================================================

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "CyberESPInfo"
	billboard.Adornee = adornee
	billboard.Size = UDim2.fromOffset(240, 78)
	billboard.StudsOffset = Vector3.new(0, 3.5, 0)
	billboard.AlwaysOnTop = true
	billboard.MaxDistance = 10000
	billboard.Enabled = Config.ESP
	billboard.Parent = PlayerGui

	--==========================================================
	-- NAME
	--==========================================================

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Name = "Name"
	nameLabel.BackgroundTransparency = 1
	nameLabel.Size = UDim2.new(1, 0, 0, 24)
	nameLabel.Position = UDim2.fromOffset(0, 0)
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextSize = 15
	nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	nameLabel.TextStrokeTransparency = 0
	nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	nameLabel.TextXAlignment = Enum.TextXAlignment.Center
	nameLabel.Parent = billboard

	--==========================================================
	-- HEALTH
	--==========================================================

	local healthLabel = Instance.new("TextLabel")
	healthLabel.Name = "Health"
	healthLabel.BackgroundTransparency = 1
	healthLabel.Size = UDim2.new(1, 0, 0, 20)
	healthLabel.Position = UDim2.fromOffset(0, 23)
	healthLabel.Font = Enum.Font.GothamBold
	healthLabel.TextSize = 13
	healthLabel.TextStrokeTransparency = 0
	healthLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	healthLabel.TextXAlignment = Enum.TextXAlignment.Center
	healthLabel.Parent = billboard

	--==========================================================
	-- DISTANCE
	--==========================================================

	local distanceLabel = Instance.new("TextLabel")
	distanceLabel.Name = "Distance"
	distanceLabel.BackgroundTransparency = 1
	distanceLabel.Size = UDim2.new(1, 0, 0, 20)
	distanceLabel.Position = UDim2.fromOffset(0, 43)
	distanceLabel.Font = Enum.Font.Gotham
	distanceLabel.TextSize = 12
	distanceLabel.TextColor3 = Color3.fromRGB(190, 220, 255)
	distanceLabel.TextStrokeTransparency = 0
	distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	distanceLabel.TextXAlignment = Enum.TextXAlignment.Center
	distanceLabel.Parent = billboard

	ESPObjects[model] = {
		Highlight = highlight,
		Billboard = billboard,
		NameLabel = nameLabel,
		HealthLabel = healthLabel,
		DistanceLabel = distanceLabel,
		Humanoid = humanoid,
	}
end

local function updateESPText()

	for model, data in pairs(ESPObjects) do

		if not model
			or not model.Parent
			or not data.Humanoid
			or not data.Humanoid.Parent then

			removeESP(model)
			continue
		end

		local humanoid = data.Humanoid

		local targetPlayer =
			Players:GetPlayerFromCharacter(model)

		local targetRoot =
			model:FindFirstChild("HumanoidRootPart")

		local alive = humanoid.Health > 0

		if data.Highlight then
			data.Highlight.Enabled =
				Config.ESP and alive
		end

		if data.Billboard then
			data.Billboard.Enabled =
				Config.ESP and alive
		end

		--======================================================
		-- NAME
		--======================================================

		if data.NameLabel then

			if Config.ESPNames then

				if targetPlayer then
					data.NameLabel.Text =
						targetPlayer.Name
				else
					data.NameLabel.Text =
						model.Name
				end

				data.NameLabel.Visible = true

			else
				data.NameLabel.Visible = false
			end
		end

		--======================================================
		-- HEALTH
		--======================================================

		if data.HealthLabel then

			if Config.ESPHealth then

				local hp =
					math.max(0, humanoid.Health)

				local maxHp =
					math.max(1, humanoid.MaxHealth)

				data.HealthLabel.Text =
					"HP: "
					.. math.floor(hp)
					.. " / "
					.. math.floor(maxHp)

				local percent =
					math.clamp(hp / maxHp, 0, 1)

				if percent > 0.6 then
					data.HealthLabel.TextColor3 =
						Color3.fromRGB(80, 255, 120)

				elseif percent > 0.3 then
					data.HealthLabel.TextColor3 =
						Color3.fromRGB(255, 210, 60)

				else
					data.HealthLabel.TextColor3 =
						Color3.fromRGB(255, 70, 70)
				end

				data.HealthLabel.Visible = true

			else
				data.HealthLabel.Visible = false
			end
		end

		--======================================================
		-- DISTANCE
		--======================================================

		if data.DistanceLabel then

			if Config.ESPDistance
				and Root
				and Root.Parent
				and targetRoot
				and targetRoot:IsA("BasePart") then

				local distance =
					(Root.Position - targetRoot.Position).Magnitude

				data.DistanceLabel.Text =
					"Distance: "
					.. math.floor(distance)
					.. " studs"

				data.DistanceLabel.Visible = true

			else
				data.DistanceLabel.Visible = false
			end
		end
	end
end

local function updateESP()

	if not Config.ESP then

		for model in pairs(ESPObjects) do
			removeESP(model)
		end

		return
	end

	--==========================================================
	-- PLAYERS
	--==========================================================

	for _, targetPlayer in ipairs(Players:GetPlayers()) do

		if targetPlayer ~= Player
			and targetPlayer.Character then

			createESP(targetPlayer.Character)
		end
	end

	--==========================================================
	-- NPC
	--==========================================================

	for _, object in ipairs(Workspace:GetChildren()) do

		if object:IsA("Model")
			and object ~= Character
			and object:FindFirstChildOfClass("Humanoid") then

			createESP(object)
		end
	end

	updateESPText()
end

Players.PlayerAdded:Connect(function(targetPlayer)

	targetPlayer.CharacterAdded:Connect(function(character)

		task.wait(0.5)

		if Config.ESP then
			createESP(character)
		end
	end)
end)

Players.PlayerRemoving:Connect(function(targetPlayer)

	if targetPlayer.Character then
		removeESP(targetPlayer.Character)
	end
end)

--==============================================================
-- MOVEMENT
--==============================================================

createSection(Movement, "MOVEMENT")

createToggle(Movement, "Fly", false, function(value)
	Config.Fly = value
end)

createSlider(
	Movement,
	"Fly Speed",
	10,
	200,
	Config.FlySpeed,
	function(value)
		Config.FlySpeed = value
	end
)

createToggle(Movement, "Custom WalkSpeed", false, function(value)
	Config.Speed = value
end)

createSlider(
	Movement,
	"WalkSpeed",
	8,
	100,
	Config.WalkSpeed,
	function(value)
		Config.WalkSpeed = value
	end
)

createToggle(Movement, "Custom Jump", false, function(value)
	Config.Jump = value
end)

createSlider(
	Movement,
	"Jump Power",
	20,
	150,
	Config.JumpPower,
	function(value)
		Config.JumpPower = value
	end
)

createToggle(Movement, "Noclip", false, function(value)
	Config.Noclip = value
end)

createToggle(Movement, "Infinite Jump", false, function(value)
	Config.InfiniteJump = value
end)

createToggle(Movement, "BunnyHop", false, function(value)
	Config.BunnyHop = value
end)

--==============================================================
-- FLY
--==============================================================

local FlyVelocity

local function updateFly()

	if not Root or not Camera then
		return
	end

	if Config.Fly then

		if not FlyVelocity then

			FlyVelocity = Instance.new("BodyVelocity")
			FlyVelocity.Name = "CyberFly"
			FlyVelocity.MaxForce =
				Vector3.new(1000000, 1000000, 1000000)
			FlyVelocity.Velocity = Vector3.zero
			FlyVelocity.Parent = Root
		end

		local direction = Vector3.zero

		if UIS:IsKeyDown(Enum.KeyCode.W) then
			direction += Camera.CFrame.LookVector
		end

		if UIS:IsKeyDown(Enum.KeyCode.S) then
			direction -= Camera.CFrame.LookVector
		end

		if UIS:IsKeyDown(Enum.KeyCode.A) then
			direction -= Camera.CFrame.RightVector
		end

		if UIS:IsKeyDown(Enum.KeyCode.D) then
			direction += Camera.CFrame.RightVector
		end

		if UIS:IsKeyDown(Enum.KeyCode.Space) then
			direction += Vector3.yAxis
		end

		if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
			direction -= Vector3.yAxis
		end

		if direction.Magnitude > 0 then
			direction =
				direction.Unit * Config.FlySpeed
		end

		FlyVelocity.Velocity = direction

	else

		if FlyVelocity then
			FlyVelocity:Destroy()
			FlyVelocity = nil
		end
	end
end

--==============================================================
-- TELEPORTS
--==============================================================

createSection(Teleports, "WAYPOINTS")

local SavedPosition

createButton(
	Teleports,
	"SAVE CURRENT POSITION",
	function()

		if Root then
			SavedPosition = Root.CFrame
		end
	end
)

createButton(
	Teleports,
	"LOAD SAVED POSITION",
	function()

		if Root and SavedPosition then
			Root.CFrame = SavedPosition
		end
	end
)

createSection(Teleports, "PLAYERS")

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Size = UDim2.new(1, 0, 0, 220)
PlayerList.BackgroundColor3 = Color3.fromRGB(14, 18, 28)
PlayerList.BorderSizePixel = 0
PlayerList.ScrollBarThickness = 3
PlayerList.ScrollBarImageColor3 = Color3.fromRGB(0, 210, 255)
PlayerList.AutomaticCanvasSize = Enum.AutomaticSize.Y
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerList.ZIndex = 13
PlayerList.Parent = Teleports

local PlayerListCorner = Instance.new("UICorner")
PlayerListCorner.CornerRadius = UDim.new(0, 8)
PlayerListCorner.Parent = PlayerList

local PlayerListLayout = Instance.new("UIListLayout")
PlayerListLayout.Padding = UDim.new(0, 5)
PlayerListLayout.Parent = PlayerList

local PlayerListPadding = Instance.new("UIPadding")
PlayerListPadding.PaddingTop = UDim.new(0, 6)
PlayerListPadding.PaddingLeft = UDim.new(0, 6)
PlayerListPadding.PaddingRight = UDim.new(0, 6)
PlayerListPadding.Parent = PlayerList

local function refreshPlayers()

	for _, child in ipairs(PlayerList:GetChildren()) do

		if child:IsA("TextButton") then
			child:Destroy()
		end
	end

	for _, target in ipairs(Players:GetPlayers()) do

		if target ~= Player then

			local Button = Instance.new("TextButton")
			Button.Size = UDim2.new(1, 0, 0, 35)
			Button.BackgroundColor3 = Color3.fromRGB(21, 27, 40)
			Button.BorderSizePixel = 0
			Button.Text =
				target.DisplayName
				.. " ["
				.. target.Name
				.. "]"
			Button.Font = Enum.Font.Gotham
			Button.TextSize = 12
			Button.TextColor3 = Color3.fromRGB(220, 225, 235)
			Button.AutoButtonColor = false
			Button.ZIndex = 14
			Button.Parent = PlayerList

			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(0, 6)
			Corner.Parent = Button

			Button.MouseButton1Click:Connect(function()

				if Root and target.Character then

					local targetRoot =
						target.Character:FindFirstChild(
							"HumanoidRootPart"
						)

					if targetRoot then
						Root.CFrame =
							targetRoot.CFrame
							* CFrame.new(0, 0, 4)
					end
				end
			end)
		end
	end
end

refreshPlayers()

Players.PlayerAdded:Connect(function()
	task.wait(0.3)
	refreshPlayers()
end)

Players.PlayerRemoving:Connect(function()
	task.wait(0.1)
	refreshPlayers()
end)

--==============================================================
-- WORLD
--==============================================================

createSection(World, "CAMERA")

createSlider(
	World,
	"Camera FOV",
	40,
	120,
	Config.CameraFOV,
	function(value)

		Config.CameraFOV = value

		if Camera then
			Camera.FieldOfView = value
		end
	end
)

createSection(World, "LIGHTING")

local OriginalLighting = {
	Brightness = Lighting.Brightness,
	ClockTime = Lighting.ClockTime,
	FogEnd = Lighting.FogEnd,
	GlobalShadows = Lighting.GlobalShadows,
}

createToggle(
	World,
	"Fullbright",
	false,
	function(value)

		Config.Fullbright = value

		if value then

			Lighting.Brightness = 3
			Lighting.ClockTime = 14
			Lighting.FogEnd = 100000
			Lighting.GlobalShadows = false

		else

			Lighting.Brightness =
				OriginalLighting.Brightness

			Lighting.ClockTime =
				OriginalLighting.ClockTime

			Lighting.FogEnd =
				OriginalLighting.FogEnd

			Lighting.GlobalShadows =
				OriginalLighting.GlobalShadows
		end
	end
)

--==============================================================
-- FREECAM
--==============================================================

createSection(World, "FREECAM")

local FreecamConnection
local FreecamCFrame

local function startFreecam()

	if FreecamConnection or not Camera then
		return
	end

	FreecamCFrame = Camera.CFrame

	Camera.CameraType =
		Enum.CameraType.Scriptable

	FreecamConnection =
		RunService.RenderStepped:Connect(function(dt)

			if not Camera or not FreecamCFrame then
				return
			end

			local move = Vector3.zero

			if UIS:IsKeyDown(Enum.KeyCode.W) then
				move += Vector3.zAxis * -1
			end

			if UIS:IsKeyDown(Enum.KeyCode.S) then
				move += Vector3.zAxis
			end

			if UIS:IsKeyDown(Enum.KeyCode.A) then
				move += Vector3.xAxis * -1
			end

			if UIS:IsKeyDown(Enum.KeyCode.D) then
				move += Vector3.xAxis
			end

			if UIS:IsKeyDown(Enum.KeyCode.Space) then
				move += Vector3.yAxis
			end

			if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
				move -= Vector3.yAxis
			end

			if move.Magnitude > 0 then

				move =
					move.Unit * 70 * dt

				FreecamCFrame =
					FreecamCFrame
					+ FreecamCFrame.RightVector * move.X
					+ Vector3.yAxis * move.Y
					+ FreecamCFrame.LookVector * (-move.Z)
			end

			Camera.CFrame = FreecamCFrame
		end)
end

local function stopFreecam()

	if FreecamConnection then
		FreecamConnection:Disconnect()
		FreecamConnection = nil
	end

	if Camera then
		Camera.CameraType =
			Enum.CameraType.Custom

		if Humanoid then
			Camera.CameraSubject = Humanoid
		end
	end
end

createToggle(
	World,
	"Freecam",
	false,
	function(value)

		Config.Freecam = value

		if value then
			startFreecam()
		else
			stopFreecam()
		end
	end
)

--==============================================================
-- FUN
--==============================================================

createSection(Fun, "FUN / TESTING")

createToggle(
	Fun,
	"SpinBot",
	false,
	function(value)
		Config.SpinBot = value
	end
)

createSlider(
	Fun,
	"Spin Speed",
	1,
	50,
	Config.SpinSpeed,
	function(value)
		Config.SpinSpeed = value
	end
)

createButton(
	Fun,
	"SIT",
	function()

		if Humanoid then
			Humanoid.Sit = true
		end
	end
)

createButton(
	Fun,
	"RESET CHARACTER",
	function()

		if Humanoid then
			Humanoid.Health = 0
		end
	end
)

createButton(
	Fun,
	"RESET CAMERA",
	function()

		stopFreecam()

		if Humanoid and Camera then
			Camera.CameraSubject = Humanoid
		end
	end
)

--==============================================================
-- SETTINGS
--==============================================================

createSection(Settings, "MENU")

createButton(
	Settings,
	"HIDE MENU  [0]",
	function()

		Main.Visible = false
		FOVCircle.Visible = false
	end
)

createButton(
	Settings,
	"SHOW MENU",
	function()

		Main.Visible = true
	end
)

createSection(Settings, "CONFIG")

createButton(
	Settings,
	"SAVE CONFIG",
	function()

		_G.CyberAdminConfig =
			table.clone(Config)

		print("[CyberHub] Config saved")
	end
)

createButton(
	Settings,
	"LOAD CONFIG",
	function()

		if _G.CyberAdminConfig then

			for key, value in pairs(
				_G.CyberAdminConfig
			) do

				Config[key] = value
			end

			print("[CyberHub] Config loaded")
		end
	end
)

createButton(
	Settings,
	"RESET MOVEMENT",
	function()

		Config.Fly = false
		Config.Speed = false
		Config.Jump = false
		Config.Noclip = false

		if FlyVelocity then
			FlyVelocity:Destroy()
			FlyVelocity = nil
		end

		if Humanoid then
			Humanoid.WalkSpeed = 16
			Humanoid.UseJumpPower = true
			Humanoid.JumpPower = 50
		end
	end
)

--==============================================================
-- AIM TARGET
--==============================================================

local function getTarget()

	if not Camera then
		return nil
	end

	local bestTarget
	local bestDistance = Config.AimFOV

	local screenCenter =
		Vector2.new(
			Camera.ViewportSize.X / 2,
			Camera.ViewportSize.Y / 2
		)

	for _, object in ipairs(Workspace:GetDescendants()) do

		if object:IsA("Model")
			and object ~= Character then

			local humanoid =
				object:FindFirstChildOfClass("Humanoid")

			local targetPart =
				object:FindFirstChild("Head")
				or object:FindFirstChild("HumanoidRootPart")

			if humanoid
				and humanoid.Health > 0
				and targetPart
				and targetPart:IsA("BasePart") then

				local position, visible =
					Camera:WorldToViewportPoint(
						targetPart.Position
					)

				if visible then

					local distance =
						(
							Vector2.new(
								position.X,
								position.Y
							)
							- screenCenter
						).Magnitude

					if distance < bestDistance then

						if Config.WallCheck then

							local params =
								RaycastParams.new()

							params.FilterType =
								Enum.RaycastFilterType.Exclude

							params.FilterDescendantsInstances =
								{Character}

							local result =
								Workspace:Raycast(
									Camera.CFrame.Position,
									targetPart.Position
										- Camera.CFrame.Position,
									params
								)

							if result
								and not result.Instance:IsDescendantOf(
									object
								) then

								continue
							end
						end

						bestDistance = distance
						bestTarget = targetPart
					end
				end
			end
		end
	end

	return bestTarget
end

local function aimAt(target)

	if not target or not Camera then
		return
	end

	local desired =
		CFrame.lookAt(
			Camera.CFrame.Position,
			target.Position
		)

	Camera.CFrame =
		Camera.CFrame:Lerp(
			desired,
			math.clamp(
				Config.AimSmooth,
				0.01,
				1
			)
		)
end

--==============================================================
-- INPUT
--==============================================================

UIS.InputBegan:Connect(function(input, gameProcessed)

	--==========================================================
	-- MENU KEY
	--==========================================================

	if input.UserInputType == Enum.UserInputType.Keyboard then

		if input.KeyCode == Enum.KeyCode.Zero
			or input.KeyCode == Enum.KeyCode.KeypadZero then

			Main.Visible = not Main.Visible

			FOVCircle.Visible =
				Main.Visible
				and Config.AimAssist

			print(
				"[CyberHub] Menu:",
				Main.Visible and "OPEN" or "CLOSED"
			)

			return
		end
	end

	if gameProcessed then
		return
	end

	--==========================================================
	-- INFINITE JUMP
	--==========================================================

	if input.KeyCode == Enum.KeyCode.Space
		and Config.InfiniteJump
		and Humanoid then

		Humanoid:ChangeState(
			Enum.HumanoidStateType.Jumping
		)
	end
end)

--==============================================================
-- MAIN LOOP
--==============================================================

local ESPTimer = 0
local ESPTextTimer = 0

RunService.RenderStepped:Connect(function(dt)

	--==========================================================
	-- CHARACTER
	--==========================================================

	if not Character
		or not Character.Parent
		or not Humanoid
		or not Humanoid.Parent
		or not Root
		or not Root.Parent then

		updateCharacter()
	end

	--==========================================================
	-- CAMERA
	--==========================================================

	Camera = Workspace.CurrentCamera

	if not Camera then
		return
	end

	--==========================================================
	-- FOV
	--==========================================================

	FOVCircle.Size =
		UDim2.fromOffset(
			Config.AimFOV * 2,
			Config.AimFOV * 2
		)

	FOVCircle.Visible =
		Main.Visible
		and Config.AimAssist

	--==========================================================
	-- AIM ASSIST
	--==========================================================

	if Config.AimAssist
		and Main.Visible then

		local target = getTarget()

		if target then
			aimAt(target)
		end
	end

	--==========================================================
	-- WALK SPEED
	--==========================================================

	if Humanoid then

		if Config.Speed then
			Humanoid.WalkSpeed =
				Config.WalkSpeed
		end

		if Config.Jump then
			Humanoid.UseJumpPower = true
			Humanoid.JumpPower =
				Config.JumpPower
		end

		--======================================================
		-- BUNNY HOP
		--======================================================

		if Config.BunnyHop
			and Humanoid.FloorMaterial ~= Enum.Material.Air
			and UIS:IsKeyDown(Enum.KeyCode.Space) then

			Humanoid:ChangeState(
				Enum.HumanoidStateType.Jumping
			)
		end
	end

	--==========================================================
	-- NOCLIP
	--==========================================================

	if Character and Config.Noclip then

		for _, part in ipairs(
			Character:GetDescendants()
		) do

			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end

	--==========================================================
	-- FLY
	--==========================================================

	updateFly()

	--==========================================================
	-- SPIN
	--==========================================================

	if Config.SpinBot and Root then

		Root.CFrame =
			Root.CFrame
			* CFrame.Angles(
				0,
				math.rad(Config.SpinSpeed),
				0
			)
	end

	--==========================================================
	-- ESP SCAN
	--==========================================================

	ESPTimer += dt

	if ESPTimer >= 0.4 then
		ESPTimer = 0
		updateESP()
	end

	--==========================================================
	-- ESP TEXT
	--==========================================================

	ESPTextTimer += dt

	if ESPTextTimer >= 0.1 then
		ESPTextTimer = 0

		if Config.ESP then
			updateESPText()
		end
	end
end)

--==============================================================
-- DEFAULT TAB
--==============================================================

for _, page in pairs(Pages) do
	page.Visible = false
end

Pages["Combat"].Visible = true

Buttons["Combat"].BackgroundColor3 =
	Color3.fromRGB(0, 105, 140)

Buttons["Combat"].TextColor3 =
	Color3.fromRGB(255, 255, 255)

--==============================================================
-- DRAG WINDOW
--==============================================================

local Dragging = false
local DragStart
local StartPosition

Header.InputBegan:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1 then

		Dragging = true
		DragStart = input.Position
		StartPosition = Main.Position
	end
end)

UIS.InputChanged:Connect(function(input)

	if Dragging
		and input.UserInputType ==
			Enum.UserInputType.MouseMovement then

		local Delta =
			input.Position - DragStart

		Main.Position =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,

				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
	end
end)

UIS.InputEnded:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1 then

		Dragging = false
	end
end)

--==============================================================
-- START
--==============================================================

Main.Visible = true

print("======================================")
print("       CYBER ADMIN HUB LOADED")
print("       PRESS 0 TO OPEN / CLOSE")
print("       ESP: NAME / HP / DISTANCE")
print("======================================")
