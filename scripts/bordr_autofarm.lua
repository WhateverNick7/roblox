if game.PlaceId ~= 3411100258 then
	warn("Game is not supported!")
	wait(604800)
end


local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local GC = getconnections or get_signal_cons
if GC then
	for i,v in pairs(GC(game.Players.LocalPlayer.Idled)) do
		if v["Disable"] then
			v["Disable"](v)
		elseif v["Disconnect"] then
			v["Disconnect"](v)
		end
	end
else
	game.Players.LocalPlayer.Idled:Connect(function()
		local VirtualUser = game:GetService("VirtualUser")
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end)
end

--

getgenv().n7 = {
	saveable = {
		use_cage = true,
		check_admins = true,
		webhook = {
			use = false,
			link = "",
			cfg = {
				ping = "@everyone",
				on_admin = true
			}
		}
	},
	autofarm = false,
    cage = CFrame.new(0,0,0),
}

pcall(function()
    if getfenv().isfile and getfenv().readfile and getfenv().isfile(string.format("%s.n7", game.GameId)) and getfenv().readfile(string.format("%s.n7", game.GameId)) then
        getgenv().n7.saveable = HttpService:JSONDecode(getfenv().readfile(string.format("%s.n7", game.GameId)))
    end
end)

-- CAGE
if workspace:FindFirstChild("Cage (nick7hub)") then workspace:FindFirstChild("Cage (nick7hub)"):Destroy() end
local folder = Instance.new("Folder", workspace)
folder.Name = "Cage (nick7hub)"
local _color = Color3.fromRGB(79, 79, 79)
local _offset = Vector3.new(math.random(-100000, 100000), math.random(-50,1500), math.random(-100000,100000))
--+ Creating
local parts = {}
local floor = Instance.new("Part", folder)
local wall1 = Instance.new("Part", folder)
local wall2 = Instance.new("Part", folder)
local wall3 = Instance.new("Part", folder)
local wall4 = Instance.new("Part", folder)
local ceiling = Instance.new("Part", folder)
local parts = {floor,wall1,wall2,wall3,wall4,ceiling}
--+ sum things
for _,v in pairs(parts) do
	v.Anchored = true
	v.Transparency = 0.4
	v.Color = _color
	v.Name = "discord.gg/6tgCfU2fX8"
end
--+ Position
floor.Position = Vector3.new(0, 0, 0) + _offset
wall1.Position = Vector3.new(5, 5, 0) + _offset
wall2.Position = Vector3.new(-5, 5, 0) + _offset
wall3.Position = Vector3.new(0, 5, -5) + _offset
wall4.Position = Vector3.new(0, 5, 5) + _offset
ceiling.Position = Vector3.new(0, 10, 0) + _offset
--+ Size
floor.Size = Vector3.new(10,1,10)
wall1.Size = Vector3.new(1, 10, 10)
wall2.Size = Vector3.new(1, 10, 10)
wall3.Size = Vector3.new(10, 10, 1)
wall4.Size = Vector3.new(10, 10, 1)
ceiling.Size = Vector3.new(10,1,10)
--
local frame = _offset + Vector3.new(0,4,0)
getgenv().n7.cage = CFrame.new(frame)
-- CAGE


local Fluent = loadstring(game:HttpGet("https://ttwizz.su/Fluent.txt", true))()
Fluent.ShowCallbackErrors = true

local Window = Fluent:CreateWindow({
	Title = "nick7 hub",
	SubTitle = "bordr | by stonifam",
	TabWidth = 100,
	Size = UDim2.fromOffset(470, 300),
	Acrylic = false,
	Theme = "Amethyst"
})

function get_exp()
	local most = 0
	local str = ""
	local CargoInfo = game.ReplicatedStorage.CargoInfo
	local island = 0
	local list_brick = {CargoInfo.BricklandiaCargoTrader.Sell.coal, CargoInfo.BricklandiaCargoTrader.Sell.fish, CargoInfo.BricklandiaCargoTrader.Sell.gold, CargoInfo.BricklandiaCargoTrader.Sell.gunpowder, CargoInfo.BricklandiaCargoTrader.Sell.lumber, CargoInfo.BricklandiaCargoTrader.Sell.potions}
	local list_far = {CargoInfo.FarlandsCargoTrader.Sell.chalices, CargoInfo.FarlandsCargoTrader.Sell.fish, CargoInfo.FarlandsCargoTrader.Sell.flowers, CargoInfo.FarlandsCargoTrader.Sell.gold, CargoInfo.FarlandsCargoTrader.Sell.gunpowder, CargoInfo.FarlandsCargoTrader.Sell.iron}
	local list_pirate = {CargoInfo.PirateCargoTrader.Sell.chalices, CargoInfo.PirateCargoTrader.Sell.coal, CargoInfo.PirateCargoTrader.Sell.flowers, CargoInfo.PirateCargoTrader.Sell.iron, CargoInfo.PirateCargoTrader.Sell.lumber, CargoInfo.PirateCargoTrader.Sell.potions}
	for i,v in pairs(list_brick) do
		if v then
			if v.Value > most then
				most = v.Value
				str = v.Name
				island = 1
			end
		end
	end
	for i,v in pairs(list_far) do
		if v.Value > most then
			most = v.Value
			str = v.Name
			island = 2
		end
	end
	for i,v in pairs(list_pirate) do
		if v.Value > most then
			most = v.Value
			str = v.Name
			island = 3
		end
	end
	return str, island
