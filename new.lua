

local v0 = game:GetService("Players");
local v1 = game:GetService("RunService");
local v2 = game:GetService("TweenService");
local v3 = game:GetService("UserInputService");
local v4 = v0.LocalPlayer;
local v5 = {particles=true,headCircles=true,selectionBoxes=true,statusLabel=true,playerESP=true,distance=true,crosshair=true,fovCircle=true,crosshairSpin=false,xray=false,snaplines=false,bigHitboxes=false,armorESP=false};
local v6 = {fovCircleSize=(440 - 340),crosshairSize=16,crosshairSpinSpeed=(131 - 81),crosshairColor={r=0,g=(28 + 122),b=(713 - 458)},fovCircleColor={r=(889 - (463 + 171)),g=(91 + 164),b=(982 - 727)},crosshairStyle="Plus"};
local v7 = true;
local v8 = 10 - 7;
local v9 = 3 + 0;
local v10 = 8;
local v11 = {};
local v12 = {};
local v13 = nil;
local v14 = nil;
local v15 = nil;
local v16 = {COMBAT={features={particles=false,headCircles=true,selectionBoxes=true,statusLabel=true,playerESP=true,distance=true,crosshair=true,fovCircle=true,crosshairSpin=false,xray=false,snaplines=true,bigHitboxes=false,armorESP=true},visualSettings={fovCircleSize=(306 - 186),crosshairSize=(708 - (364 + 324)),crosshairSpinSpeed=(137 - 87),crosshairColor={r=255,g=(0 - 0),b=0},fovCircleColor={r=(85 + 170),g=(1066 - 811),b=(408 - 153)},crosshairStyle="Plus"},performanceMode=true},VISUAL={features={particles=true,headCircles=true,selectionBoxes=true,statusLabel=true,playerESP=true,distance=true,crosshair=true,fovCircle=true,crosshairSpin=true,xray=false,snaplines=false,bigHitboxes=false,armorESP=false},visualSettings={fovCircleSize=(455 - 305),crosshairSize=(1292 - (1249 + 19)),crosshairSpinSpeed=(91 + 9),crosshairColor={r=(0 - 0),g=(1341 - (686 + 400)),b=(201 + 54)},fovCircleColor={r=(229 - (73 + 156)),g=(2 + 253),b=(811 - (721 + 90))},crosshairStyle="Star"},performanceMode=false},STEALTH={features={particles=false,headCircles=false,selectionBoxes=false,statusLabel=false,playerESP=true,distance=false,crosshair=true,fovCircle=false,crosshairSpin=false,xray=true,snaplines=false,bigHitboxes=false,armorESP=false},visualSettings={fovCircleSize=80,crosshairSize=(1 + 11),crosshairSpinSpeed=30,crosshairColor={r=(324 - 224),g=100,b=(570 - (224 + 246))},fovCircleColor={r=(81 - 31),g=(92 - 42),b=50},crosshairStyle="Dot"},performanceMode=true},RAINBOW={features={particles=true,headCircles=true,selectionBoxes=true,statusLabel=true,playerESP=true,distance=true,crosshair=true,fovCircle=true,crosshairSpin=true,xray=false,snaplines=true,bigHitboxes=false,armorESP=true},visualSettings={fovCircleSize=(37 + 163),crosshairSize=28,crosshairSpinSpeed=(4 + 146),crosshairColor={r=(188 + 67),g=(0 - 0),b=255},fovCircleColor={r=255,g=(848 - 593),b=(513 - (203 + 310))},crosshairStyle="Target"},performanceMode=false},MINIMAL={features={particles=false,headCircles=false,selectionBoxes=false,statusLabel=false,playerESP=false,distance=false,crosshair=true,fovCircle=false,crosshairSpin=false,xray=false,snaplines=false,bigHitboxes=false,armorESP=false},visualSettings={fovCircleSize=(2043 - (1238 + 755)),crosshairSize=(1 + 7),crosshairSpinSpeed=(1554 - (709 + 825)),crosshairColor={r=255,g=(469 - 214),b=(371 - 116)},fovCircleColor={r=255,g=(1119 - (196 + 668)),b=(1006 - 751)},crosshairStyle="Plus"},performanceMode=true}};
local v17 = {isOpen=false,activeTab="Combat",dragStart=nil,startPos=nil};
if not v4.PlayerGui then
	local v691 = 0 - 0;
	while true do
		if (v691 == (833 - (171 + 662))) then
			v4.CharacterAdded:Wait();
			wait(94 - (4 + 89));
			break;
		end
	end
end
local v18 = Instance.new("ScreenGui");
v18.Name = "ModernHackGUI";
v18.ResetOnSpawn = false;
v18.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
v18.Parent = v4.PlayerGui;
local v25 = {};
local function v26(v277, v278, v279)
	local v280 = 0;
	while true do
		if (v280 == (0 - 0)) then
			local v762 = 0;
			while true do
				if (v762 == (0 + 0)) then
					if (v277 == "Plus") then
						local v1410 = 0 - 0;
						local v1411;
						local v1412;
						while true do
							if (v1410 == (2 + 1)) then
								v1412.BorderSizePixel = 1486 - (35 + 1451);
								v1412.Visible = false;
								v1412.ZIndex = 1;
								v1412.Parent = v18;
								v1410 = 1457 - (28 + 1425);
							end
							if (v1410 == 2) then
								v1412 = Instance.new("Frame");
								v1412.Size = UDim2.new(1993 - (941 + 1052), 1 + 0, 0, v278);
								v1412.Position = UDim2.new(0.5, -(1514.5 - (822 + 692)), 0.41 - 0, -v278 / 2);
								v1412.BackgroundColor3 = v279;
								v1410 = 3;
							end
							if (v1410 == (2 + 2)) then
								return {v1411,v1412};
							end
							if (1 == v1410) then
								v1411.BorderSizePixel = 297 - (45 + 252);
								v1411.Visible = false;
								v1411.ZIndex = 1;
								v1411.Parent = v18;
								v1410 = 2 + 0;
							end
							if (v1410 == 0) then
								v1411 = Instance.new("Frame");
								v1411.Size = UDim2.new(0 + 0, v278, 0 - 0, 434 - (114 + 319));
								v1411.Position = UDim2.new(0.5 - 0, -v278 / (2 - 0), 0.41 + 0, -0.5);
								v1411.BackgroundColor3 = v279;
								v1410 = 1 - 0;
							end
						end
					elseif (v277 == "X-Shape") then
						local v1502 = 0 - 0;
						local v1503;
						local v1504;
						while true do
							if (v1502 == (1965 - (556 + 1407))) then
								v1503.Parent = v18;
								v1504 = Instance.new("Frame");
								v1504.Size = UDim2.new(1206 - (741 + 465), v278 * 1.4, 465 - (170 + 295), 1);
								v1504.Position = UDim2.new(0.5 + 0, -v278 * (0.7 + 0), 0.41 - 0, -(0.5 + 0));
								v1502 = 3;
							end
							if (v1502 == (1 + 0)) then
								v1503.BorderSizePixel = 0 + 0;
								v1503.Visible = false;
								v1503.ZIndex = 1;
								v1503.Rotation = 1275 - (957 + 273);
								v1502 = 1 + 1;
							end
							if (v1502 == (2 + 2)) then
								v1504.Rotation = -45;
								v1504.Parent = v18;
								return {v1503,v1504};
							end
							if (v1502 == (0 - 0)) then
								v1503 = Instance.new("Frame");
								v1503.Size = UDim2.new(0 - 0, v278 * (4.4 - 3), 1780 - (389 + 1391), 1 + 0);
								v1503.Position = UDim2.new(0.5 + 0, -v278 * 0.7, 0.41, -(0.5 - 0));
								v1503.BackgroundColor3 = v279;
								v1502 = 1;
							end
							if (v1502 == (954 - (783 + 168))) then
								v1504.BackgroundColor3 = v279;
								v1504.BorderSizePixel = 0 - 0;
								v1504.Visible = false;
								v1504.ZIndex = 1 + 0;
								v1502 = 4;
							end
						end
					elseif (v277 == "Circle") then
						local v1600 = 0;
						local v1601;
						local v1602;
						local v1603;
						while true do
							if (v1600 == (313 - (309 + 2))) then
								v1602 = Instance.new("UIStroke");
								v1602.Color = v279;
								v1602.Thickness = 2 - 1;
								v1602.Parent = v1601;
								v1600 = 3;
							end
							if ((1213 - (1090 + 122)) == v1600) then
								v1601.BorderSizePixel = 0 + 0;
								v1601.Visible = false;
								v1601.ZIndex = 1;
								v1601.Parent = v18;
								v1600 = 6 - 4;
							end
							if (v1600 == (0 + 0)) then
								v1601 = Instance.new("Frame");
								v1601.Size = UDim2.new(1118 - (628 + 490), v278, 0, v278);
								v1601.Position = UDim2.new(0.5 + 0, -v278 / (4 - 2), 0.41 - 0, -v278 / (776 - (431 + 343)));
								v1601.BackgroundTransparency = 1 - 0;
								v1600 = 2 - 1;
							end
							if (v1600 == 3) then
								v1603 = Instance.new("UICorner");
								v1603.CornerRadius = UDim.new(1 + 0, 0 + 0);
								v1603.Parent = v1601;
								return {v1601};
							end
						end
					elseif (v277 == "Dot") then
						local v1670 = 15 - (6 + 9);
						local v1671;
						local v1672;
						while true do
							if (2 == v1670) then
								v1671.ZIndex = 1 + 0;
								v1671.Parent = v18;
								v1672 = Instance.new("UICorner");
								v1670 = 2 + 1;
							end
							if (v1670 == (169 - (28 + 141))) then
								local v1759 = 0 + 0;
								while true do
									if (v1759 == (0 - 0)) then
										v1671 = Instance.new("Frame");
										v1671.Size = UDim2.new(0 + 0, 1320 - (486 + 831), 0 - 0, 10 - 7);
										v1759 = 1;
									end
									if (v1759 == (1 + 0)) then
										v1671.Position = UDim2.new(0.5, -1.5, 0.41 - 0, -(1264.5 - (668 + 595)));
										v1670 = 1;
										break;
									end
								end
							end
							if (v1670 == (1 + 0)) then
								v1671.BackgroundColor3 = v279;
								v1671.BorderSizePixel = 0 + 0;
								v1671.Visible = false;
								v1670 = 5 - 3;
							end
							if (v1670 == (293 - (23 + 267))) then
								local v1763 = 0;
								while true do
									if (v1763 == 0) then
										v1672.CornerRadius = UDim.new(1945 - (1129 + 815), 387 - (371 + 16));
										v1672.Parent = v1671;
										v1763 = 1;
									end
									if (v1763 == 1) then
										return {v1671};
									end
								end
							end
						end
					elseif (v277 == "Arrow") then
						local v1743 = 0;
						local v1744;
						local v1745;
						local v1746;
						while true do
							if (v1743 == (14 - 6)) then
								v1746.Rotation = -45;
								v1746.Parent = v18;
								return {v1744,v1745,v1746};
							end
							if (v1743 == (2 - 1)) then
								v1744.BackgroundColor3 = v279;
								v1744.BorderSizePixel = 0;
								v1744.Visible = false;
								v1743 = 1778 - (421 + 1355);
							end
							if (v1743 == (9 - 3)) then
								v1746.Size = UDim2.new(0 + 0, v278 * (1083.4 - (286 + 797)), 0 - 0, 2);
								v1746.Position = UDim2.new(0.5 - 0, -v278 * (439.2 - (397 + 42)), 0.41 + 0, -v278 * (800.4 - (24 + 776)));
								v1746.BackgroundColor3 = v279;
								v1743 = 7;
							end
							if (v1743 == 7) then
								v1746.BorderSizePixel = 0 - 0;
								v1746.Visible = false;
								v1746.ZIndex = 786 - (222 + 563);
								v1743 = 8;
							end
							if (v1743 == (11 - 6)) then
								v1745.Rotation = 33 + 12;
								v1745.Parent = v18;
								v1746 = Instance.new("Frame");
								v1743 = 196 - (23 + 167);
							end
							if (v1743 == 4) then
								v1745.BorderSizePixel = 1798 - (690 + 1108);
								v1745.Visible = false;
								v1745.ZIndex = 1 + 0;
								v1743 = 5 + 0;
							end
							if (v1743 == (850 - (40 + 808))) then
								v1744.ZIndex = 1 + 0;
								v1744.Parent = v18;
								v1745 = Instance.new("Frame");
								v1743 = 3;
							end
							if ((11 - 8) == v1743) then
								v1745.Size = UDim2.new(0, v278 * (0.4 + 0), 0 + 0, 2);
								v1745.Position = UDim2.new(0.5 + 0, -v278 * (571.2 - (47 + 524)), 0.41 + 0, -v278 * (0.4 - 0));
								v1745.BackgroundColor3 = v279;
								v1743 = 5 - 1;
							end
							if (v1743 == (0 - 0)) then
								v1744 = Instance.new("Frame");
								v1744.Size = UDim2.new(0, 1728 - (1165 + 561), 0, v278 * (0.8 + 0));
								v1744.Position = UDim2.new(0.5 - 0, -(1 + 0), 479.41 - (341 + 138), -v278 * (0.4 + 0));
								v1743 = 1;
							end
						end
					elseif (v277 == "Target") then
						local v1774 = 0 - 0;
						local v1775;
						local v1776;
						local v1777;
						local v1778;
						local v1779;
						local v1780;
						local v1781;
						local v1782;
						while true do
							local v1813 = 326 - (89 + 237);
							while true do
								if (v1813 == 2) then
									if (4 == v1774) then
										v1778.Visible = false;
										v1778.ZIndex = 3 - 2;
										v1778.Parent = v18;
										v1779 = Instance.new("UIStroke");
										v1779.Color = v279;
										v1774 = 10 - 5;
									end
									if (v1774 == 1) then
										local v1858 = 881 - (581 + 300);
										while true do
											if ((1221 - (855 + 365)) == v1858) then
												v1775.Parent = v18;
												v1776 = Instance.new("UIStroke");
												v1858 = 4 - 2;
											end
											if (v1858 == 0) then
												v1775.Visible = false;
												v1775.ZIndex = 1 + 0;
												v1858 = 1236 - (1030 + 205);
											end
											if (v1858 == 2) then
												v1776.Color = v279;
												v1774 = 2;
												break;
											end
										end
									end
									v1813 = 3;
								end
								if (v1813 == (1 + 0)) then
									if (v1774 == (3 + 0)) then
										v1778 = Instance.new("Frame");
										v1778.Size = UDim2.new(286 - (156 + 130), v278 * 0.6, 0 - 0, v278 * (0.6 - 0));
										v1778.Position = UDim2.new(0.5 - 0, -v278 * 0.3, 0.41 + 0, -v278 * (0.3 + 0));
										v1778.BackgroundTransparency = 1;
										v1778.BorderSizePixel = 69 - (10 + 59);
										v1774 = 2 + 2;
									end
									if (v1774 == (9 - 7)) then
										v1776.Thickness = 1164 - (671 + 492);
										v1776.Parent = v1775;
										v1777 = Instance.new("UICorner");
										v1777.CornerRadius = UDim.new(1 + 0, 1215 - (369 + 846));
										v1777.Parent = v1775;
										v1774 = 1 + 2;
									end
									v1813 = 2 + 0;
								end
								if (v1813 == (1949 - (1036 + 909))) then
									if (v1774 == (5 + 1)) then
										v1781 = Instance.new("Frame");
										v1781.Size = UDim2.new(0 - 0, 205 - (11 + 192), 0 + 0, 177 - (135 + 40));
										v1781.Position = UDim2.new(0.5 - 0, -1, 0.41 + 0, -1);
										v1781.BackgroundColor3 = v279;
										v1781.BorderSizePixel = 0;
										v1774 = 15 - 8;
									end
									break;
								end
								if (v1813 == 0) then
									if (v1774 == (7 - 2)) then
										v1779.Thickness = 177 - (50 + 126);
										v1779.Parent = v1778;
										v1780 = Instance.new("UICorner");
										v1780.CornerRadius = UDim.new(1, 0 - 0);
										v1780.Parent = v1778;
										v1774 = 2 + 4;
									end
									if (v1774 == (1413 - (1233 + 180))) then
										v1775 = Instance.new("Frame");
										v1775.Size = UDim2.new(969 - (522 + 447), v278, 0, v278);
										v1775.Position = UDim2.new(1421.5 - (107 + 1314), -v278 / (1 + 1), 0.41, -v278 / 2);
										v1775.BackgroundTransparency = 2 - 1;
										v1775.BorderSizePixel = 0;
										v1774 = 1 + 0;
									end
									v1813 = 1 - 0;
								end
								if (v1813 == 3) then
									if (v1774 == (27 - 20)) then
										v1781.Visible = false;
										v1781.ZIndex = 1;
										v1781.Parent = v18;
										v1782 = Instance.new("UICorner");
										v1782.CornerRadius = UDim.new(1, 0);
										v1774 = 1918 - (716 + 1194);
									end
									if (v1774 == 8) then
										v1782.Parent = v1781;
										return {v1775,v1778,v1781};
									end
									v1813 = 4;
								end
							end
						end
					elseif (v277 == "Star") then
						local v1831 = 0;
						local v1832;
						local v1833;
						local v1834;
						while true do
							if (v1831 == 0) then
								v1832 = 0;
								v1833 = nil;
								v1831 = 1 + 0;
							end
							if (v1831 == (1 + 0)) then
								v1834 = nil;
								while true do
									if (v1832 == (504 - (74 + 429))) then
										for v1906 = 1 - 0, 2 + 2 do
											local v1907 = 0 - 0;
											local v1908;
											while true do
												if (v1907 == (0 + 0)) then
													local v1920 = 0 - 0;
													while true do
														if (v1920 == (0 - 0)) then
															v1908 = Instance.new("Frame");
															v1908.Size = UDim2.new(0, v278 * 0.7, 0, v1834);
															v1920 = 1;
														end
														if (v1920 == (434 - (279 + 154))) then
															v1907 = 1;
															break;
														end
													end
												end
												if (v1907 == 3) then
													v1908.ZIndex = 779 - (454 + 324);
													v1908.Rotation = (v1906 - 1) * 45;
													v1907 = 4;
												end
												if (v1907 == (2 + 0)) then
													v1908.BorderSizePixel = 17 - (12 + 5);
													v1908.Visible = false;
													v1907 = 2 + 1;
												end
												if (v1907 == (10 - 6)) then
													v1908.Parent = v18;
													table.insert(v1833, v1908);
													break;
												end
												if (v1907 == (1 + 0)) then
													v1908.Position = UDim2.new(1093.5 - (277 + 816), -v278 * 0.35, 0.41 - 0, -v1834 / (1185 - (1058 + 125)));
													v1908.BackgroundColor3 = v279;
													v1907 = 2;
												end
											end
										end
										return v1833;
									end
									if (v1832 == (0 + 0)) then
										v1833 = {};
										v1834 = 977 - (815 + 160);
										v1832 = 4 - 3;
									end
								end
								break;
							end
						end
					elseif (v277 == "Diamond") then
						local v1850 = 0;
						local v1851;
						local v1852;
						local v1853;
						while true do
							if (v1850 == (11 - 6)) then
								v1853.Parent = v1851;
								return {v1851};
							end
							if (v1850 == 0) then
								v1851 = Instance.new("Frame");
								v1851.Size = UDim2.new(0, v278 * 0.8, 0, v278 * (0.8 - 0));
								v1851.Position = UDim2.new(1898.5 - (41 + 1857), -v278 * 0.4, 1893.41 - (1222 + 671), -v278 * 0.4);
								v1850 = 1;
							end
							if (v1850 == (10 - 6)) then
								v1852.Parent = v1851;
								v1853 = Instance.new("UICorner");
								v1853.CornerRadius = UDim.new(0 - 0, 4);
								v1850 = 1187 - (229 + 953);
							end
							if (v1850 == (1777 - (1111 + 663))) then
								v1852 = Instance.new("UIStroke");
								v1852.Color = v279;
								v1852.Thickness = 1580 - (874 + 705);
								v1850 = 4;
							end
							if (v1850 == (1 + 1)) then
								v1851.ZIndex = 1 + 0;
								v1851.Rotation = 93 - 48;
								v1851.Parent = v18;
								v1850 = 1 + 2;
							end
							if (v1850 == (680 - (642 + 37))) then
								local v1896 = 0 + 0;
								while true do
									if (0 == v1896) then
										v1851.BackgroundTransparency = 1;
										v1851.BorderSizePixel = 0 + 0;
										v1896 = 2 - 1;
									end
									if (v1896 == (455 - (233 + 221))) then
										v1851.Visible = false;
										v1850 = 4 - 2;
										break;
									end
								end
							end
						end
					end
					return {};
				end
			end
		end
	end
