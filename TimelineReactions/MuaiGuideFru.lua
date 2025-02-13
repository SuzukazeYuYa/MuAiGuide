local tbl = 
{
	
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
							actionLua = "local selfIndex = MuAiGuide.IndexOf(MuAiGuide.Config.FruCfg.JobPos, MuAiGuide.SelfPos)\ndata.MuAiGd_P1_8_BaseHeading = (selfIndex - 1) * math.pi / 4\nlocal pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, data.MuAiGd_P1_8_BaseHeading, 7)\nMuAiGuide.DirectTo(pos.x, pos.z, 10000)\nfor _, ent in pairs(TensorCore.entityList(\"contentid=9707\")) do\n    if Argus.isEntityVisible(ent) then\n        data.MuAiGd_P1_BOSS = ent\n        break\n    end\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "25e6b076-bdfc-d583-b16b-027d0cb6cd1c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 13.7,
				name = "[MuAiGuide]8方",
				timelineIndex = 1,
				timerOffset = -12,
				uuid = "db69b28f-01d0-ec40-a2c6-7157106baa6d",
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
							actionLua = "local bossPos = TensorCore.mGetEntity(data.MuAiGd_P1_BOSS.id).pos\nlocal heading = bossPos.h - math.pi + data.MuAiGd_P1_8_BaseHeading\ndata.MuAiGd_P1_8_BossHeading = heading\nlocal distance\nif TensorCore.isAnyEntityCasting(40144) then -- 火\n    data.MuAiGd_P1_8_Type1 = 1\n    distance = 6\nelse\n    data.MuAiGd_P1_8_Type1 = 2\n    local melees = { \"MT\", \"ST\", \"D1\", \"D2\" }\n\n    if table.contains(melees, MuAiGuide.SelfPos) then\n        distance = 6\n    else\n        distance = 14\n    end\nend\nlocal pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, distance)\nMuAiGuide.DirectTo(pos.x, pos.z, 5000)\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "25e6b076-bdfc-d583-b16b-027d0cb6cd1c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 13.7,
				name = "[MuAiGuide]BOSS8方",
				timelineIndex = 1,
				timerOffset = -5,
				uuid = "63663593-7871-8d7a-8751-3b224a3c37e7",
				version = 2,
			},
		},
	},
	
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
							actionLua = "local heading = data.MuAiGd_P1_8_BossHeading\nlocal tankHealer = { \"MT\", \"ST\", \"H1\", \"H2\" }\nif table.contains(tankHealer, MuAiGuide.SelfPos) then\n    heading = heading + math.pi / 8\nelse\n    heading = heading - math.pi / 8\nend\n\nlocal bossPos = TensorCore.mGetEntity(data.MuAiGd_P1_BOSS.id).pos\nlocal distance = TensorCore.getDistance2d(MuAiGuide.GetPlayer().pos, bossPos)\nlocal pos = TensorCore.getPosInDirection(bossPos, heading, distance)\nMuAiGuide.DirectTo(pos.x, pos.z, 5000)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "eb782d2d-bfbe-5bd9-bcf4-ccd1a584451d",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 14.4,
				name = "[MuAiGuide]躲",
				timelineIndex = 2,
				uuid = "1691a491-98f8-68ea-8a7b-ab58c3c56a7c",
				version = 2,
			},
		},
	},
	
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
							actionLua = "local bossPos = TensorCore.mGetEntity(data.MuAiGd_P1_BOSS.id).pos\nlocal distance = TensorCore.getDistance2d(MuAiGuide.GetPlayer().pos, bossPos)\nlocal pos = TensorCore.getPosInDirection(bossPos, data.MuAiGd_P1_8_BossHeading, distance)\nMuAiGuide.DirectTo(pos.x, pos.z, 3000)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "eb782d2d-bfbe-5bd9-bcf4-ccd1a584451d",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 16.4,
				name = "[MuAiGuide]回",
				timelineIndex = 3,
				uuid = "1c3044b6-be9f-ffc6-b5ea-597744ca14d5",
				version = 2,
			},
			inheritedIndex = 1,
		},
	}, 
	[5] = 
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
							actionLua = "local heading = data.MuAiGd_P1_8_BossHeading\nlocal tankHealer = { \"MT\", \"ST\", \"H1\", \"H2\" }\nif table.contains(tankHealer, MuAiGuide.SelfPos) then\n    heading = heading + math.pi / 8\nelse\n    heading = heading - math.pi / 8\nend\n\nlocal bossPos = TensorCore.mGetEntity(data.MuAiGd_P1_BOSS.id).pos\nlocal distance = TensorCore.getDistance2d(MuAiGuide.GetPlayer().pos, bossPos)\nlocal pos = TensorCore.getPosInDirection(bossPos, heading, distance)\nMuAiGuide.DirectTo(pos.x, pos.z, 2000)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "eb782d2d-bfbe-5bd9-bcf4-ccd1a584451d",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 18.4,
				name = "[MuAiGuide]躲",
				timelineIndex = 5,
				uuid = "88d6bd89-b470-541c-9739-271449826418",
				version = 2,
			},
			inheritedIndex = 1,
		},
	},
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
							actionLua = "local M = MuAiGuide\nlocal drawTime = 10000\nif data.MuAiGd_SinsmokeIndex == nil then\n    data.MuAiGd_SinsmokeIndex = {}\n    -- 雾龙站位情况C开始逆时针一圈, 如果站位不同可以修改这里\n    data.MuAiGd_SinsmokeJobOrder = { \"H2\", \"D2\", \"D4\", \"ST\", \"MT\", \"D3\", \"H1\", \"D1\" }\n    data.MuAiGd_SinsmokeGuideFinish = false\n    M.Debug(\"================================== 雾龙计算开始 ====================================\")\nend\n\nif table.size(data.MuAiGd_SinsmokeIndex) < 3 then\n    -- 采集阶段\n    for _, ent in pairs(TensorCore.entityList(\"contentid=9708\")) do\n        if ent.action == 210 then\n            -- 抬手\n            local pos = M.GetDirectionIndex({ x = 100, z = 100 }, { x = ent.pos.x, z = ent.pos.z })\n            table.insert(data.MuAiGd_SinsmokeIndex, pos)\n            --如果是自己，那么自己往前走\n            local jobName = data.MuAiGd_SinsmokeJobOrder[pos]\n            if jobName then\n                if M.IsMeByPos(jobName) then\n                    -- 指路到前面(给对面的人看的)\n                    local pos1 = M.GetPointAtDistance({ x = 100, y = 0, z = 100 }, ent.pos, 10)\n                    M.DirectTo(pos1.x, pos1.z, 2000)\n                end\n            end\n        end\n    end\nend\n\nif table.size(data.MuAiGd_SinsmokeIndex) == 3\n    and data.MuAiGd_SinsmokeGuideFinish == false then\n   \n    local danger = {}\n    for i = 1, 3, 1 do\n        local pos = data.MuAiGd_SinsmokeIndex[i]\n        table.insert(danger, pos)\n        local opposite = pos + 4\n        if opposite > 8 then\n            opposite = opposite - 8\n        end\n        table.insert(danger, opposite)\n    end\n\n    local safeHeading\n    local selfOrder = M.IndexOf(data.MuAiGd_SinsmokeJobOrder, M.SelfPos)\n    for i = 1, 8, 1 do\n        if not table.contains(danger, i) then\n            if (selfOrder >= 5 and i >= 5) or (selfOrder <= 4 and i <= 4) then\n                safeHeading = (i - 1) * math.pi / 4\n            end\n        end\n    end\n\n    -- debug start\n    local msg = \"危险点\"\n    for i = 1, #danger do\n        msg = msg .. \", \" .. danger[i]\n    end\n    M.Debug(msg)\n    msg = \"本组安全区\" .. (safeHeading / math.pi)\n    M.Debug(msg)\n    local infoPoint = M.GetGamePointByHeading(M.Config.FruCfg.PosInfo, safeHeading)\n   \n    -- debug end\n\n    local targetPos\n    if data.MuAiGd_SinsmokeType == 1 then\n        --分摊\n        targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, safeHeading, 13)\n        M.Info(\"去\" .. infoPoint .. \"点，分摊。\")\n    elseif data.MuAiGd_SinsmokeType == 2 then\n        -- 按照如下站位进下的指路\n        --      H\n        -- 近   T   远\n        -- 如果站位不同，需要修改\n        if M.SelfPos == \"MT\" or M.SelfPos == \"ST\" then\n            targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, safeHeading, 19.5)\n        elseif M.SelfPos == \"H1\" or M.SelfPos == \"H2\" then\n            targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, safeHeading, 13)\n        elseif M.SelfPos == \"D1\" or M.SelfPos == \"D2\" then\n            targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, safeHeading - 0.105 * math.pi, 19.5)\n        elseif M.SelfPos == \"D3\" or M.SelfPos == \"D4\" then\n            targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, safeHeading + 0.105 * math.pi, 19.5)\n        end\n        M.Info(\"去\" .. infoPoint .. \"点，分散。\")\n    end\n\n    if table.contains(data.MuAiGd_SinsmokeIndex, selfOrder) then\n        M.DirectTo(targetPos.x, targetPos.z, 8000, 0.5, 2000)\n    else\n        M.DirectTo(targetPos.x, targetPos.z, drawTime)\n    end\n    data.MuAiGd_SinsmokeGuideFinish = true\n    M.Debug(\"================================== 雾龙计算结束 ====================================\")\nend\n\nself.used = true\n",
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
	[32] = 
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
							actionLua = "local one = { 40131, 40135 }\nlocal two = { 40122, 40125 }\nlocal three = { 40123, 40126 }\nlocal four = { 40124, 40127 }\n\nif data.MuAiGd_P1_Towers == nil then\n    data.MuAiGd_P1_Towers = {}\nend\n\nif table.contains(one, eventArgs.spellID) then\n    local ent = TensorCore.mGetEntity(eventArgs.entityID)\n    table.insert(data.MuAiGd_P1_Towers, { entity = ent, need = 1 })\nelseif table.contains(two, eventArgs.spellID) then\n    local ent = TensorCore.mGetEntity(eventArgs.entityID)\n    table.insert(data.MuAiGd_P1_Towers, { entity = ent, need = 2 })\nelseif table.contains(three, eventArgs.spellID) then\n    local ent = TensorCore.mGetEntity(eventArgs.entityID)\n    table.insert(data.MuAiGd_P1_Towers, { entity = ent, need = 3 })\nelseif table.contains(four, eventArgs.spellID) then\n    local ent = TensorCore.mGetEntity(eventArgs.entityID)\n    table.insert(data.MuAiGd_P1_Towers, { entity = ent, need = 4 })\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"efe1e409-1d08-9ae8-8701-bbc0288e0a9f",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "54a27c0c-6796-08ef-91e8-238265170ca9",
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
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "塔读条ID",
							spellIDList = 
							{
								40122,
								40123,
								40124,
								40125,
								40126,
								40127,
								40131,
								40135,
							},
							uuid = "efe1e409-1d08-9ae8-8701-bbc0288e0a9f",
							version = 2,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 140.9,
				name = "[MuAiGuide]塔数据采集",
				timeRange = true,
				timelineIndex = 32,
				timerEndOffset = -2,
				timerStartOffset = -10,
				uuid = "6f235a4a-a910-3ae1-a40d-e69d2bf4bf23",
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
							actionLua = "data.MuAiGd_P1_TowerCastingType = eventArgs.spellID\nself.used = true\n",
							conditions = 
							{
								
								{
									"de1aaff4-b6a9-a121-8871-069f75bccd9c",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "0700d340-a1b3-02fd-ba00-077aae5e464c",
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
							eventArgOptionType = 3,
							eventArgType = 2,
							spellIDList = 
							{
								40129,
								40133,
							},
							uuid = "de1aaff4-b6a9-a121-8871-069f75bccd9c",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 140.9,
				name = "[MuAiGuide]读条采集",
				timeRange = true,
				timelineIndex = 32,
				timerEndOffset = -2,
				timerStartOffset = -10,
				uuid = "fc962f58-cd80-e8c5-93a6-b4c81ee10b57",
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
							actionLua = "if MuAiGuide.SelfPos ~= \"MT\" and MuAiGuide.SelfPos ~= \"ST\" then\n    local towers = table.deepcopy(data.MuAiGd_P1_Towers)\n    table.sort(towers, function(a, b)\n        return a.entity.pos.z < b.entity.pos.z\n    end)\n    local infoPos = function(index)\n        if index == 1 then\n            return \"上\"\n        elseif index == 2 then\n            return \"中\"\n        elseif index == 3 then\n            return \"下\"\n        end\n        return \"\"\n    end\n    local towerIdx\n    -- 小学塔\n    if MuAiGuide.Config.FruCfg.TakeTowerType == 1 then\n        local selfIndex = MuAiGuide.IndexOf(MuAiGuide.Config.FruCfg.FallTowerOrder, MuAiGuide.SelfPos)\n        if selfIndex <= towers[1].need then\n            towerIdx = 1\n        elseif towers[1].need < selfIndex and selfIndex <= towers[1].need + towers[2].need then\n            towerIdx = 2\n        elseif towers[1].need + towers[2].need < selfIndex and selfIndex <= 6 then\n            towerIdx = 3\n        end\n        MuAiGuide.Info(\"填充踩塔，去\" .. infoPos(towerIdx) .. \"塔\")\n    else\n        if table.contains(MuAiGuide.Config.FruCfg.FixTowerUp, MuAiGuide.SelfPos) then\n            if MuAiGuide.Config.FruCfg.FixTowerUp[1] == MuAiGuide.SelfPos or towers[1].need >= 2 then\n                towerIdx = 1\n            else\n                if towers[2].need > 2 then\n                    towerIdx = 2\n                else\n                    towerIdx = 3\n                end\n            end\n        elseif table.contains(MuAiGuide.Config.FruCfg.FixTowerMid, MuAiGuide.SelfPos) then\n            if MuAiGuide.Config.FruCfg.FixTowerMid[1] == MuAiGuide.SelfPos or towers[2].need >= 2 then\n                towerIdx = 2\n            else\n                if towers[1].need > 2 then\n                    towerIdx = 1\n                else\n                    towerIdx = 3\n                end\n            end\n        elseif table.contains(MuAiGuide.Config.FruCfg.FixTowerDown, MuAiGuide.SelfPos) then\n            if MuAiGuide.Config.FruCfg.FixTowerDown[1] == MuAiGuide.SelfPos or towers[3].need >= 2 then\n                towerIdx = 3\n            else\n                if towers[1].need > 2 then\n                    towerIdx = 1\n                else\n                    towerIdx = 2\n                end\n            end\n        end\n\n        MuAiGuide.Info(\"固定踩塔，去\" .. infoPos(towerIdx) .. \"塔\")\n    end\n\n    local towerPos = towers[towerIdx].entity.pos\n    data.MuAiGd_P1_SelfTowerInfo = { Index = towerIdx, Pos = towerPos }\n\td(data.MuAiGd_P1_TowerCastingType)\n    if data.MuAiGd_P1_TowerCastingType == 40129 then\n        local posX, posZ\n        if towerPos.x > 100 then\n            posX = 106\n        else\n            posX = 94\n        end\n        if towerIdx == 1 then\n            posZ = 94\n        elseif towerIdx == 2 then\n            posZ = 100\n        elseif towerIdx == 3 then\n            posZ = 106\n        end\n        MuAiGuide.DirectTo(posX, posZ, 6000)\n    elseif data.MuAiGd_P1_TowerCastingType == 40133 then\n        MuAiGuide.DirectTo(towerPos.x, towerPos.z, 10000)\n    end\nelse\n\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"580974dc-f238-142e-8c97-10454362f8c5",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "c5bdcc5c-2318-a466-9a53-e311565dd1a5",
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
							conditionLua = "return data.MuAiGd_P1_TowerCastingType ~= nil\nand  data.MuAiGd_P1_Towers ~= nil and table.size(data.MuAiGd_P1_Towers) >= 3",
							name = "获取到读条和塔信息",
							uuid = "580974dc-f238-142e-8c97-10454362f8c5",
							version = 2,
						},
					},
				},
				mechanicTime = 140.9,
				name = "[MuAiGuide]踩塔指路",
				timeRange = true,
				timelineIndex = 32,
				timerEndOffset = 10,
				timerStartOffset = -10,
				uuid = "d313db81-8d8e-da94-8c73-d3d01aebbffc",
				version = 2,
			},
			inheritedIndex = 7,
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
							actionLua = "d(data.MuAiGd_P1_TowerCastingType)\nif data.MuAiGd_P1_TowerCastingType == 40129 then\n    local posX, posZ\n    if data.MuAiGd_P1_SelfTowerInfo.Pos.x > 100 then\n        posX = 101\n    else\n        posX = 99\n    end\n    if data.MuAiGd_P1_SelfTowerInfo.Index == 1 then\n        posZ = 94\n    elseif data.MuAiGd_P1_SelfTowerInfo.Index == 2 then\n        posZ = 100\n    elseif data.MuAiGd_P1_SelfTowerInfo.Index == 3 then\n        posZ = 106\n    end\n    MuAiGuide.DirectTo(posX, posZ, 4000)\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "56b76848-40a6-9c88-a384-92eb80bf56e2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 140.9,
				name = "[MuAiGuide]火靠近",
				timelineIndex = 32,
				uuid = "bed0da6f-ee8d-e3df-8bbd-7d36f25ae95b",
				version = 2,
			},
			inheritedIndex = 8,
		},
	},
	[33] = 
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
							actionLua = "if data.MuAiGd_P1_TowerCastingType == 40129 then\n    local towerPos = data.MuAiGd_P1_SelfTowerInfo.Pos\n    MuAiGuide.DirectTo(towerPos.x, towerPos.z, 2100)\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "11df3678-7386-177e-aba4-19239e145091",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 142.9,
				name = "[MuAiGuide]指塔",
				timelineIndex = 33,
				uuid = "43c5dedd-ee48-577f-babb-f51c170e21d3",
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
							actionLua = "local M = MuAiGuide\nif data.MuAiGd_DiamondDustTarget == nil then\n    M.Debug(\"===================== DD冰花位置收集 && DD 指路1 =====================\")\n    data.MuAiGd_DiamondDustTarget = {}\n    -- C逆\n    data.MuAiGd_DiamondDustJobPos = { \"H2\", \"D2\", \"ST\", \"D4\", \"MT\", \"D3\", \"H1\", \"D1\" }\n    data.MuAiGd_DiamondDustSelfGuideDir = 0\n    ---  DD中的1情况  1： 钢铁冰花，2：钢铁水波，3：月环冰花，4：月环水波\n    data.MuAiGd_DiamondDustSelfGuideType = 0\nend\n\n\nif table.size(data.MuAiGd_DiamondDustTarget) < 4 then\n    for jobPos, player in pairs(M.Party) do\n        if player.id == eventArgs.entityID then\n            table.insert(data.MuAiGd_DiamondDustTarget, M.IndexOf(data.MuAiGd_DiamondDustJobPos, jobPos))\n            break\n        end\n    end\n    if table.size(data.MuAiGd_DiamondDustTarget) == 4 then\n        -- 如果点名人的站位序列和初次出现的2个冰花存在重合, 则需要换位\n        for i = 1, #data.MuAiGd_DiamondDustTarget do\n            for j = 1, #data.MuAiGd_DiamondDustStartPoint do\n                if data.MuAiGd_DiamondDustStartPoint[j] == data.MuAiGd_DiamondDustTarget[i] then\n                    data.MuAiGd_DiamondDustNeedExChange = true\n                    M.Info(\"点名和冰花方向重合，需要换位。\")\n                    break\n                end\n            end\n            if data.MuAiGd_DiamondDustNeedExChange then\n                break\n            end\n        end\n\n        -- 计算指路方位\n        local selfBaseDir = M.IndexOf(data.MuAiGd_DiamondDustJobPos, M.SelfPos)\n        if data.MuAiGd_DiamondDustNeedExChange then\n            if M.IsDps(M.GetPlayer().job) then\n                data.MuAiGd_DiamondDustSelfGuideDir = selfBaseDir - 1\n            else\n                data.MuAiGd_DiamondDustSelfGuideDir = selfBaseDir + 1\n            end\n            if data.MuAiGd_DiamondDustSelfGuideDir > 8 then\n                data.MuAiGd_DiamondDustSelfGuideDir = data.MuAiGd_DiamondDustSelfGuideDir - 8\n            elseif data.MuAiGd_DiamondDustSelfGuideDir < 0 then\n                data.MuAiGd_DiamondDustSelfGuideDir = data.MuAiGd_DiamondDustSelfGuideDir + 8\n            end\n        else\n            data.MuAiGd_DiamondDustSelfGuideDir = selfBaseDir\n        end\n\n        -- 指路时间\n        -- 钢铁时间\n        local timeAimFar = 7000  -- 冰花人： 直接指过去，呆着\n        local timeFar = 5000     -- 无冰花人： 指过去，等钢/月判定后立刻回中，当前脚本仅指路第一阶段\n        -- 月环时间\n        local timeAimNear = 5000 -- 冰花人 指路到 钢/月判定\n        local timeNear = 5000    -- 没冰花人，呆着\n\n        local guideTime\n        local guideDistance\n        if TensorCore.isAnyEntityCasting(40203) then\n            data.MuAiGd_DiamondDustStandType = 1 --月环\n            -- 冰花点名\n            if table.contains(data.MuAiGd_DiamondDustTarget, selfBaseDir) then\n                guideTime = timeAimNear\n                guideDistance = 3.7\n                data.MuAiGd_DiamondDustSelfGuideType = 3 --月环冰花\n            else\n                guideTime = timeNear\n                guideDistance = 1.5\n                data.MuAiGd_DiamondDustSelfGuideType = 4 --月环水波\n            end\n        elseif TensorCore.isAnyEntityCasting(40202) then\n            data.MuAiGd_DiamondDustStandType = 2 --钢铁\n            -- 冰花点名\n            if table.contains(data.MuAiGd_DiamondDustTarget, selfBaseDir) then\n                guideTime = timeAimFar\n                guideDistance = 19.7\n                data.MuAiGd_DiamondDustSelfGuideType = 1 --钢铁冰花\n            else\n                guideTime = timeFar\n                guideDistance = 16.5\n                data.MuAiGd_DiamondDustSelfGuideType = 2 --钢铁水波\n            end\n        end\n\n        local guidePos = TensorCore.getPosInDirection(\n            { x = 100, y = 0, z = 100 },\n            (data.MuAiGd_DiamondDustSelfGuideDir - 1) * math.pi / 4,\n            guideDistance)\n        M.DirectTo(guidePos.x, guidePos.z, guideTime, 0.3)\n        M.Debug(\"===================== DD冰花位置收集 && DD 指路1 结束 =====================\")\n        self.used = true\n    end\nend\n",
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
				timerOffset = -0.20000000298023,
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
							actionLua = "-- 1： 钢铁冰花，2：钢铁水波，3：月环冰花，4：月环水波\nif data.MuAiGd_DiamondDustSelfGuideType == 1 then\n    -- 立刻回中 大约2500后前往击退位置\n    MuAiGuide.DirectTo(100, 100, 2500)\n    MuAiGuide.DirectTo(data.MuAiGd_DiamondDustKnockBackPos.x, data.MuAiGd_DiamondDustKnockBackPos.z, 2500, 0.5, 2500)\nelseif data.MuAiGd_DiamondDustSelfGuideType == 2 then\n    -- 不管\nelseif data.MuAiGd_DiamondDustSelfGuideType == 3 then\n    -- 场中指路1秒 后 指路到击退位置\n    MuAiGuide.DirectTo(100, 100, 1000)\n    MuAiGuide.DirectTo(data.MuAiGd_DiamondDustKnockBackPos.x, data.MuAiGd_DiamondDustKnockBackPos.z, 2500, 0.5, 1000)\nelseif data.MuAiGd_DiamondDustSelfGuideType == 4 then\n    -- 不管\nend\n\nself.used = true\n",
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
	[50] = 
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
							actionLua = "local drawTime = 13000\nlocal selfHeading = MuAiGuide.SetHeading2Pi(TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, data.MuAiGd_DiamondDustKnockBackPos))\nlocal distance = 16.1\nlocal lightBoss\nlocal startPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, selfHeading, distance)\nMuAiGuide.DrawCircleFloor(startPos.x, startPos.z, drawTime, 0.5)\n\nfor _, ent in pairs(TensorCore.entityList(\"contentid=13554\")) do\n    lightBoss = ent\n    break\nend\n\n\nlocal OP = { x = startPos.x - 100, z = startPos.z - 100 }\nlocal OB = { x = lightBoss.pos.x - 100, z = lightBoss.pos.z - 100 }\n\n-- 计算点积和模长，用于计算夹角\nlocal dotProduct = OP.x * OB.x + OP.z * OB.z\nlocal magnitudeOA = math.sqrt(OP.x ^ 2 + OP.z ^ 2)\nlocal magnitudeOB = math.sqrt(OB.x ^ 2 + OB.z ^ 2)\n\n-- 计算夹角\nlocal theta = math.acos(dotProduct / (magnitudeOA * magnitudeOB))\n-- 使用叉积判断方向\nlocal crossProduct = OP.x * OB.z - OP.z * OB.x\nif crossProduct < 0 then\n    theta = 2 * math.pi - theta\nend\nif MuAiGuide.IsSame(theta, 2 * math.pi) then\n    theta = 0\nend\nd(theta)\nlocal wide\nlocal endHeading\nlocal guideHeading\nif MuAiGuide.IsSame(math.pi / 4, theta) or MuAiGuide.IsSame(math.pi * 5 / 4, theta) then\n    MuAiGuide.Info(\"反跑135度！\")\n    wide = math.pi * 3 / 4\n    endHeading = selfHeading + wide / 2\n    guideHeading = selfHeading + wide\nelse\n    if MuAiGuide.IsSame(math.pi / 2, theta) or MuAiGuide.IsSame(math.pi * 3 / 2, theta) then\n        MuAiGuide.Info(\"正跑90度！\")\n        wide = math.pi / 2\n    elseif MuAiGuide.IsSame(math.pi * 3 / 4, theta) or MuAiGuide.IsSame(math.pi * 7 / 4, theta) then\n        MuAiGuide.Info(\"正跑135度！\")\n        wide = math.pi * 3 / 4\n    elseif MuAiGuide.IsSame(0, theta) or MuAiGuide.IsSame(math.pi, theta) then\n        MuAiGuide.Info(\"正跑180度！\")\n        wide = math.pi\n    end\n    endHeading = selfHeading - wide / 2\n    guideHeading = selfHeading - wide\nend\n\nlocal endPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, guideHeading, distance)\nMuAiGuide.DirectTo(endPos.x, endPos.z, drawTime)\n\nlocal posDrawer = Argus2.ShapeDrawer:new(\n    (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0)),\n    (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0)),\n    (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0)),\n    (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n    5\n) \nposDrawer:addTimedCone(\n    drawTime,\n    100, 0, 100,\n    distance,\n    wide,\n    endHeading,\n    0,\n    false\n)\n\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "80339835-c5e5-2000-be6a-7a3bf542d52d",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 251.1,
				name = "[MuAiGuide]跑圈方向",
				timelineIndex = 50,
				timerOffset = 1,
				uuid = "ba5a2f21-2839-d605-a4b2-0636a2a4737d",
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
							actionLua = "MuAiGuide.Info(\"滑冰倒计时:[3]<se.3>\" )\nself.used = true",
							conditions = 
							{
								
								{
									"39d69fbe-ac9d-4cab-b313-0ab2b33ef31e",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "d1150595-03f0-9ffb-9efb-e9dcc70841ae",
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
							conditionLua = "return MuAiGuide.Config.LogToEchoMsg",
							name = "开启提示",
							uuid = "39d69fbe-ac9d-4cab-b313-0ab2b33ef31e",
							version = 2,
						},
					},
				},
				mechanicTime = 270.3,
				name = "[MuAiGuide]滑冰噪音-倒计时3",
				timelineIndex = 60,
				timerOffset = -3.5,
				uuid = "699198ee-ea0e-01a0-ac6e-b5a6d1d40274",
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
							actionLua = "MuAiGuide.Info(\"滑冰倒计时:[2]<se.3>\" )\nself.used = true",
							conditions = 
							{
								
								{
									"ae66bcf9-3c8d-5525-9de1-4dfe0b3b575e",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "7d3d9c00-403d-4acc-9de0-007a94dbaa24",
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
							conditionLua = "return MuAiGuide.Config.LogToEchoMsg",
							name = "开启提示",
							uuid = "ae66bcf9-3c8d-5525-9de1-4dfe0b3b575e",
							version = 2,
						},
					},
				},
				mechanicTime = 270.3,
				name = "[MuAiGuide]滑冰噪音-倒计时2",
				timelineIndex = 60,
				timerOffset = -2.5,
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
							actionLua = "MuAiGuide.Info(\"滑冰倒计时:[1]<se.3>\" )\nself.used = true",
							conditions = 
							{
								
								{
									"c220c521-38d5-3bd7-ad36-21f3a8689e09",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "513f77e2-ddaa-dd5b-ab49-946fcd9a47f6",
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
							conditionLua = "return MuAiGuide.Config.LogToEchoMsg",
							name = "开启提示",
							uuid = "c220c521-38d5-3bd7-ad36-21f3a8689e09",
							version = 2,
						},
					},
				},
				mechanicTime = 270.3,
				name = "[MuAiGuide]滑冰噪音-倒计时1",
				timelineIndex = 60,
				timerOffset = -1.5,
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
							actionLua = "MuAiGuide.Info(\"滑冰，快走！<se.1>\" )\nself.used = true",
							conditions = 
							{
								
								{
									"06852cc3-adaf-d9ef-8172-d598dad21241",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "a3ccb272-4541-3e6b-a06c-ac9dbcc993cf",
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
							conditionLua = "return MuAiGuide.Config.LogToEchoMsg",
							name = "开启提示",
							uuid = "06852cc3-adaf-d9ef-8172-d598dad21241",
							version = 2,
						},
					},
				},
				mechanicTime = 270.3,
				name = "[MuAiGuide]滑冰噪音-GOGOGO",
				timelineIndex = 60,
				timerOffset = -0.5,
				uuid = "0e0126fd-ce97-175a-8046-2a02145c37a7",
				version = 2,
			},
			inheritedIndex = 4,
		},
	},
	[68] = 
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
							actionLua = "local guideTime = 10000\n\nlocal allMirrors = {}\nlocal blueMirror = nil\nfor _, ent in pairs(TensorCore.entityList(\"contentid=9317\")) do\n    if TensorCore.getDistance2d({ x = 100, y = 0, z = 100 }, ent.pos) > 15 then\n        table.insert(allMirrors, ent)\n        if blueMirror == nil or ent.id < blueMirror.id then\n            blueMirror = ent\n        end\n    end\nend\n\nlocal redMirror = {}\nfor _, mirror in pairs(allMirrors) do\n    if mirror.id ~= blueMirror.id then\n        table.insert(redMirror, mirror)\n    end\nend\n\nlocal distance1 = TensorCore.getDistance2d(redMirror[1].pos, blueMirror.pos)\nlocal distance2 = TensorCore.getDistance2d(redMirror[2].pos, blueMirror.pos)\nlocal left, right\nif MuAiGuide.GetClock(redMirror[1].pos, redMirror[2].pos) then\n    left  = redMirror[1]\n    right = redMirror[2]\nelse\n    left  = redMirror[2]\n    right = redMirror[1]\nend\n\nif MuAiGuide.IsSame(distance1, distance2) then\n    if table.contains(MuAiGuide.Config.FruCfg.MirrorPosMelee1, MuAiGuide.SelfPos) then\n        data.MuAiGd_P2_Mirror2 = { pos = right.pos, isLeft = false }\n    else\n        data.MuAiGd_P2_Mirror2 = { pos = left.pos, isLeft = true }\n    end\nelse\n    local far, near\n    if distance1 > distance2 then\n        far  = redMirror[1]\n        near = redMirror[2]\n    else\n        near = redMirror[1]\n        far  = redMirror[2]\n    end\n    if table.contains(MuAiGuide.Config.FruCfg.MirrorPosMelee1, MuAiGuide.SelfPos) then\n        data.MuAiGd_P2_Mirror2 = { pos = far.pos, isLeft = (far.id == left.id) }\n    else\n        data.MuAiGd_P2_Mirror2 = { pos = near.pos, isLeft = (near.id == left.id) }\n    end\nend\nlocal m2cHeading = TensorCore.getHeadingToTarget(blueMirror.pos, { x = 100, y = 0, z = 100 })\nif table.contains(MuAiGuide.Config.FruCfg.MirrorPosMelee1, MuAiGuide.SelfPos) then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=12809\")) do\n        if Argus.isEntityVisible(ent) then\n            data.MuAiGd_P2_BOSS = ent\n            break\n        end\n    end\n    data.MuAiGd_P2_MirrorMelee = true\nelse\n    data.MuAiGd_P2_MirrorMelee = false\n    local selfIndex = MuAiGuide.IndexOf(MuAiGuide.Config.FruCfg.MirrorPosRange, MuAiGuide.SelfPos)\n    local endHeading\n    if selfIndex == 1 then       --左1\n        endHeading = m2cHeading - 75 / 180 * math.pi\n    elseif selfIndex == 2 then   --左2\n        endHeading = m2cHeading - 45 / 180 * math.pi\n    elseif selfIndex == 3 then   --左3\n        endHeading = m2cHeading + 45 / 180 * math.pi\n    elseif selfIndex == 4 then   --左4\n        endHeading = m2cHeading + 75 / 180 * math.pi\n    end\n    local endPos = TensorCore.getPosInDirection(blueMirror.pos, endHeading, 3)\n    MuAiGuide.DirectTo(endPos.x, endPos.z, guideTime)\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "3f737fe6-7887-9bb2-92dc-36920051bb49",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 292.6,
				name = "[MuAiGuide]镜子指路",
				timelineIndex = 68,
				timerEndOffset = 10,
				timerOffset = 2.2000000476837,
				timerStartOffset = -2,
				uuid = "3d46a6be-3783-ce07-85ca-0ff9d219fd31",
				version = 2,
			},
			inheritedIndex = 1,
		},
	},
	[71] = 
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
							actionLua = "local guideTime = 10000\nif data.MuAiGd_P2_Mirror2 ~= nil then\n    local baseDir = TensorCore.getHeadingToTarget(data.MuAiGd_P2_Mirror2.pos, { x = 100, y = 0, z = 100 })\n    local endHeading\n    local posTable\n    if table.contains(MuAiGuide.Config.FruCfg.MirrorPosMelee1, MuAiGuide.SelfPos) then\n        posTable = MuAiGuide.Config.FruCfg.MirrorPosMelee2\n    else\n        posTable = MuAiGuide.Config.FruCfg.MirrorPosRange\n    end\n    local index = MuAiGuide.IndexOf(posTable, MuAiGuide.SelfPos)\n\n    if index == 1 then\n        endHeading = baseDir - 75 / 180 * math.pi\n    elseif index == 2 then\n        if data.MuAiGd_P2_Mirror2.isLeft then\n            endHeading = baseDir - 45 / 180 * math.pi\n        else\n            endHeading = baseDir\n        end\n    elseif index == 3 then\n        if not data.MuAiGd_P2_Mirror2.isLeft then\n            endHeading = baseDir + 45 / 180 * math.pi\n        else\n            endHeading = baseDir\n        end\n    elseif index == 4 then\n        endHeading = baseDir + 75 / 180 * math.pi\n    end\n    \n    local endPos = TensorCore.getPosInDirection(data.MuAiGd_P2_Mirror2.pos, endHeading, 3)\n    MuAiGuide.DirectTo(endPos.x, endPos.z, guideTime)\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "3d17e481-f584-72bd-90c4-253ac1dbac4a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 306.6,
				name = "[MuAiGuide]镜子2指路",
				timelineIndex = 71,
				timerEndOffset = 10,
				timerStartOffset = -2,
				uuid = "308bfcf7-a1cf-208f-8084-ed90f5916d54",
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
							actionLua = "local bossPos = TensorCore.mGetEntity(data.MuAiGd_P2_BOSS.id).pos\nlocal selfIndex = MuAiGuide.IndexOf(MuAiGuide.Config.FruCfg.MirrorPosMelee1, MuAiGuide.SelfPos)\nlocal heading\nif selfIndex == 1 then\n    heading = bossPos.h + math.pi / 2\nelseif selfIndex == 2 then\n    heading = bossPos.h + math.pi / 6\nelseif selfIndex == 3 then\n    heading = bossPos.h - math.pi / 6\nelseif selfIndex == 4 then\n    heading = bossPos.h - math.pi / 2\nend\nlocal targetPos = TensorCore.getPosInDirection(bossPos, heading, 3)\nMuAiGuide.FrameDirect(targetPos.x, targetPos.z)\nself.used = true\n",
							conditions = 
							{
								
								{
									"e81648ff-fd6b-60d7-bb67-a558ec8f6d6a",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "49bfeaf6-80d5-9f7f-b681-63b8ada4b9ba",
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
							conditionLua = "return data.MuAiGd_P2_MirrorMelee ~= nil \nand data.MuAiGd_P2_MirrorMelee == true\nand data.MuAiGd_P2_BOSS ~= nil",
							uuid = "e81648ff-fd6b-60d7-bb67-a558ec8f6d6a",
							version = 2,
						},
					},
				},
				eventType = 12,
				mechanicTime = 306.6,
				name = "[MuAiGuide]镜子1指路MELEE",
				randomOffset = 10,
				timeRange = true,
				timelineIndex = 71,
				timerOffset = -10,
				timerStartOffset = -10,
				uuid = "7ccf8be3-3ad0-aecd-919b-6ddd2453cfa8",
				version = 2,
			},
		},
	},
	[77] = 
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
							actionLua = "local guideTime = 5000\nif TensorCore.isAnyEntityCasting(40220) then\n    MuAiGuide.Info(\"找搭档分摊。\")\n    local partner = MuAiGuide.GetRMPartner()\n    local p = MuAiGuide.Party[partner]\n    MuAiGuide.DirectToEnt(p.id, guideTime)\nelse\n\tMuAiGuide.Info(\"分散。\")\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "5840bec7-50a0-5eee-91fd-048a1eb247e9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 322.5,
				name = "[MuAiGuide]分摊or分散",
				timelineIndex = 77,
				timerOffset = -4,
				uuid = "f5d0b86f-606a-2740-842e-2400e8bd479d",
				version = 2,
			},
			inheritedIndex = 1,
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
							conditions = 
							{
								
								{
									"d61da128-1e8a-58ef-a605-bd41ca15d360",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							name = "MGL光暴-预站位",
							uuid = "2e6576e5-8d1c-70dc-a78e-692bd7a9da41",
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
							conditionLua = "return MuAiGuide and MuAiGuide.Config.FruCfg.FruLightRampantType == 1",
							name = "田园郡式",
							uuid = "d61da128-1e8a-58ef-a605-bd41ca15d360",
							version = 2,
						},
					},
				},
				mechanicTime = 331.8,
				name = "[MuAiGuide]MGL光暴-预站位",
				timelineIndex = 80,
				timerOffset = -5,
				uuid = "38b9f6af-b0a3-156e-a702-5c7db4f787b1",
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
							actionLua = "local guideTime = 9000\nlocal buffId = 4157\nlocal M = MuAiGuide\nlocal linkBuff = TensorCore.getBuff(M.GetPlayer().id, buffId)\n\n-- 计算是否有线（是否有线BUFF）\nif linkBuff ~= nil then\n    --连线定名\n    local TGroup = { \"MT\", \"ST\", \"H1\", \"H2\" }\n    local DGroup = { \"D1\", \"D2\", \"D3\", \"D4\" }\n    local selfLinkOrder = 0 --计算自己是第几个有线\n    local targetHeading = 0\n    if table.contains(TGroup, M.SelfPos) then\n        local index = M.IndexOf(TGroup, M.SelfPos)\n        for i = 1, index do\n            local curPlayer = M.Party[TGroup[i]]\n            if TensorCore.getBuff(curPlayer.id, buffId) then\n                selfLinkOrder = selfLinkOrder + 1\n            end\n        end\n        if selfLinkOrder == 1 then\n            targetHeading = math.pi * 4 / 3\n            M.Info(\"我是上1，去左上。\")\n        elseif selfLinkOrder == 2 then\n            M.Info(\"我是上2，去下。\")\n            targetHeading = 0\n        elseif selfLinkOrder == 3 then\n            M.Info(\"我是上3，去右上。\")\n            targetHeading = math.pi * 2 / 3\n        elseif selfLinkOrder == 4 then\n            M.Info(\"我是上4，需要补位去左下。\")\n            targetHeading = math.pi * 5 / 3\n        end\n    elseif table.contains(DGroup, M.SelfPos) then\n        local index = M.IndexOf(DGroup, M.SelfPos)\n        for i = 1, index do\n            local curPlayer = M.Party[DGroup[i]]\n            if TensorCore.getBuff(curPlayer.id, buffId) then\n                selfLinkOrder = selfLinkOrder + 1\n            end\n        end\n        if selfLinkOrder == 1 then\n            M.Info(\"我是下1，去右下。\")\n            targetHeading = math.pi / 3\n        elseif selfLinkOrder == 2 then\n            M.Info(\"我是下2，去上。\")\n            targetHeading = math.pi\n        elseif selfLinkOrder == 3 then\n            M.Info(\"我是下3，去左下。\")\n            targetHeading = math.pi * 5 / 3\n        elseif selfLinkOrder == 4 then\n            targetHeading = math.pi * 2 / 3\n            M.Info(\"我是下4，需要补位去右上。\")\n        end\n    end\n    local targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, targetHeading, 18)\n    M.DirectTo(targetPos.x, targetPos.z, guideTime)\nelse\n    M.Info(\"被点名了，放五个圈。\")\n    local guideTime2 = 16000\n    local fromA = {\n        { x = 100,   z = 92 },\n        { x = 106.1, z = 94.8 },\n        { x = 109,   z = 100.77 },\n        { x = 108,   z = 107.3 },\n        { x = 106,   z = 113.6 },\n    }\n    local fromC = {\n        { x = 100,  z = 108 },\n        { x = 93.9, z = 105.2 },\n        { x = 91,   z = 99.23 },\n        { x = 92,   z = 92.7 },\n        { x = 94,   z = 86.4 },\n    }\n    local draw = function(points)\n        for i = 1, #points do\n            local curPos = points[i]\n            local size = 0.5\n            M.DrawCircleUI(curPos.x, curPos.z, guideTime2, 0.5, 0, 255, 0, 0.7)\n            if i > 1 then\n                local lastPos = points[i - 1]\n                local heading = TensorCore.getHeadingToTarget(lastPos, curPos)\n                local length = TensorCore.getDistance2d(lastPos, curPos)\n                local pos = TensorCore.getPosInDirection(lastPos, heading, size + 0.1)\n                Argus2.addTimedArrowFilled(\n                    guideTime2,\n                    pos.x,\n                    0,\n                    pos.z,\n                    length - size * 2 - 1 - 0.2,\n                    size / 5 * 2,\n                    1,\n                    0.25,\n                    heading,\n                    GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 255 / 255, 0.7),\n                    GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 255 / 255, 0.7),\n                    GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 255 / 255, 0.7),\n                    0,\n                    nil,\n                    nil,\n                    GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1),\n                    1.0,\n                    3,\n                    0.05,\n                    true\n                )\n            end\n        end\n    end\n    local noBuffOther\n    for i = 1, 8 do\n        local curJobPos = M.JobPosName[i]\n        if curJobPos ~= M.SelfPos and TensorCore.getBuff(M.Party[curJobPos].id, buffId) == nil then\n            noBuffOther = curJobPos\n        end\n    end\n    if noBuffOther then\n        if M.IndexOf(M.SelfPos) < M.IndexOf(noBuffOther) then\n            draw(fromA)\n        else\n            draw(fromC)\n        end\n    else\n        draw(fromA)\n        draw(fromC)\n    end\nend\nself.used = true",
							conditions = 
							{
								
								{
									"cf85f192-7932-8d1a-aa9a-11eb68d7a4f8",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							name = "MGL光暴-线分析&指路",
							uuid = "63c0bd19-de44-6780-822c-251564f6c733",
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
							conditionLua = "return MuAiGuide and MuAiGuide.Config.FruCfg.FruLightRampantType == 1",
							name = "田园郡式",
							uuid = "cf85f192-7932-8d1a-aa9a-11eb68d7a4f8",
							version = 2,
						},
					},
				},
				mechanicTime = 331.8,
				name = "[MuAiGuide]MGL光暴-线分析&指路",
				timelineIndex = 80,
				timerOffset = 1,
				uuid = "df04ad36-0dec-a5b8-86b0-2187c689b527",
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
							actionLua = "local TGroup = { \"MT\", \"ST\", \"H1\", \"H2\" }\nlocal DGroup = { \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal noBuff = {}\ndata.MuAiGd_LightRampantGroupUp = {}\ndata.MuAiGd_LightRampantGroupDown = {}\nlocal buffCnt = 0\nfor i = 1, 4 do\n    local curPlayer = MuAiGuide.Party[TGroup[i]]\n    if TensorCore.getBuff(curPlayer.id, 4157) then\n        buffCnt = buffCnt + 1\n        if buffCnt == 2 or buffCnt == 4 then\n            table.insert(data.MuAiGd_LightRampantGroupDown, TGroup[i])\n        else\n            table.insert(data.MuAiGd_LightRampantGroupUp, TGroup[i])\n        end\n        d(TGroup[i])\n    else\n        table.insert(noBuff, TGroup[i])\n    end\nend\nbuffCnt = 0\nfor i = 1, 4 do\n    local curPlayer = MuAiGuide.Party[DGroup[i]]\n    if TensorCore.getBuff(curPlayer.id, 4157) then\n        buffCnt = buffCnt + 1\n        if buffCnt == 2 or buffCnt == 4 then\n            table.insert(data.MuAiGd_LightRampantGroupUp, DGroup[i])\n        else\n            table.insert(data.MuAiGd_LightRampantGroupDown, DGroup[i])\n        end\n        d(DGroup[i])\n    else\n        table.insert(noBuff, DGroup[i])\n    end\nend\ntable.insert(data.MuAiGd_LightRampantGroupUp, noBuff[2])\ntable.insert(data.MuAiGd_LightRampantGroupDown, noBuff[1])\nMuAiGuide.Info(\"最终分摊分组，上：\" .. MuAiGuide.StringJoin(data.MuAiGd_LightRampantGroupUp, \",\"))\nMuAiGuide.Info(\"最终分摊分组，下：\" .. MuAiGuide.StringJoin(data.MuAiGd_LightRampantGroupDown, \",\"))\nself.used = true\n",
							conditions = 
							{
								
								{
									"9fb670e4-237b-04bd-8112-2c00b7a31ac3",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "c641c1e0-c330-93d6-a98e-c1a1d2d5c619",
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
							conditionLua = "return MuAiGuide and MuAiGuide.Config.FruCfg.FruLightRampantType == 1",
							name = "田园郡式",
							uuid = "9fb670e4-237b-04bd-8112-2c00b7a31ac3",
							version = 2,
						},
					},
				},
				mechanicTime = 331.8,
				name = "[MuAiGuide]MGL光暴-上下分组统计",
				timelineIndex = 80,
				timerOffset = 2,
				uuid = "cb6be8aa-dbad-5a0b-aafb-b2019b193705",
				version = 2,
			},
		},
	},
	[85] = 
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
							actionLua = "if TensorCore.getBuff(MuAiGuide.GetPlayer().id, 4159) then\n    if table.contains(data.MuAiGd_LightRampantGroupUp, MuAiGuide.SelfPos) then\n        MuAiGuide.DirectTo(100, 81, 5000)\n    else\n        MuAiGuide.DirectTo(100, 119, 5000)\n    end\nelse\n    for jobPos, player in pairs(MuAiGuide.Party) do\n        if not MuAiGuide.IsMe(player) and TensorCore.getBuff(player.id, 4159) then\n            if table.contains(data.MuAiGd_LightRampantGroupUp, MuAiGuide.SelfPos)\n                and table.contains(data.MuAiGd_LightRampantGroupUp, jobPos) then\n                MuAiGuide.DirectToEnt(player.id, 5000)\n                break\n            end\n            if table.contains(data.MuAiGd_LightRampantGroupDown, MuAiGuide.SelfPos)\n                and table.contains(data.MuAiGd_LightRampantGroupDown, jobPos) then\n                MuAiGuide.DirectToEnt(player.id, 5000)\n                break\n            end\n        end\n    end\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"8424550c-ee17-c678-9a1d-8e0868d4e911",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "88d1f8fe-edd6-e370-8749-9fc28b8ef6c7",
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
							conditionLua = "return MuAiGuide and MuAiGuide.Config.FruCfg.FruLightRampantType == 1",
							name = "田园郡式",
							uuid = "8424550c-ee17-c678-9a1d-8e0868d4e911",
							version = 2,
						},
					},
				},
				mechanicTime = 343,
				name = "[MuAiGuide]MGL光暴-指路分摊",
				timelineIndex = 85,
				uuid = "b300baf4-9c3f-470c-b120-98cabf414d6f",
				version = 2,
			},
		},
	},
	[91] = 
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
							actionLua = "local buff = TensorCore.getBuff(MuAiGuide.GetPlayer().id, 2257)\nif buff and buff.stacks <= 2 then\n    MuAiGuide.DirectTo(100, 100, 5000)\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "ad8e4ca1-3dd5-e4cc-a999-8563781b7638",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 357.7,
				name = "[MuAiGuide]光爆后-4人踩塔",
				timelineIndex = 91,
				timerOffset = -5,
				uuid = "b3ff0fd1-15e9-36e1-8b7e-dac02e3dd343",
				version = 2,
			},
			inheritedIndex = 2,
		},
	},
	[92] = 
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
							actionLua = "local guideTime = 3000\nif TensorCore.isAnyEntityCasting(40220) then\n    MuAiGuide.Info(\"斜点找搭档分摊。\")\n    local partner = MuAiGuide.GetBasePartner()\n    local p = MuAiGuide.Party[partner]\n    MuAiGuide.DirectToEnt(p.id, guideTime)\nelseif TensorCore.isAnyEntityCasting(40221) then\n    MuAiGuide.Info(\"八方分散。\")\n    d(MuAiGuide.Config.FruCfg.JobPos)\n    local index = MuAiGuide.IndexOf(MuAiGuide.Config.FruCfg.JobPos, MuAiGuide.SelfPos)\n    local dir = (index - 1) * math.pi / 4\n    local endPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, dir, 13)\n    MuAiGuide.DirectTo(endPos.x, endPos.z, guideTime)\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "5840bec7-50a0-5eee-91fd-048a1eb247e9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 360.8,
				name = "[MuAiGuide]分摊or分散",
				timelineIndex = 92,
				timerOffset = -3,
				uuid = "9aec1874-ca9e-70f8-8369-9cea58d56a80",
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
							actionLua = "local guideTime = 10000\nlocal index = MuAiGuide.IndexOf(MuAiGuide.Config.FruCfg.JobPos, MuAiGuide.SelfPos)\nlocal dir = (index - 1) * math.pi / 4\nlocal endPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, dir, 8)\nMuAiGuide.DirectTo(endPos.x, endPos.z, guideTime)\nself.used = true  ",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "2fdca798-c49e-dcef-8436-36cf487e446f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 360.8,
				name = "[MuAiGuide]8方分散",
				timelineIndex = 92,
				uuid = "512895ab-c36c-02d0-b277-f03e589afade",
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
							actionLua = "local M = MuAiGuide\nif data.MuAiGd_P3_1_Lights == nil then\n    data.MuAiGd_P3_1_Lights = {}\n    data.MuGuide_GetDirType = function(fire)\n        if fire == nil then\n            return 4\n        end\n        if fire then\n            -- 长火\n            if fire.duration > 22 then\n                return 1\n            elseif fire.duration > 12 then\n                -- 中火\n                return 2\n            else\n                -- 短火\n                return 3\n            end\n        end\n    end\n    M.Debug(\"===================== P3一运查找关键灯-开始 =====================\")\nend\n\n-- 采集灯\nif table.size(data.MuAiGd_P3_1_Lights) < 8 then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=9825\")) do\n        if Argus.getEntityModel(ent.id) == 17832 then\n            local curHeading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, ent.pos)\n            data.MuAiGd_P3_1_Lights[ent.id] = { entity = ent, heading = curHeading }\n        end\n    end\nend\n\n--获取12点\nif table.size(data.MuAiGd_P3_1_Lights) == 8 and data.MuAiGd_P3_1_Clock12 == nil then\n    local yellowLineInfo = {}\n    for _, info in pairs(data.MuAiGd_P3_1_Lights) do\n        local lines = Argus.getTethersOnEnt(info.entity.id)\n        for _, line in pairs(lines) do\n            if line.type == 134 then\n                table.insert(yellowLineInfo, info)\n                break\n            end\n        end\n    end\n    if table.size(yellowLineInfo) > 0 then\n        M.Debug(\"连线灯分析完毕，开始查找12点！\")\n        local not12 = {}\n        for i = 1, #yellowLineInfo do\n            for j = i + 1, #yellowLineInfo do\n                local diff = math.abs(yellowLineInfo[i].heading - yellowLineInfo[j].heading)\n                if diff > math.pi then\n                    diff = diff - math.pi\n                end\n                --近似互为直角\n                if M.IsSame(diff, math.pi / 2) then\n                    table.insert(not12, i)\n                    table.insert(not12, j)\n                    break\n                end\n            end\n            if table.size(not12) == 2 then\n                break\n            end\n        end\n        for i = 1, #yellowLineInfo do\n            if not table.contains(not12, i) then\n                data.MuAiGd_P3_1_Clock12 = yellowLineInfo[i]\n                if M.Config.LogToEchoMsg then\n                    local infoPoint = M.GetGamePointByHeading(M.Config.FruCfg.PosInfo, data.MuAiGd_P3_1_Clock12.heading)\n                    M.Info(\"当前12点为：\" .. infoPoint .. \"点\")\n                end\n                break\n            end\n        end\n        if data.MuAiGd_P3_1_Clock12 ~= nil then\n            if not M.Config.AnyOneReactionOn then\n                TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, .25), 2)\n                    :addTimedArrow(40000, 100, 0, 100, data.MuAiGd_P3_1_Clock12.heading, 6, 2, 4, 4, 0, false)\n            end\n            local type = data.MuAiGd_P3_1_type\n            local dir\n            if M.IsDps(M.GetPlayer().job) then\n                if type == 1 or type == 4 then\n                    dir = 0\n                elseif type == 2 then\n                    dir = -math.pi / 2\n                else\n                    for jobName, ptMember in pairs(M.Party) do\n                        --找到另外一个短火的人\n                        if M.IsDps(ptMember.job) and not M.IsMe(ptMember) then\n                            local fireOther = TensorCore.getBuff(ptMember.id, 2455);\n                            if fireOther and data.MuGuide_GetDirType(fireOther) == 3 then\n                                -- 找到了 开始判断优先级\n                                local selfOrder = M.IndexOf(M.JobPosName, M.SelfPos)\n                                local otherOrder = M.IndexOf(M.JobPosName, jobName)\n                                if selfOrder < otherOrder then\n                                    -- 索引小的优先\n                                    dir = math.pi / 4\n                                    M.Info(\"我是高优先级短火。\")\n                                else\n                                    dir = -math.pi / 4\n                                    M.Info(\"我是低优先级短火。\")\n                                end\n                            end\n                        end\n                    end\n                end\n            else\n                if type == 1 then\n                    for jobName, ptMember in pairs(M.Party) do\n                        --找到另外一个短火的人\n                        if not M.IsDps(ptMember.job) and not M.IsMe(ptMember) then\n                            local fireOther = TensorCore.getBuff(ptMember.id, 2455);\n                            if fireOther and data.MuGuide_GetDirType(fireOther) == 1 then\n                                -- 找到了 开始判断优先级\n                                local selfOrder = M.IndexOf(M.JobPosName, M.SelfPos)\n                                local otherOrder = M.IndexOf(M.JobPosName, jobName)\n                                if selfOrder < otherOrder then\n                                    -- 索引小的优先\n                                    dir = 3 / 4 * math.pi\n                                    M.Info(\"我是高优先级长火。\")\n                                else\n                                    dir = -3 / 4 * math.pi\n                                    M.Info(\"我是低优先级长火。\")\n                                end\n                            end\n                        end\n                    end\n                elseif type == 2 then\n                    dir = math.pi / 2\n                else\n                    dir = math.pi\n                end\n            end\n            local finalDir = data.MuAiGd_P3_1_Clock12.heading + dir\n            if finalDir > math.pi * 2 or M.IsSame(finalDir, math.pi * 2) then\n                finalDir = finalDir - math.pi * 2\n            elseif finalDir < 0 then\n                finalDir = finalDir + math.pi * 2\n            end\n            for _, light in pairs(data.MuAiGd_P3_1_Lights) do\n                if M.IsSame(light.heading, finalDir) then\n                    data.MuAiGd_SelfLight = light\n                    break\n                end\n            end\n            M.Debug(\"最终方向\" .. (finalDir / math.pi))\n            TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, .25), 2)\n                :addTimedArrow(40000, 100, 0, 100, data.MuAiGd_SelfLight.heading, 15, 1, 2, 2, 0, false)\n            if M.Config.LogToEchoMsg then\n                local infoPoint = M.GetGamePointByHeading(M.Config.FruCfg.PosInfo, finalDir)\n                M.Info(\"机制处理方向：\" .. infoPoint .. \"点。\")\n            end\n            M.Debug(\"===================== P3一运查找关键灯-结束 =====================\")\n            self.used = true\n        end\n    end\nend\n",
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
							actionLua = "local guideTime = 6000\nlocal M = MuAiGuide\nif data.MuAiGd_RelativityFlag == nil then\n    data.MuAiGd_RelativityFlag = {\n        StartPos = false,\n        Fire = false,\n        Fire2 = false,\n        Delay = false,\n        ReturnBuff = false,\n        Converge = false,\n        Ice = false,\n        Turing = false,\n        TuringBack = false,\n        EndGuide = false\n    }\n    data.MuAiGd_P3_BackCenter = function()\n        if data.MuAiGd_P3_CenterPos == nil then\n            data.MuAiGd_P3_CenterPos = TensorCore.getPosInDirection({ x = 100, 0, z = 100 },\n                data.MuAiGd_SelfLight.heading, 1)\n        end\n        local targetPos = data.MuAiGd_P3_CenterPos\n        M.DirectTo(targetPos.x, targetPos.z, guideTime, 0.3)\n    end\nend\n-- 火\nlocal fire = TensorCore.getBuff(M.GetPlayer().id, 2455)\n-- 冰\nlocal ice = TensorCore.getBuff(M.GetPlayer().id, 2462)\n-- 分摊\nlocal converge = TensorCore.getBuff(M.GetPlayer().id, 2454)\n-- 回返（未放置）\nlocal delay = TensorCore.getBuff(M.GetPlayer().id, 2464)\n-- 暗焰\nlocal darkFlame = TensorCore.getBuff(M.GetPlayer().id, 2460)\n-- 回返（放置）\nlocal returnBuff = TensorCore.getBuff(M.GetPlayer().id, 2452)\n\n-- 初始位置\nif not data.MuAiGd_RelativityFlag.StartPos and (fire or ice) then\n    if data.MuAiGd_P3_1_type == 3 then\n        local targetPos = TensorCore.getPosInDirection({ x = 100, 0, z = 100 }, data.MuAiGd_SelfLight.heading, 15.5)\n        M.DirectTo(targetPos.x, targetPos.z, guideTime)\n    else\n        data.MuAiGd_P3_BackCenter()\n    end\n    data.MuAiGd_RelativityFlag.StartPos = true\nend\n\n-- 火BUFF\nif not data.MuAiGd_RelativityFlag.Fire and fire then\n    if data.MuAiGd_P3_1_type == 3 then\n        data.MuAiGd_RelativityFlag.Fire = true\n    elseif fire.duration < 5.1 then\n        local targetPos = TensorCore.getPosInDirection({ x = 100, 0, z = 100 }, data.MuAiGd_SelfLight.heading, 15.5)\n        M.DirectTo(targetPos.x, targetPos.z, guideTime)\n        data.MuAiGd_RelativityFlag.Fire = true\n        M.Info(\"火BUFF即将判定，去场外！\")\n    end\nend\n\nif data.MuAiGd_P3_1_type == 2 or data.MuAiGd_P3_1_type == 1 then\n    if not data.MuAiGd_RelativityFlag.Fire2 and (fire == nil or fire.duration < 0.1) then\n        data.MuAiGd_P3_BackCenter()\n        M.Info(\"火BUFF放置完毕，回场中。\")\n        data.MuAiGd_RelativityFlag.Fire2 = true\n    end\nend\n\n-- 回返\nif not data.MuAiGd_RelativityFlag.Delay and delay then\n    if delay.duration < 5.1 then\n        if darkFlame == nil then\n            targetPos = TensorCore.getPosInDirection({ x = 100, 0, z = 100 }, data.MuAiGd_SelfLight.heading, 1)\n            M.Info(\"场中放置回返。\")\n        else\n            targetPos = data.MuAiGd_SelfLight.entity.pos\n            M.Info(\"灯下放置回返。\")\n        end\n        data.MuAiGd_RelativityFlag.Delay = true\n        M.DirectTo(targetPos.x, targetPos.z, guideTime, 0.3)\n    end\nend\n\n-- 放完回返\nif not data.MuAiGd_RelativityFlag.ReturnBuff and returnBuff then\n    data.MuAiGd_RelativityFlag.ReturnBuff = true\n    if not fire or fire.duration >= 10 then\n        M.Info(\"回返放完了，回场中。\")\n        data.MuAiGd_P3_BackCenter()\n    end\nend\n\n-- 分摊\nif not data.MuAiGd_RelativityFlag.Converge and converge then\n    if converge.duration < 5.1 then\n        data.MuAiGd_P3_BackCenter()\n        M.Info(\"分摊，回场中。\")\n        data.MuAiGd_RelativityFlag.Converge = true\n    end\nend\n\n-- 冰\nif not data.MuAiGd_RelativityFlag.Ice and ice then\n    if ice.duration < 5.1 then\n        data.MuAiGd_P3_BackCenter()\n        M.Info(\"冰，回场中。\")\n        data.MuAiGd_RelativityFlag.Ice = true\n    end\nend\n\n-- 终点\nif not data.MuAiGd_RelativityFlag.EndGuide and returnBuff then\n    if returnBuff.duration < 1 then\n        local targetPos = TensorCore.getPosInDirection({ x = 100, 0, z = 100 }, data.MuAiGd_SelfLight.heading, 1)\n        MuAiGuide.DirectTo(targetPos.x, targetPos.z, 10000)\n        data.MuAiGd_RelativityFlag.EndGuide = true\n        M.Info(\"全BUFF处理完毕，回场中等待分摊！\")\n        self.used = true\n    end\nend\n\n-- 灯开始转了\n-- 黄/顺\nif not data.MuAiGd_RelativityFlag.Turing then\n    local turing = TensorCore.getBuff(data.MuAiGd_SelfLight.entity.id, 2970)\n    if turing and turing.duration > 0 then\n        local posDir\n        if turing.stacks == 269 then\n            M.Info(\"引导逆时针的灯!\")\n            posDir = data.MuAiGd_SelfLight.heading - 7 / 18 * math.pi;\n        elseif turing.stacks == 348 then\n            M.Info(\"引导顺时针的灯!\")\n            posDir = data.MuAiGd_SelfLight.heading + 7 / 18 * math.pi;\n        end\n        local pos = data.MuAiGd_SelfLight.entity.pos\n        if not M.Config.AnyOneReactionOn then\n            Argus2.addTimedArrowFilled(\n                guideTime,\n                pos.x, 0, pos.z,\n                2, 0.2, 1, 0.25,\n                posDir,\n                GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, 0.5),\n                GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, 0.5),\n                GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, 0.5),\n                0,\n                nil,\n                nil,\n                GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1),\n                1.0,\n                3,\n                0.05,\n                true\n            )\n        end\n        local targetPos = TensorCore.getPosInDirection(pos, posDir, 0.5)\n        M.DirectTo(targetPos.x, targetPos.z, guideTime, 0.2)\n        data.MuAiGd_RelativityFlag.Turing = true\n    end\nend\n\n-- 引导灯结束了 且 获得了火伤buff，需要回中了\nif data.MuAiGd_RelativityFlag.Turing and not data.MuAiGd_RelativityFlag.TuringBack then\n    local buff = TensorCore.getBuff(M.GetPlayer().id, 4383)\n    if buff and buff.duration >= 11 then\n        M.Info(\"引导灯完成, 回场中！\")\n        data.MuAiGd_P3_BackCenter()\n        data.MuAiGd_RelativityFlag.TuringBack = true\n    end\nend\n",
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
							actionLua = "local M = MuAiGuide\nlocal typeMap = {}\ndata.MuAiGd_P3_2_PlayerBuffType = {}\nfor i = 1, #M.JobPosName do\n    local jobName = M.JobPosName[i]\n    local party = M.Party[jobName]\n    local waterBuff = TensorCore.getBuff(party.id, 2461)\n    local type -- 长 1 中2 短3 无4\n    if waterBuff then\n        if waterBuff.duration > 30 then\n            type = 1\n        elseif waterBuff.duration > 20 then\n            type = 2\n        else\n            type = 3\n        end\n    else\n        type = 4\n    end\n    if not typeMap[type] then\n        typeMap[type] = { jobName }\n    else\n        table.insert(typeMap[type], jobName)\n    end\n    data.MuAiGd_P3_2_PlayerBuffType[jobName] = { IsLeft = i <= 4, Type = type }\nend\n\n-- 左侧基础站位\nlocal LeftBaseGroup = { \"MT\", \"ST\", \"H1\", \"H2\" }\n-- 右侧基础站位\nlocal RightBaseGroup = { \"D1\", \"D2\", \"D3\", \"D4\" }\n\nlocal L2R = {}\nlocal R2L = {}\nlocal ChangeOrder = function(tbl)\n    if table.size(tbl) == 1 then\n        return { tbl[1], tbl[2] }\n    else\n        local index1 = M.IndexOf(M.JobPosName, tbl[1])\n        local index2 = M.IndexOf(M.JobPosName, tbl[2])\n        if index1 > index2 then\n            return { tbl[2], tbl[1] }\n        end\n    end\n    return { tbl[1], tbl[2] }\nend\n\nfor _, list in pairs(typeMap) do\n    if table.contains(LeftBaseGroup, list[1]) and table.contains(LeftBaseGroup, list[2]) then\n        --同属TH\n        table.insert(L2R, list[2])\n    elseif table.contains(RightBaseGroup, list[1]) and table.contains(RightBaseGroup, list[2]) then\n        --同属D\n        table.insert(R2L, list[2])\n    end\nend\n\nL2R = ChangeOrder(L2R)\nR2L = ChangeOrder(R2L)\nlocal selfNeedChange = false\nfor i = 1, #L2R do\n    if L2R[i] == M.SelfPos then\n        local p = M.Party[R2L[i]]\n        local curP = TensorCore.mGetEntity(p.id)\n        M.DirectTo(curP.pos.x, curP.pos.z, 5000)\n        M.Info(\"与\" .. R2L[i] .. \"交换位置！<se.1>\")\n        data.MuAiGd_P3_2_SelfJob = R2L[i]\n        selfNeedChange = true\n    elseif R2L[i] == M.SelfPos then\n        local p = M.Party[L2R[i]]\n        local curP = TensorCore.mGetEntity(p.id)\n        M.DirectTo(curP.pos.x, curP.pos.z, 5000)\n        M.Info(\"与\" .. L2R[i] .. \"交换位置！<se.1>\")\n        data.MuAiGd_P3_2_SelfJob = L2R[i]\n        selfNeedChange = true\n    else\n        M.Info(L2R[i] .. \"与\" .. R2L[i] .. \"交换位置！\")\n    end\n    data.MuAiGd_P3_2_PlayerBuffType[L2R[i]].IsLeft = not data.MuAiGd_P3_2_PlayerBuffType[L2R[i]].IsLeft\n    data.MuAiGd_P3_2_PlayerBuffType[R2L[i]].IsLeft = not data.MuAiGd_P3_2_PlayerBuffType[R2L[i]].IsLeft\nend\nif not selfNeedChange then\n    M.Info(\"我不换！\")\n    data.MuAiGd_P3_2_SelfJob = M.SelfPos\nend\nself.used = true\n",
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
							actionLua = "local M = MuAiGuide\nif data.MuAiGd_P3_2_Objects == nil then\n    data.MuAiGd_P3_2_Objects = {}\n    data.MuAiGd_P3_2_Ids = {}\n    data.MuAiGd_P3_2_GroundFireFinish = false\nend\n\nif eventArgs.entityContentID == 2011391\n    and not table.contains(data.MuAiGd_P3_2_Ids, eventArgs.entityID)\n    and table.size(data.MuAiGd_P3_2_Ids) < 6\nthen\n    table.insert(data.MuAiGd_P3_2_Ids, eventArgs.entityID)\n\n    if table.size(data.MuAiGd_P3_2_Ids) == 6 and data.MuAiGd_P3_2_GroundFireFinish == false then\n        --- 绘制方向箭头\n        local drawClock = function(clock, index)\n            local baseEnt = TensorCore.mGetEntity(data.MuAiGd_P3_2_Ids[index])\n            local baseDir = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, baseEnt.pos)\n            for i = 1, 3 do\n                local curDir\n                local heading\n                if clock then\n                    curDir = baseDir - math.pi / 4 * i\n                    heading = curDir - math.pi / 2\n                else\n                    curDir = baseDir - math.pi / 4 * i\n                    heading = curDir + math.pi / 2\n                end\n                local startPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, curDir, 14)\n                local pos = TensorCore.getPosInDirection(startPos, heading, -3)\n                Argus2.addTimedArrowFilled(\n                    15000,\n                    pos.x, 0, pos.z,\n                    5,\n                    2.5,\n                    3,\n                    4,\n                    heading,\n                    GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 0, 0 / 255, 0.2),\n                    GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 0, 0 / 255, 0.2),\n                    GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 0, 0 / 255, 0.2),\n                    0,\n                    nil,\n                    nil,\n                    GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1),\n                    1.0,\n                    3,\n                    0.05,\n                    false\n                )\n            end\n        end\n        local clock = M.GetClock(TensorCore.mGetEntity(data.MuAiGd_P3_2_Ids[3]).pos,\n            TensorCore.mGetEntity(data.MuAiGd_P3_2_Ids[5]).pos)\n        -- 非标准坐标系，叉乘结果要反着来\n        if clock then\n            M.Debug(\"顺时针\")\n        elseif clock then\n            M.Debug(\"逆时针\")\n        end\n        -- 画出方向箭头\n        drawClock(clock, 3)\n        drawClock(clock, 4)\n\n        local firstDir = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 },\n            TensorCore.mGetEntity(data.MuAiGd_P3_2_Ids[3]).pos)\n        if firstDir > math.pi then\n            firstDir = firstDir - math.pi\n        end\n\n        local posTable\n        -- 计算车头法站位\n        if M.Config.FruCfg.ApocalypseType == 1 then\n            local headDir1 = M.SetHeading2Pi(firstDir + math.pi / 2)\n            local headDir2 = M.SetHeading2Pi(firstDir - math.pi / 2)\n            local headDps, headTh\n            if headDir1 > headDir2 then\n                headTh = headDir1\n                headDps = headDir2\n            else\n                headTh = headDir2\n                headDps = headDir1\n            end\n            if clock then\n                posTable = {\n                    [\"MT\"] = { h = headTh, r = 10 },\n                    [\"ST\"] = { h = headTh - math.pi / 4, r = 10 },\n                    [\"H1\"] = { h = headTh - math.pi / 4 - math.pi / 14, r = 18 },\n                    [\"H2\"] = { h = headTh - math.pi / 4 + math.pi / 14, r = 18 },\n                    [\"D1\"] = { h = headDps, r = 10 },\n                    [\"D2\"] = { h = headDps - math.pi / 4, r = 10 },\n                    [\"D3\"] = { h = headDps - math.pi / 4 - math.pi / 14, r = 18 },\n                    [\"D4\"] = { h = headDps - math.pi / 4 + math.pi / 14, r = 18 },\n                }\n            else\n                posTable = {\n                    [\"MT\"] = { h = headTh, r = 10 },\n                    [\"ST\"] = { h = headTh + math.pi / 4, r = 10 },\n                    [\"H1\"] = { h = headTh + math.pi / 4 - math.pi / 14, r = 18 },\n                    [\"H2\"] = { h = headTh + math.pi / 4 + math.pi / 14, r = 18 },\n                    [\"D1\"] = { h = headDps, r = 10 },\n                    [\"D2\"] = { h = headDps + math.pi / 4, r = 10 },\n                    [\"D3\"] = { h = headDps + math.pi / 4 - math.pi / 14, r = 18 },\n                    [\"D4\"] = { h = headDps + math.pi / 4 + math.pi / 14, r = 18 },\n                }\n            end\n            if MuAiGuide.Config.LogToEchoMsg then\n                local Th = { \"MT\", \"ST\", \"H1\", \"H2\" }\n                local endHeading\n                if data.MuAiGd_P3_2_SelfJob == \"MT\" then\n                    endHeading = headTh\n                elseif data.MuAiGd_P3_2_SelfJob == \"D1\" then\n                    endHeading = headDps\n                else\n                    if table.contains(Th, data.MuAiGd_P3_2_SelfJob) then\n                        endHeading = M.SetHeading2Pi(posTable[\"ST\"].h)\n                    else\n                        endHeading = M.SetHeading2Pi(posTable[\"D2\"].h)\n                    end\n                end\n                local point = MuAiGuide.GetGamePointByHeading(MuAiGuide.Config.FruCfg.PosInfo, endHeading)\n                MuAiGuide.Info(\"前往\" .. point .. \"点附近分散。\")\n                data.MuAiGd_P3_2_MoveInHeading = endHeading\n                data.MuAiGd_P3_2_MTHeading = headTh\n            end\n        else\n            local headDir1\n            local headDir2\n            if clock then\n                headDir1 = M.SetHeading2Pi(firstDir + math.pi / 4)\n                headDir2 = M.SetHeading2Pi(firstDir + math.pi * 5 / 4)\n            else\n                headDir1 = M.SetHeading2Pi(firstDir - math.pi / 4)\n                headDir2 = M.SetHeading2Pi(firstDir - math.pi * 5 / 4)\n            end\n            local headDps, headTh\n            if headDir1 > headDir2 then\n                headTh = headDir1\n                headDps = headDir2\n            else\n                headTh = headDir2\n                headDps = headDir1\n            end\n            posTable = {\n                [\"ST\"] = { h = headTh, r = 10 },\n                [\"H1\"] = { h = headTh - math.pi / 14, r = 18 },\n                [\"H2\"] = { h = headTh + math.pi / 14, r = 18 },\n                [\"D2\"] = { h = headDps, r = 10 },\n                [\"D3\"] = { h = headDps - math.pi / 14, r = 18 },\n                [\"D4\"] = { h = headDps + math.pi / 14, r = 18 },\n            }\n            if clock then\n                posTable[\"MT\"] = { headTh + math.pi / 4, r = 10 }\n                posTable[\"D1\"] = { headDps + math.pi / 4, r = 10 }\n            else\n                posTable[\"MT\"] = { headTh - math.pi / 4, r = 10 }\n                posTable[\"D1\"] = { headDps - math.pi / 4, r = 10 }\n            end\n            if MuAiGuide.Config.LogToEchoMsg then\n                local Th = { \"MT\", \"ST\", \"H1\", \"H2\" }\n                local endHeading\n                if data.MuAiGd_P3_2_SelfJob == \"MT\" or data.MuAiGd_P3_2_SelfJob == \"D1\" then\n                    endHeading = M.SetHeading2Pi(posTable[data.MuAiGd_P3_2_SelfJob].h)\n                else\n                    if table.contains(Th, data.MuAiGd_P3_2_SelfJob) then\n                        endHeading = M.SetHeading2Pi(posTable[\"ST\"].h)\n                    else\n                        endHeading = M.SetHeading2Pi(posTable[\"D2\"].h)\n                    end\n                end\n                local point = MuAiGuide.GetGamePointByHeading(MuAiGuide.Config.FruCfg.PosInfo, endHeading)\n                MuAiGuide.Info(\"前往\" .. point .. \"点附近分散。\")\n                data.MuAiGd_P3_2_MoveInHeading = endHeading\n                data.MuAiGd_P3_2_MTHeading = headTh\n            end\n        end\n        local targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 },\n            posTable[data.MuAiGd_P3_2_SelfJob].h, posTable[data.MuAiGd_P3_2_SelfJob].r)\n        M.DirectTo(targetPos.x, targetPos.z, 10000)\n        data.MuAiGd_P3_2_GroundFireFinish = true\n        M.Debug(\"地火指路完成！\")\n    end\nend\nself.used = true\n",
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
	[148] = 
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
							actionLua = "local pos\nif data.MuAiGd_P3_2_SelfJob ~= \"MT\" then\n    pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, data.MuAiGd_P3_2_MoveInHeading, 4)\nelse\n    pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, data.MuAiGd_P3_2_MTHeading, 4)\nend\nMuAiGuide.Info(\"场中分组分摊。\")\nMuAiGuide.DirectTo(pos.x, pos.z, 6000, 0.5)\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "961624f1-9bcb-a5ac-9c6e-1650ebc5ae27",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 635.4,
				name = "[MuAiGuide]场中分组分摊",
				timelineIndex = 148,
				timerOffset = -0.5,
				uuid = "dd3ad00f-86f5-46f4-8b5f-9f1b3f140f5a",
				version = 2,
			},
		},
	},
	[150] = 
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
							actionLua = "if data.MuAiGd_P3_2_SelfJob == \"MT\" then\n    local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, data.MuAiGd_P3_2_MoveInHeading, 18)\n    MuAiGuide.Info(\"远离引导跳跃。\")\n    MuAiGuide.DirectTo(pos.x, pos.z, 2200, 0.5)\nend\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "404c2b89-13f1-141b-a6fd-aff6ed9dfca7",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 644.3,
				name = "[MuAiGuide]MT远离引导跳跃",
				timelineIndex = 150,
				timerOffset = -2.2000000476837,
				uuid = "4043c439-e649-5f81-910a-644f1ae4f1eb",
				version = 2,
			},
		},
	},
	[151] = 
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
							actionLua = "if data.MuAiGd_KnockBackTime == nil then\n    data.MuAiGd_KnockBackTime = Now()\n    if data.MuAiGd_P3_2_PlayerBuffType[MuAiGuide.SelfPos].IsLeft then\n        MuAiGuide.Info(\"BOSS左后击退。\")\n    else\n        MuAiGuide.Info(\"BOSS右后击退。\")\n    end\nend\n\nif data.MuAiGd_P3_BOSS == nil then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=9832\")) do\n        if Argus.isEntityVisible(ent) then\n            data.MuAiGd_P3_BOSS = ent\n            break\n        end\n    end\nend\n\nif data.MuAiGd_P3_BOSS then\n    if MuAiGuide.SelfPos ~= \"MT\" or TimeSince(data.MuAiGd_KnockBackTime) > 2000 then\n        local pos = TensorCore.mGetEntity(data.MuAiGd_P3_BOSS.id).pos\n        local endHeading\n        if data.MuAiGd_P3_2_PlayerBuffType[MuAiGuide.SelfPos].IsLeft then\n            endHeading = pos.h + math.pi * 15 / 18\n        else\n            endHeading = pos.h - math.pi * 15 / 18\n        end\n        local endPos = TensorCore.getPosInDirection(pos, endHeading, 2)\n        MuAiGuide.FrameDirect(endPos.x, endPos.z, 0.3)\n    end\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "b6db2169-6a93-ee27-9d27-151e7ba3b19e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 647.2,
				name = "[MuAiGuide]P3地火后击退",
				timeRange = true,
				timelineIndex = 151,
				timerOffset = -5,
				timerStartOffset = -5,
				uuid = "c3ef09e4-5ecd-9479-809f-968a156f87a3",
				version = 2,
			},
		},
	},
	[152] = 
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
							actionLua = "local selfState = data.MuAiGd_P3_2_PlayerBuffType[MuAiGuide.SelfPos]\nif selfState.Type == 1 then -- 长水\n    local pos = TensorCore.mGetEntity(data.MuAiGd_P3_BOSS.id).pos\n    local endHeading\n    if selfState.IsLeft then\n        endHeading = pos.h + math.pi * 3 / 4\n    else\n        endHeading = pos.h - math.pi * 3 / 4\n    end\n    local endPos = TensorCore.getPosInDirection(pos, endHeading, 6.5)\n    MuAiGuide.DirectTo(endPos.x, endPos.z, 4000)\nelse\n    local targetJob\n    for job, state in pairs(data.MuAiGd_P3_2_PlayerBuffType) do\n        if state.Type == 1 and selfState.IsLeft == state.IsLeft and job ~= MuAiGuide.SelfPos then\n            targetJob = job\n            break\n        end\n    end\n    local id = MuAiGuide.Party[targetJob].id\n    MuAiGuide.DirectToEnt(id, 4000)\nend\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "5805cf91-906a-2e91-987a-4a2ac0c401e7",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 651.2,
				name = "[MuAiGuide]击退后分摊",
				timelineIndex = 152,
				timerOffset = -4,
				uuid = "3014db00-9808-8e92-ace6-085fd57dd984",
				version = 2,
			},
		},
	},
	[159] = 
	{
		
		{
			data = 
			{
				name = "[Kaze] Potion",
				uuid = "baf4dad5-40d5-ce13-b11d-a18f325cd2e4",
				version = 2,
			},
			inheritedObjectUUID = "b02f4064-9d8d-a4f4-9a26-1f408ef229bf",
			inheritedOverwrites = 
			{
				timerStartOffset = 6.1999998092651,
			},
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
							actionLua = "if data.MuAiGd_P4_1_Converge ~= nil then\n    if MuAiGuide.SelfPos ~= data.MuAiGd_P4_1_Converge then\n        local player = MuAiGuide.Party[data.MuAiGd_P4_1_Converge]\n        MuAiGuide.DirectToEnt(player.id, 5000)\n        self.used = true\n    else\n        if TensorCore.isAnyEntityCasting(40228) then\n            data.MuAiGd_P4_1_Skill = \"Right\"\n        elseif TensorCore.isAnyEntityCasting(40229) then\n            data.MuAiGd_P4_1_Skill = \"Left\"\n        end\n        if data.MuAiGd_P4_1_Skill ~= nil then\n            local selfIndex = MuAiGuide.IndexOf(data.MuAiGd_P4_1_OrderPos, MuAiGuide.SelfPos)\n            -- 去上面\n            if 3 <= selfIndex and selfIndex <= 6 then\n                if data.MuAiGd_P4_1_Skill == \"Right\" then\n                    MuAiGuide.DirectTo(91, 91, 5000)\n                else\n                    MuAiGuide.DirectTo(109, 91, 5000)\n                end\n            else\n                -- 下面\n                if data.MuAiGd_P4_1_Skill == \"Right\" then\n                    MuAiGuide.DirectTo(91, 109, 5000)\n                else\n                    MuAiGuide.DirectTo(109, 109, 5000)\n                end\n            end\n            self.used = true\n        end\n    end\nend",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "3953cd55-a913-da28-ac8f-e75bc5ab3536",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				eventType = 3,
				mechanicTime = 752.3,
				name = "[MuAiGuide]光暗龙诗-分摊",
				timeRange = true,
				timelineIndex = 169,
				timerEndOffset = 3,
				timerStartOffset = -1,
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
	[172] = 
	{
		
		{
			data = 
			{
				name = "[Draw] Somber Farthest",
				uuid = "905fb580-de19-a71f-b711-b39e154c9ea3",
				version = 2,
			},
			inheritedObjectUUID = "b8ceffad-ca0c-f59f-bce4-6edf811a507b",
			inheritedOverwrites = 
			{
				timerEndOffset = 0.34999999403954,
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
							actionLua = "local M = MuAiGuide\n\nif data.MuAiGd_P4_Player == nil then\n    data.MuAiGd_P4_ManualMarks = {}\n    data.MuAiGd_P4_BuffCollected = false\n    data.MuAiGd_P4_Player = {}\n    data.MuAiGd_P4_Player.Ice1 = nil\n    data.MuAiGd_P4_Player.Ice2 = nil\n    data.MuAiGd_P4_Player.Ice3 = nil\n    data.MuAiGd_P4_Player.Wind1 = nil\n    data.MuAiGd_P4_Player.Wind2 = nil\n    data.MuAiGd_P4_Player.Water = nil\n    data.MuAiGd_P4_Player.Flame = nil\n    data.MuAiGd_P4_Player.Converge = nil\n    data.MuAiGd_P4_Player.GroupWind = nil\n    --- 1:捡D，2:捡B，3:捡3，4:捡4，5:左龙撞头，6:右龙撞头，7:左下撞龙头，8:右下撞龙头，\n    data.MuAiGd_P4_SelfGuideType = 0\n    data.MuAiGd_P4_InfoGuideType = function()\n        if data.MuAiGd_P4_SelfGuideType == 1 then\n            M.Info(\"当前指路类型：D点拾取贡品。\")\n        elseif data.MuAiGd_P4_SelfGuideType == 2 then\n            M.Info(\"当前指路类型：B点拾取贡品。\")     \n        elseif data.MuAiGd_P4_SelfGuideType == 3 then\n            M.Info(\"当前指路类型：3点拾取贡品。\")    \n        elseif data.MuAiGd_P4_SelfGuideType == 4 then\n            M.Info(\"当前指路类型：4点拾取贡品。\")   \n        elseif data.MuAiGd_P4_SelfGuideType == 5 then\n            M.Info(\"当前指路类型：左边撞龙头。\")   \n        elseif data.MuAiGd_P4_SelfGuideType == 6 then\n            M.Info(\"当前指路类型：右边撞龙头。\")    \n        elseif data.MuAiGd_P4_SelfGuideType == 7 then\n            M.Info(\"当前指路类型：左下撞龙头。\")    \n        elseif data.MuAiGd_P4_SelfGuideType == 8 then\n            M.Info(\"当前指路类型：右下撞龙头。\")\n        end\n    end\nend\n\n--- 固定位置转换到类型\nlocal FixToType = function(fixPoint)\n    if fixPoint == \"D\" then\n        return 1\n    elseif fixPoint == \"B\" then\n        return 2\n    elseif fixPoint == \"3\" then\n        return 3\n    elseif fixPoint == \"4\" then\n        return 4\n    end\nend\n\nif not data.MuAiGd_P4_BuffCollected then\n    for i = 1, #M.JobPosName do\n        local job = M.JobPosName[i]\n        local player = M.Party[job]\n\n        local claw3263 = TensorCore.getBuff(player.id, 3263)\n        local booth3264 = TensorCore.getBuff(player.id, 3264)\n\n        local wind2463 = TensorCore.getBuff(player.id, 2463)\n        local ice2462 = TensorCore.getBuff(player.id, 2462)\n        local flame2460 = TensorCore.getBuff(player.id, 2460)\n        local water2461 = TensorCore.getBuff(player.id, 2461)\n        local converge2454 = TensorCore.getBuff(player.id, 2454)\n\n        if ice2462 then\n            if claw3263 then\n                if data.MuAiGd_P4_Player.Ice1 == nil then\n                    data.MuAiGd_P4_Player.Ice1 = player\n                    if MuAiGuide.IsMe(player) then\n                        data.MuAiGd_P4_SelfGuideType = 5\n                    end\n                else\n                    data.MuAiGd_P4_Player.Ice2 = player\n                    if MuAiGuide.IsMe(player) then\n                        data.MuAiGd_P4_SelfGuideType = 6\n                    end\n                end\n            else\n                if booth3264 then\n                    data.MuAiGd_P4_Player.Ice3 = player\n                    local fixConfig = MuAiGuide.Config.FruCfg.CrystallizeTimeFix[2462]\n                    if MuAiGuide.IsMe(player) then\n                        data.MuAiGd_P4_SelfGuideType = FixToType(fixConfig)\n                    end\n                   \n                end\n            end\n        end\n        if wind2463 then\n            if data.MuAiGd_P4_Player.Wind1 == nil then\n                data.MuAiGd_P4_Player.Wind1 = player\n                if MuAiGuide.IsMe(player) then\n                    data.MuAiGd_P4_SelfGuideType = 7\n                end\n               \n            else\n                data.MuAiGd_P4_Player.Wind2 = player\n                if MuAiGuide.IsMe(player) then\n                    data.MuAiGd_P4_SelfGuideType = 8\n                end\n            end\n        end\n        if water2461 then\n            data.MuAiGd_P4_Player.Water = player\n            local fixConfig = MuAiGuide.Config.FruCfg.CrystallizeTimeFix[2461]\n            if MuAiGuide.IsMe(player) then\n                data.MuAiGd_P4_SelfGuideType = FixToType(fixConfig)\n            end\n        end\n        if flame2460 then\n            data.MuAiGd_P4_Player.Flame = player\n            local fixConfig = MuAiGuide.Config.FruCfg.CrystallizeTimeFix[2460]\n            if MuAiGuide.IsMe(player) then\n                data.MuAiGd_P4_SelfGuideType = FixToType(fixConfig)\n            end\n        end\n        if converge2454 then\n            data.MuAiGd_P4_Player.Converge = player\n            local fixConfig = MuAiGuide.Config.FruCfg.CrystallizeTimeFix[2454]\n            if MuAiGuide.IsMe(player) then\n                data.MuAiGd_P4_SelfGuideType = FixToType(fixConfig)\n            end\n        end\n    end\n    M.Info(\"初始BUFF分析完毕：\")\n    data.MuAiGd_P4_InfoGuideType()\n    data.MuAiGd_P4_BuffCollected = true\nend\n\n-- 如果手摇，在获取BUFF后，循环执行进行逻辑覆盖，则持续判断标记类型\nif data.MuAiGd_P4_BuffCollected\n    and MuAiGuide.Config.FruCfg.CrystallizeTimeType == 3\n    and TensorCore.getBuff(MuAiGuide.GetPlayer().id, 3264) then\n    for i = 1, #M.JobPosName do\n        local job = M.JobPosName[i]\n        local player = M.Party[job]\n        local booth3264 = TensorCore.getBuff(player.id, 3264)\n        if booth3264 then\n            if not MuAiGuide.IsMe(player) and player.maker ~= 0 and player.maker <= 4 then\n                data.MuAiGd_P4_ManualMarks[player.maker] = player\n            end\n        end\n    end\n    if table.size(data.MuAiGd_P4_ManualMarks) == 3 and MuAiGuide.GetPlayer().maker == 0 then\n        local notUseId = 0\n        for i = 1, 4 do\n            if data.MuAiGd_P4_ManualMarks[i] == nil then\n                notUseId = i\n                break\n            end\n        end\n        ActionList:Get(12, notUseId):Cast(MuAiGuide.GetPlayer().id)\n        data.MuAiGd_P4_SelfGuideType = notUseId\n        self.used = true\n    end\nelse\n    self.used = true\nend",
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
							actionLua = "local guideTime = 10000\nif data.MuAiGd_P4_Lights == nil then\n    data.MuAiGd_P4_Lights = {}\n    --- 场地类型 1:左上紫色，2:右上紫色\n    data.MuAiGd_P4_GroundType = 0\nend\n\n-- 采集灯\nif table.size(data.MuAiGd_P4_Lights) < 6 then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=9823\")) do\n        data.MuAiGd_P4_Lights[ent.id] = ent\n    end\nend\nif table.size(data.MuAiGd_P4_Lights) == 6 then\n    local purpleLines = {}\n    for _, light in pairs(data.MuAiGd_P4_Lights) do\n        local lines = Argus.getTethersOnEnt(light.id)\n        for _, line in pairs(lines) do\n            if line.type == 133 then\n                purpleLines[light.id] = light\n            end\n        end\n    end\n    if table.size(purpleLines) == 2 then\n        for _, purpleLine in pairs(purpleLines) do\n            if purpleLine.pos.z < 100 then\n                if purpleLine.pos.x > 100 then\n                    data.MuAiGd_P4_GroundType = 2\n                else\n                    data.MuAiGd_P4_GroundType = 1\n                end\n            end\n        end\n\n        -- 如果当前为标点模式，且自身有标点\n        if MuAiGuide.Config.FruCfg.CrystallizeTimeType ~= 1 and MuAiGuide.GetPlayer().marker ~= 0 then\n            if MuAiGuide.GetPlayer().marker <= 4 then\n                --- type 1:捡D，2:捡B，3:捡3，4:捡4，\n                if MuAiGuide.Config.FruCfg.CrystallizeMark[\"D\"] == MuAiGuide.GetPlayer().marker then\n                    data.MuAiGd_P4_SelfGuideType = 1\n                elseif MuAiGuide.Config.FruCfg.CrystallizeMark[\"B\"] == MuAiGuide.GetPlayer().marker then\n                    data.MuAiGd_P4_SelfGuideType = 2\n                elseif MuAiGuide.Config.FruCfg.CrystallizeMark[\"3\"] == MuAiGuide.GetPlayer().marker then\n                    data.MuAiGd_P4_SelfGuideType = 3\n                elseif MuAiGuide.Config.FruCfg.CrystallizeMark[\"4\"] == MuAiGuide.GetPlayer().marker then\n                    data.MuAiGd_P4_SelfGuideType = 4\n                end\n            else\n                if MuAiGuide.GetPlayer().marker == 6 then\n                    data.MuAiGd_P4_SelfGuideType = 5\n                elseif MuAiGuide.GetPlayer().marker == 7 then\n                    data.MuAiGd_P4_SelfGuideType = 6\n                elseif MuAiGuide.GetPlayer().marker == 9 then\n                    data.MuAiGd_P4_SelfGuideType = 7\n                elseif MuAiGuide.GetPlayer().marker == 10 then\n                    data.MuAiGd_P4_SelfGuideType = 8\n                end\n            end\n            if MuAiGuide.Config.FruCfg.CrystallizeTimeType == 2 then\n                MuAiGuide.Info(\"检测到当前为ACT标点模式，逻辑变更：\")\n            elseif MuAiGuide.Config.FruCfg.CrystallizeTimeType == 3 then\n                MuAiGuide.Info(\"检测到当前为手摇模式，逻辑变更：\")\n            end\n            data.MuAiGd_P4_InfoGuideType()\n        end\n\n        if MuAiGuide.IsMe(data.MuAiGd_P4_Player.Flame) then -- 暗单走\n            if data.MuAiGd_P4_GroundType == 1 then\n                MuAiGuide.DirectTo(88.67, 84, guideTime, 0.3)\n            else\n                MuAiGuide.DirectTo(111.33, 84, guideTime, 0.3)\n            end\n        else\n            if data.MuAiGd_P4_SelfGuideType <= 4 then -- 3个蓝BUFF\n                if data.MuAiGd_P4_GroundType == 1 then\n                    MuAiGuide.DirectTo(111.33, 116, guideTime, 0.3)\n                else\n                    MuAiGuide.DirectTo(88.67, 116, guideTime, 0.3)\n                end\n            elseif data.MuAiGd_P4_SelfGuideType == 7 then\n                MuAiGuide.DirectTo(88.67, 116, guideTime, 0.3)\n            elseif data.MuAiGd_P4_SelfGuideType == 8 then\n                MuAiGuide.DirectTo(111.33, 116, guideTime, 0.3)\n            elseif data.MuAiGd_P4_SelfGuideType == 5 then\n                MuAiGuide.DirectTo(87, 100, guideTime)\n            elseif data.MuAiGd_P4_SelfGuideType == 6 then\n                MuAiGuide.DirectTo(113, 100, guideTime)\n            end\n        end\n    end\n    if MuAiGuide.Config.LogToEchoMsg then\n        if data.MuAiGd_P4_SelfGuideType <= 4 then\n            if MuAiGuide.IsMe(data.MuAiGd_P4_Player.Flame) then\n                MuAiGuide.Info(\"我是暗单走。\")\n            else\n                MuAiGuide.Info(\"我和人群一起行动。\")\n            end\n        end\n    end\nend\ndata.MuAiGd_P4_Guide1Finish = true\nself.used = true\n",
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
							actionLua = "local M = MuAiGuide\nif data.MuAiGd_P4_Flags == nil then\n    data.MuAiGd_P4_Flags = {\n        Water = false,\n        Converge = false,\n        Wind = false,\n        Blue = false,\n        Red = false,\n        MissRed = false,\n        LinkToHead = false,\n        Avoid = false,\n        EndGuide = false,\n        RedGuides = {}\n    }\n    data.MuAiGd_P4_FinalGuide = function()\n        if data.MuAiGd_P4_WaveGuideHeading == nil or data.MuAiGd_P4_WaveGuideHeading < -10 then\n            return false\n        end\n        local endHeading\n        local distance\n        if M.Config.FruCfg.CrystallizeTimeKnockBack == 1 then --Y字 then\n            if M.SelfPos == \"MT\" then\n                endHeading = data.MuAiGd_P4_WaveGuideHeading + math.pi / 8\n                distance = 14\n            elseif M.SelfPos == \"ST\" then\n                endHeading = data.MuAiGd_P4_WaveGuideHeading - math.pi / 8\n                distance = 14\n            else\n                endHeading = data.MuAiGd_P4_WaveGuideHeading\n                distance = 4\n            end\n        else\n            local selfIndex = M.IndexOf(M.JobPosName)\n            if selfIndex % 2 == 1 then -- mt 组\n                if M.SelfPos == \"MT\" then\n                    endHeading = data.MuAiGd_P4_WaveGuideHeading + math.pi * 11 / 180\n                    distance = 16.1\n                else\n                    endHeading = data.MuAiGd_P4_WaveGuideHeading + math.pi * 8 / 180\n                    distance = 13\n                end\n            else\n                if M.SelfPos == \"ST\" then\n                    endHeading = data.MuAiGd_P4_WaveGuideHeading + math.pi * 11 / 180\n                    distance = 16.1\n                else\n                    endHeading = data.MuAiGd_P4_WaveGuideHeading + math.pi * 8 / 180\n                    distance = 13\n                end\n            end\n        end\n        local targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, endHeading, distance)\n        local curReturn = TensorCore.getBuff(M.GetPlayer().id, 4208)\n        if curReturn ~= nil then\n            M.DirectTo(targetPos.x, targetPos.z, curReturn.duration * 1000)\n        else\n            M.DirectTo(targetPos.x, targetPos.z, 5000)\n        end\n        return true\n    end\n    data.MuAiGd_P4_GetDragonHead = function()\n        local heads = {}\n        local rightHead, leftHead\n        for _, ent in pairs(TensorCore.entityList(\"contentid=9323\")) do\n            if Argus.getEntityModel(ent.id) == 17836 then\n                table.insert(heads, ent)\n            end\n        end\n        if heads[1].pos.x > heads[2].pos.x then\n            rightHead = heads[1]\n            leftHead = heads[2]\n        else\n            leftHead = heads[1]\n            rightHead = heads[2]\n        end\n        return leftHead, rightHead\n    end\nend\n\nif data.MuAiGd_P4_SelfGuideType <= 4 then -- 分摊BUFF倒计时结束\n    -- 水判定，准备击退\n    if data.MuAiGd_P4_Flags.Water == false then\n        if not M.IsMe(data.MuAiGd_P4_Player.Flame) then\n            local curWater = TensorCore.getBuff(data.MuAiGd_P4_Player.Water.id, 2461)\n            if curWater == nil or curWater.duration < 0.9 then\n                local pos\n                if data.MuAiGd_P4_GroundType == 1 then\n                    pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi / 6, 17)\n                else\n                    pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 11 / 6, 17)\n                end\n                M.DirectTo(pos.x, pos.z, 4000, 0.3)\n                data.MuAiGd_P4_Flags.Water = true\n                M.Info(\"准备击退。\")\n            end\n        end\n    end\n\n    if data.MuAiGd_P4_Flags.Wind == false then\n        -- 被击退/暗判定 =>调整位置进行分摊\n        local curWind = TensorCore.getBuff(data.MuAiGd_P4_Player.Wind1.id, 2463)\n        if curWind == nil or curWind.duration < 0.1 then\n            local pos\n            if data.MuAiGd_P4_GroundType == 1 then\n                pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 5 / 4, 19.5)\n            else\n                pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 3 / 4, 19.5)\n            end\n            M.DirectTo(pos.x, pos.z, 4000)\n            data.MuAiGd_P4_Flags.Wind = true\n            M.Info(\"调整位置到斜点。\")\n        end\n    end\n\n    if data.MuAiGd_P4_Flags.Converge == false then\n        -- 分摊判定回A\n        local curConverge = TensorCore.getBuff(data.MuAiGd_P4_Player.Converge.id, 2454)\n        if curConverge == nil or curConverge.duration < 0.1 then\n            M.DirectTo(100, 82, 4000)\n            data.MuAiGd_P4_Flags.Converge = true\n            M.Info(\"分摊完毕前往A方向。\")\n        end\n    end\n\n    --- 指路捡垃圾\n    if data.MuAiGd_P4_Flags.Blue == false then\n        local removerList = {}\n        local curBlue = TensorCore.getBuff(M.GetPlayer().id, 3264)\n        if curBlue and curBlue.duration < 18.5 then\n            for _, ent in pairs(TensorCore.entityList(\"contentid=2014529\")) do\n                table.insert(removerList, ent)\n            end\n            for i = 1, #removerList do\n                for j = 1, #removerList - i do\n                    if removerList[j].pos.x > removerList[j + 1].pos.x then\n                        removerList[j], removerList[j + 1] = removerList[j + 1], removerList[j]\n                    end\n                end\n            end\n            local pos\n            if data.MuAiGd_P4_SelfGuideType == 1 then\n                M.Info(\"去D点附近捡垃圾。\")\n                pos = removerList[1].pos\n            elseif data.MuAiGd_P4_SelfGuideType == 2 then\n                M.Info(\"去B点附近捡垃圾。\")\n                pos = removerList[4].pos\n            elseif data.MuAiGd_P4_SelfGuideType == 3 then\n                M.Info(\"去3点附近捡垃圾。\")\n                pos = removerList[3].pos\n            elseif data.MuAiGd_P4_SelfGuideType == 4 then\n                M.Info(\"去4点附近捡垃圾。\")\n                pos = removerList[2].pos\n            end\n            M.DirectTo(pos.x, pos.z, curBlue.duration * 1000)\n            data.MuAiGd_P4_Flags.Blue = true\n        end\n    end\n    if data.MuAiGd_P4_Flags.EndGuide == false then\n        local curBlue = TensorCore.getBuff(M.GetPlayer().id, 3264)\n        if curBlue == nil then\n            if data.MuAiGd_P4_FinalGuide() then\n                M.Info(\"垃圾回收成功！\")\n                data.MuAiGd_P4_Flags.EndGuide = true\n                self.used = true\n            end\n        end\n    end\nelse\n    if data.MuAiGd_P4_SelfGuideType == 5 or data.MuAiGd_P4_SelfGuideType == 6 then\n        -- 左右撞头\n        if data.MuAiGd_P4_Flags.LinkToHead == false then\n            local curClaw = TensorCore.getBuff(M.GetPlayer().id, 3263)\n            if curClaw and curClaw.duration <= 8 then\n                M.CancelDir()\n                local leftHead, rightHead = data.MuAiGd_P4_GetDragonHead()\n                local selfHead\n                if data.MuAiGd_P4_SelfGuideType == 5 then\n                    selfHead = leftHead\n                else\n                    selfHead = rightHead\n                end\n                data.MuAiGd_P4_Flags.RedGuides = M.DirectToEnt(selfHead.id, 10000)\n                data.MuAiGd_P4_Flags.LinkToHead = true\n            end\n        end\n\n        -- 撞头完毕\n        if data.MuAiGd_P4_Flags.MissRed == false then\n            local curClaw = TensorCore.getBuff(M.GetPlayer().id, 3263)\n            if curClaw == nil then\n                for _, uuid in pairs(data.MuAiGd_P4_Flags.RedGuides) do\n                    Argus.deleteTimedShape(uuid)\n                end\n                if data.MuAiGd_P4_SelfGuideType == 5 then\n                    if data.MuAiGd_P4_GroundType == 1 then\n                        local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 5 / 4, 19.5)\n                        M.DirectTo(pos.x, pos.z, 4000)\n                        M.Info(\"撞头完毕，和人群分摊。\")\n                    else\n                        MuAiGuide.DirectTo(80.5, 101.8, 8000, 0.3)\n                        M.Info(\"撞头完毕，躲开大圈。\")\n                    end\n                elseif data.MuAiGd_P4_SelfGuideType == 6 then\n                    if data.MuAiGd_P4_GroundType == 2 then\n                        local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 3 / 4, 19.5)\n                        M.DirectTo(pos.x, pos.z, 4000)\n                        M.Info(\"撞头完毕，和人群分摊。\")\n                    else\n                        MuAiGuide.DirectTo(119.5, 101.8, 8000, 0.3)\n                        M.Info(\"撞头完毕，躲开大圈。\")\n                    end\n                end\n                data.MuAiGd_P4_Flags.MissRed = true\n            end\n        end\n        -- 分摊\n        if data.MuAiGd_P4_Flags.Converge == false then\n            if data.MuAiGd_P4_SelfGuideType == 5 and data.MuAiGd_P4_GroundType == 1 or data.MuAiGd_P4_SelfGuideType == 6 and data.MuAiGd_P4_GroundType == 2 then\n                local curConverge = TensorCore.getBuff(data.MuAiGd_P4_Player.Converge.id, 2454)\n                if curConverge == nil or curConverge.duration < 0.1 then\n                    M.DirectTo(100, 82, 4000)\n                    data.MuAiGd_P4_Flags.Converge = true\n                    M.Info(\"分摊完毕前往A方向。\")\n                end\n            end\n        end\n\n        -- 躲大圈\n        if data.MuAiGd_P4_Flags.Avoid == false then\n            if data.MuAiGd_P4_SelfGuideType == 5 and data.MuAiGd_P4_GroundType == 2 or data.MuAiGd_P4_SelfGuideType == 6 and data.MuAiGd_P4_GroundType == 1 then\n                local curReturn = TensorCore.getBuff(M.GetPlayer().id, 4208)\n                if curReturn and curReturn.duration < 16.5 then\n                    M.Info(\"前往A点。\")\n                    M.DirectTo(100, 82, 8000)\n                    data.MuAiGd_P4_Flags.Avoid = true\n                end\n            end\n        end\n\n        -- 终点指路\n        if data.MuAiGd_P4_Flags.EndGuide == false then\n            local curReturn = TensorCore.getBuff(M.GetPlayer().id, 4208)\n            if curReturn and curReturn.duration < 13 then\n                if data.MuAiGd_P4_FinalGuide() then\n                    data.MuAiGd_P4_Flags.EndGuide = true\n                    self.used = true\n                end\n            end\n        end\n    else\n        -- 水判定\n        if data.MuAiGd_P4_Flags.Water == false then\n            local curWater = TensorCore.getBuff(data.MuAiGd_P4_Player.Water.id, 2461)\n            if curWater == nil or curWater.duration < 0.9 then\n                local pos\n                M.Info(\"准备站位击飞其他人。\")\n                if data.MuAiGd_P4_SelfGuideType == 7 then\n                    pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 11 / 6, 19.5)\n                else\n                    pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi / 6, 19.5)\n                end\n                M.DirectTo(pos.x, pos.z, 4000)\n                data.MuAiGd_P4_Flags.Water = true\n            end\n        end\n\n        --风判定\n        if data.MuAiGd_P4_Flags.Wind == false then\n            -- 被击退/暗判定 =>调整位置进行分摊\n            local curWind = TensorCore.getBuff(data.MuAiGd_P4_Player.Wind1.id, 2463)\n            if curWind == nil or curWind.duration < 0.1 then\n                M.Info(\"躲开大圈。\")\n                local pos\n                if data.MuAiGd_P4_SelfGuideType == 7 then\n                    M.DirectTo(92.5, 117.9, 5000)\n                else\n                    M.DirectTo(107.5, 117.9, 5000)\n                end\n                data.MuAiGd_P4_Flags.Wind = true\n            end\n        end\n \n        -- 左下右下撞头\n        if data.MuAiGd_P4_Flags.LinkToHead == false then\n            local curClaw = TensorCore.getBuff(M.GetPlayer().id, 3263)\n            if curClaw and curClaw.duration <= 23.5 then\n                M.Info(\"龙撞头。\")\n                M.CancelDir()\n                local leftHead, rightHead = data.MuAiGd_P4_GetDragonHead()\n                local selfHead\n                if data.MuAiGd_P4_SelfGuideType == 7 then\n                    selfHead = leftHead\n                else\n                    selfHead = rightHead\n                end\n                data.MuAiGd_P4_Flags.RedGuides = M.DirectToEnt(selfHead.id, 10000)\n                data.MuAiGd_P4_Flags.LinkToHead = true\n            end\n        end\n\n        -- 撞头完毕\n        if data.MuAiGd_P4_Flags.MissRed == false then\n            local curClaw = TensorCore.getBuff(M.GetPlayer().id, 3263)\n            if curClaw == nil then\n                for _, uuid in pairs(data.MuAiGd_P4_Flags.RedGuides) do\n                    Argus.deleteTimedShape(uuid)\n                end\n                M.Info(\"前往C点。\")\n                M.DirectTo(100, 118, 8000)\n                data.MuAiGd_P4_Flags.MissRed = true\n            end\n        end\n\n        -- 终点指路\n        if data.MuAiGd_P4_Flags.EndGuide == false then\n            local curReturn = TensorCore.getBuff(M.GetPlayer().id, 4208)\n            if curReturn and curReturn.duration < 13 then\n                if data.MuAiGd_P4_FinalGuide() then\n                    data.MuAiGd_P4_Flags.EndGuide = true\n                    self.used = true\n                end\n            end\n        end\n    end\nend\n",
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
							actionLua = "d(\"[MuAiGuide]自动使用防击退！\")\nself.used = true",
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
							name = "log",
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
							name = "Y字击退",
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
	[222] = 
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
							actionLua = "if data.MuAiGd_P5_LDStartTime1 == nil then\n    data.MuAiGd_P5_LDStartTime1 = Now()\nend\nif data.MuAiGd_P5_TowerGuide == nil then\n    data.MuAiGd_P5_TowerGuide = function(startTime, towers, castInfo)\n        local purpleDrawer = Argus2.ShapeDrawer:new(\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 0.5)),\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 0.5)),\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 0.5)),\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 2)),\n            2\n        )\n        local yellowDrawer = Argus2.ShapeDrawer:new(\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 0 / 255, 0.5)),\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 0 / 255, 0.5)),\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 0 / 255, 0.5)),\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 2)),\n            2\n        )\n        --- 绘制左右刀和圆圈范围\n        ---@param playerId number 当前1仇\n        local drawAoeRange = function(playerId, skillId, first)\n            local targetPos = TensorCore.mGetEntity(playerId).pos\n            local curHeading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, targetPos)\n            local skillType\n            if first then\n                skillType = skillId\n            else\n                if skillId == 40313 then\n                    skillType = 40233\n                else\n                    skillType = 40313\n                end\n            end\n            if skillType == 40313 then\n                yellowDrawer:addCone(100, 0, 100, 20, math.pi * 5 / 4, curHeading + math.pi * 3 / 8, 0, false)\n                local farthest, maxDistance\n                for i, ent in pairs(MuAiGuide.Party) do\n                    local curPos = TensorCore.mGetEntity(ent.id).pos\n                    if farthest == nil then\n                        farthest = curPos\n                        maxDistance = TensorCore.getDistance2d({ x = 100, y = 0, z = 100 }, curPos)\n                    else\n                        local distance = TensorCore.getDistance2d({ x = 100, y = 0, z = 100 }, curPos)\n                        if distance > maxDistance then\n                            farthest = curPos\n                            maxDistance = distance\n                        end\n                    end\n                end\n                yellowDrawer:addCircle(farthest.x, farthest.y, farthest.z, 4)\n            elseif skillType == 40233 then\n                purpleDrawer:addCone(100, 0, 100, 20, math.pi * 5 / 4, curHeading - math.pi * 3 / 8, 0, false)\n                local nearest, minDistance\n                for i, ent in pairs(MuAiGuide.Party) do\n                    local curPos = TensorCore.mGetEntity(ent.id).pos\n                    if nearest == nil then\n                        nearest = curPos\n                        minDistance = TensorCore.getDistance2d({ x = 100, y = 0, z = 100 }, curPos)\n                    else\n                        local distance = TensorCore.getDistance2d({ x = 100, y = 0, z = 100 }, curPos)\n                        if distance < minDistance then\n                            nearest = curPos\n                            minDistance = distance\n                        end\n                    end\n                end\n                purpleDrawer:addCircle(nearest.x, nearest.y, nearest.z, 4)\n            end\n        end\n\n        local timeSince = TimeSince(startTime)\n        --- 下塔到中心的方向\n        local headingD2U = TensorCore.getHeadingToTarget(towers.Down, { x = 100, y = 0, z = 100 })\n\n        if timeSince < 8000 then\n            drawAoeRange(castInfo.MT.id, castInfo.SkillId, true)\n            if MuAiGuide.IsMe(castInfo.MT) then\n                local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, headingD2U, 7)\n                MuAiGuide.FrameDirect(pos.x, pos.z)\n            elseif MuAiGuide.IsMe(castInfo.ST) then\n                local heading\n                local distance\n                if castInfo.SkillId == 40313 then\n                    local mid = {\n                        x = (towers.Down.x + towers.Right.x) / 2,\n                        y = 0,\n                        z = (towers.Down.z + towers.Right.z) / 2\n                    }\n                    heading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, mid)\n                    distance = 19.5\n                elseif castInfo.SkillId == 40233 then\n                    local mid = {\n                        x = (towers.Down.x + towers.Left.x) / 2,\n                        y = 0,\n                        z = (towers.Down.z + towers.Left.z) / 2\n                    }\n                    heading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, mid)\n                    distance = 2\n                end\n                local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, distance)\n                MuAiGuide.FrameDirect(pos.x, pos.z)\n            else\n                if table.contains(MuAiGuide.Config.FruCfg.DarkLightWings.Down, MuAiGuide.SelfPos) then\n                    local towerHeading = headingD2U + math.pi\n                    local heading\n                    if castInfo.SkillId == 40313 then\n                        heading = towerHeading + 1 / 7\n                    elseif castInfo.SkillId == 40233 then\n                        heading = towerHeading - 1 / 7\n                    end\n                    local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 7)\n                    MuAiGuide.FrameDirect(pos.x, pos.z)\n                else\n                    if castInfo.SkillId == 40313 and table.contains(MuAiGuide.Config.FruCfg.DarkLightWings.Right, MuAiGuide.SelfPos) then\n                        local heading = headingD2U - math.pi / 4 - math.pi / 12\n                        local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 8)\n                        MuAiGuide.FrameDirect(pos.x, pos.z)\n                    elseif castInfo.SkillId == 40233 and table.contains(MuAiGuide.Config.FruCfg.DarkLightWings.Left, MuAiGuide.SelfPos) then\n                        local heading = headingD2U + math.pi / 4 + math.pi / 12\n                        local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 8)\n                        MuAiGuide.FrameDirect(pos.x, pos.z)\n                    end\n                end\n            end\n        elseif (timeSince < 12000) then\n            drawAoeRange(castInfo.ST.id, castInfo.SkillId, false)\n            if MuAiGuide.IsMe(castInfo.MT) then\n                local distance\n                if castInfo.SkillId == 40233 then\n                    distance = 19.5\n                elseif castInfo.SkillId == 40313 then\n                    distance = 2\n                end\n                local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, headingD2U, distance)\n                MuAiGuide.FrameDirect(pos.x, pos.z)\n            elseif MuAiGuide.IsMe(castInfo.ST) then\n                local heading\n                if castInfo.SkillId == 40313 then\n                    local mid = {\n                        x = (towers.Down.x + towers.Right.x) / 2,\n                        y = 0,\n                        z = (towers.Down.z + towers.Right.z) / 2\n                    }\n                    heading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, mid)\n                elseif castInfo.SkillId == 40233 then\n                    local mid = {\n                        x = (towers.Down.x + towers.Left.x) / 2,\n                        y = 0,\n                        z = (towers.Down.z + towers.Left.z) / 2\n                    }\n                    heading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, mid)\n                end\n                local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 7)\n                MuAiGuide.FrameDirect(pos.x, pos.z)\n            else\n                if table.contains(MuAiGuide.Config.FruCfg.DarkLightWings.Down, MuAiGuide.SelfPos) then\n                    local pos\n                    if castInfo.SkillId == 40313 then\n                        pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, headingD2U, 10)\n                    elseif castInfo.SkillId == 40233 then\n                        pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, headingD2U, 5)\n                    end\n                    MuAiGuide.FrameDirect(pos.x, pos.z)\n                else\n                    if castInfo.SkillId == 40313 and table.contains(MuAiGuide.Config.FruCfg.DarkLightWings.Left, MuAiGuide.SelfPos) then\n                        MuAiGuide.FrameDirect(towers.Left.x, towers.Left.z)\n                    elseif castInfo.SkillId == 40233 and table.contains(MuAiGuide.Config.FruCfg.DarkLightWings.Right, MuAiGuide.SelfPos) then\n                        MuAiGuide.FrameDirect(towers.Right.x, towers.Right.z)\n                    end\n                end\n            end\n        end\n    end\nend\n\ndata.MuAiGd_P5_TowerGuide(data.MuAiGd_P5_LDStartTime1, data.MuAiGd_P5_Towers, data.MuAiGd_P5CastInfo)\nself.used = true\n",
							conditions = 
							{
								
								{
									"aa6083d6-9c1e-d8ad-ad02-5f22e0fae8fa",
									true,
								},
							},
							gVar = "ACR_RikuGNB3_CD",
							uuid = "198103b8-80ac-dcac-83a6-beee85117067",
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
							conditionLua = "return data.MuAiGd_P5_Towers ~= nil and data.MuAiGd_P5CastInfo ~= nil",
							uuid = "aa6083d6-9c1e-d8ad-ad02-5f22e0fae8fa",
							version = 2,
						},
					},
				},
				eventType = 12,
				mechanicTime = 1033.6,
				name = "[MuAiGuide]左右刀&踩塔指路",
				timeRange = true,
				timelineIndex = 222,
				timerStartOffset = -30,
				uuid = "39ddc27b-7256-3e58-8a24-082cca1c31db",
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
							actionLua = "if data.MuAiGd_GetP5TowerTable == nil then\n    data.MuAiGd_P5_Towers = nil\n    data.MuAiGd_GetP5TowerTable = function(a1)\n        local left = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 4 / 3, 7)\n        local right = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 2 / 3, 7)\n        local down = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, 0, 7)\n        if a1 == 51 then\n            return { Down = left, Left = right, Right = down }\n        elseif a1 == 52 then\n            return { Down = right, Left = down, Right = left }\n        elseif a1 == 53 then\n            return { Down = down, Left = left, Right = right }\n        end\n        return nil\n    end\nend\nif data.MuAiGd_P5_Towers == nil then\n\tlocal result = data.MuAiGd_GetP5TowerTable(eventArgs.a1)\n\tif result ~= nil then\n\t\td(eventArgs.a1)\n\t\td(result)\n\t\tdata.MuAiGd_P5_Towers = result\n\tend\nend\nself.used = true",
							conditions = 
							{
								
								{
									"0d3db2d7-d7d4-0c2d-8a72-3fe6b8c71536",
									true,
								},
							},
							gVar = "ACR_RikuGNB3_CD",
							uuid = "c5ce03af-9d98-db9c-99c3-585821790223",
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
							conditionLua = "return eventArgs.a2 == 1 and eventArgs.a3 == 2 and data.MuAiGd_P5_Towers == nil",
							uuid = "0d3db2d7-d7d4-0c2d-8a72-3fe6b8c71536",
							version = 2,
						},
					},
				},
				eventType = 14,
				mechanicTime = 1033.6,
				name = "[MuAiGuide]分析塔位置",
				timeRange = true,
				timelineIndex = 222,
				timerEndOffset = 3,
				timerStartOffset = -20,
				uuid = "5d5aac25-32a9-3239-84a7-30236bbe05f7",
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
							actionLua = "if data.MuAiGd_P5GetCastInfo == nil then\n    data.MuAiGd_P5GetCastInfo = function(skillId)\n        local curMT = TensorCore.getEntityByGroup(\"Main Tank\", \"Nearest\")\n        local curST\n        if MuAiGuide.Party[\"MT\"].id == curMT.id then\n            curST = MuAiGuide.Party[\"ST\"]\n        else\n            curST = MuAiGuide.Party[\"MT\"]\n        end\n        return { MT = curMT, ST = curST, SkillId = skillId }\n    end\nend\n\ndata.MuAiGd_P5CastInfo = data.MuAiGd_P5GetCastInfo(eventArgs.spellID)\nd(data.MuAiGd_P5CastInfo)\nself.used = true",
							conditions = 
							{
								
								{
									"c25ee2de-b639-e5ed-8022-60cbcc01c230",
									true,
								},
							},
							gVar = "ACR_RikuGNB3_CD",
							uuid = "198103b8-80ac-dcac-83a6-beee85117067",
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
							eventArgOptionType = 3,
							eventArgType = 2,
							eventSpellID = 40233,
							name = "光与暗黑的双翼",
							spellIDList = 
							{
								40313,
								40233,
							},
							uuid = "c25ee2de-b639-e5ed-8022-60cbcc01c230",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 1033.6,
				name = "[MuAiGuide]读条类型分析",
				timeRange = true,
				timelineIndex = 222,
				timerEndOffset = 20,
				timerStartOffset = -20,
				uuid = "9ed56e58-5dcd-3456-8f73-d72ffa4ec644",
				version = 2,
			},
			inheritedIndex = 5,
		},
	},
	[247] = 
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
							actionLua = "data.MuAiGd_P5_Towers = nil\ndata.MuAiGd_P5CastInfo = nil\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "a5e8aa3b-649f-3abc-a4d8-a7bcb66f2420",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1146.3,
				name = "[MuAiGuide]ClearCache",
				timelineIndex = 247,
				timerOffset = -30,
				uuid = "50e9fdda-52f5-b3df-81fd-92a66b734838",
				version = 2,
			},
		},
	},
	[250] = 
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
							actionLua = "if data.MuAiGd_P5_Towers == nil then\n\tlocal result = data.MuAiGd_GetP5TowerTable(eventArgs.a1)\n\tif result ~= nil then\n\t\td(eventArgs.a1)\n\t\td(result)\n\t\tdata.MuAiGd_P5_Towers = result\n\tend\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"a84a5896-c18a-d96e-98c7-7113928e3731",
									true,
								},
							},
							gVar = "ACR_RikuGNB3_CD",
							uuid = "c5ce03af-9d98-db9c-99c3-585821790223",
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
							conditionLua = "return eventArgs.a2 == 1 and eventArgs.a3 == 2 and data.MuAiGd_P5_Towers == nil",
							uuid = "a84a5896-c18a-d96e-98c7-7113928e3731",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				eventType = 14,
				mechanicTime = 1150.3,
				name = "[MuAiGuide]分析塔位置",
				timeRange = true,
				timelineIndex = 250,
				timerStartOffset = -20,
				uuid = "6fdcc152-dc0a-2a8b-a278-483079c843c9",
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
							actionLua = "data.MuAiGd_P5CastInfo = data.MuAiGd_P5GetCastInfo(eventArgs.spellID)\nd(data.MuAiGd_P5CastInfo)\nself.used = true",
							conditions = 
							{
								
								{
									"c25ee2de-b639-e5ed-8022-60cbcc01c230",
									true,
								},
							},
							gVar = "ACR_RikuGNB3_CD",
							uuid = "198103b8-80ac-dcac-83a6-beee85117067",
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
							eventArgOptionType = 3,
							eventArgType = 2,
							eventSpellID = 40233,
							name = "光与暗黑的双翼",
							spellIDList = 
							{
								40313,
								40233,
							},
							uuid = "c25ee2de-b639-e5ed-8022-60cbcc01c230",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 1150.3,
				name = "[MuAiGuide]读条类型分析",
				timeRange = true,
				timelineIndex = 250,
				timerEndOffset = 20,
				timerStartOffset = -20,
				uuid = "0d97e63c-d9dc-f5fd-82fa-b059761eda42",
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
							actionLua = "if data.MuAiGd_P5_LDStartTime2 == nil then\n    data.MuAiGd_P5_LDStartTime2 = Now()\nend\ndata.MuAiGd_P5_TowerGuide(data.MuAiGd_P5_LDStartTime2, data.MuAiGd_P5_Towers, data.MuAiGd_P5CastInfo)\nself.used = true\n",
							conditions = 
							{
								
								{
									"aa6083d6-9c1e-d8ad-ad02-5f22e0fae8fa",
									true,
								},
							},
							gVar = "ACR_RikuGNB3_CD",
							uuid = "198103b8-80ac-dcac-83a6-beee85117067",
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
							conditionLua = "return data.MuAiGd_P5_Towers ~= nil and data.MuAiGd_P5CastInfo ~= nil",
							uuid = "aa6083d6-9c1e-d8ad-ad02-5f22e0fae8fa",
							version = 2,
						},
					},
				},
				eventType = 12,
				mechanicTime = 1150.3,
				name = "[MuAiGuide]左右刀&踩塔指路",
				timeRange = true,
				timelineIndex = 250,
				timerStartOffset = -30,
				uuid = "d5a4ca3f-86ad-2373-bd4d-c150a8159c95",
				version = 2,
			},
			inheritedIndex = 3,
		},
	},
	inheritedProfiles = 
	{
		"rdps_mitigation",
	},
	mapID = 1238,
	version = 5,
}



return tbl