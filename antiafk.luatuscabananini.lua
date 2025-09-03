-- Anti-AFK GUI mejorado (toggle, intervalos, aleatorio, teclas configurables, draggable)
-- Autor base: Tuscabananini | Mejora: ChatGPT
-- ADVERTENCIA: Puede violar reglas de juegos/plataformas. Úsalo bajo tu responsabilidad.

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local player = Players.LocalPlayer
local pg = player:WaitForChild("PlayerGui")

--==================== GUI ====================--
local gui = Instance.new("ScreenGui")
gui.Name = "AntiAFKGui"
gui.ResetOnSpawn = false
gui.Parent = pg

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 170)
frame.Position = UDim2.new(0.5, -150, 0, 50)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BorderSizePixel = 0
frame.Parent = gui

local uiCorner = Instance.new("UICorner", frame)
uiCorner.CornerRadius = UDim.new(0,10)

local title = Instance.new("TextLabel")
title.Text = "Anti AFK • Tuscabananini"
title.Size = UDim2.new(1, -30, 0, 26)
title.Position = UDim2.new(0, 10, 0, 6)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

local minimize = Instance.new("TextButton")
minimize.Text = "-"
minimize.Size = UDim2.new(0, 24, 0, 24)
minimize.Position = UDim2.new(1, -30, 0, 6)
minimize.BackgroundColor3 = Color3.fromRGB(45,45,45)
minimize.TextColor3 = Color3.fromRGB(255,255,255)
minimize.Font = Enum.Font.SourceSansBold
minimize.TextSize = 18
minimize.Parent = frame
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0,6)

local status = Instance.new("TextLabel")
status.Text = "Estado: OFF"
status.Size = UDim2.new(1, -20, 0, 20)
status.Position = UDim2.new(0, 10, 0, 36)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(255,60,60)
status.Font = Enum.Font.SourceSansBold
status.TextSize = 14
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = frame

local timerLbl = Instance.new("TextLabel")
timerLbl.Text = "Tiempo: 0s"
timerLbl.Size = UDim2.new(1, -20, 0, 20)
timerLbl.Position = UDim2.new(0, 10, 0, 58)
timerLbl.BackgroundTransparency = 1
timerLbl.TextColor3 = Color3.fromRGB(230,230,230)
timerLbl.Font = Enum.Font.SourceSans
timerLbl.TextSize = 14
timerLbl.TextXAlignment = Enum.TextXAlignment.Left
timerLbl.Parent = frame

-- Controles
local intervalLbl = Instance.new("TextLabel")
intervalLbl.Text = "Intervalo (s):"
intervalLbl.Size = UDim2.new(0, 100, 0, 24)
intervalLbl.Position = UDim2.new(0, 10, 0, 86)
intervalLbl.BackgroundTransparency = 1
intervalLbl.TextColor3 = Color3.fromRGB(200,200,200)
intervalLbl.Font = Enum.Font.SourceSans
intervalLbl.TextSize = 14
intervalLbl.Parent = frame

local intervalBox = Instance.new("TextBox")
intervalBox.Text = "60"
intervalBox.Size = UDim2.new(0, 60, 0, 24)
intervalBox.Position = UDim2.new(0, 110, 0, 86)
intervalBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
intervalBox.TextColor3 = Color3.fromRGB(255,255,255)
intervalBox.Font = Enum.Font.SourceSans
intervalBox.ClearTextOnFocus = false
intervalBox.TextSize = 14
intervalBox.Parent = frame
Instance.new("UICorner", intervalBox).CornerRadius = UDim.new(0,6)

local randBtn = Instance.new("TextButton")
randBtn.Text = "Aleatorio: OFF"
randBtn.Size = UDim2.new(0, 110, 0, 24)
randBtn.Position = UDim2.new(0, 180, 0, 86)
randBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
randBtn.TextColor3 = Color3.fromRGB(255,255,255)
randBtn.Font = Enum.Font.SourceSans
randBtn.TextSize = 14
randBtn.Parent = frame
Instance.new("UICorner", randBtn).CornerRadius = UDim.new(0,6)

local varLbl = Instance.new("TextLabel")
varLbl.Text = "±Var (s):"
varLbl.Size = UDim2.new(0, 100, 0, 24)
varLbl.Position = UDim2.new(0, 10, 0, 116)
varLbl.BackgroundTransparency = 1
varLbl.TextColor3 = Color3.fromRGB(200,200,200)
varLbl.Font = Enum.Font.SourceSans
varLbl.TextSize = 14
varLbl.Parent = frame

local varBox = Instance.new("TextBox")
varBox.Text = "15"
varBox.Size = UDim2.new(0, 60, 0, 24)
varBox.Position = UDim2.new(0, 110, 0, 116)
varBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
varBox.TextColor3 = Color3.fromRGB(255,255,255)
varBox.Font = Enum.Font.SourceSans
varBox.ClearTextOnFocus = false
varBox.TextSize = 14
varBox.Parent = frame
Instance.new("UICorner", varBox).CornerRadius = UDim.new(0,6)

local keysLbl = Instance.new("TextLabel")
keysLbl.Text = "Teclas (coma):"
keysLbl.Size = UDim2.new(0, 110, 0, 24)
keysLbl.Position = UDim2.new(0, 180, 0, 116)
keysLbl.BackgroundTransparency = 1
keysLbl.TextColor3 = Color3.fromRGB(200,200,200)
keysLbl.Font = Enum.Font.SourceSans
keysLbl.TextSize = 14
keysLbl.Parent = frame

