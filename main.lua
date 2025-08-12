if game.PlaceId == 90462358603255 then
    local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()
    local Window = OrionLib:MakeWindow({Name="ABI │ Anime Eternal", HidePremium=false, IntroEnabled=false, IntroText="ABI", SaveConfig=true, ConfigFolder="XlurConfig"})

    _G.AutoFarm = false

    local punchEvent = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("To_Server")
    local player = game.Players.LocalPlayer
    local monstersFolder = workspace:WaitForChild("Debris"):WaitForChild("Monsters")

    local function autofarm()
        spawn(function()
            while _G.AutoFarm do
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hrp then
                    warn("HumanoidRootPart not found!")
                    task.wait(1)
                    continue
                end

                for _, enemy in pairs(monstersFolder:GetChildren()) do
                    local hum = enemy:FindFirstChild("Humanoid")
                    local enemyHRP = enemy:FindFirstChild("HumanoidRootPart")
                    if hum and enemyHRP and hum.Health > 0 then
                        print("Teleporting to enemy:", enemy.Name)
                        hrp.CFrame = enemyHRP.CFrame * CFrame.new(0, 0, -3)
                        task.wait(0.1)

                        punchEvent:FireServer({{Id = enemy.Name, Action = "_Mouse_Click"}})
                        repeat task.wait() until hum.Health <= 0 or not enemy:IsDescendantOf(monstersFolder)
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
