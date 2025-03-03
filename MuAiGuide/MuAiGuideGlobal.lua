﻿local M = {}
--- 是否开启测试模式
M.DebugMode = false
--- 测试模式玩家职能
M.DebugPos = ""
M.DevelopMode = false
local TankJobs = { 19, 21, 32, 37 }
local HealerJobs = { 24, 28, 33, 40 }
local MeleeJob = { 20, 22, 30, 34, 39, 41 }
local RangeJob = { 31, 23, 38 }
local MagicJob = { 25, 27, 35, 42 }
local JobIds = {
    19, 21, 32, 37,
    24, 33, 40, 28,
    20, 22, 30, 34, 39, 41,
    31, 23, 38,
    25, 27, 35, 42
}

local JobName = {
    "骑士", "战士", "黑骑", "绝枪",
    "白魔", "占星", "贤者", "学者",
    "武僧", "龙骑", "忍者", "武士", "钐镰", "蝰蛇",
    "机工", "诗人", "舞者",
    "黑魔", "召唤", "赤魔", "绘灵"
}

M.JobPosName = { "MT", "ST", "H1", "H2", "D1", "D2", "D3", "D4" }
--- UI定义
M.UI = {}
M.FruConfigUI = {}

M.IsTank = function(job)
    return table.contains(TankJobs, job)
end

M.IsHealer = function(job)
    return table.contains(HealerJobs, job)
end

M.IsMelee = function(job)
    return table.contains(MeleeJob, job)
end

M.IsRange = function(job)
    return table.contains(RangeJob, job)
end

M.IsMagic = function(job)
    return table.contains(MagicJob, job)
end

M.IsDps = function(job)
    return table.contains(MeleeJob, job)
        or table.contains(RangeJob, job)
        or table.contains(MagicJob, job)
end

M.IsPlayer = function(entity)
    if not entity
        or not entity.job
        or entity.type ~= 1
        or not table.contains(JobIds, entity.job)
    then
        return false
    end

    return true
end

--- 输出消息到聊天栏
--- @param msg string
M.Info = function(msg)
    if not M.Config.LogToEchoMsg then
        return
    end
    local info = "/e [信息]" .. msg
    SendTextCommand(info)
end

--- 输出信息到控制台
--- @param msg string
M.Debug = function(msg)
    local info = "[MuAiGuide]" .. msg
    d(info)
end

--- 获取职业名称
--- @param job number 职业ID
M.GetJobNameById = function(job)
    for i = 1, #JobIds, 1 do
        if JobIds[i] == job then
            return JobName[i]
        end
    end
end

--- 读取小队列表
M.GetPartyPlayers = function()
    local curPt = TensorCore.getEntityGroupList("Party")
    local members = {}
    local checker = {}
    -- 回放模式或者其他情况
    if #curPt == 1 then
        table.insert(members, curPt[1])
        table.insert(checker, curPt[1].id)
        curPt = TensorCore.entityList("Party")
    end
    for _, ent in pairs(curPt) do
        if M.IsPlayer(ent)
            and ent.type == 1
            and not table.contains(checker, ent.id)
            and ent.name ~= nil and ent.name ~= ""
        then
            table.insert(members, ent)
        end
    end
    return members
end

--- 读取设置信息
M.LoadConfig = function()
    local path = GetLuaModsPath()
    local savePath = path .. "\\MuAiGuide"
    local saveFile = savePath .. "\\MuAiGuideConfig.lua"
    if (not FolderExists(savePath)) then
        FolderCreate(savePath)
    end
    local config = FileLoad(saveFile)
    local defaultCfg = M.CreateDefaultCfg();
    if config ~= nil then
        local function syncNestedFields(saveData, defaultData)
            for key, value in pairs(defaultData) do
                if type(value) == "table" then
                    if type(saveData[key]) == "table" then
                        syncNestedFields(saveData[key], value)
                    else
                        saveData[key] = value
                    end
                else
                    if saveData[key] == nil then
                        saveData[key] = value
                    end
                end
            end
        end
        syncNestedFields(config, defaultCfg)
        return config
    end
    return defaultCfg;
end

--- 创建默认配置
M.CreateDefaultCfg = function()
    return {
        --- 指路工具颜色
        GuideColor = { r = 0, g = 1, b = 1, a = 0.5 },
        GuidePairColor = { r = 0, g = 0, b = 1, a = 0.5 },
        --- 是否启用了Anyone
        AnyOneReactionOn = true,
        --- 是否输出提示信息到消息栏
        LogToEchoMsg = true,
        --- 绝伊甸设置
        FruCfg = M.CreateFruDefaultCfg(),
    }
