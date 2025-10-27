local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- 创建主UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SuicideScriptUI"
ScreenGui.Parent = player.PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- 创建主框架
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 350, 0, 400)
MainFrame.ClipsDescendants = true

-- 添加黑白渐变背景
local BackgroundGradient = Instance.new("UIGradient")
BackgroundGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(50, 50, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 25))
})
BackgroundGradient.Rotation = 45
BackgroundGradient.Parent = MainFrame

-- 创建标题栏
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 40)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "脚本中心自杀脚本"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.TextStrokeTransparency = 0.8

-- 关闭按钮
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(0.9, 0, 0.2, 0)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18

-- 最小化按钮
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(0.8, 0, 0.2, 0)
MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 18

-- 内容容器
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.Size = UDim2.new(1, 0, 1, -40)

-- 创建按钮容器
local ButtonsContainer = Instance.new("Frame")
ButtonsContainer.Name = "ButtonsContainer"
ButtonsContainer.Parent = ContentFrame
ButtonsContainer.BackgroundTransparency = 1
ButtonsContainer.Position = UDim2.new(0.1, 0, 0.05, 0)
ButtonsContainer.Size = UDim2.new(0.8, 0, 0.8, 0)

-- 自杀按钮
local SuicideButton = Instance.new("TextButton")
SuicideButton.Name = "SuicideButton"
SuicideButton.Parent = ButtonsContainer
SuicideButton.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
SuicideButton.BorderSizePixel = 0
SuicideButton.Position = UDim2.new(0, 0, 0, 0)
SuicideButton.Size = UDim2.new(1, 0, 0, 50)
SuicideButton.Font = Enum.Font.GothamBold
SuicideButton.Text = "自 杀"
SuicideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SuicideButton.TextSize = 20
SuicideButton.TextStrokeTransparency = 0.8

-- 循环自杀按钮
local LoopSuicideButton = Instance.new("TextButton")
LoopSuicideButton.Name = "LoopSuicideButton"
LoopSuicideButton.Parent = ButtonsContainer
LoopSuicideButton.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
LoopSuicideButton.BorderSizePixel = 0
LoopSuicideButton.Position = UDim2.new(0, 0, 0.2, 0)
LoopSuicideButton.Size = UDim2.new(1, 0, 0, 50)
LoopSuicideButton.Font = Enum.Font.GothamBold
LoopSuicideButton.Text = "循环自杀 [关闭]"
LoopSuicideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LoopSuicideButton.TextSize = 20
LoopSuicideButton.TextStrokeTransparency = 0.8

-- 飞天自杀按钮
local FlySuicideButton = Instance.new("TextButton")
FlySuicideButton.Name = "FlySuicideButton"
FlySuicideButton.Parent = ButtonsContainer
FlySuicideButton.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
FlySuicideButton.BorderSizePixel = 0
FlySuicideButton.Position = UDim2.new(0, 0, 0.4, 0)
FlySuicideButton.Size = UDim2.new(1, 0, 0, 50)
FlySuicideButton.Font = Enum.Font.GothamBold
FlySuicideButton.Text = "飞天自杀"
FlySuicideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlySuicideButton.TextSize = 20
FlySuicideButton.TextStrokeTransparency = 0.8

-- 状态标签
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = ContentFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 0, 0.85, 0)
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "就绪"
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.TextSize = 14
StatusLabel.TextStrokeTransparency = 0.9

-- 添加圆角效果
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = SuicideButton
ButtonCorner:Clone().Parent = LoopSuicideButton
ButtonCorner:Clone().Parent = FlySuicideButton
ButtonCorner:Clone().Parent = CloseButton
ButtonCorner:Clone().Parent = MinimizeButton

-- 添加阴影效果
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(100, 100, 100)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- 变量
local isLoopSuicide = false
local loopConnection = nil
local isMinimized = false

-- 通知函数
local function SendNotification(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150",
        Duration = 5
    })
end

-- 自杀函数
local function Suicide()
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.Health = 0
        StatusLabel.Text = "自杀执行成功"
        SendNotification("自杀", "自杀命令已执行")
    else
        StatusLabel.Text = "错误：找不到角色或Humanoid"
        SendNotification("错误", "找不到角色或Humanoid")
    end