end

function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

Farm = Window:AddTab({Title = "Farming", Icon = "carrot"})
local FarmToggle = Farm:AddToggle("FarmToggle", { Title = "Autofarm", Description = "Toggles money autofarm using cargo", Default = false })

local status = Farm:AddParagraph({
	Title = "Autofarm status will be here", Content = ""
})

FarmToggle:OnChanged(function(Value)
	getgenv().n7.autofarm = Value
	if getgenv().n7.autofarm then
		if game.Players.LocalPlayer.leaderstats.coins.Value >= 50 then
			while getgenv().n7.autofarm do
				local exp, tp = get_exp()
				game:GetService("ReplicatedStorage").Packages.Knit.Services.ShopService.RF.Shop:InvokeServer(exp, false, true)
				for i=10,1,-1 do
					status:SetTitle("Waiting "..i.." seconds...")
					task.wait(1)
					if not getgenv().n7.autofarm then
						status:SetTitle("Finished farming!")
						break
					end
				end
				if not getgenv().n7.autofarm then
					break
				end
				local char = game.Players.LocalPlayer.Character
				local pre = getRoot(char).CFrame
				char:FindFirstChild("Humanoid").Sit = false
				local of = Vector3.new(0,0,0)
				local noise = math.random(-50,30)
				local fs = Vector3.new(noise,10000 + noise,noise)
				if tp == 1 then
					of = game.Workspace.Map.Islands.Bricklandia.BricklandiaCargoTrader.Sell.Position
				elseif tp == 2 then
					of = game.Workspace.Map.Islands.Farlands.FarlandsCargoTrader.Sell.Position
				elseif tp == 3 then
					of = game.Workspace.Map.Islands["Pirate Cove"]:GetChildren()[81].Sell.Position
				end
				of = of +fs
                if char and getRoot(char) then
                    getRoot(char).CFrame = CFrame.new(of)
					status:SetTitle("Teleported to selling point")
                    task.wait(.25)
                    game:GetService("ReplicatedStorage").Packages.Knit.Services.ShopService.RF.Shop:InvokeServer(exp, false, false)
					status:SetTitle("Teleporting back")
                    task.wait(.01)
                    if getgenv().n7.saveable.use_cage then
                        getRoot(char).CFrame = getgenv().n7.cage
                    else
                        getRoot(char).CFrame = pre
                    end
                else
                    Fluent:Notify({
                        Title = "nick7 hub | ERROR",
                        Content = "Can't find character.",
                        SubContent = "bordr autofarm",
                        Duration = 5
                    })
                end
			end
		else
			Fluent:Notify({
				Title = "nick7 hub | WARN",
				Content = "Not enough coins! You need 50 coins",
				SubContent = "bordr autofarm",
				Duration = 5
			})
		end
	end
end)

Farm:AddParagraph({
	Title = "WARNING | Autofarm",
	Content = "Don't do anything crazy with: your position and your tools\nAutofarm will remove tool from your hands (not from inventory)\nAutofarm will teleport you"
})

Webhook = Window:AddTab({Title = "Webhook", Icon = "bell"})
function SendMessage(url, message)
	if url ~= "" or url ~= " " then
		local http = game:GetService("HttpService")
		local headers = {
			["Content-Type"] = "application/json"
		}
		local data = {
			["content"] = message
		}
		local body = http:JSONEncode(data)
		local response = request({
			Url = url,
			Method = "POST",
			Headers = headers,
			Body = body
		})
	end
end

local UseWebhook = Webhook:AddToggle("UseWebhook", { Title = "Use webhook", Description = "Will message on selected event(-s)", Default = getgenv().n7.saveable.webhook.use})
UseWebhook:OnChanged(function(Value)
	getgenv().n7.saveable.webhook.use = Value
end)

