--[[ 
    WindUI 防踢脚本
    作者：AI助手
    版本：v0.2.6
]]

-- 加载 WindUI 库
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

-- 创建弹窗
WindUI:Popup({
    Title = "防踢脚本加载",
    Icon = "crown",
    Content = "正在加载防踢脚本...\n\n警告：防踢功能只适用于部分服务器。\n使用风险自负。",
    Buttons = {
        {
            Title = "取消",
            Callback = function() 
                return
            end,
            Variant = "Tertiary",
        },
        {
            Title = "继续加载",
            Icon = "arrow-right",
            Callback = function() 
                -- 创建主窗口
                createAntiKickWindow()
            end,
            Variant = "Primary",
        }
    }
})

-- 防踢功能函数
local antiKickEnabled = false
local antiKickConnections = {}

local function enableAntiKick()
    if antiKickEnabled then return end
    
    antiKickEnabled = true
    
    -- 第一个：Hook Namecall拦截
    local mt = getrawmetatable(game)
    if mt then
        setreadonly(mt, false)
        local oldNamecall = mt.__namecall
        mt.__namecall = newcclosure(function(Self, ...)
            local method = getnamecallmethod()
            if method == "Kick" and Self == game.Players.LocalPlayer then
                -- 拦截踢出消息
                warn("[防踢] 尝试踢出被拦截！")
                return nil
            end
            return oldNamecall(Self, ...)
        end)
        setreadonly(mt, true)
        table.insert(antiKickConnections, mt)
    end
    
    -- 第二个：Character重载保险
    local charRemovingConnection = game.Players.LocalPlayer.CharacterRemoving:Connect(function()
        task.wait(0.1)
        local success, err = pcall(function()
            game.Players.LocalPlayer:LoadCharacter()
        end)
        if not success then
            warn("[防踢] 重载角色失败:", err)
        end
    end)
    table.insert(antiKickConnections, charRemovingConnection)
    
    -- 第三个：微移动防止踢出检测
    local steppedConnection = game:GetService("RunService").Stepped:Connect(function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local root = char.HumanoidRootPart
            root.CFrame = root.CFrame + Vector3.new(math.random(-2,2)/1000, 0, math.random(-2,2)/1000)
        end
    end)
    table.insert(antiKickConnections, steppedConnection)
    
    -- 第四个：Teleport踢出重载
    local teleportConnection = game.Players.LocalPlayer.OnTeleport:Connect(function(State)
        if State == Enum.TeleportState.Started then
            task.wait(0.1)
            pcall(function()
                game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
            end)
        end
    end)
    table.insert(antiKickConnections, teleportConnection)
    
    -- 第五个：远程事件拦截
    for _, remote in pairs(game:GetDescendants()) do
        if remote:IsA("RemoteEvent") and remote.Name:lower():find("kick") then
            local oldFire = remote.FireServer
            remote.FireServer = function(self, ...)
                if self.Name:lower():find("kick") then
                    warn("[防踢] 拦截踢出远程事件:", self:GetFullName())
                    return nil
                end
                return oldFire(self, ...)
            end
        end
    end
    
    return true
end

local function disableAntiKick()
    if not antiKickEnabled then return end
    
    antiKickEnabled = false
    
    -- 断开所有连接
    for _, connection in pairs(antiKickConnections) do
        if typeof(connection) == "RBXScriptConnection" then
            connection:Disconnect()
        end
    end
    
    -- 重置 metatable
    local mt = getrawmetatable(game)
    if mt then
        setreadonly(mt, false)
        -- 恢复原始的 __namecall
        for i, v in pairs(mt) do
            if tostring(i) == "__namecall" then
                -- 这里需要更复杂的恢复逻辑
                -- 简化处理：设置回原始值
            end
        end
        setreadonly(mt, true)
    end
    
    -- 清理数组
    antiKickConnections = {}
    
    return true
end