end

M.LoadDefaultMain = function()
    M.Config.GuideColor = { r = 0, g = 1, b = 1, a = 0.5 }
    M.Config.GuidePairColor = { r = 0, g = 0, b = 1, a = 0.5 }
    M.Config.AnyOneReactionOn = true
    M.Config.LogToEchoMsg = true
end

M.LoadDefaultFre = function()
    M.Config.FruCfg = M.CreateFruDefaultCfg()
end

M.CreateFruDefaultCfg = function()
    return {
        ---全局指路方式 1：国服 2：日基
        GuideType = 1,
        --- 标点
        PosInfo = { "C", "3", "B", "2", "A", "1", "D", "4" },
        --- 基础8方位置
        JobPos = { "H2", "D2", "ST", "D4", "MT", "D3", "H1", "D1" },
        --- 8方预站位上边分组
        GlobalUpGroup = { "MT", "ST", "H1", "H2" },
        --- 8方预站位下边分组
        GlobalDownGroup = { "D1", "D2", "D3", "D4" },
        ----------------------------- P1 -----------------------------
        --- 雾龙8方站位 C逆
        FruUtopainSkyPosInfo = { "H2", "D2", "D4", "ST", "MT", "D3", "H1", "D1" },
        --- 抓人分组上
        CatchTwoUp = { "MT", "H1", "D1", "D3" },
        --- 抓人分组下
        CatchTwoDown = { "ST", "H2", "D2", "D4" },
        --- 抓人补位
        CatchTwoDownFall = { "D1", "D2" },
        --- 雷火线优先级
        FruLightFirePriority = { "H1", "H2", "MT", "ST", "D1", "D2", "D3", "D4" },
        --- 雷火线处理方向：1：上下，2：左右
        FruLightFireDir = 1,
        --- 雷火线处理方式：1：上下互换，2：闲人固定
        FruLightFireType = 1,
        --- 闲人顺序，从上到下从左到右
        FruLightFireRestPos = { "1", "2", "3", "4" },
        --- 踩塔方式 1 小学塔，2固定+补位，3,日基塔固定3人补位3人
        TakeTowerType = 1,

        --- 填充塔优先级
        FallTowerOrder = { "H1", "H2", "D1", "D2", "D3", "D4" },

        --- 固定塔
        FixTowerUp = { "H1", "D1" },
        FixTowerMid = { "D4", "D3" },
        FixTowerDown = { "H2", "D2" },
        --- 日基踩塔
        JapanTowerFix = { "H1", "H2", "D4" },
        JapanTowerFall = { "D1", "D2", "D3" },

        ----------------------------- P2 -----------------------------
        --- DD 换位方式 1： 同组互换，2：全员顺时针
        DDChangeType = 1,
        --- 滑冰提示TTS
        SkatingHit = 2,
        --- 镜子
        MirrorPosMelee1 = { "D1", "MT", "ST", "D2" },
        MirrorPosMelee2 = { "MT", "D1", "D2", "ST" },
        MirrorPosRange = { "H1", "D3", "D4", "H2" },
        --- 蓝镜子居中情况下 1. 远左近右， 2.近左远右
        MirrorSameDistanceType = 1,
        --- 光爆处理方式 1、田园郡 2、灰9
        FruLightRampantType = 1,

        ----------------------------- P3 -----------------------------
        --- 分组方案 1: 预站位， 2: 分组
        ApocalypseGroupType = 1,
        --- P3地火解法 1：车头法 2：人群法
        ApocalypseType = 1,
        --- 时间结晶优先级
        CrystallizeTimePriority = { "MT", "ST", "H1", "H2", "D1", "D2", "D3", "D4" },
        --- 时间结晶处理方式：1:固定吃，2:标点，3:自动摇号
        CrystallizeTimeType = 1,
        --- 时间结晶击退处理方式：1 Y字， 2：角落
        CrystallizeTimeKnockBack = 1,
        -- 固定吃, 顺序
        CrystallizeTimeFix = {
            [2460] = "D", -- 暗
            [2454] = "B", -- 摊
            [2462] = "3", -- 冰
            [2461] = "4", -- 水
        },

        CrystallizeMark = {
            ["D"] = 1,
            ["B"] = 2,
            ["3"] = 3,
            ["4"] = 4
        },

        DarkLightWings = {
            Down = { "D1", "D2" },
            Left = { "H1", "H2" },
            Right = { "D3", "D4" },
        },

        DarkLightWings2 = {
            Down = { "H1", "H2" },
            Left = { "D3", "D4" },
            Right = { "D1", "D2" },
        },

        --- 踩塔类型： 1.固定踩塔 ，2.顺序踩塔
        DarkLightWingsTakeTowerType = 1,

        drawAknMorn = true,
        drawShit = true,
        drawWinLight = true,
        drawWinPolarizing = true,

    }
