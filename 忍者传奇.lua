--[[ 警告：请注意！此脚本尚未经过ScriptBlox验证。使用风险自负！ ]]
-- 忍者传奇脚本中心
-- 汉化版

-- 启动通知
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "脚本中心";
    Text = "忍者脚本已加载";
    Icon = "rbxthumb://type=Asset&id=4563944926&w=150&h=150";
    Duration = 5;
})

-- 加载WindUI
local WindUI do
    local ok, result = pcall(function()
        return require("./src/Init")
    end)
    if ok then
        WindUI = result
    else
        WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
    end
end

-- 创建窗口
local Window = WindUI:CreateWindow({
    Title = "脚本中心 | 忍者传奇",
    Author = "by 脚本中心",
    Folder = "ninjalegends",
    NewElements = true,
    HideSearchBar = false,
    OpenButton = {
        Title = "打开忍者脚本",
        CornerRadius = UDim.new(1,0),
        StrokeThickness = 3,
        Enabled = true,
        Draggable = true,
        OnlyMobile = false,
        Color = ColorSequence.new(
            Color3.fromHex("#30FF6A"),
            Color3.fromHex("#e7ff2f")
        )
    }
})

-- 主功能标签
local MainTab = Window:Tab({
    Title = "主功能",
    Icon = "star",
})

-- 自动刷气功能
local AutoChiSection = MainTab:Section({
    Title = "自动刷气",
})

local isAutoChi = false
local autoChiConnection = nil

AutoChiSection:Toggle({
    Title = "自动刷气",
    Desc = "该功能处于测试中，请期待正式版",
    Default = false,
    Callback = function(state)
        isAutoChi = state
        if state then
            WindUI:Notify({
                Title = "自动刷气",
                Content = "已开启自动刷气",
                Icon = "check",
            })
            
            -- 开始自动刷气
            autoChiConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if game.Players.LocalPlayer.Character then
                    -- 模拟按下空格键收集气
                    game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("chiEvent"):FireServer("collectOrbs", "White")
                end
            end)
        else
            if autoChiConnection then
                autoChiConnection:Disconnect()
                autoChiConnection = nil
            end
            WindUI:Notify({
                Title = "自动刷气",
                Content = "已关闭自动刷气",
                Icon = "x",
            })
        end
    end
})

-- 岛屿传送功能
local IslandSection = MainTab:Section({
    Title = "岛屿传送",
})

local function teleportToHighestIsland()
    local islands = workspace:FindFirstChild("Islands")
    if not islands then
        WindUI:Notify({
            Title = "错误",
            Content = "无法传送岛屿",
            Icon = "alert-circle",
        })
        return
    end
    
    local highestIsland = nil
    local highestY = -math.huge
    
    for _, island in pairs(islands:GetChildren()) do
        if island:IsA("Model") and island.PrimaryPart then
            if island.PrimaryPart.Position.Y > highestY then
                highestY = island.PrimaryPart.Position.Y
                highestIsland = island
            end
        end
    end
    
    if highestIsland then
        local humanoidRootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.CFrame = highestIsland.PrimaryPart.CFrame + Vector3.new(0, 10, 0)
            WindUI:Notify({
                Title = "传送成功",
                Content = "已传送到最高岛屿",
                Icon = "check",
            })
        end
    else
        WindUI:Notify({
            Title = "错误",
            Content = "未找到可传送的岛屿",
            Icon = "alert-circle",
        })
    end
end

IslandSection:Button({
    Title = "传送到最高岛屿",
    Desc = "该功能处于测试中，请期待正式版",
    Color = Color3.fromHex("#30a1ff"),
    Callback = teleportToHighestIsland
})

-- 元素精通标签
local ElementsTab = Window:Tab({
    Title = "所有元素精通",
    Icon = "zap",
})

-- 元素列表
local elements = {
    {Title = "暗影充能", Name = "Shadow Charge"},
    {Title = "雷电混沌", Name = "Electral Chaos"},
    {Title = "烈焰实体", Name = "Blazing Entity"},
    {Title = "暗影之火", Name = "Shadowfire"},
    {Title = "闪电", Name = "Lightning"},
    {Title = "大师之怒", Name = "Masterful Wrath"},
    {Title = "地狱火", Name = "Inferno"},
    {Title = "永恒风暴", Name = "Eternity Storm"},
    {Title = "寒冰", Name = "Frost"}
}