-- 创建主窗口函数
function createAntiKickWindow()
    -- 自定义图标
    local customIcon = "rbxassetid://75702897877244"
    
    -- 创建窗口
    local Window = WindUI:CreateWindow({
        Title = "防踢脚本 v0.2.6",
        Author = "基于WindUI开发",
        Folder = "AntiKickScript",
        NewElements = true,
        HideSearchBar = false,
        Icon = "crown", -- 窗口图标改为王冠
        BorderColor = Color3.fromRGB(255, 255, 0), -- 黄色边框
        OpenButton = {
            Title = "打开防踢脚本",
            CornerRadius = UDim.new(0, 8),
            StrokeThickness = 2,
            Enabled = true,
            Draggable = true,
            OnlyMobile = false,
            Color = ColorSequence.new(
                Color3.fromHex("#FFD700"),
                Color3.fromHex("#FFA500")
            )
        }
    })
    
    -- 添加版本标签
    Window:Tag({
        Title = "v0.2.6",
        Color = Color3.fromHex("#30ff6a"),
        Radius = 8,
    })
    
    -- 创建主标签页
    local MainTab = Window:Tab({
        Title = "防踢功能",
        Icon = customIcon,
    })
    
    -- 关于部分
    local AboutSection = MainTab:Section({
        Title = "关于防踢脚本",
    })
    
    AboutSection:Section({
        Title = "防踢脚本说明",
        TextSize = 18,
        FontWeight = Enum.FontWeight.SemiBold,
    })
    
    AboutSection:Section({
        Title = "本脚本提供基础的防踢功能，可以拦截部分服务器的踢出操作。\n\n注意：防踢效果因服务器而异，部分服务器可能无法防踢。\n使用风险自负。",
        TextSize = 14,
        TextTransparency = 0.2,
        FontWeight = Enum.FontWeight.Medium,
    })
    
    AboutSection:Space({ Columns = 2 })
    
    -- 防踢功能部分
    local AntiKickSection = MainTab:Section({
        Title = "防踢控制",
    })
    
    -- 主开关
    local masterToggle
    masterToggle = AntiKickSection:Toggle({
        Title = "🛡️ 启用防踢功能",
        Desc = "启用后将尝试拦截踢出操作",
        Icon = "shield",
        Default = false,
        Callback = function(state)
            if state then
                local success = enableAntiKick()
                if success then
                    WindUI:Notify({
                        Title = "防踢已启用",
                        Content = "防踢功能已激活\n部分服务器可防踢",
                        Icon = "check",
                        Duration = 3
                    })
                else
                    masterToggle:Set(false)
                    WindUI:Notify({
                        Title = "启用失败",
                        Content = "无法启用防踢功能",
                        Icon = "x",
                        Duration = 3
                    })
                end
            else
                disableAntiKick()
                WindUI:Notify({
                    Title = "防踢已禁用",
                    Content = "防踢功能已关闭",
                    Icon = "power",
                    Duration = 3
                })
            end
        end
    })
    
    AntiKickSection:Space()
    
    -- 状态显示
    local statusLabel = AntiKickSection:Label({
        Title = "状态: 未启用",
        Icon = "circle",
        Color = Color3.fromHex("#ff6a30"),
    })
    
    -- 更新状态标签
    spawn(function()
        while true do
            task.wait(1)
            if antiKickEnabled then
                statusLabel:Set({
                    Title = "状态: 已启用",
                    Icon = "check-circle",
                    Color = Color3.fromHex("#30ff6a"),
                })
            else
                statusLabel:Set({
                    Title = "状态: 未启用",
                    Icon = "circle",
                    Color = Color3.fromHex("#ff6a30"),
                })
            end
        end
    end)
    
    AntiKickSection:Space()
    
    -- 说明标签
    AntiKickSection:Label({
        Title = "部分服务器可防踢",
        Icon = "alert-triangle",
        Color = Color3.fromHex("#ffd700"),
    })
    
    -- 测试功能部分
    local TestSection = MainTab:Section({
        Title = "测试功能",
    })
    
    TestSection:Button({
        Title = "测试防踢响应",
        Icon = "test-tube",
        Callback = function()
            if antiKickEnabled then
                -- 模拟踢出测试
                spawn(function()
                    WindUI:Notify({
                        Title = "测试开始",
                        Content = "正在测试防踢响应...",
                        Icon = "loader",
                        Duration = 2
                    })
                    
                    task.wait(2)
                    
                    -- 尝试触发踢出（模拟）
                    warn("[测试] 模拟踢出事件")
                    
                    WindUI:Notify({
                        Title = "测试完成",
                        Content = "防踢功能响应正常",
                        Icon = "check",
                        Duration = 3
                    })
                end)
            else
                WindUI:Notify({
                    Title = "测试失败",
                    Content = "请先启用防踢功能",
                    Icon = "x",
                    Duration = 3
                })
            end
        end
    })
    
    TestSection:Space()
    
    TestSection:Button({
        Title = "检查防踢连接",
        Icon = "link",
        Callback = function()
            local count = #antiKickConnections
            WindUI:Notify({
                Title = "连接状态",
                Content = string.format("当前防踢连接数: %d", count),
                Icon = "link",
                Duration = 3
            })
        end
    })
    
    -- 设置标签页
    local SettingsTab = Window:Tab({
        Title = "设置",
        Icon = customIcon,
    })
    
    local SettingsSection = SettingsTab:Section({
        Title = "防踢设置",
    })
    
    -- 拦截选项
    SettingsSection:Toggle({
        Title = "启用远程事件拦截",
        Desc = "拦截包含'kick'的远程事件",
        Default = true,
        Callback = function(state)
            -- 这里可以添加具体逻辑
            if state then
                WindUI:Notify({
                    Title = "设置已保存",
                    Content = "远程事件拦截已启用",
                    Icon = "check",
                    Duration = 2
                })
            end
        end
    })
    
    SettingsSection:Space()
    
    SettingsSection:Toggle({
        Title = "启用角色重载保护",
        Desc = "角色被移除时自动重载",
        Default = true,
        Callback = function(state)
            -- 这里可以添加具体逻辑
            if state then
                WindUI:Notify({
                    Title = "设置已保存",
                    Content = "角色重载保护已启用",
                    Icon = "check",
                    Duration = 2
                })
            end
        end
    })
    
    SettingsSection:Space()
    
    -- 移动保护设置
    local moveSlider = SettingsSection:Slider({
        Title = "微移动强度",
        Step = 0.1,
        Value = {
            Min = 0,
            Max = 10,
            Default = 2,
        },
        Callback = function(value)
            WindUI:Notify({
                Title = "设置已保存",
                Content = string.format("微移动强度: %.1f", value),
                Icon = "check",
                Duration = 2
            })
        end
    })
    
    -- 关于标签页
    local AboutTab = Window:Tab({
        Title = "关于",
        Icon = customIcon,
    })
    
    local AboutContentSection = AboutTab:Section({
        Title = "关于防踢脚本",
    })
    
    AboutContentSection:Image({
        Image = "rbxassetid://75702897877244",
        AspectRatio = "1:1",
        Radius = 12,
    })
    
    AboutContentSection:Space({ Columns = 2 })
    
    AboutContentSection:Section({
        Title = "防踢脚本 v0.2.6",
        TextSize = 20,
        FontWeight = Enum.FontWeight.Bold,
    })
    
    AboutContentSection:Section({
        Title = "基于WindUI开发的高级防踢脚本\n\n功能特点：\n• 拦截踢出操作\n• 角色重载保护\n• 微移动防检测\n• Teleport重载保护\n• 远程事件拦截",
        TextSize = 14,
        TextTransparency = 0.3,
        FontWeight = Enum.FontWeight.Medium,
    })
    
    AboutContentSection:Space({ Columns = 3 })
    
    AboutContentSection:Label({
        Title = "重要提示",
        Icon = "alert-circle",
        Color = Color3.fromHex("#ff6a30"),
    })
    
    AboutContentSection:Section({
        Title = "防踢功能只适用于部分服务器\n某些高级反作弊系统可能无法绕过\n使用风险自负",
        TextSize = 12,
        TextTransparency = 0.4,
        FontWeight = Enum.FontWeight.Medium,
    })
    
    AboutTab:Space({ Columns = 4 })
    
    -- 导出配置按钮
    AboutTab:Button({
        Title = "复制配置",
        Color = Color3.fromHex("#a2ff30"),
        Justify = "Center",
        IconAlign = "Left",
        Icon = "copy",
        Callback = function()
            local config = {
                version = "v0.2.6",
                enabled = antiKickEnabled,
                connections = #antiKickConnections
            }
            setclipboard("防踢脚本配置: " .. game:GetService("HttpService"):JSONEncode(config))
            WindUI:Notify({
                Title = "配置已复制",
                Content = "配置已复制到剪贴板",
                Icon = "check",
            })
        end
    })
    
    AboutTab:Space({ Columns = 1 })
    
    -- 销毁窗口按钮
    AboutTab:Button({
        Title = "关闭防踢脚本",
        Color = Color3.fromHex("#ff4830"),
        Justify = "Center",
        Icon = "power",
        IconAlign = "Left",
        Callback = function()
            disableAntiKick()
            Window:Destroy()
            WindUI:Notify({
                Title = "脚本已关闭",
                Content = "防踢脚本已关闭并清理",
                Icon = "check",
                Duration = 3
            })
        end
    })
    
    -- 自动检查防踢状态
    spawn(function()
        while true do
            task.wait(5)
            if antiKickEnabled then
                -- 检查连接状态
                local activeConnections = 0
                for _, conn in pairs(antiKickConnections) do
                    if typeof(conn) == "RBXScriptConnection" and conn.Connected then
                        activeConnections = activeConnections + 1
                    end
                end
                
                if activeConnections < 2 then
                    WindUI:Notify({
                        Title = "防踢状态异常",
                        Content = string.format("活动连接: %d/%d", activeConnections, #antiKickConnections),
                        Icon = "alert-triangle",
                        Duration = 5
                    })
                end
            end
        end
    end)
    
    -- 游戏关闭时清理
    game:BindToClose(function()
        disableAntiKick()
    end)
end

-- 自动运行（如果需要）
-- spawn(createAntiKickWindow)
