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
			name = "---- MuAiGuide ----",
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
						actionLua = "if MuAiGuide and MuAiGuide.FruConfigUI.open then\n    local M = MuAiGuide\n    -- 全局变量读取\n    if not M.ConfigInit then\n        M.ConfigInit = true\n        --------- P1 雾龙 --------- \n        M.FruConfigUI.P1InputStr1 = M.StringJoin(M.Config.FruCfg.FruUtopainSkyPosInfo, \",\")\n        M.FruConfigUI.Input1Changed = false\n        --------- P1 雷火线 --------- \n        M.FruConfigUI.P1InputStr2 = M.StringJoin(M.Config.FruCfg.FruLightFirePriority, \",\")\n        M.FruConfigUI.Input2Changed = false\n        --------- P2 光暴打法--------- \n        if M.Config.FruCfg.FruLightRampantType == 1 then\n            M.FruConfigUI.LightRampantMGL = true\n            M.FruConfigUI.LightRampantG9 = false\n        else\n            M.FruConfigUI.LightRampantMGL = false\n            M.FruConfigUI.LightRampantG9 = true\n        end\n\n        --------- P3 地火 ---------\n        if M.Config.FruCfg.ApocalypseType == 1 then\n            M.FruConfigUI.ApocalypseTypeLeader = true\n            M.FruConfigUI.ApocalypseTypeParty = false\n        else\n            M.FruConfigUI.ApocalypseTypeLeader = false\n            M.FruConfigUI.ApocalypseTypeParty = true\n        end\n    end\n\n    GUI:SetNextWindowSize(200, 0, GUI.SetCond_Appearing)\n    GUI:SetNextWindowPos(M.FruConfigUI.x, M.FruConfigUI.y, GUI.SetCond_Appearing)\n    M.FruConfigUI.visible, M.FruConfigUI.open = GUI:Begin(\"绝伊甸相关配置\", M.FruConfigUI.open)\n    if M.FruConfigUI.visible then\n        GUI:SetNextWindowPos(M.FruConfigUI.x, M.FruConfigUI.y, GUI.SetCond_Appearing)\n        --------------------------------------------------------------------------------\n        GUI:Dummy(1, 3)\n        GUI:TextColored(255, 0, 0, 1, \"注意：\")\n        GUI:Text(\"8方站位均为\")\n        GUI:SameLine()\n        GUI:TextColored(255, 0, 0, 1, \"C开始逆时针\")\n        GUI:SameLine()\n        GUI:Text(\"顺序\")\n        GUI:TextColored(0, 255, 0, 1, \"优先级从高到低！\")\n        GUI:Text(\"调整站位和优先级一定要\")\n        GUI:SameLine()\n        GUI:TextColored(255, 0, 0, 1, \"全大写\")\n        GUI:Text(\"并使用\")\n        GUI:SameLine()\n        GUI:TextColored(255, 0, 0, 1, \"英文逗号“,”\")\n        GUI:SameLine()\n        GUI:Text(\"分隔，否则将设置失败！\")\n        --------------------------------------------------------------------------------\n        GUI:Separator()\n        GUI:Dummy(1, 4)\n        GUI:BulletText(\"P1；绝命战士\")\n        GUI:Dummy(1, 2)\n        GUI:Text(\"雾龙8方位：\")\n        M.FruConfigUI.P1InputStr1, M.FruConfigUI.Input1Changed = GUI:InputText(\"#1\", M.FruConfigUI.P1InputStr1, GUI.InputTextFlags_CharsNoBlank)\n        if M.FruConfigUI.Input1Changed then\n            M.Config.FruCfg.FruUtopainSkyPosInfo = M.StringSplit(M.FruConfigUI.P1InputStr1, \",\")\n        end\n        \n        GUI:Dummy(1, 2)\n        GUI:Text(\"雷火线优先级：\")\n        M.FruConfigUI.P1InputStr2, M.FruConfigUI.Input2Changed = GUI:InputText(\"#2\", M.FruConfigUI.P1InputStr2, GUI.InputTextFlags_CharsNoBlank)\n        if M.FruConfigUI.Input2Changed then\n            M.Config.FruCfg.FruLightFirePriority = M.StringSplit(M.FruConfigUI.P1InputStr2, \",\")\n        end\n        GUI:Dummy(1, 2)\n        --------------------------------------------------------------------------------\n        GUI:Separator()\n        GUI:Dummy(1, 2)\n        GUI:BulletText(\"P2：希瓦·米特隆\")\n        GUI:Dummy(1, 2)\n        GUI:Text(\"光暴打法：\")\n\n        M.FruConfigUI.LightRampantMGL = GUI:Checkbox(\"田园郡(MGL)\", M.FruConfigUI.LightRampantMGL)\n        if M.FruConfigUI.LightRampantMGL then\n            M.FruConfigUI.LightRampantG9 = false\n        else\n            M.FruConfigUI.LightRampantG9 = true\n        end\n        GUI:SameLine()\n        M.FruConfigUI.LightRampantG9 = GUI:Checkbox(\"新灰9\", M.FruConfigUI.LightRampantG9)\n        if M.FruConfigUI.LightRampantG9 then\n            M.FruConfigUI.LightRampantMGL = false\n        else\n            M.FruConfigUI.LightRampantMGL = true\n        end\n\n        GUI:Dummy(1, 2)\n        GUI:Separator()\n        ------------------------------------------------------------------------------------\n        GUI:BulletText(\"P3：暗之巫女\")\n        GUI:Text(\"地火打法：\")\n        M.FruConfigUI.ApocalypseTypeLeader = GUI:Checkbox(\"车头法\", M.FruConfigUI.ApocalypseTypeLeader)\n        if M.FruConfigUI.ApocalypseTypeLeader then\n            M.FruConfigUI.ApocalypseTypeParty = false\n            M.Config.FruCfg.ApocalypseType = 1\n        else\n            M.FruConfigUI.LightRampantG9 = true\n            M.Config.FruCfg.ApocalypseType = 2\n        end\n        GUI:SameLine()\n        M.FruConfigUI.ApocalypseTypeParty = GUI:Checkbox(\"人群法\", M.FruConfigUI.ApocalypseTypeParty)\n        if M.FruConfigUI.ApocalypseTypeParty then\n            M.FruConfigUI.ApocalypseTypeLeader = false\n            M.Config.FruCfg.ApocalypseType = 2\n        else\n            M.FruConfigUI.ApocalypseTypeParty = true\n            M.Config.FruCfg.ApocalypseType = 1\n        end\n\n        GUI:Separator()\n        GUI:BulletText(\"P4：光之巫女&暗之巫女\")\n\n        GUI:Separator()\n\n        GUI:Button(\"保存并关闭\")\n        if GUI:IsItemClicked(0) then\n            d(\"保存伊甸设置\")\n            M.FruConfigUI.open = false\n        end\n        GUI:Button(\"测试按钮\")\n    end\n    MuAiGuide.SaveConfig()\n    GUI:SetWindowSize(300, 0)\n    GUI:End()\nend\nself.used = true\n",
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
						actionLua = "if MuAiGuide and MuAiGuide.UI.open then\n    local M = MuAiGuide\n    if M.ConfigUI == nil then\n        M.ConfigUI = {}\n        M.ConfigUI.GuideColor = M.Config.GuideColor\n        M.ConfigUI.GuideColorChange = false\n    end\n    GUI:SetNextWindowSize(200, 0, GUI.SetCond_Appearing)\n    M.UI.visible, M.UI.open = GUI:Begin(\"指路绘制设置\", M.UI.open)\n    GUI:Dummy(1, 1)\n    GUI:Separator()\n    GUI:BulletText(\"基础设置\")\n    GUI:Text(\" \")\n    GUI:SameLine()\n    M.ConfigUI.GuideColor.r, M.ConfigUI.GuideColor.g, M.ConfigUI.GuideColor.b, M.ConfigUI.GuideColor.a, M.ConfigUI.GuideColorChange = GUI:ColorEdit4(\n            \"指路工具颜色\",\n            M.Config.GuideColor.r,\n            M.Config.GuideColor.g,\n            M.Config.GuideColor.b,\n            M.Config.GuideColor.a,\n            GUI.ColorEditMode_NoInputs)\n    if M.ConfigUI.GuideColorChange then\n        M.SaveConfig()\n    end\n    GUI:Dummy(1, 1)\n    GUI:Separator()\n    GUI:BulletText(\"职能设置\")\n    GUI:SameLine()\n    GUI:TextColored(0, 255, 0, 1, \"[拖动角色名进行职能修改]\")\n    GUI:Text(\"   玩家当前职能\")\n    GUI:SameLine()\n    GUI:TextColored(255, 0, 0, 1, \"[\" .. M.SelfPos .. \"]\")\n    GUI:Separator()\n    GUI:Text(\"    <职能>    <职业>     <角色名>\")\n    if M.UI.visible then\n        if M.Party == nil or table.size(M.Party) == 0 then\n            M.Party = {}\n            M.Party.MT = nil\n            M.Party.ST = nil\n            M.Party.H1 = nil\n            M.Party.H2 = nil\n            M.Party.D1 = nil\n            M.Party.D2 = nil\n            M.Party.D3 = nil\n            M.Party.D4 = nil\n        end\n        GUI:Text(\" \")\n        GUI:SameLine()\n        GUI:PushItemWidth(303)\n        GUI:ListBoxHeader(\"##Jobs\", 304, 200)\n\n        local partyMembers = {\n            { info = M.Party.MT, label = \"MT\" },\n            { info = M.Party.ST, label = \"ST\" },\n            { info = M.Party.H1, label = \"H1\" },\n            { info = M.Party.H2, label = \"H2\" },\n            { info = M.Party.D1, label = \"D1\" },\n            { info = M.Party.D2, label = \"D2\" },\n            { info = M.Party.D3, label = \"D3\" },\n            { info = M.Party.D4, label = \"D4\" }\n        }\n        for i, member in ipairs(partyMembers) do\n            local IsSelected = function()\n                if member.label == M.Party.selected then\n                    return true\n                end\n                return false\n            end\n            local ptMember = partyMembers[i]\n            if i == 1 or i == 2 then\n                GUI:ColorButton(\"#jobPos\", 0, 0, 255, 255, GUI.ColorEditMode_NoTooltip, 20, 20)\n            elseif i == 3 or i == 4 then\n                GUI:ColorButton(\"#jobPos\", 0, 255, 0, 255, GUI.ColorEditMode_NoTooltip, 20, 20)\n            else\n                GUI:ColorButton(\"#jobPos\", 255, 0, 0, 255, GUI.ColorEditMode_NoTooltip, 20, 20)\n            end\n            GUI:SameLine()\n            if i == 1 or i == 2 then\n                GUI:TextColored(0, 100, 255, 1, \"[\" .. ptMember.label .. \"]\")\n            elseif i == 3 or i == 4 then\n                GUI:TextColored(0, 255, 0, 1, \"[\" .. ptMember.label .. \"]\")\n            else\n                GUI:TextColored(255, 0, 0, 1, \"[\" .. ptMember.label .. \"]\")\n            end\n            GUI:SameLine()\n            if ptMember.info ~= nil and ptMember.info.job ~= nil and ptMember.info.name ~= nil then\n                GUI:Selectable(\n                        \"   \" .. M.GetJobNameById(ptMember.info.job) .. \"      \" .. ptMember.info.name,\n                        IsSelected()\n                )\n            else\n                GUI:Selectable(\"   \" .. \"未知\" .. \"      \" .. \"未知玩家\" .. i, IsSelected())\n            end\n            if\n            GUI:IsItemHovered(\n                    GUI.HoveredFlags_AllowWhenBlockedByPopup + GUI.HoveredFlags_AllowWhenBlockedByActiveItem +\n                            GUI.HoveredFlags_AllowWhenOverlapped\n            )\n            then\n                if GUI:IsMouseDown(0) then\n                    if M.Party.mousePosition == nil then\n                        if M.Party.mousePosition ~= ptMember.label then\n                            M.Party.mousePosition = ptMember.label\n                        end\n                        if M.Party.selected ~= ptMember.label then\n                            M.Party.selected = ptMember.label\n                        end\n                    elseif M.Party.mousePosition ~= ptMember.label then\n                        d(\"[M]站位交换：\" .. M.Party.mousePosition .. \"<==>\" .. ptMember.label)\n                        local temp = M.Party[M.Party.mousePosition]\n                        M.Party[M.Party.mousePosition] = M.Party[ptMember.label]\n                        M.Party[ptMember.label] = temp\n\n                        -- 职能调整\n                        if M.Party[M.Party.mousePosition].id == M.GetPlayer().id then\n                            M.SelfPos = M.Party.mousePosition;\n                        elseif M.Party[ptMember.label].id == M.GetPlayer().id then\n                            M.SelfPos = ptMember.label;\n                        end\n\n                        M.Party.mousePosition = ptMember.label\n                        if M.Party.selected ~= ptMember.label then\n                            M.Party.selected = ptMember.label\n                        end\n                    end\n                end\n            end\n\n            if M.Party.mousePosition ~= nil and (GUI:IsMouseReleased(0) or not GUI:IsMouseDown(0)) then\n                M.Party.mousePosition = nil\n            end\n            if M.Party.selected ~= nil and (GUI:IsMouseReleased(0) or not GUI:IsMouseDown(0)) then\n                M.Party.selected = nil\n            end\n        end\n        GUI:ListBoxFooter()\n        if\n        M.Party.mousePosition ~= nil and\n                not GUI:IsItemHovered(\n                        GUI.HoveredFlags_AllowWhenBlockedByPopup + GUI.HoveredFlags_AllowWhenBlockedByActiveItem +\n                                GUI.HoveredFlags_AllowWhenOverlapped\n                )\n        then\n            M.Party.mousePosition = nil\n        end\n        GUI:Dummy(1, 1)\n    \tGUI:Text(\" \")\n    \tGUI:SameLine()\n        GUI:Button(\"绝伊甸设置\")\n        if GUI:IsItemClicked(0) then\n            M.ConfigFruInit = false\n            M.FruConfigUI.open = not M.FruConfigUI.open\n        end\n\n        GUI:Dummy(1, 3)\n        local winPosx, winPosy = GUI:GetWindowPos();\n        M.FruConfigUI.x = winPosx + 300\n        M.FruConfigUI.y = winPosy\n    end\n    GUI:Separator()\n    GUI:Button(\"重新加载小队列表\")\n    if GUI:IsItemClicked(0) then\n        M.LoadParty()\n    end\n    GUI:SetWindowSize(350, 0)\n    GUI:End()\nend\nself.used = true\n",
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
						actionLua = "MuAiGuide = {}\nlocal M = MuAiGuide\nlocal TankJobs = { 19, 21, 32, 37 }\nlocal HealerJobs = { 24, 28, 33, 40 }\nlocal MeleeJob = { 20, 22, 30, 34, 39, 41 }\nlocal RangeJob = { 31, 23, 38 }\nlocal MagicJob = { 25, 27, 35, 42 }\nlocal JobIds = {\n    19, 21, 32, 37,\n    24, 33, 40, 28,\n    20, 22, 30, 34, 39, 41,\n    31, 23, 38,\n    25, 27, 35, 42\n}\n\nlocal JobName = {\n    \"骑士\", \"战士\", \"黑骑\", \"枪刃\",\n    \"白魔\", \"占星\", \"贤者\", \"学者\",\n    \"武僧\", \"龙骑\", \"忍者\", \"武士\", \"镰刀\", \"蝰蛇\",\n    \"机工\", \"诗人\", \"舞者\",\n    \"黑魔\", \"召唤\", \"赤魔\", \"绘灵\"\n}\n\nM.JobPosName = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\n--- UI定义\nM.UI = {}\nM.FruConfigUI = {}\n\nM.IsTank = function(job)\n    return table.contains(TankJobs, job)\nend\n\nM.IsHealer = function(job)\n    return table.contains(HealerJobs, job)\nend\n\nM.IsMelee = function(job)\n    return table.contains(MeleeJob, job)\nend\n\nM.IsRange = function(job)\n    return table.contains(RangeJob, job)\nend\n\nM.IsMagic = function(job)\n    return table.contains(MagicJob, job)\nend\n\nM.IsDps = function(job)\n    return table.contains(MeleeJob, job)\n            or table.contains(RangeJob, job)\n            or table.contains(MagicJob, job)\nend\n\nM.IsPlayer = function(entity)\n    if not entity\n            or not entity.job\n            or entity.type ~= 1\n            or not table.contains(JobIds, entity.job)\n    then\n        return false\n    end\n\n    return true\nend\n\n--- 获取职业名称\n--- @param job number 职业ID\nM.GetJobNameById = function(job)\n    for i = 1, #JobIds, 1 do\n        if JobIds[i] == job then\n            return JobName[i]\n        end\n    end\nend\n\n--- 读取小队列表\nM.GetPartyPlayers = function()\n    local curPt = TensorCore.getEntityGroupList(\"Party\")\n    local members = {}\n    local checker = {}\n    -- 回放模式或者其他情况\n    if #curPt == 1 then\n        table.insert(members, curPt[1])\n        table.insert(checker, curPt[1].id)\n        curPt = TensorCore.entityList(\"Party\")\n        d(\"当前小队列表一人\")\n    end\n    for _, ent in pairs(curPt) do\n        if M.IsPlayer(ent) and not table.contains(checker, ent.id) then\n            table.insert(members, ent)\n        end\n    end\n    return members\nend\n\n--- 读取设置信息\nM.LoadConfig = function()\n    local path = GetLuaModsPath()\n    local savePath = path .. \"\\\\MuAiGuide\"\n    local saveFile = savePath .. \"\\\\MuAiGuideConfig.lua\"\n\n    if (not FolderExists(savePath)) then\n        FolderCreate(savePath)\n    end\n    local config = FileLoad(saveFile)\n    if config ~= nil then\n        return config\n    end\n    return M.CreateDefaultCfg();\nend\n\n--- 创建默认配置\nM.CreateDefaultCfg = function()\n    return {\n        -- 是否开启测试模式\n        DebugMode = false,\n        -- 测试模式玩家职能\n        DebugPos = \"D3\",\n        -- 绝伊甸\n        FruCfg = M.CreateFruDefaultCfg(),\n        -- 指路工具颜色\n        GuideColor = { r = 0, g = 1, b = 0, a = 0.5 }\n    }\nend\n\nM.CreateFruDefaultCfg = function()\n    return {\n        --- 雾龙8方站位 C逆\n        FruUtopainSkyPosInfo = { \"H2\", \"D2\", \"D4\", \"ST\", \"MT\", \"D3\", \"H1\", \"D1\" },\n\n        --- 雷火线优先级\n        FruLightFirePriority = { \"H1\", \"H2\", \"MT\", \"ST\", \"D1\", \"D2\", \"D3\", \"D4\" },\n\n        --- 光暴类型 1：田园式 2：灰9式\n        FruLightRampantType = 1,\n\n        --- P3地火解法 1：车头法 2：人群法\n        ApocalypseType = 1,\n\n        -- 固定吃, 顺序\n        CrystallizeTimeFix = {\n            [2461] = \"D\", -- 水\n            [2462] = \"B\", -- 冰\n            [2454] = \"3\", -- 贪\n            [2460] = \"4\"   -- 暗\n        }\n    }\nend\n\nM.SaveConfig = function()\n    if not table.deepcompare(M.Config, M.PreviousSave) then\n        local path = GetLuaModsPath()\n        local savePath = path .. \"\\\\MuAiGuide\"\n        local saveFile = savePath .. \"\\\\MuAiGuideConfig.lua\"\n        if (not FolderExists(savePath)) then\n            FolderCreate(savePath)\n        end\n        FileSave(saveFile, M.Config)\n        d(\"[MuAiGuide]已更新存档\")\n        M.PreviousSave = table.deepcopy(M.Config)\n    end\nend\n\nM.Config = M.LoadConfig()\nM.PreviousSave = M.LoadConfig()\n\n--- 读取小队信息（初始化模块）\nM.LoadParty = function()\n    M.Party = {}\n    local members = M.GetPartyPlayers()\n    local memberHasSet = {}\n    for i = 1, 8, 1 do\n        if M.IsTank(members[i].job) then\n            if M.Party.MT == nil then\n                M.Party.MT = members[i]\n                table.insert(memberHasSet, members[i])\n            else\n                M.Party.ST = members[i]\n                table.insert(memberHasSet, members[i])\n            end\n        elseif M.IsHealer(members[i].job) then\n            if M.Party.H1 == nil then\n                M.Party.H1 = members[i]\n                table.insert(memberHasSet, members[i])\n            else\n                M.Party.H2 = members[i]\n                table.insert(memberHasSet, members[i])\n            end\n        elseif M.IsMelee(members[i].job) then\n            if M.Party.D1 == nil then\n                M.Party.D1 = members[i]\n                table.insert(memberHasSet, members[i])\n            else\n                M.Party.D2 = members[i]\n                table.insert(memberHasSet, members[i])\n            end\n        elseif M.IsRange(members[i].job) then\n            if M.Party.D3 == nil then\n                M.Party.D3 = members[i]\n                table.insert(memberHasSet, members[i])\n            end\n        elseif M.IsMagic(members[i].job) then\n            if M.Party.D4 == nil then\n                M.Party.D4 = members[i]\n                table.insert(memberHasSet, members[i])\n            end\n        end\n    end\n\n    if #memberHasSet < 8 then\n        for i = 1, #members, 1 do\n            if not table.contains(memberHasSet, members[i]) then\n                if M.Party.MT == nil then\n                    M.Party.MT = members[i]\n                    table.insert(memberHasSet, members[i])\n                elseif M.Party.ST == nil then\n                    M.Party.ST = members[i]\n                    table.insert(memberHasSet, members[i])\n                elseif M.Party.H1 == nil then\n                    M.Party.H1 = members[i]\n                    table.insert(memberHasSet, members[i])\n                elseif M.Party.H2 == nil then\n                    M.Party.H2 = members[i]\n                    table.insert(memberHasSet, members[i])\n                elseif M.Party.D1 == nil then\n                    M.Party.D1 = members[i]\n                    table.insert(memberHasSet, members[i])\n                elseif M.Party.D2 == nil then\n                    M.Party.D2 = members[i]\n                    table.insert(memberHasSet, members[i])\n                elseif M.Party.D3 == nil then\n                    M.Party.D3 = members[i]\n                    table.insert(memberHasSet, members[i])\n                elseif M.Party.D4 == nil then\n                    M.Party.D4 = members[i]\n                    table.insert(memberHasSet, members[i])\n                end\n            end\n        end\n    end\n\n    M.GetSelfPos()\nend\n\n--- 计算自己当前的职能\nM.GetSelfPos = function()\n    -- 设置自己的职能\n    if not M.Party then\n        return\n    end\n    for jobPos, ent in pairs(M.Party) do\n        if ent.id == M.GetPlayer().id then\n            M.SelfPos = jobPos\n            break\n        end\n    end\nend\n\n--- 获取当前玩家表\n--- @return table | nil player\nM.GetPlayer = function()\n    if not M.Config.DebugMode then\n        return TensorCore.mGetPlayer()\n    end\n    if M.Party == nil then\n        return nil\n    end\n    return M[M.Config.DebugPos]\nend\n\n--- 通过ID来获取其他玩家\n--- @return table | nil player\nM.GetOtherPlayer = function(id)\n    for _, member in pairs(M.Party) do\n        if member.id == id then\n            return member\n        end\n    end\n    return nil\nend\n\n--- 计算索引位置\n--- @param orderTable table 基于哪个优先级序列的表\n--- @param value any 元素成员\n--- @return number index 索引\nM.IndexOf = function(orderTable, value)\n    for i = 1, #orderTable, 1 do\n        if value == orderTable[i] then\n            return i\n        end\n    end\n    return 0\nend\n\n--- 字符串分割\n--- @param str string 待分割的字符串\n--- @return table list 分割后的列表\nM.StringSplit = function(str, mark)\n    local t = {}\n    local pattern = \"([^\" .. mark .. \"]+)\"\n    for match in string.gmatch(str, pattern) do\n        table.insert(t, match)\n    end\n    return t\nend\n\n--- 列表进行拼接\n--- @param str string 待分割的字符串\n--- @return table result 拼合后的字符串\nM.StringJoin = function(tbl, mark)\n    local result = \"\"\n    for i, v in ipairs(tbl) do\n        if i > 1 then\n            result = result .. mark\n        end\n        result = result .. v\n    end\n    return result\nend\n\n--- 判断当前物体是否是自己\n--- @param entity table 查找到的entity\n--- @return boolean result 是否是自己\nM.IsMe = function(entity)\n    if not entity then\n        return false\n    end\n    return M.GetPlayer().id == entity.id\nend\n\n--- 判断当前物体是否是自己\n--- @param curJosPos string 当前职能\n--- @return boolean result 是否是自己\nM.IsMeByPos = function(curJosPos)\n    if not table.contains(M.JobPosName, curJosPos) or not M.Party then\n        return false\n    end\n    local curPlayer = M.Party[curJosPos]\n    if not curPlayer then\n        return false\n    end\n    return M.GetPlayer().id == curPlayer.id\nend\n\n--- 计算目标点在中心点的相对方位 6点钟（C）逆时针 1~8\n--- @param center table 中心点的坐标 {x=number, z=number}\n--- @param target table 物品点的坐标 {x=number, z=number}\n--- @return number 方位 ID（1~8）\nM.GetDirectionIndex = function(center, target)\n    local heading = TensorCore.getHeadingToTarget(center, target);\n    local min = 100000000\n    local index = 0\n    -- 请求弧度最接近的值\n    for i = 1, 8 do\n        local curRad = (i - 1) / 4 * math.pi\n        local abs = math.abs(heading - curRad)\n        if abs < min then\n            min = abs\n            index = i\n        end\n    end\n    return index\nend\n\n--- 从 startPos点出发，沿着 startPos => endPos 方向，获取距离为 distance 的点坐标\n--- @param startPos table 起点坐标\n--- @param endPos table 终点坐标\n--- @param distance number 距离，正值为朝向终点方向，负值为反向\n--- @return table targetPos 返回目标点的坐标，包含 x 和 z 分量\nM.GetPointAtDistance = function(startPos, endPos, distance)\n    local heading = TensorCore.getHeadingToTarget(startPos, endPos)\n    return TensorCore.getPosInDirection(startPos, heading, distance)\nend\n\n--- 计算2个弧度之间的夹角（0~π）\nM.GetAngleRadian = function(r1, r2)\n    local diff = math.abs(r2 - r1)\n    if diff > math.pi then\n        diff = 2 * math.pi - diff\n    end\n    return diff\nend\n\n--- 判断2个数是否相等\n--- @return boolean is same\nM.IsSame = function(n1, n2)\n    if n1 == nil or n2 == nil then\n        return n1 == nil and n2 == nil\n    end\n    local diff = math.abs(n1 - n2)\n    if diff < 0.0001 then\n        return true\n    end\n    return false\nend\n\n--- 安全弧度变换\n--- @param value number 基础值\n--- @param delta number 变化值\n--- @param min number 下边界\n--- @param max number 上边界\n--- @param normalize number 越界补充值\n--- @return number 计算的结果\nM.SafeHeadingChange = function(value, delta, min, max, normalize)\n    local endValue = value + delta\n    if endValue > max then\n        endValue = endValue - normalize\n    elseif endValue < min then\n        endValue = endValue + normalize\n    end\n    return endValue\nend\n\n------------------------------- 全局绘制 -------------------------------\nMuAiGuide.NotDelayGuides = {}\n--- 绘制一个指路工具\n--- @param x number 当前x坐标\n--- @param z number 当前z坐标\n--- @param time number 指路时间（毫秒）\n--- @param size? number 圈大小（默认0.5）\n--- @param delay? number 延迟执行（毫秒）\nM.DirectTo = function(x, z, time, size, delay)\n    local color = M.Config.GuideColor\n    size = size or 0.5\n    delay = delay or 0\n    if table.size(MuAiGuide.NotDelayGuides) > 0 and delay < 1 then\n        for i, uuid in pairs(MuAiGuide.NotDelayGuides) do\n            Argus.deleteTimedShape(uuid)\n        end\n        MuAiGuide.NotDelayGuides = {}\n    end\n    local newDraw = Argus2.ShapeDrawer:new(\n            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),\n            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),\n            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1)),\n            2\n    )\n    local guide1 = newDraw:addTimedCircle(time, x, M.GetPlayer().pos.y, z, size, delay, true)\n    local guide2 = Argus2.addTimedRectFilled(\n            time,\n            x,\n            M.GetPlayer().pos.y,\n            z,\n            0.3,\n            0.05,\n            math.pi,\n            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),\n            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),\n            nil,\n            delay,\n            nil,\n            M.GetPlayer().id,\n            false,\n            nil,\n            0.01,\n            nil,\n            nil,\n            true\n    )\n\n    local newDraw2 = Argus2.ShapeDrawer:new(\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),\n            nil,\n            1\n    )\n\n    local guide3 = newDraw2:addTimedCircle(time, x, M.GetPlayer().pos.y, z, 0.03, delay, true)\n    if delay < 1 then\n        table.insert(MuAiGuide.NotDelayGuides, guide1)\n        table.insert(MuAiGuide.NotDelayGuides, guide2)\n        table.insert(MuAiGuide.NotDelayGuides, guide3)\n    end\nend\n--- 取消已注册的所有指路\nM.CancelDir = function()\n    if table.size(MuAiGuide.NotDelayGuides) > 0 then\n        for i, uuid in pairs(MuAiGuide.NotDelayGuides) do\n            Argus.deleteTimedShape(uuid)\n        end\n        MuAiGuide.NotDelayGuides = {}\n    end\nend\n--- 绘制一个连到其他玩家的连线（矩形）\nM.LinkToPlayer = function(id, time, size, r, g, b, a)\n    size = size or 0.05\n    r = r or 0\n    g = g or 0\n    b = b or 0\n    a = a or 0.55\n    if r == 0 and g == 0 and b == 0 then\n        b = 255\n    end\n    Argus2.addTimedRectFilled(\n            time,\n            100,\n            M.GetPlayer().pos.y,\n            100,\n            0.3,\n            size,\n            math.pi,\n            (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),\n            (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),\n            nil,\n            0,\n            id,\n            M.GetPlayer().id,\n            false,\n            nil,\n            0.01,\n            nil,\n            nil,\n            true\n    )\nend\n\n--- 绘制一个圆\nM.DrawCircleUI = function(x, z, time, size, r, g, b, a, delay)\n    r = r or 0\n    g = g or 0\n    b = b or 0\n    a = a or 0.35\n    delay = delay or 0\n    size = size or 1\n    if r == 0 and g == 0 and b == 0 then\n        g = 255\n    end\n    local newDraw = Argus2.ShapeDrawer:new(\n            (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),\n            (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),\n            (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1)),\n            1\n    )\n    newDraw:addTimedCircle(time, x, M.GetPlayer().pos.y, z, size, 0, true)\nend\n\n--- 绘制一个地面圆\nM.DrawCircleFloor = function(x, z, time, size, r, g, b, a, delay)\n    r = r or 0\n    g = a or 0\n    b = b or 0\n    a = a or 0.35\n    size = size or 1\n    delay = delay or 0\n    if r == 0 and g == 0 and b == 0 then\n        g = 255\n    end\n    local newDraw = Argus2.ShapeDrawer:new(\n            (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),\n            (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),\n            (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1)),\n            1\n    )\n    newDraw:addTimedCircle(time, x, M.GetPlayer().pos.y, z, size, 0, false)\nend\nd(\"[MuAiGuide] 初始化成功!\")\n-- SendTextCommand(\"/e [MuAiGuide]初始化完毕，欢迎使用暮霭MuAi指路系列时间轴, 作者联系方式QQ2437365584，欢迎BUG反馈！\")\nself.used = true\n",
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
						actionLua = "if not MuAiGuide.UIPop then\n    MuAiGuide.UIPop = false\nend\n\nif MuAiGuide and not MuAiGuide.UIPop then\n    local party = MuAiGuide.GetPartyPlayers()\n    if party and table.size(party) >= 8  then\n        if table.size(MuAiGuide.Party) == 0 then\n            MuAiGuide.LoadParty()\n        end\n        MuAiGuide.UI.open = true\n        MuAiGuide.UIPop = true\n        SendTextCommand(\"/e [MuAiGuide]初始化完毕，欢迎使用暮霭MuAi指路系列时间轴, 作者联系方式QQ2437365584，欢迎BUG反馈！\")\n    end\nend\nself.used = true\n",
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
						actionLua = "MuAiGuide.DirectTo(100, 100, 5000)\nself.used = true",
						gVar = "ACR_TensorRequiem3_CD",
						uuid = "5ed1ba01-11c5-b486-8f72-79d2d18cc8d7",
						version = 2.1,
					},
				},
			},
			conditions = 
			{
			},
			enabled = false,
			name = "123",
			uuid = "019fe6e9-657d-4179-a782-89f6ea2b6961",
			version = 2,
		},
	}, 
	inheritedProfiles = 
	{
	},
}



return tbl