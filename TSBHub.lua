-- TSB Awakening Hub
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "TSBHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0,200,0,120)
main.Position = UDim2.new(0,10,0,10)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)
main.Active = true
main.Draggable = true
main.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.Text = "TSB HUB"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundColor3 = Color3.fromRGB(30,30,30)
title.Parent = main

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0,180,0,40)
btn.Position = UDim2.new(0,10,0,50)
btn.Text = "ENCHER DESPERTAR"
btn.BackgroundColor3 = Color3.fromRGB(180,30)
btn.TextColor3 = Color3.new(1,1,1)
btn.Parent = main

btn.MouseButton1Click:Connect(function()
    -- Método 1: tenta achar valores de Awakening no Player
    for _,v in pairs(player:GetDescendants()) do
        if v:IsA("NumberValue") or v:IsA("IntValue") then
            local n = string.lower(v.Name)
            if string.find(n, "awak") or string.find(n, "rage") or string.find(n, "ult") then
                v.Value = v.MaxValue or 100
                print("Setado:", v:GetFullName())
            end
        end
    end

    -- Método 2: tenta achar no character
    local char = player.Character
    if char then
        for _,v in pairs(char:GetDescendants()) do
            if v:IsA("NumberValue") and string.find(string.lower(v.Name), "awak") then
                v.Value = 100
            end
        end
    end

    -- Método 3: tenta disparar remote (nome varia por update)
    for _,r in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if r:IsA("RemoteEvent") and string.find(string.lower(r.Name), "awak") then
            print("Remote achada:", r.Name)
            -- pcall(function() r:FireServer(100) end)
        end
    end

    game.StarterGui:SetCore("SendNotification",{Title="TSB Hub",Text="Tentativa enviada! Veja o console (F9)",Duration=3})
end)

print("TSB Hub carregado")
