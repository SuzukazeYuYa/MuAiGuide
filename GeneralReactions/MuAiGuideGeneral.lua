local tbl = 
{
	
	{
		data = 
		{
			actions = 
			{
			},
			conditions = 
			{
			},
			enabled = false,
			name = "--------- MuAiGuide ----------",
			uuid = "0d8cee50-d961-3cb9-981b-07f4fbce8dea",
			version = 2,
		},
		inheritedIndex = 2,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "if not MuAiGuide then\n    self.used = true\n    return\nend\n\nif MuAiGuide and MuAiGuide.FruConfigUI.open then\n    MuAiGuide.FruConfigUI.open = false\nend\nif MuAiGuide and MuAiGuide.UI.open then\n    MuAiGuide.UI.open = false\nend\nMuAiGuide = nil\nd(\"[MuAiGuide] 基础数据已清空！\")\nMuAiGuideClearFlg = 1\nself.used = true",
						gVar = "ACR_TensorRequiem3_CD",
						name = "重置MuAiGuide",
						uuid = "c58be1b6-54b0-6889-a973-4de1d29faf08",
						version = 2.1,
					},
					inheritedIndex = 1,
				},
			},
			conditions = 
			{
			},
			eventType = 11,
			name = "ReSetMuAiGuide",
			timeout = 0,
			uuid = "ccba9a67-6513-7043-95d3-8c4db0c7a193",
			version = 2,
		},
		inheritedIndex = 3,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide = {}\nlocal M = MuAiGuide\n--- 是否开启测试模式\nM.DebugMode = false\n--- 测试模式玩家职能\nM.DebugPos = \"D3\"\n\nlocal TankJobs = { 19, 21, 32, 37 }\nlocal HealerJobs = { 24, 28, 33, 40 }\nlocal MeleeJob = { 20, 22, 30, 34, 39, 41 }\nlocal RangeJob = { 31, 23, 38 }\nlocal MagicJob = { 25, 27, 35, 42 }\nlocal JobIds = {\n    19, 21, 32, 37,\n    24, 33, 40, 28,\n    20, 22, 30, 34, 39, 41,\n    31, 23, 38,\n    25, 27, 35, 42\n}\n\nlocal JobName = {\n    \"骑士\", \"战士\", \"黑骑\", \"绝枪\",\n    \"白魔\", \"占星\", \"贤者\", \"学者\",\n    \"武僧\", \"龙骑\", \"忍者\", \"武士\", \"钐镰\", \"蝰蛇\",\n    \"机工\", \"诗人\", \"舞者\",\n    \"黑魔\", \"召唤\", \"赤魔\", \"绘灵\"\n}\n\nM.JobPosName = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\n--- UI定义\nM.UI = {}\nM.FruConfigUI = {}\n\nM.IsTank = function(job)\n    return table.contains(TankJobs, job)\nend\n\nM.IsHealer = function(job)\n    return table.contains(HealerJobs, job)\nend\n\nM.IsMelee = function(job)\n    return table.contains(MeleeJob, job)\nend\n\nM.IsRange = function(job)\n    return table.contains(RangeJob, job)\nend\n\nM.IsMagic = function(job)\n    return table.contains(MagicJob, job)\nend\n\nM.IsDps = function(job)\n    return table.contains(MeleeJob, job)\n        or table.contains(RangeJob, job)\n        or table.contains(MagicJob, job)\nend\n\nM.IsPlayer = function(entity)\n    if not entity\n        or not entity.job\n        or entity.type ~= 1\n        or not table.contains(JobIds, entity.job)\n    then\n        return false\n    end\n\n    return true\nend\n\n--- 输出消息到聊天栏\n--- @param msg string\nM.Info = function(msg)\n    if not M.Config.LogToEchoMsg then\n        return\n    end\n    local info = \"/e [信息]\" .. msg\n    SendTextCommand(info)\nend\n\n--- 输出信息到控制台\n--- @param msg string\nM.Debug = function(msg)\n    local info = \"[MuAiGuide]\" .. msg\n    d(info)\nend\n\n--- 获取职业名称\n--- @param job number 职业ID\nM.GetJobNameById = function(job)\n    for i = 1, #JobIds, 1 do\n        if JobIds[i] == job then\n            return JobName[i]\n        end\n    end\nend\n\n--- 读取小队列表\nM.GetPartyPlayers = function()\n    local curPt = TensorCore.getEntityGroupList(\"Party\")\n    local members = {}\n    local checker = {}\n    -- 回放模式或者其他情况\n    if #curPt == 1 then\n        table.insert(members, curPt[1])\n        table.insert(checker, curPt[1].id)\n        curPt = TensorCore.entityList(\"Party\")\n        M.Debug(\"当前小队列表一人\")\n    end\n    for _, ent in pairs(curPt) do\n        if M.IsPlayer(ent) and not table.contains(checker, ent.id) then\n            table.insert(members, ent)\n        end\n    end\n    return members\nend\n\n--- 读取设置信息\nM.LoadConfig = function()\n    local path = GetLuaModsPath()\n    local savePath = path .. \"\\\\MuAiGuide\"\n    local saveFile = savePath .. \"\\\\MuAiGuideConfig.lua\"\n    if (not FolderExists(savePath)) then\n        FolderCreate(savePath)\n    end\n    local config = FileLoad(saveFile)\n    local defaultCfg = M.CreateDefaultCfg();\n    if config ~= nil then\n        local function syncNestedFields(saveData, defaultData)\n            for key, value in pairs(defaultData) do\n                if type(value) == \"table\" then\n                    if type(saveData[key]) == \"table\" then\n                        syncNestedFields(saveData[key], value)\n                    else\n                        saveData[key] = value\n                    end\n                else\n                    if saveData[key] == nil then\n                        saveData[key] = value\n                    end\n                end\n            end\n        end\n        syncNestedFields(config, defaultCfg)\n        return config\n    end\n    return defaultCfg;\nend\n\n--- 创建默认配置\nM.CreateDefaultCfg = function()\n    return {\n        --- 指路工具颜色\n        GuideColor = { r = 0, g = 1, b = 1, a = 0.5 },\n        --- 是否启用了Anyone\n        AnyOneReactionOn = true,\n        --- 是否输出提示信息到消息栏\n        LogToEchoMsg = true,\n        --- 绝伊甸设置\n        FruCfg = M.CreateFruDefaultCfg(),\n    }\nend\n\nM.LoadDefaultMain = function()\n    M.Config.GuideColor = { r = 0, g = 1, b = 1, a = 0.5 }\n    M.Config.AnyOneReactionOn = true\n    M.Config.LogToEchoMsg = true\nend\n\nM.LoadDefaultFre = function()\n    M.Config.FruCfg = M.CreateFruDefaultCfg()\nend\n\nM.CreateFruDefaultCfg = function()\n    return {\n        PosInfo                  = { \"C\", \"3\", \"B\", \"2\", \"A\", \"1\", \"D\", \"4\" },\n        --- 基础8方位置\n        JobPos                   = { \"H2\", \"D2\", \"ST\", \"D4\", \"MT\", \"D3\", \"H1\", \"D1\" },\n        --- 雾龙8方站位 C逆\n        FruUtopainSkyPosInfo     = { \"H2\", \"D2\", \"D4\", \"ST\", \"MT\", \"D3\", \"H1\", \"D1\" },\n        --- 抓人分组上\n        CatchTwoUp               = { \"MT\", \"H1\", \"D1\", \"D3\" },\n        --- 抓人分组下\n        CatchTwoDown             = { \"ST\", \"H2\", \"D2\", \"D4\" },\n        --- 抓人补位\n        CatchTwoDownFall         = { \"D1\", \"D2\" },\n        --- 雷火线优先级\n        FruLightFirePriority     = { \"H1\", \"H2\", \"MT\", \"ST\", \"D1\", \"D2\", \"D3\", \"D4\" },\n        --- 雷火线处理方向：1：上下，2：左右\n        FruLightFireDir          = 1,\n        --- 雷火线处理方式：1：上下互换，2：闲人固定\n        FruLightFireType         = 1,\n\n        --- 踩塔方式 1 小学塔，2固定+补位\n        TakeTowerType            = 1,\n\n        --- 填充塔优先级\n        FallTowerOrder           = { \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" },\n\n        --- 固定塔\n        FixTowerUp               = { \"H1\", \"D1\" },\n        FixTowerMid              = { \"D4\", \"D3\" },\n        FixTowerDown             = { \"H2\", \"D2\" },\n        --- 镜子\n        MirrorPosMelee1          = { \"D1\", \"MT\", \"ST\", \"D2\" },\n        MirrorPosMelee2          = { \"MT\", \"D1\", \"D2\", \"ST\" },\n        MirrorPosRange           = { \"H1\", \"D3\", \"D4\", \"H2\" },\n        --- 光爆处理方式 1、田园郡 2、灰9\n        FruLightRampantType      = 1,\n\n        --- P3地火解法 1：车头法 2：人群法\n        ApocalypseType           = 1,\n\n        --- 时间结晶处理方式：1:固定吃，2:标点，3:自动摇号\n        CrystallizeTimeType      = 1,\n        --- 时间结晶击退处理方式：1 Y字， 2：角落\n        CrystallizeTimeKnockBack = 1,\n        -- 固定吃, 顺序\n        CrystallizeTimeFix       = {\n            [2460] = \"D\", -- 暗\n            [2454] = \"B\", -- 摊\n            [2462] = \"3\", -- 冰\n            [2461] = \"4\", -- 水\n        },\n\n        CrystallizeMark          = {\n            [\"D\"] = 1,\n            [\"B\"] = 2,\n            [\"3\"] = 3,\n            [\"4\"] = 4\n        },\n\n        DarkLightWings           = {\n            Down = { \"D1\", \"D2\" },\n            Left = { \"H1\", \"H2\" },\n            Right = { \"D3\", \"D4\" },\n        }\n    }\nend\n\nM.SaveConfig = function()\n    if not table.deepcompare(M.Config, M.PreviousSave) then\n        local path = GetLuaModsPath()\n        local savePath = path .. \"\\\\MuAiGuide\"\n        local saveFile = savePath .. \"\\\\MuAiGuideConfig.lua\"\n        if (not FolderExists(savePath)) then\n            FolderCreate(savePath)\n        end\n        FileSave(saveFile, M.Config)\n        M.Debug(\"已更新存档\")\n        M.PreviousSave = table.deepcopy(M.Config)\n    end\nend\n\nM.Config = M.LoadConfig()\nM.PreviousSave = M.LoadConfig()\n\n--- 读取小队信息（初始化模块）\nM.LoadParty = function()\n    M.Party = {}\n    local members = M.GetPartyPlayers()\n    local memberHasSet = {}\n    for i = 1, 8, 1 do\n        if M.IsTank(members[i].job) then\n            if M.Party.MT == nil then\n                M.Party.MT = members[i]\n                table.insert(memberHasSet, members[i])\n            else\n                M.Party.ST = members[i]\n                table.insert(memberHasSet, members[i])\n            end\n        elseif M.IsHealer(members[i].job) then\n            if M.Party.H1 == nil then\n                M.Party.H1 = members[i]\n                table.insert(memberHasSet, members[i])\n            else\n                M.Party.H2 = members[i]\n                table.insert(memberHasSet, members[i])\n            end\n        elseif M.IsMelee(members[i].job) then\n            if M.Party.D1 == nil then\n                M.Party.D1 = members[i]\n                table.insert(memberHasSet, members[i])\n            else\n                M.Party.D2 = members[i]\n                table.insert(memberHasSet, members[i])\n            end\n        elseif M.IsRange(members[i].job) then\n            if M.Party.D3 == nil then\n                M.Party.D3 = members[i]\n                table.insert(memberHasSet, members[i])\n            end\n        elseif M.IsMagic(members[i].job) then\n            if M.Party.D4 == nil then\n                M.Party.D4 = members[i]\n                table.insert(memberHasSet, members[i])\n            end\n        end\n    end\n\n    if #memberHasSet < 8 then\n        for i = 1, #members, 1 do\n            if not table.contains(memberHasSet, members[i]) then\n                if M.Party.MT == nil then\n                    M.Party.MT = members[i]\n                    table.insert(memberHasSet, members[i])\n                elseif M.Party.ST == nil then\n                    M.Party.ST = members[i]\n                    table.insert(memberHasSet, members[i])\n                elseif M.Party.H1 == nil then\n                    M.Party.H1 = members[i]\n                    table.insert(memberHasSet, members[i])\n                elseif M.Party.H2 == nil then\n                    M.Party.H2 = members[i]\n                    table.insert(memberHasSet, members[i])\n                elseif M.Party.D1 == nil then\n                    M.Party.D1 = members[i]\n                    table.insert(memberHasSet, members[i])\n                elseif M.Party.D2 == nil then\n                    M.Party.D2 = members[i]\n                    table.insert(memberHasSet, members[i])\n                elseif M.Party.D3 == nil then\n                    M.Party.D3 = members[i]\n                    table.insert(memberHasSet, members[i])\n                elseif M.Party.D4 == nil then\n                    M.Party.D4 = members[i]\n                    table.insert(memberHasSet, members[i])\n                end\n            end\n        end\n    end\n\n    M.GetSelfPos()\nend\n\n--- 计算自己当前的职能\nM.GetSelfPos = function()\n    -- 设置自己的职能\n    if not M.Party then\n        return\n    end\n    for jobPos, ent in pairs(M.Party) do\n        if ent.id == M.GetPlayer().id then\n            M.SelfPos = jobPos\n            break\n        end\n    end\nend\n\n--- 获取当前玩家表\n--- @return table | nil player\nM.GetPlayer = function()\n    if M.Party == nil then\n        return nil\n    end\n    if M.DebugMode then\n        local testPlayer = M.Party[M.DebugPos]\n        if testPlayer == nil then\n            return TensorCore.mGetPlayer()\n        end\n        return TensorCore.mGetEntity(testPlayer.id)\n    end\n    return TensorCore.mGetPlayer()\nend\n\n--- 通过ID来获取其他玩家\n--- @return table | nil player\nM.GetOtherPlayer = function(id)\n    for _, member in pairs(M.Party) do\n        if member.id == id then\n            return member\n        end\n    end\n    return nil\nend\n\n--- 计算索引位置\n--- @param orderTable table 基于哪个优先级序列的表\n--- @param value any 元素成员\n--- @return number index 索引\nM.IndexOf = function(orderTable, value)\n    for i = 1, #orderTable, 1 do\n        if value == orderTable[i] then\n            return i\n        end\n    end\n    return 0\nend\n\n--- 字符串分割\n--- @param str string 待分割的字符串\n--- @return table list 分割后的列表\nM.StringSplit = function(str, mark)\n    local t = {}\n    local pattern = \"([^\" .. mark .. \"]+)\"\n    for match in string.gmatch(str, pattern) do\n        table.insert(t, match)\n    end\n    return t\nend\n\n--- 列表进行拼接\n--- @param str string 待分割的字符串\n--- @return table result 拼合后的字符串\nM.StringJoin = function(tbl, mark)\n    local result = \"\"\n    for i, v in ipairs(tbl) do\n        if i > 1 then\n            result = result .. mark\n        end\n        result = result .. v\n    end\n    return result\nend\n\n--- 判断当前物体是否是自己\n--- @param entity table 查找到的entity\n--- @return boolean result 是否是自己\nM.IsMe = function(entity)\n    if not entity then\n        return false\n    end\n    return M.GetPlayer().id == entity.id\nend\n\n--- 判断当前物体是否是自己\n--- @param curJosPos string 当前职能\n--- @return boolean result 是否是自己\nM.IsMeByPos = function(curJosPos)\n    if not table.contains(M.JobPosName, curJosPos) or not M.Party then\n        return false\n    end\n    local curPlayer = M.Party[curJosPos]\n    if not curPlayer then\n        return false\n    end\n    return M.GetPlayer().id == curPlayer.id\nend\n\n--- 计算目标点在中心点的相对方位 6点钟（C）逆时针 1~8\n--- @param center table 中心点的坐标 {x=number, z=number}\n--- @param target table 物品点的坐标 {x=number, z=number}\n--- @return number 方位 ID（1~8）\nM.GetDirectionIndex = function(center, target)\n    local heading = TensorCore.getHeadingToTarget(center, target);\n    local min = 100000000\n    local index = 0\n    -- 请求弧度最接近的值\n    for i = 1, 8 do\n        local curRad = (i - 1) / 4 * math.pi\n        local abs = math.abs(heading - curRad)\n        if abs < min then\n            min = abs\n            index = i\n        end\n    end\n    return index\nend\n\n--- 根据给定的站位表和heading输出8方位置\n--- @param tblStand table 站位表（C逆）\n--- @param heading number 方向\n--- @return string 方位名称\nM.GetGamePointByHeading = function(tblStand, heading)\n    for i = 1, 8 do\n        local infoDir = (i - 1) * math.pi / 4\n        if M.IsSame(infoDir, heading) then\n            return tblStand[i]\n        end\n    end\n    return nil\nend\n\n--- 从 startPos点出发，沿着 startPos => endPos 方向，获取距离为 distance 的点坐标\n--- @param startPos table 起点坐标\n--- @param endPos table 终点坐标\n--- @param distance number 距离，正值为朝向终点方向，负值为反向\n--- @return table targetPos 返回目标点的坐标，包含 x 和 z 分量\nM.GetPointAtDistance = function(startPos, endPos, distance)\n    local heading = TensorCore.getHeadingToTarget(startPos, endPos)\n    return TensorCore.getPosInDirection(startPos, heading, distance)\nend\n\n--- 计算2个弧度之间的夹角（0~π）\nM.GetAngleRadian = function(r1, r2)\n    local diff = math.abs(r2 - r1)\n    if diff > math.pi then\n        diff = 2 * math.pi - diff\n    end\n    return diff\nend\n\n--- 判断2个数是否相等\n--- @return boolean is same\nM.IsSame = function(n1, n2)\n    if n1 == nil or n2 == nil then\n        return n1 == nil and n2 == nil\n    end\n    if n1 == n2 then\n        return true\n    end\n    local diff = math.abs(n1 - n2)\n    if diff < 0.05 then\n        return true\n    end\n    return false\nend\n\n--- 将给定弧度调整到0~2π\nM.SetHeading2Pi = function(heading)\n    if M.IsSame(heading, 0) or M.IsSame(heading, 2 * math.pi) then\n        return 0\n    end\n    if heading > math.pi * 2 then\n        local result = heading - math.pi * 2\n        if M.IsSame(endH, 0) then\n            return 0\n        end\n        return result\n    end\n    if heading < 0 then\n        return heading + math.pi * 2\n    end\n    return heading\nend\n\n--- 判断点A到B的顺逆\n--- @return boolean true 顺时针，false 逆时针\nM.GetClock = function(posA, posB)\n    local OA = { x = posA.x - 100, z = posA.z - 100 }\n    local OB = { x = posB.x - 100, z = posB.z - 100 }\n    local crossProduct = OA.x * OB.z - OA.z * OB.x\n    -- 非标准坐标系，叉乘结果要反着来\n    if crossProduct > 0 then\n        return true\n    elseif crossProduct < 0 then\n        return false\n    end\nend\n\n--- 计算基础搭档\nM.GetBasePartner = function()\n    local partner\n    if MuAiGuide.SelfPos == \"MT\" then\n        partner = \"D3\"\n    elseif MuAiGuide.SelfPos == \"ST\" then\n        partner = \"D4\"\n    elseif MuAiGuide.SelfPos == \"H1\" then\n        partner = \"D1\"\n    elseif MuAiGuide.SelfPos == \"H2\" then\n        partner = \"D2\"\n    elseif MuAiGuide.SelfPos == \"D1\" then\n        partner = \"H1\"\n    elseif MuAiGuide.SelfPos == \"D2\" then\n        partner = \"H2\"\n    elseif MuAiGuide.SelfPos == \"D3\" then\n        partner = \"MT\"\n    elseif MuAiGuide.SelfPos == \"D4\" then\n        partner = \"ST\"\n    end\n    return partner\nend\n\n--- 计算同为远程/近战搭档\nM.GetRMPartner = function()\n    local partner\n    if MuAiGuide.SelfPos == \"MT\" then\n        partner = \"D1\"\n    elseif MuAiGuide.SelfPos == \"ST\" then\n        partner = \"D2\"\n    elseif MuAiGuide.SelfPos == \"H1\" then\n        partner = \"D3\"\n    elseif MuAiGuide.SelfPos == \"H2\" then\n        partner = \"D4\"\n    elseif MuAiGuide.SelfPos == \"D1\" then\n        partner = \"MT\"\n    elseif MuAiGuide.SelfPos == \"D2\" then\n        partner = \"ST\"\n    elseif MuAiGuide.SelfPos == \"D3\" then\n        partner = \"H1\"\n    elseif MuAiGuide.SelfPos == \"D4\" then\n        partner = \"H2\"\n    end\n    return partner\nend\n\n------------------------------- 全局绘制 -------------------------------\nM.NotDelayGuides = {}\n\n--- 取消已注册的所有指路\nM.CancelDir = function()\n    if table.size(M.NotDelayGuides) > 0 then\n        for i, uuid in pairs(M.NotDelayGuides) do\n            Argus.deleteTimedShape(uuid)\n        end\n        M.NotDelayGuides = {}\n    end\nend\n\n--- 绘制一个指路工具\n--- @param x number 当前x坐标\n--- @param z number 当前z坐标\n--- @param time number 指路时间（毫秒）\n--- @param size? number 圈大小（默认0.5）\n--- @param delay? number 延迟执行（毫秒）\nM.DirectTo = function(x, z, time, size, delay)\n    local color = M.Config.GuideColor\n    size = size or 0.5\n    delay = delay or 0\n    if delay < 1 then\n        M.CancelDir()\n    end\n    local newDraw = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),\n        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),\n        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1)),\n        2\n    )\n    local guide1 = newDraw:addTimedCircle(time, x, M.GetPlayer().pos.y, z, size, delay, true)\n    local guide2 = Argus2.addTimedRectFilled(\n        time,\n        x,\n        M.GetPlayer().pos.y,\n        z,\n        0.3,\n        0.05,\n        math.pi,\n        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),\n        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),\n        nil,\n        delay,\n        nil,\n        M.GetPlayer().id,\n        false,\n        nil,\n        0.01,\n        nil,\n        nil,\n        true\n    )\n\n    local newDraw2 = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),\n        nil,\n        1\n    )\n\n    local guide3 = newDraw2:addTimedCircle(time, x, M.GetPlayer().pos.y, z, 0.03, delay, true)\n    if delay < 1 then\n        table.insert(M.NotDelayGuides, guide1)\n        table.insert(M.NotDelayGuides, guide2)\n        table.insert(M.NotDelayGuides, guide3)\n    end\nend\n\n--- 绘制一个连到其他玩家的连线（矩形）\nM.LinkToPlayer = function(id, time, size, r, g, b, a)\n    size = size or 0.05\n    r = r or 0\n    g = g or 0\n    b = b or 0\n    a = a or 0.55\n    if r == 0 and g == 0 and b == 0 then\n        b = 255\n    end\n    Argus2.addTimedRectFilled(\n        time,\n        100,\n        M.GetPlayer().pos.y,\n        100,\n        0.3,\n        size,\n        math.pi,\n        (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),\n        (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),\n        nil,\n        0,\n        id,\n        M.GetPlayer().id,\n        false,\n        nil,\n        0.01,\n        nil,\n        nil,\n        true\n    )\nend\n\n--- 指路到某移动物体\n--- @param id number 目标的Id\n--- @return table uuidList\nM.DirectToEnt = function(id, time, size)\n    local drawIds = {}\n    size = size or 0.2\n    local color = M.Config.GuideColor\n\n    local newDraw = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),\n        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),\n        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1)),\n        2\n    )\n\n    local id1 = newDraw:addTimedCircleOnEnt(time, id, size, 0, true)\n    local id2 = Argus2.addTimedRectFilled(\n        time,\n        0,\n        M.GetPlayer().pos.y,\n        0,\n        0.3,\n        0.05,\n        math.pi,\n        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),\n        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),\n        nil,\n        0,\n        id,\n        M.GetPlayer().id,\n        false,\n        nil,\n        0.01,\n        nil,\n        nil,\n        true\n    )\n    local newDraw2 = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),\n        nil,\n        1\n    )\n\n    local id3 = newDraw2:addTimedCircleOnEnt(time, id, 0.03, 0, true)\n    table.insert(drawIds, id1)\n    table.insert(drawIds, id2)\n    table.insert(drawIds, id3)\n    return drawIds\nend\n\nM.FrameDirect = function(x, z, size)\n    size = size or 0.5\n    local playerPos = TensorCore.mGetEntity(M.GetPlayer().id).pos\n    local color = M.Config.GuideColor\n    local newDraw = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),\n        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),\n        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1)),\n        2\n    )\n    newDraw:addCircle(x, playerPos.y, z, size, true)\n    local newDraw2 = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),\n        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),\n        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),\n        (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),\n        2\n    )\n    local distance = TensorCore.getDistance2d(playerPos, { x = x, y = 0, z = z })\n    local heading = TensorCore.getHeadingToTarget(playerPos, { x = x, y = 0, z = z })\n    newDraw2:addRect(playerPos.x, playerPos.y, playerPos.z, distance, 0.05, heading, true)\n    local newDraw3 = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),\n        nil,\n        1\n    )\n    newDraw3:addCircle(x, playerPos.y, z, 0.03, true)\nend\n\n--- 绘制一个圆\nM.DrawCircleUI = function(x, z, time, size, r, g, b, a, delay)\n    r = r or 0\n    g = g or 0\n    b = b or 0\n    a = a or 0.35\n    delay = delay or 0\n    size = size or 1\n    if r == 0 and g == 0 and b == 0 then\n        g = 255\n    end\n    local newDraw = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),\n        (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),\n        (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1)),\n        1\n    )\n    newDraw:addTimedCircle(time, x, M.GetPlayer().pos.y, z, size, 0, true)\nend\n\n--- 绘制一个地面圆\nM.DrawCircleFloor = function(x, z, time, size, r, g, b, a, delay)\n    r = r or 0\n    g = a or 0\n    b = b or 0\n    a = a or 0.35\n    size = size or 1\n    delay = delay or 0\n    if r == 0 and g == 0 and b == 0 then\n        g = 255\n    end\n    local newDraw = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),\n        (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),\n        (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1)),\n        1\n    )\n    newDraw:addTimedCircle(time, x, M.GetPlayer().pos.y, z, size, 0, false)\nend\nM.Debug(\"初始化成功!\")\nself.used = true\n",
						conditions = 
						{
							
							{
								"b78ab0cc-9e0f-2286-8d92-db467096ddd7",
								true,
							},
							
							{
								"7fdeee4c-72a2-05ea-8dba-924e9c684026",
								true,
							},
						},
						gVar = "ACR_TensorRequiem3_CD",
						name = "MuAiGuideGlobal",
						uuid = "bf52aa28-58f1-3e62-a8da-e16c2d246c86",
						version = 2.1,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "if not MuAiGuide.UIPop then\n    MuAiGuide.UIPop = false\nend\n\nif MuAiGuide and not MuAiGuide.UIPop then\n    local party = MuAiGuide.GetPartyPlayers()\n    if party and table.size(party) >= 8 then\n        if table.size(MuAiGuide.Party) == 0 then\n            MuAiGuide.LoadParty()\n        end\n        MuAiGuide.UI.open = true\n        MuAiGuide.UIPop = true\n        MuAiGuide.Info(\"欢迎使用暮霭指路系列时间轴, 作者QQ：2437365584，欢迎BUG反馈！\")\n    end\nend\nself.used = true",
						conditions = 
						{
							
							{
								"0c9fdff7-6d79-4928-bdfd-3254b0be907f",
								true,
							},
							
							{
								"7fdeee4c-72a2-05ea-8dba-924e9c684026",
								true,
							},
						},
						gVar = "ACR_RikuMNK2_CD",
						name = "OnMapChangeAutoPop",
						uuid = "e0fdf394-9150-e791-99da-a7eefaa8769b",
						version = 2.1,
					},
					inheritedIndex = 2,
				},
			},
			conditions = 
			{
				
				{
					data = 
					{
						category = "Self",
						conditionType = 12,
						localMapIDList = 
						{
							1238,
							1122,
						},
						localmapid = 1228,
						name = "指路支持的地图",
						uuid = "7fdeee4c-72a2-05ea-8dba-924e9c684026",
						version = 2,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide == nil",
						name = "MuAiGuideNotInit",
						uuid = "b78ab0cc-9e0f-2286-8d92-db467096ddd7",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide ~= nil",
						name = "MuAiGuideIsInit",
						uuid = "0c9fdff7-6d79-4928-bdfd-3254b0be907f",
						version = 2,
					},
				},
			},
			eventType = 11,
			name = "MuAiGuide",
			timeout = 10,
			uuid = "b1ec4a77-b34b-71e5-9b4c-b388d08b8b03",
			version = 2,
		},
		inheritedIndex = 4,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "-- 优先级UI打开\nif GUI:IsKeyPressed(88) and GUI:IsKeyDown(17) then\n    MuAiGuide.UI.open = not MuAiGuide.UI.open\n    if MuAiGuide.UI.open then\n        d(\"[MuAiGuide]打开UI\")\n    else\n        d(\"[MuAiGuide]关闭UI\")\n    end\nend\n",
						conditions = 
						{
							
							{
								"edc3f9f7-c453-c8a3-aac2-4dc7bff618a0",
								true,
							},
						},
						gVar = "ACR_RikuMNK2_CD",
						name = "ClickToOpen",
						uuid = "098bc86b-a89f-fb7a-917e-9f3a18033c64",
						version = 2.1,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "if MuAiGuide and MuAiGuide.FruConfigUI.open then\n    local M = MuAiGuide\n    -- 全局变量读取\n    if not M.ConfigInit then\n        M.ConfigInit = true\n        --------- P1 雾龙 ---------\n        M.FruConfigUI.P1InputStr1 = M.StringJoin(M.Config.FruCfg.JobPos, \",\")\n        M.FruConfigUI.Input1Changed = false\n\n        --------- P1 雾龙 ---------\n        M.FruConfigUI.P1InputStr2 = M.StringJoin(M.Config.FruCfg.FruUtopainSkyPosInfo, \",\")\n        M.FruConfigUI.Input2Changed = false\n\n        --------- P1 雷火线 ---------\n        M.FruConfigUI.P1InputStr3 = M.StringJoin(M.Config.FruCfg.FruLightFirePriority, \",\")\n        M.FruConfigUI.Input3Changed = false\n        M.FruConfigUI.BluePos = { \"B\", \"D\", \"3\", \"4\" }\n        M.FruConfigUI.FixInputRight = true\n    end\n\n    GUI:SetNextWindowSize(200, 0, GUI.SetCond_Appearing)\n    GUI:SetNextWindowPos(M.FruConfigUI.x, M.FruConfigUI.y, GUI.SetCond_Appearing)\n    M.FruConfigUI.visible, M.FruConfigUI.open = GUI:Begin(\"绝伊甸相关配置\", M.FruConfigUI.open)\n    if M.FruConfigUI.visible then\n        GUI:SetNextWindowPos(M.FruConfigUI.x, M.FruConfigUI.y, GUI.SetCond_Appearing)\n        GUI:Dummy(1, 3)\n        GUI:TextColored(255, 0, 0, 1, \"注意：\")\n        GUI:Text(\"职能\")\n        GUI:SameLine()\n        GUI:TextColored(255, 0, 0, 1, \"全大写！\")\n        GUI:SameLine()\n        GUI:Text(\"如果需要填写多个，要用\")\n        GUI:SameLine()\n        GUI:TextColored(255, 0, 0, 1, \"英文逗号“,”\")\n        GUI:Text(\"进行分隔！\")\n        GUI:Separator()\n        GUI:Dummy(1, 3)\n        if GUI:CollapsingHeader(\"全局设置\") then\n            GUI:Text(\"基础8方站位：\")\n            GUI:SameLine()\n            GUI:TextColored(255, 0, 0, 1, \"[C开始逆时针]\")\n            M.FruConfigUI.P1InputStr1, M.FruConfigUI.Input1Changed = GUI:InputText(\"#1\", M.FruConfigUI.P1InputStr1,\n                GUI.InputTextFlags_CharsNoBlank)\n            if M.FruConfigUI.Input1Changed then\n                M.Config.FruCfg.JobPos = M.StringSplit(M.FruConfigUI.P1InputStr1, \",\")\n            end\n        end\n\n        if GUI:CollapsingHeader(\"P1.绝命战士\") then\n            GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)\n            if GUI:TreeNode(\"1.雾龙\") then\n                GUI:Text(\"8方位置\")\n                GUI:SameLine()\n                GUI:TextColored(255, 0, 0, 1, \"[C开始逆时针]\")\n                M.FruConfigUI.P1InputStr2, M.FruConfigUI.Input2Changed = GUI:InputText(\"#2\", M.FruConfigUI.P1InputStr2,\n                    GUI.InputTextFlags_CharsNoBlank)\n                if M.FruConfigUI.Input2Changed then\n                    M.Config.FruCfg.FruUtopainSkyPosInfo = M.StringSplit(M.FruConfigUI.P1InputStr2, \",\")\n                end\n                GUI:TreePop()\n            end\n            GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)\n            if GUI:TreeNode(\"2.双分组\") then\n                GUI:PushItemWidth(110)\n                GUI:TextColored(255, 0, 0, 1, \"[含优先级设置]\")\n                local inputGroupUp, inputGroupUpChanged = GUI:InputText(\": 去上\",\n                    M.StringJoin(M.Config.FruCfg.CatchTwoUp, \",\"),\n                    GUI.InputTextFlags_CharsNoBlank)\n                if inputGroupUpChanged then\n                    M.Config.FruCfg.CatchTwoUp = M.StringSplit(inputGroupUp, \",\")\n                end\n                local inputGroupDown, inputGroupDownChanged = GUI:InputText(\": 去下\",\n                    M.StringJoin(M.Config.FruCfg.CatchTwoDown, \",\"),\n                    GUI.InputTextFlags_CharsNoBlank)\n                if inputGroupDownChanged then\n                    M.Config.FruCfg.CatchTwoDown = M.StringSplit(inputGroupDown, \",\")\n                end\n                local inputGroupFall, inputGroupFallDownChanged = GUI:InputText(\": 补位\",\n                    M.StringJoin(M.Config.FruCfg.CatchTwoDownFall, \",\"),\n                    GUI.InputTextFlags_CharsNoBlank)\n                if inputGroupFallDownChanged then\n                    M.Config.FruCfg.CatchTwoDownFall = M.StringSplit(inputGroupFall, \",\")\n                end\n                GUI:PopItemWidth()\n                GUI:TreePop()\n            end\n            GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)\n            if GUI:TreeNode(\"3.雷火线\") then\n                GUI:Text(\"优先级：\")\n                M.FruConfigUI.P1InputStr3, M.FruConfigUI.Input3Changed = GUI:InputText(\"#3\", M.FruConfigUI.P1InputStr3,\n                    GUI.InputTextFlags_CharsNoBlank)\n                if M.FruConfigUI.Input3Changed then\n                    M.Config.FruCfg.FruLightFirePriority = M.StringSplit(M.FruConfigUI.P1InputStr3, \",\")\n                end\n                GUI:Text(\"处理方向：\")\n                if GUI:Checkbox(\"上下\", M.Config.FruCfg.FruLightFireDir == 1) then\n                    M.Config.FruCfg.FruLightFireDir = 1\n                end\n                GUI:SameLine()\n                if GUI:Checkbox(\"左右\", M.Config.FruCfg.FruLightFireDir == 2) then\n                    M.Config.FruCfg.FruLightFireDir = 2\n                end\n                GUI:Text(\"处理方式：\")\n                if GUI:Checkbox(\"上下互换\", M.Config.FruCfg.FruLightFireType == 1) then\n                    M.Config.FruCfg.FruLightFireType = 1\n                end\n                GUI:SameLine()\n                if GUI:Checkbox(\"闲人固定\", M.Config.FruCfg.FruLightFireType == 2) then\n                    M.Config.FruCfg.FruLightFireType = 2\n                end\n                GUI:TreePop()\n            end\n            GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)\n            if GUI:TreeNode(\"4.踩塔\") then\n                GUI:Text(\"踩塔方式：\")\n                if GUI:Checkbox(\"填充[小学塔]\", M.Config.FruCfg.TakeTowerType == 1) then\n                    M.Config.FruCfg.TakeTowerType = 1\n                end\n                GUI:SameLine()\n                if GUI:Checkbox(\"固定/补位\", M.Config.FruCfg.TakeTowerType == 2) then\n                    M.Config.FruCfg.TakeTowerType = 2\n                end\n                if M.Config.FruCfg.TakeTowerType == 1 then\n                    GUI:Text(\"补位优先级：\")\n                    GUI:SameLine()\n                    local fallInput, fallInputChanged = GUI:InputText(\"#order\",\n                        M.StringJoin(M.Config.FruCfg.FallTowerOrder, \",\"),\n                        GUI.InputTextFlags_CharsNoBlank)\n                    if fallInputChanged then\n                        M.Config.FruCfg.FallTowerOrder = M.StringSplit(fallInput, \",\")\n                    end\n                elseif M.Config.FruCfg.TakeTowerType == 2 then\n                    GUI:Text(\"固定成员：\")\n                    GUI:SameLine()\n                    GUI:PushItemWidth(45)\n                    GUI:TextColored(0, 255, 0, 1, \"[第一个是固定，第二个是补位]\")\n                    local inputFixUp, inputFixUpChanged = GUI:InputText(\":上塔 \",\n                        M.StringJoin(M.Config.FruCfg.FixTowerUp, \",\"),\n                        GUI.InputTextFlags_CharsNoBlank)\n                    if inputFixUpChanged then\n                        M.Config.FruCfg.FixTowerUp = M.StringSplit(inputFixUp, \",\")\n                    end\n                    GUI:SameLine()\n                    local inputFixMid, inputFixMidChanged = GUI:InputText(\":中塔 \",\n                        M.StringJoin(M.Config.FruCfg.FixTowerMid, \",\"),\n                        GUI.InputTextFlags_CharsNoBlank)\n                    if inputFixMidChanged then\n                        M.Config.FruCfg.FixTowerMid = M.StringSplit(inputFixMid, \",\")\n                    end\n                    GUI:SameLine()\n                    local inputFixDown, inputFixDownChanged = GUI:InputText(\":下塔 \",\n                        M.StringJoin(M.Config.FruCfg.FixTowerDown, \",\"),\n                        GUI.InputTextFlags_CharsNoBlank)\n                    if inputFixDownChanged then\n                        M.Config.FruCfg.FixTowerDown = M.StringSplit(inputFixDown, \",\")\n                    end\n                    GUI:PopItemWidth()\n                end\n                GUI:TreePop()\n            end\n        end\n        if GUI:CollapsingHeader(\"P2.希瓦·米特隆\") then\n            GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)\n            if GUI:TreeNode(\"1.镜中奇遇\") then\n                GUI:PushItemWidth(110)\n                GUI:Text(\"近战第1波：\")\n                GUI:SameLine()\n                GUI:TextColored(0, 255, 0, 1, \"[BOSS面向为12点，从左到右]\")\n                local inputMelee1, inputMelee1Changed = GUI:InputText(\"#4\",\n                    M.StringJoin(M.Config.FruCfg.MirrorPosMelee1, \",\"),\n                    GUI.InputTextFlags_CharsNoBlank)\n                if inputMelee1Changed then\n                    M.Config.FruCfg.MirrorPosMelee1 = M.StringSplit(inputMelee1, \",\")\n                end\n                GUI:Text(\"近战第2波：\")\n                GUI:SameLine()\n                GUI:TextColored(0, 255, 0, 1, \"[面向镜子]\")\n                local inputMelee2, inputMelee2Changed = GUI:InputText(\"#5\",\n                    M.StringJoin(M.Config.FruCfg.MirrorPosMelee2, \",\"),\n                    GUI.InputTextFlags_CharsNoBlank)\n                if inputMelee2Changed then\n                    M.Config.FruCfg.MirrorPosMelee2 = M.StringSplit(inputMelee2, \",\")\n                end\n\n                GUI:Text(\"远程站位：\")\n                GUI:SameLine()\n                GUI:TextColored(0, 255, 0, 1, \"[面向镜子]\")\n                local inputRange, inputRangeChanged = GUI:InputText(\"#6\",\n                    M.StringJoin(M.Config.FruCfg.MirrorPosRange, \",\"),\n                    GUI.InputTextFlags_CharsNoBlank)\n                if inputRangeChanged then\n                    M.Config.FruCfg.MirrorPosRange = M.StringSplit(inputRange, \",\")\n                end\n                GUI:PopItemWidth()\n                GUI:TreePop()\n            end\n            GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)\n            if GUI:TreeNode(\"2.光之暴走\") then\n                if GUI:Checkbox(\"田园郡式（莫古力）\", M.Config.FruCfg.FruLightRampantType == 1) then\n                    M.Config.FruCfg.FruLightRampantType = 1\n                end\n                GUI:SameLine()\n                if GUI:Checkbox(\"新灰9式\", M.Config.FruCfg.FruLightRampantType == 2) then\n                    M.Config.FruCfg.FruLightRampantType = 2\n                end\n                GUI:TreePop()\n            end\n        end\n        if GUI:CollapsingHeader(\"P3.暗之巫女\") then\n            GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)\n            if GUI:TreeNode(\"地火处理方案\") then\n                if GUI:Checkbox(\"车头固定，人群根据顺逆去车头下一个位置\", M.Config.FruCfg.ApocalypseType == 1) then\n                    M.Config.FruCfg.ApocalypseType = 1\n                end\n                if GUI:Checkbox(\"人群固定，车头根据顺逆找人群前一个位置\", M.Config.FruCfg.ApocalypseType == 2) then\n                    M.Config.FruCfg.ApocalypseType = 2\n                end\n                GUI:TreePop()\n            end\n        end\n        if GUI:CollapsingHeader(\"P4：光之巫女&暗之巫女\") then\n            GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)\n            if GUI:TreeNode(\"1.贡品分配：\") then\n                GUI:Text(\"基础方案： \")\n                GUI:SameLine()\n                if GUI:Checkbox(\"根据BUFF\", M.Config.FruCfg.CrystallizeTimeType == 1) then\n                    M.Config.FruCfg.CrystallizeTimeType = 1\n                end\n                GUI:SameLine()\n                if GUI:Checkbox(\"ACT标点\", M.Config.FruCfg.CrystallizeTimeType == 2) then\n                    M.Config.FruCfg.CrystallizeTimeType = 2\n                end\n                GUI:SameLine()\n                if GUI:Checkbox(\"自动摇号\", M.Config.FruCfg.CrystallizeTimeType == 3) then\n                    M.Config.FruCfg.CrystallizeTimeType = 3\n                end\n                GUI:Text(\"具体位置： \")\n                GUI:SameLine()\n                if M.Config.FruCfg.CrystallizeTimeType == 1 then\n                    M.FruConfigUI.FixInputRight = true\n                    GUI:PushItemWidth(20)\n                    local inputFlame, inputFlameChanged = GUI:InputText(\":暗焰\",\n                        M.Config.FruCfg.CrystallizeTimeFix[2460],\n                        GUI.InputTextFlags_CharsNoBlank)\n                    if inputFlameChanged then\n                        if table.contains(M.FruConfigUI.BluePos, inputFlame) then\n                            M.Config.FruCfg.CrystallizeTimeFix[2460] = inputFlame\n                        else\n                            M.FruConfigUI.FixInputRight = false\n                        end\n                    end\n                    GUI:SameLine()\n                    local inputConverge, inputConvergeChanged = GUI:InputText(\":分摊\",\n                        M.Config.FruCfg.CrystallizeTimeFix[2454],\n                        GUI.InputTextFlags_CharsNoBlank)\n                    if inputConvergeChanged then\n                        if table.contains(M.FruConfigUI.BluePos, inputConverge) then\n                            M.Config.FruCfg.CrystallizeTimeFix[2454] = inputConverge\n                        else\n                            M.FruConfigUI.FixInputRight = false\n                        end\n                    end\n                    GUI:SameLine()\n                    local inputIce, inputIceChanged = GUI:InputText(\":冰\", M.Config.FruCfg.CrystallizeTimeFix[2462],\n                        GUI.InputTextFlags_CharsNoBlank)\n                    if inputIceChanged then\n                        if table.contains(M.FruConfigUI.BluePos, inputIce) then\n                            M.Config.FruCfg.CrystallizeTimeFix[2462] = inputIce\n                        else\n                            M.FruConfigUI.FixInputRight = false\n                        end\n                    end\n                    GUI:SameLine()\n\n                    GUI:SameLine()\n                    local inputWater, inputWaterChanged = GUI:InputText(\":水\", M.Config.FruCfg.CrystallizeTimeFix[2461],\n                        GUI.InputTextFlags_CharsNoBlank)\n                    if inputWaterChanged then\n                        if table.contains(M.FruConfigUI.BluePos, inputWater) then\n                            M.Config.FruCfg.CrystallizeTimeFix[2461] = inputWater\n                        else\n                            M.FruConfigUI.FixInputRight = false\n                        end\n                    end\n                    if not M.FruConfigUI.FixInputRight then\n                        GUI:TextColored(255, 0, 0, 1, \"错误，请检查填写的内容!\")\n                    end\n                    GUI:PopItemWidth()\n                else\n                    GUI:PushItemWidth(20)\n                    local inputStrD, DChanged = GUI:InputText(\"去D\",\n                        M.Config.FruCfg.CrystallizeMark[\"D\"],\n                        GUI.InputTextFlags_CharsNoBlank)\n                    if DChanged then\n                        M.Config.FruCfg.CrystallizeMark[\"D\"] = inputStrD\n                    end\n                    GUI:SameLine()\n                    local inputStrB, BChanged = GUI:InputText(\"去B\",\n                        M.Config.FruCfg.CrystallizeMark[\"B\"],\n                        GUI.InputTextFlags_CharsNoBlank)\n                    if BChanged then\n                        M.Config.FruCfg.CrystallizeMark[\"B\"] = inputStrB\n                    end\n                    GUI:SameLine()\n                    local inputStr3, _3Changed = GUI:InputText(\"去3\",\n                        M.Config.FruCfg.CrystallizeMark[\"3\"],\n                        GUI.InputTextFlags_CharsNoBlank)\n                    if _3Changed then\n                        M.Config.FruCfg.CrystallizeMark[\"3\"] = inputStr3\n                    end\n                    GUI:SameLine()\n                    local inputStr4, _4Changed = GUI:InputText(\"去4\",\n                        M.Config.FruCfg.CrystallizeMark[\"4\"],\n                        GUI.InputTextFlags_CharsNoBlank)\n                    if _4Changed then\n                        M.Config.FruCfg.CrystallizeMark[\"4\"] = inputStr4\n                    end\n\n                    GUI:PopItemWidth()\n                end\n                GUI:TreePop()\n            end\n            GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)\n            if GUI:TreeNode(\"2.击退方案：\") then\n                if GUI:Checkbox(\"Y字\", M.Config.FruCfg.CrystallizeTimeKnockBack == 1) then\n                    M.Config.FruCfg.CrystallizeTimeKnockBack = 1\n                end\n                GUI:SameLine()\n                if GUI:Checkbox(\"角落\", M.Config.FruCfg.CrystallizeTimeKnockBack == 2) then\n                    M.Config.FruCfg.CrystallizeTimeKnockBack = 2\n                end\n                GUI:TreePop()\n            end\n        end\n        if GUI:CollapsingHeader(\"P5.潘多拉·米特隆\") then\n            GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)\n            if GUI:TreeNode(\"踩塔方式：\") then\n                GUI:PushItemWidth(45)\n                local inputDown, inputDownChanged = GUI:InputText(\"去下，\",\n                    M.StringJoin(M.Config.FruCfg.DarkLightWings.Down, \",\"),\n                    GUI.InputTextFlags_CharsNoBlank)\n                if inputDownChanged then\n                    M.Config.FruCfg.DarkLightWings.Down = M.StringSplit(inputDown, \",\")\n                end\n                GUI:SameLine()\n                local inputLeft, inputLeftChanged = GUI:InputText(\"去左上，\",\n                    M.StringJoin(M.Config.FruCfg.DarkLightWings.Left, \",\"),\n                    GUI.InputTextFlags_CharsNoBlank)\n                if inputLeftChanged then\n                    M.Config.FruCfg.DarkLightWings.Left = M.StringSplit(inputLeft, \",\")\n                end\n                GUI:SameLine()\n                local inputRight, inputRightChanged = GUI:InputText(\"去右上\",\n                    M.StringJoin(M.Config.FruCfg.DarkLightWings.Right, \",\"),\n                    GUI.InputTextFlags_CharsNoBlank)\n                if inputRightChanged then\n                    M.Config.FruCfg.DarkLightWings.Right = M.StringSplit(inputRight, \",\")\n                end\n                GUI:PopItemWidth()\n                GUI:TreePop()\n            end\n        end\n        GUI:Separator()\n        GUI:Button(\"恢复默认\")\n        if GUI:IsItemClicked(0) then\n            M.Config.FruCfg = M.CreateFruDefaultCfg()\n        end\n        --[[ GUI:Button(\"测试按钮\")\n         if GUI:IsItemClicked(0) then\n             d(M.Config.FruCfg)\n         end]]\n    end\n    MuAiGuide.SaveConfig()\n    GUI:SetWindowSize(350, 0)\n    GUI:End()\nend\nself.used = true\n",
						conditions = 
						{
							
							{
								"edc3f9f7-c453-c8a3-aac2-4dc7bff618a0",
								true,
							},
						},
						gVar = "ACR_TensorRequiem3_CD",
						name = "FruConfigUI",
						uuid = "12cfbd9f-ec79-0333-be7f-908645a421e0",
						version = 2.1,
					},
					inheritedIndex = 3,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "if MuAiGuide and MuAiGuide.UI.open then\n    local M = MuAiGuide\n    if M.ConfigUI == nil then\n        M.ConfigUI = {}\n        M.ConfigUI.GuideColorChange = false\n        M.ConfigUI.DebugPos = M.Config.DebugPos\n        M.ConfigUI.DebugPosChange = false\n        M.ConfigUI.DebugMode = false\n    end\n    GUI:SetNextWindowSize(200, 0, GUI.SetCond_Appearing)\n    M.UI.visible, M.UI.open = GUI:Begin(\"MuAiGuide Setting\", M.UI.open)\n    if M.UI.visible then\n        GUI:Dummy(1, 1)\n        GUI:Separator() ------------------------------------------------------------------------------\n        if GUI:CollapsingHeader(\"基础设置\") then\n            GUI:Text(\" \")\n            GUI:SameLine()\n            M.Config.AnyOneReactionOn = GUI:Checkbox(\"启用Anyone\", M.Config.AnyOneReactionOn)\n            GUI:SameLine()\n            GUI:TextColored(0, 255, 0, 1, \"[开启后将关闭不必要的重复功能]\")\n            GUI:Text(\" \")\n            GUI:SameLine()\n            M.Config.GuideColor.r, M.Config.GuideColor.g, M.Config.GuideColor.b, M.Config.GuideColor.a, M.ConfigUI.GuideColorChange =\n                GUI:ColorEdit4(\"指路工具颜色\",\n                    M.Config.GuideColor.r,\n                    M.Config.GuideColor.g,\n                    M.Config.GuideColor.b,\n                    M.Config.GuideColor.a,\n                    GUI.ColorEditMode_NoInputs)\n            if M.ConfigUI.GuideColorChange then\n                M.SaveConfig()\n            end\n            GUI:Text(\" \")\n            GUI:SameLine()\n            M.Config.LogToEchoMsg = GUI:Checkbox(\"启用聊天栏提示\", M.Config.LogToEchoMsg)\n            GUI:SameLine()\n            GUI:TextColored(0, 255, 0, 1, \"[在聊天栏输出提示信息]\")\n            GUI:Dummy(1, 1)\n            GUI:Button(\"恢复默认设置\")\n            if GUI:IsItemClicked(0) then\n                M.LoadDefaultMain()\n            end\n            GUI:SameLine()\n            GUI:Text(\" \")\n            GUI:SameLine()\n            GUI:Button(\"重新加载小队列表\")\n            if GUI:IsItemClicked(0) then\n                M.LoadParty()\n            end\n        end\n        GUI:Separator() ------------------------------------------------------------------------------\n        GUI:BulletText(\"职能设置\")\n        GUI:SameLine()\n        GUI:TextColored(0, 255, 0, 1, \"[拖动角色名进行职能修改]\")\n        GUI:Text(\"   玩家当前职能\")\n        GUI:SameLine()\n        if M.DebugMode then\n            GUI:TextColored(255, 0, 0, 1, \"[\" .. M.SelfPos .. \"][调试]\")\n        else\n            GUI:TextColored(255, 0, 0, 1, \"[\" .. M.SelfPos .. \"]\")\n        end\n\n        GUI:Text(\"    <职能>    <职业>     <角色名>\")\n        if M.Party == nil or table.size(M.Party) == 0 then\n            M.Party = {}\n            M.Party.MT = nil\n            M.Party.ST = nil\n            M.Party.H1 = nil\n            M.Party.H2 = nil\n            M.Party.D1 = nil\n            M.Party.D2 = nil\n            M.Party.D3 = nil\n            M.Party.D4 = nil\n        end\n        GUI:Text(\" \")\n        GUI:SameLine()\n        GUI:PushItemWidth(303)\n        GUI:ListBoxHeader(\"##Jobs\", 304, 200)\n        local partyMembers = {\n            { info = M.Party.MT, label = \"MT\" },\n            { info = M.Party.ST, label = \"ST\" },\n            { info = M.Party.H1, label = \"H1\" },\n            { info = M.Party.H2, label = \"H2\" },\n            { info = M.Party.D1, label = \"D1\" },\n            { info = M.Party.D2, label = \"D2\" },\n            { info = M.Party.D3, label = \"D3\" },\n            { info = M.Party.D4, label = \"D4\" }\n        }\n        for i, member in ipairs(partyMembers) do\n            local IsSelected = function()\n                if member.label == M.Party.selected then\n                    return true\n                end\n                return false\n            end\n            local ptMember = partyMembers[i]\n            if i == 1 or i == 2 then\n                GUI:ColorButton(\"#jobPos\", 0, 0, 255, 255, GUI.ColorEditMode_NoTooltip, 20, 20)\n            elseif i == 3 or i == 4 then\n                GUI:ColorButton(\"#jobPos\", 0, 255, 0, 255, GUI.ColorEditMode_NoTooltip, 20, 20)\n            else\n                GUI:ColorButton(\"#jobPos\", 255, 0, 0, 255, GUI.ColorEditMode_NoTooltip, 20, 20)\n            end\n            GUI:SameLine()\n            if i == 1 or i == 2 then\n                GUI:TextColored(0, 100, 255, 1, \"[\" .. ptMember.label .. \"]\")\n            elseif i == 3 or i == 4 then\n                GUI:TextColored(0, 255, 0, 1, \"[\" .. ptMember.label .. \"]\")\n            else\n                GUI:TextColored(255, 0, 0, 1, \"[\" .. ptMember.label .. \"]\")\n            end\n            GUI:SameLine()\n            if ptMember.info ~= nil and ptMember.info.job ~= nil and ptMember.info.name ~= nil then\n                GUI:Selectable(\n                    \"   \" .. M.GetJobNameById(ptMember.info.job) .. \"      \" .. ptMember.info.name,\n                    IsSelected()\n                )\n            else\n                GUI:Selectable(\"   \" .. \"未知\" .. \"      \" .. \"未知玩家\" .. i, IsSelected())\n            end\n            if\n                GUI:IsItemHovered(\n                    GUI.HoveredFlags_AllowWhenBlockedByPopup + GUI.HoveredFlags_AllowWhenBlockedByActiveItem +\n                    GUI.HoveredFlags_AllowWhenOverlapped\n                )\n            then\n                if GUI:IsMouseDown(0) then\n                    if M.Party.mousePosition == nil then\n                        if M.Party.mousePosition ~= ptMember.label then\n                            M.Party.mousePosition = ptMember.label\n                        end\n                        if M.Party.selected ~= ptMember.label then\n                            M.Party.selected = ptMember.label\n                        end\n                    elseif M.Party.mousePosition ~= ptMember.label then\n                        d(\"[M]站位交换：\" .. M.Party.mousePosition .. \"<==>\" .. ptMember.label)\n                        local temp = M.Party[M.Party.mousePosition]\n                        M.Party[M.Party.mousePosition] = M.Party[ptMember.label]\n                        M.Party[ptMember.label] = temp\n\n                        -- 职能调整\n                        if M.Party[M.Party.mousePosition].id == M.GetPlayer().id then\n                            M.SelfPos = M.Party.mousePosition;\n                        elseif M.Party[ptMember.label].id == M.GetPlayer().id then\n                            M.SelfPos = ptMember.label;\n                        end\n\n                        M.Party.mousePosition = ptMember.label\n                        if M.Party.selected ~= ptMember.label then\n                            M.Party.selected = ptMember.label\n                        end\n                    end\n                end\n            end\n\n            if M.Party.mousePosition ~= nil and (GUI:IsMouseReleased(0) or not GUI:IsMouseDown(0)) then\n                M.Party.mousePosition = nil\n            end\n            if M.Party.selected ~= nil and (GUI:IsMouseReleased(0) or not GUI:IsMouseDown(0)) then\n                M.Party.selected = nil\n            end\n        end\n        GUI:ListBoxFooter()\n        if\n            M.Party.mousePosition ~= nil and\n            not GUI:IsItemHovered(\n                GUI.HoveredFlags_AllowWhenBlockedByPopup + GUI.HoveredFlags_AllowWhenBlockedByActiveItem +\n                GUI.HoveredFlags_AllowWhenOverlapped\n            )\n        then\n            M.Party.mousePosition = nil\n        end\n        GUI:Dummy(1, 1)\n        GUI:Text(\" \")\n        GUI:SameLine()\n        GUI:Button(\"绝伊甸设置\")\n        if GUI:IsItemClicked(0) then\n            M.ConfigFruInit = false\n            M.FruConfigUI.open = not M.FruConfigUI.open\n        end\n        local winPosx, winPosy = GUI:GetWindowPos();\n        M.FruConfigUI.x = winPosx + 350\n        M.FruConfigUI.y = winPosy\n\n        GUI:Dummy(1, 1)\n        GUI:Separator()\n        GUI:Dummy(1, 1)\n        if GUI:CollapsingHeader(\"调试工具\") then\n            GUI:SameLine()\n            GUI:TextColored(255, 0, 0, 1, \"[不知道做什么的千万别动！]\")\n            GUI:Text(\" \")\n            GUI:SameLine()\n            if not M.DebugMode then\n                GUI:PushItemWidth(25)\n                local value, changed = GUI:InputText(\"作为调试视角\", M.DebugPos, GUI.InputTextFlags_CharsNoBlank)\n                if changed then\n                    M.DebugPos = value\n                end\n                GUI:PopItemWidth()\n                GUI:SameLine()\n\n                GUI:Text(\"    \")\n                GUI:SameLine()\n                GUI:Button(\"设置调试视角\")\n                if GUI:IsItemClicked(0) then\n                    if not table.contains(M.JobPosName, M.DebugPos) then\n                        M.Info(\"填写有误!\")\n                        M.Debug(\"填写有误!\")\n                    else\n                        M.DebugMode = true\n                        M.GetSelfPos()\n                        M.Info(\"进入视角调试模式，当前视角：\" .. M.SelfPos)\n                    end\n                end\n            else\n                GUI:Button(\"取消调试视角\")\n                if GUI:IsItemClicked(0) then\n                    M.DebugMode = false\n                    M.GetSelfPos()\n                    M.Info(\"退出视角调试，视角还原到：\" .. M.SelfPos)\n                end\n            end\n            GUI:Text(\" \")\n            GUI:SameLine()\n            GUI:Button(\"快速销毁MuAiGuide\")\n            if GUI:IsItemClicked(0) then\n                MuAiGuide = nil\n            end\n        else\n            GUI:SameLine()\n            GUI:TextColored(255, 0, 0, 1, \"[不知道做什么的千万别动！]\")\n        end\n    end\n    M.SaveConfig()\n    GUI:SetWindowSize(350, 0)\n    GUI:End()\nend\nself.used = true\n",
						conditions = 
						{
							
							{
								"edc3f9f7-c453-c8a3-aac2-4dc7bff618a0",
								true,
							},
						},
						gVar = "ACR_TensorRequiem3_CD",
						name = "MainUI",
						uuid = "f0ae80bc-0294-7c5b-badb-3e34d31c5c23",
						version = 2.1,
					},
					inheritedIndex = 3,
				},
			},
			conditions = 
			{
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide ~= nil",
						name = "MuAiGuideIsInit",
						uuid = "edc3f9f7-c453-c8a3-aac2-4dc7bff618a0",
						version = 2,
					},
					inheritedIndex = 1,
				},
			},
			eventType = 13,
			name = "MuAiGuideUI",
			uuid = "198825bb-513f-1eb9-b0c3-20b8a87426f5",
			version = 2,
		},
		inheritedIndex = 5,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "-- 根据转圈来分析方向\nlocal drawTime = 30000\n--local BallState = nil\nif eventArgs.markerID == 156 or eventArgs.markerID == 157 then\n    data.AloaloLinkPlayers = nil\n    --d('火球出现！！！！！')\n    --d(eventArgs.markerID)\n\t--BallState = {}\n    -- 场地半径\n    local range = 19.5\n\n    -- 火球位置（场地中心）\n    local fireBallPos = TensorCore.mGetEntity(eventArgs.entityID).pos\n\n    -- 设指针球的位置是 ballPos\n    local ballPos\n    for _, ent in pairs(TensorCore.entityList(\"contentid=12507\")) do\n        ballPos = ent.pos\n        break\n    end\n\n    MuAiGuide.DrawCircleUI(fireBallPos.x, fireBallPos.y, 10000)\n\n    -- 球角度\n    local headingBall = TensorCore.getHeadingToTarget(fireBallPos, ballPos)\n\n    -- 球角度逆时针旋转15°即为目标颜色的正向\n    local targetBase = headingBall + math.pi / 12\n\n    -- 求出4个备选安全点\n     local aimPos4 = {}\n    for i = 1, 4 do\n        local heading = targetBase + math.pi / 2 * (i - 1)\n        local pos = TensorCore.getPosInDirection(fireBallPos, heading, range)\n        --table.insert(aimPos4, pos)\n        --MuAiGuide.DrawCircleUI(pos.x, pos.z, drawTime)\n        if  i % 2 == 0 then\n            MuAiGuide.DrawCircleUI(pos.x, pos.z, drawTime, 1, 0, 0, 0, 0.9, 0 )\n        else \n            MuAiGuide.DrawCircleUI(pos.x, pos.z, drawTime, 1, 255, 0, 0, 0.9, 0 )\n        end\n    end\n --[[ \n    -- 找到火球的一个圈\n    local model9020\n    for _, ent in pairs(TensorCore.entityList(\"model=9020\")) do\n        model9020 = ent\n        break\n    end\n    local headingFireBall = TensorCore.getHeadingToTarget(fireBallPos, model9020.pos)\n\n    local firePos = {}\n    table.insert(firePos, TensorCore.getPosInDirection(fireBallPos, headingFireBall, range))\n    table.insert(firePos, TensorCore.getPosInDirection(fireBallPos, headingFireBall + math.pi * 2 / 3, range))\n    table.insert(firePos, TensorCore.getPosInDirection(fireBallPos, headingFireBall - math.pi * 2 / 3, range))\n\n    local minDisSqr = math.huge\n    local point12\n    for _, a in ipairs(aimPos4) do\n        for _, b in ipairs(firePos) do\n            local dist = (a.x - b.x) ^ 2 + (a.z - b.z) ^ 2\n            if dist < minDisSqr then\n                minDisSqr = dist\n                point12 = a\n            end\n        end\n    end\n    local o2bh = TensorCore.getHeadingToTarget(fireBallPos, point12)\n    local guidePos1 = TensorCore.getPosInDirection(fireBallPos, o2bh + math.pi / 2, 19.5)\n    local guidePos2 = TensorCore.getPosInDirection(fireBallPos, o2bh - math.pi / 2, 19.5)\n\t\n\tMuAiGuide.DrawCircleUI(guidePos1.x, guidePos1.z , drawTime, 1, 0, 0, 0, 0.9, 0 ) \n\tMuAiGuide.DrawCircleUI(guidePos2.x, guidePos2.z , drawTime, 1, 0, 0, 0, 0.9, 0 ) \n\tMuAiGuide.DrawCircleUI(point12.x, point12.z , drawTime, 1, 255, 0, 0, 0.9, 0 ) \n\n\n   BallState.Standard12 = point12;\nelseif eventArgs.markerID == 97 and BallState then\n\tif\tBallState.MarkPlayers == nil then\n\t\tBallState.MarkPlayers = {}\n\tend\n\n    local p = TensorCore.mGetPlayer()\n    if #BallState.MarkPlayers < 2 then\n        table.insert(BallState.MarkPlayers, eventArgs.entityID)\n    end\n    if #BallState.MarkPlayers == 2 then\n        local o2bh = TensorCore.getHeadingToTarget(fireBallPos, BallState.Standard12)\n        local guidePos\n        -- 判断自己是否在这2个人里面\n        if table.contains(BallState.MarkPlayers, p.id) then\n            -- 判断是否是DPS\n            if MuAiGuide.IsDps(p.job) then\n                guidePos = TensorCore.getPosInDirection(fireBallPos, o2bh - math.pi / 2, 19.5)\n            else\n                guidePos = TensorCore.getPosInDirection(fireBallPos, o2bh + math.pi / 2, 19.5)\n            end\n        else\n            guidePos = BallState.Standard12\n        end\n\t\tBallState.MarkPlayers = {}\n        MuAiGuide.DirectTo(guidePos.x, guidePos.z, drawTime)\n    end\nend]]--\nend\nself.used = true",
						conditions = 
						{
							
							{
								"9c5f46ee-8155-c114-892c-f124c7b63815",
								true,
							},
						},
						gVar = "ACR_TensorReaper_AOE",
						name = "阿罗阿罗2转盘",
						uuid = "57ead78e-08cb-c312-8b10-598d9fceb159",
						version = 2.1,
					},
				},
			},
			conditions = 
			{
				
				{
					data = 
					{
						category = "Self",
						conditionType = 12,
						dequeueIfLuaFalse = true,
						localMapIDList = 
						{
							1179,
							1180,
						},
						name = "阿罗阿罗",
						uuid = "9c5f46ee-8155-c114-892c-f124c7b63815",
						version = 2,
					},
				},
			},
			enabled = false,
			eventType = 4,
			name = "AloaloAddMarker",
			uuid = "6e30e67e-07d4-96d5-924f-b0a285fdf586",
			version = 2,
		},
		inheritedIndex = 6,
	},
	
	{
		data = 
		{
			actions = 
			{
			},
			conditions = 
			{
			},
			name = "------------------------------",
			uuid = "65a5bfad-1c35-4e8f-8a45-9b2806c422c2",
			version = 2,
		},
		inheritedIndex = 7,
	},
	
	{
		data = 
		{
			name = "Gladiator",
			uuid = "26d09344-efff-4580-ba15-a23485ff39db",
			version = 2,
		},
		inheritedIndex = 8,
		inheritedObjectUUID = "c7a91848-de71-fc6c-85b5-5209d81c03d0",
		inheritedOverwrites = 
		{
		},
	},
	
	{
		data = 
		{
			name = "Channels",
			uuid = "4879662e-5208-a073-94bf-59ccaab426c4",
			version = 2,
		},
		inheritedObjectUUID = "91d05ec5-c53d-d2ac-a187-22b1c8e9323d",
		inheritedOverwrites = 
		{
			conditions = 
			{
				
				{
					position = 3,
					type = "add",
					value = 
					{
						data = 
						{
							name = "Aloalo Island",
							uuid = "e0b5a99e-4791-d7d4-8fa0-3ba1f56b9471",
							version = 2,
						},
						inheritedIndex = 3,
						inheritedObjectUUID = "6db5d64c-a95a-3787-8d2a-3cf42e2e92e9",
					},
				},
			},
		},
	}, 
	inheritedProfiles = 
	{
		"7_Bard_Fru_General",
	},
}



return tbl