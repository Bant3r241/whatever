if game.PlaceId == 82706969044553 then
    local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()
    local Window = OrionLib:MakeWindow({Name="ABI │ Reaper Legends!", HidePremium=false, IntroEnabled=false, IntroText="ABI", SaveConfig=true, ConfigFolder="XlurConfig"})
    
    _G.Sell = false
    local function Sell() game:GetService("ReplicatedStorage").Remotes.SellTP:FireServer() end

    local function autofarm()
        local player = game.Players.LocalPlayer
        local mouse = player:GetMouse()
        local targetPosition = Vector3.new(0, 0, 0)
        local target = workspace:FindPartOnRayWithWhitelist(Ray.new(mouse.Hit.p, Vector3.new(0, -1, 0)), {workspace})
        if target then
            mouse.Hit = CFrame.new(targetPosition)
            game:GetService("UserInputService"):InputBegan({UserInputType = Enum.UserInputType.MouseButton1, Position = Vector2.new(mouse.X, mouse.Y)})
            game:GetService("UserInputService"):InputEnded({UserInputType = Enum.UserInputType.MouseButton1, Position = Vector2.new(mouse.X, mouse.Y)})
        end
    end

    local function equipBestPet()
        local player = game.Players.LocalPlayer
        local bestPet = "Platypus"
        game:GetService("ReplicatedStorage").Remotes.PetEquip:FireServer(bestPet, player.Data.PetInventory[bestPet], "c096a36c-f639-40ea-a07b-4e0a63377c0e")
    end
    
    local MainTab = Window:MakeTab({Name="Main", Icon="rbxassetid://4299432428", PremiumOnly=false})
    MainTab:AddToggle({Name="Auto Farm", Default=false, Callback=function(v) _G.AutoHit = v if v then while _G.AutoHit do autofarm() wait(0.1) end end end})
    MainTab:AddButton({Name="Sell", Callback=Sell})
    MainTab:AddButton({Name="Equip Best Pet", Callback=equipBestPet})
    
    OrionLib:Init()
end
