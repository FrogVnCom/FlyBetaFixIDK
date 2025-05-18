-- Script FrogVnCom - Fly + Speed Boost + Thu nhỏ cơ thể + UI tối ưu - HOẠT ĐỘNG HOÀN HẢO

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local flying = false
local baseFlySpeed = 50
local flySpeed = baseFlySpeed

local running = false
local baseWalkSpeed = 16
local boostedWalkSpeed = 32

local shrunken = false

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- UI chính
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.Name = "FlySpeedUI"

-- Welcome Achievement
local achievementText = Instance.new("TextLabel", screenGui)
achievementText.Size = UDim2.new(0, 200, 0, 40)
achievementText.Position = UDim2.new(0.5, -100, 0.1, 0)
achievementText.Text = "Welcome!"
achievementText.TextColor3 = Color3.new(1, 1, 1)
achievementText.BackgroundTransparency = 0.3
achievementText.TextScaled = true
achievementText.Font = Enum.Font.SourceSansBold

spawn(function()
    wait(5)
    achievementText.Visible = false
end)

-- Thanh slider
local sliderFrame = Instance.new("Frame", screenGui)
sliderFrame.Size = UDim2.new(0, 300, 0, 30)
sliderFrame.Position = UDim2.new(0.5, -150, 0.2, 0)
sliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local slider = Instance.new("Frame", sliderFrame)
slider.Size = UDim2.new(0.5, 0, 1, 0)
slider.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

-- Điều chỉnh tốc độ bay
sliderFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mousePos = UserInputService:GetMouseLocation().X
        local relativePos = math.clamp((mousePos - sliderFrame.AbsolutePosition.X) / sliderFrame.AbsoluteSize.X, 0, 1)
        slider.Size = UDim2.new(relativePos, 0, 1, 0)
        flySpeed = math.floor(relativePos * 100)
    end
end)

-- Fly control
local function startFlying()
    if flying then return end
    flying = true

    RunService.Heartbeat:Connect(function()
        if flying then
            humanoidRootPart.Velocity = humanoidRootPart.CFrame.LookVector * flySpeed
        end
    end)
end

local function stopFlying()
    flying = false
end

-- Thu nhỏ cơ thể
local function toggleShrink()
    humanoidRootPart.Size = shrunken and Vector3.new(2, 2, 1) or Vector3.new(1, 1, 0.5)
    shrunken = not shrunken
end

-- Phím điều khiển
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then
        if flying then stopFlying() else startFlying() end
    elseif input.KeyCode == Enum.KeyCode.G then
        humanoid.WalkSpeed = boostedWalkSpeed
    elseif input.KeyCode == Enum.KeyCode.M then
        toggleShrink()
    elseif input.KeyCode == Enum.KeyCode.LeftControl then
        screenGui.Enabled = not screenGui.Enabled
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.G then
        humanoid.WalkSpeed = baseWalkSpeed
    end
end)