Webhook:AddInput("WebhookLink", {
    Title = "Webhook link",
    Description = "After typing, press Enter",
	Default = #getgenv().n7.saveable.webhook.link > 0 and getgenv().n7.saveable.webhook.link or "",
    Numeric = false,
    Finished = true,
    Placeholder = "https://discord.com/api/webhooks/*",
    Callback = function(Value)
        getgenv().n7.saveable.webhook.link = Value
    end
})

Webhook:AddButton({
	Title = "Test webhook",
	Description = "Will send a test message to your webhook",
	Callback = function()
		SendMessage(getgenv().n7.saveable.webhook.link, "Message sent from `".. game.Players.LocalPlayer.Name.."`.")
	end
})

local UISection = Webhook:AddSection("Events")

local EventAdmin = UISection:AddToggle("EventAdmin", { Title = "Admin join/exists", Description = "Will message when admin is on the server", Default = getgenv().n7.saveable.webhook.cfg.on_admin})
EventAdmin:OnChanged(function(Value)
	getgenv().n7.saveable.webhook.cfg.on_admin = Value
end)

local Settings = Window:AddTab({ Title = "Settings", Icon = "cog"})
local UISection = Settings:AddSection("Farming")

local FarmToggle = Settings:AddToggle("CageToggle", { Title = "Use cage", Description = "Teleports you to cage after selling", Default = getgenv().n7.saveable.use_cage})
FarmToggle:OnChanged(function(Value)
    getgenv().n7.saveable.use_cage = Value
end)

UISection:AddButton({
	Title = "Rebuild cage",
	Description = "Will delete previous cage",
	Callback = function()
		if workspace:FindFirstChild("Cage (nick7hub)") then workspace:FindFirstChild("Cage (nick7hub)"):Destroy() end
        local folder = Instance.new("Folder", workspace)
        folder.Name = "Cage (nick7hub)"
        local _color = Color3.fromRGB(79, 79, 79)
        local _offset = Vector3.new(math.random(-100000, 100000), math.random(-50,5000), math.random(-100000,100000))
        --+ Creating
        local parts = {}
        local floor = Instance.new("Part", folder)
        local wall1 = Instance.new("Part", folder)
        local wall2 = Instance.new("Part", folder)
        local wall3 = Instance.new("Part", folder)
        local wall4 = Instance.new("Part", folder)
        local ceiling = Instance.new("Part", folder)
        local parts = {floor,wall1,wall2,wall3,wall4,ceiling}
        --+ sum things
        for _,v in pairs(parts) do
            v.Anchored = true
            v.Transparency = 0.4
            v.Color = _color
            v.Name = "discord.gg/6tgCfU2fX8"
        end
        --+ Position
        floor.Position = Vector3.new(0, 0, 0) + _offset
        wall1.Position = Vector3.new(5, 5, 0) + _offset
        wall2.Position = Vector3.new(-5, 5, 0) + _offset
        wall3.Position = Vector3.new(0, 5, -5) + _offset
        wall4.Position = Vector3.new(0, 5, 5) + _offset
        ceiling.Position = Vector3.new(0, 10, 0) + _offset
        --+ Size
        floor.Size = Vector3.new(10,1,10)
        wall1.Size = Vector3.new(1, 10, 10)
        wall2.Size = Vector3.new(1, 10, 10)
        wall3.Size = Vector3.new(10, 10, 1)
        wall4.Size = Vector3.new(10, 10, 1)
        ceiling.Size = Vector3.new(10,1,10)
        --
        local frame = _offset + Vector3.new(0,4,0)
        getgenv().n7.cage = CFrame.new(frame)
	end
})

local AdminCheck = UISection:AddToggle("AdminCheck", { Title = "Check for admins", Description = "Checks for admins while you play", Default = getgenv().n7.saveable.check_admins})
AdminCheck:OnChanged(function(Value)
	getgenv().n7.saveable.check_admins = Value
    task.spawn(function()
		task.wait(.1)
		local warned = false
		while getgenv().n7.saveable.check_admins do
            local plrs = game.Players:GetPlayers()
			local code = 0
            for _,v in plrs do
                local role = v:GetRoleInGroup(5069767)
                local bad = {"Admin", "Trial Admin", "Head Admin"}
                for _,b in pairs(bad) do
                    if string.match(role, b) then
                        game.Players.LocalPlayer:Kick("found admin. code: 1")
						code = 1
                    end
                end
                local role = v:GetRoleInGroup(11566845)
                local bad = {"Admin", "Head Admin", "Owner"}
                for _,b in pairs(bad) do
                    if string.match(role, b) then
                        game.Players.LocalPlayer:Kick("found admin. code: 2")
						code = 2
                    end
                end
            end
            if game.Teams:FindFirstChild("admin") then
                game.Players.LocalPlayer:Kick("found admin. code: 3")
				code = 3
            end
			if code ~= 0 then
				if getgenv().n7.saveable.webhook.use then
					if getgenv().n7.saveable.webhook.link ~= ""  or getgenv().n7.saveable.webhook.link ~= " " then
						if not warned then
							SendMessage(getgenv().n7.saveable.webhook.link, getgenv().n7.saveable.webhook.cfg.ping.." Admin joined the game! Kicked `"..game.Players.LocalPlayer.Name.."`. Code: ".. code)
							warned = true
						end
					end
				end
			end
            task.wait()
        end
    end)
end)

