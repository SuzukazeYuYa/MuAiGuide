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
							actionLua = "local drawTime = 10000\nif data.MuAiGd_SinsmokeIndex == nil then\n    data.MuAiGd_SinsmokeIndex = {}\n    -- 雾龙站位情况C开始逆时针一圈, 如果站位不同可以修改这里\n    data.MuAiGd_SinsmokeJobOrder = { \"H2\", \"D2\", \"D4\", \"ST\", \"MT\", \"D3\", \"H1\", \"D1\" }\n    data.MuAiGd_SinsmokeGuideFinish = false\n    d(\"[MuAiGuide]================================== 雾龙计算开始 ====================================\")\nend\n\nif table.size(data.MuAiGd_SinsmokeIndex) < 3 then\n    -- 采集阶段\n    for _, ent in pairs(TensorCore.entityList(\"contentid=9708\")) do\n        if ent.action == 210 then\n            -- 抬手\n            local pos = MuAiGuide.GetDirectionIndex({ x = 100, z = 100 }, { x = ent.pos.x, z = ent.pos.z })\n            table.insert(data.MuAiGd_SinsmokeIndex, pos)\n            --如果是自己，那么自己往前走\n            local jobName = data.MuAiGd_SinsmokeJobOrder[pos]\n            if jobName then\n                if MuAiGuide.IsMeByPos(jobName) then\n                    -- 指路到前面(给对面的人看的)\n                    local pos1 = MuAiGuide.GetPointAtDistance({ x = 100, y = 0, z = 100 }, ent.pos, 10)\n                    MuAiGuide.DirectTo(pos1.x, pos1.z, 2000)\n                end\n            end\n        end\n    end\nend\n\nif table.size(data.MuAiGd_SinsmokeIndex) == 3\n    and data.MuAiGd_SinsmokeGuideFinish == false then\n    local msg = \"[MuAiGuide]危险点\"\n    local danger = {}\n    for i = 1, 3, 1 do\n        local pos = data.MuAiGd_SinsmokeIndex[i]\n        table.insert(danger, pos)\n        local opposite = pos + 4\n        if opposite > 8 then\n            opposite = opposite - 8\n        end\n        table.insert(danger, opposite)\n    end\n\n    local safeHeading\n    local selfOrder = MuAiGuide.IndexOf(data.MuAiGd_SinsmokeJobOrder, MuAiGuide.SelfPos)\n    for i = 1, 8, 1 do\n        if not table.contains(danger, i) then\n            if (selfOrder >= 5 and i >= 5) or (selfOrder <= 4 and i <= 4) then\n                safeHeading = (i - 1) * math.pi / 4\n            end\n        end\n    end\n    -- debug start\n    for i = 1, #danger do\n        msg = msg .. \", \" .. danger[i]\n    end\n    d(msg)\n    msg = \"[MuAiGuide]本组安全区\" .. (safeHeading / math.pi)\n    d(msg)\n    -- debug end\n\n    local targetPos\n    if data.MuAiGd_SinsmokeType == 1 then\n        --分摊\n        targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, safeHeading, 13)\n    elseif data.MuAiGd_SinsmokeType == 2 then\n        -- 按照如下站位进下的指路\n        --      H\n        -- 近   T   远\n        -- 如果站位不同，需要修改\n        if MuAiGuide.SelfPos == \"MT\" or MuAiGuide.SelfPos == \"ST\" then\n            targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, safeHeading, 19.5)\n        elseif MuAiGuide.SelfPos == \"H1\" or MuAiGuide.SelfPos == \"H2\" then\n            targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, safeHeading, 13)\n        elseif MuAiGuide.SelfPos == \"D1\" or MuAiGuide.SelfPos == \"D2\" then\n            targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, safeHeading - 0.105 * math.pi, 19.5)\n        elseif MuAiGuide.SelfPos == \"D3\" or MuAiGuide.SelfPos == \"D4\" then\n            targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, safeHeading + 0.105 * math.pi, 19.5)\n        end\n    end\n\n    if table.contains(data.MuAiGd_SinsmokeIndex, selfOrder) then\n        MuAiGuide.DirectTo(targetPos.x, targetPos.z, 8000, 0.5, 2000)\n    else\n        MuAiGuide.DirectTo(targetPos.x, targetPos.z, drawTime)\n    end\n    data.MuAiGd_SinsmokeGuideFinish = true\n    d(\"[MuAiGuide]================================== 雾龙计算结束 ====================================\")\nend\n\nself.used = true\n",
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
							actionLua = "if not data.MuAiGd_FallOfFaithInit then\n    d(\"[MuAiGuide]============================== 雷火线点名指路 && 数据采集开始 ============================\")\n    data.MuAiGd_FallOfFaithInit = true\n    data.MuAiGd_FallOfFaithLink = {}\n    data.MuAiGd_FallOfFaithRest = {}\n    data.MuAiGd_FallOfFaithRecordIds = {}\n\n    -- 站位优先级\n    if MuAiGuide.Config.FruLightFirePriority and table.size(MuAiGuide.Config.FruLightFirePriority) == 8\n    then\n        data.MuAiGd_FallOfFaithOrder = MuAiGuide.Config.FruLightFirePriority\n    else\n        data.MuAiGd_FallOfFaithOrder = { \"H1\", \"H2\", \"MT\", \"ST\", \"D1\", \"D2\", \"D3\", \"D4\" }\n    end\n\n    -- AC方向站位 索引：优先级顺序\n    data.MuAiGd_FallOfFaithLinkLightingPos = {\n        { x = 100, z = 95 }, -- 上\n        { x = 100, z = 105 }, -- 下\n        { x = 100, z = 93 }, -- 最上\n        { x = 100, z = 107 }  -- 最下\n    }\n\n    data.MuAiGd_FallOfFaithLinkFirePos = {\n        { x = 100, z = 95.5 }, -- 上\n        { x = 100, z = 104.5 }, -- 下\n        { x = 100, z = 93 }, -- 最上\n        { x = 100, z = 107 }    -- 最下\n    }\n\n    data.MuAiGd_FallOfFaithRestLightingPos = {\n        { x = 97.8, z = 94.8 }, -- 左上\n        { x = 102.2, z = 94.8 }, -- 右上\n        { x = 97.8, z = 105.2 }, -- 左下\n        { x = 102.2, z = 105.2 } -- 右下\n    }\n\n    data.MuAiGd_FallOfFaithRestFirePos = {\n        { x = 100, z = 93 }, -- 上\n        { x = 100, z = 93 }, -- 上\n        { x = 100, z = 107 }, -- 下\n        { x = 100, z = 107 }, -- 下\n    }\n\n    data.MuAiGd_FallOfFaithLinkCnt = 0\n    data.MuAiGd_FallOfFaithRestCnt = 0\n    data.MuAiGd_FallOfFaithLinkSelfIndex = 0\n    data.MuAiGd_FallOfFaithRestSelfIndex = 0\nend\n\nif table.size(data.MuAiGd_FallOfFaithLink) < 4 then\n    for jobPos, ent in pairs(MuAiGuide.Party) do\n        local tethers = Argus.getTethersOnEnt(ent.id)\n        if tethers and not table.contains(data.MuAiGd_FallOfFaithRecordIds, ent.id) then\n            for _, tether in pairs(tethers) do\n                if tether.type == 31 or tether.type == 249 then\n                    data.MuAiGd_FallOfFaithLinkCnt = data.MuAiGd_FallOfFaithLinkCnt + 1\n                    d(\"获取到[\" .. jobPos .. \"]点名，连线[\" .. data.MuAiGd_FallOfFaithLinkCnt .. \"]\")\n                    local curRecord = {\n                        player = ent,\n                        jobStr = jobPos,\n                        tetherType = tether.type,\n                        orderIndex = data.MuAiGd_FallOfFaithLinkCnt\n                    }\n                    table.insert(data.MuAiGd_FallOfFaithLink, curRecord)\n                    table.insert(data.MuAiGd_FallOfFaithRecordIds, ent.id)\n                    if MuAiGuide.IsMe(ent) then\n                        local hitMsg = \"/e 我被点名[\"\n                        data.MuAiGd_FallOfFaithLinkSelfIndex = data.MuAiGd_FallOfFaithLinkCnt\n                        local pos\n                        if tether.type == 31 then\n                            hitMsg = hitMsg .. data.MuAiGd_FallOfFaithLinkSelfIndex .. \"]号[雷]线连线了!<se.1><se.1><se.1>\"\n                            pos = data.MuAiGd_FallOfFaithLinkLightingPos[data.MuAiGd_FallOfFaithLinkCnt]\n                        else\n                            hitMsg = hitMsg .. data.MuAiGd_FallOfFaithLinkSelfIndex .. \"]号[火]线连线了!<se.1><se.1><se.1>\"\n                            pos = data.MuAiGd_FallOfFaithLinkFirePos[data.MuAiGd_FallOfFaithLinkCnt]\n                        end\n                        local time = 8500 - (data.MuAiGd_FallOfFaithLinkSelfIndex - 1) * 1000\n                        SendTextCommand(hitMsg)\n                        MuAiGuide.DirectTo(pos.x, pos.z, time, 0.3)\n                    end\n                end\n                break\n            end\n        end\n    end\n    -- 自己被点名，且4个连线人都计算完毕\n    if data.MuAiGd_FallOfFaithLinkSelfIndex > 0 and table.size(data.MuAiGd_FallOfFaithLink) >= 4 then\n        data.MuAiGd_FallOfFaithFinish = true\n        self.used = true\n        return\n    end\nelseif #data.MuAiGd_FallOfFaithRecordIds < 8 then\n    for jobPos, ent in pairs(MuAiGuide.Party) do\n        if not table.contains(data.MuAiGd_FallOfFaithRecordIds, ent.id) then\n            data.MuAiGd_FallOfFaithRest[jobPos] = ent\n            table.insert(data.MuAiGd_FallOfFaithRecordIds, ent.id)\n        end\n    end\n\n    for i = 1, #data.MuAiGd_FallOfFaithOrder, 1 do\n        local jobPos = data.MuAiGd_FallOfFaithOrder[i]\n        local curPlayer = data.MuAiGd_FallOfFaithRest[jobPos]\n        if curPlayer then\n            data.MuAiGd_FallOfFaithRestCnt = data.MuAiGd_FallOfFaithRestCnt + 1\n            if MuAiGuide.IsMe(curPlayer) then\n                data.MuAiGd_FallOfFaithRestSelfIndex = data.MuAiGd_FallOfFaithRestCnt\n                SendTextCommand(\"/e 没有连线，我是闲[\" .. data.MuAiGd_FallOfFaithRestSelfIndex .. \"]<se.2>\")\n                break\n            end\n        end\n    end\n    if data.MuAiGd_FallOfFaithRestSelfIndex > 0 then\n        local lookAt\n        local guidePos\n        local guideTime = 4000\n        -- 判断观察哪个人\n        if data.MuAiGd_FallOfFaithRestSelfIndex == 1 or data.MuAiGd_FallOfFaithRestSelfIndex == 2 then\n            lookAt = data.MuAiGd_FallOfFaithLink[1]\n        elseif data.MuAiGd_FallOfFaithRestSelfIndex == 3 or data.MuAiGd_FallOfFaithRestSelfIndex == 4 then\n            guideTime = guideTime + 3000\n            lookAt = data.MuAiGd_FallOfFaithLink[2]\n        end\n        if lookAt.tetherType == 31 then\n            guidePos = data.MuAiGd_FallOfFaithRestLightingPos[data.MuAiGd_FallOfFaithRestSelfIndex];\n        elseif lookAt.tetherType == 249 then\n            guidePos = data.MuAiGd_FallOfFaithRestFirePos[data.MuAiGd_FallOfFaithRestSelfIndex];\n        end\n        if guidePos then\n            MuAiGuide.DirectTo(guidePos.x, guidePos.z, guideTime, 0.3)\n        end\n    end\n    data.MuAiGd_FallOfFaithFinish = true\n    d(\"[MuAiGuide]============================== 雷火线第一波指路 && 数据采集结束 ============================\")\n    self.used = true\nend",
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
							actionLua = "--[[\n[MuAiGuide]DD冰花位置收集\n]]\nif data.MuAiGd_DiamondDustStartPoint == nil then\n    data.MuAiGd_DiamondDustStartPoint = {}\n    data.MuAiGd_DiamondDustNeedExChange = false\n    d(\"[MuAiGuide] ===================== DD冰花位置收集 =====================\")\nend\n\nif table.size(data.MuAiGd_DiamondDustStartPoint) < 2 then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=12809\")) do\n        local record = MuAiGuide.GetDirectionIndex({ x = 100, y = 0, z = 100 }, ent.pos)\n        if not table.contains(data.MuAiGd_DiamondDustStartPoint, record) and Argus.getEntityModel(ent.id) == 9020 then\n            table.insert(data.MuAiGd_DiamondDustStartPoint, record)\n            d(\"[MuAiGuide]采集到冰花位置：\" .. record)\n        end\n    end\n    if table.size(data.MuAiGd_DiamondDustStartPoint) == 2 then\n        d(\"[MuAiGuide] ===================== DD冰花位置完毕 =====================\")\n        self.used = true\n    end\nend",
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
							actionLua = "SendTextCommand(\"/e <se.3>回旋踢即将结束:[3]\" )\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "d1150595-03f0-9ffb-9efb-e9dcc70841ae",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 244.5,
				name = "[无脑DD噪音]倒计时3",
				timelineIndex = 46,
				timerOffset = -3,
				uuid = "4aaa70b2-e42a-227b-9c59-cb75915c73eb",
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
							actionLua = "SendTextCommand(\"/e <se.3>回旋踢即将结束:[2]\" )\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "7d3d9c00-403d-4acc-9de0-007a94dbaa24",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 244.5,
				name = "[无脑DD噪音]倒计时2",
				timelineIndex = 46,
				timerOffset = -2,
				uuid = "fe13d028-dc1b-e323-84e2-bd5bf13c87ff",
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
							actionLua = "SendTextCommand(\"/e <se.3>回旋踢即将结束:[1]\" )\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "513f77e2-ddaa-dd5b-ab49-946fcd9a47f6",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 244.5,
				name = "[无脑DD噪音]倒计时1",
				timelineIndex = 46,
				timerOffset = -1,
				uuid = "66e32b7f-bf1a-0a89-a6a8-8a4cb75670b3",
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
							actionLua = "SendTextCommand(\"/e <se.1><se.1><se.1>回旋踢已经结束，快走！\" )\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "a3ccb272-4541-3e6b-a06c-ac9dbcc993cf",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 244.5,
				name = "[无脑DD噪音]走走走",
				timelineIndex = 46,
				timerOffset = -0.0099999997764826,
				uuid = "34222189-c01f-7b31-ae4c-2a13fb6de5c1",
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
				timerOffset = -0.0099999997764826,
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
							actionLua = "local guideTime = 9000\nlocal buffId = 4157\nlocal linkBuff = TensorCore.getBuff(MuAiGuide.GetPlayer(), buffId)\n\n-- 计算是否有线（是否有线BUFF）\nif linkBuff ~= nil then\n    --连线定名\n    local TGroup = { \"MT\", \"ST\", \"H1\", \"H2\" }\n    local DGroup = { \"D1\", \"D2\", \"D3\", \"D4\" }\n    local selfLinkOrder = 0 --计算自己是第几个有线\n    local targetHeading = 0\n    if table.contains(TGroup, MuAiGuide.SelfPos) then\n        local index = MuAiGuide.IndexOf(TGroup, MuAiGuide.SelfPos)\n        for i = 1, index do\n            local curPlayer = MuAiGuide.Party[TGroup[i]]\n            if TensorCore.getBuff(curPlayer.id, buffId) then\n                selfLinkOrder = selfLinkOrder + 1\n            end\n            if MuAiGuide.IsMe(curPlayer) then\n                break\n            end\n        end\n        if selfLinkOrder == 1 then\n            targetHeading = math.pi * 4 / 3\n        elseif selfLinkOrder == 2 then\n            targetHeading = 0\n        elseif selfLinkOrder == 3 then\n            targetHeading = math.pi * 2 / 3\n        elseif selfLinkOrder == 4 then\n            targetHeading = math.pi * 5 / 3\n        end\n    elseif table.contains(DGroup, MuAiGuide.SelfPos) then\n        local index = MuAiGuide.IndexOf(DGroup, MuAiGuide.SelfPos)\n        for i = 1, index do\n            local curPlayer = MuAiGuide.Party[DGroup[i]]\n            if TensorCore.getBuff(curPlayer.id, buffId) then\n                selfLinkOrder = selfLinkOrder + 1\n                d(curPlayer.name)\n            end\n            if MuAiGuide.IsMe(curPlayer) then\n                break\n            end\n        end\n        if selfLinkOrder == 1 then\n            targetHeading = math.pi / 3\n        elseif selfLinkOrder == 2 then\n            targetHeading = math.pi\n        elseif selfLinkOrder == 3 then\n            targetHeading = math.pi * 5 / 3\n        elseif selfLinkOrder == 4 then\n            targetHeading = math.pi * 2 / 3\n        end\n    end\n    local targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, targetHeading, 16)\n    MuAiGuide.DirectTo(targetPos.x, targetPos.z, guideTime)\nelse\n    local guideTime2 = 16000\n    local fromA = {\n        { x = 100,   z = 92 },\n        { x = 106.1, z = 94.8 },\n        { x = 109,   z = 100.77 },\n        { x = 108,   z = 107.3 },\n        { x = 106,   z = 113.6 },\n    }\n    local fromC = {\n        { x = 100,  z = 108 },\n        { x = 93.9, z = 105.2 },\n        { x = 91,   z = 99.23 },\n        { x = 92,   z = 92.7 },\n        { x = 94,   z = 86.4 },\n    }\n    local draw = function(points)\n        for i = 1, #points do\n            local curPos = points[i]\n            local size = 0.5\n            MuAiGuide.DrawCircleUI(curPos.x, curPos.z, guideTime2, 0.5, 0, 255, 0, 0.7)\n            if i > 1 then\n                local lastPos = points[i - 1]\n                local heading = TensorCore.getHeadingToTarget(lastPos, curPos)\n                local length = TensorCore.getDistance2d(lastPos, curPos)\n                local pos = TensorCore.getPosInDirection(lastPos, heading, size + 0.1)\n                Argus2.addTimedArrowFilled(\n                    guideTime2,\n                    pos.x,\n                    0,\n                    pos.z,\n                    length - size * 2 - 1 - 0.2,\n                    size / 5 * 2,\n                    1,\n                    0.25,\n                    heading,\n                    GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 255 / 255, 0.7),\n                    GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 255 / 255, 0.7),\n                    GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 255 / 255, 0.7),\n                    0,\n                    nil,\n                    nil,\n                    GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1),\n                    1.0,\n                    3,\n                    0.05,\n                    true\n                )\n            end\n        end\n    end\n    draw(fromA)\n    draw(fromC)\nend\nself.used = true",
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
							actionLua = "if data.MuAiGd_P3_1_Lights == nil then\n    data.MuAiGd_P3_1_Lights = {}\n    data.MuGuide_GetDirType = function(fire)\n        if fire == nil then\n            return 4\n        end\n        if fire then\n            -- 长火\n            if fire.duration > 22 then\n                return 1\n            elseif fire.duration > 12 then\n                -- 中火\n                return 2\n            else\n                -- 短火\n                return 3\n            end\n        end\n    end\n    d(\"[MuAiGuide] ===================== P3一运查找关键灯-开始 =====================\")\nend\n-- 采集灯\nif table.size(data.MuAiGd_P3_1_Lights) < 8 then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=9825\")) do\n        local curHeading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, ent.pos)\n        table.insert(data.MuAiGd_P3_1_Lights, { entity = ent, heading = curHeading })\n    end\nend\n\n--获取12点\nif table.size(data.MuAiGd_P3_1_Lights) == 8 and data.MuAiGd_P3_1_Clock12 == nil then\n    local yellowLineInfo = {}\n    for _, info in pairs(data.MuAiGd_P3_1_Lights) do\n        local lines = Argus.getTethersOnEnt(info.entity.id)\n        for _, line in pairs(lines) do\n            if line.type == 134 then\n                table.insert(yellowLineInfo, info)\n                break\n            end\n        end\n    end\n    if table.size(yellowLineInfo) == 0 then\n        self.used = true\n        return\n    end\n    d(\"开始查找12点！\")\n    local not12 = {}\n    for i = 1, #yellowLineInfo do\n        for j = i + 1, #yellowLineInfo do\n            local diff = math.abs(yellowLineInfo[i].heading - yellowLineInfo[j].heading)\n            if diff > math.pi then\n                diff = diff - math.pi\n            end\n            --近似互为直角\n            if MuAiGuide.IsSame(diff, math.pi / 2) then\n                table.insert(not12, i)\n                table.insert(not12, j)\n                break\n            end\n        end\n        if table.size(not12) == 2 then\n            break\n        end\n    end\n    for i = 1, #yellowLineInfo do\n        if not table.contains(not12, i) then\n            data.MuAiGd_P3_1_Clock12 = yellowLineInfo[i]\n            break\n        end\n    end\n    if data.MuAiGd_P3_1_Clock12 ~= nil then\n        local pos = data.MuAiGd_P3_1_Clock12.entity.pos\n        MuAiGuide.DrawCircleFloor(pos.x, pos.z, 40000, 0.5, 255, 0, 0, 1)\n        local player = MuAiGuide.GetPlayer()\n        -- 处理方案，1 长火，2 中火，3 短火 4 冰\n        local type = data.MuGuide_GetDirType(TensorCore.getBuff(player, 2455))\n        d(\"P3 1 运buff分析: TYPE = \" .. type)\n        data.MuAiGd_P3_1_type = type\n        local dir\n        if MuAiGuide.IsDps(MuAiGuide.GetPlayer().job) then\n            if type == 1 or type == 4 then\n                dir = 0\n            elseif type == 2 then\n                dir = -math.pi / 2\n            else\n                for jobName, ptMember in pairs(MuAiGuide.Party) do\n                    --找到另外一个短火的人\n                    if MuAiGuide.IsDps(ptMember.job) and not MuAiGuide.IsMe(ptMember) then\n                        local fireOther = TensorCore.getBuff(ptMember.id, 2455);\n                        if fireOther and data.MuGuide_GetDirType(fireOther) == 3 then\n                            -- 找到了 开始判断优先级\n                            local selfOrder = MuAiGuide.IndexOf(MuAiGuide.JobPosName, MuAiGuide.SelfPos)\n                            local otherOrder = MuAiGuide.IndexOf(MuAiGuide.JobPosName, jobName)\n                            if selfOrder < otherOrder then\n                                -- 索引小的优先\n                                dir = math.pi / 4\n                            else\n                                dir = -math.pi / 4\n                            end\n                        end\n                    end\n                end\n            end\n        else\n            if type == 1 then\n                for jobName, ptMember in pairs(MuAiGuide.Party) do\n                    --找到另外一个短火的人\n                    if not MuAiGuide.IsDps(MuAiGuide.GetPlayer().job) and not MuAiGuide.IsMe(ptMember) then\n                        local fireOther = TensorCore.getBuff(ptMember.id, 2455);\n                        if fireOther and data.MuGuide_GetDirType(fireOther) == 1 then\n                            -- 找到了 开始判断优先级\n                            local selfOrder = MuAiGuide.IndexOf(MuAiGuide.JobPosName, MuAiGuide.SelfPos)\n                            local otherOrder = MuAiGuide.IndexOf(MuAiGuide.JobPosName, jobName)\n                            if selfOrder < otherOrder then\n                                -- 索引小的优先\n                                dir = 3 / 4 * math.pi\n                            else\n                                dir = -3 / 4 * math.pi\n                            end\n                        end\n                    end\n                end\n            elseif type == 2 then\n                dir = math.pi / 2\n            else\n                dir = math.pi\n            end\n        end\n        d(dir)\n        local finalDir = data.MuAiGd_P3_1_Clock12.heading + dir\n        if finalDir > math.pi * 2 then\n            finalDir = finalDir - math.pi * 2\n            if finalDir < 0 then\n                finalDir = finalDir + math.pi * 2\n            end\n        end\n        for _, light in pairs(data.MuAiGd_P3_1_Lights) do\n            if MuAiGuide.IsSame(light.heading, finalDir) then\n                data.MuAiGd_SelfLight = light\n                break\n            end\n        end\n        TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, .25), 2)\n            :addTimedArrow(40000, 100, 0, 100, data.MuAiGd_SelfLight.heading, 20, .3, .3, .3, 0, false)\n        d(\"[MuAiGuide] ===================== P3一运查找关键灯-结束 =====================\")\n    end\nend\nself.used = true\n",
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
				},
				eventType = 3,
				loop = true,
				mechanicTime = 532.4,
				name = "[MuAiGuide]查找关键灯",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 6,
				timerStartOffset = -1,
				uuid = "25b1fa05-3be0-87f3-a68f-dd660934ad10",
				version = 2,
			},
			inheritedIndex = 11,
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
							actionLua = "if data.MuAiGd_P3_1_GuideFlags == nil then\n    data.MuAiGd_P3_1_GuideFlags = {}\n    for i = 1, 10 do\n        table.insert(data.MuAiGd_P3_1_GuideFlags, false)\n    end\n    data.MuAiGd_P3_BackCenter = function()\n        if data.MuAiGd_P3_CenterPos == nil then\n            data.MuAiGd_P3_CenterPos = TensorCore.getPosInDirection({ x = 100, 0, z = 100 },\n                data.MuAiGd_SelfLight.heading, 1)\n        end\n        local targetPos = data.MuAiGd_P3_CenterPos\n        MuAiGuide.DirectTo(targetPos.x, targetPos.z, 6000, 0.3)\n    end\nend\n\nif data.MuAiGd_SelfLight ~= nil then\n    -- 火 1\n    local fire = TensorCore.getBuff(MuAiGuide.GetPlayer().id, 2455)\n    if fire and not data.MuAiGd_P3_1_GuideFlags[1]\n        -- 火buff小于5\n        and (fire.duration < 5 or data.MuAiGd_P3_1_type == 3)\n    then\n        d(\"火BUFF指路\")\n        local targetPos = TensorCore.getPosInDirection({ x = 100, 0, z = 100 }, data.MuAiGd_SelfLight.heading, 15.5) -- 15待定\n        data.MuAiGd_P3_1_GuideFlags[1] = true\n        MuAiGuide.DirectTo(targetPos.x, targetPos.z, 6000)\n    end\n\n    -- 回返 2\n    local darkFlame = TensorCore.getBuff(MuAiGuide.GetPlayer().id, 2460)\n    local delay = TensorCore.getBuff(MuAiGuide.GetPlayer().id, 2464)\n    if delay and delay.duration < 5 and not data.MuAiGd_P3_1_GuideFlags[2] then\n        d(\"回返BUFF指路\")\n        local targetPos\n        if darkFlame == nil then\n            targetPos = TensorCore.getPosInDirection({ x = 100, 0, z = 100 }, data.MuAiGd_SelfLight.heading, 1)\n        else\n            targetPos = data.MuAiGd_SelfLight.entity.pos\n        end\n        data.MuAiGd_P3_1_GuideFlags[2] = true\n        MuAiGuide.DirectTo(targetPos.x, targetPos.z, 6000, 0.3)\n    end\n\n    -- 分摊BUFF判定指路  3\n    local converge = TensorCore.getBuff(MuAiGuide.GetPlayer().id, 2454)\n    if (converge and converge.duration < 5) and not data.MuAiGd_P3_1_GuideFlags[3] then\n        d(\"分摊BUFF指路\")\n        data.MuAiGd_P3_1_GuideFlags[3] = true\n        data.MuAiGd_P3_BackCenter()\n    end\n\n    -- 冰buff 4\n    local ice = TensorCore.getBuff(MuAiGuide.GetPlayer().id, 2462)\n    if (ice and ice.duration < 5) and not data.MuAiGd_P3_1_GuideFlags[4] then\n        d(\"冰BUFF指路\")\n        data.MuAiGd_P3_1_GuideFlags[4] = true\n        data.MuAiGd_P3_BackCenter()\n    end\n\n    -- 回返放置后指路\n    local returnBuff = TensorCore.getBuff(MuAiGuide.GetPlayer().id, 2452)\n    if not data.MuAiGd_P3_1_GuideFlags[5] and returnBuff and returnBuff.duration > 0 then\n        d(\"出现 回返BUFF回中\")\n        data.MuAiGd_P3_1_GuideFlags[5] = true\n        data.MuAiGd_P3_BackCenter()\n    end\n\n    -- 通过回返倒计时进行最后BUFF判断\n    if returnBuff and returnBuff.duration < 3 and not data.MuAiGd_P3_1_GuideFlags[6] then\n        d(\"最后回中指路 指路\")\n        data.MuAiGd_P3_1_GuideFlags[6] = true\n        local targetPos = TensorCore.getPosInDirection({ x = 100, 0, z = 100 }, data.MuAiGd_SelfLight.heading, 1)\n        MuAiGuide.DirectTo(targetPos.x, targetPos.z, 10000)\n    end\n\n    -- 灯开始转了\n    -- 黄/顺\n    local turing = TensorCore.getBuff(data.MuAiGd_SelfLight.entity.id, 2970)\n    if turing and turing.duration > 0 and not data.MuAiGd_P3_1_GuideFlags[7] then\n        local posDir\n        d(\"引导灯\")\n        if turing.stacks == 269 then\n            -- 顺\n            posDir = data.MuAiGd_SelfLight.heading - 7 / 18 * math.pi;\n        elseif turing.stacks == 348 then\n            -- 逆\n            posDir = data.MuAiGd_SelfLight.heading + 7 / 18 * math.pi;\n        end\n        local pos = data.MuAiGd_SelfLight.entity.pos\n        Argus2.addTimedArrowFilled(\n            5000,\n            pos.x, 0, pos.z,\n            3, 0.2, 1, 0.25,\n            posDir,\n            GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, 0.5),\n            GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, 0.5),\n            GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, 0.5),\n            0,\n            nil,\n            nil,\n            GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1),\n            1.0,\n            3,\n            0.05,\n            true\n        )\n        local targetPos = TensorCore.getPosInDirection(pos, posDir, 1.5)\n        MuAiGuide.DirectTo(targetPos.x, targetPos.z, 6000, 0.2)\n        data.MuAiGd_P3_1_GuideFlags[7] = true\n    end\n\n    -- 引导灯结束了 且 获得了火伤buff，需要回中了\n    if data.MuAiGd_P3_1_GuideFlags[7] and not data.MuAiGd_P3_1_GuideFlags[8] then\n        local buff = TensorCore.getBuff(MuAiGuide.GetPlayer().id, 4383)\n        d(\"引导灯完成判断 成功\")\n        if buff and buff.duration >= 8 then\n            d(\"引导灯完成, 指路回中！\")\n            data.MuAiGd_P3_BackCenter()\n            data.MuAiGd_P3_1_GuideFlags[8] = true\n        end\n    end\nend\n\nself.used = true\n",
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
				},
				eventType = 3,
				loop = true,
				mechanicTime = 532.4,
				name = "[MuAiGuide]处理BUFF",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 42,
				timerStartOffset = -1,
				uuid = "98a8e885-2585-3698-9dca-9cbeb102b5bc",
				version = 2,
			},
			inheritedIndex = 12,
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
							actionLua = "--2个9秒，2个28秒，2个37秒。还有两个玩家无点名。 [MuAiGuide]排优先级\nlocal typeMap = {}\nfor i = 1, #MuAiGuide.JobPosName do\n    local jobName = MuAiGuide.JobPosName[i]\n    local party = MuAiGuide.Party[jobName]\n    local waterBuff = TensorCore.getBuff(party.id, 2461)\n    local type -- 长 1 中2 短3 无4\n    if waterBuff then\n        if waterBuff.duration > 30 then\n            type = 1\n        elseif waterBuff.duration > 20 then\n            type = 2\n        else\n            type = 3\n        end\n    else\n        type = 4\n    end\n    if not typeMap[type] then\n        typeMap[type] = { jobName }\n    else\n        table.insert(typeMap[type], jobName)\n    end\nend\n\n-- 左侧基础站位\nlocal LeftBaseGroup = { \"MT\", \"ST\", \"H1\", \"H2\" }\n-- 右侧基础站位\nlocal RightBaseGroup = { \"D1\", \"D2\", \"D3\", \"D4\" }\n\nlocal L2R = {}\nlocal R2L = {}\nlocal ChangeOrder = function(tbl)\n    if table.size(tbl) == 1 then\n        return { tbl[1], tbl[2] }\n    else\n        local index1 = MuAiGuide.IndexOf(MuAiGuide.JobPosName, tbl[1])\n        local index2 = MuAiGuide.IndexOf(MuAiGuide.JobPosName, tbl[2])\n        if index1 > index2 then\n            return { tbl[2], tbl[1] }\n        end\n    end\n    return { tbl[1], tbl[2] }\nend\n\nfor _, list in pairs(typeMap) do\n    if table.contains(LeftBaseGroup, list[1]) and table.contains(LeftBaseGroup, list[2]) then\n        --同属TH\n        table.insert(L2R, list[2])\n    elseif table.contains(RightBaseGroup, list[1]) and table.contains(RightBaseGroup, list[2]) then\n        --同属D\n        table.insert(R2L, list[2])\n    end\nend\n\nL2R = ChangeOrder(L2R)\nR2L = ChangeOrder(R2L)\nfor i = 1, #L2R do\n    if L2R[i] == MuAiGuide.SelfPos then\n        local p = MuAiGuide.Party[R2L[i]]\n        local curP = TensorCore.mGetEntity(p.id)\n        MuAiGuide.DirectTo(curP.pos.x, curP.pos.z, 5000)\n        SendTextCommand(\"/e 与\" .. R2L[i] .. \"交换位置！<se.1>\")\n        data.MuAiGd_P3_2_SelfJob = R2L[i]\n        self.used = true\n        return\n    elseif R2L[i] == MuAiGuide.SelfPos then\n        local p = MuAiGuide.Party[L2R[i]]\n        local curP = TensorCore.mGetEntity(p.id)\n        MuAiGuide.DirectTo(curP.pos.x, curP.pos.z, 5000)\n        SendTextCommand(\"/e 与\" .. L2R[i] .. \"交换位置！<se.1>\")\n        data.MuAiGd_P3_2_SelfJob = L2R[i]\n        self.used = true\n        return\n    else\n        SendTextCommand(\"/e \" .. L2R[i] .. \"与\" .. R2L[i] .. \"交换位置！\")\n    end\nend\nSendTextCommand(\"/e 我不换！<se.3>\")\ndata.MuAiGd_P3_2_SelfJob = MuAiGuide.SelfPos\nself.used = true\n",
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
							actionLua = "if data.MuAiGd_P3_2_Objects == nil then\n    data.MuAiGd_P3_2_Objects = {}\n    data.MuAiGd_P3_2_Ids = {}\n    data.MuAiGd_P3_2_GroundFireFinish = false\nend\n\nif eventArgs.entityContentID == 2011391\n    and not table.contains(data.MuAiGd_P3_2_Ids, eventArgs.entityID)\n    and table.size(data.MuAiGd_P3_2_Ids) < 6\nthen\n    table.insert(data.MuAiGd_P3_2_Ids, eventArgs.entityID)\n\n    local debugEnt = TensorCore.mGetEntity(eventArgs.entityID)\n    if table.size(data.MuAiGd_P3_2_Ids) > 2 then\n        d(MuAiGuide.GetDirectionIndex({ x = 100, y = 0, z = 100 }, debugEnt.pos))\n    end\n    \n    if table.size(data.MuAiGd_P3_2_Ids) == 6 and data.MuAiGd_P3_2_GroundFireFinish == false\n    then\n        --- 绘制方向箭头\n        local drawClock = function(director, index)\n            local baseEnt = TensorCore.mGetEntity(data.MuAiGd_P3_2_Ids[index])\n            local baseDir = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, baseEnt.pos)\n            for i = 1, 3 do\n                local curDir\n                local heading\n                if director == 1 then\n                    curDir = baseDir - math.pi / 4 * i\n                    heading = curDir - math.pi / 2\n                else\n                    curDir = baseDir - math.pi / 4 * i\n                    heading = curDir + math.pi / 2\n                end\n                local startPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, curDir, 14)\n                local pos = TensorCore.getPosInDirection(startPos, heading, -3)\n                Argus2.addTimedArrowFilled(\n                    15000,\n                    pos.x, 0, pos.z,\n                    5,\n                    2.5,\n                    3,\n                    4,\n                    heading,\n                    GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 0, 0 / 255, 0.2),\n                    GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 0, 0 / 255, 0.2),\n                    GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 0, 0 / 255, 0.2),\n                    0,\n                    nil,\n                    nil,\n                    GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1),\n                    1.0,\n                    3,\n                    0.05,\n                    false\n                )\n            end\n        end\n\n        local dir3 = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 },\n            TensorCore.mGetEntity(data.MuAiGd_P3_2_Ids[3]).pos)\n        local dir4 = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 },\n            TensorCore.mGetEntity(data.MuAiGd_P3_2_Ids[4]).pos)\n        local dir5 = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 },\n            TensorCore.mGetEntity(data.MuAiGd_P3_2_Ids[5]).pos)\n        local director = 0\n        if dir3 > dir5 then\n            d(\"顺时针\")\n            director = 1\n        else\n            d(\"逆时针\")\n            director = 2\n        end\n        -- 画出方向箭头\n        drawClock(director, 3)\n        drawClock(director, 4)\n        -- 计算车头法站位\n        local firstDir = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 },\n            TensorCore.mGetEntity(data.MuAiGd_P3_2_Ids[3]).pos)\n        if firstDir > math.pi then\n            firstDir = firstDir - math.pi\n        end\n\n        local headDir1 = MuAiGuide.SafeHeadingChange(firstDir, math.pi / 2, 0, 2 * math.pi, 2 * math.pi)\n        local headDir2 = MuAiGuide.SafeHeadingChange(firstDir, -math.pi / 2, 0, 2 * math.pi, 2 * math.pi)\n        local headDps, headTh\n        if headDir1 > headDir2 then\n            headTh = headDir1\n            headDps = headDir2\n        else\n            headTh = headDir2\n            headDps = headDir1\n        end\n\n        local posTable\n        if director == 1 then\n            posTable = {\n                [\"MT\"] = { h = headTh, r = 10 },\n                [\"ST\"] = { h = headTh - math.pi / 4, r = 10 },\n                [\"H1\"] = { h = headTh - math.pi / 4 - math.pi / 14, r = 18 },\n                [\"H2\"] = { h = headTh - math.pi / 4 + math.pi / 14, r = 18 },\n                [\"D1\"] = { h = headDps, r = 10 },\n                [\"D2\"] = { h = headDps - math.pi / 4, r = 10 },\n                [\"D3\"] = { h = headDps - math.pi / 4 - math.pi / 14, r = 18 },\n                [\"D4\"] = { h = headDps - math.pi / 4 + math.pi / 14, r = 18 },\n            }\n        else\n            posTable = {\n                [\"MT\"] = { h = headTh, r = 10 },\n                [\"ST\"] = { h = headTh + math.pi / 4, r = 10 },\n                [\"H1\"] = { h = headTh + math.pi / 4 - math.pi / 14, r = 18 },\n                [\"H2\"] = { h = headTh + math.pi / 4 + math.pi / 14, r = 18 },\n                [\"D1\"] = { h = headDps, r = 10 },\n                [\"D2\"] = { h = headDps + math.pi / 4, r = 10 },\n                [\"D3\"] = { h = headDps + math.pi / 4 - math.pi / 14, r = 18 },\n                [\"D4\"] = { h = headDps + math.pi / 4 + math.pi / 14, r = 18 },\n            }\n        end\n\n        local index = data.MuAiGd_P3_2_SelfJob\n        local targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, posTable[index].h, posTable[index].r)\n        MuAiGuide.DirectTo(targetPos.x, targetPos.z, 10000)\n        data.MuAiGd_P3_2_GroundFireFinish = true\n        d(\"地火指路完成！\")\n    end\nend\nself.used = true",
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
			inheritedIndex = 10,
		},
	},
	[149] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "ACR",
							gVar = "ACR_TensorRequiem3_Hotbar_Sprint",
							uuid = "93ba554b-888a-30ce-b01f-017c611e5f5c",
							variableTogglesType = 2,
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 642.1,
				name = "[MuAiGuide]远程疾跑",
				timelineIndex = 149,
				timerOffset = -7,
				uuid = "2875c3f3-f371-ca51-b1e0-44d15f987311",
				version = 2,
			},
		},
	},
	inheritedProfiles = 
	{
	},
	mapID = 1238,
	version = 5,
}



return tbl