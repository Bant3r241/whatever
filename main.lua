if game.PlaceId == 90462358603255 then
    local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()
    local Window = OrionLib:MakeWindow({Name="ABI │ Reaper Legends!", HidePremium=false, IntroEnabled=false, IntroText="ABI", SaveConfig=true, ConfigFolder="XlurConfig"})


    
    local AutoFarm = Window:MakeTab({Name="Main", Icon="rbxassetid://4299432428", PremiumOnly=false})

    
    OrionLib:Init()
