local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "👤kadd: Mining World👤",
   Icon = 0, 
   LoadingTitle = "👤kadd priv👤",
   LoadingSubtitle = "by kadd",
   Theme = "Default", 

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, 

   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, 
      FileName = "kadd HUB"
   },

   Discord = {
      Enabled = true, 
      Invite = "BWzBGNwaJH", 
      RememberJoins = true
   },

   KeySystem = false, 
   KeySettings = {
      Title = "Mining World Key",
      Subtitle = "Link In Discord Server",
      Note = "https://discord.gg/                   BWzBGNwaJH      Key Here ❤️", 
      FileName = "Mining World Key", 
      SaveKey = false, 
      GrabKeyFromSite = true, 
      Key = {"https://pastefy.app/D3rtUrej/raw"} 
   }
})



local MainTab = Window:CreateTab("💀💀💀", nil) 
local MainSection = MainTab:CreateSection("Auto Farm")

local Toggle = MainTab:CreateToggle({
    Name = "Auto Mine Nodes in the nearest range",  
    CurrentValue = false,
    Flag = "AutoMineRadius",
    Callback = function(Value)
        _G.AutoMineRadius = Value
        local player = game.Players.LocalPlayer

        local function SetCharacterPhysics(character, canCollide, anchored)
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = canCollide
                    part.Anchored = anchored
                end
            end
        end

        if Value then
            task.spawn(function()
                while _G.AutoMineRadius do
                    local character = player.Character or player.CharacterAdded:Wait()
                    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
                    local nodesFolder = workspace:WaitForChild("Nodes")
                    local closestNode = nil
                    local closestDistance = math.huge  

                    SetCharacterPhysics(character, false, true)

                    for _, node in pairs(nodesFolder:GetChildren()) do
                        if node:IsA("Model") and node.PrimaryPart then
                            local distance = (humanoidRootPart.Position - node.PrimaryPart.Position).Magnitude
                            if distance <= 150 and distance < closestDistance then
                                closestNode = node
                                closestDistance = distance
                            end
                        end
                    end

                    if closestNode then
                        local direction = (closestNode.PrimaryPart.Position - humanoidRootPart.Position).Unit
                        local sideOffset = direction * -5  
                        local verticalOffset = Vector3.new(0, 5, 0) 

                        local targetPosition = closestNode.PrimaryPart.Position + sideOffset + verticalOffset

                        character:SetPrimaryPartCFrame(CFrame.new(targetPosition, closestNode.PrimaryPart.Position))

                        local nodeGUID = closestNode.Name

                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("DamageNode"):FireServer(nodeGUID)

                        while closestNode and closestNode.Parent do
                            task.wait(0.2)  
                            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("DamageNode"):FireServer(nodeGUID)
                        end
                    end

                    task.wait(0.2)  
                end

                local character = player.Character
                if character then
                    SetCharacterPhysics(character, true, false)
                end
            end)
        else
            local character = player.Character
            if character then
                SetCharacterPhysics(character, true, false)
            end
        end
    end
})






local MainSection = MainTab:CreateSection("Discord: https://discord.gg/BWzBGNwaJH")
local MainSection = MainTab:CreateSection("the key resets once a day")


local tpTab = Window:CreateTab("TP", nil) 
local tpSection = tpTab:CreateSection("Teleport lvl 1")

local Dropdown = tpTab:CreateDropdown({
   Name = "Teleport",
   Options = {"Iron Node", "Gem Node", "Ice Node","Grassy Node"},
   CurrentOption = {"💀"},
   MultipleOptions = false,
   Flag = "Dropdown1",
   Callback = function(Options)
      local player = game.Players.LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

      if Options[1] == "Iron Node" then
         humanoidRootPart.CFrame = CFrame.new(2702, -1001, -6722)
      elseif Options[1] == "Gem Node" then
         humanoidRootPart.CFrame = CFrame.new(2937, -1003, -7188)
      elseif Options[1] == "Ice Node" then
         humanoidRootPart.CFrame = CFrame.new(3071, -1003, -6797)
      elseif Options[1] == "Grassy Node" then
         humanoidRootPart.CFrame = CFrame.new(3119, -1003, -6943)
      end
   end,
})


local tpSection = tpTab:CreateSection("Teleport lvl 2")


local Dropdown = tpTab:CreateDropdown({
   Name = "Teleport",
   Options = {"Pirate Crate", "Coral", "Witch Cauldron"},
   CurrentOption = {"💀"},
   MultipleOptions = false,
   Flag = "Dropdown2",
   Callback = function(Options)
      local player = game.Players.LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

      if Options[1] == "Pirate Crate" then
         humanoidRootPart.CFrame = CFrame.new(2375, -2142, -6587)
      elseif Options[1] == "Coral" then
         humanoidRootPart.CFrame = CFrame.new(2229, -2142, -6351)
      elseif Options[1] == "Witch Cauldron" then
         humanoidRootPart.CFrame = CFrame.new(1888, -2139, -6619)
      end
   end,
})

local sellTab = Window:CreateTab("Auto Sell", nil) 
local sellSection = sellTab:CreateSection("Auto Sell")

local autosellEnabled = false

task.spawn(function()
    while true do
        if autosellEnabled then
            -- Wysyłamy sygnał do serwera, żeby sprzedać wszystko
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellAll"):FireServer()
        end
        task.wait(5) -- Czekamy 5 sekund niezależnie czy AutoSell jest włączony czy nie
    end
end)

local Toggle = sellTab:CreateToggle({
    Name = "Auto Sell",
    CurrentValue = false,
    Flag = "Toggle20",
    Callback = function(Value)
        autosellEnabled = Value
    end,
})
