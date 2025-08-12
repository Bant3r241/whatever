if game.PlaceId == 82706969044553 then
    local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()
    local Window = OrionLib:MakeWindow({Name="ABI │ Reaper Legends!", HidePremium=false, IntroEnabled=false, IntroText="ABI", SaveConfig=true, ConfigFolder="XlurConfig"})

    _G.Sell = false
    local function Sell() game:GetService("ReplicatedStorage").Remotes.SellTP:FireServer() end

    local function equipBestPet()
        local player = game.Players.LocalPlayer
        local petInventory = player:WaitForChild("Data"):WaitForChild("PetInventory")
        local bestPet, bestPetName

        for petName, petData in pairs(petInventory:GetChildren()) do
            if not bestPet or petData.Level.Value > bestPet.Level.Value then
                bestPet = petData
                bestPetName = petName
            end
        end

        if bestPet then
            game:GetService("ReplicatedStorage").Remotes.PetEquip:FireServer(bestPetName, bestPet, "c096a36c-f639-40ea-a07b-4e0a63377c0e")
        end
    end
    
    local MainTab = Window:MakeTab({Name="Main", Icon="rbxassetid://4299432428", PremiumOnly=false})
    MainTab:AddButton({Name="Sell", Callback=Sell})
    MainTab:AddButton({Name="Equip Best Pet", Callback=equipBestPet})
    
    OrionLib:Init()
end
