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

    MainTab:AddToggle({
        Name = "Activate Dropdown", 
        Default = false, 
        Callback = function(value)
            isDropdownActive = value
        end
    })

    MainTab:AddDropdown({
        Name = "World 1", 
        Default = "None", 
        Options = { "None", "Kriluni" }, 
        Callback = function(selected)
            if isDropdownActive then
                if selected == "Kriluni" then
                    print("World 1 - Kriluni selected")
                elseif selected == "None" then
                    print("No world selected")
                end
            else
                print("Dropdown is inactive.")
            end
        end
    })

    OrionLib:Init()
end
