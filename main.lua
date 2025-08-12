if game.PlaceId == 90462358603255 then
    local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()
    local Window = OrionLib:MakeWindow({Name="ABI │ Anime Eternal", HidePremium=false, IntroEnabled=false, IntroText="ABI", SaveConfig=true, ConfigFolder="XlurConfig"})

    _G.AutoFarm = false

    local punchEvent = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("To_Server")
    local player = game.Players.LocalPlayer
    local enemiesFolder = workspace:WaitForChild("3. Bleach - Soul Society Monster Pads")

    local function autofarm()
        spawn(function()
            while _G.AutoFarm do
                for _, enemy in pairs(enemiesFolder:GetChildren()) do
                    local hum = enemy:FindFirstChild("Humanoid")
                    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                    if hum and hrp and hum.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
                        hrp.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                        task.wait(0.1)
                        punchEvent:FireServer({{Id = enemy.Name, Action = "_Mouse_Click"}})
                        repeat task.wait() until hum.Health <= 0 or not enemy:IsDescendantOf(enemiesFolder)
                    end
                end
                task.wait(1)
            end
        end)
    end

    local MainTab = Window:MakeTab({Name="Main", Icon="rbxassetid://4299432428", PremiumOnly=false})
    MainTab:AddToggle({
        Name = "Auto Farm",
        Default = false,
        Callback = function(v)
            _G.AutoFarm = v
            if v then autofarm() end
        end
    })

    OrionLib:Init()
end