-- 创建元素精通按钮
for _, element in ipairs(elements) do
    ElementsTab:Button({
        Title = "精通 " .. element.Title,
        Desc = "立即掌握" .. element.Title .. "元素",
        Color = Color3.fromHex("#ff6b30"),
        Callback = function()
            -- 元素精通事件
            game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("elementMasteryEvent"):FireServer(element.Name)
            
            WindUI:Notify({
                Title = "元素精通",
                Content = "已精通 " .. element.Title,
                Icon = "check",
            })
        end
    })
    
    ElementsTab:Space({Columns = 1})
end

-- 宝石转换标签
local GemsTab = Window:Tab({
    Title = "金币修改",
    Icon = "gem",
})

-- 快速转换
GemsTab:Section({
    Title = "快速获取金币",
})

GemsTab:Button({
    Title = "开始修改",
    Desc = "开始修改金币",
    Color = Color3.fromHex("#30ff6a"),
    Callback = function()
        local args = {
            [1] = "convertGems",
            [2] = -9999999999999999999999999999999999999999999999999999999999999999999
        }
        game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("zenMasterEvent"):FireServer(unpack(args))
        
        WindUI:Notify({
            Title = "宝石转换",
            Content = "已开始修改金币",
            Icon = "check",
        })
    end
})

-- 自定义转换
GemsTab:Section({
    Title = "自定义修改",
})

local gemAmount = 1000
local gemInput = GemsTab:Input({
    Title = "修改数量",
    Desc = "输入要修改的金币数量",
    Value = "1000",
    InputIcon = "hash",
    Placeholder = "输入数量...",
    Callback = function(input)
        local num = tonumber(input)
        if num and num > 0 then
            gemAmount = num
        end
    end
})

GemsTab:Button({
    Title = "提交修改",
    Desc = "提交自定义数量的金币修改",
    Color = Color3.fromHex("#306aff"),
    Callback = function()
        if gemAmount and gemAmount > 0 then
            game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("zenMasterEvent"):FireServer("convertGems", gemAmount)
            
            WindUI:Notify({
                Title = "金币修改",
                Content = "已修改 " .. tostring(gemAmount) .. " 宝石",
                Icon = "check",
            })
        end
    end
})

-- 设置标签
local SettingsTab = Window:Tab({
    Title = "设置",
    Icon = "settings",
})

SettingsTab:Button({
    Title = "隐藏界面",
    Desc = "隐藏脚本界面",
    Color = Color3.fromHex("#ff4830"),
    Callback = function()
        Window:Hide()
        WindUI:Notify({
            Title = "界面隐藏",
            Content = "界面已隐藏，点击屏幕右侧按钮重新打开",
            Icon = "eye-off",
        })
    end
})

SettingsTab:Space({Columns = 2})

SettingsTab:Button({
    Title = "销毁界面",
    Desc = "完全销毁脚本界面",
    Color = Color3.fromHex("#ff3030"),
    Callback = function()
        Window:Destroy()
        WindUI:Notify({
            Title = "界面销毁",
            Content = "脚本界面已销毁",
            Icon = "trash-2",
        })
    end
})

-- 关于标签
local AboutTab = Window:Tab({
    Title = "关于",
    Icon = "info",
})

AboutTab:Section({
    Title = "脚本中心忍者脚本",
    TextSize = 20,
    FontWeight = Enum.FontWeight.SemiBold,
})

AboutTab:Space()

AboutTab:Section({
    Title = [[这是一个专为忍者传奇设计的脚本，提供多种功能：
    
• 自动刷气 - 自动收集气资源
• 岛屿传送 - 快速传送到最高岛屿
• 元素精通 - 一键精通所有元素
• 金币修改 - 快速获取金币

请注意：不知道。]],
    TextSize = 14,
    TextTransparency = .3,
})

-- 脚本加载完成通知
wait(1)
WindUI:Notify({
    Title = "脚本中心",
    Content = "忍者脚本加载完成，享受游戏吧！",
    Icon = "check",
    Duration = 5,
})
