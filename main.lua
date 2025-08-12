if game.PlaceId == 128120317905952 then
    local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()
    local Window = OrionLib:MakeWindow({Name="ABI │ Click To Aura Farm", HidePremium=false, IntroEnabled=false, IntroText="ABI", SaveConfig=true, ConfigFolder="XlurConfig"})

    _G.AutoHit = false
    function autoHit() while _G.AutoHit do game:GetService("ReplicatedStorage").src.Packages.Knit.Services.GameService.RE.HandleClick:FireServer(3) task.wait(0.1) end end

    local MainTab = Window:MakeTab({Name="Main", Icon="rbxassetid://4299432428", PremiumOnly=false})
    MainTab:AddToggle({Name="Auto Hit", Default=false, Callback=function(v) _G.AutoHit = v if v then autoHit() end end})
end

OrionLib:Init()
