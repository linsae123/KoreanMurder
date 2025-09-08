-- 소스 코드 쓸꺼면 쓰기 ㄱㄱ 짜피 이제 업데이트도 안할꺼고 할 흥미도 없노

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local originalCameraType = Camera.CameraType
local originalSubject = Camera.CameraSubject
local debris = workspace:WaitForChild("Game"):WaitForChild("Debris")

local autoGunEnabled = false
local debrisConnection
local ESPObjects = {}
local TeleportMurderEnabled, TeleportConnection = false, nil
local AutoKillEnabled, AutoKillConnection = false, nil
local GunDropNotifyEnabled = false
local playerIsGunner = {}

local GUI = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = GUI:CreateWindow({
    Name = "KoreanMurder",
    Icon = 0,
    LoadingTitle = "- KoreanMurder",
    LoadingSubtitle = "by linsae123",
    ShowText = "KM",
    Theme = "DarkBlue", 
    ToggleUIKeybind = "K",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "IGNNOMUHYEON",
        FileName = "KoreanMurder"
    }
})

local MainTab = Window:CreateTab("Main", "layout-dashboard")
local TrollSection = MainTab:CreateSection("Troll")

MainTab:CreateButton({
    Name = "Fling All",
    Callback = function()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                GUI:Notify({
                    Title = "Fling All",
                    Content = "Flinging: "..player.Name,
                    Duration = 5,
                    Image = "users-round",
                })

                local Target = player
                local Thrust = Instance.new("BodyThrust")
                Thrust.Parent = LocalPlayer.Character.HumanoidRootPart
                Thrust.Force = Vector3.new(999999999999999999, 99999999999999999, 9999999999999999)
                Thrust.Name = "YeetForce"

                spawn(function()
                    repeat
                        if not Target.Character or not Target.Character:FindFirstChild("HumanoidRootPart") then break end
                        LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame
                        Thrust.Location = Target.Character.HumanoidRootPart.Position
                        RunService.Heartbeat:Wait()
                    until not Target.Character:FindFirstChild("Head")
                    Thrust:Destroy()
                end)
            end
        end
    end,
})

MainTab:CreateButton({
    Name = "Fling Murder",
    Callback = function()
        local function isMurder(player)
            local function hasMurderTool(container)
                if container then
                    for _, tool in ipairs(container:GetChildren()) do
                        if tool:IsA("Tool") then
                            local name = string.lower(tool.Name)
                            if string.find(name, "knife") or string.find(name, "sword") then
                                return true
                            end
                        end
                    end
                end
                return false
            end
            return hasMurderTool(player.Character) or hasMurderTool(player:FindFirstChild("Backpack"))
        end

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and isMurder(player) then
                GUI:Notify({
                    Title = "Fling Murder",
                    Content = "Flinging Murder: "..player.Name,
                    Duration = 5,
                    Image = "users-round",
                })
                local Thrust = Instance.new("BodyThrust")
                Thrust.Parent = LocalPlayer.Character.HumanoidRootPart
                Thrust.Force = Vector3.new(999999999999999999, 99999999999999999, 9999999999999999)
                Thrust.Name = "YeetForce"
                spawn(function()
                    repeat
                        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then break end
                        LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                        Thrust.Location = player.Character.HumanoidRootPart.Position
                        RunService.Heartbeat:Wait()
                    until not player.Character:FindFirstChild("Head")
                    Thrust:Destroy()
                end)
            end
        end
    end,
})

MainTab:CreateButton({
    Name = "Fling Gunner",
    Callback = function()
        local function isGunner(player)
            local function hasGun(container)
                if container then
                    for _, tool in ipairs(container:GetChildren()) do
                        if tool:IsA("Tool") then
                            local name = string.lower(tool.Name)
                            if string.find(name, "revolver") or string.find(name, "herorevolver") then
                                return true
                            end
                        end
                    end
                end
                return false
            end
            return hasGun(player.Character) or hasGun(player:FindFirstChild("Backpack"))
        end

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and isGunner(player) then
                GUI:Notify({
                    Title = "Fling Gunner",
                    Content = "Flinging Gunner: "..player.Name,
                    Duration = 5,
                    Image = "users-round",
                })
                local Thrust = Instance.new("BodyThrust")
                Thrust.Parent = LocalPlayer.Character.HumanoidRootPart
                Thrust.Force = Vector3.new(999999999999999999, 99999999999999999, 9999999999999999)
                Thrust.Name = "YeetForce"
                spawn(function()
                    repeat
                        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then break end
                        LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                        Thrust.Location = player.Character.HumanoidRootPart.Position
                        RunService.Heartbeat:Wait()
                    until not player.Character:FindFirstChild("Head")
                    Thrust:Destroy()
                end)
            end
        end
    end,
})