end
local function v27()
	local v281 = 0 + 0;
	while true do
		if (v281 == 0) then
			for v1123, v1124 in pairs(v25) do
				for v1188, v1189 in pairs(v1124) do
					v1189.Visible = false;
				end
			end
			if v5.crosshair then
				local v1191 = 0;
				local v1192;
				while true do
					if (v1191 == (1541 - (718 + 823))) then
						v1192 = v6.crosshairStyle;
						if v25[v1192] then
							for v1571, v1572 in pairs(v25[v1192]) do
								v1572.Visible = true;
							end
						end
						break;
					end
				end
			end
			break;
		end
	end
end
local function v28()
	local v282 = 0 + 0;
	local v283;
	while true do
		if (v282 == (805 - (266 + 539))) then
			v283 = Color3.fromRGB(v6.crosshairColor.r, v6.crosshairColor.g, v6.crosshairColor.b);
			for v1125, v1126 in pairs(v25) do
				for v1193, v1194 in pairs(v1126) do
					if v1194:FindFirstChild("UIStroke") then
						v1194.UIStroke.Color = v283;
					else
						v1194.BackgroundColor3 = v283;
					end
				end
			end
			break;
		end
	end
end
local function v29()
	local v284 = v6.crosshairSize;
	for v692, v693 in pairs(v25) do
		if ((v692 == "Plus") and (#v693 >= (5 - 3))) then
			v693[1226 - (636 + 589)].Size = UDim2.new(0 - 0, v284, 0, 1 - 0);
			v693[1 + 0].Position = UDim2.new(0.5 + 0, -v284 / (1017 - (657 + 358)), 0.41, -(0.5 - 0));
			v693[4 - 2].Size = UDim2.new(0, 1, 1187 - (1151 + 36), v284);
			v693[2].Position = UDim2.new(0.5, -0.5, 0.41 + 0, -v284 / (1 + 1));
		elseif ((v692 == "X-Shape") and (#v693 >= 2)) then
			local v1195 = 0 - 0;
			while true do
				if ((1833 - (1552 + 280)) == v1195) then
					v693[2].Size = UDim2.new(0, v284 * (835.4 - (64 + 770)), 0, 1 + 0);
					v693[4 - 2].Position = UDim2.new(0.5 + 0, -v284 * 0.7, 1243.41 - (157 + 1086), -(0.5 - 0));
					break;
				end
				if (v1195 == (0 - 0)) then
					v693[1].Size = UDim2.new(0 - 0, v284 * (1.4 - 0), 0, 820 - (599 + 220));
					v693[1 - 0].Position = UDim2.new(1931.5 - (1813 + 118), -v284 * (0.7 + 0), 0.41, -0.5);
					v1195 = 1218 - (841 + 376);
				end
			end
		elseif ((v692 == "Circle") and (#v693 >= (1 - 0))) then
			local v1354 = 0 + 0;
			while true do
				if (v1354 == (0 - 0)) then
					v693[860 - (464 + 395)].Size = UDim2.new(0, v284, 0 - 0, v284);
					v693[1].Position = UDim2.new(0.5 + 0, -v284 / (839 - (467 + 370)), 0.41, -v284 / (3 - 1));
					break;
				end
			end
		elseif ((v692 == "Dot") and (#v693 >= (1 + 0))) then
			v693[3 - 2].Position = UDim2.new(0.5 + 0, -1.5, 0.41, -(2.5 - 1));
		elseif ((v692 == "Arrow") and (#v693 >= (523 - (150 + 370)))) then
			local v1574 = 1282 - (74 + 1208);
			while true do
				if ((4 - 2) == v1574) then
					v693[14 - 11].Size = UDim2.new(0 + 0, v284 * 0.4, 390 - (14 + 376), 3 - 1);
					v693[3].Position = UDim2.new(0.5 + 0, -v284 * (0.2 + 0), 0.41 + 0, -v284 * (0.4 - 0));
					break;
				end
				if (v1574 == (0 + 0)) then
					v693[79 - (23 + 55)].Size = UDim2.new(0, 4 - 2, 0, v284 * 0.8);
					v693[1 + 0].Position = UDim2.new(0.5 + 0, -1, 0.41 - 0, -v284 * 0.4);
					v1574 = 1 + 0;
				end
				if (v1574 == (902 - (652 + 249))) then
					v693[5 - 3].Size = UDim2.new(1868 - (708 + 1160), v284 * 0.4, 0, 2);
					v693[5 - 3].Position = UDim2.new(0.5 - 0, -v284 * (27.2 - (10 + 17)), 0.41 + 0, -v284 * (1732.4 - (1400 + 332)));
					v1574 = 3 - 1;
				end
			end
		elseif ((v692 == "Target") and (#v693 >= (1911 - (242 + 1666)))) then
			local v1643 = 0;
			while true do
				if (v1643 == (0 + 0)) then
					v693[1].Size = UDim2.new(0 + 0, v284, 0, v284);
					v693[1].Position = UDim2.new(0.5 + 0, -v284 / 2, 940.41 - (850 + 90), -v284 / 2);
					v1643 = 1 - 0;
				end
				if (v1643 == (1391 - (360 + 1030))) then
					v693[2 + 0].Size = UDim2.new(0 - 0, v284 * (0.6 - 0), 0, v284 * 0.6);
					v693[1663 - (909 + 752)].Position = UDim2.new(1223.5 - (109 + 1114), -v284 * (0.3 - 0), 0.41 + 0, -v284 * (242.3 - (6 + 236)));
					v1643 = 2 + 0;
				end
				if (v1643 == (2 + 0)) then
					v693[3].Position = UDim2.new(0.5, -(2 - 1), 0.41 - 0, -(1134 - (1076 + 57)));
					break;
				end
			end
		elseif ((v692 == "Star") and (#v693 >= 4)) then
			for v1752 = 1 + 0, #v693 do
				local v1753 = 689 - (579 + 110);
				while true do
					if (v1753 == (0 + 0)) then
						v693[v1752].Size = UDim2.new(0 + 0, v284 * (0.7 + 0), 407 - (174 + 233), 5 - 3);
						v693[v1752].Position = UDim2.new(0.5, -v284 * (0.35 - 0), 0.41 + 0, -(1175 - (663 + 511)));
						break;
					end
				end
			end
		elseif ((v692 == "Diamond") and (#v693 >= (1 + 0))) then
			local v1764 = 0 + 0;
			while true do
				if (v1764 == 0) then
					v693[2 - 1].Size = UDim2.new(0 + 0, v284 * (0.8 - 0), 0, v284 * 0.8);
					v693[2 - 1].Position = UDim2.new(0.5, -v284 * 0.4, 0.41 + 0, -v284 * 0.4);
					break;
				end
			end
		end
	end
	v27();
end
local function v30()
	local v285 = {"Plus","X-Shape","Circle","Dot","Arrow","Target","Star","Diamond"};
	local v286 = Color3.fromRGB(v6.crosshairColor.r, v6.crosshairColor.g, v6.crosshairColor.b);
	for v694, v695 in ipairs(v285) do
		v25[v695] = v26(v695, v6.crosshairSize, v286);
	end
end
v30();
local function v31()
	local v287 = 517 - (440 + 77);
	local v288;
	local v289;
	local v290;
	while true do
		if (v287 == (4 + 3)) then
			table.insert(v288, tostring(v6.crosshairColor.b));
			table.insert(v288, tostring(v6.fovCircleColor.r));
			table.insert(v288, tostring(v6.fovCircleColor.g));
			v287 = 29 - 21;
		end
		if (3 == v287) then
			local v767 = 1556 - (655 + 901);
			while true do
				if (v767 == (0 + 0)) then
					table.insert(v288, (v5.crosshairSpin and "1") or "0");
					table.insert(v288, (v5.xray and "1") or "0");
					v767 = 1;
				end
				if (v767 == (1 + 0)) then
					table.insert(v288, (v5.snaplines and "1") or "0");
					v287 = 3 + 1;
					break;
				end
			end
		end
		if (v287 == 0) then
			v288 = {};
			table.insert(v288, (v5.particles and "1") or "0");
			table.insert(v288, (v5.headCircles and "1") or "0");
			v287 = 3 - 2;
		end
		if (v287 == 8) then
			table.insert(v288, tostring(v6.fovCircleColor.b));
			v289 = 1446 - (695 + 750);
			v290 = {"Plus","X-Shape","Circle","Dot","Arrow","Target","Star","Diamond"};
			v287 = 308 - (176 + 123);
		end
		if (v287 == 4) then
			table.insert(v288, (v5.bigHitboxes and "1") or "0");
			table.insert(v288, (v5.armorESP and "1") or "0");
			table.insert(v288, (v7 and "1") or "0");
			v287 = 3 + 2;
		end
		if ((4 + 1) == v287) then
			table.insert(v288, "|");
			table.insert(v288, tostring(v6.fovCircleSize));
			table.insert(v288, tostring(v6.crosshairSize));
			v287 = 275 - (239 + 30);
		end
		if (v287 == (1 + 0)) then
			local v768 = 0 + 0;
			while true do
				if (v768 == (0 - 0)) then
					table.insert(v288, (v5.selectionBoxes and "1") or "0");
					table.insert(v288, (v5.statusLabel and "1") or "0");
					v768 = 2 - 1;
				end
				if (v768 == (316 - (306 + 9))) then
					table.insert(v288, (v5.playerESP and "1") or "0");
					v287 = 2;
					break;
				end
			end
		end
		if (v287 == 2) then
			local v769 = 0;
			while true do
				if (v769 == 1) then
					table.insert(v288, (v5.fovCircle and "1") or "0");
					v287 = 3;
					break;
				end
				if (v769 == (0 - 0)) then
					table.insert(v288, (v5.distance and "1") or "0");
					table.insert(v288, (v5.crosshair and "1") or "0");
					v769 = 1 + 0;
				end
			end
		end
		if (v287 == 9) then
			for v1127, v1128 in ipairs(v290) do
				if (v1128 == v6.crosshairStyle) then
					v289 = v1127;
					break;
				end
			end
			table.insert(v288, tostring(v289));
			return table.concat(v288, "-");
		end
		if (v287 == (4 + 2)) then
			table.insert(v288, tostring(v6.crosshairSpinSpeed));
			table.insert(v288, tostring(v6.crosshairColor.r));
			table.insert(v288, tostring(v6.crosshairColor.g));
			v287 = 4 + 3;
		end
	end
end
local function v32(v291)
	local v292 = 0;
	local v293;
	local v294;
	local v295;
	local v296;
	while true do
		local v697 = 0 - 0;
		while true do
			if ((1376 - (1140 + 235)) == v697) then
				if (v292 == (0 + 0)) then
					if (not v291 or (v291 == "")) then
						return false, "Code cannot be empty!";
					end
					if v16[v291:upper()] then
						local v1418 = 0 + 0;
						local v1419;
						while true do
							local v1468 = 0 + 0;
							while true do
								if (v1468 == 1) then
									if (v1418 == (54 - (33 + 19))) then
										v27();
										v28();
										v1418 = 2 + 1;
									end
									if (v1418 == 3) then
										local v1679 = 0 - 0;
										while true do
											if ((0 + 0) == v1679) then
												v29();
												return true, "Applied predefined code: " .. v291:upper();
											end
										end
									end
									break;
								end
								if ((0 - 0) == v1468) then
									if (v1418 == (0 + 0)) then
										v1419 = v16[v291:upper()];
										for v1712, v1713 in pairs(v1419.features) do
											if (v5[v1712] ~= nil) then
												v5[v1712] = v1713;
											end
										end
										v1418 = 690 - (586 + 103);
									end
									if (v1418 == (1 + 0)) then
										for v1714, v1715 in pairs(v1419.visualSettings) do
											if (v6[v1714] ~= nil) then
												v6[v1714] = v1715;
											end
										end
										if (v1419.performanceMode ~= nil) then
											v7 = v1419.performanceMode;
										end
										v1418 = 5 - 3;
									end
									v1468 = 1;
								end
							end
						end
					end
					v293 = {};
					for v1355 in string.gmatch(v291, "[^-]+") do
						table.insert(v293, v1355);
					end
					v292 = 1489 - (1309 + 179);
				end
				if (v292 == (6 - 2)) then
					if v293[v296 + 2 + 2] then
						v6.crosshairColor.g = tonumber(v293[v296 + (10 - 6)]) or (114 + 36);
					end
					if v293[v296 + (10 - 5)] then
						v6.crosshairColor.b = tonumber(v293[v296 + (9 - 4)]) or 255;
					end
					if v293[v296 + (615 - (295 + 314))] then
						v6.fovCircleColor.r = tonumber(v293[v296 + 6]) or 255;
					end
					if v293[v296 + (16 - 9)] then
						v6.fovCircleColor.g = tonumber(v293[v296 + (1969 - (1300 + 662))]) or 255;
					end
					v292 = 15 - 10;
				end
				v697 = 1757 - (1178 + 577);
			end
			if (v697 == (2 + 0)) then
				if (v292 == 5) then
					if v293[v296 + (23 - 15)] then
						v6.fovCircleColor.b = tonumber(v293[v296 + 8]) or (1660 - (851 + 554));
					end
					if v293[v296 + 8 + 1] then
						local v1425 = 0 - 0;
						local v1426;
						local v1427;
						while true do
							if (v1425 == (0 - 0)) then
								v1426 = {"Plus","X-Shape","Circle","Dot","Arrow","Target","Star","Diamond"};
								v1427 = tonumber(v293[v296 + (35 - 26)]) or 1;
								v1425 = 1162 - (160 + 1001);
							end
							if (v1425 == 1) then
								if v1426[v1427] then
									v6.crosshairStyle = v1426[v1427];
								end
								break;
							end
						end
					end
					v27();
					v28();
					v292 = 6 + 0;
				end
				if (v292 == (5 + 1)) then
					v29();
					return true, "Custom code applied successfully!";
				end
				v697 = 3;
			end
			if (v697 == 0) then
				if (v292 == (3 - 1)) then
					v295 = {"particles","headCircles","selectionBoxes","statusLabel","playerESP","distance","crosshair","fovCircle","crosshairSpin","xray","snaplines","bigHitboxes","armorESP"};
					for v1356, v1357 in ipairs(v295) do
						if (v293[v1356] and (v5[v1357] ~= nil)) then
							v5[v1357] = v293[v1356] == "1";
						end
					end
					if v293[14] then
						v7 = v293[51 - 37] == "1";
					end
					v296 = v294 + 1 + 0;
					v292 = 5 - 2;
				end
				if (v292 == (5 - 2)) then
					if v293[v296] then
						v6.fovCircleSize = tonumber(v293[v296]) or (819 - (316 + 403));
					end
					if v293[v296 + 1] then
						v6.crosshairSize = tonumber(v293[v296 + 1 + 0]) or (43 - 27);
					end
					if v293[v296 + 1 + 1] then
						v6.crosshairSpinSpeed = tonumber(v293[v296 + (4 - 2)]) or 50;
					end
					if v293[v296 + 3 + 0] then
						v6.crosshairColor.r = tonumber(v293[v296 + 3]) or 0;
					end
					v292 = 2 + 2;
				end
				v697 = 3 - 2;
			end
			if (v697 == (14 - 11)) then
				if (v292 == (1 - 0)) then
					if (#v293 < (1 + 14)) then
						return false, "Invalid code format!";
					end
					v294 = nil;
					for v1358, v1359 in ipairs(v293) do
						if (v1359 == "|") then
							v294 = v1358;
							break;
						end
					end
					if not v294 then
						return false, "Invalid code format - missing separator!";
					end
					v292 = 3 - 1;
				end
				break;
			end
		end
	end
end
local v33 = {primary=Color3.fromRGB(25, 2 + 23, 102 - 67),secondary=Color3.fromRGB(35, 52 - (12 + 5), 45),accent=Color3.fromRGB(341 - 253, 101, 242),accentHover=Color3.fromRGB(71, 82, 196),success=Color3.fromRGB(67, 385 - 204, 273 - 144),danger=Color3.fromRGB(587 - 350, 66, 15 + 54),text=Color3.fromRGB(2228 - (1656 + 317), 228 + 27, 205 + 50),textSecondary=Color3.fromRGB(478 - 298, 885 - 705, 534 - (5 + 349)),border=Color3.fromRGB(261 - 206, 1326 - (266 + 1005), 43 + 22)};
local v34 = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
local v35 = TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
local v36 = Instance.new("Frame");
v36.Name = "MainFrame";
v36.Size = UDim2.new(0, 1979 - 1399, 0 - 0, 2096 - (561 + 1135));
v36.Position = UDim2.new(0.5 - 0, -290, 0.5 - 0, -200);
v36.BackgroundColor3 = v33.primary;
v36.BorderSizePixel = 1066 - (507 + 559);
v36.Visible = false;
v36.ClipsDescendants = true;
v36.ZIndex = 12 - 7;
v36.Parent = v18;
local v47 = Instance.new("ImageLabel");
v47.Name = "Shadow";
v47.AnchorPoint = Vector2.new(0.5, 0.5);
v47.BackgroundTransparency = 3 - 2;
v47.Position = UDim2.new(388.5 - (212 + 176), 905 - (250 + 655), 0.5, 0 - 0);
v47.Size = UDim2.new(1, 30, 1 - 0, 30);
v47.Image = "rbxasset://textures/ui/Controls/DropShadow.png";
v47.ImageColor3 = Color3.new(0, 0 - 0, 1956 - (1869 + 87));
v47.ImageTransparency = 0.5;
v47.ScaleType = Enum.ScaleType.Slice;
v47.SliceCenter = Rect.new(41 - 29, 1913 - (484 + 1417), 12, 25 - 13);
v47.ZIndex = v36.ZIndex - 1;
v47.Parent = v36;
local v61 = Instance.new("UICorner");
v61.CornerRadius = UDim.new(0, 19 - 7);
v61.Parent = v36;
local v64 = Instance.new("Frame");
v64.Name = "Header";
v64.Size = UDim2.new(774 - (48 + 725), 0 - 0, 0 - 0, 30 + 20);
v64.Position = UDim2.new(0 - 0, 0 + 0, 0, 0 + 0);
v64.BackgroundColor3 = v33.secondary;
v64.BorderSizePixel = 853 - (152 + 701);
v64.ZIndex = 1317 - (430 + 881);
v64.Parent = v36;
local v73 = Instance.new("UICorner");
v73.CornerRadius = UDim.new(0 + 0, 907 - (557 + 338));
v73.Parent = v64;
local v76 = Instance.new("Frame");
v76.Size = UDim2.new(1, 0 + 0, 0 - 0, 41 - 29);
v76.Position = UDim2.new(0 - 0, 0 - 0, 802 - (499 + 302), -(878 - (39 + 827)));
v76.BackgroundColor3 = v33.secondary;
v76.BorderSizePixel = 0 - 0;
v76.ZIndex = 13 - 7;
v76.Parent = v64;
local v83 = Instance.new("TextLabel");
v83.Name = "Title";
v83.Size = UDim2.new(0 - 0, 307 - 107, 1 + 0, 0);
v83.Position = UDim2.new(0, 20, 0 - 0, 0 + 0);
v83.BackgroundTransparency = 1 - 0;
v83.Text = "BIGHACK";
v83.TextColor3 = v33.text;
v83.TextSize = 124 - (103 + 1);
v83.Font = Enum.Font.GothamBold;
v83.TextXAlignment = Enum.TextXAlignment.Left;
v83.ZIndex = 6;
v83.Parent = v64;
local v98 = Instance.new("TextLabel");
v98.Name = "Version";
v98.Size = UDim2.new(554 - (475 + 79), 100, 0, 43 - 23);
v98.Position = UDim2.new(0, 64 - 44, 0 + 0, 23 + 2);
v98.BackgroundTransparency = 1504 - (1395 + 108);
v98.Text = "v1.0.0 PREMIUM";
v98.TextColor3 = v33.textSecondary;
v98.TextSize = 29 - 19;
v98.Font = Enum.Font.Gotham;
v98.TextXAlignment = Enum.TextXAlignment.Left;
v98.ZIndex = 1210 - (7 + 1197);
v98.Parent = v64;
local v112 = Instance.new("TextButton");
v112.Name = "CloseButton";
v112.Size = UDim2.new(0 + 0, 11 + 19, 319 - (27 + 292), 30);
v112.Position = UDim2.new(2 - 1, -(51 - 11), 0, 41 - 31);
v112.BackgroundColor3 = v33.danger;
v112.BorderSizePixel = 0 - 0;
v112.Text = "✕";
v112.TextColor3 = v33.text;
v112.TextSize = 14;
v112.Font = Enum.Font.GothamBold;
v112.ZIndex = 6;
v112.Parent = v64;
local v125 = Instance.new("UICorner");
v125.CornerRadius = UDim.new(0 - 0, 145 - (43 + 96));
v125.Parent = v112;
local v128 = Instance.new("TextButton");
v128.Name = "MinimizeButton";
v128.Size = UDim2.new(0 - 0, 30, 0, 67 - 37);
v128.Position = UDim2.new(1 + 0, -75, 0 + 0, 19 - 9);
v128.BackgroundColor3 = v33.border;
v128.BorderSizePixel = 0;
v128.Text = "−";
v128.TextColor3 = v33.text;
v128.TextSize = 7 + 9;
v128.Font = Enum.Font.GothamBold;
v128.ZIndex = 10 - 4;
v128.Parent = v64;
local v141 = Instance.new("UICorner");
v141.CornerRadius = UDim.new(0, 6);
v141.Parent = v128;
local v144 = Instance.new("Frame");
v144.Name = "ContentFrame";
v144.Size = UDim2.new(1 + 0, 0 + 0, 1752 - (1414 + 337), -(1990 - (1642 + 298)));
v144.Position = UDim2.new(0, 0 - 0, 0, 143 - 93);
v144.BackgroundTransparency = 1;
v144.ZIndex = 14 - 9;
v144.Parent = v36;
local v151 = Instance.new("Frame");
v151.Name = "TabBar";
v151.Size = UDim2.new(0 + 0, 120, 1 + 0, 0);
v151.Position = UDim2.new(972 - (357 + 615), 0 + 0, 0 - 0, 0);
v151.BackgroundColor3 = v33.secondary;
v151.BorderSizePixel = 0 + 0;
v151.ZIndex = 5;
v151.Parent = v144;
local v159 = {{name="Combat",icon="⚔",features={{type="toggle",key="playerESP",name="Player ESP",desc="Highlight all players"},{type="toggle",key="headCircles",name="Head Circles",desc="Show circles on player heads"},{type="toggle",key="armorESP",name="Armor ESP",desc="Highlight player armor"},{type="toggle",key="snaplines",name="Snaplines",desc="Lines to closest players"},{type="toggle",key="distance",name="Distance",desc="Show distance to players"},{type="toggle",key="selectionBoxes",name="Selection Boxes",desc="Boxes around players"}}},{name="Visuals",icon="👁",features={{type="toggle",key="crosshair",name="Crosshair",desc="Custom crosshair overlay"},{type="dropdown",key="crosshairStyle",name="Crosshair Style",options={"Plus","X-Shape","Circle","Dot","Arrow","Target","Star","Diamond"},desc="Choose crosshair shape"},{type="slider",key="crosshairSize",name="Crosshair Size",min=(429 - (275 + 146)),max=40,desc="Adjust crosshair size"},{type="colorpicker",key="crosshairColor",name="Crosshair Color",desc="Customize crosshair color"},{type="toggle",key="crosshairSpin",name="Crosshair Spin",desc="Animated spinning crosshair"},{type="slider",key="crosshairSpinSpeed",name="Spin Speed",min=(74 - (29 + 35)),max=(886 - 686),desc="Crosshair rotation speed"},{type="toggle",key="fovCircle",name="FOV Circle",desc="Field of view indicator"},{type="slider",key="fovCircleSize",name="FOV Size",min=(220 - 170),max=(196 + 104),desc="FOV circle radius"},{type="colorpicker",key="fovCircleColor",name="FOV Circle Color",desc="Customize FOV circle color"},{type="toggle",key="particles",name="Particle Trails",desc="Visual particle effects"}}},{name="World",icon="🌍",features={{type="toggle",key="xray",name="X-Ray Vision",desc="See through walls"},{type="toggle",key="bigHitboxes",name="Expanded Hitboxes",desc="Larger player hitboxes"}}},{name="Misc",icon="⚙",features={{type="toggle",key="statusLabel",name="Status Display",desc="Show system information"},{type="toggle",key="performanceMode",name="Performance Mode",desc="Optimize for better FPS"}}},{name="Saves",icon="💾",features={{type="code_generator",name="Generate Code",desc="Create a shareable code for your current settings"},{type="predefined_codes",name="Quick Codes",desc="Pre-made configuration codes"},{type="code_input",name="Load Code",desc="Enter a code to apply configuration"}}}};
local v160 = Instance.new("ScrollingFrame");
v160.Name = "ContentPanel";
v160.Size = UDim2.new(1 + 0, -(424 - 294), 1087 - (860 + 226), -10);
v160.Position = UDim2.new(303 - (121 + 182), 16 + 109, 0, 1245 - (988 + 252));
v160.BackgroundTransparency = 1;
v160.BorderSizePixel = 0;
v160.ScrollBarThickness = 4;
v160.ScrollBarImageColor3 = v33.accent;
v160.CanvasSize = UDim2.new(0 + 0, 0, 0 + 0, 2570 - (49 + 1921));
v160.ZIndex = 895 - (223 + 667);
v160.Parent = v144;
local function v172(v297, v298)
	local v299 = 0;
	local v300;
	local v301;
	local v302;
	local v303;
	local v304;
	local v305;
	local v306;
	local v307;
	local v308;
	local v309;
	while true do
		if (v299 == (53 - (51 + 1))) then
			v301 = Instance.new("UICorner");
			v301.CornerRadius = UDim.new(0 - 0, 8);
			v301.Parent = v300;
			v302 = Instance.new("TextLabel");
			v302.Size = UDim2.new(1 - 0, -(1205 - (146 + 979)), 0 + 0, 625 - (311 + 294));
			v302.Position = UDim2.new(0, 41 - 26, 0 + 0, 8);
			v302.BackgroundTransparency = 1444 - (496 + 947);
			v302.Text = v297.name;
			v299 = 1360 - (1233 + 125);
		end
		if (v299 == (3 + 2)) then
			v305.ZIndex = 5 + 0;
			v305.Parent = v300;
			v306 = Instance.new("UICorner");
			v306.CornerRadius = UDim.new(1 + 0, 0);
			v306.Parent = v305;
			v307 = Instance.new("Frame");
			v307.Size = UDim2.new(1645 - (963 + 682), 16 + 2, 1504 - (504 + 1000), 13 + 5);
			v307.Position = (v304 and UDim2.new(1, -(19 + 1), 0.5, -(1 + 8))) or UDim2.new(0, 2, 0.5 - 0, -9);
			v299 = 6 + 0;
		end
		if (v299 == 6) then
			v307.BackgroundColor3 = v33.text;
			v307.BorderSizePixel = 0 + 0;
			v307.ZIndex = 5;
			v307.Parent = v305;
			v308 = Instance.new("UICorner");
			v308.CornerRadius = UDim.new(183 - (156 + 26), 0 + 0);
			v308.Parent = v307;
			v309 = Instance.new("TextButton");
			v299 = 10 - 3;
		end
		if (v299 == 7) then
			v309.Size = UDim2.new(165 - (149 + 15), 960 - (890 + 70), 118 - (39 + 78), 482 - (14 + 468));
			v309.BackgroundTransparency = 1;
			v309.Text = "";
			v309.ZIndex = 10 - 5;
			v309.Parent = v305;
			v309.MouseButton1Click:Connect(function()
				local v1129 = 0 - 0;
				local v1130;
				local v1131;
				while true do
					if (v1129 == 2) then
						v2:Create(v307, v35, {Position=v1131}):Play();
						break;
					end
					if (v1129 == (1 + 0)) then
						v1131 = (v304 and UDim2.new(1 + 0, -(5 + 15), 0.5 + 0, -9)) or UDim2.new(0, 2, 0.5 + 0, -(16 - 7));
						v2:Create(v305, v35, {BackgroundColor3=v1130}):Play();
						v1129 = 2 + 0;
					end
					if (v1129 == 0) then
						if (v297.key == "performanceMode") then
							local v1470 = 0 - 0;
							local v1471;
							while true do
								if (v1470 == (0 + 0)) then
									v1471 = 51 - (12 + 39);
									while true do
										if (v1471 == (0 + 0)) then
											v7 = not v7;
											v304 = v7;
											break;
										end
									end
									break;
								end
							end
						else
							local v1472 = 0;
							while true do
								if (v1472 == (0 - 0)) then
									v5[v297.key] = not v5[v297.key];
									v304 = v5[v297.key];
									break;
								end
							end
						end
						v1130 = (v304 and v33.success) or Color3.fromRGB(60, 213 - 153, 21 + 49);
						v1129 = 1;
					end
				end
			end);
			return v300;
		end
		if (v299 == (3 + 1)) then
			v303.Parent = v300;
			v304 = nil;
			if (v297.key == "performanceMode") then
				v304 = v7;
			else
				v304 = v5[v297.key];
			end
			v305 = Instance.new("Frame");
			v305.Size = UDim2.new(0 - 0, 30 + 15, 0 - 0, 1732 - (1596 + 114));
			v305.Position = UDim2.new(1, -(156 - 96), 713.5 - (164 + 549), -11);
			v305.BackgroundColor3 = (v304 and v33.success) or Color3.fromRGB(1498 - (1059 + 379), 60, 70);
			v305.BorderSizePixel = 0 - 0;
			v299 = 5;
		end
		if (v299 == 3) then
			v303.Position = UDim2.new(0, 8 + 7, 0, 28);
			v303.BackgroundTransparency = 1;
			v303.Text = v297.desc;
			v303.TextColor3 = v33.textSecondary;
			v303.TextSize = 10;
			v303.Font = Enum.Font.Gotham;
			v303.TextXAlignment = Enum.TextXAlignment.Left;
			v303.ZIndex = 1 + 4;
			v299 = 396 - (145 + 247);
		end
		if (v299 == 2) then
			v302.TextColor3 = v33.text;
			v302.TextSize = 12 + 2;
			v302.Font = Enum.Font.GothamSemibold;
			v302.TextXAlignment = Enum.TextXAlignment.Left;
			v302.ZIndex = 3 + 2;
			v302.Parent = v300;
			v303 = Instance.new("TextLabel");
			v303.Size = UDim2.new(1, -(237 - 157), 0 + 0, 13 + 2);
			v299 = 4 - 1;
		end
		if (v299 == 0) then
			v300 = Instance.new("Frame");
			v300.Name = v297.key .. "Container";
			v300.Size = UDim2.new(721 - (254 + 466), -(580 - (544 + 16)), 0, 190 - 130);
			v300.Position = UDim2.new(628 - (294 + 334), 10, 253 - (236 + 17), v298);
			v300.BackgroundColor3 = v33.secondary;
			v300.BorderSizePixel = 0;
			v300.ZIndex = 5;
			v300.Parent = v160;
			v299 = 1 + 0;
		end
	end
end
local function v173(v310, v311)
	local v312 = Instance.new("Frame");
	v312.Name = v310.key .. "Container";
	v312.Size = UDim2.new(1 + 0, -(75 - 55), 0 - 0, 70);
	v312.Position = UDim2.new(0 + 0, 9 + 1, 794 - (413 + 381), v311);
	v312.BackgroundColor3 = v33.secondary;
	v312.BorderSizePixel = 0;
	v312.ZIndex = 1 + 4;
	v312.Parent = v160;
	local v321 = Instance.new("UICorner");
	v321.CornerRadius = UDim.new(0 - 0, 20 - 12);
	v321.Parent = v312;
	local v324 = Instance.new("TextLabel");
	v324.Size = UDim2.new(1971 - (582 + 1388), -(136 - 56), 0 + 0, 384 - (326 + 38));
	v324.Position = UDim2.new(0 - 0, 21 - 6, 620 - (47 + 573), 3 + 5);
	v324.BackgroundTransparency = 4 - 3;
	v324.Text = v310.name .. ": " .. v6[v310.key];
	v324.TextColor3 = v33.text;
	v324.TextSize = 22 - 8;
	v324.Font = Enum.Font.GothamSemibold;
	v324.TextXAlignment = Enum.TextXAlignment.Left;
	v324.ZIndex = 1669 - (1269 + 395);
	v324.Parent = v312;
	local v338 = Instance.new("TextBox");
	v338.Size = UDim2.new(0, 542 - (76 + 416), 443 - (319 + 124), 45 - 25);
	v338.Position = UDim2.new(1, -65, 1007 - (564 + 443), 21 - 13);
	v338.BackgroundColor3 = v33.border;
	v338.BorderSizePixel = 458 - (337 + 121);
	v338.Text = tostring(v6[v310.key]);
	v338.TextColor3 = v33.text;
	v338.TextSize = 12;
	v338.Font = Enum.Font.Gotham;
	v338.TextXAlignment = Enum.TextXAlignment.Center;
	v338.PlaceholderText = "Value";
	v338.PlaceholderColor3 = v33.textSecondary;
	v338.ZIndex = 14 - 9;
	v338.Parent = v312;
	local v356 = Instance.new("UICorner");
	v356.CornerRadius = UDim.new(0 - 0, 1915 - (1261 + 650));
	v356.Parent = v338;
	local v359 = Instance.new("TextLabel");
	v359.Size = UDim2.new(1, -20, 0 + 0, 15);
	v359.Position = UDim2.new(0 - 0, 1832 - (772 + 1045), 0, 4 + 21);
	v359.BackgroundTransparency = 145 - (102 + 42);
	v359.Text = v310.desc;
	v359.TextColor3 = v33.textSecondary;
	v359.TextSize = 10;
	v359.Font = Enum.Font.Gotham;
	v359.TextXAlignment = Enum.TextXAlignment.Left;
	v359.ZIndex = 5;
	v359.Parent = v312;
	local v371 = Instance.new("Frame");
	v371.Size = UDim2.new(1, -(1919 - (1524 + 320)), 0, 4);
	v371.Position = UDim2.new(0, 1285 - (1049 + 221), 156 - (18 + 138), 122 - 72);
	v371.BackgroundColor3 = Color3.fromRGB(1162 - (67 + 1035), 408 - (136 + 212), 70);
	v371.BorderSizePixel = 0;
	v371.ZIndex = 21 - 16;
	v371.Parent = v312;
	local v378 = Instance.new("UICorner");
	v378.CornerRadius = UDim.new(1 + 0, 0 + 0);
	v378.Parent = v371;
	local v381 = v6[v310.key];
	local v382 = (v381 - v310.min) / (v310.max - v310.min);
	local v383 = Instance.new("Frame");
	v383.Size = UDim2.new(v382, 1604 - (240 + 1364), 1083 - (1050 + 32), 0);
	v383.Position = UDim2.new(0 - 0, 0 + 0, 1055 - (331 + 724), 0);
	v383.BackgroundColor3 = v33.accent;
	v383.BorderSizePixel = 0 + 0;
	v383.ZIndex = 5;
	v383.Parent = v371;
	local v391 = Instance.new("UICorner");
	v391.CornerRadius = UDim.new(645 - (269 + 375), 725 - (267 + 458));
	v391.Parent = v383;
	local v394 = Instance.new("Frame");
	v394.Size = UDim2.new(0, 5 + 11, 0 - 0, 834 - (667 + 151));
	v394.Position = UDim2.new(v382, -8, 0.5, -(1505 - (1410 + 87)));
	v394.BackgroundColor3 = v33.text;
	v394.BorderSizePixel = 1897 - (1504 + 393);
	v394.ZIndex = 5;
	v394.Parent = v371;
	local v401 = Instance.new("UICorner");
	v401.CornerRadius = UDim.new(2 - 1, 0);
	v401.Parent = v394;
	local function v404(v698)
		local v699 = 0 - 0;
		local v700;
		while true do
			if (v699 == (797 - (461 + 335))) then
				v324.Text = v310.name .. ": " .. v698;
				v338.Text = tostring(v698);
				v699 = 1 + 1;
			end
			if (v699 == 0) then
				v698 = math.clamp(v698, v310.min, v310.max);
				v6[v310.key] = v698;
				v699 = 1;
			end
			if (v699 == 3) then
				v2:Create(v394, v35, {Position=UDim2.new(v700, -(1769 - (1730 + 31)), 1667.5 - (728 + 939), -(28 - 20))}):Play();
				if (v310.key == "crosshairSize") then
					v29();
				end
				break;
			end
			if (v699 == (3 - 1)) then
				v700 = (v698 - v310.min) / (v310.max - v310.min);
				v2:Create(v383, v35, {Size=UDim2.new(v700, 0 - 0, 1069 - (138 + 930), 0)}):Play();
				v699 = 3 + 0;
			end
		end
	end
	local v405 = false;
	local function v406(v701)
		local v702 = v371.AbsolutePosition.X;
		local v703 = v371.AbsoluteSize.X;
		local v704 = v701.Position.X;
		local v705 = math.clamp((v704 - v702) / v703, 0 + 0, 1 + 0);
		local v706 = math.floor(v310.min + ((v310.max - v310.min) * v705));
		v404(v706);
	end
	v394.InputBegan:Connect(function(v707)
		if (v707.UserInputType == Enum.UserInputType.MouseButton1) then
			local v830 = 0;
			local v831;
			while true do
				if (v830 == (0 - 0)) then
					v831 = 1766 - (459 + 1307);
					while true do
						if (0 == v831) then
							v405 = true;
							v406(v707);
							break;
						end
					end
					break;
				end
			end
		end
	end);
	v3.InputChanged:Connect(function(v708)
		if (v405 and (v708.UserInputType == Enum.UserInputType.MouseMovement)) then
			v406(v708);
		end
	end);
	v3.InputEnded:Connect(function(v709)
		if (v709.UserInputType == Enum.UserInputType.MouseButton1) then
			v405 = false;
		end
	end);
	v338.FocusLost:Connect(function(v710)
		local v711 = 1870 - (474 + 1396);
		local v712;
		while true do
			if (v711 == (0 - 0)) then
				v712 = tonumber(v338.Text);
				if v712 then
					v404(math.floor(v712));
				else
					v338.Text = tostring(v6[v310.key]);
				end
				break;
			end
		end
	end);
	v338.Focused:Connect(function()
		v2:Create(v338, v35, {BackgroundColor3=v33.accent}):Play();
	end);
	v338.FocusLost:Connect(function()
		v2:Create(v338, v35, {BackgroundColor3=v33.border}):Play();
	end);
	v338:GetPropertyChangedSignal("Text"):Connect(function()
		local v713 = 0 + 0;
		local v714;
		local v715;
		while true do
			if (0 == v713) then
				v714 = v338.Text;
				v715 = v714:gsub("[^%d]", "");
				v713 = 1 + 0;
			end
			if (v713 == (2 - 1)) then
				if (v715 ~= v714) then
					v338.Text = v715;
				end
				break;
			end
		end
	end);
	return v312;
end
local function v174(v407, v408)
	local v409 = 0 + 0;
	local v410;
	local v411;
	local v412;
	local v413;
	local v414;
	local v415;
	local v416;
	local v417;
	local v418;
	while true do
		if (v409 == (9 - 6)) then
			v412.Font = Enum.Font.GothamSemibold;
			v412.TextXAlignment = Enum.TextXAlignment.Left;
			v412.ZIndex = 21 - 16;
			v412.Parent = v410;
			v413 = Instance.new("TextLabel");
			v413.Size = UDim2.new(592 - (562 + 29), -(18 + 2), 0, 1434 - (374 + 1045));
			v409 = 4 + 0;
		end
		if (v409 == (12 - 8)) then
			v413.Position = UDim2.new(638 - (448 + 190), 15, 0 + 0, 12 + 13);
			v413.BackgroundTransparency = 1;
			v413.Text = v407.desc;
			v413.TextColor3 = v33.textSecondary;
			v413.TextSize = 7 + 3;
			v413.Font = Enum.Font.Gotham;
			v409 = 19 - 14;
		end
		if ((15 - 10) == v409) then
			v413.TextXAlignment = Enum.TextXAlignment.Left;
			v413.ZIndex = 1499 - (1307 + 187);
			v413.Parent = v410;
			v414 = Instance.new("TextButton");
			v414.Size = UDim2.new(1, -(118 - 88), 0 - 0, 76 - 51);
			v414.Position = UDim2.new(0, 698 - (232 + 451), 0 + 0, 36 + 4);
			v409 = 570 - (510 + 54);
		end
		if (v409 == (3 - 1)) then
			v412.Size = UDim2.new(1, -20, 36 - (13 + 23), 38 - 18);
			v412.Position = UDim2.new(0 - 0, 26 - 11, 0, 8);
			v412.BackgroundTransparency = 1;
			v412.Text = v407.name .. ": " .. v6[v407.key];
			v412.TextColor3 = v33.text;
			v412.TextSize = 1102 - (830 + 258);
			v409 = 10 - 7;
		end
		if (v409 == (6 + 2)) then
			v416.Size = UDim2.new(0 + 0, 1661 - (860 + 581), 0 - 0, #v407.options * (20 + 5));
			v416.Position = UDim2.new(241 - (237 + 4), 58 - 33, 0 - 0, v408 + (123 - 58));
			v416.BackgroundColor3 = v33.primary;
			v416.BorderSizePixel = 0 + 0;
			v416.Visible = false;
			v416.ZIndex = 25;
			v409 = 6 + 3;
		end
		if (v409 == (37 - 27)) then
			v418.Thickness = 1;
			v418.Parent = v416;
			for v1136, v1137 in ipairs(v407.options) do
				local v1138 = 0;
				local v1139;
				while true do
					if ((0 + 0) == v1138) then
						v1139 = Instance.new("TextButton");
						v1139.Size = UDim2.new(1 + 0, 1426 - (85 + 1341), 0 - 0, 70 - 45);
						v1139.Position = UDim2.new(0, 0, 372 - (45 + 327), (v1136 - 1) * (47 - 22));
						v1138 = 1;
					end
					if (v1138 == (506 - (444 + 58))) then
						v1139.MouseLeave:Connect(function()
							v1139.BackgroundColor3 = v33.primary;
						end);
						v1139.MouseButton1Click:Connect(function()
							local v1434 = 0 + 0;
							while true do
								if (v1434 == (1 + 0)) then
									v412.Text = v407.name .. ": " .. v1137;
									v416.Visible = false;
									v1434 = 2;
								end
								if ((0 + 0) == v1434) then
									v6[v407.key] = v1137;
									v414.Text = v1137 .. " ▼";
									v1434 = 2 - 1;
								end
								if (v1434 == (1734 - (64 + 1668))) then
									if (v407.key == "crosshairStyle") then
										v27();
									end
									break;
								end
							end
						end);
						break;
					end
					if (v1138 == (1976 - (1227 + 746))) then
						v1139.ZIndex = 25;
						v1139.Parent = v416;
						v1139.MouseEnter:Connect(function()
							v1139.BackgroundColor3 = v33.accent;
						end);
						v1138 = 12 - 8;
					end
					if (2 == v1138) then
						local v1364 = 0 - 0;
						while true do
							if (0 == v1364) then
								v1139.TextColor3 = v33.text;
								v1139.TextSize = 505 - (415 + 79);
								v1364 = 1;
							end
							if (v1364 == 1) then
								v1139.Font = Enum.Font.Gotham;
								v1138 = 1 + 2;
								break;
							end
						end
					end
					if (v1138 == (492 - (142 + 349))) then
						v1139.BackgroundColor3 = v33.primary;
						v1139.BorderSizePixel = 0;
						v1139.Text = v1137;
						v1138 = 1 + 1;
					end
				end
			end
			v414.MouseButton1Click:Connect(function()
				local v1140 = 0;
				while true do
					if (v1140 == 0) then
						v416.Visible = not v416.Visible;
						if v416.Visible then
							v414.Text = v6[v407.key] .. " ▲";
						else
							v414.Text = v6[v407.key] .. " ▼";
						end
						break;
					end
				end
			end);
			return v410;
		end
		if (v409 == (9 - 2)) then
			v414.ZIndex = 3 + 2;
			v414.Parent = v410;
			v415 = Instance.new("UICorner");
			v415.CornerRadius = UDim.new(0 + 0, 10 - 6);
			v415.Parent = v414;
			v416 = Instance.new("Frame");
			v409 = 8;
		end
		if (v409 == 0) then
			v410 = Instance.new("Frame");
			v410.Name = v407.key .. "Container";
			v410.Size = UDim2.new(1865 - (1710 + 154), -(338 - (200 + 118)), 0, 70);
			v410.Position = UDim2.new(0 + 0, 17 - 7, 0 - 0, v408);
			v410.BackgroundColor3 = v33.secondary;
			v410.BorderSizePixel = 0 + 0;
			v409 = 1 + 0;
		end
		if (v409 == (1 + 0)) then
			v410.ZIndex = 5;
			v410.Parent = v160;
			v411 = Instance.new("UICorner");
			v411.CornerRadius = UDim.new(0, 2 + 6);
			v411.Parent = v410;
			v412 = Instance.new("TextLabel");
			v409 = 4 - 2;
		end
		if (v409 == (1256 - (363 + 887))) then
			v414.BackgroundColor3 = v33.border;
			v414.BorderSizePixel = 0;
			v414.Text = v6[v407.key] .. " ▼";
			v414.TextColor3 = v33.text;
			v414.TextSize = 20 - 8;
			v414.Font = Enum.Font.Gotham;
			v409 = 33 - 26;
		end
		if (v409 == (2 + 7)) then
			v416.Parent = v160;
			v417 = Instance.new("UICorner");
			v417.CornerRadius = UDim.new(0, 4);
			v417.Parent = v416;
			v418 = Instance.new("UIStroke");
			v418.Color = v33.border;
			v409 = 23 - 13;
		end
	end
end
local function v175(v419, v420)
	local v421 = Instance.new("Frame");
	v421.Name = v419.key .. "Container";
	v421.Size = UDim2.new(1 + 0, -(1684 - (674 + 990)), 0 + 0, 46 + 64);
	v421.Position = UDim2.new(0 - 0, 10, 1055 - (507 + 548), v420);
	v421.BackgroundColor3 = v33.secondary;
	v421.BorderSizePixel = 0;
	v421.ZIndex = 842 - (289 + 548);
	v421.Parent = v160;
	local v430 = Instance.new("UICorner");
	v430.CornerRadius = UDim.new(0, 1826 - (821 + 997));
	v430.Parent = v421;
	local v433 = Instance.new("TextLabel");
	v433.Size = UDim2.new(1, -60, 255 - (195 + 60), 6 + 14);
	v433.Position = UDim2.new(0, 1516 - (251 + 1250), 0 - 0, 6 + 2);
	v433.BackgroundTransparency = 1;
	v433.Text = v419.name;
	v433.TextColor3 = v33.text;
	v433.TextSize = 14;
	v433.Font = Enum.Font.GothamSemibold;
	v433.TextXAlignment = Enum.TextXAlignment.Left;
	v433.ZIndex = 1037 - (809 + 223);
	v433.Parent = v421;
	local v448 = Instance.new("Frame");
	v448.Size = UDim2.new(0, 58 - 18, 0 - 0, 20);
	v448.Position = UDim2.new(1, -(181 - 126), 0 + 0, 5 + 3);
	local v451 = v6[v419.key];
	v448.BackgroundColor3 = Color3.fromRGB(v451.r, v451.g, v451.b);
	v448.BorderSizePixel = 617 - (14 + 603);
	v448.ZIndex = 134 - (118 + 11);
	v448.Parent = v421;
	local v456 = Instance.new("UICorner");
	v456.CornerRadius = UDim.new(0 + 0, 4 + 0);
	v456.Parent = v448;
	local v459 = Instance.new("TextLabel");
	v459.Size = UDim2.new(1, -(58 - 38), 0, 964 - (551 + 398));
	v459.Position = UDim2.new(0 + 0, 6 + 9, 0 + 0, 25);
	v459.BackgroundTransparency = 3 - 2;
	v459.Text = v419.desc;
	v459.TextColor3 = v33.textSecondary;
	v459.TextSize = 23 - 13;
	v459.Font = Enum.Font.Gotham;
	v459.TextXAlignment = Enum.TextXAlignment.Left;
	v459.ZIndex = 5;
	v459.Parent = v421;
	local v473 = Instance.new("Frame");
	v473.Size = UDim2.new(1 + 0, -(119 - 89), 0 + 0, 114 - (40 + 49));
	v473.Position = UDim2.new(0 - 0, 15, 0, 535 - (99 + 391));
	v473.BackgroundTransparency = 1;
	v473.ZIndex = 5;
	v473.Parent = v421;
	local v479 = Instance.new("TextLabel");
	v479.Size = UDim2.new(0, 13 + 2, 4 - 3, 0 - 0);
	v479.Position = UDim2.new(0, 0 + 0, 0 - 0, 1604 - (1032 + 572));
	v479.BackgroundTransparency = 418 - (203 + 214);
	v479.Text = "R:";
	v479.TextColor3 = Color3.fromRGB(255, 1917 - (568 + 1249), 100);
	v479.TextSize = 10 + 2;
	v479.Font = Enum.Font.GothamSemibold;
	v479.TextXAlignment = Enum.TextXAlignment.Left;
	v479.ZIndex = 12 - 7;
	v479.Parent = v473;
	local v490 = Instance.new("TextBox");
	v490.Size = UDim2.new(0 - 0, 1341 - (913 + 393), 0 - 0, 28 - 8);
	v490.Position = UDim2.new(410 - (269 + 141), 44 - 24, 1981 - (362 + 1619), 1627.5 - (950 + 675));
	v490.BackgroundColor3 = v33.border;
	v490.BorderSizePixel = 0;
	v490.Text = tostring(v451.r);
	v490.TextColor3 = v33.text;
	v490.TextSize = 5 + 6;
	v490.Font = Enum.Font.Gotham;
	v490.TextXAlignment = Enum.TextXAlignment.Center;
	v490.PlaceholderText = "0";
	v490.ZIndex = 1184 - (216 + 963);
	v490.Parent = v473;
	local v505 = Instance.new("UICorner");
	v505.CornerRadius = UDim.new(1287 - (485 + 802), 3);
	v505.Parent = v490;
	local v508 = Instance.new("TextLabel");
	v508.Size = UDim2.new(559 - (432 + 127), 1088 - (1065 + 8), 1 + 0, 1601 - (635 + 966));
	v508.Position = UDim2.new(0 + 0, 107 - (5 + 37), 0, 0);
	v508.BackgroundTransparency = 2 - 1;
	v508.Text = "G:";
	v508.TextColor3 = Color3.fromRGB(42 + 58, 255, 100);
	v508.TextSize = 18 - 6;
	v508.Font = Enum.Font.GothamSemibold;
	v508.TextXAlignment = Enum.TextXAlignment.Left;
	v508.ZIndex = 3 + 2;
	v508.Parent = v473;
	local v519 = Instance.new("TextBox");
	v519.Size = UDim2.new(0 - 0, 132 - 97, 0, 37 - 17);
	v519.Position = UDim2.new(0 - 0, 62 + 23, 529 - (318 + 211), 2.5);
	v519.BackgroundColor3 = v33.border;
	v519.BorderSizePixel = 0 - 0;
	v519.Text = tostring(v451.g);
	v519.TextColor3 = v33.text;
	v519.TextSize = 11;
	v519.Font = Enum.Font.Gotham;
	v519.TextXAlignment = Enum.TextXAlignment.Center;
	v519.PlaceholderText = "0";
	v519.ZIndex = 1592 - (963 + 624);
	v519.Parent = v473;
	local v532 = Instance.new("UICorner");
	v532.CornerRadius = UDim.new(0, 3);
	v532.Parent = v519;
	local v535 = Instance.new("TextLabel");
	v535.Size = UDim2.new(0 + 0, 861 - (518 + 328), 1, 0 - 0);
	v535.Position = UDim2.new(0, 207 - 77, 317 - (301 + 16), 0 - 0);
	v535.BackgroundTransparency = 1;
	v535.Text = "B:";
	v535.TextColor3 = Color3.fromRGB(280 - 180, 260 - 160, 255);
	v535.TextSize = 12;
	v535.Font = Enum.Font.GothamSemibold;
	v535.TextXAlignment = Enum.TextXAlignment.Left;
	v535.ZIndex = 5 + 0;
	v535.Parent = v473;
	local v546 = Instance.new("TextBox");
	v546.Size = UDim2.new(0 + 0, 35, 0 - 0, 13 + 7);
	v546.Position = UDim2.new(0 + 0, 476 - 326, 0, 1.5 + 1);
	v546.BackgroundColor3 = v33.border;
	v546.BorderSizePixel = 1019 - (829 + 190);
	v546.Text = tostring(v451.b);
	v546.TextColor3 = v33.text;
	v546.TextSize = 39 - 28;
	v546.Font = Enum.Font.Gotham;
	v546.TextXAlignment = Enum.TextXAlignment.Center;
	v546.PlaceholderText = "0";
	v546.ZIndex = 5;
	v546.Parent = v473;
	local v559 = Instance.new("UICorner");
	v559.CornerRadius = UDim.new(0, 3 - 0);
	v559.Parent = v546;
	local v562 = Instance.new("Frame");
	v562.Size = UDim2.new(1 - 0, -(74 - 44), 0, 25);
	v562.Position = UDim2.new(0 + 0, 5 + 10, 0 - 0, 71 + 4);
	v562.BackgroundTransparency = 614 - (520 + 93);
	v562.ZIndex = 5;
	v562.Parent = v421;
	local v568 = {{name="Red",color={r=(15 + 240),g=(0 + 0),b=0}},{name="Green",color={r=(591 - (396 + 195)),g=(739 - 484),b=(1761 - (440 + 1321))}},{name="Blue",color={r=0,g=150,b=(1179 - 924)}},{name="Yellow",color={r=(47 + 208),g=255,b=(1347 - (641 + 706))}},{name="Purple",color={r=(695 - (249 + 191)),g=0,b=255}},{name="Cyan",color={r=0,g=255,b=(1110 - 855)}},{name="White",color={r=255,g=255,b=(982 - 727)}},{name="Orange",color={r=255,g=(592 - (183 + 244)),b=0}}};
	local function v569(v716)
		local v717 = 0;
		while true do
			if (v717 == (1 + 0)) then
				v716.b = math.clamp(v716.b, 730 - (434 + 296), 255);
				v6[v419.key] = v716;
				v717 = 2;
			end
			if (v717 == (9 - 6)) then
				v519.Text = tostring(v716.g);
				v546.Text = tostring(v716.b);
				v717 = 516 - (169 + 343);
			end
			if (v717 == (4 + 0)) then
				if (v419.key == "crosshairColor") then
					v28();
				end
				break;
			end
			if (2 == v717) then
				v448.BackgroundColor3 = Color3.fromRGB(v716.r, v716.g, v716.b);
				v490.Text = tostring(v716.r);
				v717 = 4 - 1;
			end
			if (v717 == (0 - 0)) then
				v716.r = math.clamp(v716.r, 0 + 0, 722 - 467);
				v716.g = math.clamp(v716.g, 1123 - (651 + 472), 193 + 62);
				v717 = 1 + 0;
			end
		end
	end
	for v718, v719 in ipairs(v568) do
		local v720 = 0 - 0;
		local v721;
		local v722;
		local v723;
		while true do
			if (v720 == (484 - (397 + 86))) then
				v721.BorderSizePixel = 876 - (423 + 453);
				v721.Text = "";
				v721.ZIndex = 1 + 4;
				v721.Parent = v562;
				v720 = 1 + 1;
			end
			if (v720 == (4 + 0)) then
				v721.MouseEnter:Connect(function()
					local v1197 = 0;
					while true do
						if (v1197 == 0) then
							v723.Thickness = 2;
							v723.Color = v33.text;
							break;
						end
					end
				end);
				v721.MouseLeave:Connect(function()
					local v1198 = 0 + 0;
					while true do
						if (v1198 == (0 + 0)) then
							v723.Thickness = 1;
							v723.Color = v33.border;
							break;
						end
					end
				end);
				break;
			end
			if (v720 == 3) then
				v723.Color = v33.border;
				v723.Thickness = 1;
				v723.Parent = v721;
				v721.MouseButton1Click:Connect(function()
					v569(v719.color);
				end);
				v720 = 4;
			end
			if (v720 == (1190 - (50 + 1140))) then
				v721 = Instance.new("TextButton");
				v721.Size = UDim2.new(0 + 0, 12 + 8, 0 + 0, 28 - 8);
				v721.Position = UDim2.new(0, (v718 - 1) * (19 + 6), 596 - (157 + 439), 2.5 - 0);
				v721.BackgroundColor3 = Color3.fromRGB(v719.color.r, v719.color.g, v719.color.b);
				v720 = 1;
			end
			if (v720 == (6 - 4)) then
				v722 = Instance.new("UICorner");
				v722.CornerRadius = UDim.new(0 - 0, 921 - (782 + 136));
				v722.Parent = v721;
				v723 = Instance.new("UIStroke");
				v720 = 3;
			end
		end
	end
	local function v570(v724, v725)
		local v726 = 855 - (112 + 743);
		while true do
			if (1 == v726) then
				v724.FocusLost:Connect(function()
					v2:Create(v724, v35, {BackgroundColor3=v33.border}):Play();
				end);
				v724:GetPropertyChangedSignal("Text"):Connect(function()
					local v1199 = 1171 - (1026 + 145);
					local v1200;
					local v1201;
					local v1202;
					while true do
						if (v1199 == (0 + 0)) then
							v1200 = 0;
							v1201 = nil;
							v1199 = 719 - (493 + 225);
						end
						if (v1199 == (3 - 2)) then
							v1202 = nil;
							while true do
								if ((0 + 0) == v1200) then
									v1201 = v724.Text;
									v1202 = v1201:gsub("[^%d]", "");
									v1200 = 2 - 1;
								end
								if (v1200 == 1) then
									if (v1202 ~= v1201) then
										v724.Text = v1202;
									end
									break;
								end
							end
							break;
						end
					end
				end);
				break;
			end
			if (v726 == 0) then
				v724.FocusLost:Connect(function()
					local v1203 = 0 + 0;
					local v1204;
					while true do
						if (v1203 == (0 - 0)) then
							v1204 = tonumber(v724.Text);
							if v1204 then
								local v1512 = {r=v6[v419.key].r,g=v6[v419.key].g,b=v6[v419.key].b};
								v1512[v725] = math.clamp(math.floor(v1204), 0 + 0, 425 - 170);
								v569(v1512);
							else
								v724.Text = tostring(v6[v419.key][v725]);
							end
							break;
						end
					end
				end);
				v724.Focused:Connect(function()
					v2:Create(v724, v35, {BackgroundColor3=v33.accent}):Play();
				end);
				v726 = 1596 - (210 + 1385);
			end
		end
	end
	v570(v490, "r");
	v570(v519, "g");
	v570(v546, "b");
	return v421;
end
local function v176(v571, v572)
	local v573 = 1689 - (1201 + 488);
	local v574;
	local v575;
	local v576;
	local v577;
	local v578;
	local v579;
	local v580;
	local v581;
	while true do
		if (v573 == 4) then
			v577.Position = UDim2.new(0, 10 + 5, 0 - 0, 44 - 19);
			v577.BackgroundTransparency = 586 - (352 + 233);
			v577.Text = v571.desc;
			v577.TextColor3 = v33.textSecondary;
			v577.TextSize = 24 - 14;
			v577.Font = Enum.Font.Gotham;
			v573 = 3 + 2;
		end
		if ((14 - 9) == v573) then
			v577.TextXAlignment = Enum.TextXAlignment.Left;
			v577.ZIndex = 579 - (489 + 85);
			v577.Parent = v574;
			v578 = Instance.new("TextButton");
			v578.Size = UDim2.new(1501 - (277 + 1224), 1613 - (663 + 830), 0 + 0, 25);
			v578.Position = UDim2.new(0 - 0, 15, 875 - (461 + 414), 8 + 37);
			v573 = 6;
		end
		if (11 == v573) then
			v578.MouseButton1Click:Connect(function()
				local v1162 = 0 + 0;
				local v1163;
				while true do
					if (v1162 == 0) then
						local v1370 = 0 + 0;
						while true do
							if (v1370 == 1) then
								v1162 = 1 + 0;
								break;
							end
							if (v1370 == (250 - (172 + 78))) then
								v1163 = v31();
								v580.Text = v1163;
								v1370 = 1 - 0;
							end
						end
					end
					if (v1162 == (1 + 0)) then
						if setclipboard then
							local v1475 = 0 - 0;
							while true do
								if (v1475 == 0) then
									setclipboard(v1163);
									if v15 then
										local v1681 = 0 + 0;
										local v1682;
										while true do
											if (v1681 == 0) then
												v1682 = 0;
												while true do
													if (v1682 == (0 + 0)) then
														v15.Text = "Code generated and copied to clipboard!";
														v15.TextColor3 = v33.success;
														break;
													end
												end
												break;
											end
										end
									end
									break;
								end
							end
						elseif v15 then
							local v1580 = 0 - 0;
							local v1581;
							while true do
								if (v1580 == 0) then
									v1581 = 0 - 0;
									while true do
										if ((0 + 0) == v1581) then
											v15.Text = "Code generated! Copy it manually.";
											v15.TextColor3 = v33.success;
											break;
										end
									end
									break;
								end
							end
						end
						break;
					end
				end
			end);
			return v574;
		end
		if (v573 == (2 + 0)) then
			v576.Size = UDim2.new(1 + 0, -20, 0, 79 - 59);
			v576.Position = UDim2.new(0 - 0, 15, 0 + 0, 5 + 3);
			v576.BackgroundTransparency = 448 - (133 + 314);
			v576.Text = v571.name;
			v576.TextColor3 = v33.text;
			v576.TextSize = 14;
			v573 = 1 + 2;
		end
		if (v573 == 7) then
			v578.ZIndex = 5;
			v578.Parent = v574;
			v579 = Instance.new("UICorner");
			v579.CornerRadius = UDim.new(213 - (199 + 14), 14 - 10);
			v579.Parent = v578;
			v580 = Instance.new("TextBox");
			v573 = 8;
		end
		if (v573 == (1552 - (647 + 902))) then
			v576.Font = Enum.Font.GothamSemibold;
			v576.TextXAlignment = Enum.TextXAlignment.Left;
			v576.ZIndex = 15 - 10;
			v576.Parent = v574;
			v577 = Instance.new("TextLabel");
			v577.Size = UDim2.new(234 - (85 + 148), -(1309 - (426 + 863)), 0, 70 - 55);
			v573 = 1658 - (873 + 781);
		end
		if (v573 == (13 - 3)) then
			v580.ZIndex = 13 - 8;
			v580.Parent = v574;
			v581 = Instance.new("UICorner");
			v581.CornerRadius = UDim.new(0 + 0, 14 - 10);
			v581.Parent = v580;
			v14 = v580;
			v573 = 11;
		end
		if (v573 == 0) then
			v574 = Instance.new("Frame");
			v574.Name = "CodeGeneratorContainer";
			v574.Size = UDim2.new(1 - 0, -(59 - 39), 0, 2067 - (414 + 1533));
			v574.Position = UDim2.new(0 + 0, 565 - (443 + 112), 0, v572);
			v574.BackgroundColor3 = v33.secondary;
			v574.BorderSizePixel = 1479 - (888 + 591);
			v573 = 2 - 1;
		end
		if (v573 == (1 + 5)) then
			v578.BackgroundColor3 = v33.accent;
			v578.BorderSizePixel = 0 - 0;
			v578.Text = "🎯 Generate Code";
			v578.TextColor3 = v33.text;
			v578.TextSize = 5 + 7;
			v578.Font = Enum.Font.GothamSemibold;
			v573 = 4 + 3;
		end
		if (v573 == (1 + 7)) then
			v580.Size = UDim2.new(1, -(57 - 27), 0, 35);
			v580.Position = UDim2.new(0, 27 - 12, 1678 - (136 + 1542), 245 - 170);
			v580.BackgroundColor3 = v33.border;
			v580.BorderSizePixel = 0 + 0;
			v580.Text = "Click 'Generate Code' to create your config code";
			v580.TextColor3 = v33.text;
			v573 = 9;
		end
		if (v573 == 1) then
			v574.ZIndex = 7 - 2;
			v574.Parent = v160;
			v575 = Instance.new("UICorner");
			v575.CornerRadius = UDim.new(0 + 0, 494 - (68 + 418));
			v575.Parent = v574;
			v576 = Instance.new("TextLabel");
			v573 = 4 - 2;
		end
		if (v573 == (15 - 6)) then
			v580.TextSize = 10;
			v580.Font = Enum.Font.Gotham;
			v580.TextXAlignment = Enum.TextXAlignment.Left;
			v580.TextYAlignment = Enum.TextYAlignment.Center;
			v580.TextWrapped = true;
			v580.ClearTextOnFocus = false;
			v573 = 9 + 1;
		end
	end
end
local function v177(v582, v583)
	local v584 = 1092 - (770 + 322);
	local v585;
	local v586;
	local v587;
	local v588;
	local v589;
	while true do
		if (v584 == 4) then
			v588.Position = UDim2.new(0 + 0, 15, 0, 8 + 17);
			v588.BackgroundTransparency = 1;
			v588.Text = v582.desc;
			v588.TextColor3 = v33.textSecondary;
			v588.TextSize = 2 + 8;
			v588.Font = Enum.Font.Gotham;
			v584 = 5;
		end
		if (v584 == 5) then
			local v981 = 0 - 0;
			while true do
				if (2 == v981) then
					for v1371, v1372 in ipairs(v589) do
						local v1373 = 0;
						local v1374;
						local v1375;
						local v1376;
						while true do
							if (v1373 == (9 - 4)) then
								v1376.Size = UDim2.new(0, 245 - 155, 0 - 0, 15);
								v1376.Position = UDim2.new(0 + 0, (22 - 7) + (((v1371 - (1 + 0)) % (2 + 1)) * 95), 0 + 0, (338 - 248) + (math.floor((v1371 - 1) / (3 - 0)) * (9 + 16)));
								v1376.BackgroundTransparency = 1;
								v1373 = 27 - 21;
							end
							if (v1373 == (19 - 13)) then
								v1376.Text = v1372.desc;
								v1376.TextColor3 = v33.textSecondary;
								v1376.TextSize = 4 + 4;
								v1373 = 34 - 27;
							end
							if (v1373 == (840 - (762 + 69))) then
								v1374.MouseLeave:Connect(function()
									v2:Create(v1374, v35, {Size=UDim2.new(0 - 0, 78 + 12, 0, 13 + 7)}):Play();
								end);
								break;
							end
							if ((2 - 1) == v1373) then
								local v1524 = 0 + 0;
								while true do
									if (v1524 == (0 + 0)) then
										v1374.BackgroundColor3 = v1372.color;
										v1374.BorderSizePixel = 0;
										v1524 = 3 - 2;
									end
									if ((158 - (8 + 149)) == v1524) then
										v1374.Text = v1372.code;
										v1373 = 1322 - (1199 + 121);
										break;
									end
								end
							end
							if (v1373 == (3 - 1)) then
								v1374.TextColor3 = v33.text;
								v1374.TextSize = 10;
								v1374.Font = Enum.Font.GothamSemibold;
								v1373 = 6 - 3;
							end
							if (v1373 == 4) then
								v1375.CornerRadius = UDim.new(0 + 0, 13 - 9);
								v1375.Parent = v1374;
								v1376 = Instance.new("TextLabel");
								v1373 = 11 - 6;
							end
							if (v1373 == 7) then
								v1376.Font = Enum.Font.Gotham;
								v1376.TextXAlignment = Enum.TextXAlignment.Center;
								v1376.ZIndex = 5 + 0;
								v1373 = 8;
							end
							if (8 == v1373) then
								local v1537 = 0;
								while true do
									if (v1537 == (1808 - (518 + 1289))) then
										v1374.MouseEnter:Connect(function()
											v2:Create(v1374, v35, {Size=UDim2.new(0 - 0, 13 + 82, 0 - 0, 17 + 5)}):Play();
										end);
										v1373 = 9;
										break;
									end
									if (v1537 == (469 - (304 + 165))) then
										v1376.Parent = v585;
										v1374.MouseButton1Click:Connect(function()
											local v1683 = 0 + 0;
											local v1684;
											local v1685;
											while true do
												if (0 == v1683) then
													v1684, v1685 = v32(v1372.code);
													if v15 then
														local v1816 = 160 - (54 + 106);
														local v1817;
														while true do
															if (v1816 == 0) then
																v1817 = 1969 - (1618 + 351);
																while true do
																	if (v1817 == (0 + 0)) then
																		v15.Text = v1685;
																		v15.TextColor3 = (v1684 and v33.success) or v33.danger;
																		break;
																	end
																end
																break;
															end
														end
													end
													break;
												end
											end
										end);
										v1537 = 1;
									end
								end
							end
							if (v1373 == (1016 - (10 + 1006))) then
								local v1538 = 0 + 0;
								while true do
									if (v1538 == (1 + 0)) then
										v1374.Position = UDim2.new(0, 15 + (((v1371 - (3 - 2)) % (1036 - (912 + 121))) * (45 + 50)), 1289 - (1140 + 149), 29 + 16 + (math.floor((v1371 - (1 - 0)) / (1 + 2)) * (85 - 60)));
										v1373 = 1;
										break;
									end
									if (v1538 == (0 - 0)) then
										v1374 = Instance.new("TextButton");
										v1374.Size = UDim2.new(0 + 0, 90, 0 - 0, 20);
										v1538 = 1;
									end
								end
							end
							if (v1373 == (189 - (165 + 21))) then
								v1374.ZIndex = 5;
								v1374.Parent = v585;
								v1375 = Instance.new("UICorner");
								v1373 = 115 - (61 + 50);
							end
						end
					end
					return v585;
				end
				if (v981 == 1) then
					v588.Parent = v585;
					v589 = {{code="COMBAT",desc="Combat focused setup",color=v33.danger},{code="VISUAL",desc="Visual effects setup",color=v33.accent},{code="STEALTH",desc="Minimal visibility setup",color=Color3.fromRGB(100, 100, 476 - 376)},{code="RAINBOW",desc="Full effects setup",color=Color3.fromRGB(101 + 154, 1560 - (1295 + 165), 255)},{code="MINIMAL",desc="Performance focused",color=v33.success}};
					v981 = 2;
				end
				if (v981 == (0 + 0)) then
					v588.TextXAlignment = Enum.TextXAlignment.Left;
					v588.ZIndex = 1402 - (819 + 578);
					v981 = 1403 - (331 + 1071);
				end
			end
		end
		if (v584 == (745 - (588 + 155))) then
			v587.Size = UDim2.new(1283 - (546 + 736), -(1957 - (1834 + 103)), 0 + 0, 20);
			v587.Position = UDim2.new(0, 15, 0 - 0, 1774 - (1536 + 230));
			v587.BackgroundTransparency = 492 - (128 + 363);
			v587.Text = v582.name;
			v587.TextColor3 = v33.text;
			v587.TextSize = 14;
			v584 = 1 + 2;
		end
		if (v584 == (7 - 4)) then
			v587.Font = Enum.Font.GothamSemibold;
			v587.TextXAlignment = Enum.TextXAlignment.Left;
			v587.ZIndex = 2 + 3;
			v587.Parent = v585;
			v588 = Instance.new("TextLabel");
			v588.Size = UDim2.new(1, -20, 0 - 0, 44 - 29);
			v584 = 9 - 5;
		end
		if (v584 == (1 + 0)) then
			v585.ZIndex = 5;
			v585.Parent = v160;
			v586 = Instance.new("UICorner");
			v586.CornerRadius = UDim.new(1009 - (615 + 394), 8 + 0);
			v586.Parent = v585;
			v587 = Instance.new("TextLabel");
			v584 = 2 + 0;
		end
		if ((0 - 0) == v584) then
			v585 = Instance.new("Frame");
			v585.Name = "PredefinedCodesContainer";
			v585.Size = UDim2.new(4 - 3, -(671 - (59 + 592)), 0, 309 - 169);
			v585.Position = UDim2.new(0 - 0, 10, 0 + 0, v583);
			v585.BackgroundColor3 = v33.secondary;
			v585.BorderSizePixel = 171 - (70 + 101);
			v584 = 2 - 1;
		end
	end
end
local function v178(v590, v591)
	local v592 = 0 + 0;
	local v593;
	local v594;
	local v595;
	local v596;
	local v597;
	local v598;
	local v599;
	local v600;
	local v601;
	while true do
		local v727 = 0 - 0;
		while true do
			if (v727 == 2) then
				if (v592 == (241 - (123 + 118))) then
					v593 = Instance.new("Frame");
					v593.Name = "CodeInputContainer";
					v593.Size = UDim2.new(1 + 0, -(1 + 19), 1399 - (653 + 746), 224 - 104);
					v593.Position = UDim2.new(0 - 0, 10, 0, v591);
					v593.BackgroundColor3 = v33.secondary;
					v593.BorderSizePixel = 0 - 0;
					v592 = 1 + 0;
				end
				if (v592 == (4 + 2)) then
					v597.BackgroundColor3 = v33.border;
					v597.BorderSizePixel = 0 + 0;
					v597.Text = "";
					v597.TextColor3 = v33.text;
					v597.TextSize = 2 + 9;
					v597.Font = Enum.Font.Gotham;
					v592 = 2 + 5;
				end
				if (9 == v592) then
					v599.Position = UDim2.new(2 - 1, -(110 + 5), 0, 82 - 37);
					v599.BackgroundColor3 = v33.success;
					v599.BorderSizePixel = 0;
					v599.Text = "📥 Load Code";
					v599.TextColor3 = v33.text;
					v599.TextSize = 1246 - (885 + 349);
					v592 = 8 + 2;
				end
				v727 = 8 - 5;
			end
			if (v727 == 3) then
				if (v592 == 10) then
					v599.Font = Enum.Font.GothamSemibold;
					v599.ZIndex = 14 - 9;
					v599.Parent = v593;
					v600 = Instance.new("UICorner");
					v600.CornerRadius = UDim.new(0, 972 - (915 + 53));
					v600.Parent = v599;
					v592 = 812 - (768 + 33);
				end
				if (v592 == 8) then
					v597.Parent = v593;
					v598 = Instance.new("UICorner");
					v598.CornerRadius = UDim.new(0, 4);
					v598.Parent = v597;
					v599 = Instance.new("TextButton");
					v599.Size = UDim2.new(0, 382 - 282, 0, 61 - 26);
					v592 = 9;
				end
				if (v592 == 13) then
					v15 = v601;
					v599.MouseButton1Click:Connect(function()
						if (v597.Text == "") then
							local v1476 = 328 - (287 + 41);
							while true do
								if (v1476 == (847 - (638 + 209))) then
									v601.Text = "Please paste a code first!";
									v601.TextColor3 = v33.danger;
									break;
								end
							end
						else
							local v1477 = 0;
							local v1478;
							local v1479;
							while true do
								if (v1477 == 1) then
									v601.TextColor3 = (v1478 and v33.success) or v33.danger;
									if v1478 then
										v597.Text = "";
									end
									break;
								end
								if (v1477 == (0 + 0)) then
									v1478, v1479 = v32(v597.Text);
									v601.Text = v1479;
									v1477 = 1687 - (96 + 1590);
								end
							end
						end
					end);
					v597.Focused:Connect(function()
						v2:Create(v597, v35, {BackgroundColor3=v33.accent}):Play();
					end);
					v597.FocusLost:Connect(function()
						v2:Create(v597, v35, {BackgroundColor3=v33.border}):Play();
					end);
					return v593;
				end
				v727 = 4;
			end
			if (v727 == (1676 - (741 + 931))) then
				if (v592 == (2 + 1)) then
					v595.Font = Enum.Font.GothamSemibold;
					v595.TextXAlignment = Enum.TextXAlignment.Left;
					v595.ZIndex = 5;
					v595.Parent = v593;
					v596 = Instance.new("TextLabel");
					v596.Size = UDim2.new(1, -(56 - 36), 0, 70 - 55);
					v592 = 4;
				end
				if (v592 == (3 + 2)) then
					v596.TextXAlignment = Enum.TextXAlignment.Left;
					v596.ZIndex = 3 + 2;
					v596.Parent = v593;
					v597 = Instance.new("TextBox");
					v597.Size = UDim2.new(1 + 0, -(493 - 363), 0 + 0, 18 + 17);
					v597.Position = UDim2.new(0 - 0, 14 + 1, 494 - (64 + 430), 45 + 0);
					v592 = 369 - (106 + 257);
				end
				break;
			end
			if (v727 == 0) then
				if (v592 == (9 + 3)) then
					v601.TextSize = 731 - (496 + 225);
					v601.Font = Enum.Font.Gotham;
					v601.TextXAlignment = Enum.TextXAlignment.Left;
					v601.ZIndex = 5;
					v601.Parent = v593;
					v13 = v597;
					v592 = 13;
				end
				if (v592 == (1 - 0)) then
					v593.ZIndex = 5;
					v593.Parent = v160;
					v594 = Instance.new("UICorner");
					v594.CornerRadius = UDim.new(0 - 0, 1666 - (256 + 1402));
					v594.Parent = v593;
					v595 = Instance.new("TextLabel");
					v592 = 2;
				end
				if (v592 == 11) then
					v601 = Instance.new("TextLabel");
					v601.Size = UDim2.new(1900 - (30 + 1869), -(1399 - (213 + 1156)), 188 - (96 + 92), 3 + 12);
					v601.Position = UDim2.new(0, 914 - (142 + 757), 0 + 0, 37 + 53);
					v601.BackgroundTransparency = 80 - (32 + 47);
					v601.Text = "Ready to load codes";
					v601.TextColor3 = v33.textSecondary;
					v592 = 1989 - (1053 + 924);
				end
				v727 = 1 + 0;
			end
			if (v727 == 1) then
				if (v592 == (11 - 4)) then
					v597.TextXAlignment = Enum.TextXAlignment.Left;
					v597.TextYAlignment = Enum.TextYAlignment.Center;
					v597.PlaceholderText = "Paste your code here...";
					v597.PlaceholderColor3 = v33.textSecondary;
					v597.TextWrapped = true;
					v597.ZIndex = 5;
					v592 = 8;
				end
				if (v592 == (1652 - (685 + 963))) then
					v596.Position = UDim2.new(0 - 0, 22 - 7, 1709 - (541 + 1168), 1622 - (645 + 952));
					v596.BackgroundTransparency = 839 - (669 + 169);
					v596.Text = v590.desc;
					v596.TextColor3 = v33.textSecondary;
					v596.TextSize = 34 - 24;
					v596.Font = Enum.Font.Gotham;
					v592 = 10 - 5;
				end
				if (2 == v592) then
					v595.Size = UDim2.new(1 + 0, -(5 + 15), 765 - (181 + 584), 1415 - (665 + 730));
					v595.Position = UDim2.new(0, 43 - 28, 0, 16 - 8);
					v595.BackgroundTransparency = 1351 - (540 + 810);
					v595.Text = v590.name;
					v595.TextColor3 = v33.text;
					v595.TextSize = 55 - 41;
					v592 = 3;
				end
				v727 = 5 - 3;
			end
		end
	end
end
local v179 = {};
for v602, v603 in ipairs(v159) do
	local v604 = 0;
	local v605;
	local v606;
	local v607;
	local v608;
	while true do
		if (v604 == (4 + 1)) then
			v607.ZIndex = 208 - (166 + 37);
			v607.Parent = v605;
			v608 = Instance.new("TextLabel");
			v608.Size = UDim2.new(1882 - (22 + 1859), -(1812 - (843 + 929)), 0, 277 - (30 + 232));
			v604 = 17 - 11;
		end
		if (v604 == (786 - (55 + 722))) then
			v605.MouseLeave:Connect(function()
				if (v603.name ~= v17.activeTab) then
					v2:Create(v605, v35, {BackgroundColor3=Color3.fromRGB(45, 96 - 51, 1730 - (78 + 1597))}):Play();
				end
			end);
			break;
		end
		if (v604 == 6) then
			v608.Position = UDim2.new(0 + 0, 10 + 0, 0 + 0, 574 - (305 + 244));
			v608.BackgroundTransparency = 1;
			v608.Text = v603.name;
			v608.TextColor3 = v33.text;
			v604 = 7;
		end
		if (v604 == (1 + 0)) then
			v605.BackgroundColor3 = ((v603.name == v17.activeTab) and v33.accent) or Color3.fromRGB(150 - (95 + 10), 32 + 13, 174 - 119);
			v605.BorderSizePixel = 0;
			v605.Text = "";
			v605.ZIndex = 5;
			v604 = 2 - 0;
		end
		if (v604 == (762 - (592 + 170))) then
			v605 = Instance.new("TextButton");
			v605.Name = v603.name .. "Tab";
			v605.Size = UDim2.new(1, -10, 0 - 0, 113 - 68);
			v605.Position = UDim2.new(0 + 0, 2 + 3, 0, (24 - 14) + ((v602 - (1 + 0)) * (92 - 42)));
			v604 = 508 - (353 + 154);
		end
		if (v604 == (2 - 0)) then
			v605.Parent = v151;
			v606 = Instance.new("UICorner");
			v606.CornerRadius = UDim.new(0 - 0, 6 + 2);
			v606.Parent = v605;
			v604 = 3;
		end
		if (v604 == 8) then
			v608.Parent = v605;
			v179[v603.name] = v605;
			v605.MouseButton1Click:Connect(function()
				switchTab(v603.name);
			end);
			v605.MouseEnter:Connect(function()
				if (v603.name ~= v17.activeTab) then
					v2:Create(v605, v35, {BackgroundColor3=Color3.fromRGB(44 + 11, 55, 43 + 22)}):Play();
				end
			end);
			v604 = 9;
		end
		if (v604 == (5 - 1)) then
			v607.Text = v603.icon;
			v607.TextColor3 = v33.text;
			v607.TextSize = 30 - 14;
			v607.Font = Enum.Font.Gotham;
			v604 = 11 - 6;
		end
		if ((93 - (7 + 79)) == v604) then
			v608.TextSize = 6 + 5;
			v608.Font = Enum.Font.Gotham;
			v608.TextXAlignment = Enum.TextXAlignment.Left;
			v608.ZIndex = 186 - (24 + 157);
			v604 = 8;
		end
		if (v604 == 3) then
			v607 = Instance.new("TextLabel");
			v607.Size = UDim2.new(0, 39 - 19, 0 - 0, 6 + 14);
			v607.Position = UDim2.new(0 - 0, 10, 0, 385 - (262 + 118));
			v607.BackgroundTransparency = 1084 - (1038 + 45);
			v604 = 4;
		end
	end
end
function switchTab(v609)
	local v610 = 0;
	local v611;
	local v612;
	while true do
		if (v610 == (5 - 2)) then
			if (v609 == "Saves") then
				local v1205 = 230 - (19 + 211);
				local v1206;
				while true do
					if (v1205 == (113 - (88 + 25))) then
						v1206 = 25 - 15;
						for v1480, v1481 in ipairs(v611.features) do
							if (v1481.type == "code_generator") then
								local v1582 = 0 + 0;
								local v1583;
								while true do
									if (v1582 == (0 + 0)) then
										v1583 = 1036 - (1007 + 29);
										while true do
											if (v1583 == (0 + 0)) then
												v176(v1481, v1206);
												v1206 = v1206 + (317 - 187);
												break;
											end
										end
										break;
									end
								end
							elseif (v1481.type == "predefined_codes") then
								local v1655 = 0 - 0;
								while true do
									if (v1655 == 0) then
										v177(v1481, v1206);
										v1206 = v1206 + 34 + 116;
										break;
									end
								end
							elseif (v1481.type == "code_input") then
								local v1716 = 811 - (340 + 471);
								local v1717;
								while true do
									if (v1716 == (0 - 0)) then
										v1717 = 589 - (276 + 313);
										while true do
											if (v1717 == (0 - 0)) then
												v178(v1481, v1206);
												v1206 = v1206 + 130;
												break;
											end
										end
										break;
									end
								end
							end
						end
						v1205 = 1;
					end
					if ((1 + 0) == v1205) then
						local v1443 = 0 + 0;
						while true do
							if (v1443 == 0) then
								v160.CanvasSize = UDim2.new(0 + 0, 1972 - (495 + 1477), 0, v1206 + (59 - 39));
								return;
							end
						end
					end
				end
			end
			v612 = 7 + 3;
			v610 = 407 - (342 + 61);
		end
		if (v610 == (0 + 0)) then
			v17.activeTab = v609;
			for v1164, v1165 in pairs(v179) do
				local v1166 = 0;
				local v1167;
				local v1168;
				local v1169;
				while true do
					if (v1166 == (166 - (4 + 161))) then
						v1169 = nil;
						while true do
							if (v1167 == (1 + 0)) then
								v2:Create(v1165, v35, {BackgroundColor3=v1169}):Play();
								break;
							end
							if (v1167 == (0 - 0)) then
								v1168 = v1164 == v609;
								v1169 = (v1168 and v33.accent) or Color3.fromRGB(118 - 73, 45, 552 - (322 + 175));
								v1167 = 564 - (173 + 390);
							end
						end
						break;
					end
					if (v1166 == 0) then
						v1167 = 0 + 0;
						v1168 = nil;
						v1166 = 315 - (203 + 111);
					end
				end
			end
			v610 = 1 + 0;
		end
		if (v610 == (1 + 0)) then
			for v1170, v1171 in pairs(v160:GetChildren()) do
				if v1171:IsA("Frame") then
					v1171:Destroy();
				end
			end
			v611 = nil;
			v610 = 5 - 3;
		end
		if (v610 == 4) then
			for v1172, v1173 in ipairs(v611.features) do
				if (v1173.type == "toggle") then
					local v1320 = 0 + 0;
					while true do
						if (v1320 == (706 - (57 + 649))) then
							v172(v1173, v612);
							v612 = v612 + (454 - (328 + 56));
							break;
						end
					end
				elseif (v1173.type == "slider") then
					local v1444 = 0 + 0;
					while true do
						if ((512 - (433 + 79)) == v1444) then
							v173(v1173, v612);
							v612 = v612 + 8 + 72;
							break;
						end
					end
				elseif (v1173.type == "colorpicker") then
					local v1541 = 0 + 0;
					while true do
						if (v1541 == (0 - 0)) then
							v175(v1173, v612);
							v612 = v612 + (567 - 447);
							break;
						end
					end
				elseif (v1173.type == "dropdown") then
					local v1610 = 0 + 0;
					while true do
						if ((0 + 0) == v1610) then
							v174(v1173, v612);
							v612 = v612 + 80;
							break;
						end
					end
				end
			end
			v160.CanvasSize = UDim2.new(1036 - (562 + 474), 0 - 0, 0 - 0, v612 + (925 - (76 + 829)));
			break;
		end
		if (v610 == (1675 - (1506 + 167))) then
			for v1174, v1175 in ipairs(v159) do
				if (v1175.name == v609) then
					v611 = v1175;
					break;
				end
			end
			if not v611 then
				return;
			end
			v610 = 3;
		end
	end
end
local v180 = Instance.new("TextButton");
v180.Name = "FloatingToggle";
v180.Size = UDim2.new(0 - 0, 326 - (58 + 208), 0 + 0, 43 + 17);
v180.Position = UDim2.new(0 + 0, 81 - 61, 337 - (258 + 79), 3 + 17);
v180.BackgroundColor3 = v33.accent;
v180.BorderSizePixel = 0;
v180.Text = "⚡";
v180.TextColor3 = v33.text;
v180.TextSize = 24;
v180.Font = Enum.Font.GothamBold;
v180.ZIndex = 21 - 11;
v180.Parent = v18;
local v192 = Instance.new("UICorner");
v192.CornerRadius = UDim.new(1, 0);
v192.Parent = v180;
local v195 = Instance.new("ImageLabel");
v195.Name = "Glow";
v195.AnchorPoint = Vector2.new(0.5, 0.5);
v195.BackgroundTransparency = 1471 - (1219 + 251);
v195.Position = UDim2.new(1671.5 - (1231 + 440), 58 - (34 + 24), 0.5, 0 + 0);
v195.Size = UDim2.new(1 - 0, 9 + 11, 1, 60 - 40);
v195.Image = "rbxasset://textures/ui/Controls/DropShadow.png";
v195.ImageColor3 = v33.accent;
v195.ImageTransparency = 0.3 - 0;
v195.ScaleType = Enum.ScaleType.Slice;
v195.SliceCenter = Rect.new(31 - 19, 39 - 27, 25 - 13, 1601 - (877 + 712));
v195.ZIndex = v180.ZIndex - (1 + 0);
v195.Parent = v180;
v180.MouseEnter:Connect(function()
	v2:Create(v180, v35, {Size=UDim2.new(0, 819 - (242 + 512), 0, 135 - 70),BackgroundColor3=v33.accentHover}):Play();
end);
v180.MouseLeave:Connect(function()
	v2:Create(v180, v35, {Size=UDim2.new(0, 687 - (92 + 535), 0 + 0, 60),BackgroundColor3=v33.accent}):Play();
end);
v180.MouseButton1Click:Connect(function()
	local v613 = 0 - 0;
	while true do
		if (v613 == (0 + 0)) then
			v17.isOpen = not v17.isOpen;
			if v17.isOpen then
				v36.Visible = true;
				switchTab(v17.activeTab);
				v2:Create(v36, v34, {Size=UDim2.new(0 - 0, 569 + 11, 0 + 0, 400),Position=UDim2.new(0.5 + 0, -290, 0.5 - 0, -200)}):Play();
				v180.Text = "✕";
			else
				local v1209 = 0;
				while true do
					if (v1209 == 1) then
						v180.Text = "⚡";
						break;
					end
					if (v1209 == (0 - 0)) then
						v2:Create(v36, v34, {Size=UDim2.new(1785 - (1476 + 309), 1284 - (299 + 985), 0 + 0, 0),Position=UDim2.new(0.5, 0 - 0, 93.5 - (86 + 7), 0 - 0)}):Play();
						spawn(function()
							local v1482 = 0 + 0;
							local v1483;
							while true do
								if (v1482 == (880 - (672 + 208))) then
									v1483 = 0 + 0;
									while true do
										if ((132 - (14 + 118)) == v1483) then
											wait(0.3);
											v36.Visible = false;
											break;
										end
									end
									break;
								end
							end
						end);
						v1209 = 1;
					end
				end
			end
			break;
		end
	end
end);
v112.MouseButton1Click:Connect(function()
	local v614 = 445 - (339 + 106);
	while true do
		if (0 == v614) then
			v17.isOpen = false;
			v2:Create(v36, v34, {Size=UDim2.new(0, 0 + 0, 0 + 0, 1395 - (440 + 955)),Position=UDim2.new(0.5 + 0, 0, 0.5 - 0, 0 + 0)}):Play();
			v614 = 2 - 1;
		end
		if ((1 + 0) == v614) then
			spawn(function()
				local v1176 = 353 - (260 + 93);
				while true do
					if (v1176 == 0) then
						wait(0.3 + 0);
						v36.Visible = false;
						break;
					end
				end
			end);
			v180.Text = "⚡";
			break;
		end
	end
end);
local v208 = false;
v128.MouseButton1Click:Connect(function()
	local v615 = 0;
	while true do
		if (v615 == 0) then
			v208 = not v208;
			if v208 then
				local v1210 = 0 - 0;
				while true do
					if (v1210 == (0 - 0)) then
						v2:Create(v36, v34, {Size=UDim2.new(0, 580, 1974 - (1181 + 793), 50)}):Play();
						v128.Text = "+";
						break;
					end
				end
			else
				local v1211 = 0;
				while true do
					if (v1211 == 0) then
						v2:Create(v36, v34, {Size=UDim2.new(0 + 0, 580, 0, 400)}):Play();
						v128.Text = "−";
						break;
					end
				end
			end
			break;
		end
	end
end);
local function v209(v616)
	local v617 = 0;
	local v618;
	local v619;
	local v620;
	while true do
		if (v617 == (309 - (105 + 202))) then
			v3.InputChanged:Connect(function(v1177)
				if (v618 and (v1177.UserInputType == Enum.UserInputType.MouseMovement)) then
					local v1321 = 0;
					local v1322;
					while true do
						if (v1321 == (0 + 0)) then
							v1322 = v1177.Position - v619;
							v616.Position = UDim2.new(v620.X.Scale, v620.X.Offset + v1322.X, v620.Y.Scale, v620.Y.Offset + v1322.Y);
							break;
						end
					end
				end
			end);
			v3.InputEnded:Connect(function(v1178)
				if (v1178.UserInputType == Enum.UserInputType.MouseButton1) then
					v618 = false;
				end
			end);
			break;
		end
		if (v617 == (810 - (352 + 458))) then
			v618 = false;
			v619 = nil;
			v617 = 3 - 2;
		end
		if (v617 == (2 - 1)) then
			v620 = nil;
			v64.InputBegan:Connect(function(v1179)
				if (v1179.UserInputType == Enum.UserInputType.MouseButton1) then
					local v1323 = 0;
					local v1324;
					while true do
						if (v1323 == (0 + 0)) then
							v1324 = 0;
							while true do
								if (v1324 == (0 - 0)) then
									v618 = true;
									v619 = v1179.Position;
									v1324 = 1;
								end
								if (v1324 == (950 - (438 + 511))) then
									v620 = v616.Position;
									break;
								end
							end
							break;
						end
					end
				end
			end);
			v617 = 1385 - (1262 + 121);
		end
	end
end
v209(v36);
local v210 = Instance.new("TextLabel");
v210.Size = UDim2.new(1068 - (728 + 340), 2090 - (816 + 974), 0 - 0, 143 - 103);
v210.Position = UDim2.new(339 - (163 + 176), 28 - 18, 0 - 0, 70);
v210.BackgroundColor3 = Color3.new(0 + 0, 1810 - (1564 + 246), 0);
v210.BackgroundTransparency = 345.3 - (124 + 221);
v210.TextColor3 = Color3.new(1, 1 + 0, 452 - (115 + 336));
v210.Text = "LOADING...";
v210.Font = Enum.Font.SourceSansBold;
v210.TextScaled = true;
v210.ZIndex = 1 - 0;
v210.Parent = v18;
local v222 = {};
for v621 = 1 + 0, 66 - (45 + 1) do
	local v622 = 0 + 0;
	local v623;
	while true do
		if (v622 == (1992 - (1282 + 708))) then
			v623.Visible = false;
			v623.ZIndex = 1213 - (583 + 629);
			v622 = 1 + 2;
		end
		if (v622 == (0 - 0)) then
			v623 = Instance.new("Frame");
			v623.Size = UDim2.new(0 + 0, 1173 - (943 + 227), 0, 3);
			v622 = 1 + 0;
		end
		if (v622 == 1) then
			v623.BackgroundColor3 = Color3.fromRGB(1631 - (1539 + 92), 2201 - (706 + 1240), 258 - (81 + 177));
			v623.BorderSizePixel = 0 - 0;
			v622 = 259 - (212 + 45);
		end
		if (v622 == (9 - 6)) then
			v623.Parent = v18;
			table.insert(v222, v623);
			break;
		end
	end
end
local v223 = {};
for v624 = 1947 - (708 + 1238), 1 + 9 do
	local v625 = Instance.new("Frame");
	v625.Size = UDim2.new(0, 20, 0 + 0, 1687 - (586 + 1081));
	v625.BackgroundColor3 = Color3.fromRGB(766 - (348 + 163), 0 + 0, 0);
	v625.BackgroundTransparency = 280.4 - (215 + 65);
	v625.BorderSizePixel = 0;
	v625.Visible = false;
	v625.ZIndex = 2 - 1;
	v625.Parent = v18;
	local v633 = Instance.new("UICorner");
	v633.CornerRadius = UDim.new(1, 1859 - (1541 + 318));
	v633.Parent = v625;
	table.insert(v223, v625);
end
local v224 = {};
for v636 = 1 + 0, 6 + 4 do
	local v637 = 0;
	local v638;
	local v639;
	local v640;
	local v641;
	local v642;
	while true do
		if (v637 == (1 + 0)) then
			v638.ZIndex = 1751 - (1036 + 714);
			v638.Parent = v18;
			v639 = Instance.new("Frame");
			v639.Name = "TopBorder";
			v637 = 2;
		end
		if (v637 == (2 + 0)) then
			v639.Size = UDim2.new(1, 0 + 0, 1280 - (883 + 397), 591 - (563 + 27));
			v639.Position = UDim2.new(0 - 0, 0, 1986 - (1369 + 617), 1487 - (85 + 1402));
			v639.BackgroundColor3 = Color3.fromRGB(88 + 167, 658 - 403, 403 - (274 + 129));
			v639.BorderSizePixel = 0;
			v637 = 220 - (12 + 205);
		end
		if (v637 == 9) then
			v642.ZIndex = 1 + 0;
			v642.Parent = v638;
			table.insert(v224, v638);
			break;
		end
		if (v637 == (0 - 0)) then
			v638 = Instance.new("Frame");
			v638.Size = UDim2.new(0 + 0, 434 - (27 + 357), 0, 550 - (91 + 389));
			v638.BackgroundTransparency = 1;
			v638.Visible = false;
			v637 = 298 - (90 + 207);
		end
		if (v637 == 8) then
			v642.Size = UDim2.new(0, 1 + 0, 862 - (706 + 155), 1795 - (730 + 1065));
			v642.Position = UDim2.new(1564 - (1339 + 224), -(1 + 0), 0 + 0, 0 - 0);
			v642.BackgroundColor3 = Color3.fromRGB(255, 255, 843 - (268 + 575));
			v642.BorderSizePixel = 1294 - (919 + 375);
			v637 = 24 - 15;
		end
		if (v637 == 6) then
			v641.Size = UDim2.new(971 - (180 + 791), 1806 - (323 + 1482), 1, 1918 - (1177 + 741));
			v641.Position = UDim2.new(0, 0 + 0, 0 - 0, 0 + 0);
			v641.BackgroundColor3 = Color3.fromRGB(255, 569 - 314, 0 + 0);
			v641.BorderSizePixel = 109 - (96 + 13);
			v637 = 7;
		end
		if (v637 == (1928 - (962 + 959))) then
			v641.ZIndex = 2 - 1;
			v641.Parent = v638;
			v642 = Instance.new("Frame");
			v642.Name = "RightBorder";
			v637 = 2 + 6;
		end
		if (v637 == (1355 - (461 + 890))) then
			v640.Size = UDim2.new(1 + 0, 0 - 0, 0, 1);
			v640.Position = UDim2.new(243 - (19 + 224), 0 + 0, 1, -(199 - (37 + 161)));
			v640.BackgroundColor3 = Color3.fromRGB(255, 92 + 163, 0);
			v640.BorderSizePixel = 0;
			v637 = 2 + 3;
		end
		if (v637 == (3 + 0)) then
			v639.ZIndex = 1;
			v639.Parent = v638;
			v640 = Instance.new("Frame");
			v640.Name = "BottomBorder";
			v637 = 4;
		end
		if (v637 == (66 - (60 + 1))) then
			v640.ZIndex = 1;
			v640.Parent = v638;
			v641 = Instance.new("Frame");
			v641.Name = "LeftBorder";
			v637 = 929 - (826 + 97);
		end
	end
end
local v225 = {};
for v643 = 1, 10 do
	local v644 = 0;
	local v645;
	while true do
		if (v644 == (0 + 0)) then
			v645 = Instance.new("TextLabel");
			v645.Size = UDim2.new(0 - 0, 164 - 84, 685 - (375 + 310), 20);
			v645.BackgroundTransparency = 1;
			v645.Text = "[0]";
			v644 = 2000 - (1864 + 135);
		end
		if ((2 - 1) == v644) then
			v645.TextColor3 = Color3.new(1, 1 + 0, 1 + 0);
			v645.Font = Enum.Font.SourceSansBold;
			v645.TextSize = 34 - 20;
			v645.TextStrokeTransparency = 0.5;
			v644 = 1133 - (314 + 817);
		end
		if (v644 == (2 + 1)) then
			table.insert(v225, v645);
			break;
		end
		if (v644 == 2) then
			v645.TextStrokeColor3 = Color3.new(0, 214 - (32 + 182), 0);
			v645.Visible = false;
			v645.ZIndex = 1 + 0;
			v645.Parent = v18;
			v644 = 10 - 7;
		end
	end
end
local v226 = {};
for v646 = 66 - (39 + 26), 147 - (54 + 90) do
	local v647 = 198 - (45 + 153);
	local v648;
	while true do
		if (v647 == (2 + 0)) then
			v648.ZIndex = 553 - (457 + 95);
			v648.Parent = v18;
			table.insert(v226, v648);
			break;
		end
		if (v647 == (1 + 0)) then
			v648.BackgroundTransparency = 0.5 - 0;
			v648.BorderSizePixel = 0;
			v648.Visible = false;
			v648.AnchorPoint = Vector2.new(0.5, 2 - 1);
			v647 = 2;
		end
		if (v647 == (0 - 0)) then
			v648 = Instance.new("Frame");
			v648.Size = UDim2.new(0 + 0, 3 - 2, 0 - 0, 100);
			v648.Position = UDim2.new(0.5, -(748.5 - (485 + 263)), 708 - (575 + 132), 861 - (750 + 111));
			v648.BackgroundColor3 = Color3.new(1011 - (445 + 565), 1 + 0, 1 + 0);
			v647 = 1 - 0;
		end
	end
end
local v227 = Instance.new("Frame");
v227.Size = UDim2.new(0, 200, 0, 67 + 133);
v227.Position = UDim2.new(310.5 - (189 + 121), -(25 + 75), 1347.41 - (634 + 713), -(638 - (493 + 45)));
v227.BackgroundTransparency = 1;
v227.BorderSizePixel = 0;
v227.Visible = false;
v227.ZIndex = 969 - (493 + 475);
v227.Parent = v18;
local v235 = Instance.new("UIStroke");
v235.Color = Color3.fromRGB(v6.fovCircleColor.r, v6.fovCircleColor.g, v6.fovCircleColor.b);
v235.Thickness = 1 + 1;
v235.Transparency = 784.3 - (158 + 626);
v235.Parent = v227;
local v240 = Instance.new("UICorner");
v240.CornerRadius = UDim.new(1 + 0, 0);
v240.Parent = v227;
local v243 = Instance.new("TextLabel");
v243.Size = UDim2.new(0 - 0, 78 + 272, 0, 40);
v243.Position = UDim2.new(0.5 + 0, -(1266 - (1035 + 56)), 0, -40);
v243.BackgroundTransparency = 960 - (114 + 845);
v243.Text = "— BIGHACK - PREMIUM [v1.0.0] —";
v243.TextColor3 = Color3.new(1 + 0, 0 - 0, 0);
v243.Font = Enum.Font.SourceSansBold;
v243.TextSize = 24;
v243.TextStrokeTransparency = 0.3 + 0;
v243.TextStrokeColor3 = Color3.new(0, 1049 - (179 + 870), 0 - 0);
v243.ZIndex = 879 - (827 + 51);
v243.Parent = v18;
local v255 = {};
local v256 = {};
local v257 = {};
local v258 = {};
local v259 = {};
local v260 = {};
local v261 = {};
local v262 = {};
local v263 = {};
local function v264(v649, v650, v651)
	local v652 = 0 - 0;
	local v653;
	local v654;
	local v655;
	local v656;
	local v657;
	local v658;
	local v659;
	local v660;
	while true do
		if (v652 == 3) then
			v656 = v656 % (4 + 2);
			if (v656 == (473 - (95 + 378))) then
				v653, v654, v655 = v651, v660, v658;
			elseif (v656 == (1 + 0)) then
				v653, v654, v655 = v659, v651, v658;
			elseif (v656 == 2) then
				v653, v654, v655 = v658, v651, v660;
			elseif (v656 == (4 - 1)) then
				v653, v654, v655 = v658, v659, v651;
			elseif (v656 == 4) then
				v653, v654, v655 = v660, v658, v651;
			elseif (v656 == 5) then
				v653, v654, v655 = v651, v658, v659;
			end
			v652 = 4 + 0;
		end
		if (v652 == (1013 - (334 + 677))) then
			v659 = v651 * (1 - (v657 * v650));
			v660 = v651 * ((3 - 2) - (((1057 - (1049 + 7)) - v657) * v650));
			v652 = 3;
		end
		if (v652 == (17 - 13)) then
			return v653, v654, v655;
		end
		if (v652 == (1 - 0)) then
			v657 = (v649 * 6) - v656;
			v658 = v651 * (1 - v650);
			v652 = 1 + 1;
		end
		if (v652 == (0 - 0)) then
			local v1109 = 0 - 0;
			while true do
				if (v1109 == (0 + 0)) then
					v653, v654, v655 = nil;
					v656 = math.floor(v649 * (1426 - (1004 + 416)));
					v1109 = 1;
				end
				if (v1109 == 1) then
					v652 = 1958 - (1621 + 336);
					break;
				end
			end
		end
	end
end
local function v265(v661)
	local v662 = 0;
	local v663;
	while true do
		if (v662 == 0) then
			if not v5.playerESP then
				local v1212 = 1939 - (337 + 1602);
				while true do
					local v1325 = 1517 - (1014 + 503);
					while true do
						if (v1325 == (1015 - (446 + 569))) then
							if (v1212 == (0 + 0)) then
								for v1613, v1614 in pairs(v255) do
									if (v1614 and v1614.Parent) then
										pcall(function()
											v1614:Destroy();
										end);
									end
								end
								v255 = {};
								v1212 = 1;
							end
							if (v1212 == (2 - 1)) then
								return;
							end
							break;
						end
					end
				end
			end
			v663 = {};
			v662 = 1 + 0;
		end
		if ((1 - 0) == v662) then
			for v1180, v1181 in ipairs(v661) do
				if (v1181.character and v1181.character.Parent) then
					local v1326 = 0 + 0;
					local v1327;
					while true do
						if ((505 - (223 + 282)) == v1326) then
							v663[v1181.character] = true;
							v1327 = false;
							v1326 = 1 + 0;
						end
						if (v1326 == 1) then
							if not v255[v1181.character] then
								v1327 = true;
							elseif not v255[v1181.character].Parent then
								v1327 = true;
							end
							if v1327 then
								local v1585 = 0 - 0;
								local v1586;
								local v1587;
								local v1588;
								while true do
									if (v1585 == (1 - 0)) then
										v1588 = nil;
										while true do
											if (v1586 == (671 - (623 + 47))) then
												if (v1587 and v1588) then
													v255[v1181.character] = v1588;
												end
												break;
											end
											if (v1586 == (45 - (32 + 13))) then
												if v255[v1181.character] then
													local v1819 = 0;
													local v1820;
													while true do
														if ((0 + 0) == v1819) then
															v1820 = 0 + 0;
															while true do
																if (v1820 == (1801 - (1070 + 731))) then
																	pcall(function()
																		v255[v1181.character]:Destroy();
																	end);
																	v255[v1181.character] = nil;
																	break;
																end
															end
															break;
														end
													end
												end
												v1587, v1588 = pcall(function()
													local v1783 = 0;
													local v1784;
													while true do
														if (v1783 == (0 + 0)) then
															v1784 = Instance.new("Highlight");
															v1784.FillColor = Color3.fromRGB(1404 - (1257 + 147), 102 + 153, 0);
															v1783 = 1 - 0;
														end
														if (v1783 == (134 - (98 + 35))) then
															v1784.FillTransparency = 0.3;
															v1784.OutlineColor = Color3.fromRGB(0 + 0, 708 - 508, 0 - 0);
															v1783 = 2;
														end
														if (v1783 == 3) then
															local v1845 = 0;
															while true do
																if (v1845 == (0 + 0)) then
																	v1784.Parent = v1181.character;
																	return v1784;
																end
															end
														end
														if (v1783 == (2 + 0)) then
															v1784.OutlineTransparency = 0;
															v1784.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
															v1783 = 3;
														end
													end
												end);
												v1586 = 1;
											end
										end
										break;
									end
									if (0 == v1585) then
										v1586 = 0;
										v1587 = nil;
										v1585 = 1 + 0;
									end
								end
							end
							break;
						end
					end
				end
			end
			for v1182, v1183 in pairs(v255) do
				if (not v663[v1182] or not v1182.Parent) then
					if (v1183 and v1183.Parent) then
						pcall(function()
							v1183:Destroy();
						end);
					end
					v255[v1182] = nil;
				end
			end
			break;
		end
	end
end
local function v266(v664)
	local v665 = 557 - (395 + 162);
	local v666;
	while true do
		if (v665 == 0) then
			if not v5.armorESP then
				local v1213 = 0 + 0;
				while true do
					if (v1213 == 0) then
						for v1486, v1487 in pairs(v256) do
							if (v1487 and v1487.Parent) then
								v1487:Destroy();
							end
						end
						v256 = {};
						v1213 = 1942 - (816 + 1125);
					end
					if (v1213 == 1) then
						return;
					end
				end
			end
			v666 = {};
			v665 = 1 - 0;
		end
		if ((1149 - (701 + 447)) == v665) then
			for v1184, v1185 in ipairs(v664) do
				if (v1185.character and v1185.character.Parent) then
					for v1378, v1379 in pairs(v1185.character:GetDescendants()) do
						if (v1379:IsA("BasePart") or v1379:IsA("MeshPart")) then
							local v1488 = 0;
							local v1489;
							local v1490;
							while true do
								if (v1488 == (0 - 0)) then
									v1489 = (v1379.Name == "Head") or (v1379.Name == "Torso") or (v1379.Name == "UpperTorso") or (v1379.Name == "LowerTorso") or (v1379.Name == "Left Arm") or (v1379.Name == "Right Arm") or (v1379.Name == "LeftUpperArm") or (v1379.Name == "RightUpperArm") or (v1379.Name == "LeftLowerArm") or (v1379.Name == "RightLowerArm") or (v1379.Name == "LeftHand") or (v1379.Name == "RightHand") or (v1379.Name == "Left Leg") or (v1379.Name == "Right Leg") or (v1379.Name == "LeftUpperLeg") or (v1379.Name == "RightUpperLeg") or (v1379.Name == "LeftLowerLeg") or (v1379.Name == "RightLowerLeg") or (v1379.Name == "LeftFoot") or (v1379.Name == "RightFoot") or (v1379.Name == "HumanoidRootPart");
									v1490 = v1379.Parent and (v1379.Parent:IsA("Accessory") or v1379.Parent:IsA("Tool"));
									v1488 = 1 - 0;
								end
								if (v1488 == (1342 - (391 + 950))) then
									if ((not v1489 or v1490) and v1379.Parent) then
										local v1687 = 0;
										while true do
											if (v1687 == 0) then
												v666[v1379] = true;
												if not v256[v1379] then
													local v1821 = 0 - 0;
													local v1822;
													local v1823;
													local v1824;
													while true do
														if (v1821 == (2 - 1)) then
															v1824 = nil;
															while true do
																if (v1822 == (0 - 0)) then
																	v1823, v1824 = pcall(function()
																		local v1900 = 0;
																		local v1901;
																		while true do
																			if (v1900 == 3) then
																				v1901.Parent = v1379;
																				return v1901;
																			end
																			if (v1900 == 1) then
																				v1901.FillTransparency = 0.2 + 0;
																				v1901.OutlineColor = Color3.fromRGB(0 + 0, 365 - 265, 255);
																				v1900 = 1524 - (251 + 1271);
																			end
																			if (v1900 == 2) then
																				v1901.OutlineTransparency = 0 + 0;
																				v1901.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
																				v1900 = 3;
																			end
																			if ((0 - 0) == v1900) then
																				local v1919 = 0;
																				while true do
																					if (v1919 == 1) then
																						v1900 = 2 - 1;
																						break;
																					end
																					if (v1919 == 0) then
																						v1901 = Instance.new("Highlight");
																						v1901.FillColor = Color3.fromRGB(0, 150, 422 - 167);
																						v1919 = 1;
																					end
																				end
																			end
																		end
																	end);
																	if (v1823 and v1824) then
																		v256[v1379] = v1824;
																	end
																	break;
																end
															end
															break;
														end
														if (v1821 == (1259 - (1147 + 112))) then
															v1822 = 0 + 0;
															v1823 = nil;
															v1821 = 1;
														end
													end
												end
												break;
											end
										end
									end
									break;
								end
							end
						end
					end
				end
			end
			for v1186, v1187 in pairs(v256) do
				if (not v666[v1186] or not v1186.Parent) then
					local v1329 = 0;
					local v1330;
					while true do
						if ((0 - 0) == v1329) then
							v1330 = 0;
							while true do
								if (v1330 == (0 + 0)) then
									if (v1187 and v1187.Parent) then
										v1187:Destroy();
									end
									v256[v1186] = nil;
									break;
								end
							end
							break;
						end
					end
				end
			end
			break;
		end
	end
end
local function v267()
	if v5.xray then
		for v1110, v1111 in pairs(workspace:GetDescendants()) do
			if (v1111:IsA("BasePart") and v1111.Parent and (v1111.Parent.Name ~= "Camera")) then
				local v1214 = 0;
				local v1215;
				while true do
					if (v1214 == 0) then
						local v1448 = 0;
						while true do
							if (v1448 == 0) then
								v1215 = false;
								for v1616, v1617 in pairs(game.Players:GetPlayers()) do
									if (v1617.Character and v1111:IsDescendantOf(v1617.Character)) then
										v1215 = true;
										break;
									end
								end
								v1448 = 698 - (335 + 362);
							end
							if (v1448 == (1 + 0)) then
								v1214 = 1;
								break;
							end
						end
					end
					if (v1214 == (1 - 0)) then
						if (not v1215 and not v257[v1111]) then
							local v1542 = 0 - 0;
							while true do
								if (v1542 == 1) then
									v1111.Transparency = 0.8 - 0;
									break;
								end
								if (v1542 == (0 - 0)) then
									v258[v1111] = v1111.Transparency;
									v257[v1111] = true;
									v1542 = 2 - 1;
								end
							end
						end
						break;
					end
				end
			end
		end
	else
		local v741 = 0;
		while true do
			if (v741 == 1) then
				v258 = {};
				break;
			end
			if (v741 == (566 - (237 + 329))) then
				for v1331, v1332 in pairs(v257) do
					if (v1331 and v1331.Parent) then
						v1331.Transparency = v258[v1331] or (0 - 0);
					end
				end
				v257 = {};
				v741 = 1 + 0;
			end
		end
	end
end
local function v268()
	if v5.bigHitboxes then
		for v1112, v1113 in pairs(workspace:GetDescendants()) do
			if ((v1113.Name == "Head") and v1113:IsA("BasePart") and v1113.Parent) then
				local v1216 = 0;
				local v1217;
				while true do
					if (v1216 == (0 + 0)) then
						v1217 = v1113.Parent;
						if (v1217 and v1217:FindFirstChild("HumanoidRootPart")) then
							if not v259[v1113] then
								local v1618 = 1124 - (408 + 716);
								while true do
									if (v1618 == 4) then
										v1113.Color = Color3.fromRGB(968 - 713, 821 - (344 + 477), 0 + 0);
										break;
									end
									if (v1618 == (1762 - (1188 + 573))) then
										v262[v1113] = v1113.Transparency;
										v263[v1113] = v1113.Color;
										v1618 = 5 - 3;
									end
									if (v1618 == (0 + 0)) then
										v260[v1113] = v1113.Size;
										v261[v1113] = v1113.CanCollide;
										v1618 = 1;
									end
									if (v1618 == (9 - 6)) then
										v1113.CanCollide = false;
										v1113.Transparency = 0.7;
										v1618 = 6 - 2;
									end
									if (v1618 == 2) then
										v259[v1113] = true;
										v1113.Size = Vector3.new(19.5 - 11, 8.5, 1537.5 - (508 + 1021));
										v1618 = 3 + 0;
									end
								end
							end
						end
						break;
					end
				end
			end
		end
	else
		local v742 = 1166 - (228 + 938);
		local v743;
		while true do
			if (v742 == (685 - (332 + 353))) then
				v743 = 0;
				while true do
					if (v743 == 0) then
						for v1491, v1492 in pairs(v259) do
							if (v1491 and v1491.Parent) then
								local v1589 = 0 - 0;
								while true do
									if (v1589 == (2 - 1)) then
										v1491.Transparency = v262[v1491] or (0 + 0);
										v1491.Color = v263[v1491] or Color3.fromRGB(82 + 81, 647 - 485, 588 - (18 + 405));
										break;
									end
									if (v1589 == 0) then
										v1491.Size = v260[v1491] or Vector3.new(1 + 1, 1, 1 + 0);
										v1491.CanCollide = v261[v1491] or false;
										v1589 = 1 - 0;
									end
								end
							end
						end
						v259 = {};
						v743 = 979 - (194 + 784);
					end
					if (v743 == (1772 - (694 + 1076))) then
						v262 = {};
						v263 = {};
						break;
					end
					if (v743 == 1) then
						v260 = {};
						v261 = {};
						v743 = 1906 - (122 + 1782);
					end
				end
				break;
			end
		end
	end
end
local function v269(v667)
	if not v667 then
		return false;
	end
	for v728, v729 in pairs(v667:GetDescendants()) do
		if (v729:IsA("BasePart") or v729:IsA("MeshPart")) then
			local v1114 = v729.Name:lower();
			local v1115 = (v729.Parent and v729.Parent.Name:lower()) or "";
			local v1116 = {"armor","vest","helmet","chestplate","leggings","boots","shield","plate","mail","guard","protection","defensive","body","chest"};
			if (v729.Parent and v729.Parent:IsA("Accessory")) then
				for v1333, v1334 in ipairs(v1116) do
					if (v1114:find(v1334) or v1115:find(v1334)) then
						return true;
					end
				end
			end
			local v1117 = (v1114 == "head") or (v1114 == "torso") or (v1114 == "uppertorso") or (v1114 == "lowertorso") or v1114:find("arm") or v1114:find("hand") or v1114:find("leg") or v1114:find("foot") or (v1114 == "humanoidrootpart");
			if (not v1117 and v729.Parent) then
				for v1335, v1336 in ipairs(v1116) do
					if (v1114:find(v1336) or v1115:find(v1336)) then
						return true;
					end
				end
			end
		end
	end
	return false;
end
local function v270(v668)
	if (not v668 or not v668:FindFirstChild("HumanoidRootPart") or not v668:FindFirstChild("Head")) then
		return false;
	end
	local v669 = v668.Head;
	local v670 = v668.HumanoidRootPart;
	local v671 = v669.Position;
	local v672 = v670.Position;
	if (v672.Y > v671.Y) then
		return true;
	end
	return false;
end
local function v271()
	local v673 = 0 + 0;
	local v674;
	while true do
		local v730 = 0 + 0;
		while true do
			if (v730 == (585 - (217 + 368))) then
				if (v673 == (0 - 0)) then
					v674 = {};
					for v1380, v1381 in pairs(v0:GetPlayers()) do
						if (v1381.Character and v1381.Character:FindFirstChild("HumanoidRootPart")) then
							table.insert(v674, {name=v1381.Name,rootPart=v1381.Character.HumanoidRootPart,character=v1381.Character,isRealPlayer=true});
						end
					end
					v673 = 1;
				end
				if (v673 == (1 + 0)) then
					for v1382, v1383 in pairs(workspace:GetDescendants()) do
						if ((v1383.Name == "HumanoidRootPart") and v1383:IsA("BasePart")) then
							local v1493 = 0 + 0;
							local v1494;
							while true do
								if (1 == v1493) then
									if (not v1494 and v1383.Parent) then
										local v1692 = 0;
										local v1693;
										local v1694;
										local v1695;
										while true do
											if (v1692 == (1 + 0)) then
												v1695 = nil;
												while true do
													if (v1693 == 0) then
														v1694 = v1383.Parent.Name;
														v1695 = not (v1694:lower():find("arm") or v1694:lower():find("fps") or v1694:lower():find("tool"));
														v1693 = 890 - (844 + 45);
													end
													if (v1693 == (285 - (242 + 42))) then
														if v1695 then
															table.insert(v674, {name=v1694,rootPart=v1383,character=v1383.Parent,isRealPlayer=false});
														end
														break;
													end
												end
												break;
											end
											if (v1692 == (0 - 0)) then
												v1693 = 0 - 0;
												v1694 = nil;
												v1692 = 1201 - (132 + 1068);
											end
										end
									end
									break;
								end
								if (v1493 == (0 - 0)) then
									local v1619 = 0;
									while true do
										if (v1619 == (1624 - (214 + 1409))) then
											v1493 = 1 + 0;
											break;
										end
										if (v1619 == (1634 - (497 + 1137))) then
											v1494 = false;
											for v1755, v1756 in ipairs(v674) do
												if (v1756.rootPart == v1383) then
													v1494 = true;
													break;
												end
											end
											v1619 = 941 - (9 + 931);
										end
									end
								end
							end
						end
					end
					return v674;
				end
				break;
			end
		end
	end
end
local v272 = 289 - (181 + 108);
local v273 = tick();
local v274 = 0;
local function v275()
	v272 = v272 + 1 + 0;
	v274 = v274 + (2 - 1);
	local v675 = tick();
	local v676 = 2;
	local v677 = ((v675 * v676) % (17 - 11)) / (2 + 4);
	local v678, v679, v680 = v264(v677, 1 + 0, 477 - (296 + 180));
	v243.TextColor3 = Color3.new(v678, v679, v680);
	v27();
	v28();
	if v5.crosshair then
		local v744 = v6.crosshairStyle;
		if v25[v744] then
			if v5.crosshairSpin then
				local v1337 = 1403 - (1183 + 220);
				local v1338;
				local v1339;
				while true do
					if (v1337 == 0) then
						v1338 = v675 - v273;
						v1339 = (v1338 * v6.crosshairSpinSpeed) % 360;
						v1337 = 1266 - (1037 + 228);
					end
					if (v1337 == (1 - 0)) then
						for v1543, v1544 in pairs(v25[v744]) do
							if (v744 == "X-Shape") then
								local v1620 = 0;
								local v1621;
								while true do
									if (v1620 == 1) then
										v1544.Rotation = v1339 + (((v1621 == (2 - 1)) and (153 - 108)) or -(779 - (527 + 207)));
										break;
									end
									if (0 == v1620) then
										local v1733 = 527 - (187 + 340);
										while true do
											if (v1733 == 1) then
												v1620 = 1;
												break;
											end
											if (v1733 == (1870 - (1298 + 572))) then
												v1621 = 2 - 1;
												for v1825, v1826 in ipairs(v25[v744]) do
													if (v1826 == v1544) then
														v1621 = v1825;
														break;
													end
												end
												v1733 = 171 - (144 + 26);
											end
										end
									end
								end
							elseif (v744 == "Star") then
								local v1696 = 0 - 0;
								local v1697;
								while true do
									if (v1696 == (0 - 0)) then
										v1697 = 1 + 0;
										for v1785, v1786 in ipairs(v25[v744]) do
											if (v1786 == v1544) then
												v1697 = v1785;
												break;
											end
										end
										v1696 = 2 - 1;
									end
									if (1 == v1696) then
										v1544.Rotation = v1339 + ((v1697 - (2 - 1)) * 45);
										break;
									end
								end
							else
								v1544.Rotation = v1339;
							end
						end
						break;
					end
				end
			else
				for v1384, v1385 in pairs(v25[v744]) do
					if (v744 == "X-Shape") then
						local v1495 = 0 - 0;
						local v1496;
						while true do
							if (v1495 == (1 + 0)) then
								v1385.Rotation = ((v1496 == 1) and (61 - 16)) or -45;
								break;
							end
							if (v1495 == 0) then
								v1496 = 1;
								for v1660, v1661 in ipairs(v25[v744]) do
									if (v1661 == v1385) then
										v1496 = v1660;
										break;
									end
								end
								v1495 = 1 + 0;
							end
						end
					elseif (v744 == "Star") then
						local v1590 = 0 + 0;
						local v1591;
						while true do
							if (v1590 == (202 - (5 + 197))) then
								v1591 = 687 - (339 + 347);
								for v1734, v1735 in ipairs(v25[v744]) do
									if (v1735 == v1385) then
										v1591 = v1734;
										break;
									end
								end
								v1590 = 2 - 1;
							end
							if (v1590 == (3 - 2)) then
								v1385.Rotation = (v1591 - (377 - (365 + 11))) * (43 + 2);
								break;
							end
						end
					elseif (v744 == "Diamond") then
						v1385.Rotation = 45;
					else
						v1385.Rotation = 0;
					end
				end
			end
		end
	end
	if v5.fovCircle then
		local v745 = 0 - 0;
		local v746;
		while true do
			if (v745 == 1) then
				v227.Size = UDim2.new(0, v746, 0, v746);
				v227.Position = UDim2.new(0.5, -v746 / (4 - 2), 924.41 - (837 + 87), -v746 / (3 - 1));
				v745 = 1672 - (837 + 833);
			end
			if (v745 == 2) then
				v235.Color = Color3.fromRGB(v6.fovCircleColor.r, v6.fovCircleColor.g, v6.fovCircleColor.b);
				break;
			end
			if (0 == v745) then
				v227.Visible = true;
				v746 = v6.fovCircleSize * (1 + 1);
				v745 = 1388 - (356 + 1031);
			end
		end
	else
		v227.Visible = false;
	end
	local v682, v683 = pcall(v271);
	if not v682 then
		local v748 = 0;
		while true do
			if (v748 == (0 + 0)) then
				if v5.statusLabel then
					v210.Text = "ERROR FINDING PLAYERS - " .. v272;
				end
				return;
			end
		end
	end
	if ((v272 % (1706 - (73 + 1573))) == (1388 - (1307 + 81))) then
		local v749 = 0;
		local v750;
		while true do
			if (v749 == 0) then
				v750 = {};
				for v1340, v1341 in ipairs(v683) do
					if v1341.character then
						v750[v1341.character] = true;
					end
				end
				v749 = 1;
			end
			if (v749 == (235 - (7 + 227))) then
				for v1342, v1343 in pairs(v11) do
					if not v750[v1342] then
						v11[v1342] = nil;
					end
				end
				for v1344, v1345 in pairs(v12) do
					if not v750[v1344] then
						v12[v1344] = nil;
					end
				end
				break;
			end
		end
	end
	local v684 = workspace.CurrentCamera;
	if (v274 >= v9) then
		local v751 = 0 - 0;
		while true do
			if (v751 == 1) then
				pcall(v266, v683);
				if ((v272 % (176 - (90 + 76))) == 0) then
					local v1387 = 0;
					while true do
						if (v1387 == (0 - 0)) then
							pcall(v267);
							pcall(v268);
							break;
						end
					end
				end
				break;
			end
			if ((0 + 0) == v751) then
				v274 = 0;
				pcall(v265, v683);
				v751 = 1;
			end
		end
	end
	if v5.snaplines then
		local v752 = 0 + 0;
		local v753;
		local v754;
		local v755;
		local v756;
		local v757;
		while true do
			if (v752 == (0 + 0)) then
				local v1222 = 0 - 0;
				while true do
					if (v1222 == (261 - (197 + 63))) then
						v752 = 1 + 0;
						break;
					end
					if (v1222 == (0 + 0)) then
						v753 = {};
						v754 = v684.ViewportSize.X / (2 + 0);
						v1222 = 1 + 0;
					end
				end
			end
			if ((1 - 0) == v752) then
				local v1223 = 1369 - (618 + 751);
				while true do
					if (v1223 == (1 + 0)) then
						v752 = 2;
						break;
					end
					if (v1223 == (1910 - (206 + 1704))) then
						v755 = v684.ViewportSize.Y;
						v756 = (v7 and (8 - 3)) or 10;
						v1223 = 1;
					end
				end
			end
			if (v752 == 3) then
				table.sort(v753, function(v1346, v1347)
					return v1346.distance < v1347.distance;
				end);
				for v1348 = 1 - 0, 2 + 1 do
					local v1349 = v226[v1348];
					if v753[v1348] then
						local v1455 = 0;
						local v1456;
						local v1457;
						local v1458;
						local v1459;
						local v1460;
						local v1461;
						local v1462;
						while true do
							if (v1455 == (1275 - (155 + 1120))) then
								v1456 = v753[v1348];
								v1457 = v1456.screenPos.X;
								v1458 = v1456.screenPos.Y;
								v1459 = v1457 - v754;
								v1455 = 1507 - (396 + 1110);
							end
							if (v1455 == (4 - 2)) then
								v1349.Position = UDim2.new(0 + 0, v754, 0, v755);
								v1349.Rotation = v1462;
								v1349.Visible = true;
								break;
							end
							if (v1455 == (1 + 0)) then
								v1460 = v1458 - v755;
								v1461 = math.sqrt((v1459 * v1459) + (v1460 * v1460));
								v1462 = math.deg(math.atan2(v1459, -v1460));
								v1349.Size = UDim2.new(0 + 0, 1, 976 - (230 + 746), v1461);
								v1455 = 603 - (473 + 128);
							end
						end
					else
						v1349.Visible = false;
					end
				end
				break;
			end
			if (v752 == 2) then
				v757 = 48 - (39 + 9);
				for v1350, v1351 in ipairs(v683) do
					if (v757 >= v756) then
						break;
					end
					if (v1351.rootPart and v1351.rootPart.Parent) then
						local v1464 = v1351.name:lower();
						local v1465 = not v1464:find("arm");
						if v1465 then
							local v1545 = 0;
							local v1546;
							local v1547;
							local v1548;
							local v1549;
							local v1550;
							while true do
								if (v1545 == 1) then
									v1548 = nil;
									v1549 = nil;
									v1545 = 268 - (38 + 228);
								end
								if (v1545 == (3 - 1)) then
									v1550 = nil;
									while true do
										if (v1546 == 0) then
											v1547 = v1351.rootPart.Position + Vector3.new(0, 474.5 - (106 + 367), 0 + 0);
											if (v1351.character and v1351.character:FindFirstChild("Head")) then
												v1547 = v1351.character.Head.Position;
											end
											v1546 = 1863 - (354 + 1508);
										end
										if (v1546 == 1) then
											v1548, v1549, v1550 = pcall(function()
												return v684:WorldToScreenPoint(v1547);
											end);
											if (v1548 and v1550 and (v1549.Z > (0 - 0))) then
												local v1788 = 0 + 0;
												local v1789;
												while true do
													if (v1788 == (1 + 0)) then
														v757 = v757 + (1 - 0);
														break;
													end
													if (v1788 == (1244 - (334 + 910))) then
														v1789 = (v684.CFrame.Position - v1547).Magnitude;
														table.insert(v753, {playerData=v1351,screenPos=v1549,distance=v1789});
														v1788 = 896 - (92 + 803);
													end
												end
											end
											break;
										end
									end
									break;
								end
								if (v1545 == (0 + 0)) then
									v1546 = 1181 - (1035 + 146);
									v1547 = nil;
									v1545 = 617 - (230 + 386);
								end
							end
						end
					end
				end
				v752 = 2 + 1;
			end
		end
	else
		for v1118 = 1511 - (353 + 1157), 1117 - (53 + 1061) do
			v226[v1118].Visible = false;
		end
	end
	if not v684 then
		local v758 = 1635 - (1568 + 67);
		local v759;
		while true do
			if (v758 == 0) then
				v759 = 0 + 0;
				while true do
					if (v759 == (0 + 0)) then
						local v1466 = 0 - 0;
						while true do
							if (v1466 == (0 - 0)) then
								if v5.statusLabel then
									v210.Text = "NO CAMERA - " .. v272;
								end
								return;
							end
						end
					end
				end
				break;
			end
		end
	end
	v210.Visible = v5.statusLabel;
	if v5.statusLabel then
		v210.Text = "PLAYERS: " .. #v683 .. " | PERF MODE: " .. tostring(v7) .. " | UPDATE " .. v272;
	end
	local v687 = 2 - 1;
	local v688 = 1;
	local v689 = 1 + 0;
	local v690 = 1;
	for v731 = 1213 - (615 + 597), #v222 do
		v222[v731].Visible = false;
	end
	for v733 = 1 + 0, #v223 do
		v223[v733].Visible = false;
	end
	for v735 = 1, #v224 do
		v224[v735].Visible = false;
	end
	for v737 = 1, #v225 do
		v225[v737].Visible = false;
	end
	for v739, v740 in ipairs(v683) do
		if (v740.rootPart and v740.rootPart.Parent) then
			local v1120, v1121, v1122 = pcall(function()
				return v684:WorldToScreenPoint(v740.rootPart.Position);
			end);
			if (v1120 and v1122 and (v1121.Z > 0)) then
				local v1224 = (v684.CFrame.Position - v740.rootPart.Position).Magnitude;
				if (v5.distance and (v690 <= #v225)) then
					local v1388 = v225[v690];
					local v1389 = "[" .. math.floor(v1224) .. "]";
					v1388.Text = v1389;
					v1388.Position = UDim2.new(0 - 0, v1121.X - (33 + 7), 0 + 0, v1121.Y - (34 + 26));
					v1388.Visible = true;
					v690 = v690 + (1900 - (1056 + 843));
				end
				if v5.particles then
					local v1393 = 0 - 0;
					local v1394;
					while true do
						if (v1393 == (0 - 0)) then
							v1394 = (v7 and v8) or (14 - 9);
							for v1599 = 1 + 0, v1394 do
								if (v687 <= #v222) then
									local v1665 = v222[v687];
									local v1666 = v1121.Y - (v1599 * (2006 - (286 + 1690)));
									v1665.Position = UDim2.new(0, v1121.X, 911 - (98 + 813), v1666);
									v1665.Visible = true;
									v687 = v687 + 1 + 0;
								end
							end
							break;
						end
					end
				end
				if (v5.headCircles and (v688 <= #v223)) then
					local v1395 = v223[v688];
					local v1396 = v740.rootPart.Position + Vector3.new(0 - 0, 1.5 + 0, 507 - (263 + 244));
					if (v740.character and v740.character:FindFirstChild("Head")) then
						v1396 = v740.character.Head.Position;
					end
					local v1397, v1398 = pcall(function()
						return v684:WorldToScreenPoint(v1396);
					end);
					if (v1397 and (v1398.Z > 0)) then
						local v1498 = 0 + 0;
						local v1499;
						local v1500;
						local v1501;
						while true do
							if (v1498 == 1) then
								v1501 = nil;
								while true do
									if ((1689 - (1502 + 185)) == v1499) then
										v1395.Size = UDim2.new(0, v1500, 0 + 0, v1500);
										v1395.Position = UDim2.new(0 - 0, v1398.X - (v1500 / (5 - 3)), 1527 - (629 + 898), v1398.Y - (v1500 / 2));
										v1499 = 8 - 5;
									end
									if ((7 - 4) == v1499) then
										v1395.Visible = true;
										v688 = v688 + (366 - (12 + 353));
										break;
									end
									if (v1499 == (1911 - (1680 + 231))) then
										local v1739 = 0 + 0;
										while true do
											if (v1739 == (1 + 0)) then
												v1499 = 1150 - (212 + 937);
												break;
											end
											if ((0 + 0) == v1739) then
												v1500 = math.max(1070 - (111 + 951), math.min(5 + 15, (427 - (18 + 9)) / v1224));
												if (((v272 % (5 + 15)) == 0) or (v11[v740.character] == nil)) then
													v11[v740.character] = v269(v740.character);
												end
												v1739 = 535 - (31 + 503);
											end
										end
									end
									if (v1499 == (1633 - (595 + 1037))) then
										v1501 = v11[v740.character] or false;
										if v1501 then
											v1395.BackgroundColor3 = Color3.fromRGB(1444 - (189 + 1255), 56 + 94, 394 - 139);
										else
											v1395.BackgroundColor3 = Color3.fromRGB(1534 - (1170 + 109), 1817 - (348 + 1469), 0);
										end
										v1499 = 1291 - (1115 + 174);
									end
								end
								break;
							end
							if (v1498 == 0) then
								v1499 = 0 - 0;
								v1500 = nil;
								v1498 = 1;
							end
						end
					end
				end
				if (v5.selectionBoxes and not v740.name:lower():find("arm") and (v689 <= #v224)) then
					local v1399 = 0;
					local v1400;
					local v1401;
					local v1402;
					local v1403;
					local v1404;
					local v1405;
					local v1406;
					local v1407;
					local v1408;
					local v1409;
					while true do
						if (v1399 == (1014 - (85 + 929))) then
							local v1551 = 0 + 0;
							while true do
								if (v1551 == (1868 - (1151 + 716))) then
									v1401 = v12[v740.character] or false;
									v1399 = 1;
									break;
								end
								if (v1551 == 0) then
									v1400 = v224[v689];
									if (((v272 % 15) == (0 + 0)) or (v12[v740.character] == nil)) then
										v12[v740.character] = v270(v740.character);
									end
									v1551 = 1;
								end
							end
						end
						if (v1399 == 4) then
							if v1407 then
								v1407.BackgroundColor3 = v1405;
							end
							if v1408 then
								v1408.BackgroundColor3 = v1405;
							end
							if v1409 then
								v1409.BackgroundColor3 = v1405;
							end
							v1399 = 5;
						end
						if (v1399 == (1 + 0)) then
							local v1552 = 1704 - (95 + 1609);
							while true do
								if (v1552 == (3 - 2)) then
									if v1401 then
										local v1741 = 758 - (364 + 394);
										while true do
											if (v1741 == (0 + 0)) then
												v1403 = math.min(v1402 * (1.8 + 0), 90);
												v1404 = math.min(v1402 * 0.5, 6 + 19);
												break;
											end
										end
									else
										local v1742 = 0 + 0;
										while true do
											if (v1742 == (0 + 0)) then
												v1403 = math.min(v1402, 26 + 24);
												v1404 = math.min(v1402 * (1.4 + 0), 70);
												break;
											end
										end
									end
									v1399 = 2 + 0;
									break;
								end
								if (v1552 == (0 + 0)) then
									v1402 = math.max(976 - (719 + 237), math.min(139 - 89, (826 + 174) / v1224));
									v1403, v1404 = nil;
									v1552 = 1;
								end
							end
						end
						if ((12 - 7) == v1399) then
							v1400.Size = UDim2.new(0 - 0, v1403, 0, v1404);
							v1400.Position = UDim2.new(0, v1121.X - (v1403 / 2), 0 - 0, v1121.Y - (v1404 / (1993 - (761 + 1230))));
							v1400.Visible = true;
							v1399 = 199 - (80 + 113);
						end
						if (v1399 == (2 + 1)) then
							v1408 = v1400:FindFirstChild("LeftBorder");
							v1409 = v1400:FindFirstChild("RightBorder");
							if v1406 then
								v1406.BackgroundColor3 = v1405;
							end
							v1399 = 4;
						end
						if (v1399 == 6) then
							v689 = v689 + 1 + 0;
							break;
						end
						if (v1399 == (1 + 1)) then
							local v1556 = 0;
							while true do
								if (v1556 == (3 - 2)) then
									v1407 = v1400:FindFirstChild("BottomBorder");
									v1399 = 1 + 2;
									break;
								end
								if (v1556 == (0 + 0)) then
									v1405 = (v1401 and Color3.fromRGB(0, 1498 - (965 + 278), 1729 - (1391 + 338))) or Color3.fromRGB(651 - 396, 249 + 6, 0 - 0);
									v1406 = v1400:FindFirstChild("TopBorder");
									v1556 = 1;
								end
							end
						end
					end
				end
			end
		end
	end
	if v5.statusLabel then
		v210.Text = "PLAYERS: " .. #v683 .. " | PARTICLES: " .. (v687 - (1 + 0)) .. " | CIRCLES: " .. (v688 - 1) .. " | BOXES: " .. (v689 - (1409 - (496 + 912))) .. " | DISTANCES: " .. (v690 - (3 - 2)) .. " | PERF: " .. tostring(v7);
	end
end
switchTab("Combat");
v210.Text = "STARTING UPDATE LOOP";
local v276 = v1.Heartbeat:Connect(function()
	pcall(v275);
end);
return {features=v5,visualSettings=v6,screenGui=v18,predefinedCodes=v16};