end


M.SaveConfig = function()
    if not table.deepcompare(M.Config, M.PreviousSave) then
        local path = GetLuaModsPath()
        local savePath = path .. "\\MuAiGuide"
        local saveFile = savePath .. "\\MuAiGuideConfig.lua"
        if (not FolderExists(savePath)) then
            FolderCreate(savePath)
        end
        FileSave(saveFile, M.Config)
        M.Debug("已更新存档")
        M.PreviousSave = table.deepcopy(M.Config)
    end
end

M.Config = M.LoadConfig()
M.PreviousSave = M.LoadConfig()

--- 读取小队信息（初始化模块）
M.LoadParty = function()
    M.Party = {}
    local members = M.GetPartyPlayers()
    if members == nil or table.size(members) < 8 then
        MuAiGuide.Info("当前没有组队。")
        return
    end
    local memberHasSet = {}
    for i = 1, 8, 1 do
        if M.IsTank(members[i].job) then
            if M.Party.MT == nil then
                M.Party.MT = members[i]
                table.insert(memberHasSet, members[i])
            else
                M.Party.ST = members[i]
                table.insert(memberHasSet, members[i])
            end
        elseif M.IsHealer(members[i].job) then
            if M.Party.H1 == nil then
                M.Party.H1 = members[i]
                table.insert(memberHasSet, members[i])
            else
                M.Party.H2 = members[i]
                table.insert(memberHasSet, members[i])
            end
        elseif M.IsMelee(members[i].job) then
            if M.Party.D1 == nil then
                M.Party.D1 = members[i]
                table.insert(memberHasSet, members[i])
            else
                M.Party.D2 = members[i]
                table.insert(memberHasSet, members[i])
            end
        elseif M.IsRange(members[i].job) then
            if M.Party.D3 == nil then
                M.Party.D3 = members[i]
                table.insert(memberHasSet, members[i])
            end
        elseif M.IsMagic(members[i].job) then
            if M.Party.D4 == nil then
                M.Party.D4 = members[i]
                table.insert(memberHasSet, members[i])
            end
        end
    end

    if #memberHasSet < 8 then
        for i = 1, #members, 1 do
            if not table.contains(memberHasSet, members[i]) then
                if M.Party.MT == nil then
                    M.Party.MT = members[i]
                    table.insert(memberHasSet, members[i])
                elseif M.Party.ST == nil then
                    M.Party.ST = members[i]
                    table.insert(memberHasSet, members[i])
                elseif M.Party.H1 == nil then
                    M.Party.H1 = members[i]
                    table.insert(memberHasSet, members[i])
                elseif M.Party.H2 == nil then
                    M.Party.H2 = members[i]
                    table.insert(memberHasSet, members[i])
                elseif M.Party.D1 == nil then
                    M.Party.D1 = members[i]
                    table.insert(memberHasSet, members[i])
                elseif M.Party.D2 == nil then
                    M.Party.D2 = members[i]
                    table.insert(memberHasSet, members[i])
                elseif M.Party.D3 == nil then
                    M.Party.D3 = members[i]
                    table.insert(memberHasSet, members[i])
                elseif M.Party.D4 == nil then
                    M.Party.D4 = members[i]
                    table.insert(memberHasSet, members[i])
                end
            end
        end
    end

    M.GetSelfPos()
end

--- 计算自己当前的职能
M.GetSelfPos = function()
    -- 设置自己的职能
    if not M.Party then
        return
    end
    for jobPos, ent in pairs(M.Party) do
        if ent.id == M.GetPlayer().id then
            M.SelfPos = jobPos
            break
        end
    end
end