local GunSection = MainTab:CreateSection("Gun")

MainTab:CreateToggle({
    Name = "Gun Drop Notify",
    Flag = "GunDropNotify",
    Callback = function(value) GunDropNotifyEnabled = value end,
})

local VisualTab = Window:CreateTab("Visual", "locate")
local ESPEnabled, ShowName, ShowBox, ShowInventory = false, false, false, false

VisualTab:CreateToggle({
    Name = "Toggle ESP",
    Flag = "ToggleESP",
    Callback = function(v) ESPEnabled = v end,
})
VisualTab:CreateToggle({
    Name = "Player Name",
    Flag = "NameESP",
    Callback = function(v) ShowName = v end,
})
VisualTab:CreateToggle({
    Name = "Box ESP",
    Flag = "BoxESP",
    Callback = function(v) ShowBox = v end,
})
VisualTab:CreateToggle({
    Name = "Inventory ESP",
    Flag = "InvESP",
    Callback = function(v) ShowInventory = v end,
})

local function CreateESP(player)
    if player == LocalPlayer or ESPObjects[player] then return end
    local nameText, box, invText = Drawing.new("Text"), Drawing.new("Square"), Drawing.new("Text")

    nameText.Size, nameText.Center, nameText.Outline = 14, true, true
    nameText.Color, nameText.Visible = Color3.fromRGB(255,255,255), false

    box.Thickness, box.Transparency, box.Color, box.Visible = 1, 1, Color3.fromRGB(255,0,0), false

    invText.Size, invText.Center, invText.Outline = 13, true, true
    invText.Color, invText.Visible = Color3.fromRGB(255,255,0), false

    ESPObjects[player] = {name = nameText, box = box, inv = invText}
end

Players.PlayerRemoving:Connect(function(player)
    if ESPObjects[player] then
        ESPObjects[player].name:Remove()
        ESPObjects[player].box:Remove()
        ESPObjects[player].inv:Remove()
        ESPObjects[player] = nil
    end
end)

for _, p in ipairs(Players:GetPlayers()) do CreateESP(p) end
Players.PlayerAdded:Connect(CreateESP)

local function getToolColor(tool)
    local lname = string.lower(tool.Name)
    if string.find(lname, "knife") then return Color3.fromRGB(255,0,0)
    elseif string.find(lname, "herorevolver") then return Color3.fromRGB(255,255,0)
    elseif string.find(lname, "revolver") then return Color3.fromRGB(0,150,255)
    else return Color3.fromRGB(255,255,255) end
end

local function determineColor(player)
    local finalColor = Color3.fromRGB(255,255,255)
    for _, c in ipairs({player.Character, player:FindFirstChild("Backpack")}) do
        if c then
            for _, tool in ipairs(c:GetChildren()) do
                if tool:IsA("Tool") then
                    local color = getToolColor(tool)
                    if color == Color3.fromRGB(255,0,0) or
                        (color == Color3.fromRGB(255,255,0) and finalColor ~= Color3.fromRGB(255,0,0)) or
                        (color == Color3.fromRGB(0,150,255) and finalColor == Color3.fromRGB(255,255,255)) then
                        finalColor = color
                    end
                end
            end
        end
    end
    return finalColor
end