end

-- 飞天自杀函数
local function FlySuicide()
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        StatusLabel.Text = "飞天自杀执行中..."
        SendNotification("飞天自杀", "开始飞天自杀")
        
        -- 保存原始重力设置
        local originalGravity = workspace.Gravity
        
        -- 禁用重力
        workspace.Gravity = 0
        
        -- 飞到高空
        local humanoidRootPart = character.HumanoidRootPart
        humanoidRootPart.Velocity = Vector3.new(0, 100, 0)
        
        -- 等待一会儿然后恢复重力
        wait(3)
        workspace.Gravity = originalGravity
        
        StatusLabel.Text = "飞天自杀完成"
        SendNotification("飞天自杀", "飞天自杀完成")
    else
        StatusLabel.Text = "错误：找不到角色或HumanoidRootPart"
        SendNotification("错误", "找不到角色或HumanoidRootPart")
    end
end

-- 循环自杀函数
local function ToggleLoopSuicide()
    isLoopSuicide = not isLoopSuicide
    
    if isLoopSuicide then
        StatusLabel.Text = "循环自杀已开启"
        LoopSuicideButton.Text = "循环自杀 [开启]"
        LoopSuicideButton.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
        SendNotification("循环自杀", "循环自杀已开启")
        
        -- 开始循环自杀
        loopConnection = RunService.Heartbeat:Connect(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.Health = 0
            end
        end)
    else
        StatusLabel.Text = "循环自杀已关闭"
        LoopSuicideButton.Text = "循环自杀 [关闭]"
        LoopSuicideButton.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
        SendNotification("循环自杀", "循环自杀已关闭")
        
        -- 停止循环自杀
        if loopConnection then
            loopConnection:Disconnect()
            loopConnection = nil
        end
    end
end

-- 按钮动画函数
local function CreateButtonAnimation(button)
    local originalSize = button.Size
    local originalPosition = button.Position
    
    button.MouseEnter:Connect(function()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(button, tweenInfo, {
            Size = originalSize + UDim2.new(0, 10, 0, 5),
            Position = originalPosition - UDim2.new(0, 5, 0, 2.5)
        })
        tween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(button, tweenInfo, {
            Size = originalSize,
            Position = originalPosition
        })
        tween:Play()
    end)
    
    button.MouseButton1Down:Connect(function()
        local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(button, tweenInfo, {
            Size = originalSize - UDim2.new(0, 5, 0, 2),
            Position = originalPosition + UDim2.new(0, 2.5, 0, 1)
        })
        tween:Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(button, tweenInfo, {
            Size = originalSize,
            Position = originalPosition
        })
        tween:Play()
    end)
end

-- 应用按钮动画
CreateButtonAnimation(SuicideButton)
CreateButtonAnimation(LoopSuicideButton)
CreateButtonAnimation(FlySuicideButton)
CreateButtonAnimation(CloseButton)
CreateButtonAnimation(MinimizeButton)

-- 按钮点击事件
SuicideButton.MouseButton1Click:Connect(Suicide)
LoopSuicideButton.MouseButton1Click:Connect(ToggleLoopSuicide)
FlySuicideButton.MouseButton1Click:Connect(FlySuicide)

-- 关闭按钮事件
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    SendNotification("脚本中心", "UI已关闭")
end)

-- 最小化按钮事件
MinimizeButton.MouseButton1Click:Connect(function()
    if isMinimized then
        -- 恢复
        MainFrame.Size = UDim2.new(0, 350, 0, 400)
        ContentFrame.Visible = true
        isMinimized = false
    else
        -- 最小化
        MainFrame.Size = UDim2.new(0, 350, 0, 40)
        ContentFrame.Visible = false
        isMinimized = true
    end
end)

-- 使UI可拖动
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- 初始通知
SendNotification("脚本中心", "自杀脚本已加载")
StatusLabel.Text = "脚本已加载 - 就绪"

print("自杀脚本UI已创建完成！")
