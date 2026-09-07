local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

_G.AimbotEnabled = true
_G.FOV = 150 -- aumenta se quiser pegar de mais longe

UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Q then
        _G.AimbotEnabled = not _G.AimbotEnabled
        game.StarterGui:SetCore("SendNotification",{Title="Aimbot",Text=_G.AimbotEnabled and "LIGADO" or "DESLIGADO",Duration=1})
    end
end)

RunService.RenderStepped:Connect(function()
    if not _G.AimbotEnabled then return end
    local mousePos = UIS:GetMouseLocation()
    local closest, dist = nil, _G.FOV
    
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local part = p.Character:FindFirstChild("Head") or p.Character:FindFirstChild("HumanoidRootPart")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if part and hum and hum.Health > 0 then
                local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
                if onScreen then
                    local mag = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                    if mag < dist then
                        dist = mag
                        closest = part
                    end
                end
            end
        end
    end
    
    if closest then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Position)
    end
end)
print("Aimbot V2 carregado")