RunService.RenderStepped:Connect(function()
    if not ESPEnabled then
        for _, esp in pairs(ESPObjects) do
            esp.name.Visible, esp.box.Visible, esp.inv.Visible = false, false, false
        end
        return
    end
    for player, esp in pairs(ESPObjects) do
        local char, hrp, head = player.Character, player.Character and player.Character:FindFirstChild("HumanoidRootPart"), player.Character and player.Character:FindFirstChild("Head")
        if char and hrp and head then
            local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
            if onScreen then
                local color = determineColor(player)
                if ShowName then
                    esp.name.Text, esp.name.Position, esp.name.Color, esp.name.Visible = player.Name, Vector2.new(screenPos.X, screenPos.Y-35), color, true
                else esp.name.Visible = false end
                if ShowBox then
                    local footPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0,3,0))
                    local h, w = math.abs(screenPos.Y-footPos.Y), math.abs(screenPos.Y-footPos.Y)/2
                    esp.box.Size, esp.box.Position, esp.box.Color, esp.box.Visible = Vector2.new(w,h), Vector2.new(screenPos.X-w/2, screenPos.Y-h/2), color, true
                else esp.box.Visible = false end
                if ShowInventory then
                    local invList = {}
                    for _, c in ipairs({char, player:FindFirstChild("Backpack")}) do
                        if c then for _, tool in ipairs(c:GetChildren()) do if tool:IsA("Tool") then table.insert(invList, tool.Name) end end end
                    end
                    esp.inv.Text, esp.inv.Position, esp.inv.Color, esp.inv.Visible = (#invList>0 and table.concat(invList," ") or "[None]"), Vector2.new(screenPos.X, screenPos.Y+40), color, true
                else esp.inv.Visible = false end
            else esp.name.Visible, esp.box.Visible, esp.inv.Visible = false,false,false end
        else esp.name.Visible, esp.box.Visible, esp.inv.Visible = false,false,false end
    end
end)

local GunnerTab = Window:CreateTab("Sheriff", "shield")

local function isMurder(player)
    local function hasMurderTool(container)
        if container then
            for _, tool in ipairs(container:GetChildren()) do
                if tool:IsA("Tool") then
                    local name = string.lower(tool.Name)
                    if string.find(name, "knife") or string.find(name, "sword") then return true end
                end
            end
        end
        return false
    end
    return hasMurderTool(player.Character) or hasMurderTool(player:FindFirstChild("Backpack"))
end

GunnerTab:CreateToggle({
    Name = "Teleport Murder",
    Flag = "TeleportMurder",
    Callback = function(v)
        TeleportMurderEnabled = v
        if v then
            TeleportConnection = RunService.RenderStepped:Connect(function()
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and isMurder(p) then
                        local head, myHRP = p.Character and p.Character:FindFirstChild("Head"), LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if head and myHRP then
                            myHRP.CFrame = CFrame.new(head.Position + Vector3.new(0, 15, 0))
                            Camera.CFrame = CFrame.new(Camera.CFrame.Position, head.Position)
                        end
                        break
                    end
                end
            end)
        else
            if TeleportConnection then TeleportConnection:Disconnect() TeleportConnection=nil end
            Camera.CameraType, Camera.CameraSubject = originalCameraType, originalSubject
        end
    end
})

GunnerTab:CreateToggle({
    Name = "Auto Kill Murder",
    Flag = "AutoKillMurder",
    Callback = function(v)
        AutoKillEnabled = v
        local Revolver = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Revolver")) or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Revolver"))
        if not Revolver then
            GUI:Notify({
                Title = "No Revolver",
                Content = "You didnt have Revolver",
                Duration = 5,
                Image = "shield-x",
            })
            return
        end
        if v then
            AutoKillConnection = RunService.RenderStepped:Connect(function()
                local Revolver = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Revolver")) or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Revolver"))
                if not Revolver then
                    GUI:Notify({
                        Title = "No Revolver",
                        Content = "You didnt have Revolver",
                        Duration = 5,
                        Image = "shield-x",
                    })
                    return
                end
                for _, p in ipairs(Players:GetPlayers()) do
                    if p~=LocalPlayer and isMurder(p) and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp, myHRP = p.Character.HumanoidRootPart, LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if myHRP then myHRP.CFrame = hrp.CFrame + Vector3.new(0,20,0) end
                        Revolver.RequestFire:FireServer(hrp.Position)
                        break
                    end
                end
            end)
        else
            if AutoKillConnection then AutoKillConnection:Disconnect() AutoKillConnection=nil end
        end
    end
})

