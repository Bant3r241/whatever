local success, OrionLib = pcall(function()
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()
end)

if not success then
    print("Error loading OrionLib: " .. OrionLib)
    return
end

if game.PlaceId == 90462358603255 then
    local Window = OrionLib:MakeWindow({Name="ABI │ Anime Eternals", HidePremium=false, IntroEnabled=false, IntroText="ABI", SaveConfig=true, ConfigFolder="XlurConfig"})
    local MainTab = Window:MakeTab({Name="AutoFarm", Icon="rbxassetid://4299432428", PremiumOnly=false})

    local isTeleportActive = false
    local currentCoordIndex = 1

    local coords = {
        {-79.5, 16.1, 514.4}, {-92.1, 16.1, 524.2}, {-71.5, 16.1, 542.1}, {-86.7, 16.1, 552.1},
        {-76.1, 16.1, 606.2}, {-93.3, 16.1, 627.5}, {-74.2, 16.1, 647.8}, {-159.8, 16.1, 429.5},
        {-180.1, 16.1, 439.2}, {-204.9, 16.1, 448.0}
    }

    local function fireEvent(id)
        local args = {
            {
                Id = id,
                Action = "_Mouse_Click"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("To_Server"):FireServer(unpack(args))
    end

    MainTab:AddDropdown({
        Name = "World 1", 
        Default = "None", 
        Options = { "None", "Kriluni" }, 
        Callback = function(selected)
            if selected == "Kriluni" then
                while isTeleportActive do
                    if currentCoordIndex <= #coords then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(coords[currentCoordIndex][1], coords[currentCoordIndex][2], coords[currentCoordIndex][3])
                        wait(1)
                        local id = "f407-191337c22ece19f43ccf6d5acf7a" .. currentCoordIndex
                        fireEvent(id)
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("To_Server").OnClientEvent:Wait()
                        currentCoordIndex = currentCoordIndex + 1
                    else
                        print("All coordinates completed.")
                        break
                    end
                end
            elseif selected == "None" then
                print("No world selected")
            end
        end
    })

    MainTab:AddToggle({
        Name = "Activate Teleport", 
        Default = false, 
        Callback = function(value)
            isTeleportActive = value
        end
    })

    OrionLib:Init()
end
