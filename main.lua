if game.PlaceId == 90462358603255 then
    local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()
    local Window = OrionLib:MakeWindow({Name="ABI │ Catch A Brainrot",HidePremium=false,IntroEnabled=false,IntroText="ABI",SaveConfig=true,ConfigFolder="XlurConfig"})

    _G.autoClaim,_G.FuseAll,_G.SellAll,_G.CollectAll=false,false,false
    _G.AutoBuySprout,_G.AutoBuySun,_G.AutoBuySpace=false,false,false
    _G.AutoBuyFries,_G.AutoBuyBanana,_G.AutoBuyCheese,_G.AutoBuyWatermelon=false,false,false,false
    _G.AutoBuyPineapple,_G.AutoBuyCupcake,_G.AutoBuyGold,_G.AutoBuyDiamond=false,false,false,false
    _G.InfiniteJump,_G.ESP=false
    _G.WalkSpeed=16

    function autoClaimTrap()
        while _G.autoClaim do
            for i=1,12 do
                local trap="Trap"..i
                local TrapService=game:GetService("ReplicatedStorage").Packages.Knit.Services.TrapService.RF
                TrapService.Reveal:InvokeServer(trap)
                TrapService.Claim:InvokeServer(trap)
                wait(1)
            end
        end
    end

    function FuseAll() game:GetService("ReplicatedStorage").Packages.Knit.Services.RelicService.RF.SubmitAll:InvokeServer() end
    function SellAll() game:GetService("ReplicatedStorage").Packages.Knit.Services.SellService.RF.SellAll:InvokeServer() end

    function AutoBuyRelic(name)
        while _G["AutoBuy"..name] do
            game:GetService("ReplicatedStorage").Packages.Knit.Services.RelicShopService.RF.Purchase:InvokeServer(name)
            wait(5)
        end
    end

    function AutoBuyBait(name)
        while _G["AutoBuy"..name] do
            game:GetService("ReplicatedStorage").Packages.Knit.Services.BaitShopService.RF.Purchase:InvokeServer(name)
            wait(5)
        end
    end
  function AutoCollect()
    while _G.AutoCollect do
        for i = 1, 15 do
            game:GetService("ReplicatedStorage").Packages.Knit.Services.EnclosureService.RF.CollectMoney:InvokeServer(i)
            wait(0.1)
        end
        wait(1)
    end
end


    local MainTab = Window:MakeTab({Name="Main",Icon="rbxassetid://4299432428",PremiumOnly=false})
    MainTab:AddToggle({Name="Auto Claim",Default=false,Callback=function(v) _G.autoClaim=v if v then autoClaimTrap() end end})
    MainTab:AddToggle({Name="Fuse All With Relic",Default=false,Callback=function(v) _G.FuseAll=v if v then FuseAll() end end})
    MainTab:AddToggle({Name="Sell All",Default=false,Callback=function(v) _G.SellAll=v if v then SellAll() end end})
    MainTab:AddToggle({Name="Auto Collect",Default=false,Callback=function(v) _G.AutoCollect=v if v then AutoCollect() end end})

    local RelicsTab=Window:MakeTab({Name="Relics",Icon="rbxassetid://4299432428",PremiumOnly=false})
    RelicsTab:AddToggle({Name="Auto Buy Sprout",Default=false,Callback=function(v) _G.AutoBuySprout=v if v then AutoBuyRelic("Sprout") end end})
    RelicsTab:AddToggle({Name="Auto Buy Sun",Default=false,Callback=function(v) _G.AutoBuySun=v if v then AutoBuyRelic("Sun") end end})
    RelicsTab:AddToggle({Name="Auto Buy Space",Default=false,Callback=function(v) _G.AutoBuySpace=v if v then AutoBuyRelic("Space") end end})

    local BaitTab=Window:MakeTab({Name="Bait",Icon="rbxassetid://4299432428",PremiumOnly=false})
    for _,bait in pairs({"Fries","Banana","Cheese","Watermelon","Pineapple","Cupcake","Gold","Diamond"}) do
        BaitTab:AddToggle({Name="Auto Buy "..bait,Default=false,Callback=function(v) _G["AutoBuy"..bait]=v if v then AutoBuyBait(bait) end end})
    end

    local MiscTab=Window:MakeTab({Name="Misc",Icon="rbxassetid://4299432428",PremiumOnly=false})
    MiscTab:AddToggle({Name="Infinite Jump",Default=false,Callback=function(v) 
        _G.InfiniteJump=v
        if v then
            game:GetService("UserInputService").InputBegan:Connect(function(inp,gp)
                if not gp and inp.UserInputType==Enum.UserInputType.Keyboard and inp.KeyCode==Enum.KeyCode.Space then
                    local plr=game.Players.LocalPlayer
                    local hum=plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
                    if hum and (hum:GetState()==Enum.HumanoidStateType.Jumping or hum:GetState()==Enum.HumanoidStateType.Freefall) then
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end)
        end
    end})

    MiscTab:AddSlider({
        Name="Walk Speed",
        Min=16,
        Max=100,
        Default=16,
        Increment=1,
        Color=Color3.new(1,1,1),
        ValueName="Speed",
        Callback=function(val)
            _G.WalkSpeed=val
            local plr=game.Players.LocalPlayer
            local char=plr.Character or plr.CharacterAdded:Wait()
            local hum=char:WaitForChild("Humanoid")
            hum.WalkSpeed=val
        end
    })

    MiscTab:AddToggle({Name="ESP",Default=false,Callback=function(v)
        _G.ESP=v
        if v then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Bant3r241/CornerESP/refs/heads/main/ESP.lua"))()
        end
    end})

end

OrionLib:Init()
