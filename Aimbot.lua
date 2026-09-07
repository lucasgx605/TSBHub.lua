-- AIMBOT UNIVERSAL - Adaptado pra FPS
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

_G.AimbotEnabled = true
_G.TeamCheck = true -- true = não mira no próprio time
_G.AimPart = "Head" -- "Head" ou "HumanoidRootPart"
_G.Sensitivity = 0.15 -- 0.1 = mais travado (bom pra FPS), 0.3 = mais suave

-- Tecla pra ligar/desligar: Q
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Q then
        _G.AimbotEnabled = not _G.AimbotEnabled
        game.StarterGui:SetCore("SendNotification",{Title="Aimbot",Text=_G.AimbotEnabled and "LIGADO" or "DESLIGADO",Duration=1})
    end
end)

local function GetClosest()
    local closest, dist = nil, math.huge
    local mousePos = UIS:GetMouseLocation()
    
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild(_G.AimPart) then
            if _G.TeamCheck and p.Team == LocalPlayer.Team then continue end
            
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local pos, onScreen = Camera:WorldToViewportPoint(p.Character[_G.AimPart].Position)
                if onScreen then
                    local mag = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                    if mag < dist then
                        dist = mag
                        closest = p
                    end
                end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if _G.AimbotEnabled then
        -- Só mira se estiver segurando botão direito (bom pra FPS)
        -- Se quiser mira automática, tira o "and UIS:IsMouseButtonPressed"
        if UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            local target = GetClosest()
            if target and target.Character then
                local aimPos = target.Character[_G.AimPart].Position
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, aimPos), _G.Sensitivity)
            end
        end
    end
end)

print("Aimbot carregado! Segure BOTÃO DIREITO + Q liga/desliga")
