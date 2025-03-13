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
						actionLua = "if not MuAiGuide then\n    self.used = true\n    return\nend\n\nif MuAiGuide and MuAiGuide.FruConfigUI.open then\n    MuAiGuide.FruConfigUI.open = false\nend\nif MuAiGuide and MuAiGuide.UI.open then\n    MuAiGuide.UI.open = false\nend\nMuAiGuide.Party = nil\nd(\"[MuAiGuide] 基础数据已清空！\")\nMuAiGuideClearFlg = 1\nMuAiGuide.UIPop = false\nMuAiGuide.SelfPos = nil\nself.used = true",
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
			uuid = "ccba9a67-6513-7043-95d3-8c4db0c7a193",
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
						actionLua = "local path = GetLuaModsPath() .. \"TensorReactions\\\\GeneralReactions\\\\MuAiGuideData\\\\\"\nMuAiGuideRoot = path\nd(\"[MuAiGuide]当前文件路径: \"..MuAiGuideRoot)\nself.used = true",
						conditions = 
						{
							
							{
								"b78ab0cc-9e0f-2286-8d92-db467096ddd7",
								true,
							},
						},
						name = "FilePath",
						uuid = "f6791738-8ac1-e4b0-be07-4f56371a05f6",
						version = 2.1,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "if MuAiGuide == nil then\n\tlocal filePath = MuAiGuideRoot .. \"MuAiGuideGlobal.glua\"\n\tMuAiGuide = FileLoad(filePath)\nend\nself.used = true",
						conditions = 
						{
							
							{
								"56c3797c-57ca-d8f2-8333-b758abeb8ab4",
								true,
							},
							
							{
								"b78ab0cc-9e0f-2286-8d92-db467096ddd7",
								true,
							},
						},
						gVar = "ACR_TensorRequiem3_CD",
						name = "MuAiGuideGlobal",
						uuid = "bf52aa28-58f1-3e62-a8da-e16c2d246c86",
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
						category = "Lua",
						conditionLua = "return MuAiGuideRoot ~= nil",
						name = "MuAiGuideRootNotNil",
						uuid = "56c3797c-57ca-d8f2-8333-b758abeb8ab4",
						version = 2,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuideRoot == nil",
						name = "MuAiGuideRootIsNil",
						uuid = "b311d95f-e301-6fbc-b40b-013549748659",
						version = 2,
					},
					inheritedIndex = 2,
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
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "if MuAiGuide == nil then\n\treturn false\nelseif MuAiGuide.DefaultConfigInit == true then\n\treturn false\nelse \n\treturn true\nend\n\n",
						name = "DefaultConfigNotInit",
						uuid = "9ae30f70-f652-b221-a895-5d2462f334bc",
						version = 2,
					},
				},
			},
			name = "MuAiGuide",
			uuid = "b1ec4a77-b34b-71e5-9b4c-b388d08b8b03",
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
						actionLua = "MuAiGuide.DrawMainUI()\nself.used = true",
						conditions = 
						{
							
							{
								"ec6a59d3-5181-45e9-a1d5-f0809fd79304",
								true,
							},
						},
						gVar = "ACR_RikuWHM3_CD",
						name = "DrawMainUI",
						uuid = "24e9b704-79ee-959e-b704-1882e46ecaeb",
						version = 2.1,
					},
					inheritedIndex = 2,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide.DrawFriConfigUI()\nself.used = true",
						conditions = 
						{
							
							{
								"fbb3ae05-9eee-8e39-bde7-611e12205b06",
								true,
							},
						},
						gVar = "ACR_RikuWHM3_CD",
						name = "DrawFruConfig",
						uuid = "ef3917b1-00b3-772e-8302-b4f58fbce07e",
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
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide~= nil \n\t   and MuAiGuide.FruConfigUI~= nil \n\t   and MuAiGuide.FruConfigUI.open == true",
						name = "伊甸设置UI打开",
						uuid = "fbb3ae05-9eee-8e39-bde7-611e12205b06",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide~= nil \n\t   and MuAiGuide.UI~= nil \n\t   and MuAiGuide.UI.open == true",
						name = "Main设置UI打开",
						uuid = "ec6a59d3-5181-45e9-a1d5-f0809fd79304",
						version = 2,
					},
				},
			},
			eventType = 13,
			name = "MuAiGuideUI",
			uuid = "198825bb-513f-1eb9-b0c3-20b8a87426f5",
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
					inheritedIndex = 1,
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
					inheritedIndex = 1,
				},
			},
			enabled = false,
			eventType = 4,
			name = "AloaloAddMarker",
			uuid = "6e30e67e-07d4-96d5-924f-b0a285fdf586",
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
						actionLua = "if not MuAiGuide.UIPop then\n    MuAiGuide.UIPop = false\nend\n\nif MuAiGuide and not MuAiGuide.UIPop and MuAiGuide.UI.open == false then\n    local party = MuAiGuide.GetPartyPlayers()\n    if party and table.size(party) >= 8 then\n        if MuAiGuide.Party == nil or table.size(MuAiGuide.Party) < 8 then\n            MuAiGuide.LoadParty()\n\t\t\tMuAiGuide.Debug(\"已读取小队列表\")\n\t\t\tMuAiGuide.UI.open = true\n\t\t\tMuAiGuide.UIPop = true\n        end      \n\t\tself.used = true\n    end\nend\n",
						conditions = 
						{
							
							{
								"0c9fdff7-6d79-4928-bdfd-3254b0be907f",
								true,
							},
							
							{
								"bbdcb575-7958-ce37-993f-cf0b7da9a535",
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
						category = "Lua",
						conditionLua = "return MuAiGuide ~= nil",
						name = "MuAiGuideIsInit",
						uuid = "0c9fdff7-6d79-4928-bdfd-3254b0be907f",
						version = 2,
					},
				},
				
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
						uuid = "bbdcb575-7958-ce37-993f-cf0b7da9a535",
						version = 2,
					},
					inheritedIndex = 1,
				},
			},
			eventType = 11,
			name = "MuaiOnMapChange",
			throttleTime = 1000,
			timeout = 10,
			uuid = "73b0ee98-d569-da5c-898f-d4d0c836b6e6",
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
	inheritedProfiles = 
	{
	},
}



return tbl