local tbl = 
{
	[10] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "--[[\n    type : OnUpdate\n    time : -3.000\n    timeline : 34.9\n]]\nif TensorCore.isAnyEntityCasting(40154) then\n    data.MuAiGd_SinsmokeType = 1\nelseif TensorCore.isAnyEntityCasting(40155) then\n    data.MuAiGd_SinsmokeType = 2\nelse\n    data.MuAiGd_SinsmokeType = 0\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							name = "乐园绝技类型记录",
							uuid = "04d12805-bffa-03a0-be65-b0f7c452ee51",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 34.9,
				name = "[MuAiGuide]乐园绝技类型记录",
				timelineIndex = 10,
				timerOffset = -3,
				uuid = "493ecff4-3afc-467d-b8b3-b3da390f9c39",
				version = 2,
			},
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
							actionLua = "local M = MuAiGuide\nlocal drawTime = 11000\nif data.MuAiGd_SinsmokeIndex == nil then\n    data.MuAiGd_SinsmokeIndex = {}\n    -- 雾龙站位情况C开始逆时针一圈, 如果站位不同可以修改这里\n    data.MuAiGd_SinsmokeJobOrder = { \"H2\", \"D2\", \"D4\", \"ST\", \"MT\", \"D3\", \"H1\", \"D1\" }\n    data.MuAiGd_SinsmokeGuideFinish = false\n    M.Debug(\"================================== 雾龙计算开始 ====================================\")\nend\n\nif table.size(data.MuAiGd_SinsmokeIndex) < 3 then\n    -- 采集阶段\n    for _, ent in pairs(TensorCore.entityList(\"contentid=9708\")) do\n        if ent.action == 210 then\n            -- 抬手\n            local pos = M.GetDirectionIndex({ x = 100, z = 100 }, { x = ent.pos.x, z = ent.pos.z })\n            table.insert(data.MuAiGd_SinsmokeIndex, pos)\n            --如果是自己，那么自己往前走\n            local jobName = data.MuAiGd_SinsmokeJobOrder[pos]\n            if jobName then\n                if M.IsMeByPos(jobName) then\n                    -- 指路到前面(给对面的人看的)\n                    local pos1 = M.GetPointAtDistance({ x = 100, y = 0, z = 100 }, ent.pos, 10)\n                    M.DirectTo(pos1.x, pos1.z, 2000)\n                end\n            end\n        end\n    end\nend\n\nif table.size(data.MuAiGd_SinsmokeIndex) == 3\n    and data.MuAiGd_SinsmokeGuideFinish == false then\n   \n    local danger = {}\n    for i = 1, 3, 1 do\n        local pos = data.MuAiGd_SinsmokeIndex[i]\n        table.insert(danger, pos)\n        local opposite = pos + 4\n        if opposite > 8 then\n            opposite = opposite - 8\n        end\n        table.insert(danger, opposite)\n    end\n\n    local safeHeading\n    local selfOrder = M.IndexOf(data.MuAiGd_SinsmokeJobOrder, M.SelfPos)\n    for i = 1, 8, 1 do\n        if not table.contains(danger, i) then\n            if (selfOrder >= 5 and i >= 5) or (selfOrder <= 4 and i <= 4) then\n                safeHeading = (i - 1) * math.pi / 4\n            end\n        end\n    end\n\n    -- debug start\n    local msg = \"危险点\"\n    for i = 1, #danger do\n        msg = msg .. \", \" .. danger[i]\n    end\n    M.Debug(msg)\n    msg = \"本组安全区\" .. (safeHeading / math.pi)\n    M.Debug(msg)\n    local infoPoint = M.GetGamePointByHeading(M.Config.FruCfg.PosInfo, safeHeading)\n   \n    -- debug end\n\n    local targetPos\n    if data.MuAiGd_SinsmokeType == 1 then\n        --分摊\n        targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, safeHeading, 13)\n        M.Info(\"去\" .. infoPoint .. \"点，分摊。\")\n    elseif data.MuAiGd_SinsmokeType == 2 then\n        -- 按照如下站位进下的指路\n        --      H\n        -- 近   T   远\n        -- 如果站位不同，需要修改\n        if M.SelfPos == \"MT\" or M.SelfPos == \"ST\" then\n            targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, safeHeading, 19.5)\n        elseif M.SelfPos == \"H1\" or M.SelfPos == \"H2\" then\n            targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, safeHeading, 13)\n        elseif M.SelfPos == \"D1\" or M.SelfPos == \"D2\" then\n            targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, safeHeading - 0.105 * math.pi, 19.5)\n        elseif M.SelfPos == \"D3\" or M.SelfPos == \"D4\" then\n            targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, safeHeading + 0.105 * math.pi, 19.5)\n        end\n        M.Info(\"去\" .. infoPoint .. \"点，分散。\")\n    end\n\n    if table.contains(data.MuAiGd_SinsmokeIndex, selfOrder) then\n        M.DirectTo(targetPos.x, targetPos.z, 8000, 0.5, 2000)\n    else\n        M.DirectTo(targetPos.x, targetPos.z, drawTime)\n    end\n    data.MuAiGd_SinsmokeGuideFinish = true\n    M.Debug(\"================================== 雾龙计算结束 ====================================\")\nend\n\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							name = "雾龙",
							uuid = "a269d71a-373e-0a3d-a331-59aa86be5681",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 3,
				loop = true,
				mechanicTime = 34.9,
				name = "[MuAiGuide]雾龙",
				timeRange = true,
				timelineIndex = 10,
				timerEndOffset = 6,
				uuid = "a770ba4a-d4d6-5833-a9ee-63653f52b664",
				version = 2,
			},
			inheritedIndex = 2,
		},
	},
	[23] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local M = MuAiGuide\nif not data.MuAiGd_FallOfFaithInit then\n    M.Debug(\"============================== 雷火线点名指路 && 数据采集开始 ============================\")\n    data.MuAiGd_FallOfFaithInit = true\n    data.MuAiGd_FallOfFaithLink = {}\n    data.MuAiGd_FallOfFaithRest = {}\n    data.MuAiGd_FallOfFaithRecordIds = {}\n\n    -- 站位优先级\n    if M.Config.FruLightFirePriority and table.size(M.Config.FruLightFirePriority) == 8\n    then\n        data.MuAiGd_FallOfFaithOrder = M.Config.FruLightFirePriority\n    else\n        data.MuAiGd_FallOfFaithOrder = { \"H1\", \"H2\", \"MT\", \"ST\", \"D1\", \"D2\", \"D3\", \"D4\" }\n    end\n\n    -- AC方向站位 索引：优先级顺序\n    data.MuAiGd_FallOfFaithLinkLightingPos = {\n        { x = 100, z = 95 }, -- 上\n        { x = 100, z = 105 }, -- 下\n        { x = 100, z = 93 }, -- 最上\n        { x = 100, z = 107 }  -- 最下\n    }\n\n    data.MuAiGd_FallOfFaithLinkFirePos = {\n        { x = 100, z = 95.5 }, -- 上\n        { x = 100, z = 104.5 }, -- 下\n        { x = 100, z = 93 }, -- 最上\n        { x = 100, z = 107 }    -- 最下\n    }\n\n    data.MuAiGd_FallOfFaithRestLightingPos = {\n        { x = 97.8, z = 94.8 }, -- 左上\n        { x = 102.2, z = 94.8 }, -- 右上\n        { x = 97.8, z = 105.2 }, -- 左下\n        { x = 102.2, z = 105.2 } -- 右下\n    }\n\n    data.MuAiGd_FallOfFaithRestFirePos = {\n        { x = 100, z = 93 }, -- 上\n        { x = 100, z = 93 }, -- 上\n        { x = 100, z = 107 }, -- 下\n        { x = 100, z = 107 }, -- 下\n    }\n\n    data.MuAiGd_FallOfFaithLinkCnt = 0\n    data.MuAiGd_FallOfFaithRestCnt = 0\n    data.MuAiGd_FallOfFaithLinkSelfIndex = 0\n    data.MuAiGd_FallOfFaithRestSelfIndex = 0\nend\n\nif table.size(data.MuAiGd_FallOfFaithLink) < 4 then\n    for jobPos, ent in pairs(M.Party) do\n        local tethers = Argus.getTethersOnEnt(ent.id)\n        if tethers and not table.contains(data.MuAiGd_FallOfFaithRecordIds, ent.id) then\n            for _, tether in pairs(tethers) do\n                if tether.type == 31 or tether.type == 249 then\n                    data.MuAiGd_FallOfFaithLinkCnt = data.MuAiGd_FallOfFaithLinkCnt + 1\n                    M.Debug(\"获取到[\" .. jobPos .. \"]点名，连线[\" .. data.MuAiGd_FallOfFaithLinkCnt .. \"]\")\n                    local curRecord = {\n                        player = ent,\n                        jobStr = jobPos,\n                        tetherType = tether.type,\n                        orderIndex = data.MuAiGd_FallOfFaithLinkCnt\n                    }\n                    table.insert(data.MuAiGd_FallOfFaithLink, curRecord)\n                    table.insert(data.MuAiGd_FallOfFaithRecordIds, ent.id)\n                    if M.IsMe(ent) then\n                        local hitMsg = \"我被点名\"\n                        data.MuAiGd_FallOfFaithLinkSelfIndex = data.MuAiGd_FallOfFaithLinkCnt\n                        local pos\n                        if tether.type == 31 then\n                            hitMsg = hitMsg .. data.MuAiGd_FallOfFaithLinkSelfIndex .. \"号[雷]线连线了!<se.1>\"\n                            pos = data.MuAiGd_FallOfFaithLinkLightingPos[data.MuAiGd_FallOfFaithLinkCnt]\n                        else\n                            hitMsg = hitMsg .. data.MuAiGd_FallOfFaithLinkSelfIndex .. \"号[火]线连线了!<se.1>\"\n                            pos = data.MuAiGd_FallOfFaithLinkFirePos[data.MuAiGd_FallOfFaithLinkCnt]\n                        end\n                        local time = 8500 - (data.MuAiGd_FallOfFaithLinkSelfIndex - 1) * 1000\n                        M.Info(hitMsg)\n                        M.DirectTo(pos.x, pos.z, time, 0.3)\n                    end\n                end\n                break\n            end\n        end\n    end\n    -- 自己被点名，且4个连线人都计算完毕\n    if data.MuAiGd_FallOfFaithLinkSelfIndex > 0 and table.size(data.MuAiGd_FallOfFaithLink) >= 4 then\n        data.MuAiGd_FallOfFaithFinish = true\n        self.used = true\n        return\n    end\nelseif #data.MuAiGd_FallOfFaithRecordIds < 8 then\n    for jobPos, ent in pairs(M.Party) do\n        if not table.contains(data.MuAiGd_FallOfFaithRecordIds, ent.id) then\n            data.MuAiGd_FallOfFaithRest[jobPos] = ent\n            table.insert(data.MuAiGd_FallOfFaithRecordIds, ent.id)\n        end\n    end\n\n    for i = 1, #data.MuAiGd_FallOfFaithOrder, 1 do\n        local jobPos = data.MuAiGd_FallOfFaithOrder[i]\n        local curPlayer = data.MuAiGd_FallOfFaithRest[jobPos]\n        if curPlayer then\n            data.MuAiGd_FallOfFaithRestCnt = data.MuAiGd_FallOfFaithRestCnt + 1\n            if M.IsMe(curPlayer) then\n                data.MuAiGd_FallOfFaithRestSelfIndex = data.MuAiGd_FallOfFaithRestCnt\n                M.Info(\"没有连线，我是闲[\" .. data.MuAiGd_FallOfFaithRestSelfIndex .. \"]\")\n                break\n            end\n        end\n    end\n    if data.MuAiGd_FallOfFaithRestSelfIndex > 0 then\n        local lookAt\n        local guidePos\n        local guideTime = 4000\n        -- 判断观察哪个人\n        if data.MuAiGd_FallOfFaithRestSelfIndex == 1 or data.MuAiGd_FallOfFaithRestSelfIndex == 2 then\n            lookAt = data.MuAiGd_FallOfFaithLink[1]\n        elseif data.MuAiGd_FallOfFaithRestSelfIndex == 3 or data.MuAiGd_FallOfFaithRestSelfIndex == 4 then\n            guideTime = guideTime + 3000\n            lookAt = data.MuAiGd_FallOfFaithLink[2]\n        end\n        if lookAt.tetherType == 31 then\n            guidePos = data.MuAiGd_FallOfFaithRestLightingPos[data.MuAiGd_FallOfFaithRestSelfIndex];\n        elseif lookAt.tetherType == 249 then\n            guidePos = data.MuAiGd_FallOfFaithRestFirePos[data.MuAiGd_FallOfFaithRestSelfIndex];\n        end\n        if guidePos then\n            M.DirectTo(guidePos.x, guidePos.z, guideTime, 0.3)\n        end\n    end\n    data.MuAiGd_FallOfFaithFinish = true\n    M.Debug(\"============================== 雷火线第一波指路 && 数据采集结束 ============================\")\n    self.used = true\nend",
							gVar = "ACR_TensorRequiem3_CD",
							name = "雷火线",
							uuid = "cb4d3186-1db3-26fc-a335-6849aabc5b14",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				eventType = 3,
				mechanicTime = 101.5,
				name = "[MuAiGuide]雷火线指路",
				timeRange = true,
				timelineIndex = 23,
				timerEndOffset = 2,
				timerStartOffset = -10,
				uuid = "a0c28a22-b441-ab4d-9091-518ddd982c58",
				version = 2,
			},
			inheritedIndex = 1,
		},
	},
	[25] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guideTime = 5000\nlocal guidePos\nlocal link3 = data.MuAiGd_FallOfFaithLink[3] --3号点名人点名类型\nif data.MuAiGd_FallOfFaithLinkSelfIndex == 1 then\n    if link3.tetherType == 31 then\n        guidePos = data.MuAiGd_FallOfFaithLinkLightingPos[3]\n    elseif link3.tetherType == 249 then\n        guidePos = data.MuAiGd_FallOfFaithLinkFirePos[3]\n    end\nelseif data.MuAiGd_FallOfFaithLinkSelfIndex == 3 then\n    if link3.tetherType == 31 then\n        guidePos = data.MuAiGd_FallOfFaithLinkLightingPos[1]\n    elseif link3.tetherType == 249 then\n        guidePos = data.MuAiGd_FallOfFaithLinkFirePos[1]\n    end\nelseif data.MuAiGd_FallOfFaithRestSelfIndex == 1 or data.MuAiGd_FallOfFaithRestSelfIndex == 2 then\n    if link3.tetherType == 31 then\n        guidePos = data.MuAiGd_FallOfFaithRestLightingPos[data.MuAiGd_FallOfFaithRestSelfIndex]\n    elseif link3.tetherType == 249 then\n        guidePos = data.MuAiGd_FallOfFaithRestFirePos[data.MuAiGd_FallOfFaithRestSelfIndex]\n    end\nend\nif guidePos then\n    MuAiGuide.DirectTo(guidePos.x, guidePos.z, guideTime, 0.3)\nend\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							name = "1线判定时",
							uuid = "7885b479-a64c-7b9f-addb-4a7a79be5e38",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 105.8,
				name = "[MuAiGuide]1线判定时",
				timelineIndex = 25,
				uuid = "9921bbed-2733-1fc1-a87d-aafca3ba022f",
				version = 2,
			},
		},
	},
	[26] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guideTime = 5000\nlocal guidePos\nlocal link4 = data.MuAiGd_FallOfFaithLink[4]\nif data.MuAiGd_FallOfFaithLinkSelfIndex == 2 then\n    if link4.tetherType == 31 then\n        guidePos = data.MuAiGd_FallOfFaithLinkLightingPos[4]\n    elseif link4.tetherType == 249 then\n        guidePos = data.MuAiGd_FallOfFaithLinkFirePos[4]\n    end\nelseif data.MuAiGd_FallOfFaithLinkSelfIndex == 4 then\n    if link4.tetherType == 31 then\n        guidePos = data.MuAiGd_FallOfFaithLinkLightingPos[2]\n    elseif link4.tetherType == 249 then\n        guidePos = data.MuAiGd_FallOfFaithLinkFirePos[2]\n    end\nelseif data.MuAiGd_FallOfFaithRestSelfIndex == 3 or data.MuAiGd_FallOfFaithRestSelfIndex == 4 then\n    if link4.tetherType == 31 then\n        guidePos = data.MuAiGd_FallOfFaithRestLightingPos[data.MuAiGd_FallOfFaithRestSelfIndex]\n    elseif link4.tetherType == 249 then\n        guidePos = data.MuAiGd_FallOfFaithRestFirePos[data.MuAiGd_FallOfFaithRestSelfIndex]\n    end\nend\nif guidePos then\n    MuAiGuide.DirectTo(guidePos.x, guidePos.z, guideTime, 0.3)\nend\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							name = "2线判定时",
							uuid = "87225787-2685-738a-a067-607ec657a3d7",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 108.6,
				name = "[MuAiGuide]2线判定时",
				timelineIndex = 26,
				uuid = "ac601090-149e-77ff-8ce0-5e0b3819dfed",
				version = 2,
			},
		},
	},
	[44] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "--[[\n[MuAiGuide]DD冰花位置收集\n]]\nif data.MuAiGd_DiamondDustStartPoint == nil then\n    data.MuAiGd_DiamondDustStartPoint = {}\n    data.MuAiGd_DiamondDustNeedExChange = false\n    MuAiGuide.Debug(\"===================== DD冰花位置收集 =====================\")\nend\n\nif table.size(data.MuAiGd_DiamondDustStartPoint) < 2 then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=12809\")) do\n        local record = MuAiGuide.GetDirectionIndex({ x = 100, y = 0, z = 100 }, ent.pos)\n        if not table.contains(data.MuAiGd_DiamondDustStartPoint, record) and Argus.getEntityModel(ent.id) == 9020 then\n            table.insert(data.MuAiGd_DiamondDustStartPoint, record)\n            MuAiGuide.Debug(\"采集到冰花位置：\" .. record)\n        end\n    end\n    if table.size(data.MuAiGd_DiamondDustStartPoint) == 2 then\n        MuAiGuide.Debug(\"===================== DD冰花位置完毕 =====================\")\n        self.used = true\n    end\nend",
							gVar = "ACR_TensorRequiem3_CD",
							name = "DD冰花位置收集",
							uuid = "85ace7ef-3075-d8bb-bfda-911ecc57b160",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							uuid = "aab8371b-18ce-b33c-b503-a9218f25fe62",
							version = 2,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 235.3,
				name = "[MuAiGuide]DD冰花位置收集",
				timeRange = true,
				timelineIndex = 44,
				timerEndOffset = 10,
				uuid = "587987fc-c74a-cfc8-b342-8ee518cdba34",
				version = 2,
			},
			inheritedIndex = 1,
		},
	},
	[46] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "--[MuAiGuide]DD冰花点名出现\n-- 需要添加ID采集逻辑\nif data.MuAiGd_DiamondDustTarget == nil then\n    d(\"[MuAiGuide] ===================== DD冰花位置收集 && DD 指路1 =====================\")\n    data.MuAiGd_DiamondDustTarget = {}\n    -- C逆\n    data.MuAiGd_DiamondDustJobPos = { \"H2\", \"D2\", \"ST\", \"D4\", \"MT\", \"D3\", \"H1\", \"D1\" }\n    data.MuAiGd_DiamondDustSelfGuideDir = 0\n    ---  DD中的1情况  1： 钢铁冰花，2：钢铁水波，3：月环冰花，4：月环水波\n    data.MuAiGd_DiamondDustSelfGuideType = 0\nend\n\n\nif table.size(data.MuAiGd_DiamondDustTarget) < 4 then\n    for jobPos, player in pairs(MuAiGuide.Party) do\n        if player.id == eventArgs.entityID then\n            table.insert(data.MuAiGd_DiamondDustTarget, MuAiGuide.IndexOf(data.MuAiGd_DiamondDustJobPos, jobPos))\n            break\n        end\n    end\n    if table.size(data.MuAiGd_DiamondDustTarget) == 4 then\n        d(\"点名情况:\")\n        d(data.MuAiGd_DiamondDustTarget)\n        -- 如果点名人的站位序列和初次出现的2个冰花存在重合, 则需要换位\n        for i = 1, #data.MuAiGd_DiamondDustTarget do\n            for j = 1, #data.MuAiGd_DiamondDustStartPoint do\n                if data.MuAiGd_DiamondDustStartPoint[j] == data.MuAiGd_DiamondDustTarget[i] then\n                    data.MuAiGd_DiamondDustNeedExChange = true\n                    SendTextCommand(\"/e 点名位置和第一组冰花重合，需要换位<se.1>\")\n                    break\n                end\n            end\n        end\n        \n        -- 计算指路方位\n        local selfBaseDir = MuAiGuide.IndexOf(data.MuAiGd_DiamondDustJobPos, MuAiGuide.SelfPos)\n        if data.MuAiGd_DiamondDustNeedExChange then\n            if MuAiGuide.IsDps(MuAiGuide.GetPlayer().job) then\n                data.MuAiGd_DiamondDustSelfGuideDir = selfBaseDir - 1\n            else\n                data.MuAiGd_DiamondDustSelfGuideDir = selfBaseDir + 1\n            end\n            if data.MuAiGd_DiamondDustSelfGuideDir > 8 then\n                data.MuAiGd_DiamondDustSelfGuideDir = data.MuAiGd_DiamondDustSelfGuideDir - 8\n            elseif data.MuAiGd_DiamondDustSelfGuideDir < 0 then\n                data.MuAiGd_DiamondDustSelfGuideDir = data.MuAiGd_DiamondDustSelfGuideDir + 8\n            end\n        else\n            data.MuAiGd_DiamondDustSelfGuideDir = selfBaseDir\n        end\n\n        -- 指路时间\n        -- 钢铁时间\n        local timeAimFar = 7000 -- 冰花人： 直接指过去，呆着\n        local timeFar = 5000 -- 无冰花人： 指过去，等钢/月判定后立刻回中，当前脚本仅指路第一阶段\n        -- 月环时间\n        local timeAimNear = 5000 -- 冰花人 指路到 钢/月判定\n        local timeNear = 5000 --没冰花人，呆着\n        \n        local guideTime\n        local guideDistance\n        if TensorCore.isAnyEntityCasting(40203) then\n            data.MuAiGd_DiamondDustStandType = 1 --月环\n            -- 冰花点名\n            if table.contains(data.MuAiGd_DiamondDustTarget, selfBaseDir) then\n                guideTime = timeAimNear\n                guideDistance = 3.7\n                data.MuAiGd_DiamondDustSelfGuideType = 3 --月环冰花\n            else\n                guideTime = timeNear\n                guideDistance = 1.5\n                data.MuAiGd_DiamondDustSelfGuideType = 4 --月环水波\n            end\n        elseif TensorCore.isAnyEntityCasting(40202) then\n            data.MuAiGd_DiamondDustStandType = 2 --钢铁\n            -- 冰花点名\n            if table.contains(data.MuAiGd_DiamondDustTarget, selfBaseDir) then\n                guideTime = timeAimFar\n                guideDistance = 19.7\n                data.MuAiGd_DiamondDustSelfGuideType = 1 --钢铁冰花\n            else\n                guideTime = timeFar\n                guideDistance = 16.5\n                data.MuAiGd_DiamondDustSelfGuideType = 2 --钢铁水波\n            end\n        end\n        \n        local guidePos = TensorCore.getPosInDirection(\n            { x = 100, y = 0, z = 100 },\n            (data.MuAiGd_DiamondDustSelfGuideDir - 1) * math.pi / 4,\n            guideDistance)\n        MuAiGuide.DirectTo(guidePos.x, guidePos.z, guideTime, 0.3)\n        d(\"[MuAiGuide] ===================== DD冰花位置收集 && DD 指路1 结束 =====================\")\n        self.used = true\n    end\nend",
							gVar = "ACR_TensorRequiem3_CD",
							name = "DD冰花点名出现",
							uuid = "46ad7d13-8ea9-7dc2-9961-c4c02b5e49c6",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							eventArgType = 2,
							eventMarkerID = 345,
							uuid = "fdc8e6c3-5795-8e23-b268-c66c76d51218",
							version = 2,
						},
					},
				},
				eventType = 4,
				mechanicTime = 244.5,
				name = "[MuAiGuide]DD冰花点名出现",
				timeRange = true,
				timelineIndex = 46,
				timerEndOffset = 1,
				timerStartOffset = -10,
				uuid = "9ad98f8f-bf9d-e4ea-91d0-2394f92a6cd1",
				version = 2,
			},
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
							actionLua = "-- 钢铁月环判定瞬间\n-- 指路到场中，然后再指路到击退位置\nlocal selfDir = MuAiGuide.IndexOf(data.MuAiGd_DiamondDustJobPos, MuAiGuide.SelfPos)\nlocal selfSafe\nfor i = 1, #data.MuAiGd_DiamondDustStartPoint do\n    if (selfDir <= 4 and data.MuAiGd_DiamondDustStartPoint[i] <= 4) or\n        (selfDir >= 5 and data.MuAiGd_DiamondDustStartPoint[i] >= 5)\n    then\n        selfSafe = data.MuAiGd_DiamondDustStartPoint[i]\n        break\n    end\nend\n-- 击退站位点\ndata.MuAiGd_DiamondDustKnockBackPos = TensorCore.getPosInDirection(\n    { x = 100, y = 0, z = 100 },\n    (selfSafe - 1) * math.pi / 4,\n    2)\n\n-- 1： 钢铁冰花，2：钢铁水波，3：月环冰花，4：月环水波\n--[[if data.MuAiGd_DiamondDustSelfGuideType == 1 then\n    -- 不动\nelse]]\nif data.MuAiGd_DiamondDustSelfGuideType == 2 then\n    -- 立刻回中 大约2500后前往击退位置\n    MuAiGuide.DirectTo(100, 100, 2500)\n    MuAiGuide.DirectTo(data.MuAiGd_DiamondDustKnockBackPos.x, data.MuAiGd_DiamondDustKnockBackPos.z, 2500, 0.5, 4000)\nelseif data.MuAiGd_DiamondDustSelfGuideType == 3 then\n    -- 立刻放冰花\n    local heading = (data.MuAiGd_DiamondDustSelfGuideDir - 1) * math.pi / 4\n    local placePos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 8)\n    MuAiGuide.DirectTo(placePos.x, placePos.z, 2500)\nelseif data.MuAiGd_DiamondDustSelfGuideType == 4 then\n    -- 指路到击退位置\n    MuAiGuide.DirectTo(data.MuAiGd_DiamondDustKnockBackPos.x, data.MuAiGd_DiamondDustKnockBackPos.z, 4000, 0.5, 2500)\nend\n\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							name = "钢铁月环判定",
							uuid = "517c22b7-5ed6-68ed-8b9a-a4b3094ec9e8",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 244.5,
				name = "[MuAiGuide]钢铁月环判定",
				timelineIndex = 46,
				uuid = "4bc492bd-4296-ab6d-92f7-5544ae806ce4",
				version = 2,
			},
		},
	},
	[48] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- 1： 钢铁冰花，2：钢铁水波，3：月环冰花，4：月环水波\nd(data.MuAiGd_DiamondDustSelfGuideType)\nd(data.MuAiGd_DiamondDustKnockBackPos)\nif data.MuAiGd_DiamondDustSelfGuideType == 1 then\n    -- 立刻回中 大约2500后前往击退位置\n    MuAiGuide.DirectTo(100, 100, 2500)\n    MuAiGuide.DirectTo(data.MuAiGd_DiamondDustKnockBackPos.x, data.MuAiGd_DiamondDustKnockBackPos.z, 2500, 0.5, 2500)\nelseif data.MuAiGd_DiamondDustSelfGuideType == 2 then\n    -- 不管\nelseif data.MuAiGd_DiamondDustSelfGuideType == 3 then\n    -- 场中指路1秒 后 指路到击退位置\n    MuAiGuide.DirectTo(100, 100, 1000)\n    MuAiGuide.DirectTo(data.MuAiGd_DiamondDustKnockBackPos.x, data.MuAiGd_DiamondDustKnockBackPos.z, 2500, 0.5, 1000)\nelseif data.MuAiGd_DiamondDustSelfGuideType == 4 then\n    -- 不管\nend\n\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							name = "冰花判定",
							uuid = "69b5a33f-1c45-10cd-8690-7e3a3b3525ad",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 246.7,
				name = "[MuAiGuide]冰花判定",
				timelineIndex = 48,
				uuid = "cf4c653a-84ec-9cfb-a039-eb43c1965127",
				version = 2,
			},
		},
	},
	[60] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "SendTextCommand(\"/e <se.3>剑技即将发出:[2]\" )\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "7d3d9c00-403d-4acc-9de0-007a94dbaa24",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 270.3,
				name = "[滑冰噪音]倒计时2",
				timelineIndex = 60,
				timerOffset = -2,
				uuid = "077b8e40-875a-8df6-88a6-bd2673465f9e",
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
							actionLua = "SendTextCommand(\"/e <se.3>剑技即将发出:[1]\" )\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "513f77e2-ddaa-dd5b-ab49-946fcd9a47f6",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 270.3,
				name = "[滑冰噪音]倒计时1",
				timelineIndex = 60,
				timerOffset = -1,
				uuid = "dbf87455-3248-664c-abfc-e3b9eaf40ee9",
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
							actionLua = "SendTextCommand(\"/e <se.3>剑技即将发出:[3]\" )\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "d1150595-03f0-9ffb-9efb-e9dcc70841ae",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 270.3,
				name = "[滑冰噪音]倒计时3",
				timelineIndex = 60,
				timerOffset = -3,
				uuid = "699198ee-ea0e-01a0-ac6e-b5a6d1d40274",
				version = 2,
			},
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
							actionLua = "SendTextCommand(\"/e <se.1><se.1><se.1>剑技已经发出，快滑冰！\" )\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "a3ccb272-4541-3e6b-a06c-ac9dbcc993cf",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 270.3,
				name = "[滑冰噪音]走走走",
				timelineIndex = 60,
				timerOffset = -0.10000000149012,
				uuid = "0e0126fd-ce97-175a-8046-2a02145c37a7",
				version = 2,
			},
		},
	},
	[80] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guideTime = 5000\n-- C开始逆时针一周站位\nlocal posOrder = { \"D3\", \"D4\", \"H2\", \"H1\", \"ST\", \"MT\", \"D1\", \"D2\" }\nlocal selfIndex = MuAiGuide.IndexOf(posOrder, MuAiGuide.SelfPos)\nlocal heading = (selfIndex - 1) * math.pi / 4 + math.pi / 8\nlocal targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 8)\nMuAiGuide.DirectTo(targetPos.x, targetPos.z, guideTime)\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							name = "MGL光暴-预站位",
							uuid = "2e6576e5-8d1c-70dc-a78e-692bd7a9da41",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 331.8,
				name = "[MuAiGuide]MGL光暴-预站位",
				timelineIndex = 80,
				timerOffset = -5,
				uuid = "38b9f6af-b0a3-156e-a702-5c7db4f787b1",
				version = 2,
			},
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
							actionLua = "local guideTime = 9000\nlocal buffId = 4157\nlocal M = MuAiGuide\nlocal linkBuff = TensorCore.getBuff(M.GetPlayer().id, buffId)\n\n-- 计算是否有线（是否有线BUFF）\nif linkBuff ~= nil then\n    --连线定名\n    local TGroup = { \"MT\", \"ST\", \"H1\", \"H2\" }\n    local DGroup = { \"D1\", \"D2\", \"D3\", \"D4\" }\n    local selfLinkOrder = 0 --计算自己是第几个有线\n    local targetHeading = 0\n    if table.contains(TGroup, M.SelfPos) then\n        local index = M.IndexOf(TGroup, M.SelfPos)\n        for i = 1, index do\n            local curPlayer = M.Party[TGroup[i]]\n            if TensorCore.getBuff(curPlayer.id, buffId) then\n                selfLinkOrder = selfLinkOrder + 1\n            end\n        end\n        if selfLinkOrder == 1 then\n            targetHeading = math.pi * 4 / 3\n            M.Info(\"我是上1，去左上。\")\n        elseif selfLinkOrder == 2 then\n            M.Info(\"我是上2，去下。\")\n            targetHeading = 0\n        elseif selfLinkOrder == 3 then\n            M.Info(\"我是上3，去右上。\")\n            targetHeading = math.pi * 2 / 3\n        elseif selfLinkOrder == 4 then\n            M.Info(\"我是上4，需要补位去左下。\")\n            targetHeading = math.pi * 5 / 3\n        end\n    elseif table.contains(DGroup, M.SelfPos) then\n        local index = M.IndexOf(DGroup, M.SelfPos)\n        for i = 1, index do\n            local curPlayer = M.Party[DGroup[i]]\n            if TensorCore.getBuff(curPlayer.id, buffId) then\n                selfLinkOrder = selfLinkOrder + 1\n            end\n        end\n        if selfLinkOrder == 1 then\n            M.Info(\"我是下1，去右下。\")\n            targetHeading = math.pi / 3\n        elseif selfLinkOrder == 2 then\n            M.Info(\"我是下2，去上。\")\n            targetHeading = math.pi\n        elseif selfLinkOrder == 3 then\n            M.Info(\"我是下3，去左下。\")\n            targetHeading = math.pi * 5 / 3\n        elseif selfLinkOrder == 4 then\n            targetHeading = math.pi * 2 / 3\n            M.Info(\"我是下4，需要补位去右上。\")\n        end\n    end\n    local targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, targetHeading, 18)\n    M.DirectTo(targetPos.x, targetPos.z, guideTime)\nelse\n    M.Info(\"被点名了，放五个圈。\")\n    local guideTime2 = 16000\n    local fromA = {\n        { x = 100,   z = 92 },\n        { x = 106.1, z = 94.8 },\n        { x = 109,   z = 100.77 },\n        { x = 108,   z = 107.3 },\n        { x = 106,   z = 113.6 },\n    }\n    local fromC = {\n        { x = 100,  z = 108 },\n        { x = 93.9, z = 105.2 },\n        { x = 91,   z = 99.23 },\n        { x = 92,   z = 92.7 },\n        { x = 94,   z = 86.4 },\n    }\n    local draw = function(points)\n        for i = 1, #points do\n            local curPos = points[i]\n            local size = 0.5\n            M.DrawCircleUI(curPos.x, curPos.z, guideTime2, 0.5, 0, 255, 0, 0.7)\n            if i > 1 then\n                local lastPos = points[i - 1]\n                local heading = TensorCore.getHeadingToTarget(lastPos, curPos)\n                local length = TensorCore.getDistance2d(lastPos, curPos)\n                local pos = TensorCore.getPosInDirection(lastPos, heading, size + 0.1)\n                Argus2.addTimedArrowFilled(\n                    guideTime2,\n                    pos.x,\n                    0,\n                    pos.z,\n                    length - size * 2 - 1 - 0.2,\n                    size / 5 * 2,\n                    1,\n                    0.25,\n                    heading,\n                    GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 255 / 255, 0.7),\n                    GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 255 / 255, 0.7),\n                    GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 255 / 255, 0.7),\n                    0,\n                    nil,\n                    nil,\n                    GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1),\n                    1.0,\n                    3,\n                    0.05,\n                    true\n                )\n            end\n        end\n    end\n    draw(fromA)\n    draw(fromC)\nend\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							name = "MGL光暴-线分析&指路",
							uuid = "63c0bd19-de44-6780-822c-251564f6c733",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 331.8,
				name = "[MuAiGuide]MGL光暴-线分析&指路",
				timelineIndex = 80,
				timerOffset = 1,
				uuid = "df04ad36-0dec-a5b8-86b0-2187c689b527",
				version = 2,
			},
		},
	},
	[123] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local player = MuAiGuide.GetPlayer()\n--- { 长:1 | 中:2 | 短:3 | 冰:4 }\ndata.MuAiGd_P3_1_type = 0\nlocal fire = TensorCore.getBuff(player.id, 2455)\nif fire then\n    -- 长火\n    if fire.duration > 22 then\n        data.MuAiGd_P3_1_type = 1\n        MuAiGuide.Info(\"我的BUFF是长火。\")\n    elseif fire.duration > 12 then\n        -- 中火\n        data.MuAiGd_P3_1_type = 2\n        MuAiGuide.Info(\"我的BUFF是中火。\")\n    else\n        -- 短火\n        data.MuAiGd_P3_1_type = 3\n        MuAiGuide.Info(\"我的BUFF是短火。\")\n    end\n    self.used = true\n    MuAiGuide.Debug(\"P3一运buff分析: TYPE = \" .. data.MuAiGd_P3_1_type)\nelseif TensorCore.getBuff(player.id, 2462) then\n    data.MuAiGd_P3_1_type = 4\n    if MuAiGuide.IsDps(player.job) then\n        MuAiGuide.Info(\"我的BUFF是冰，当做长火处理！\")\n    else\n        MuAiGuide.Info(\"我的BUFF是冰，当做短火处理！\")\n    end\n    self.used = true\n    MuAiGuide.Debug(\"P3一运buff分析: TYPE = \" .. data.MuAiGd_P3_1_type)\nend",
							gVar = "ACR_TensorRequiem3_CD",
							name = "GetBuffType",
							uuid = "0e69975b-9346-5907-9e56-c896f3e74abf",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				eventType = 3,
				mechanicTime = 532.4,
				name = "[MuAiGuide]获取BUFF类型",
				randomOffset = 1,
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 10,
				timerOffset = -2,
				timerStartOffset = -2,
				uuid = "03cb0846-6dad-e0e9-9b8e-21798892978d",
				version = 2,
			},
			inheritedIndex = 1,
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
							actionLua = "local M = MuAiGuide\nif data.MuAiGd_P3_1_Lights == nil then\n    data.MuAiGd_P3_1_Lights = {}\n    data.MuGuide_GetDirType = function(fire)\n        if fire == nil then\n            return 4\n        end\n        if fire then\n            -- 长火\n            if fire.duration > 22 then\n                return 1\n            elseif fire.duration > 12 then\n                -- 中火\n                return 2\n            else\n                -- 短火\n                return 3\n            end\n        end\n    end\n    M.Debug(\"===================== P3一运查找关键灯-开始 =====================\")\nend\n\n-- 采集灯\nif table.size(data.MuAiGd_P3_1_Lights) < 8 then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=9825\")) do\n        if Argus.getEntityModel(ent.id) == 17832 then\n            local curHeading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, ent.pos)\n            data.MuAiGd_P3_1_Lights[ent.id] = { entity = ent, heading = curHeading }\n        end\n    end\nend\n\n--获取12点\nif table.size(data.MuAiGd_P3_1_Lights) == 8 and data.MuAiGd_P3_1_Clock12 == nil then\n    local yellowLineInfo = {}\n    for _, info in pairs(data.MuAiGd_P3_1_Lights) do\n        local lines = Argus.getTethersOnEnt(info.entity.id)\n        for _, line in pairs(lines) do\n            if line.type == 134 then\n                table.insert(yellowLineInfo, info)\n                break\n            end\n        end\n    end\n    if table.size(yellowLineInfo) > 0 then\n        M.Debug(\"连线灯分析完毕，开始查找12点！\")\n        local not12 = {}\n        for i = 1, #yellowLineInfo do\n            for j = i + 1, #yellowLineInfo do\n                local diff = math.abs(yellowLineInfo[i].heading - yellowLineInfo[j].heading)\n                if diff > math.pi then\n                    diff = diff - math.pi\n                end\n                --近似互为直角\n                if M.IsSame(diff, math.pi / 2) then\n                    table.insert(not12, i)\n                    table.insert(not12, j)\n                    break\n                end\n            end\n            if table.size(not12) == 2 then\n                break\n            end\n        end\n        for i = 1, #yellowLineInfo do\n            if not table.contains(not12, i) then\n                data.MuAiGd_P3_1_Clock12 = yellowLineInfo[i]\n                if M.Config.LogToEchoMsg then\n                    local infoPoint = M.GetGamePointByHeading(M.Config.FruCfg.PosInfo, data.MuAiGd_P3_1_Clock12.heading)\n                    M.Info(\"当前12点为：\" .. infoPoint .. \"点\")\n                end\n                break\n            end\n        end\n        if data.MuAiGd_P3_1_Clock12 ~= nil then\n            if not M.Config.AnyOneReactionOn then\n                TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, .25), 2)\n                    :addTimedArrow(40000, 100, 0, 100, data.MuAiGd_P3_1_Clock12.heading, 6, 2, 4, 4, 0, false)\n            end\n            local type = data.MuAiGd_P3_1_type\n            local dir\n            if M.IsDps(M.GetPlayer().job) then\n                if type == 1 or type == 4 then\n                    dir = 0\n                elseif type == 2 then\n                    dir = -math.pi / 2\n                else\n                    for jobName, ptMember in pairs(M.Party) do\n                        --找到另外一个短火的人\n                        if M.IsDps(ptMember.job) and not M.IsMe(ptMember) then\n                            local fireOther = TensorCore.getBuff(ptMember.id, 2455);\n                            if fireOther and data.MuGuide_GetDirType(fireOther) == 3 then\n                                -- 找到了 开始判断优先级\n                                local selfOrder = M.IndexOf(M.JobPosName, M.SelfPos)\n                                local otherOrder = M.IndexOf(M.JobPosName, jobName)\n                                if selfOrder < otherOrder then\n                                    -- 索引小的优先\n                                    dir = math.pi / 4\n                                    M.Info(\"我是高优先级短火。\")\n                                else\n                                    dir = -math.pi / 4\n                                    M.Info(\"我是低优先级短火。\")\n                                end\n                            end\n                        end\n                    end\n                end\n            else\n                if type == 1 then\n                    for jobName, ptMember in pairs(M.Party) do\n                        --找到另外一个短火的人\n                        if not M.IsDps(M.GetPlayer().job) and not M.IsMe(ptMember) then\n                            local fireOther = TensorCore.getBuff(ptMember.id, 2455);\n                            if fireOther and data.MuGuide_GetDirType(fireOther) == 1 then\n                                -- 找到了 开始判断优先级\n                                local selfOrder = M.IndexOf(M.JobPosName, M.SelfPos)\n                                local otherOrder = M.IndexOf(M.JobPosName, jobName)\n                                if selfOrder < otherOrder then\n                                    -- 索引小的优先\n                                    dir = 3 / 4 * math.pi\n                                    M.Info(\"我是高优先级长火。\")\n                                else\n                                    dir = -3 / 4 * math.pi\n                                    M.Info(\"我是高优先级长火。\")\n                                end\n                            end\n                        end\n                    end\n                elseif type == 2 then\n                    dir = math.pi / 2\n                else\n                    dir = math.pi\n                end\n            end\n            local finalDir = data.MuAiGd_P3_1_Clock12.heading + dir\n            if finalDir > math.pi * 2 then\n                finalDir = finalDir - math.pi * 2\n            elseif finalDir < 0 then\n                finalDir = finalDir + math.pi * 2\n            end\n            for _, light in pairs(data.MuAiGd_P3_1_Lights) do\n                if M.IsSame(light.heading, finalDir) then\n                    data.MuAiGd_SelfLight = light\n                    break\n                end\n            end\n            M.Debug(\"最终方向\" .. (finalDir / math.pi))\n            TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, .25), 2)\n                :addTimedArrow(40000, 100, 0, 100, data.MuAiGd_SelfLight.heading, 15, 1, 2, 2, 0, false)\n            if M.Config.LogToEchoMsg then\n                local infoPoint = M.GetGamePointByHeading(M.Config.FruCfg.PosInfo, finalDir)\n                M.Info(\"机制处理方向：\" .. infoPoint .. \"点。\")\n            end\n            M.Debug(\"===================== P3一运查找关键灯-结束 =====================\")\n            self.used = true\n        end\n    end\nend",
							conditions = 
							{
								
								{
									"9609cce8-5dd2-599e-902b-0b50dcff7b7c",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							name = "查找关键灯",
							uuid = "c25a8b75-f300-1a72-9e0d-84f923e6cd97",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.MuAiGd_P3_1_type ~= nil and data.MuAiGd_P3_1_type > 0",
							name = "已读取到当前BUFF类型",
							uuid = "9609cce8-5dd2-599e-902b-0b50dcff7b7c",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 532.4,
				name = "[MuAiGuide]查找关键灯",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 6,
				timerStartOffset = -1,
				uuid = "25b1fa05-3be0-87f3-a68f-dd660934ad10",
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
							actionLua = "local guideTime = 6000\nlocal M = MuAiGuide\nif data.MuAiGd_RelativityFlag == nil then\n    data.MuAiGd_RelativityFlag = {\n        StartPos = false,\n        Fire = false,\n        Fire2 = false,\n        Delay = false,\n        ReturnBuff = false,\n        Converge = false,\n        Ice = false,\n        Turing = false,\n        TuringBack = false,\n        EndGuide = false\n    }\n    data.MuAiGd_P3_BackCenter = function()\n        if data.MuAiGd_P3_CenterPos == nil then\n            data.MuAiGd_P3_CenterPos = TensorCore.getPosInDirection({ x = 100, 0, z = 100 },\n                data.MuAiGd_SelfLight.heading, 1)\n        end\n        local targetPos = data.MuAiGd_P3_CenterPos\n        M.DirectTo(targetPos.x, targetPos.z, guideTime, 0.3)\n    end\nend\n-- 火\nlocal fire = TensorCore.getBuff(M.GetPlayer().id, 2455)\n-- 冰\nlocal ice = TensorCore.getBuff(M.GetPlayer().id, 2462)\n-- 分摊\nlocal converge = TensorCore.getBuff(M.GetPlayer().id, 2454)\n-- 回返（未放置）\nlocal delay = TensorCore.getBuff(M.GetPlayer().id, 2464)\n-- 暗焰\nlocal darkFlame = TensorCore.getBuff(M.GetPlayer().id, 2460)\n-- 回返（放置）\nlocal returnBuff = TensorCore.getBuff(M.GetPlayer().id, 2452)\n\n-- 初始位置\nif not data.MuAiGd_RelativityFlag.StartPos and (fire or ice) then\n    if data.MuAiGd_P3_1_type == 3 then\n        local targetPos = TensorCore.getPosInDirection({ x = 100, 0, z = 100 }, data.MuAiGd_SelfLight.heading, 15.5)\n        M.DirectTo(targetPos.x, targetPos.z, guideTime)\n    else\n        data.MuAiGd_P3_BackCenter()\n    end\n    data.MuAiGd_RelativityFlag.StartPos = true\nend\n\n-- 火BUFF\nif not data.MuAiGd_RelativityFlag.Fire and fire then\n    if data.MuAiGd_P3_1_type == 3 then\n        data.MuAiGd_RelativityFlag.Fire = true\n    elseif fire.duration < 5.1 then\n        local targetPos = TensorCore.getPosInDirection({ x = 100, 0, z = 100 }, data.MuAiGd_SelfLight.heading, 15.5)\n        M.DirectTo(targetPos.x, targetPos.z, guideTime)\n        data.MuAiGd_RelativityFlag.Fire = true\n        M.Info(\"火BUFF即将判定，去场外！\")\n    end\nend\n\nif data.MuAiGd_P3_1_type == 2 or data.MuAiGd_P3_1_type == 3 then\n    if not data.MuAiGd_RelativityFlag.Fire2 and (not fire or fire.duration < 0.1) then\n        data.MuAiGd_P3_BackCenter()\n        M.Info(\"火BUFF放置完毕，回场中。\")\n\t\tdata.MuAiGd_RelativityFlag.Fire2 = true\n    end\nend\n\n-- 回返\nif not data.MuAiGd_RelativityFlag.Delay and delay then\n    if delay.duration < 5.1 then\n        if darkFlame == nil then\n            targetPos = TensorCore.getPosInDirection({ x = 100, 0, z = 100 }, data.MuAiGd_SelfLight.heading, 1)\n            M.Info(\"场中放置回返。\")\n        else\n            targetPos = data.MuAiGd_SelfLight.entity.pos\n            M.Info(\"灯下放置回返。\")\n        end\n        data.MuAiGd_RelativityFlag.Delay = true\n        M.DirectTo(targetPos.x, targetPos.z, guideTime, 0.3)\n    end\nend\n\n-- 放完回返\nif not data.MuAiGd_RelativityFlag.ReturnBuff and returnBuff then\n    data.MuAiGd_RelativityFlag.ReturnBuff = true\n    if not fire or fire.duration >= 10 then\n        M.Info(\"回返放完了，回场中。\")\n        data.MuAiGd_P3_BackCenter()\n    end\nend\n\n-- 分摊\nif not data.MuAiGd_RelativityFlag.Converge and converge then\n    if converge.duration < 5.1 then\n        data.MuAiGd_P3_BackCenter()\n        M.Info(\"分摊，回场中。\")\n        data.MuAiGd_RelativityFlag.Converge = true\n    end\nend\n\n-- 冰\nif not data.MuAiGd_RelativityFlag.Ice and ice then\n    if ice.duration < 5.1 then\n        data.MuAiGd_P3_BackCenter()\n        M.Info(\"冰，回场中。\")\n        data.MuAiGd_RelativityFlag.Ice = true\n    end\nend\n\n-- 终点\nif not data.MuAiGd_RelativityFlag.EndGuide and returnBuff then\n    if returnBuff.duration < 1 then\n        local targetPos = TensorCore.getPosInDirection({ x = 100, 0, z = 100 }, data.MuAiGd_SelfLight.heading, 1)\n        MuAiGuide.DirectTo(targetPos.x, targetPos.z, 10000)\n        data.MuAiGd_RelativityFlag.EndGuide = true\n        M.Info(\"全BUFF处理完毕，回场中等待分摊！\")\n        self.used = true\n    end\nend\n\n-- 灯开始转了\n-- 黄/顺\nif not data.MuAiGd_RelativityFlag.Turing then\n    local turing = TensorCore.getBuff(data.MuAiGd_SelfLight.entity.id, 2970)\n    if turing and turing.duration > 0 then\n        local posDir\n        if turing.stacks == 269 then\n            M.Info(\"引导逆时针的灯!\")\n            posDir = data.MuAiGd_SelfLight.heading - 7 / 18 * math.pi;\n        elseif turing.stacks == 348 then\n            M.Info(\"引导顺时针的灯!\")\n            posDir = data.MuAiGd_SelfLight.heading + 7 / 18 * math.pi;\n        end\n        local pos = data.MuAiGd_SelfLight.entity.pos\n        if not M.Config.AnyOneReactionOn then\n            Argus2.addTimedArrowFilled(\n                guideTime,\n                pos.x, 0, pos.z,\n                2, 0.2, 1, 0.25,\n                posDir,\n                GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, 0.5),\n                GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, 0.5),\n                GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, 0.5),\n                0,\n                nil,\n                nil,\n                GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1),\n                1.0,\n                3,\n                0.05,\n                true\n            )\n        end\n        local targetPos = TensorCore.getPosInDirection(pos, posDir, 0.5)\n        M.DirectTo(targetPos.x, targetPos.z, guideTime, 0.2)\n        data.MuAiGd_RelativityFlag.Turing = true\n    end\nend\n\n-- 引导灯结束了 且 获得了火伤buff，需要回中了\nif data.MuAiGd_RelativityFlag.Turing and not data.MuAiGd_RelativityFlag.TuringBack then\n    local buff = TensorCore.getBuff(M.GetPlayer().id, 4383)\n    if buff and buff.duration >= 11 then\n        M.Info(\"引导灯完成, 回场中！\")\n        data.MuAiGd_P3_BackCenter()\n        data.MuAiGd_RelativityFlag.TuringBack = true\n    end\nend\n",
							conditions = 
							{
								
								{
									"91218c42-2e34-4e1b-afeb-b178cff662de",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							name = "处理BUFF",
							uuid = "c25a8b75-f300-1a72-9e0d-84f923e6cd97",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.MuAiGd_P3_1_Clock12 ~= nil and data.MuAiGd_SelfLight ~= nil",
							name = "找到灯",
							uuid = "91218c42-2e34-4e1b-afeb-b178cff662de",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 532.4,
				name = "[MuAiGuide]BUFF处理",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 42,
				timerStartOffset = -1,
				uuid = "42e8f9f9-e7a4-1f69-b4e4-4c807cc70b94",
				version = 2,
			},
			inheritedIndex = 3,
		},
	},
	[142] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local M = MuAiGuide\nlocal typeMap = {}\nfor i = 1, #M.JobPosName do\n    local jobName = M.JobPosName[i]\n    local party = M.Party[jobName]\n    local waterBuff = TensorCore.getBuff(party.id, 2461)\n    local type -- 长 1 中2 短3 无4\n    if waterBuff then\n        if waterBuff.duration > 30 then\n            type = 1\n        elseif waterBuff.duration > 20 then\n            type = 2\n        else\n            type = 3\n        end\n    else\n        type = 4\n    end\n    if not typeMap[type] then\n        typeMap[type] = { jobName }\n    else\n        table.insert(typeMap[type], jobName)\n    end\nend\n\n-- 左侧基础站位\nlocal LeftBaseGroup = { \"MT\", \"ST\", \"H1\", \"H2\" }\n-- 右侧基础站位\nlocal RightBaseGroup = { \"D1\", \"D2\", \"D3\", \"D4\" }\n\nlocal L2R = {}\nlocal R2L = {}\nlocal ChangeOrder = function(tbl)\n    if table.size(tbl) == 1 then\n        return { tbl[1], tbl[2] }\n    else\n        local index1 = M.IndexOf(M.JobPosName, tbl[1])\n        local index2 = M.IndexOf(M.JobPosName, tbl[2])\n        if index1 > index2 then\n            return { tbl[2], tbl[1] }\n        end\n    end\n    return { tbl[1], tbl[2] }\nend\n\nfor _, list in pairs(typeMap) do\n    if table.contains(LeftBaseGroup, list[1]) and table.contains(LeftBaseGroup, list[2]) then\n        --同属TH\n        table.insert(L2R, list[2])\n    elseif table.contains(RightBaseGroup, list[1]) and table.contains(RightBaseGroup, list[2]) then\n        --同属D\n        table.insert(R2L, list[2])\n    end\nend\n\nL2R = ChangeOrder(L2R)\nR2L = ChangeOrder(R2L)\nlocal selfNeedChange = false\nfor i = 1, #L2R do\n    if L2R[i] == M.SelfPos then\n        local p = M.Party[R2L[i]]\n        local curP = TensorCore.mGetEntity(p.id)\n        M.DirectTo(curP.pos.x, curP.pos.z, 5000)\n        M.Info(\"与\" .. R2L[i] .. \"交换位置！<se.1>\")\n        data.MuAiGd_P3_2_SelfJob = R2L[i]\n        selfNeedChange = true\n    elseif R2L[i] == M.SelfPos then\n        local p = M.Party[L2R[i]]\n        local curP = TensorCore.mGetEntity(p.id)\n        M.DirectTo(curP.pos.x, curP.pos.z, 5000)\n        M.Info(\"与\" .. L2R[i] .. \"交换位置！<se.1>\")\n        data.MuAiGd_P3_2_SelfJob = L2R[i]\n        selfNeedChange = true\n    else\n        M.Info(L2R[i] .. \"与\" .. R2L[i] .. \"交换位置！\")\n    end\nend\nif not selfNeedChange then\n    M.Info(\"我不换！\")\n    data.MuAiGd_P3_2_SelfJob = M.SelfPos\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							name = "排优先级",
							uuid = "dd5779db-3e79-1ce9-af31-2a2cf44db09d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 612.6,
				name = "[MuAiGuide]排优先级",
				timelineIndex = 142,
				timerOffset = 1,
				uuid = "70ee63e7-a987-c5be-99c1-ef37fcd9bd5c",
				version = 2,
			},
		},
	},
	[144] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local M = MuAiGuide\nif data.MuAiGd_P3_2_Objects == nil then\n    data.MuAiGd_P3_2_Objects = {}\n    data.MuAiGd_P3_2_Ids = {}\n    data.MuAiGd_P3_2_GroundFireFinish = false\nend\n\nif eventArgs.entityContentID == 2011391\n    and not table.contains(data.MuAiGd_P3_2_Ids, eventArgs.entityID)\n    and table.size(data.MuAiGd_P3_2_Ids) < 6\nthen\n    table.insert(data.MuAiGd_P3_2_Ids, eventArgs.entityID)\n\n    if table.size(data.MuAiGd_P3_2_Ids) == 6 and data.MuAiGd_P3_2_GroundFireFinish == false then\n        --- 绘制方向箭头\n        local drawClock = function(director, index)\n            local baseEnt = TensorCore.mGetEntity(data.MuAiGd_P3_2_Ids[index])\n            local baseDir = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, baseEnt.pos)\n            for i = 1, 3 do\n                local curDir\n                local heading\n                if director == 1 then\n                    curDir = baseDir - math.pi / 4 * i\n                    heading = curDir - math.pi / 2\n                else\n                    curDir = baseDir - math.pi / 4 * i\n                    heading = curDir + math.pi / 2\n                end\n                local startPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, curDir, 14)\n                local pos = TensorCore.getPosInDirection(startPos, heading, -3)\n                Argus2.addTimedArrowFilled(\n                    15000,\n                    pos.x, 0, pos.z,\n                    5,\n                    2.5,\n                    3,\n                    4,\n                    heading,\n                    GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 0, 0 / 255, 0.2),\n                    GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 0, 0 / 255, 0.2),\n                    GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 0, 0 / 255, 0.2),\n                    0,\n                    nil,\n                    nil,\n                    GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1),\n                    1.0,\n                    3,\n                    0.05,\n                    false\n                )\n            end\n        end\n        \n        local posA = TensorCore.mGetEntity(data.MuAiGd_P3_2_Ids[3]).pos\n        local posB = TensorCore.mGetEntity(data.MuAiGd_P3_2_Ids[5]).pos\n        local OA = { x = posA.x - 100, z = posA.z - 100 }\n        local OB = { x = posB.x - 100, z = posB.z - 100 }\n        local crossProduct = OA.x * OB.z - OA.z * OB.x\n        local director = 0\n        -- 非标准坐标系，叉乘结果要反着来\n        if crossProduct > 0 then\n            M.Debug(\"顺时针\")\n            director = 1\n        elseif crossProduct < 0 then\n            M.Debug(\"逆时针\")\n            director = 2\n        end\n        -- 画出方向箭头\n        drawClock(director, 3)\n        drawClock(director, 4)\n        -- 计算车头法站位\n        local firstDir = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 },\n            TensorCore.mGetEntity(data.MuAiGd_P3_2_Ids[3]).pos)\n        if firstDir > math.pi then\n            firstDir = firstDir - math.pi\n        end\n\n        local headDir1 = M.SafeHeadingChange(firstDir, math.pi / 2, 0, 2 * math.pi, 2 * math.pi)\n        local headDir2 = M.SafeHeadingChange(firstDir, -math.pi / 2, 0, 2 * math.pi, 2 * math.pi)\n        local headDps, headTh\n        if headDir1 > headDir2 then\n            headTh = headDir1\n            headDps = headDir2\n        else\n            headTh = headDir2\n            headDps = headDir1\n        end\n\n        local posTable\n        if director == 1 then\n            posTable = {\n                [\"MT\"] = { h = headTh, r = 10 },\n                [\"ST\"] = { h = headTh - math.pi / 4, r = 10 },\n                [\"H1\"] = { h = headTh - math.pi / 4 - math.pi / 14, r = 18 },\n                [\"H2\"] = { h = headTh - math.pi / 4 + math.pi / 14, r = 18 },\n                [\"D1\"] = { h = headDps, r = 10 },\n                [\"D2\"] = { h = headDps - math.pi / 4, r = 10 },\n                [\"D3\"] = { h = headDps - math.pi / 4 - math.pi / 14, r = 18 },\n                [\"D4\"] = { h = headDps - math.pi / 4 + math.pi / 14, r = 18 },\n            }\n        else\n            posTable = {\n                [\"MT\"] = { h = headTh, r = 10 },\n                [\"ST\"] = { h = headTh + math.pi / 4, r = 10 },\n                [\"H1\"] = { h = headTh + math.pi / 4 - math.pi / 14, r = 18 },\n                [\"H2\"] = { h = headTh + math.pi / 4 + math.pi / 14, r = 18 },\n                [\"D1\"] = { h = headDps, r = 10 },\n                [\"D2\"] = { h = headDps + math.pi / 4, r = 10 },\n                [\"D3\"] = { h = headDps + math.pi / 4 - math.pi / 14, r = 18 },\n                [\"D4\"] = { h = headDps + math.pi / 4 + math.pi / 14, r = 18 },\n            }\n        end\n\n        local index = data.MuAiGd_P3_2_SelfJob\n        local targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, posTable[index].h, posTable[index].r)\n        M.DirectTo(targetPos.x, targetPos.z, 10000)\n        data.MuAiGd_P3_2_GroundFireFinish = true\n        M.Debug(\"地火指路完成！\")\n    end\nend\nself.used = true",
							gVar = "ACR_RikuDRK3_CD",
							name = "地火",
							uuid = "2e3d3a95-ecba-0df4-91b0-0315322c9003",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 19,
				loop = true,
				mechanicTime = 619.6,
				name = "[MuAiGuide]P3-地火",
				timeRange = true,
				timelineIndex = 144,
				timerEndOffset = 26,
				timerStartOffset = -30,
				uuid = "77f2218f-ab09-7356-ba22-d27e48059969",
				version = 2,
			},
			inheritedIndex = 1,
		},
	},
	[166] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "guideTime  = 7000\n-- C 逆计数\nlocal jobOrder = { \"D3\", \"D4\", \"H2\", \"H1\", \"ST\", \"MT\", \"D1\", \"D2\" }\nlocal selfIndex = MuAiGuide.IndexOf(jobOrder, MuAiGuide.SelfPos)\nlocal heading = (selfIndex - 1) * math.pi / 4 + math.pi / 8\nlocal targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 8)\nMuAiGuide.DirectTo(targetPos.x, targetPos.z, guideTime)\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "2c6c86ae-6749-6a77-aeb1-91f0780115eb",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 738.2,
				name = "[MuAiGuide]光暗龙诗-预站位",
				timelineIndex = 166,
				timerOffset = -7,
				uuid = "88dd1ea6-adaf-7409-a9c7-2f88f0378a72",
				version = 2,
			},
			inheritedIndex = 1,
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
							actionLua = "local buffId1 = 2253 -- 锁链\nlocal buffId2 = 2461 -- 水\nlocal lineId = 110;\n\n-- 8方=> 翻花绳/ 换位 踩塔/引导 => 8方 => 左右刀 => 分摊 => A/C 或者 T 引导\n\n-- 找出ABCD\nlocal groupTH = { \"MT\", \"ST\", \"H1\", \"H2\" }\nlocal groupD = { \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal noLinkTH = {}\nlocal noLinkD = {}\nlocal waterMarked = {}\nlocal A, B, C, D\n\nfor i = 1, #MuAiGuide.JobPosName do\n    local jobPos = MuAiGuide.JobPosName[i]\n    local ent = MuAiGuide.Party[jobPos]\n    local buff = TensorCore.getBuff(ent.id, buffId1)\n    local buff2 = TensorCore.getBuff(ent.id, buffId2)\n    if buff then\n        MuAiGuide.Debug(jobPos .. \" 连线点名\")\n        if table.contains(groupTH, jobPos) then\n            if A == nil then\n                A = { player = ent, pos = \"A\", job = jobPos }\n            else\n                B = { player = ent, pos = \"B\", job = jobPos }\n            end\n        elseif table.contains(groupD, jobPos) then\n            if C == nil then\n                C = { player = ent, pos = \"C\", job = jobPos }\n            else\n                D = { player = ent, pos = \"D\", job = jobPos }\n            end\n        end\n    else\n        if MuAiGuide.IsDps(ent.job) then\n            table.insert(noLinkD, jobPos)\n        else\n            table.insert(noLinkTH, jobPos)\n        end\n    end\n    if buff2 then\n        MuAiGuide.Debug(jobPos .. \" 分摊点名\")\n        table.insert(waterMarked, jobPos)\n    end\nend\nlocal IsLinked = function(startEnt, entEnt)\n    local tethers = Argus.getTethersOnEnt(startEnt.player.id)\n    for _, tether in pairs(tethers) do\n        if tether.type == lineId and tether.partnerid == entEnt.player.id then\n            return true\n        end\n    end\n    return false\nend\n\n--[[ 判断形状\n 假设连线人从上到下从左到右分别为ABCD\n 1. AB 存在 AC 存在 => 四边形  => AC 互换\n 2. AD 存在 BC 存在 =>交叉\n    2.1 AB存在 => 沙漏   =>BC 互换\n    2.2 AC存在 => 蝴蝶结\n]]\n\nlocal abIsLink = IsLinked(A, B)\nlocal acIsLink = IsLinked(A, C)\nlocal isCross = IsLinked(A, D) and IsLinked(B, C, lineId)\n\nlocal GroupUp = {}\nlocal GroupDown = {}\n-- 类型 1 蝴蝶结 2 四边形，3 沙漏\nlocal type\nif isCross then\n    if acIsLink then\n        type = 1\n        local msg = \"翻花绳类型：蝴蝶结, 不换\"\n        MuAiGuide.Debug(msg)\n        MuAiGuide.Info(msg)\n        GroupUp = { noLinkTH[1], A.job, B.job, noLinkTH[2] }\n        GroupDown = { noLinkD[1], C.job, D.job, noLinkD[2] }\n    elseif abIsLink then\n        local msg = \"翻花绳类型：沙漏, \" .. B.job .. \"<=>\" .. C.job .. \"互换\"\n        MuAiGuide.Debug(msg)\n        MuAiGuide.Info(msg)\n        GroupUp = { noLinkTH[1], A.job, C.job, noLinkTH[2] }\n        GroupDown = { noLinkD[1], B.job, D.job, noLinkD[2] }\n        type = 3\n    end\nelse\n    local msg = \"翻花绳类型：四边形, \" .. A.job .. \"<=>\" .. C.job .. \"互换！\"\n    MuAiGuide.Debug(msg)\n    MuAiGuide.Info(msg)\n    GroupUp = { noLinkTH[1], C.job, B.job, noLinkTH[2] }\n    GroupDown = { noLinkD[1], A.job, D.job, noLinkD[2] }\n    type = 2\nend\n\nMuAiGuide.Debug(\"上部翻花绳后分组: \" .. MuAiGuide.StringJoin(GroupUp, \",\"))\nMuAiGuide.Debug(\"下部翻花绳后分组: \" .. MuAiGuide.StringJoin(GroupDown, \",\"))\n\n-- 分析BUFF, 看看2个水是否在同侧\n\nlocal finalGroupUp\nlocal finalGroupDown\n\n-- 检查上组\nif table.contains(GroupUp, waterMarked[1]) and table.contains(GroupUp, waterMarked[2]) then\n    if table.contains(waterMarked, GroupUp[1]) then\n        finalGroupUp = { GroupDown[1], GroupUp[2], GroupUp[3], GroupUp[4] }\n        finalGroupDown = { GroupUp[1], GroupDown[2], GroupDown[3], GroupDown[4] }\n    else\n        finalGroupUp = { GroupUp[1], GroupUp[2], GroupUp[3], GroupDown[4] }\n        finalGroupDown = { GroupDown[1], GroupDown[2], GroupDown[3], GroupUp[4] }\n    end\nelseif table.contains(GroupDown, waterMarked[1]) and table.contains(GroupDown, waterMarked[2]) then\n    if table.contains(waterMarked, GroupDown[1]) then\n        finalGroupUp = { GroupDown[1], GroupUp[2], GroupUp[3], GroupUp[4] }\n        finalGroupDown = { GroupUp[1], GroupDown[2], GroupDown[3], GroupDown[4] }\n    else\n        finalGroupUp = { GroupUp[1], GroupUp[2], GroupUp[3], GroupDown[4] }\n        finalGroupDown = { GroupDown[1], GroupDown[2], GroupDown[3], GroupUp[4] }\n    end\nelse\n    finalGroupUp = GroupUp\n    finalGroupDown = GroupDown\nend\n\nMuAiGuide.Info(\"上部最终分组: \" .. MuAiGuide.StringJoin(finalGroupUp, \",\"))\nMuAiGuide.Info(\"下部最终分组: \" .. MuAiGuide.StringJoin(finalGroupDown, \",\"))\nMuAiGuide.Debug(\"上部最终分组: \" .. MuAiGuide.StringJoin(finalGroupUp, \",\"))\nMuAiGuide.Debug(\"下部最终分组: \" .. MuAiGuide.StringJoin(finalGroupDown, \",\"))\n-- C 逆时针\ndata.MuAiGd_P4_1_OrderPos = {\n    finalGroupDown[3],\n    finalGroupDown[4],\n    finalGroupUp[4],\n    finalGroupUp[3],\n    finalGroupUp[2],\n    finalGroupUp[1],\n    finalGroupDown[1],\n    finalGroupDown[2],\n}\n\nlocal guideInfo = {\n    { deltaH = -math.pi / 12, distance = 7 },\n    { deltaH = 0,             distance = 5 },\n    { deltaH = 0,             distance = 5 },\n    { deltaH = math.pi / 12,  distance = 7 },\n    { deltaH = -math.pi / 12, distance = 7 },\n    { deltaH = 0,             distance = 5 },\n    { deltaH = 0,             distance = 5 },\n    { deltaH = math.pi / 12,  distance = 7 }\n}\n\nlocal selfIndex = MuAiGuide.IndexOf(data.MuAiGd_P4_1_OrderPos, MuAiGuide.SelfPos)\nlocal selfGuide = guideInfo[selfIndex]\nlocal heading = (selfIndex - 1) * math.pi / 4 + math.pi / 8 + selfGuide.deltaH\nlocal finalPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, selfGuide.distance)\nMuAiGuide.DirectTo(finalPos.x, finalPos.z, 10000)\n\n-- 判断自己组分摊的人是谁\nfor i = 1, #waterMarked do\n    if table.contains(finalGroupUp, MuAiGuide.SelfPos) and table.contains(finalGroupUp, waterMarked[i])\n        or table.contains(finalGroupDown, MuAiGuide.SelfPos) and table.contains(finalGroupDown, waterMarked[i])\n    then\n        data.MuAiGd_P4_1_Converge = waterMarked[i]\n        break\n    end\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "1326ce5d-88b6-3530-ba5c-b4dfef15bb5b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 738.2,
				name = "[MuAiGuide]光暗龙诗-翻花绳引导光波",
				timelineIndex = 166,
				timerOffset = 2,
				uuid = "1faae67b-df7d-40a7-9f9c-ab5a22a01dde",
				version = 2,
			},
			inheritedIndex = 2,
		},
	},
	[167] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guideTime  = 4000\n-- C 逆计数\nlocal selfIndex = MuAiGuide.IndexOf(data.MuAiGd_P4_1_OrderPos, MuAiGuide.SelfPos)\nlocal heading = (selfIndex - 1) * math.pi / 4 + math.pi / 8\nlocal targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 11)\nMuAiGuide.DirectTo(targetPos.x, targetPos.z, guideTime)\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "8a2c9a03-fed0-2646-b3cb-8eec38455cdc",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 749.3,
				name = "[MuAiGuide]光暗龙诗-分散",
				timelineIndex = 167,
				uuid = "eee763f0-4831-85ba-950e-9561a27390cf",
				version = 2,
			},
		},
	},
	[169] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if TensorCore.isAnyEntityCasting(40228) then\n    data.MuAiGd_P4_1_Skill = \"Right\"\nelse\n    data.MuAiGd_P4_1_Skill = \"Left\"\nend\nlocal selfIndex = MuAiGuide.IndexOf(data.MuAiGd_P4_1_OrderPos, MuAiGuide.SelfPos)\n-- 去上面\nif selfIndex >= 3 and selfIndex <= 6 then\n    if data.MuAiGd_P4_1_Skill == \"Right\" then\n        MuAiGuide.DirectTo(91, 91, 5000)\n    else\n        MuAiGuide.DirectTo(109, 91, 5000)\n    end\nelse\n    -- 下面  \n    if data.MuAiGd_P4_1_Skill == \"Right\" then\n        MuAiGuide.DirectTo(91, 109, 5000)\n    else\n        MuAiGuide.DirectTo(109, 109, 5000)\n    end\nend\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "cc60e808-2342-a401-960a-6d7fb31ddd33",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 752.3,
				name = "[MuAiGuide]光暗龙诗-分摊old",
				timelineIndex = 169,
				uuid = "c38fae62-de82-5670-b95d-92369c38f312",
				version = 2,
			},
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
							actionLua = "if data.MuAiGd_P4_1_Converge ~= nil and MuAiGuide.SelfPos ~= data.MuAiGd_P4_1_Converge then\n    local player = MuAiGuide.Party[data.MuAiGd_P4_1_Converge]\n    MuAiGuide.DirectToEnt(player.id, 5000)\nend\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "3953cd55-a913-da28-ac8f-e75bc5ab3536",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 752.3,
				name = "[MuAiGuide]光暗龙诗-分摊",
				timelineIndex = 169,
				uuid = "7689405b-5111-69a9-a90e-bf0167a9a14d",
				version = 2,
			},
		},
	},
	[170] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if MuAiGuide.SelfPos ~= \"MT\" and MuAiGuide.SelfPos ~= \"ST\" then\n    local selfIndex = MuAiGuide.IndexOf(data.MuAiGd_P4_1_OrderPos, MuAiGuide.SelfPos)\n    -- 引导人群回中增加T容错\n    if selfIndex >= 3 and selfIndex <= 6 then\n        MuAiGuide.DirectTo(100, 91, 5000)\n    else\n        MuAiGuide.DirectTo(100, 109, 5000)\n    end\nend\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "7210f740-d0f3-2ce3-ba75-b4075af0a2b0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 757.3,
				name = "[MuAiGuide]光暗龙诗-引导人群回中增加T容错",
				timelineIndex = 170,
				uuid = "9e6e5623-ca59-e4d3-9b64-3656ca01e0df",
				version = 2,
			},
		},
	},
	[179] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if data.MuAiGd_P4_WaveFrom == nil then\n    data.MuAiGd_P4_WaveFrom = {}\n    data.MuAiGd_P4_WaveGuidePos = 0\nend\n\nif table.size(data.MuAiGd_P4_WaveFrom) < 2 then\n    local entity = TensorCore.mGetEntity(eventArgs.entityID)\n    table.insert(data.MuAiGd_P4_WaveFrom, entity.pos)\n    local cnt = table.size(data.MuAiGd_P4_WaveFrom)\n    if entity.pos.x < 90 then      -- 左边\n        MuAiGuide.Info(\"地火\" .. cnt .. \"来自左边的D方向。\")\n    elseif entity.pos.x > 110 then -- 右边\n        MuAiGuide.Info(\"地火\" .. cnt .. \"来自右边的B方向。\")\n    elseif entity.pos.z < 90 then  -- 上\n        MuAiGuide.Info(\"地火\" .. cnt .. \"来自上边的A方向。\")\n    elseif entity.pos.z > 110 then -- 下\n        MuAiGuide.Info(\"地火\" .. cnt .. \"来自下边的C方向。\")\n    end\n \n    if cnt == 2 then\n        local p1 = data.MuAiGd_P4_WaveFrom[1]\n        local p2 = data.MuAiGd_P4_WaveFrom[2]\n        if MuAiGuide.Config.FruCfg.CrystallizeTimeKnockBack == 1 then --Y字\n            data.MuAiGd_P4_WaveGuideHeading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, p2)\n        else\n            local centerPoint = { x = (p1.x + p2.x) / 2, y = 0, z = (p1.z + p2.z) / 2 }\n            data.MuAiGd_P4_WaveGuideHeading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, centerPoint)\n        end\n    end\n    self.used = true\nend\n",
							conditions = 
							{
								
								{
									"ff53dc67-78da-a41e-9650-cf4447153514",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "45a12f1f-0bf8-81ba-bd99-4c3227a7db70",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							eventArgType = 2,
							eventSpellID = 40251,
							uuid = "ff53dc67-78da-a41e-9650-cf4447153514",
							version = 2,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 798.9,
				name = "[MuAiGuide]查找回返放置位置",
				timeRange = true,
				timelineIndex = 179,
				timerEndOffset = 60,
				timerStartOffset = -1,
				uuid = "8e5f258e-712a-588f-96e1-9fd96100574f",
				version = 2,
			},
		},
	},
	[181] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local M = MuAiGuide\n\nif data.MuAiGd_P4_Player == nil then\n    data.MuAiGd_P4_ManualMarks = {}\n    data.MuAiGd_P4_BuffCollected = false\n    data.MuAiGd_P4_Player = {}\n    data.MuAiGd_P4_Player.Ice1 = nil\n    data.MuAiGd_P4_Player.Ice2 = nil\n    data.MuAiGd_P4_Player.Ice3 = nil\n    data.MuAiGd_P4_Player.Wind1 = nil\n    data.MuAiGd_P4_Player.Wind2 = nil\n    data.MuAiGd_P4_Player.Water = nil\n    data.MuAiGd_P4_Player.Flame = nil\n    data.MuAiGd_P4_Player.Converge = nil\n    data.MuAiGd_P4_Player.GroupWind = nil\n    --- 1:捡D，2:捡B，3:捡3，4:捡4，5:左龙撞头，6:右龙撞头，7:左下撞龙头，8:右下撞龙头，\n    data.MuAiGd_P4_SelfGuideType = 0\nend\n\n--- 固定位置转换到类型\nlocal FixToType = function(fixPoint)\n    if fixPoint == \"D\" then\n        return 1\n    elseif fixPoint == \"B\" then\n        return 2\n    elseif fixPoint == \"3\" then\n        return 3\n    elseif fixPoint == \"4\" then\n        return 4\n    end\nend\n\nif not data.MuAiGd_P4_BuffCollected then\n    for i = 1, #M.JobPosName do\n        local job = M.JobPosName[i]\n        local player = M.Party[job]\n\n        local claw3263 = TensorCore.getBuff(player.id, 3263)\n        local booth3264 = TensorCore.getBuff(player.id, 3264)\n\n        local wind2463 = TensorCore.getBuff(player.id, 2463)\n        local ice2462 = TensorCore.getBuff(player.id, 2462)\n        local flame2460 = TensorCore.getBuff(player.id, 2460)\n        local water2461 = TensorCore.getBuff(player.id, 2461)\n        local converge2454 = TensorCore.getBuff(player.id, 2454)\n\n        if ice2462 then\n            if claw3263 then\n                if data.MuAiGd_P4_Player.Ice1 == nil then\n                    data.MuAiGd_P4_Player.Ice1 = player\n                    if MuAiGuide.IsMe(player) then\n                        data.MuAiGd_P4_SelfGuideType = 5\n                    end\n                else\n                    data.MuAiGd_P4_Player.Ice2 = player\n                    if MuAiGuide.IsMe(player) then\n                        data.MuAiGd_P4_SelfGuideType = 6\n                    end\n                end\n            else\n                if booth3264 then\n                    data.MuAiGd_P4_Player.Ice3 = player\n                    local fixConfig = MuAiGuide.Config.FruCfg.CrystallizeTimeFix[2462]\n                    if MuAiGuide.IsMe(player) then\n                        data.MuAiGd_P4_SelfGuideType = FixToType(fixConfig)\n                    end\n                   \n                end\n            end\n        end\n        if wind2463 then\n            if data.MuAiGd_P4_Player.Wind1 == nil then\n                data.MuAiGd_P4_Player.Wind1 = player\n                if MuAiGuide.IsMe(player) then\n                    data.MuAiGd_P4_SelfGuideType = 7\n                end\n               \n            else\n                data.MuAiGd_P4_Player.Wind2 = player\n                if MuAiGuide.IsMe(player) then\n                    data.MuAiGd_P4_SelfGuideType = 8\n                end\n            end\n        end\n        if water2461 then\n            data.MuAiGd_P4_Player.Water = player\n            local fixConfig = MuAiGuide.Config.FruCfg.CrystallizeTimeFix[2461]\n            if MuAiGuide.IsMe(player) then\n                data.MuAiGd_P4_SelfGuideType = FixToType(fixConfig)\n            end\n        end\n        if flame2460 then\n            data.MuAiGd_P4_Player.Flame = player\n            local fixConfig = MuAiGuide.Config.FruCfg.CrystallizeTimeFix[2460]\n            if MuAiGuide.IsMe(player) then\n                data.MuAiGd_P4_SelfGuideType = FixToType(fixConfig)\n            end\n        end\n        if converge2454 then\n            data.MuAiGd_P4_Player.Converge = player\n            local fixConfig = MuAiGuide.Config.FruCfg.CrystallizeTimeFix[2454]\n            if MuAiGuide.IsMe(player) then\n                data.MuAiGd_P4_SelfGuideType = FixToType(fixConfig)\n            end\n        end\n    end\n\n    data.MuAiGd_P4_BuffCollected = true\nend\n\n-- 如果手摇，在获取BUFF后，循环执行进行逻辑覆盖，则持续判断标记类型\nif data.MuAiGd_P4_BuffCollected\n    and MuAiGuide.Config.FruCfg.CrystallizeTimeType == 3\n    and TensorCore.getBuff(MuAiGuide.GetPlayer().id, 3264) then\n    for i = 1, #M.JobPosName do\n        local job = M.JobPosName[i]\n        local player = M.Party[job]\n        local booth3264 = TensorCore.getBuff(player.id, 3264)\n        if booth3264 then\n            if not MuAiGuide.IsMe(player) and player.maker ~= 0 and player.maker <= 4 then\n                data.MuAiGd_P4_ManualMarks[player.maker] = player\n            end\n        end\n    end\n    if table.size(data.MuAiGd_P4_ManualMarks) == 3 and MuAiGuide.GetPlayer().maker == 0 then\n        local notUseId = 0\n        for i = 1, 4 do\n            if data.MuAiGd_P4_ManualMarks[i] == nil then\n                notUseId = i\n                break\n            end\n        end\n        ActionList:Get(12, notUseId):Cast(MuAiGuide.GetPlayer().id)\n        data.MuAiGd_P4_SelfGuideType = notUseId\n        self.used = true\n    end\nelse\n    self.used = true\nend\n",
							gVar = "ACR_TensorMagnum3_CD",
							uuid = "2fbf2e9f-9dc2-7001-9365-919010343d26",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 3,
				mechanicTime = 804.9,
				name = "[MuaiGuide]初始BUFF数据收集",
				randomOffset = 30,
				timeRange = true,
				timelineIndex = 181,
				timerEndOffset = 30,
				timerOffset = -4,
				timerStartOffset = -4.5,
				uuid = "b9d38afd-6893-80eb-a67e-0caf590425d5",
				version = 2,
			},
			inheritedIndex = 6,
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
							actionLua = "local guideTime = 10000\nif data.MuAiGd_P4_Lights == nil then\n    data.MuAiGd_P4_Lights = {}\n    --- 场地类型 1:左上紫色，2:右上紫色\n    data.MuAiGd_P4_GroundType = 0\nend\n\n-- 采集灯\nif table.size(data.MuAiGd_P4_Lights) < 6 then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=9823\")) do\n        data.MuAiGd_P4_Lights[ent.id] = ent\n    end\nend\nif table.size(data.MuAiGd_P4_Lights) == 6 then\n    local purpleLines = {}\n    for _, light in pairs(data.MuAiGd_P4_Lights) do\n        local lines = Argus.getTethersOnEnt(light.id)\n        for _, line in pairs(lines) do\n            if line.type == 133 then\n                purpleLines[light.id] = light\n            end\n        end\n    end\n    if table.size(purpleLines) == 2 then\n        for _, purpleLine in pairs(purpleLines) do\n            if purpleLine.pos.z < 100 then\n                if purpleLine.pos.x > 100 then\n                    data.MuAiGd_P4_GroundType = 2\n                else\n                    data.MuAiGd_P4_GroundType = 1\n                end\n            end\n        end\n\n        -- 如果当前为标点模式，且自身有标点\n        if MuAiGuide.Config.FruCfg.CrystallizeTimeType ~= 1 and MuAiGuide.GetPlayer().marker ~= 0 then\n            if MuAiGuide.GetPlayer().marker <= 4 then\n                --- type 1:捡D，2:捡B，3:捡3，4:捡4，\n                if MuAiGuide.Config.FruCfg.CrystallizeMark[\"D\"] == MuAiGuide.GetPlayer().marker then\n                    data.MuAiGd_P4_SelfGuideType = 1\n                elseif MuAiGuide.Config.FruCfg.CrystallizeMark[\"B\"] == MuAiGuide.GetPlayer().marker then\n                    data.MuAiGd_P4_SelfGuideType = 2\n                elseif MuAiGuide.Config.FruCfg.CrystallizeMark[\"3\"] == MuAiGuide.GetPlayer().marker then\n                    data.MuAiGd_P4_SelfGuideType = 3\n                elseif MuAiGuide.Config.FruCfg.CrystallizeMark[\"4\"] == MuAiGuide.GetPlayer().marker then\n                    data.MuAiGd_P4_SelfGuideType = 4\n                end\n            else \n                if MuAiGuide.GetPlayer().marker == 6 then\n                    data.MuAiGd_P4_SelfGuideType = 5\n                elseif MuAiGuide.GetPlayer().marker == 7 then\n                    data.MuAiGd_P4_SelfGuideType = 6\n                elseif MuAiGuide.GetPlayer().marker == 9 then\n                    data.MuAiGd_P4_SelfGuideType = 7\n                elseif MuAiGuide.GetPlayer().marker == 10 then\n                    data.MuAiGd_P4_SelfGuideType = 8\n                end\n            end\n        end\n\n        if MuAiGuide.IsMe(data.MuAiGd_P4_Player.Flame) then -- 暗单走\n            if data.MuAiGd_P4_GroundType == 1 then\n                MuAiGuide.DirectTo(88.67, 84, guideTime, 0.3)\n            else\n                MuAiGuide.DirectTo(111.33, 84, guideTime, 0.3)\n            end\n        else\n            if data.MuAiGd_P4_SelfGuideType <= 4 then -- 3个蓝BUFF\n                if data.MuAiGd_P4_GroundType == 1 then\n                    MuAiGuide.DirectTo(111.33, 116, guideTime, 0.3)\n                else\n                    MuAiGuide.DirectTo(88.67, 116, guideTime, 0.3)\n                end\n            elseif data.MuAiGd_P4_SelfGuideType == 7 then\n                MuAiGuide.DirectTo(88.67, 116, guideTime, 0.3)\n            elseif data.MuAiGd_P4_SelfGuideType == 8 then\n                MuAiGuide.DirectTo(111.33, 116, guideTime, 0.3)\n            elseif data.MuAiGd_P4_SelfGuideType == 5 then\n                MuAiGuide.DirectTo(87, 100, guideTime)\n            elseif data.MuAiGd_P4_SelfGuideType == 6 then\n                MuAiGuide.DirectTo(113, 100, guideTime)\n            end\n        end\n    end\n    if MuAiGuide.Config.LogToEchoMsg then\n        if data.MuAiGd_P4_SelfGuideType <= 4 then\n            if MuAiGuide.IsMe(data.MuAiGd_P4_Player.Flame) then\n                MuAiGuide.Info(\"我是暗单走。\")\n            else\n                MuAiGuide.Info(\"我需要集体行动。\")\n            end\n        else\n            if data.MuAiGd_P4_SelfGuideType == 5 then\n                MuAiGuide.Info(\"D点撞龙头。\")\n            elseif data.MuAiGd_P4_SelfGuideType == 6 then\n                MuAiGuide.Info(\"B点撞龙头。\")\n            elseif data.MuAiGd_P4_SelfGuideType == 7 then\n                MuAiGuide.Info(\"4点撞龙头。\")\n            elseif data.MuAiGd_P4_SelfGuideType == 8 then\n                MuAiGuide.Info(\"3点撞龙头。\")\n            end\n        end\n    end\nend\ndata.MuAiGd_P4_Guide1Finish = true\nself.used = true\n",
							gVar = "ACR_TensorMagnum3_CD",
							uuid = "fd341487-f82a-4a77-a895-984b05db4d7e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 804.9,
				name = "[MuAiGuide]分析线&指路1",
				timelineIndex = 181,
				timerOffset = -1.5,
				uuid = "59c6f796-4136-3dc1-b912-b2b69d7ec748",
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
							actionLua = "local M = MuAiGuide\nif data.MuAiGd_P4_Flags == nil then\n    data.MuAiGd_P4_Flags = {\n        Water = false,\n        Converge = false,\n        Wind = false,\n        Blue = false,\n        Red = false,\n        MissRed = false,\n        LinkToHead = false,\n        Avoid = false,\n        EndGuide = false,\n        RedGuides = {}\n    }\n    data.MuAiGd_P4_FinalGuide = function()\n        if data.MuAiGd_P4_WaveGuideHeading == nil or data.MuAiGd_P4_WaveGuideHeading < -10 then\n            return false\n        end\n        local targetPos\n        if M.Config.FruCfg.CrystallizeTimeKnockBack == 1 then --Y字 then\n            targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, data.MuAiGd_P4_WaveGuideHeading, 9.4)\n        else\n            local selfIndex = M.IndexOf(M.JobPosName)\n            local endHeading\n            local distance\n            if selfIndex % 2 == 1 then -- mt 组\n                if M.SelfPos == \"MT\" then\n                    endHeading = data.MuAiGd_P4_WaveGuideHeading + math.pi * 11 / 180\n                    distance = 16.1\n                else\n                    endHeading = data.MuAiGd_P4_WaveGuideHeading + math.pi * 8 / 180\n                    distance = 13\n                end\n            else\n                if M.SelfPos == \"ST\" then\n                    endHeading = data.MuAiGd_P4_WaveGuideHeading + math.pi * 11 / 180\n                    distance = 16.1\n                else\n                    endHeading = data.MuAiGd_P4_WaveGuideHeading + math.pi * 8 / 180\n                    distance = 13\n                end\n            end\n            targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, endHeading, distance)\n        end\n        local curReturn = TensorCore.getBuff(M.GetPlayer().id, 4208)\n        if curReturn ~= nil then\n            M.DirectTo(targetPos.x, targetPos.z, curReturn.duration * 1000)\n        end\n        return true\n    end\n    data.MuAiGd_P4_GetDragonHead = function()\n        local heads = {}\n        local rightHead, leftHead\n        for _, ent in pairs(TensorCore.entityList(\"contentid=9323\")) do\n            if Argus.getEntityModel(ent.id) == 17836 then\n                table.insert(heads, ent)\n            end\n        end\n        if heads[1].pos.x > heads[2].pos.x then\n            rightHead = heads[1]\n            leftHead = heads[2]\n        else\n            leftHead = heads[1]\n            rightHead = heads[2]\n        end\n        return leftHead, rightHead\n    end\nend\n\nif data.MuAiGd_P4_SelfGuideType <= 4 then -- 分摊BUFF倒计时结束\n    -- 水判定，准备击退\n    if data.MuAiGd_P4_Flags.Water == false then\n        if not M.IsMe(data.MuAiGd_P4_Player.Flame) then\n            local curWater = TensorCore.getBuff(data.MuAiGd_P4_Player.Water.id, 2461)\n            if curWater == nil or curWater.duration < 0.9 then\n                local pos\n                if data.MuAiGd_P4_GroundType == 1 then\n                    pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi / 6, 18.5)\n                else\n                    pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 11 / 6, 18.5)\n                end\n                M.DirectTo(pos.x, pos.z, 4000)\n                data.MuAiGd_P4_Flags.Water = true\n                M.Info(\"准备击退。\")\n            end\n        end\n    end\n\n    if data.MuAiGd_P4_Flags.Wind == false then\n        -- 被击退/暗判定 =>调整位置进行分摊\n        local curWind = TensorCore.getBuff(data.MuAiGd_P4_Player.Wind1.id, 2463)\n        if curWind == nil or curWind.duration < 0.1 then\n            local pos\n            if data.MuAiGd_P4_GroundType == 1 then\n                pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 5 / 4, 19.5)\n            else\n                pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 3 / 4, 19.5)\n            end\n            M.DirectTo(pos.x, pos.z, 4000)\n            data.MuAiGd_P4_Flags.Wind = true\n            M.Info(\"调整位置到斜点。\")\n        end\n    end\n\n    if data.MuAiGd_P4_Flags.Converge == false then\n        -- 分摊判定回A\n        local curConverge = TensorCore.getBuff(data.MuAiGd_P4_Player.Converge.id, 2454)\n        if curConverge == nil or curConverge.duration < 0.1 then\n            M.DirectTo(100, 82, 4000)\n            data.MuAiGd_P4_Flags.Converge = true\n            M.Info(\"分摊完毕前往A方向。\")\n        end\n    end\n\n    --- 指路捡垃圾\n    if data.MuAiGd_P4_Flags.Blue == false then\n        local removerList = {}\n        local curBlue = TensorCore.getBuff(M.GetPlayer().id, 3264)\n        if curBlue and curBlue.duration < 18.5 then\n            for _, ent in pairs(TensorCore.entityList(\"contentid=2014529\")) do\n                table.insert(removerList, ent)\n            end\n            for i = 1, #removerList do\n                for j = 1, #removerList - i do\n                    if removerList[j].pos.x > removerList[j + 1].pos.x then\n                        removerList[j], removerList[j + 1] = removerList[j + 1], removerList[j]\n                    end\n                end\n            end\n            local pos\n            if data.MuAiGd_P4_SelfGuideType == 1 then\n                M.Info(\"去D点附近捡垃圾。\")\n                pos = removerList[1].pos\n            elseif data.MuAiGd_P4_SelfGuideType == 2 then\n                M.Info(\"去B点附近捡垃圾。\")\n                pos = removerList[4].pos\n            elseif data.MuAiGd_P4_SelfGuideType == 3 then\n                M.Info(\"去3点附近捡垃圾。\")\n                pos = removerList[3].pos\n            elseif data.MuAiGd_P4_SelfGuideType == 4 then\n                M.Info(\"去4点附近捡垃圾。\")\n                pos = removerList[2].pos\n            end\n            M.DirectTo(pos.x, pos.z, curBlue.duration * 1000)\n            data.MuAiGd_P4_Flags.Blue = true\n        end\n    end\n    if data.MuAiGd_P4_Flags.EndGuide == false then\n        local curBlue = TensorCore.getBuff(M.GetPlayer().id, 3264)\n        if curBlue == nil then\n            if data.MuAiGd_P4_FinalGuide() then\n                M.Info(\"垃圾回收成功，前往回返点。\")\n                data.MuAiGd_P4_Flags.EndGuide = true\n                self.used = true\n            end\n        end\n    end\nelse\n    if data.MuAiGd_P4_SelfGuideType == 5 or data.MuAiGd_P4_SelfGuideType == 6 then\n        -- 左右撞头\n        if data.MuAiGd_P4_Flags.LinkToHead == false then\n            local curClaw = TensorCore.getBuff(M.GetPlayer().id, 3263)\n            if curClaw and curClaw.duration <= 8 then\n                M.CancelDir()\n                local leftHead, rightHead = data.MuAiGd_P4_GetDragonHead()\n                local selfHead\n                if data.MuAiGd_P4_SelfGuideType == 5 then\n                    selfHead = leftHead\n                else\n                    selfHead = rightHead\n                end\n                data.MuAiGd_P4_Flags.RedGuides = M.DirectToEnt(selfHead.id, 10000)\n                data.MuAiGd_P4_Flags.LinkToHead = true\n            end\n        end\n\n        -- 撞头完毕\n        if data.MuAiGd_P4_Flags.MissRed == false then\n            local curClaw = TensorCore.getBuff(M.GetPlayer().id, 3263)\n            if curClaw == nil then\n                for _, uuid in pairs(data.MuAiGd_P4_Flags.RedGuides) do\n                    Argus.deleteTimedShape(uuid)\n                end\n                if data.MuAiGd_P4_SelfGuideType == 5 then\n                    if data.MuAiGd_P4_GroundType == 1 then\n                        local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 5 / 4, 19.5)\n                        M.DirectTo(pos.x, pos.z, 4000)\n                        M.Info(\"撞头完毕，和人群分摊。\")\n                    else\n                        MuAiGuide.DirectTo(80.5, 101.8, 8000, 0.3)\n                        M.Info(\"撞头完毕，躲开大圈。\")\n                    end\n                elseif data.MuAiGd_P4_SelfGuideType == 6 then\n                    if data.MuAiGd_P4_GroundType == 2 then\n                        local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 3 / 4, 19.5)\n                        M.DirectTo(pos.x, pos.z, 4000)\n                        M.Info(\"撞头完毕，和人群分摊。\")\n                    else\n                        MuAiGuide.DirectTo(119.5, 101.8, 8000, 0.3)\n                        M.Info(\"撞头完毕，躲开大圈。\")\n                    end\n                end\n                data.MuAiGd_P4_Flags.MissRed = true\n            end\n        end\n        -- 分摊\n        if data.MuAiGd_P4_Flags.Converge == false then\n            if data.MuAiGd_P4_SelfGuideType == 5 and data.MuAiGd_P4_GroundType == 1 or data.MuAiGd_P4_SelfGuideType == 6 and data.MuAiGd_P4_GroundType == 2 then\n                local curConverge = TensorCore.getBuff(data.MuAiGd_P4_Player.Converge.id, 2454)\n                if curConverge == nil or curConverge.duration < 0.1 then\n                    M.DirectTo(100, 82, 4000)\n                    data.MuAiGd_P4_Flags.Converge = true\n                    M.Info(\"分摊完毕前往A方向。\")\n                end\n            end\n        end\n\n        -- 躲大圈\n        if data.MuAiGd_P4_Flags.Avoid == false then\n            if data.MuAiGd_P4_SelfGuideType == 5 and data.MuAiGd_P4_GroundType == 2 or data.MuAiGd_P4_SelfGuideType == 6 and data.MuAiGd_P4_GroundType == 1 then\n                local curReturn = TensorCore.getBuff(M.GetPlayer().id, 4208)\n                if curReturn and curReturn.duration < 16.5 then\n                    M.Info(\"前往A点。\")\n                    M.DirectTo(100, 82, 8000)\n                    data.MuAiGd_P4_Flags.Avoid = true\n                end\n            end\n        end\n\n        -- 终点指路\n        if data.MuAiGd_P4_Flags.EndGuide == false then\n            local curReturn = TensorCore.getBuff(M.GetPlayer().id, 4208)\n            if curReturn and curReturn.duration < 13 then\n                if data.MuAiGd_P4_FinalGuide() then\n                    data.MuAiGd_P4_Flags.EndGuide = true\n                    self.used = true\n                end\n            end\n        end\n    else\n        -- 水判定\n        if data.MuAiGd_P4_Flags.Water == false then\n            local curWater = TensorCore.getBuff(data.MuAiGd_P4_Player.Water.id, 2461)\n            if curWater == nil or curWater.duration < 0.9 then\n                local pos\n                if data.MuAiGd_P4_SelfGuideType == 7 then\n                    pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 11 / 6, 18.5)\n                else\n                    pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi / 6, 18.5)\n                end\n                M.DirectTo(pos.x, pos.z, 4000)\n                data.MuAiGd_P4_Flags.Water = true\n            end\n        end\n\n        --风判定\n        if data.MuAiGd_P4_Flags.Wind == false then\n            -- 被击退/暗判定 =>调整位置进行分摊\n            local curWind = TensorCore.getBuff(data.MuAiGd_P4_Player.Wind1.id, 2463)\n            if curWind == nil or curWind.duration < 0.1 then\n                local pos\n                if data.MuAiGd_P4_GroundType == 7 then\n                    M.DirectTo(92.5, 117.9, 5000)\n                else\n                    M.DirectTo(107.5, 117.9, 5000)\n                end\n                data.MuAiGd_P4_Flags.Wind = true\n            end\n        end\n\n        -- 左下右下撞头\n        if data.MuAiGd_P4_Flags.LinkToHead == false then\n            local curClaw = TensorCore.getBuff(M.GetPlayer().id, 3263)\n            if curClaw and curClaw.duration <= 23.5 then\n                M.CancelDir()\n                local leftHead, rightHead = data.MuAiGd_P4_GetDragonHead()\n                local selfHead\n                if data.MuAiGd_P4_SelfGuideType == 5 then\n                    selfHead = leftHead\n                else\n                    selfHead = rightHead\n                end\n                data.MuAiGd_P4_Flags.RedGuides = M.DirectToEnt(selfHead.id, 10000)\n                data.MuAiGd_P4_Flags.LinkToHead = true\n            end\n        end\n\n        -- 撞头完毕\n        if data.MuAiGd_P4_Flags.MissRed == false then\n            local curClaw = TensorCore.getBuff(M.GetPlayer().id, 3263)\n            if curClaw == nil then\n                for _, uuid in pairs(data.MuAiGd_P4_Flags.RedGuides) do\n                    Argus.deleteTimedShape(uuid)\n                end\n                M.Info(\"前往C点。\")\n                M.DirectTo(100, 118, 8000)\n                data.MuAiGd_P4_Flags.MissRed = true\n            end\n        end\n\n        -- 终点指路\n        if data.MuAiGd_P4_Flags.EndGuide == false then\n            local curReturn = TensorCore.getBuff(M.GetPlayer().id, 4208)\n            if curReturn and curReturn.duration < 13 then\n                if data.MuAiGd_P4_FinalGuide() then\n                    data.MuAiGd_P4_Flags.EndGuide = true\n                    self.used = true\n                end\n            end\n        end\n    end\nend\n",
							gVar = "ACR_TensorMagnum3_CD",
							uuid = "cd63e215-3e32-dbfa-944a-c95ba44302b3",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				eventType = 3,
				mechanicTime = 804.9,
				name = "[MuAiGuide]循环处理BUFF",
				timeRange = true,
				timelineIndex = 181,
				timerEndOffset = 40,
				timerOffset = -1,
				timerStartOffset = -1,
				uuid = "d92862b0-284c-1791-ad03-c2c1502744b5",
				version = 2,
			},
		},
	},
	[194] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7548,
							conditions = 
							{
								
								{
									"de577b2a-0560-16eb-98a5-5e09353fff5c",
									true,
								},
								
								{
									"91b7d982-c22c-37e0-ace4-9a8016ef54fc",
									true,
								},
								
								{
									"3c80be25-6539-4eda-a09d-c0c6c674b4c0",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorRequiem3_CD",
							ignoreWeaveRules = true,
							uuid = "e29c8492-e8c6-964e-8ba9-91f560353b38",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7559,
							allowInterrupt = true,
							conditions = 
							{
								
								{
									"3c80be25-6539-4eda-a09d-c0c6c674b4c0",
									true,
								},
								
								{
									"de577b2a-0560-16eb-98a5-5e09353fff5c",
									true,
								},
								
								{
									"fd7d6133-ded9-381e-8493-aedf9caeb78d",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorRequiem3_CD",
							ignoreWeaveRules = true,
							uuid = "cebe343d-9da5-5660-b103-36d9c8a0191e",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "d(\"自动使用防击退！\")\nself.used = true",
							conditions = 
							{
								
								{
									"de577b2a-0560-16eb-98a5-5e09353fff5c",
									true,
								},
								
								{
									"3c80be25-6539-4eda-a09d-c0c6c674b4c0",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "14b3b544-2ce1-8d09-9cbb-68765b521ad9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide and MuAiGuide.Config.FruCfg.CrystallizeTimeKnockBack == 1",
							uuid = "de577b2a-0560-16eb-98a5-5e09353fff5c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7548,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							dequeueIfLuaFalse = true,
							name = "亲疏自行可用",
							uuid = "91b7d982-c22c-37e0-ace4-9a8016ef54fc",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7559,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							dequeueIfLuaFalse = true,
							name = "沉稳咏唱可用",
							uuid = "fd7d6133-ded9-381e-8493-aedf9caeb78d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40289,
							name = "神圣之翼",
							uuid = "3c80be25-6539-4eda-a09d-c0c6c674b4c0",
							version = 2,
						},
					},
				},
				eventType = 2,
				mechanicTime = 835.3,
				name = "[MuAiGuide]Y字自动防击退",
				randomOffset = -5,
				timeRange = true,
				timelineIndex = 194,
				timerEndOffset = 5,
				timerOffset = -5,
				timerStartOffset = -5,
				uuid = "fc943854-2d7a-c3f2-a3fa-424c142de4d5",
				version = 2,
			},
			inheritedIndex = 2,
		},
	},
	inheritedProfiles = 
	{
		"bard_mitigation",
	},
	mapID = 1238,
	version = 5,
}



return tbl