local keysBox = Instance.new("TextBox")
keysBox.Text = "W,A,S,D"
keysBox.Size = UDim2.new(0, 110, 0, 24)
keysBox.Position = UDim2.new(0, 180, 0, 140)
keysBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
keysBox.TextColor3 = Color3.fromRGB(255,255,255)
keysBox.Font = Enum.Font.SourceSans
keysBox.ClearTextOnFocus = false
keysBox.TextSize = 14
keysBox.Parent = frame
Instance.new("UICorner", keysBox).CornerRadius = UDim.new(0,6)

local toggleBtn = Instance.new("TextButton")
toggleBtn.Text = "START"
toggleBtn.Size = UDim2.new(0, 160, 0, 28)
toggleBtn.Position = UDim2.new(0, 10, 0, 140)
toggleBtn.BackgroundColor3 = Color3.fromRGB(0,140,90)
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 16
toggleBtn.Parent = frame
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0,8)

-- Draggable por el título
do
    local dragging = false
    local dragStart, startPos
    title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Minimizar
local collapsed = false
minimize.MouseButton1Click:Connect(function()
    collapsed = not collapsed
    minimize.Text = collapsed and "+" or "-"
    for _,child in ipairs(frame:GetChildren()) do
        if child ~= title and child ~= minimize and child:IsA("GuiObject") then
            child.Visible = not collapsed
        end
    end
    frame.Size = collapsed and UDim2.new(0,300,0,36) or UDim2.new(0,300,0,170)
end)

--==================== LÓGICA ====================--
local running = false
local tiempo = 0
local lastTick = os.clock()
local randomEnabled = false

local keyMap = {
    ["W"] = Enum.KeyCode.W, ["A"] = Enum.KeyCode.A, ["S"] = Enum.KeyCode.S, ["D"] = Enum.KeyCode.D,
    ["SPACE"] = Enum.KeyCode.Space, ["E"] = Enum.KeyCode.E, ["Q"] = Enum.KeyCode.Q,
    ["R"] = Enum.KeyCode.R, ["F"] = Enum.KeyCode.F, ["SHIFT"] = Enum.KeyCode.LeftShift
}

local function parseKeys(str)
    local out = {}
    for token in string.gmatch(string.upper(str), "[^,%s]+") do
        if keyMap[token] then
            table.insert(out, keyMap[token])
        end
    end
    if #out == 0 then
        -- fallback por si el usuario mete algo inválido
        out = {Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D}
    end
    return out
end

local function getInterval()
    local base = tonumber(intervalBox.Text) or 60
    base = math.clamp(math.floor(base), 5, 600)
    local var = tonumber(varBox.Text) or 0
    var = math.clamp(math.floor(var), 0, 300)
    if randomEnabled and var > 0 then
        local delta = math.random(-var, var)
        return math.max(2, base + delta)
    end
    return base
end

local function setStatus(on)
    running = on
    status.Text = on and "Estado: ON" or "Estado: OFF"
    status.TextColor3 = on and Color3.fromRGB(0,255,130) or Color3.fromRGB(255,60,60)
    toggleBtn.Text = on and "STOP" or "START"
    toggleBtn.BackgroundColor3 = on and Color3.fromRGB(200,60,60) or Color3.fromRGB(0,140,90)
    if not on then
        tiempo = 0
        timerLbl.Text = "Tiempo: 0s"
    end
end

randBtn.MouseButton1Click:Connect(function()
    randomEnabled = not randomEnabled
    randBtn.Text = randomEnabled and "Aleatorio: ON" or "Aleatorio: OFF"
    randBtn.BackgroundColor3 = randomEnabled and Color3.fromRGB(60,120,60) or Color3.fromRGB(45,45,45)
end)

toggleBtn.MouseButton1Click:Connect(function()
    setStatus(not running)
    lastTick = os.clock()
end)

-- Bucle
task.spawn(function()
    local teclas = parseKeys(keysBox.Text)
    keysBox.FocusLost:Connect(function() teclas = parseKeys(keysBox.Text) end)

    while true do
        task.wait(0.2)

        -- no enviar input si estás escribiendo en un TextBox (chat, etc.)
        if UIS:GetFocusedTextBox() then
            lastTick = os.clock()
            continue
        end

        if running then
            tiempo += 0.2
            if math.floor(tiempo) % 1 == 0 then
                timerLbl.Text = ("Tiempo: %ds"):format(math.floor(tiempo))
            end

            local now = os.clock()
            local interval = getInterval()
            if now - lastTick >= interval then
                -- Elegir tecla aleatoria de la lista válida
                local tecla = teclas[math.random(1, #teclas)]
                status.Text = "Presionando: " .. tecla.Name

                -- Pulsación breve
                VirtualInputManager:SendKeyEvent(true, tecla, false, game)
                task.wait(0.05 + math.random() * 0.15) -- 50–200ms
                VirtualInputManager:SendKeyEvent(false, tecla, false, game)

                -- Pequeño “shake” de mouse opcional (descomenta si lo quieres)
                -- local mx = math.random(-2,2)
                -- local my = math.random(-2,2)
                -- VirtualInputManager:SendMouseMove(0,0) -- centra delta (algunos exploits usan MoveMouse)
                -- task.wait()
                -- VirtualInputManager:SendMouseMove(mx, my)

                status.Text = "Estado: ON"
                lastTick = now
            end
        end
    end
end)