local UISection = Settings:AddSection("UI")
UISection:AddDropdown("InterfaceTheme", {
	Title = "Theme",
	Description = "Changes the UI Theme",
	Values = Fluent.Themes,
	Default = Fluent.Theme,
	Callback = function(Value)
		Fluent:SetTheme(Value)
	end
})

if Fluent.UseAcrylic then
	UISection:AddToggle("AcrylicToggle", {
		Title = "Acrylic",
		Description = "Blurred Background requires Graphic Quality >= 8",
		Default = Fluent.Acrylic,
		Callback = function(Value)
			if not Value then
				Fluent:ToggleAcrylic(Value)
			else
				Window:Dialog({
					Title = "Warning",
					Content = "This Option can be detected! Activate it anyway?",
					Buttons = {
						{
							Title = "Confirm",
							Callback = function()
								Fluent:ToggleAcrylic(Value)
							end
						},
						{
							Title = "Cancel",
							Callback = function()
								Fluent.Options.AcrylicToggle:SetValue(false)
							end
						}
					}
				})
			end
		end
	})
end

UISection:AddToggle("TransparentToggle", {
	Title = "Transparency",
	Description = "Makes the UI Transparent",
	Default = Fluent.Transparency,
	Callback = function(Value)
		Fluent:ToggleTransparency(Value)
	end
})

UISection:AddKeybind("MinimizeKeybind", { Title = "Minimize Key", Description = "Changes the Minimize Key", Default = "RightShift" })
Fluent.MinimizeKeybind = Fluent.Options.MinimizeKeybind

if getfenv().isfile and getfenv().readfile and getfenv().writefile and getfenv().delfile then
	local ConfigurationManager = Settings:AddSection("Configuration Manager")

	ConfigurationManager:AddButton({
		Title = "Export Configuration",
		Description = "Overwrites the Game Configuration File",
		Callback = function()
			xpcall(function()
				local ExportedConfiguration = HttpService:JSONEncode(getgenv().n7.saveable)

				getfenv().writefile(string.format("%s.n7", game.GameId), ExportedConfiguration)
				Window:Dialog({
					Title = "Configuration Manager",
					Content = string.format("Configuration File %s.n7 has been successfully overwritten!", game.GameId),
					Buttons = {
						{
							Title = "Confirm"
						}
					}
				})
			end, function()
				Window:Dialog({
					Title = "Configuration Manager",
					Content = string.format("An Error occurred when overwriting the Configuration File %s.n7", game.GameId),
					Buttons = {
						{
							Title = "Confirm"
						}
					}
				})
			end)
		end
	})

	ConfigurationManager:AddButton({
		Title = "Delete Configuration File",
		Description = "Deletes the Game Configuration File",
		Callback = function()
			if getfenv().isfile(string.format("%s.n7", game.GameId)) then
				getfenv().delfile(string.format("%s.n7", game.GameId))
				Window:Dialog({
					Title = "Configuration Manager",
					Content = string.format("Configuration File %s.n7 has been successfully deleted!", game.GameId),
					Buttons = {
						{
							Title = "Confirm"
						}
					}
				})
			else
				Window:Dialog({
					Title = "Configuration Manager",
					Content = string.format("Configuration File %s.n7 could not be found!", game.GameId),
					Buttons = {
						{
							Title = "Confirm"
						}
					}
				})
			end
		end
	})
end

Credits = Window:AddTab({Title = "Credits", Icon = "person-standing"})
Credits:AddParagraph({
	Title = "nick7 hub",
	Content = "Main script was made by Stonifam\nUsing forked Fluent UI lib by @ttwiz_z"
})
Credits:AddButton({
	Title = "Copy discord invite",
	Description = "nick7 community",
	Callback = function()
		setclipboard("https://discord.gg/6tgCfU2fX8")
	end
})

Window:SelectTab(1)