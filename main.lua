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

    local isDropdownActive = false

    local coords = {
        {-79.5, 16.1, 514.4}, {-92.1, 16.1, 524.2}, {-71.5, 16.1, 542.1}, {-86.7, 16.1, 552.1},
        {-76.1, 16.1, 606.2}, {-93.3, 16.1, 627.5}, {-74.2, 16.1, 647.8}, {-159.8, 16.1, 429.5},
        {-180.1, 16.1, 439.2}, {-204.9, 16.1, 448.0}
    }

    MainTab:AddDropdown({
        Name = "World 1", 
        Default = "None", 
        Options = { "None", "Kriluni" }, 
        Callback = function(selected)
            if isDropdownActive then
                if selected == "Kriluni" then
                    for i = 1, #coords do
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(coords[i][1], coords[i][2], coords[i][3])
                        wait(1)  -- Wait a second before teleporting to the next coordinate
                    end
                elseif selected == "None" then
                    print("No world selected")
                end
            else
                print("Dropdown is inactive.")
            end
        end
    })

    MainTab:AddToggle({
        Name = "Activate Dropdown", 
        Default = false, 
        Callback = function(value)
            isDropdownActive = value
        end
    })

    OrionLib:Init()
end
