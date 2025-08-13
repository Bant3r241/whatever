if game.PlaceId == 90462358603255 then
    local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()
    local Window = OrionLib:MakeWindow({Name="ABI │ Anime Eternal", HidePremium=false, IntroEnabled=false, IntroText="ABI", SaveConfig=true, ConfigFolder="XlurConfig"})
   
    
    
    local MainTab = Window:MakeTab({Name="AutoFarm", Icon="rbxassetid://4299432428", PremiumOnly=false})
    MainTab:AddDropdown({
    Name = "World 1", Default = "Kriluni", Options = { "Kriluni" }, 
        Callback = function(selected) if selected == "Kriluni" then print("World 1 - Kriluni selected") end
    })
    OrionLib:Init()
end