--- 获取当前玩家表
--- @return table | nil player
M.GetPlayer = function()
    if M.Party == nil then
        return nil
    end
    if M.DebugMode then
        local testPlayer = M.Party[M.DebugPos]
        if testPlayer == nil then
            return TensorCore.mGetPlayer()
        end
        return TensorCore.mGetEntity(testPlayer.id)
    end
    return TensorCore.mGetPlayer()
end

--- 通过ID来获取其他玩家
--- @return table | nil player
M.GetOtherPlayer = function(id)
    for _, member in pairs(M.Party) do
        if member.id == id then
            return member
        end
    end
    return nil
end

--- 计算索引位置
--- @param orderTable table 基于哪个优先级序列的表
--- @param value any 元素成员
--- @return number index 索引
M.IndexOf = function(orderTable, value)
    for i = 1, #orderTable, 1 do
        if value == orderTable[i] then
            return i
        end
    end
    return 0
end

--- 字符串分割
--- @param str string 待分割的字符串
--- @return table list 分割后的列表
M.StringSplit = function(str, mark)
    local t = {}
    local pattern = "([^" .. mark .. "]+)"
    for match in string.gmatch(str, pattern) do
        table.insert(t, match)
    end
    return t
end

--- 列表进行拼接
--- @param str string 待分割的字符串
--- @return table result 拼合后的字符串
M.StringJoin = function(tbl, mark)
    local result = ""
    for i, v in ipairs(tbl) do
        if i > 1 then
            result = result .. mark
        end
        result = result .. v
    end
    return result
end

--- 将表B合并到表A中
M.Append = function(tblA, tblB)
    local tbl = {}
    for _, v in ipairs(tblA) do
        table.insert(tbl, v)
    end
    for _, v in ipairs(tblB) do
        table.insert(tbl, v)
    end
    return tbl
end

--- 判断当前物体是否是自己
--- @param entity table 查找到的entity
--- @return boolean result 是否是自己
M.IsMe = function(entity)
    if not entity then
        return false
    end
    return M.GetPlayer().id == entity.id
end

--- 判断当前物体是否是自己
--- @param curJosPos string 当前职能
--- @return boolean result 是否是自己
M.IsMeByPos = function(curJosPos)
    if not table.contains(M.JobPosName, curJosPos) or not M.Party then
        return false
    end
    local curPlayer = M.Party[curJosPos]
    if not curPlayer then
        return false
    end
    return M.GetPlayer().id == curPlayer.id
end

--- 计算目标点在中心点的相对方位 6点钟（C）逆时针 1~8
--- @param center table 中心点的坐标 {x=number, z=number}
--- @param target table 物品点的坐标 {x=number, z=number}
--- @return number 方位 ID（1~8）
M.GetDirectionIndex = function(center, target)
    local heading = TensorCore.getHeadingToTarget(center, target);
    local index = 0
    -- 请求弧度最接近的值
    for i = 1, 8 do
        local curRad = (i - 1) / 4 * math.pi
        if M.IsSame(heading, curRad) then
            index = i
            break
        end
    end
    return index
end

--- 根据给定的站位表和heading输出8方位置
--- @param tblStand table 站位表（C逆）
--- @param heading number 方向
--- @return string 方位名称
M.GetGamePointByHeading = function(tblStand, heading)
    for i = 1, 8 do
        local infoDir = (i - 1) * math.pi / 4
        if M.IsSame(infoDir, heading) then
            return tblStand[i]
        end
    end
    return nil
end

--- 从 startPos点出发，沿着 startPos => endPos 方向，获取距离为 distance 的点坐标
--- @param startPos table 起点坐标
--- @param endPos table 终点坐标
--- @param distance number 距离，正值为朝向终点方向，负值为反向
--- @return table targetPos 返回目标点的坐标，包含 x 和 z 分量
M.GetPointAtDistance = function(startPos, endPos, distance)
    local heading = TensorCore.getHeadingToTarget(startPos, endPos)
    return TensorCore.getPosInDirection(startPos, heading, distance)
end

--- 计算2个弧度之间的夹角（0~π）
M.GetAngleRadian = function(r1, r2)
    local diff = math.abs(r2 - r1)
    if diff > math.pi then
        diff = 2 * math.pi - diff
    end
    return diff
end

--- 判断2个数是否相等
--- @return boolean is same
M.IsSame = function(n1, n2)
    if n1 == nil or n2 == nil then
        return n1 == nil and n2 == nil
    end
    if n1 == n2 then
        return true
    end
    local diff = math.abs(n1 - n2)
    if diff < 0.05 then
        return true
    end
    return false
