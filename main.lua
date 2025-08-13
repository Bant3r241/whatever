if game.PlaceId == 90462358603255 then
    local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()
    local Window = OrionLib:MakeWindow({Name="ABI │ Anime Eternal", HidePremium=false, IntroEnabled=false, IntroText="ABI", SaveConfig=true, ConfigFolder="XlurConfig"})

    local AutoFarm = Window:MakeTab({Name="AutoFarm", Icon="rbxassetid://4299432428", PremiumOnly=false})

    local coords = {
        {-79.5, 16.1, 514.4}, {-92.1, 16.1, 524.2}, {-71.5, 16.1, 542.1}, {-86.7, 16.1, 552.1},
        {-76.1, 16.1, 606.2}, {-93.3, 16.1, 627.5}, {-74.2, 16.1, 647.8}, {-159.8, 16.1, 429.5},
        {-180.1, 16.1, 439.2}, {-204.9, 16.1, 448.0}
    }

    AutoFarm:AddDropdown({
        Name = "World 1", 
        Default = "Kriluni", 
        Options = { "Kriluni" }, 
        Callback = function(selected)
            if selected == "Kriluni" then
                local i = 1
                local function teleport()
                    if i <= #coords then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(coords[i][1], coords[i][2], coords[i][3])
                        repeat wait(1) until -- Condition to check if enemy is defeated, e.g., enemy health == 0
                        i = i + 1
                        teleport()
                    end
                end
                teleport()
            end
        end

    OrionLib:Init()