GunnerTab:CreateToggle({
    Name = "Auto Shoot",
    Flag = "AutoShootMurder",
    Callback = function(v)
        if v then
            local Revolver = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Revolver")) or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Revolver"))
            if not Revolver then
                GUI:Notify({
                    Title = "No Revolver",
                    Content = "You didnt have Revolver",
                    Duration = 5,
                    Image = "shield-x",
                })
                return
            end

            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and isMurder(player) and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local HumanoidRootPart = player.Character.HumanoidRootPart
                    Revolver.RequestFire:FireServer(HumanoidRootPart.Position)
                end
            end
        end
    end
})

local MurderTab = Window:CreateTab("Murder", "sword")

local function KillAll()
    local knife = LocalPlayer.Character:FindFirstChild("Knife")
    if not knife then
        GUI:Notify({
            Title = "No Knife",
            Content = "You didnt have knife.",
            Duration = 5,
            Image = "sword"
        })        
        return
    end

    for i = 1, 5 do
        local stab = knife:FindFirstChild("RequestStab")
        if stab then
            stab:FireServer()
        end
    end

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            local hit = knife:FindFirstChild("RequestHit")
            if hum and hit then
                hit:FireServer(hum)
            end
        end
    end

    GUI:Notify({
        Title = "Kill All",
        Content = "Success to Kill All",
        Duration = 5,
        Image = "sword"
    })   
end

local function KillGunner()
    local function isGunner(player)
        local function hasGun(container)
            if container then
                for _, tool in ipairs(container:GetChildren()) do
                    if tool:IsA("Tool") then
                        local name = string.lower(tool.Name)
                        if string.find(name, "revolver") or string.find(name, "herorevolver") then
                            return true
                        end
                    end
                end
            end
            return false
        end
        return hasGun(player.Character) or hasGun(player:FindFirstChild("Backpack"))
    end
    
    local knife = LocalPlayer.Character:FindFirstChild("Knife")
    if not knife then 
        GUI:Notify({
            Title = "No Knife",
            Content = "You didnt have knife.",
            Duration = 5,
            Image = "sword"
        })
        return
    end

    for i = 1, 5 do
        local stab = knife:FindFirstChild("RequestStab")
        if stab then
            stab:FireServer()
        end
    end

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and isGunner(p) and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            local hit = knife:FindFirstChild("RequestHit")
            if hum and hit then
                hit:FireServer(hum)
            end
        end
    end
end

MurderTab:CreateButton({
    Name = "Kill Gunner",
    Callback = function() KillGunner() end,
})

MurderTab:CreateButton({
    Name = "Kill All",
    Callback = function() KillAll() end,
})

local function isGunner(player)
    local function hasGun(container)
        if container then
            for _, tool in ipairs(container:GetChildren()) do
                if tool:IsA("Tool") then
                    local name = string.lower(tool.Name)
                    if string.find(name, "revolver") or string.find(name, "herorevolver") then
                        return true
                    end
                end
            end
        end
        return false
    end
    return hasGun(player.Character) or hasGun(player:FindFirstChild("Backpack"))
end

local function monitorPlayer(player)
    local function onHumanoid(humanoid)
        humanoid.Died:Connect(function()
            if GunDropNotifyEnabled then
                local hadGun = isGunner(player)
                if hadGun then
                    GUI:Notify({
                        Title = "Gun Drop!",
                        Content = player.Name.."`s revolver is dropped!",
                        Duration = 5,
                        Image = "map",
                    })
                end
            end
        end)
    end

    local function onCharacterAdded(char)
        local humanoid = char:WaitForChild("Humanoid")
        onHumanoid(humanoid)
    end

    if player.Character then
        onCharacterAdded(player.Character)
    end
    player.CharacterAdded:Connect(onCharacterAdded)
end

for _, p in ipairs(Players:GetPlayers()) do monitorPlayer(p) end
Players.PlayerAdded:Connect(monitorPlayer)

GUI:LoadConfiguration()