end

--- 将给定弧度调整到0~2π
M.SetHeading2Pi = function(heading)
    if M.IsSame(heading, 0) or M.IsSame(heading, 2 * math.pi) then
        return 0
    end
    if heading > math.pi * 2 then
        local result = heading - math.pi * 2
        if M.IsSame(endH, 0) then
            return 0
        end
        return result
    end
    if heading < 0 then
        return heading + math.pi * 2
    end
    return heading
end

--- 判断点A到B的顺逆
--- @return boolean true 顺时针，false 逆时针
M.GetClock = function(posA, posB)
    local OA = { x = posA.x - 100, z = posA.z - 100 }
    local OB = { x = posB.x - 100, z = posB.z - 100 }
    local crossProduct = OA.x * OB.z - OA.z * OB.x
    -- 非标准坐标系，叉乘结果要反着来
    if crossProduct > 0 then
        return true
    elseif crossProduct < 0 then
        return false
    end
end

--- 计算基础搭档
M.GetBasePartner = function()
    local partner
    if M.SelfPos == "MT" then
        partner = "D3"
    elseif M.SelfPos == "ST" then
        partner = "D4"
    elseif M.SelfPos == "H1" then
        partner = "D1"
    elseif M.SelfPos == "H2" then
        partner = "D2"
    elseif M.SelfPos == "D1" then
        partner = "H1"
    elseif M.SelfPos == "D2" then
        partner = "H2"
    elseif M.SelfPos == "D3" then
        partner = "MT"
    elseif M.SelfPos == "D4" then
        partner = "ST"
    end
    return partner
end

--- 计算同为远程/近战搭档
M.GetRMPartner = function()
    local partner
    if M.SelfPos == "MT" then
        partner = "D1"
    elseif M.SelfPos == "ST" then
        partner = "D2"
    elseif M.SelfPos == "H1" then
        partner = "D3"
    elseif M.SelfPos == "H2" then
        partner = "D4"
    elseif M.SelfPos == "D1" then
        partner = "MT"
    elseif M.SelfPos == "D2" then
        partner = "ST"
    elseif M.SelfPos == "D3" then
        partner = "H1"
    elseif M.SelfPos == "D4" then
        partner = "H2"
    end
    return partner
end

------------------------------- 全局绘制 -------------------------------
M.NotDelayGuides = {}

--- 取消已注册的所有指路
M.CancelDir = function()
    if table.size(M.NotDelayGuides) > 0 then
        for i, uuid in pairs(M.NotDelayGuides) do
            Argus.deleteTimedShape(uuid)
        end
        M.NotDelayGuides = {}
    end
end

--- 绘制一个指路工具
--- @param x number 当前x坐标
--- @param z number 当前z坐标
--- @param time number 指路时间（毫秒）
--- @param size? number 圈大小（默认0.5）
--- @param delay? number 延迟执行（毫秒）
M.DirectTo = function(x, z, time, size, delay)
    local color = M.Config.GuideColor
    size = size or 0.5
    delay = delay or 0
    if delay < 1 then
        M.CancelDir()
    end
    local newDraw = Argus2.ShapeDrawer:new(
        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),
        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),
        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),
        (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1)),
        2
    )
    local guide1 = newDraw:addTimedCircle(time, x, M.GetPlayer().pos.y, z, size, delay, true)
    local guide2 = Argus2.addTimedRectFilled(
        time,
        x,
        M.GetPlayer().pos.y,
        z,
        0.3,
        0.05,
        math.pi,
        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),
        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),
        nil,
        delay,
        nil,
        M.GetPlayer().id,
        false,
        nil,
        0.01,
        nil,
        nil,
        true
    )

    local newDraw2 = Argus2.ShapeDrawer:new(
        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),
        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),
        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),
        nil,
        1
    )

    local guide3 = newDraw2:addTimedCircle(time, x, M.GetPlayer().pos.y, z, 0.03, delay, true)
    if delay < 1 then
        table.insert(M.NotDelayGuides, guide1)
        table.insert(M.NotDelayGuides, guide2)
        table.insert(M.NotDelayGuides, guide3)
    end
end

