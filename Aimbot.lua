-- [VC] Podcasts - Noclip + Teleportes
local player = game.Players.LocalPlayer
local noclip = true
local savedPos = nil

-- GUI
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "VCPodcasts"
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 160, 0, 200)
frame.Position = UDim2.new(0, 10, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame)

local function criarBotao(texto, ordem, func)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(1, -10, 0, 35)
    b.Position = UDim2.new(0, 5, 0, 5 + (ordem*40))
    b.Text = texto
    b.BackgroundColor3 = Color3.fromRGB(50,50,50)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(func)
end

criarBotao("Noclip: ON", 0, function() 
    noclip = not noclip 
end)

criarBotao("Salvar Posição", 1, function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        savedPos = player.Character.HumanoidRootPart.CFrame
        game.StarterGui:SetCore("SendNotification",{Title="Salvo",Text="Posição salva!",Duration=2})
    end
end)

criarBotao("Ir p/ Salva", 2, function()
    if savedPos and player.Character then
        player.Character.HumanoidRootPart.CFrame = savedPos
    end
end)

criarBotao("Ir p/ Palco", 3, function()
    -- Anda até o palco uma vez, aperta "Salvar Posição", depois usa "Ir p/ Salva"
    game.StarterGui:SetCore("SendNotification",{Title="Dica",Text="Vá até o palco e clique em Salvar Posição",Duration=3})
end)

-- Noclip loop
game:GetService("RunService").Stepped:Connect(function()
    if noclip and player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)
print("Script [VC] Podcasts carregado!")