--- 绘制一个连到其他玩家的连线（矩形）
M.LinkToPlayer = function(id, time, size, r, g, b, a)
    size = size or 0.05
    r = r or 0
    g = g or 0
    b = b or 0
    a = a or 0.55
    if r == 0 and g == 0 and b == 0 then
        b = 255
    end
    Argus2.addTimedRectFilled(
        time,
        100,
        M.GetPlayer().pos.y,
        100,
        0.3,
        size,
        math.pi,
        (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),
        (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),
        nil,
        0,
        id,
        M.GetPlayer().id,
        false,
        nil,
        0.01,
        nil,
        nil,
        true
    )
end

--- 指路到某移动物体
--- @param id number 目标的Id
--- @return table uuidList
M.DirectToEnt = function(id, time, size)
    local drawIds = {}
    size = size or 0.2
    local color = M.Config.GuidePairColor

    local newDraw = Argus2.ShapeDrawer:new(
        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),
        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),
        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),
        (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1)),
        2
    )

    local id1 = newDraw:addTimedCircleOnEnt(time, id, size, 0, true)
    local id2 = Argus2.addTimedRectFilled(
        time,
        0,
        M.GetPlayer().pos.y,
        0,
        0.3,
        0.05,
        math.pi,
        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),
        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),
        nil,
        0,
        id,
        M.GetPlayer().id,
        false,
        nil,
        0.01,
        nil,
        nil,
        true
    )
    local newDraw2 = Argus2.ShapeDrawer:new(
        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),
        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),
        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),
        nil,
        1
    )

    local id3 = newDraw2:addTimedCircleOnEnt(time, id, 0.03, 0, true)
    table.insert(drawIds, id1)
    table.insert(drawIds, id2)
    table.insert(drawIds, id3)
    return drawIds
end

M.FrameDirect = function(x, z, size)
    size = size or 0.5
    local playerPos = TensorCore.mGetEntity(M.GetPlayer().id).pos
    local color = M.Config.GuideColor
    local newDraw = Argus2.ShapeDrawer:new(
        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),
        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),
        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),
        (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1)),
        2
    )
    newDraw:addCircle(x, playerPos.y, z, size, true)
    local newDraw2 = Argus2.ShapeDrawer:new(
        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),
        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),
        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),
        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),
        2
    )
    local distance = TensorCore.getDistance2d(playerPos, { x = x, y = 0, z = z })
    local heading = TensorCore.getHeadingToTarget(playerPos, { x = x, y = 0, z = z })
    newDraw2:addRect(playerPos.x, playerPos.y, playerPos.z, distance, 0.05, heading, true)
    local newDraw3 = Argus2.ShapeDrawer:new(
        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),
        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),
        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),
        nil,
        1
    )
    newDraw3:addCircle(x, playerPos.y, z, 0.03, true)
end

--- 绘制一个圆
M.DrawCircleUI = function(x, z, time, size, r, g, b, a, delay)
    r = r or 0
    g = g or 0
    b = b or 0
    a = a or 0.35
    delay = delay or 0
    size = size or 1
    if r == 0 and g == 0 and b == 0 then
        g = 255
    end
    local newDraw = Argus2.ShapeDrawer:new(
        (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),
        (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),
        (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),
        (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1)),
        1
    )
    newDraw:addTimedCircle(time, x, M.GetPlayer().pos.y, z, size, 0, true)
end

--- 绘制一个地面圆
M.DrawCircleFloor = function(x, z, time, size, r, g, b, a, delay)
    r = r or 0
    g = g or 0
    b = b or 0
    a = a or 0.35
    size = size or 1
    delay = delay or 0
    if r == 0 and g == 0 and b == 0 then
        g = 255
    end
    local newDraw = Argus2.ShapeDrawer:new(
        (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),
        (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),
        (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),
        (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1)),
        1
    )
    newDraw:addTimedCircle(time, x, M.GetPlayer().pos.y, z, size, 0, false)
end

local mainDrawer, fruConfigDrawer = nil, nil
M.DrawMainUI = function()
    if mainDrawer == nil or M.DevelopMode then
        local path = MuAiGuideRoot .. "MainUI.lua"
        mainDrawer = FileLoad(path)
    end
    mainDrawer(M)
end

M.DrawFriConfigUI = function()
    if fruConfigDrawer == nil or M.DevelopMode then
        local path = MuAiGuideRoot .. "FruConfigUI.lua"
        fruConfigDrawer = FileLoad(path)
    end
    fruConfigDrawer(M)
end
FileLoad(MuAiGuideRoot .. "FruOneKeyConfigs.lua")

M.Debug("初始化成功!")
return M
