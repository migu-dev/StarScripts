-- Thx for all buyers, im making a ss for the buyers!

local variables = {}

variables.autoCornFarm = false;
variables.hitboxexpand = false;
variables.killmethodgun = false;
variables.autoAureus = false;
variables.autoScavEnabled = false;
variables.autoPrinterFarm = false;
variables.deathBarrierBypassEnabled = false;
variables.versione = "1.0";
variables.globRainbowColor3 = nil;
variables.kickOnModJoin = false;


_G.deathBarrierBypassEnabled = false;
_G.weaponMultiplierEnabled = false;


-- Kick on mod join

local variables = {}

variables.kickOnModJoin = false;

modList = { 
	"2J0Y",
	"PsychoBuckett",
	"J_mey",
	"RayRacoon",
	"JumpyBageI",
	"Voyagr",
	"Artaniss",
	"RyIock",
	"Dj5826",
	"Edd_E"
}
function isUserEsMod(username)
	for i,v in pairs(modList) do
		if string.lower(username) == string.lower(v) then
			if variables.kickOnModJoin then
				game.Players.LocalPlayer:Kick("Moderator " .. username .. " joined your game, kicking you for safety!");
			end
			return true
		end
	end
	return false
end







-- auto corn

function autoCornFarmRun()
	if variables.autoCornFarm then
		hasFoundCargoStation = false;
		pcall(function()
			if game:GetService("Workspace").Buildings[game.Players.LocalPlayer.Name]["Capital Cargo Station"].Name == "Capital Cargo Station" then
				hasFoundCargoStation = true;
			end
		end)
		if hasFoundCargoStation then
			pcall(function()
				cargoStation = game:GetService("Workspace").Buildings[game.Players.LocalPlayer.Name]["Capital Cargo Station"];
				for i,v in pairs(game:GetService("Workspace").Buildings[game.Players.LocalPlayer.Name]:GetChildren()) do
					pcall(function()
						if v.Name == "Corn Farm" or v.Name == "Tomato Farm" or v.Name == "Carrot Farm" then
							if v["3"].Transparency == 0 then
								pcall(function()
									-- ready for harvest
									local cFrameRn = nil;
									cFrameRn = CFrame.new(Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Y, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z));
									local controls = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerModule):GetControls()
									controls:Disable();
									pcall(function()
										wait(1);
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v["3"].CFrame;
										wait(1);
										Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(40, v);
										wait(1);
										Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(40, v);
										wait(1);
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cargoStation.Union.CFrame;
										wait(1);
										corn = nil;
										for i1, v1 in pairs(game:GetService("Workspace")[game.Players.LocalPlayer.Name]:GetChildren()) do
											if string.match(v1.Name, "Corn") or string.match(v1.Name, "Tomato") or string.match(v1.Name, "Carrot") then
												corn = v1;
												break;
											end
										end
										if corn ~= nil then
											Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(41, cargoStation, corn);
										end
									end)
									wait(1);
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(cFrameRn.X, cFrameRn.Y, cFrameRn.Z));
									wait(1);
									controls:Enable();
								end)
							end
						end
					end)
				end
			end)
		else
			notice:Fire("StarEssentials", "Please place a capital cargo station in your node for AutoCornFarm!", 4);
		end
	end
end


-- poner el chido topbar
spawn(function()
	while wait() do
		local hue = tick() % 10 / 10;
		variables.globRainbowColor3 = Color3.fromHSV(hue, 1, 1);
		game:GetService("Players").LocalPlayer.PlayerGui.TopBar.Frame.BackgroundColor3 = variables.globRainbowColor3;
	end
end);

variables.versione = "1.0"

game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):SetTopbarTransparency(1);
local textArray = { " StarEssentials | Version: " .. variables.versione};
local textLabel = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("TopBar"):WaitForChild("Frame"):WaitForChild("TextLabel");
local randomInt = math.random(1, #textArray);
spawn(function()
	while true do
		textLabel.Text = textArray[randomInt];
		randomInt = randomInt + 1;
		if #textArray < randomInt then
			randomInt = 1;
		end;
		wait(0.1);	
	end;
end);


-- Anti-die barrier
local mt = getrawmetatable(game);
local backup = mt.__namecall;
if setreadonly then setreadonly(mt, false) else make_writeable(mt, true) end

mt.__namecall = newcclosure(function(...)
	local method = getnamecallmethod()
	local args = {...}
	if method == "FindPartOnRayWithWhitelist" then
		if _G.deathBarrierBypassEnabled then
			local getScript = getfenv(2).script
			if getScript == nil then
				getScript = ""
			end
			if tostring(getScript:GetFullName()) == "game.Players.LocalPlayer.PlayerScripts.LocalScript" then
				args[2].Y = 144;
				return backup(unpack(args))
			else
				return backup(...)
			end
		else
			return backup(...)
		end
	end


	if method == "FireServer" or method == "InvokeServer" then
		if _G.weaponMultiplierEnabled then
			if args[1].Name == "MenuActionEvent" then
				if args[2] == 33 and args[8] ~= "" and args[8] ~= "a" then
					spawn(function()
						wait()
						Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(args[2], args[3], args[4], args[5], args[6], args[7], "a");
						wait()
						Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(args[2], args[3], args[4], args[5], args[6], args[7], "a");
						wait()
						Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(args[2], args[3], args[4], args[5], args[6], args[7], "a");
						wait(0.1)
						Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(args[2], args[3], args[4], args[5], args[6], args[7], "a");
						wait()
						Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(args[2], args[3], args[4], args[5], args[6], args[7], "a");
						wait()
						Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(args[2], args[3], args[4], args[5], args[6], args[7], "a");
						wait(0.1)
						Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(args[2], args[3], args[4], args[5], args[6], args[7], "a");
						wait()
						Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(args[2], args[3], args[4], args[5], args[6], args[7], "a");
						wait()
						Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(args[2], args[3], args[4], args[5], args[6], args[7], "a");
						wait()
						Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(args[2], args[3], args[4], args[5], args[6], args[7], "a");
						wait(0.1)
						Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(args[2], args[3], args[4], args[5], args[6], args[7], "a");
						wait()
						Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(args[2], args[3], args[4], args[5], args[6], args[7], "a");
						wait()
						Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(args[2], args[3], args[4], args[5], args[6], args[7], "a");
						wait()
						Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(args[2], args[3], args[4], args[5], args[6], args[7], "a");
					end);
					return backup(unpack(args))
				end
			elseif args[1].Name == "MenuActionEvent" and args[2] == 33 and args[8] == "a" then
				args[8] = "";
				return backup(unpack(args))
			else

			end
		end
	end
	return backup(...)
end)

_G.deathBarrierBypassEnabled = false;


-- Load map
msg = Instance.new("Message",workspace)
msg.Text = "Loading map, pls wait!"
game:GetService("Workspace").Camera.CameraType = Enum.CameraType.Scriptable;
game:GetService("Workspace").Camera.CFrame = CFrame.new(Vector3.new(-2251, 196, 1465));
wait(1)
game:GetService("Workspace").Camera.CFrame = CFrame.new(Vector3.new(-1533, 190, -344));
wait(1)
game:GetService("Workspace").Camera.CFrame = CFrame.new(Vector3.new(-502, 138, -1308));
wait(1)
game:GetService("Workspace").Camera.CFrame = CFrame.new(Vector3.new(1494, 272, -1663));
wait(1)
game:GetService("Workspace").Camera.CFrame = CFrame.new(Vector3.new(1983, 138, 48));
wait(1)
game:GetService("Workspace").Camera.CFrame = CFrame.new(Vector3.new(2144, 135, 1611));
wait(1)
game:GetService("Workspace").Camera.CFrame = CFrame.new(Vector3.new(5, 274, 1302));
wait(1)
game:GetService("Workspace").Camera.CFrame = CFrame.new(Vector3.new(-131, 197, -463));
wait(1)
game:GetService("Workspace").Camera.CFrame = CFrame.new(Vector3.new(-1572, 206, -1235));
wait(1)
game:GetService("Workspace").Camera.CFrame = CFrame.new(Vector3.new(-1725, 263, -1798));
wait(1)
game:GetService("Workspace").Camera.CameraType = Enum.CameraType.Custom;
wait(3 )
msg:Destroy()


-- Farm
----------------




-- aureus auto


notice = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Note");

function auroAureusRun()
	if variables.autoAureus then
		hasFoundScavStation = false;
		pcall(function()
			if game:GetService("Workspace").Buildings[game.Players.LocalPlayer.Name]["Scavenge Station"].Name == "Scavenge Station" then
				hasFoundScavStation = true;
			end
		end)
		if hasFoundScavStation then
			pcall(function()
				scavStation = game:GetService("Workspace").Buildings[game.Players.LocalPlayer.Name]["Scavenge Station"];
				timerOnThing = game.Players.LocalPlayer.PlayerGui.Client.Drone.Slots.Amt.Text;
				if timerOnThing == "Ready" then
					pcall(function()
						-- ready for drone
						local cFrameRn = nil;
						cFrameRn = CFrame.new(Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Y, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z));
						local controls = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerModule):GetControls()
						controls:Disable();
						pcall(function()

							CFrameEnd = scavStation.Union.CFrame;
							Time = 5
							tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Time), {CFrame = CFrameEnd})
							tween:Play()
							tween.Completed:Wait()


							wait(1);
							Game:GetService("ReplicatedStorage").Events.InteractEvent:FireServer(scavStation);
							wait(1);
							Game:GetService("ReplicatedStorage").Events.MenuAcitonEvent:FireServer(1, scavStation);
							wait(1);

							CFrameEnd = game:GetService("Workspace").DroneShipment.MeshPart.CFrame;
							Time = 5
							tween =  game:GetService("TweenService"):Create(game:GetService("Workspace").Drones[game.Players.LocalPlayer.Name].Hull, TweenInfo.new(Time), {CFrame = CFrameEnd})
							tween:Play()
							tween.Completed:Wait()

							wait(2);
							Game:GetService("ReplicatedStorage").Events.MenuAcitonEvent:FireServer(3);
							wait(1);
							game:GetService("Workspace").Drones[game.Players.LocalPlayer.Name].Hull.CFrame = game:GetService("Workspace").Buildings[game.Players.LocalPlayer.Name]["Scavenge Station"].Union.CFrame;
							wait(1);
							Game:GetService("ReplicatedStorage").Events.MenuAcitonEvent:FireServer(4);
							wait();
							Game:GetService("ReplicatedStorage").Events.InteractEvent:FireServer(scavStation);
						end)
						wait(1);

						CFrameEnd = CFrame.new(Vector3.new(cFrameRn.X, cFrameRn.Y, cFrameRn.Z));
						Time = 5
						tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Time), {CFrame = CFrameEnd})
						tween:Play()
						tween.Completed:Wait()

						wait(1);
						controls:Enable();
						Game:GetService("ReplicatedStorage").Events.ScavengeFunction:InvokeServer("Old-World Crate");

					end)
				end
			end)
		else
			notice:Fire("Staressentials", "Please place a scavenge station in your node for AutoAureus!", 4);
		end
	end
end

-- auto scavenge

function autoScavRun()
	if variables.autoScavEnabled then
		local controls = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerModule):GetControls()
		pcall(function()
			for i,v in pairs(game:GetService("Workspace").Loot:GetChildren()) do
				wait(2);
				shouldBreak = false;
				pcall(function()
					if v.LootCrate ~= nil then
						pcall(function()
							controls:Disable();
							local cFrameRn = nil;
							cFrameRn = CFrame.new(Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Y, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z));									
							local CFrameEnd = v.LootCrate.CFrame;
							local Time = 5
							local tween =  game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Time), {CFrame = CFrameEnd})
							tween:Play()
							tween.Completed:Wait()
							wait(2);
							Game:GetService("ReplicatedStorage").Events.CratePickUpEvent:FireServer(v);
							wait(2);

							local CFrameEnd = CFrame.new(Vector3.new(cFrameRn.X, cFrameRn.Y, cFrameRn.Z));
							local Time = 5
							local tween =  game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Time), {CFrame = CFrameEnd})
							tween:Play()
							tween.Completed:Wait()

							shouldBreak = true;
							wait(1);
						end)
					end
				end)
				if shouldBreak then
					break;
				end
			end
			controls:Enable();
		end)
		pcall(function()
			local controls = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerModule):GetControls()
			controls:Enable();
		end)
		Game:GetService("ReplicatedStorage").Events.ScavengeFunction:InvokeServer("Scavenge Crate");
	end
end









-- Auto printer




notice = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Note");

function getClosestOwnedPrinter()
	local lplayer = game.Players.LocalPlayer
	local Character = lplayer.Character
	local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
	if not (Character or HumanoidRootPart) then return end
	local TargetDistance = math.huge
	local Target
	for i,v in ipairs(game:GetService("Workspace").MoneyPrinters:GetChildren()) do
		pcall(function()
			mesh = nil;	
			pcall(function()
				if v.PrimaryPart.Name ~= "" then
					mesh = v.PrimaryPart
				end
			end)
			pcall(function()
				if mesh == nil then
					mesh = v.PrimaryPart
				end
			end)
			if mesh then
				if string.lower(tostring(v.TrueOwner.Value)) == tostring(string.lower(game.Players.LocalPlayer.Name)) then
					local TargetHRP = mesh
					local mag = (HumanoidRootPart.Position - TargetHRP.Position).magnitude
					if mag < TargetDistance then
						TargetDistance = mag
						Target = v
					end
				end
			end
		end)
	end

	return Target
end


function runAutoPrinter()
	if variables.autoPrinterFarm then
		if variables.deathBarrierBypassEnabled then
			pcall(function()
				ownedPrinters = 0;
				printersMade = 0;
				for i,v in pairs(game:GetService("Workspace").MoneyPrinters:GetChildren()) do
					if string.lower(tostring(v.TrueOwner.Value)) == tostring(string.lower(game.Players.LocalPlayer.Name)) then
						ownedPrinters = ownedPrinters + 1;
					end
				end

				if ownedPrinters >= 2 or printersMade >= 2 then
					-- already have 2 printers
				else
					pcall(function()
						if variables.makebaseplate then
							game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(4)


							local ohNumber1 = 1
							local ohString2 = "Node"
							local ohCFrame3 = CFrame.new(1.30126417, 2.68526554, 14.9110432, 0, -4.37113883e-08, 1, 0, 1, 4.37113883e-08, -1, 0, 0)

							game:GetService("ReplicatedStorage").Events.BuildingEvent:FireServer(ohNumber1, ohString2, ohCFrame3)




							local ohNumber1 = 1
							local ohString2 = "Wooden Wall (1x2)"
							local ohCFrame3 = CFrame.new(0, 0, 0, 0, 3.33601961e-14, -1, 1, -4.37113883e-08, 1.19248806e-08, -4.37113883e-08, -1, 3.28389422e-14)

							game:GetService("ReplicatedStorage").Events.BuildingEvent:FireServer(ohNumber1, ohString2, ohCFrame3)



							local ohNumber1 = 1
							local ohString2 = "Wooden Wall (1x2)"
							local ohCFrame3 = CFrame.new(0, 0, 10, 0, 3.33601961e-14, -1, 1, -4.37113883e-08, 1.19248806e-08, -4.37113883e-08, -1, 3.28389422e-14)

							game:GetService("ReplicatedStorage").Events.BuildingEvent:FireServer(ohNumber1, ohString2, ohCFrame3)



							local ohNumber1 = 1
							local ohString2 = "Wooden Wall (1x2)"
							local ohCFrame3 = CFrame.new(7, 0, 10, 0, 3.33601961e-14, -1, 1, -4.37113883e-08, 1.19248806e-08, -4.37113883e-08, -1, 3.28389422e-14)

							game:GetService("ReplicatedStorage").Events.BuildingEvent:FireServer(ohNumber1, ohString2, ohCFrame3)



							local ohNumber1 = 1
							local ohString2 = "Wooden Wall (1x2)"
							local ohCFrame3 = CFrame.new(7, 0, 0, 0, 3.33601961e-14, -1, 1, -4.37113883e-08, 1.19248806e-08, -4.37113883e-08, -1, 3.28389422e-14)

							game:GetService("ReplicatedStorage").Events.BuildingEvent:FireServer(ohNumber1, ohString2, ohCFrame3)


							local ohNumber1 = 1
							local ohString2 = "Wooden Wall (1x2)"
							local ohCFrame3 = CFrame.new(-7, 0, 0, 0, 3.33601961e-14, -1, 1, -4.37113883e-08, 1.19248806e-08, -4.37113883e-08, -1, 3.28389422e-14)

							game:GetService("ReplicatedStorage").Events.BuildingEvent:FireServer(ohNumber1, ohString2, ohCFrame3)



							local ohNumber1 = 1
							local ohString2 = "Wooden Wall (1x2)"
							local ohCFrame3 = CFrame.new(-7, 0, 10, 0, 3.33601961e-14, -1, 1, -4.37113883e-08, 1.19248806e-08, -4.37113883e-08, -1, 3.28389422e-14)

							game:GetService("ReplicatedStorage").Events.BuildingEvent:FireServer(ohNumber1, ohString2, ohCFrame3)
						end

						wait(1);


						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-394.148163, 153.951874, -81.6159363, 0.212195292, 3.52738674e-08, -0.977227271, -4.09336351e-08, 1, 2.72075322e-08, 0.977227271, 3.42281545e-08, 0.212195292);

						wait(1);
						Game:GetService("ReplicatedStorage").Events.MenuEvent:FireServer(2, "Money Printer Advanced", nil, 8);
						wait(1);
						printer = getClosestOwnedPrinter();
						Game:GetService("ReplicatedStorage").Events.PickUpEvent:FireServer(printer, true);
						counterunowo = 0;
						pcall(function()
							while tonumber(printer.Int.Money.Value) < 999999 do
								if counterunowo > 10 then
									break;
								end
								wait(1);
								counterunowo = counterunowo + 1;
							end
						end)
						wait(1);
						didSuccessyy = false;
						pcall(function()
							if tonumber(printer.Int2.Money.Value) < 99999 then
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-0.609249473, 3, 0.498477787, 0, 0, 1, 0, 1, -0, -1, 0, 0);
								didSuccessyy = true;
							end
						end)
						if didSuccessyy then

						else
							Game:GetService("ReplicatedStorage").Events.PickUpEvent:FireServer(printer, true);
							wait(1);
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-0.609249473, 3, 0.498477787, 0, 0, 1, 0, 1, -0, -1, 0, 0);
						end

						wait(2);
					end)
					pcall(function()
						Game:GetService("ReplicatedStorage").Events.PickUpEvent:FireServer(printer, false);
					end)
					wait(2);


					printer.Int.Money.Changed:connect(function(newVal)
						doPrinterStuffy();
					end)

					printersMade = printersMade + 1;
					runAutoPrinter();
				end
			end)
		else
			notice:Fire("Staressentials", "Please enable Bypass Barriers!", 4);
		end
	end
end

function doPrinterStuffy()
	pcall(function()
		if isDoingPrinterRn == false then
			isDoingPrinterRn = true;
			if variables.autoPrinterFarm then
				if variables.deathBarrierBypassEnabled then
					pcall(function()
						for i,v in pairs(game:GetService("Workspace").MoneyPrinters:GetChildren()) do
							if string.lower(tostring(v.TrueOwner.Value)) == tostring(string.lower(game.Players.LocalPlayer.Name)) then
								if tonumber(v.Int.Money.Value) > 0 then
									howManyIsLeft = v.Int.Uses.Value;

									cframeyy = CFrame.new(v.PrimaryPart.CFrame.X, v.PrimaryPart.CFrame.Y + 3, v.PrimaryPart.CFrame.Z); 

									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframeyy;

									wait(2);
									Game:GetService("ReplicatedStorage").Events.InteractEvent:FireServer(v);

									if howManyIsLeft == 0 then
										wait(1);
										runAutoPrinter();
									end
								end
							end
						end
					end)
				else
					notice:Fire("Staressentials", "Please enable Bypass Barriers!", 4);
				end
			end
			isDoingPrinterRn = false;
		else

		end
	end)
	isDoingPrinterRn = false;
end




local UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/xBVw0uNM"))()

local localplayer = game.Players.LocalPlayer.Name
-- Noclip
noclip = false
game:GetService('RunService').Stepped:connect(function()
	if noclip then
		game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
	end
end)


-- Load screen
local Player = game:GetService("Players").LocalPlayer
local ProgressBar = game.Players.LocalPlayer.PlayerGui.Client.ProgressBar
ProgressBar.TextLabel.Text = "Loading StarEssentials";
ProgressBar.Frame.Frame.Size = UDim2.new(0, 0, 1, 0);
ProgressBar.Visible = true;
ProgressBar.Frame.Frame:TweenSize(UDim2.new(1, 0, 1, 0), "In", "Linear", 1, true, u2);
wait(1)
ProgressBar.Visible = false
local ProgressBar = game.Players.LocalPlayer.PlayerGui.Client.ProgressBar
ProgressBar.TextLabel.Text = "Loading Gui";
ProgressBar.Frame.Frame.Size = UDim2.new(0, 0, 1, 0);
ProgressBar.Visible = true;
ProgressBar.Frame.Frame:TweenSize(UDim2.new(1, 0, 1, 0), "In", "Linear", 1, true, u2);
wait(1)
ProgressBar.Visible = false


-- infjump

_G.infinjump = false

local Mouse = Player:GetMouse()
Mouse.KeyDown:connect(function(k)
	if _G.infinjump then
		if k:byte() == 32 then
			Humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			Humanoid:ChangeState("Jumping")
			wait(0.1)
			Humanoid:ChangeState("Seated")
		end
	end
end)
noclip = false
game:GetService("RunService").Stepped:connect(
function()
	if noclip then
		game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
	end
end
)

-- ESP

local ESP = loadstring(game:HttpGet("https://pastebin.com/raw/Lierd3sc"))()

-- UI

local MainUI = UILibrary.Load("StarEssentials")


local players = MainUI.AddPage("players")

local localps = MainUI.AddPage("Local player", false)

local troll = MainUI.AddPage("Troll")

local combat = MainUI.AddPage("Combat", false)

local farm = MainUI.AddPage("Farming", false)

local crafting = MainUI.AddPage("Crafting", false)

local teleports = MainUI.AddPage("Teleports", false)

local times = MainUI.AddPage("Time", false)

local options = MainUI.AddPage("Options", false)



-- times
local day = times.AddButton("Day", function()
	game.Lighting.Condition.Value = "Day"
	game.Lighting:SetMinutesAfterMidnight(720)
	game:GetService("Lighting").SunRays.Intensity = 0.25
	game:GetService("Lighting").SunRays.Spread = 1
	game:GetService("Lighting").Bloom.Intensity = 0.4
	game:GetService("Lighting").Sky.SkyboxBk = "rbxassetid://2677179366"
	game:GetService("Lighting").Sky.SkyboxDn = "rbxassetid://501313275"
	game:GetService("Lighting").Sky.SkyboxFt = "rbxassetid://2677179602"
	game:GetService("Lighting").Sky.SkyboxLf = "rbxassetid://2677179822"
	game:GetService("Lighting").Sky.SkyboxRt = "rbxassetid://2677179738"
	game:GetService("Lighting").Sky.SkyboxUp = "rbxassetid://247087559"
	game:GetService("Lighting").Brightness =  1.85
	game:GetService("Lighting").FogColor =  Color3.fromRGB(255, 247, 234)
	game:GetService("Lighting").OutdoorAmbient =  Color3.fromRGB(185, 178, 167)
	game:GetService("Lighting").FogEnd = 7000;
	game:GetService("Lighting").FogStart = 0;
end)

local night = times.AddButton("Night", function()
	game.Lighting.Condition.Value = "Night"
	game.Lighting:SetMinutesAfterMidnight(1025)
	game:GetService("Lighting").SunRays.Intensity = 0.04
	game:GetService("Lighting").SunRays.Spread = 1.2
	game:GetService("Lighting").Bloom.Intensity = 0.4
	game:GetService("Lighting").Sky.SkyboxBk = "rbxassetid://2695798966"
	game:GetService("Lighting").Sky.SkyboxDn = "rbxassetid://213221473"
	game:GetService("Lighting").Sky.SkyboxFt = "rbxassetid://220789557"
	game:GetService("Lighting").Sky.SkyboxLf = "rbxassetid://220789543"
	game:GetService("Lighting").Sky.SkyboxRt = "rbxassetid://220789524"
	game:GetService("Lighting").Sky.SkyboxUp = "rbxassetid://220789575"
	game:GetService("Lighting").Brightness = 0
	game:GetService("Lighting").FogColor = Color3.fromRGB(31, 46, 75)
	game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(33, 40, 61)
end)

local rain = times.AddButton("Rain", function()
	game.Lighting.Condition.Value = "Rain"
	game.Lighting:SetMinutesAfterMidnight(720)
	game:GetService("Lighting").SunRays.Intensity = 0.25
	game:GetService("Lighting").SunRays.Spread = 1
	game:GetService("Lighting").Bloom.Intensity = 0.4
	game:GetService("Lighting").Sky.SkyboxBk = "rbxassetid://931421737"
	game:GetService("Lighting").Sky.SkyboxDn = "rbxassetid://931421868"
	game:GetService("Lighting").Sky.SkyboxFt = "rbxassetid://931421587"
	game:GetService("Lighting").Sky.SkyboxLf = "rbxassetid://931421672"
	game:GetService("Lighting").Sky.SkyboxRt = "rbxassetid://931421501"
	game:GetService("Lighting").Sky.SkyboxUp = "rbxassetid://931421803"
	game:GetService("Lighting").Brightness =  0
	game:GetService("Lighting").FogColor =  Color3.fromRGB(193, 193, 193)
	game:GetService("Lighting").OutdoorAmbient =  Color3.fromRGB(195, 195, 195)
end)

local war = times.AddButton("War", function()
	game.Lighting.Condition.Value = "Rain"
	game.Lighting:SetMinutesAfterMidnight(1025)
	game:GetService("Lighting").SunRays.Intensity = 0.03999999910593
	game:GetService("Lighting").SunRays.Spread = 1.2000000476837
	game:GetService("Lighting").Bloom.Intensity = 0.40000000596046
	game:GetService("Lighting").Sky.SkyboxBk = "rbxassetid://2506974318"
	game:GetService("Lighting").Sky.SkyboxDn = "rbxassetid://2506974575"
	game:GetService("Lighting").Sky.SkyboxFt = "rbxassetid://2506974238"
	game:GetService("Lighting").Sky.SkyboxLf = "rbxassetid://2506974390"
	game:GetService("Lighting").Sky.SkyboxRt = "rbxassetid://2506974153"
	game:GetService("Lighting").Sky.SkyboxUp = "rbxassetid://2506974467"
	game:GetService("Lighting").Brightness = 0
	game:GetService("Lighting").FogColor = Color3.fromRGB(145.00000655651, 144.00000661612, 138.00000697374)
	game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(118.00000056624, 115.00000074506, 113.00000086427)
end)

local evening = times.AddButton("evening", function()
	game.Lighting.Condition.Value = "Night"
	game.Lighting:SetMinutesAfterMidnight(1020)
	game:GetService("Lighting").SunRays.Intensity = 0.25
	game:GetService("Lighting").SunRays.Spread = 1
	game:GetService("Lighting").Bloom.Intensity = 0.40000000596046
	game:GetService("Lighting").Sky.SkyboxBk = "rbxassetid://271042516"
	game:GetService("Lighting").Sky.SkyboxDn = "rbxassetid://271077243"
	game:GetService("Lighting").Sky.SkyboxFt = "rbxassetid://271042556"
	game:GetService("Lighting").Sky.SkyboxLf = "rbxassetid://271042310"
	game:GetService("Lighting").Sky.SkyboxRt = "rbxassetid://271042467"
	game:GetService("Lighting").Sky.SkyboxUp = "rbxassetid://271077958"
	game:GetService("Lighting").Brightness = 0.69999998807907
	game:GetService("Lighting").FogColor = Color3.fromRGB(253.00000011921, 198.00000339746, 189.00000393391)
	game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(124.00000020862, 92.000002115965, 114.00000080466)
end)

local nuclearw = times.AddButton("Nuclear Winter", function()
	game.Lighting.Condition.Value = "Snowstorm"
	game.Lighting:SetMinutesAfterMidnight(720)
	game:GetService("Lighting").SunRays.Intensity = 0.25
	game:GetService("Lighting").SunRays.Spread = 1
	game:GetService("Lighting").Bloom.Intensity = 0.40000000596046
	game:GetService("Lighting").Sky.SkyboxBk = "rbxassetid://931421737"
	game:GetService("Lighting").Sky.SkyboxDn = "rbxassetid://931421868"
	game:GetService("Lighting").Sky.SkyboxFt = "rbxassetid://931421587"
	game:GetService("Lighting").Sky.SkyboxLf = "rbxassetid://931421672"
	game:GetService("Lighting").Sky.SkyboxRt = "rbxassetid://931421501"
	game:GetService("Lighting").Sky.SkyboxUp = "rbxassetid://931421803"
	game:GetService("Lighting").Brightness = 0
	game:GetService("Lighting").FogColor = Color3.fromRGB(193.00000369549, 193.00000369549, 193.00000369549)
	game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(195.00000357628, 195.00000357628, 195.00000357628)
end)

local morning = times.AddButton("Morning", function()
	game.Lighting.Condition.Value = "Night"
	game.Lighting:SetMinutesAfterMidnight(402)
	game:GetService("Lighting").SunRays.Intensity = 0.25
	game:GetService("Lighting").SunRays.Spread = 1
	game:GetService("Lighting").Bloom.Intensity = 0.40000000596046
	game:GetService("Lighting").Sky.SkyboxBk = "rbxassetid://253027015"
	game:GetService("Lighting").Sky.SkyboxDn = "rbxassetid://253027058"
	game:GetService("Lighting").Sky.SkyboxFt = "rbxassetid://253027039"
	game:GetService("Lighting").Sky.SkyboxLf = "rbxassetid://253027029"
	game:GetService("Lighting").Sky.SkyboxRt = "rbxassetid://253026999"
	game:GetService("Lighting").Sky.SkyboxUp = "rbxassetid://253027050"
	game:GetService("Lighting").Brightness = 0.25
	game:GetService("Lighting").FogColor = Color3.fromRGB(81.000002771616, 107.0000012219, 112.00000092387)
	game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(35.000001713634, 45.000001117587, 61.000000163913)
end)

local sandstorm = times.AddButton("Sandstorm", function()
	game.Lighting.Condition.Value = "Sandstorm"
	game.Lighting:SetMinutesAfterMidnight(720)
	game:GetService("Lighting").SunRays.Intensity = 0.04
	game:GetService("Lighting").SunRays.Spread = 1.2
	game:GetService("Lighting").Bloom.Intensity = 0.4
	game:GetService("Lighting").Sky.SkyboxBk = "rbxassetid://364908114"
	game:GetService("Lighting").Sky.SkyboxDn = "rbxassetid://364908331"
	game:GetService("Lighting").Sky.SkyboxFt = "rbxassetid://364908148"
	game:GetService("Lighting").Sky.SkyboxLf = "rbxassetid://364908195"
	game:GetService("Lighting").Sky.SkyboxRt = "rbxassetid://364908247"
	game:GetService("Lighting").Sky.SkyboxUp = "rbxassetid://364908301"
	game:GetService("Lighting").Brightness =  0
	game:GetService("Lighting").FogColor =  Color3.fromRGB(248, 222, 147)
	game:GetService("Lighting").OutdoorAmbient =  Color3.fromRGB(162, 130, 91)
end)

-- OPTIONS

local DELETEGUI = options.AddButton("Delete gui", function()
	game.CoreGui.StarEssentials:remove()
end)

local killgun = options.AddToggle("Kill gun method", false, function(Value)
	if Value == true then
		variables.killmethodgun = true;
	end
	if Value == false then
		variables.killmethodgun = false;
	end
end)

local kickonmod = options.AddToggle("Kick on mod join", false, function(Value)
	if Value == true then
		variables.kickOnModJoin = true;
	end
	if Value == false then
		variables.kickOnModJoin = false;
	end
end)


-- Players

local copyn = players.AddButton("Copy node", function()
	-- Jugador
	local playerNameClicked = game:GetService("CoreGui").StarEssentials.ContainerFrame.MainFrame.Display.players.PlayerBar.PlayerInput.Text
	-- Objetos

	-- node copy

	local allItems = {};
	function addPropToArray(itemProperties)
		table.insert(allItems, itemProperties);
	end


	addPropToArray({"Dumpster", "73.999999642372"});
	addPropToArray({"Bust Statue Hat", "49.40000000596"});
	addPropToArray({"Barricade", "54.999992370605"});
	addPropToArray({"Shelves Lounge", "34.477004051208"});
	addPropToArray({"Plant Tree Small", "39.281250119209"});
	addPropToArray({"Chair Stool", "7.1212601661682"});
	addPropToArray({"Easel", "37.199998617172"});
	addPropToArray({"Couch Booth", "68.700000956655"});
	addPropToArray({"Canopy Fabric", "50.324487686157"});
	addPropToArray({"Railing", "28.300001144409"});
	addPropToArray({"Dressing Stand", "54.970696628094"});
	addPropToArray({"Clock Grandfather", "48.35000000149"});
	addPropToArray({"Bench White", "90.634871721268"});
	addPropToArray({"Dryer", "26.699999988079"});
	addPropToArray({"Map Board", "53.778938695788"});
	addPropToArray({"Desk Big", "133.5000000298"});
	addPropToArray({"Bunk Bed", "258.99999608099"});
	addPropToArray({"Box Small", "8.4375"});
	addPropToArray({"Ladder Wood", "64.5"});
	addPropToArray({"Game Table", "93.775068819523"});
	addPropToArray({"Sofa Red", "47.900000810623"});
	addPropToArray({"Fabric Overhead", "26.324487686157"});
	addPropToArray({"Table Coffee", "21.5"});
	addPropToArray({"Street Lamp", "65.10001373291"});
	addPropToArray({"Table Lounge", "29.75"});
	addPropToArray({"Plastic Table", "28.25"});
	addPropToArray({"Bottles Tall", "57"});
	addPropToArray({"Cabinets", "21.13872385025"});
	addPropToArray({"Table X", "41.662277579308"});
	addPropToArray({"Computer Screens", "78.196396231651"});
	addPropToArray({"Bench", "16.025469303131"});
	addPropToArray({"Logs", "20.819108009338"});
	addPropToArray({"Night Stand", "52.999983936548"});
	addPropToArray({"Table", "46.3703237921"});
	addPropToArray({"Chair Picnic", "12.501653194427"});
	addPropToArray({"Couch Small", "32.104417800903"});
	addPropToArray({"Generator", "39.463157773018"});
	addPropToArray({"Bed", "73.868103116751"});
	addPropToArray({"Register", "11.199994087219"});
	addPropToArray({"Ammo Box", "8.8533323407173"});
	addPropToArray({"Shelves", "58.25"});
	addPropToArray({"Chair Comfort", "27.039119243622"});
	addPropToArray({"Bench Modern", "34.25"});
	addPropToArray({"Table Booth", "20.800000011921"});
	addPropToArray({"Computer Scifi", "53.875"});
	addPropToArray({"Desk Small", "62.312395974994"});
	addPropToArray({"Bag", "14.172916173935"});
	addPropToArray({"Gun Rack", "40.814584851265"});
	addPropToArray({"Table Round", "32.800000160933"});
	addPropToArray({"Papers", "35.800000078976"});
	addPropToArray({"Couch White", "49.852519154549"});
	addPropToArray({"Plant", "13.493908643723"});
	addPropToArray({"Couch Lounge", "54.625000953674"});
	addPropToArray({"Chair Lounge", "37.25"});
	addPropToArray({"Plant Tree", "75.562500238419"});
	addPropToArray({"Bust Statue", "42.40000000596"});
	addPropToArray({"Dresser Long", "106.79998357594"});
	addPropToArray({"Sink", "16.000000119209"});
	addPropToArray({"Tub", "22.838701248169"});
	addPropToArray({"Table Long", "42.666665047407"});
	addPropToArray({"Sandbags", "28.201997280121"});
	addPropToArray({"Cabinet Filing", "16.500000923872"});
	addPropToArray({"Computer", "26.055407680571"});
	addPropToArray({"Chair", "19.256631344557"});
	addPropToArray({"Podium", "20.800003483891"});
	addPropToArray({"Sci Fi", "51.259048700333"});
	addPropToArray({"Long Shelves", "78.300012856722"});
	addPropToArray({"Box", "9.9375"});
	addPropToArray({"Computer Set-up", "51.254103973508"});
	addPropToArray({"Shelves Store", "52.024270653725"});
	addPropToArray({"Camp Food", "48.442285079509"});
	addPropToArray({"Book Shelves", "97.422241687775"});
	addPropToArray({"Rat Candle", "37.966639995575"});
	addPropToArray({"Chair Beanbag", "14.30319237709"});
	addPropToArray({"Board", "95.929889678955"});
	addPropToArray({"Chair Folding", "10.11127614975"});
	addPropToArray({"Washer", "26.75"});
	addPropToArray({"Bottles Small", "38.549999892712"});
	addPropToArray({"Desk Low", "33.420437626541"});
	addPropToArray({"Desk", "73.399993047118"});
	addPropToArray({"Furnace", "60.649999566376"});
	addPropToArray({"Starlight", "20.715383768082"});
	addPropToArray({"Telephone Pole Light", "65.849999576807"});
	addPropToArray({"Lamp", "16.582590252161"});
	addPropToArray({"Floor Lamp", "9.4999998956919"});
	addPropToArray({"Lamp Prisim", "11.000000953674"});
	addPropToArray({"Lamp WallStreet", "19"});
	addPropToArray({"Spotlight", "10.89999973774"});
	addPropToArray({"Lamp Small", "12.582590252161"});
	addPropToArray({"House Wasteland2", "1103.7285881341"});
	addPropToArray({"Saloon Adobe", "1348.8256006762"});
	addPropToArray({"Old Warehouse", "2169.1924418211"});
	addPropToArray({"House Wasteland", "866.5"});
	addPropToArray({"Garage Wasteland", "768"});
	addPropToArray({"Wooden Wall Thick (2x3)", "39.5"});
	addPropToArray({"Wooden Wall (2x3)", "38.5"});
	addPropToArray({"Wooden Wall Thick (1x2)", "25.5"});
	addPropToArray({"Wooden Wall Thick (1x3)", "32.5"});
	addPropToArray({"Wooden Wall (2x2)", "31.5"});
	addPropToArray({"Fence", "43.326451078057"});
	addPropToArray({"Wooden Wall (1x2)", "24.5"});
	addPropToArray({"Wooden Wall Thick (2x2)", "32.5"});
	addPropToArray({"Counter (1x2)", "37.600000143051"});
	addPropToArray({"Wooden Wall (1x3)", "31.5"});
	addPropToArray({"Slot Machine", "67.245401829481"});
	addPropToArray({"Taps", "36.375"});
	addPropToArray({"Register Shop", "20.541307538748"});
	addPropToArray({"Shop Beacon", "53.224999696016"});
	addPropToArray({"Killzone Board", "29.705087780952"});
	addPropToArray({"Piano Tall", "34.199897825718"});
	addPropToArray({"Soda Machine", "50.5"});
	addPropToArray({"Fuel Station Saturn", "48.061149220914"});
	addPropToArray({"Dispencer", "52.273146498948"});
	addPropToArray({"Vending Machine", "42.547998577356"});
	addPropToArray({"Billboard Sign 1", "15.25"});
	addPropToArray({"Door Double", "110.00000275671"});
	addPropToArray({"Door", "34.749816894531"});
	addPropToArray({"Door Vault", "49.000025033951"});



	function getItemNameFromId(itemId)
		for i,v in pairs(allItems) do
			if v[2] == tostring(itemId) then
				return tostring(v[1]);
			end
		end
		return "";
	end

	-- Copiar
	notice = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Note");
	wassuccessyy = false;
	pcall(function()			
		if game:GetService("Workspace").Buildings[playerNameClicked].Node.Name == "Node" then
			pcall(function()
				fullStringOutput = "--Staressentials node copier\n--Please execute this as a script in a new server to paste the node!\n--Please report bugs to https://discord.gg/ewKCVhCpDB\n\nGame:GetService(\"ReplicatedStorage\").Events.BuildingEvent:FireServer(1, \"Node\", CFrame.new(" .. tostring(game:GetService("Workspace").Buildings[playerNameClicked].Node.PrimaryPart.CFrame) .. "));\n";


				for i,v in pairs(game:GetService("Workspace").Buildings[playerNameClicked]:GetChildren()) do
					pcall(function()
						if v.Name ~= "Node" then
							if v.Name == "" then
								unqId = 0;
								for i1,v1 in pairs(v:GetChildren()) do
									pcall(function()
										size = v1.Size;
										unqId = unqId + (size.X + size.Y + size.Z);
									end)
								end
								if unqId ~= 0 then
									if getItemNameFromId(unqId) ~= "" then
										print("Item found!: " .. getItemNameFromId(unqId));
										matRep = tostring(v.PrimaryPart.Material):gsub("Enum.Material.", "");
										fullStringOutput = fullStringOutput .. "Game:GetService(\"ReplicatedStorage\").Events.BuildingEvent:FireServer(1, \"" .. getItemNameFromId(unqId) .. "\", CFrame.new(" .. tostring(v.PrimaryPart.CFrame) .. "), nil, BrickColor.new(\"" .. tostring(v.PrimaryPart.BrickColor) .. "\"), nil, nil, \"" .. tostring(matRep) .. "\");\n";
									end
								end
							elseif v.Name == "Resizable Wall" then
								fullStringOutput = fullStringOutput .. "Game:GetService(\"ReplicatedStorage\").Events.BuildingEvent:FireServer(1, \"" .. v.Name .. "\", CFrame.new(" .. tostring(v.PrimaryPart.CFrame) .. "));\n";
								fullStringOutput = fullStringOutput .. "wait(0.5); lastWall = nil; for i,v in pairs(game:GetService(\"Workspace\").Buildings[game.Players.LocalPlayer.Name]:GetChildren()) do if v.Name == \"Resizable Wall\" then lastWall = v; end end Game:GetService(\"ReplicatedStorage\").Events.BuildingEvent:FireServer(7, lastWall, lastWall.PrimaryPart.CFrame, nil, Vector3.new(" .. tostring(v.PrimaryPart.Size) .. "));\n";
								matRep = tostring(v.PrimaryPart.Material):gsub("Enum.Material.", "");
								fullStringOutput = fullStringOutput .. "wait(0.5); lastWall = nil; for i,v in pairs(game:GetService(\"Workspace\").Buildings[game.Players.LocalPlayer.Name]:GetChildren()) do if v.Name == \"Resizable Wall\" then lastWall = v; end end Game:GetService(\"ReplicatedStorage\").Events.BuildingEvent:FireServer(5, lastWall, lastWall.PrimaryPart.CFrame, nil, BrickColor.new(\"" .. tostring(v.PrimaryPart.BrickColor) .. "\"), nil, nil, \"" .. tostring(matRep) .. "\");\n";
							elseif string.match(v.Name, "Picture Sign") then
								fullStringOutput = fullStringOutput .. "Game:GetService(\"ReplicatedStorage\").Events.BuildingEvent:FireServer(1, \"" .. v.Name .. "\", CFrame.new(" .. tostring(v.PrimaryPart.CFrame) .. "));\n";
								pictureId = tostring(v.Part.SurfaceGui["1"].Image):gsub("rbxassetid://", "");
								fullStringOutput = fullStringOutput .. "wait(0.5); lastWall = nil; for i,v in pairs(game:GetService(\"Workspace\").Buildings[game.Players.LocalPlayer.Name]:GetChildren()) do if string.match(v.Name, \"Picture Sign\") then lastWall = v; end end Game:GetService(\"ReplicatedStorage\").Events.MenuActionEvent:FireServer(29, lastWall, {\"" .. pictureId .. "\"});\n";
							elseif string.match(v.Name, "Billboard Sign") then
								fullStringOutput = fullStringOutput .. "Game:GetService(\"ReplicatedStorage\").Events.BuildingEvent:FireServer(1, \"" .. v.Name .. "\", CFrame.new(" .. tostring(v.PrimaryPart.CFrame) .. "));\n";
								textOnSign = tostring(tostring(v.Part.SurfaceGui["1"].Text):gsub("\"", "\\\""):gsub("\\", "\\\\"));
								textOnSign = tostring(textOnSign):gsub("\n", "\\n");
								fullStringOutput = fullStringOutput .. "wait(0.5); lastWall = nil; for i,v in pairs(game:GetService(\"Workspace\").Buildings[game.Players.LocalPlayer.Name]:GetChildren()) do if string.match(v.Name, \"Billboard Sign\") then lastWall = v; end end Game:GetService(\"ReplicatedStorage\").Events.MenuActionEvent:FireServer(7, lastWall, {\"" .. textOnSign .. "\"});\n";
							else
								fullStringOutput = fullStringOutput .. "Game:GetService(\"ReplicatedStorage\").Events.BuildingEvent:FireServer(1, \"" .. v.Name .. "\", CFrame.new(" .. tostring(v.PrimaryPart.CFrame) .. "));\n";
							end
						end
					end)
				end
			end)

			nodeCopyName = "Node_copy_" .. playerNameClicked .. math.random(1,100) .. ".txt";
			writefile(nodeCopyName, fullStringOutput .. "\nprint(\"Staressentials - Pasted node!\")");
			notice:Fire("Staressentials", "Saved all available data to " .. nodeCopyName);
			wassuccessyy = true;
		else
			notice:Fire("Staressentials", "Error, does that player have a node?", 4);
		end
	end)
	if wassuccessyy == false then
		notice:Fire("Staressentials", "Error, does that player have a node?", 4);
	end
end)

local Kill = players.AddButton("Kill", function()
	local jugador = game:GetService("CoreGui").StarEssentials.ContainerFrame.MainFrame.Display.players.PlayerBar.PlayerInput.Text
	local pos2 = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[jugador].Character.HumanoidRootPart.CFrame
	if variables.killmethodgun then
		local Player = game:GetService("Players").LocalPlayer
		local character = Player.Character or Player.CharacterAdded:Wait()
		local HumanoidRootPart = character:WaitForChild("HumanoidRootPart")
		local Humanoid =  character:WaitForChild("Humanoid")

		wait(1)
		Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(33, game:GetService("Workspace")[jugador].HumanoidRootPart.CFrame, 1, game:GetService("Workspace")[jugador].Humanoid, 26, game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool"));
		wait(0.2)
		Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(33, game:GetService("Workspace")[jugador].HumanoidRootPart.CFrame, 1, game:GetService("Workspace")[jugador].Humanoid, 26, game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool"));
		wait(0.2)
		Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(33, game:GetService("Workspace")[jugador].HumanoidRootPart.CFrame, 1, game:GetService("Workspace")[jugador].Humanoid, 26, game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool"));
		wait(0.2)
		Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(33, game:GetService("Workspace")[jugador].HumanoidRootPart.CFrame, 1, game:GetService("Workspace")[jugador].Humanoid, 26, game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool"));
		wait(0.2);
		Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(33, game:GetService("Workspace")[jugador].HumanoidRootPart.CFrame, 1, game:GetService("Workspace")[jugador].Humanoid, 26, game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool"));
		wait(0.2);
		Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(33, game:GetService("Workspace")[jugador].HumanoidRootPart.CFrame, 1, game:GetService("Workspace")[jugador].Humanoid, 26, game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool"));
		wait(0.2);
		Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(33, game:GetService("Workspace")[jugador].HumanoidRootPart.CFrame, 1, game:GetService("Workspace")[jugador].Humanoid, 26, game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool"));

	else
		for count = 1, 10 do
			wait(0.1)
			local ohNumber1 = 34
			local ohInstance2 = game.Workspace[jugador].Humanoid
			local ohCFrame3 = CFrame.new(-139.816254, 141.651443, 0.956251562, -0.772362351, -0.303539932, 0.557960451, -1.49011612e-08, 0.878425837, 0.477878571, -0.635182142, 0.369095415, -0.678463101)

			game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(ohNumber1, ohInstance2, ohCFrame3)
		end
	end
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos2
end)


local rears = players.AddButton("Rape ears", function()
	local jugadors = game:GetService("CoreGui").StarEssentials.ContainerFrame.MainFrame.Display.players.PlayerBar.PlayerInput.Text
	for i=1,100 do
		game.ReplicatedStorage.Events:WaitForChild("mpib"):FireServer(game.Players[jugadors].Character.HumanoidRootPart, 13);
		wait();
	end	
	notice:Fire("StarEssentials", "Ear rape'd " + jugadors + "!");
end)

local rearst = players.AddButton("Rape ears all server", function()
	notice = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Note");
	notice:Fire("Staressentials", "Loading, please wait...");
	for i1,v1 in pairs(game.Players:GetChildren()) do
		pcall(function()
			for i=1,100 do
				game.ReplicatedStorage.Events:WaitForChild("mpib"):FireServer(v1.Character.HumanoidRootPart, 13);
				wait();
			end
		end)
	end

	notice:Fire("StarEssentials", "Ear rape'd all players!");
end)

local joing = players.AddButton("Join game", function()
	local variables = {}

	variables.hasDoneCheck1 = false;

	notice = Game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Note");

	HttpService = game:GetService("HttpService")

	pcall(function()
		if syn.request then
			function httprequesty(url)
				return syn.request({
					Url = url,
					Method = "GET" }).Body;
			end
		else
			function httprequesty(url)
				return game:HttpGet(url);
			end
		end
		variables.hasDoneCheck1 = true;
	end)

	function HttpGet(url)
		return HttpService:JSONDecode(httprequesty(url))
	end


	function Status(text)
		notice:Fire("StarEssentials", text);
	end

	Status("Thank you synapse! Scanning games...")
	usernameToJoin = game:GetService("CoreGui").StarEssentials.ContainerFrame.MainFrame.Display.players.PlayerBar.PlayerInput.Text
	UserId = game:GetService("Players"):GetUserIdFromNameAsync(usernameToJoin)

	Thumbnail = HttpGet("https://www.roblox.com/headshot-thumbnail/json?userId=" .. UserId .. "&width=48&height=48").Url

	local Index = 0
	while true do
		local GameInstances = HttpGet("https://loell.ca/api.php?startindex=" .. Index)
		for I,V in pairs(GameInstances.Collection) do
			for I2,V2 in pairs(V.CurrentPlayers) do
				if V2.Id == UserId or V2.Thumbnail.Url == Thumbnail then
					Status("Complete!")
					game:GetService("TeleportService"):TeleportToPlaceInstance(2262441883, V.Guid)
					local FailCounter = 0
					game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
						if State == Enum.TeleportState.Failed then
							FailCounter = FailCounter + 1
							Status("Failed to teleport. (retry " .. tostring(FailCounter) .. ")")
							game:GetService("TeleportService"):TeleportToPlaceInstance(2262441883, V.Guid)
						end
					end)
					return
				end
			end
		end
		Status("Stage 3 (" .. tostring(Index) .. "/" .. tostring(GameInstances.TotalCollectionSize) .. " servers scanned)...")
		if Index > GameInstances.TotalCollectionSize then
			return Status("Failed to get user's game!")
		end
		if Kill then
			Kill = false
			Debounce = false
			Status("Cancelled.")
			return
		end
		Index = Index + 10
	end
end)

local baseplate = teleports.AddButton("Baseplate", function()
	if variables.deathBarrierBypassEnabled then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0);
	else
		notice:Fire("StarEssentials", "Enable bypass barriers!");
	end
end)

local TP = players.AddButton("TP", function()
	local jugador = game:GetService("CoreGui").StarEssentials.ContainerFrame.MainFrame.Display.players.PlayerBar.PlayerInput.Text
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[jugador].Character.HumanoidRootPart.CFrame
end)

local TPNODE = players.AddButton("TP NODE", function()
	local jugador = game:GetService("CoreGui").StarEssentials.ContainerFrame.MainFrame.Display.players.PlayerBar.PlayerInput.Text
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Buildings[jugador].Node.PrimaryPart.CFrame + Vector3.new(0,10,0)
end)

local stealo = players.AddButton("Steal Outfit", function()
	notice = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Note");
	-- HTTP y variables
	HttpService = game:GetService("HttpService")

	function httprequesty(url)
		return game:HttpGet(url);
	end



	function HttpGet(url)
		return HttpService:JSONDecode(httprequesty(url))
	end
	notice = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Note");

	-- STEAL OUTFIT CALL
	local http = game:GetService('HttpService')
	function getOutfits(id)
		local data
		local url = 'https://avatar.rprxy.xyz/v1/users/'..id..'/avatar'
		data =  http:JSONDecode(game:HttpGet(url,true))
		local tables = data.assets
		local stuff = {}
		for i = 1,#tables do
			local subTables = tables[i]
			local id = subTables["id"]
			table.insert(stuff,id)
		end
		return stuff
	end
	-- steal 2
	local playerToSteal = game:GetService("Players")[game:GetService("CoreGui").StarEssentials.ContainerFrame.MainFrame.Display.players.PlayerBar.PlayerInput.Text];
	local daOutfits = getOutfits(playerToSteal.UserId);
	local curOutfitString = "";
	for _asd, vp in pairs(daOutfits) do
		curOutfitString = curOutfitString .. vp .. ","
	end
	game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(8, { playerToSteal.PlayerData.RoleplayName.Value, curOutfitString .. playerToSteal.PlayerData.Outfit.Value, true });
	notice:Fire("StarEssentials", "You have stolen their outfit!");
end)

local stealoclip = players.AddButton("Steal outfit id (clipboard)", function()
	notice = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Note");
	-- HTTP y variables
	HttpService = game:GetService("HttpService")

	function httprequesty(url)
		return game:HttpGet(url);
	end



	function HttpGet(url)
		return HttpService:JSONDecode(httprequesty(url))
	end
	notice = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Note");

	-- STEAL OUTFIT CALL
	local http = game:GetService('HttpService')
	function getOutfits(id)
		local data
		local url = 'https://avatar.rprxy.xyz/v1/users/'..id..'/avatar'
		data =  http:JSONDecode(game:HttpGet(url,true))
		local tables = data.assets
		local stuff = {}
		for i = 1,#tables do
			local subTables = tables[i]
			local id = subTables["id"]
			table.insert(stuff,id)
		end
		return stuff
	end
	-- Steal 1
	local jugador = "danizo"
	local Players = game:GetService("Players")
	local playerToSteal = Players:GetUserIdFromNameAsync(jugador)
	local daOutfits = getOutfits(playerToSteal);
	local curOutfitString = "";
	for _asd, vp in pairs(daOutfits) do
		curOutfitString = curOutfitString .. vp .. ","
	end
	Game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(8, { jugador, curOutfitString, true });
	notice:Fire("Staressentials", "Copied their outfit id's to clipboard!");
end)

local mediheal = players.AddToggle("Medi Auto Heal", false, function(Value)
	local jugador = game:GetService("CoreGui").StarEssentials.ContainerFrame.MainFrame.Display.players.PlayerBar.PlayerInput.Text
	while Value == true do
		wait(0.1)
		local ohNumber1 = 5
		local ohInstance2 = workspace[jugador].Humanoid

		game:GetService("ReplicatedStorage").Events.ToolsEvent:FireServer(ohNumber1, ohInstance2)
	end
end)

-- localplayer


local fullbright = localps.AddToggle("FullBright", false, function(Value)
	if Value == true then
		if not _G.FullBrightExecuted then

			_G.FullBrightEnabled = false

			_G.NormalLightingSettings = {
				Brightness = game:GetService("Lighting").Brightness,
				ClockTime = game:GetService("Lighting").ClockTime,
				FogEnd = game:GetService("Lighting").FogEnd,
				GlobalShadows = game:GetService("Lighting").GlobalShadows,
				Ambient = game:GetService("Lighting").Ambient
			}

			game:GetService("Lighting"):GetPropertyChangedSignal("Brightness"):Connect(function()
				if game:GetService("Lighting").Brightness ~= 1 and game:GetService("Lighting").Brightness ~= _G.NormalLightingSettings.Brightness then
					_G.NormalLightingSettings.Brightness = game:GetService("Lighting").Brightness
					if not _G.FullBrightEnabled then
						repeat
							wait()
						until _G.FullBrightEnabled
					end
					game:GetService("Lighting").Brightness = 1
				end
			end)

			game:GetService("Lighting"):GetPropertyChangedSignal("ClockTime"):Connect(function()
				if game:GetService("Lighting").ClockTime ~= 12 and game:GetService("Lighting").ClockTime ~= _G.NormalLightingSettings.ClockTime then
					_G.NormalLightingSettings.ClockTime = game:GetService("Lighting").ClockTime
					if not _G.FullBrightEnabled then
						repeat
							wait()
						until _G.FullBrightEnabled
					end
					game:GetService("Lighting").ClockTime = 12
				end
			end)

			game:GetService("Lighting"):GetPropertyChangedSignal("FogEnd"):Connect(function()
				if game:GetService("Lighting").FogEnd ~= 786543 and game:GetService("Lighting").FogEnd ~= _G.NormalLightingSettings.FogEnd then
					_G.NormalLightingSettings.FogEnd = game:GetService("Lighting").FogEnd
					if not _G.FullBrightEnabled then
						repeat
							wait()
						until _G.FullBrightEnabled
					end
					game:GetService("Lighting").FogEnd = 786543
				end
			end)

			game:GetService("Lighting"):GetPropertyChangedSignal("GlobalShadows"):Connect(function()
				if game:GetService("Lighting").GlobalShadows ~= false and game:GetService("Lighting").GlobalShadows ~= _G.NormalLightingSettings.GlobalShadows then
					_G.NormalLightingSettings.GlobalShadows = game:GetService("Lighting").GlobalShadows
					if not _G.FullBrightEnabled then
						repeat
							wait()
						until _G.FullBrightEnabled
					end
					game:GetService("Lighting").GlobalShadows = false
				end
			end)

			game:GetService("Lighting"):GetPropertyChangedSignal("Ambient"):Connect(function()
				if game:GetService("Lighting").Ambient ~= Color3.fromRGB(178, 178, 178) and game:GetService("Lighting").Ambient ~= _G.NormalLightingSettings.Ambient then
					_G.NormalLightingSettings.Ambient = game:GetService("Lighting").Ambient
					if not _G.FullBrightEnabled then
						repeat
							wait()
						until _G.FullBrightEnabled
					end
					game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
				end
			end)

			game:GetService("Lighting").Brightness = 1
			game:GetService("Lighting").ClockTime = 12
			game:GetService("Lighting").FogEnd = 786543
			game:GetService("Lighting").GlobalShadows = false
			game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)

			local LatestValue = true
			spawn(function()
				repeat
					wait()
				until _G.FullBrightEnabled
				while wait() do
					if _G.FullBrightEnabled ~= LatestValue then
						if not _G.FullBrightEnabled then
							game:GetService("Lighting").Brightness = _G.NormalLightingSettings.Brightness
							game:GetService("Lighting").ClockTime = _G.NormalLightingSettings.ClockTime
							game:GetService("Lighting").FogEnd = _G.NormalLightingSettings.FogEnd
							game:GetService("Lighting").GlobalShadows = _G.NormalLightingSettings.GlobalShadows
							game:GetService("Lighting").Ambient = _G.NormalLightingSettings.Ambient
						else
							game:GetService("Lighting").Brightness = 1
							game:GetService("Lighting").ClockTime = 12
							game:GetService("Lighting").FogEnd = 786543
							game:GetService("Lighting").GlobalShadows = false
							game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
						end
						LatestValue = not LatestValue
					end
				end
			end)
		end

		_G.FullBrightExecuted = true
		_G.FullBrightEnabled = not _G.FullBrightEnabled
	end
	if Value == false then
		if not _G.FullBrightExecuted then

			_G.FullBrightEnabled = false

			_G.NormalLightingSettings = {
				Brightness = game:GetService("Lighting").Brightness,
				ClockTime = game:GetService("Lighting").ClockTime,
				FogEnd = game:GetService("Lighting").FogEnd,
				GlobalShadows = game:GetService("Lighting").GlobalShadows,
				Ambient = game:GetService("Lighting").Ambient
			}

			game:GetService("Lighting"):GetPropertyChangedSignal("Brightness"):Connect(function()
				if game:GetService("Lighting").Brightness ~= 1 and game:GetService("Lighting").Brightness ~= _G.NormalLightingSettings.Brightness then
					_G.NormalLightingSettings.Brightness = game:GetService("Lighting").Brightness
					if not _G.FullBrightEnabled then
						repeat
							wait()
						until _G.FullBrightEnabled
					end
					game:GetService("Lighting").Brightness = 1
				end
			end)

			game:GetService("Lighting"):GetPropertyChangedSignal("ClockTime"):Connect(function()
				if game:GetService("Lighting").ClockTime ~= 12 and game:GetService("Lighting").ClockTime ~= _G.NormalLightingSettings.ClockTime then
					_G.NormalLightingSettings.ClockTime = game:GetService("Lighting").ClockTime
					if not _G.FullBrightEnabled then
						repeat
							wait()
						until _G.FullBrightEnabled
					end
					game:GetService("Lighting").ClockTime = 12
				end
			end)

			game:GetService("Lighting"):GetPropertyChangedSignal("FogEnd"):Connect(function()
				if game:GetService("Lighting").FogEnd ~= 786543 and game:GetService("Lighting").FogEnd ~= _G.NormalLightingSettings.FogEnd then
					_G.NormalLightingSettings.FogEnd = game:GetService("Lighting").FogEnd
					if not _G.FullBrightEnabled then
						repeat
							wait()
						until _G.FullBrightEnabled
					end
					game:GetService("Lighting").FogEnd = 786543
				end
			end)

			game:GetService("Lighting"):GetPropertyChangedSignal("GlobalShadows"):Connect(function()
				if game:GetService("Lighting").GlobalShadows ~= false and game:GetService("Lighting").GlobalShadows ~= _G.NormalLightingSettings.GlobalShadows then
					_G.NormalLightingSettings.GlobalShadows = game:GetService("Lighting").GlobalShadows
					if not _G.FullBrightEnabled then
						repeat
							wait()
						until _G.FullBrightEnabled
					end
					game:GetService("Lighting").GlobalShadows = false
				end
			end)

			game:GetService("Lighting"):GetPropertyChangedSignal("Ambient"):Connect(function()
				if game:GetService("Lighting").Ambient ~= Color3.fromRGB(178, 178, 178) and game:GetService("Lighting").Ambient ~= _G.NormalLightingSettings.Ambient then
					_G.NormalLightingSettings.Ambient = game:GetService("Lighting").Ambient
					if not _G.FullBrightEnabled then
						repeat
							wait()
						until _G.FullBrightEnabled
					end
					game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
				end
			end)

			game:GetService("Lighting").Brightness = 1
			game:GetService("Lighting").ClockTime = 12
			game:GetService("Lighting").FogEnd = 786543
			game:GetService("Lighting").GlobalShadows = false
			game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)

			local LatestValue = true
			spawn(function()
				repeat
					wait()
				until _G.FullBrightEnabled
				while wait() do
					if _G.FullBrightEnabled ~= LatestValue then
						if not _G.FullBrightEnabled then
							game:GetService("Lighting").Brightness = _G.NormalLightingSettings.Brightness
							game:GetService("Lighting").ClockTime = _G.NormalLightingSettings.ClockTime
							game:GetService("Lighting").FogEnd = _G.NormalLightingSettings.FogEnd
							game:GetService("Lighting").GlobalShadows = _G.NormalLightingSettings.GlobalShadows
							game:GetService("Lighting").Ambient = _G.NormalLightingSettings.Ambient
						else
							game:GetService("Lighting").Brightness = 1
							game:GetService("Lighting").ClockTime = 12
							game:GetService("Lighting").FogEnd = 786543
							game:GetService("Lighting").GlobalShadows = false
							game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
						end
						LatestValue = not LatestValue
					end
				end
			end)
		end

		_G.FullBrightExecuted = false
		_G.FullBrightEnabled = not _G.FullBrightEnabled
	end
end)


local Brightness = localps.AddSlider("Brightness", {Min = 0, Max = 5, Def = 1}, function(Value)
	game:GetService("Lighting").Brightness = Value
end)

local walks = localps.AddToggle("Walkspeed", false, function(Value)
	if Value == true then
		local gmt = getrawmetatable(game)
		setreadonly(gmt, false)
		local oldindex = gmt.__index
		gmt.__index = newcclosure(function(self,b)
			if b == "WalkSpeed" then
				return 16
			end
			return oldindex(self,b)
		end)


		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed=500
	end
	if Value == false then
		local gmt = getrawmetatable(game)
		setreadonly(gmt, false)
		local oldindex = gmt.__index
		gmt.__index = newcclosure(function(self,b)
			if b == "WalkSpeed" then
				return 16
			end
			return oldindex(self,b)
		end)


		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed=16
	end
end)


local jumpp = localps.AddToggle("JumpPower", false, function(Value)
	if Value == true then
		local gmt = getrawmetatable(game)
		setreadonly(gmt, false)
		local oldindex = gmt.__index
		gmt.__index = newcclosure(function(self,b)
			if b == "JumpPower" then
				return 16
			end
			return oldindex(self,b)
		end)


		game.Players.LocalPlayer.Character.Humanoid.JumpPower=120
	end
	if Value == false then
		local gmt = getrawmetatable(game)
		setreadonly(gmt, false)
		local oldindex = gmt.__index
		gmt.__index = newcclosure(function(self,b)
			if b == "JumpPower" then
				return 16
			end
			return oldindex(self,b)
		end)


		game.Players.LocalPlayer.Character.Humanoid.JumpPower=60
	end
end)

local deathbarrier = localps.AddToggle("Bypass death barriers", false, function(Value)
	if Value == true then
		_G.deathBarrierBypassEnabled = true
		variables.deathBarrierBypassEnabled = true;
		notice:Fire("Staressentials", "Bypass death barriers enabled", 1);
	end
	if Value == false then
		_G.deathBarrierBypassEnabled = false
		variables.deathBarrierBypassEnabled = false;
	end
	notice:Fire("Staressentials", "Bypass death barriers disabled", 1);
end)


local jetpack = localps.AddButton("JetPack", function()
	notice = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Note");
	local clientzzz = game:GetService("Players").LocalPlayer
	local model = Instance.new("Model")
	model.Name = "Jetpack"
	local main = Instance.new("Part")
	main.Name = "Main"
	main.Parent = model
	model.Parent = game:GetService("Workspace")[clientzzz.Name].Util

	notice:Fire("StarEssentials", "Done! Press y to activate jetpack!");
end)


local tpcar = localps.AddButton("TP NEAR CAR", function()
	function GetClosestVehicle()
		local lplayer = game.Players.LocalPlayer
		local Character = lplayer.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		if not (Character or HumanoidRootPart) then return end
		local TargetDistance = math.huge
		local Target
		for i,v in ipairs(game:GetService("Workspace").Vehicles:GetChildren()) do
			pcall(function()
				if v.Main then
					local TargetHRP = v.Main
					local mag = (HumanoidRootPart.Position - TargetHRP.Position).magnitude
					if mag < TargetDistance then
						TargetDistance = mag
						Target = v
					end
				end
			end)
		end

		return Target
	end
	game:GetService("ReplicatedStorage").Events.InteractEvent:FireServer(GetClosestVehicle().VehicleSeat);
end)



local invisible = localps.AddButton("Invisible", function()
	notice = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Note");
	isdoneee = false;

	pcall(function()
		game.Players.LocalPlayer.Character.LowerTorso.Root:Destroy();
		game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = false;
		game.Players.LocalPlayer.Character.UpperTorso.Anchored = true;
		game.Players.LocalPlayer.Character.UpperTorso.CanCollide = false;
		game.Players.LocalPlayer.Character.HumanoidRootPart.Transparency = 0;
		isdoneee = true;
		notice:Fire("Staressentials", "Made your player invisible to others!");
	end)
	if isdoneee == false then
		notice:Fire("Staressentials", "Error! Maybe your already invisible?", 4);
	end
end)



local Infjump = localps.AddToggle("Inf jump", false, function(Value)
	if Value == true then
		_G.infinjump = true
	end
	if Value == false then
		_G.infinjump = false
	end
end)


local hitbox = combat.AddToggle("Hitbox Expander", false, function(Value)
	if Value == true then
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			pcall(function()
				if v ~= game:GetService("Players").LocalPlayer then
					v.Character.HumanoidRootPart.Size = Vector3.new(20,20,20);						
					v.Character.HumanoidRootPart.Transparency = 0.7;
					v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Bright green");
					v.Character.HumanoidRootPart.Material = "Neon";
					v.Character.HumanoidRootPart.CanCollide = false;
				end
			end)
		end
		notice:Fire("StarEssentials", "Hitbox Expander enabled.");
	end
	if Value == false then
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			pcall(function()
				if v ~= game:GetService("Players").LocalPlayer then
					v.Character.HumanoidRootPart.Size = Vector3.new(2,2,1)
					v.Character.HumanoidRootPart.CanCollide = true
				end
			end)
		end
		notice:Fire("StarEssentials", "Hitbox Expander disabled.");
	end
end)


local noclip = localps.AddToggle("NoClip", false, function(Value)
	if Value == true then
		noclip = not noclip
		game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
	end
	if Value == false then
		noclip = not noclip
		game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
	end
end)

local freeze = localps.AddToggle("Freeze", false, function(Value)
	if Value == true then
		game.Players.LocalPlayer.Character.Head.Anchored = true
	end
	if Value == false then
		game.Players.LocalPlayer.Character.Head.Anchored = false
	end
end)

local PVP = localps.AddToggle("PVP", false, function(Value)
	if Value == true then
		local ohNumber1 = 6
		local ohBoolean2 = true

		game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(ohNumber1, ohBoolean2)
	end
	if Value == false then
		local ohNumber1 = 6
		local ohBoolean2 = false

		game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(ohNumber1, ohBoolean2)
	end
end)

local ESPTOGGLE = localps.AddToggle("ESP", false, function(Value)
	if Value == true then
		ESP:Toggle(true)
	end
	if Value == false then
		ESP:Toggle(false)
	end
end)

local NLR = localps.AddToggle("ANTI NLR", false, function(Value)
	if Value == true then
		while true do
			wait(0.1)
			local NLR = workspace:FindFirstChild("NL")
			if NLR ~= nil and typeof(NLR) == "Instance" then
				if NLR:FindFirstChild("NL") then
					NLR:Destroy()
				end
			end
		end
	end
	if Value == false then
		print("set ANTI NLR false!")
	end
end)

-- TROLL

local M1911 = troll.AddToggle("M1911 EFFECT SPAM", false, function(Value)
	repeat
		local ohNumber1 = 33
		local ohCFrame2 = CFrame.new(-346.391754, 130.287308, -403.861359, -0, 0.999725401, 0.0234374516, -0.0253975485, 0.023429893, -0.999402881, -0.999677479, -0.000595253834, 0.0253905728)
		local ohNumber3 = 1
		local ohNil4 = nil
		local ohNumber5 = 18
		local ohInstance6 = workspace[localplayer].M1911

		game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(ohNumber1, ohCFrame2, ohNumber3, ohNil4, ohNumber5, ohInstance6)

		local ohInstance1 = workspace[localplayer].HumanoidRootPart
		local ohNumber2 = 3

		game:GetService("ReplicatedStorage").Events.mpib:FireServer(ohInstance1, ohNumber2)
		wait(0.001)
	until Value == false
end)

local Invisible = troll.AddToggle("M1911 EFFECT SPAM", false, function(Value)
	repeat
		local ohNumber1 = 33
		local ohCFrame2 = CFrame.new(-346.391754, 130.287308, -403.861359, -0, 0.999725401, 0.0234374516, -0.0253975485, 0.023429893, -0.999402881, -0.999677479, -0.000595253834, 0.0253905728)
		local ohNumber3 = 1
		local ohNil4 = nil
		local ohNumber5 = 18
		local ohInstance6 = workspace[localplayer].M1911

		game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(ohNumber1, ohCFrame2, ohNumber3, ohNil4, ohNumber5, ohInstance6)

		local ohInstance1 = workspace[localplayer].HumanoidRootPart
		local ohNumber2 = 3

		game:GetService("ReplicatedStorage").Events.mpib:FireServer(ohInstance1, ohNumber2)
		wait(0.001)
	until Value == false
end)

-- Farming

local TPPRINTER = farm.AddButton("TP PRINTER", function()
	local UnOwnedPrintersOnly = false
	local Chil = workspace.MoneyPrinters:GetDescendants()
	for i,v in pairs(Chil) do
		if v and v.ClassName == "StringValue" and v.Name == "Int2" then
			v.Parent:Destroy()
		end
	end


	local PP = workspace.MoneyPrinters:GetDescendants()
	for i,v in pairs(PP) do
		if UnOwnedPrintersOnly == true then
			if v and v.ClassName == "Part" and v.Parent.Int.Money.Value ~= 0 and v.Parent.TrueOwner.Value == nil then
				print("Teleporting to an unowned printer!")
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
			end
		else
			if v and v.ClassName == "Part" and v.Parent.Int.Money.Value ~= 0 and v.Parent.TrueOwner.Value ~= nil then
				print("Teleporting to an owned printer!")
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
			end
		end
	end
end)


local AntiAfk = localps.AddButton("Anti kick AFK", function()
	local vu = game:GetService("VirtualUser")
	game:GetService("Players").LocalPlayer.Idled:connect(function()
		vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		wait(1)
		vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	end)
end)

local infhunger = localps.AddButton("Full hunger", function()
	while true do
		wait()
		game:GetService("Players")[localplayer].PlayerData.Hunger.Value = 100
	end
end)

local TPUNPRINTER = farm.AddButton("TP UNOWNED PRINTER", function()
	local UnOwnedPrintersOnly = true
	local Chil = workspace.MoneyPrinters:GetDescendants()
	for i,v in pairs(Chil) do
		if v and v.ClassName == "StringValue" and v.Name == "Int2" then
			v.Parent:Destroy()
		end
	end


	local PP = workspace.MoneyPrinters:GetDescendants()
	for i,v in pairs(PP) do
		if UnOwnedPrintersOnly == true then
			if v and v.ClassName == "Part" and v.Parent.Int.Money.Value ~= 0 and v.Parent.TrueOwner.Value == nil then
				print("Teleporting to an unowned printer!")
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
			end
		else
			if v and v.ClassName == "Part" and v.Parent.Int.Money.Value ~= 0 and v.Parent.TrueOwner.Value ~= nil then
				print("Teleporting to an owned printer!")
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
			end
		end
	end
end)






local autoaureus = farm.AddToggle("Auto aureus", false, function(Value)
	if Value == true then
		variables.autoAureus = true;
		notice:Fire("Staressentials", "Auto aureus enabled", 1);
	end
	if Value == false then
		variables.autoAureus = false;
		notice:Fire("Staressentials", "Auto aureus disabled", 1);
	end
end)


local autoscav = farm.AddToggle("Auto scavenge", false, function(Value)
	if Value == true then
		variables.autoScavEnabled = true;
		notice:Fire("Staressentials", "Auto scavenge enabled", 1);
	end
	if Value == false then
		variables.autoScavEnabled = false;
		notice:Fire("Staressentials", "Auto scavenge disabled", 1);
	end
end)

local autocorn = farm.AddToggle("Auto corn farm", false, function(Value)
	if Value == true then
		variables.autoCornFarm = true;
		notice:Fire("Staressentials", "Auto corn farm enabled", 1);
	end
	if Value == false then
		variables.autoCornFarm = false;
		notice:Fire("Staressentials", "Auto corn farm disabled", 1);
	end
end)

local autoprinter = farm.AddToggle("Auto farm printers", false, function(Value)
	if Value == true then
		variables.autoPrinterFarm = true;
		notice:Fire("Staressentials", "Auto farm printers enabled", 1);
	end
	if Value == false then
		variables.autoPrinterFarm = false;
		notice:Fire("Staressentials", "Auto farm printers disabled", 1);
	end
end)

local mbaseplayeprint = farm.AddToggle("Make baseplate (printer farm)", false, function(Value)
	if Value == true then

		local ohNumber1 = 1
		local ohString2 = "Node"
		local ohCFrame3 = CFrame.new(1.30126417, 2.68526554, 14.9110432, 0, -4.37113883e-08, 1, 0, 1, 4.37113883e-08, -1, 0, 0)

		game:GetService("ReplicatedStorage").Events.BuildingEvent:FireServer(ohNumber1, ohString2, ohCFrame3)




		local ohNumber1 = 1
		local ohString2 = "Wooden Wall (1x2)"
		local ohCFrame3 = CFrame.new(0, 0, 0, 0, 3.33601961e-14, -1, 1, -4.37113883e-08, 1.19248806e-08, -4.37113883e-08, -1, 3.28389422e-14)

		game:GetService("ReplicatedStorage").Events.BuildingEvent:FireServer(ohNumber1, ohString2, ohCFrame3)



		local ohNumber1 = 1
		local ohString2 = "Wooden Wall (1x2)"
		local ohCFrame3 = CFrame.new(0, 0, 10, 0, 3.33601961e-14, -1, 1, -4.37113883e-08, 1.19248806e-08, -4.37113883e-08, -1, 3.28389422e-14)

		game:GetService("ReplicatedStorage").Events.BuildingEvent:FireServer(ohNumber1, ohString2, ohCFrame3)



		local ohNumber1 = 1
		local ohString2 = "Wooden Wall (1x2)"
		local ohCFrame3 = CFrame.new(7, 0, 10, 0, 3.33601961e-14, -1, 1, -4.37113883e-08, 1.19248806e-08, -4.37113883e-08, -1, 3.28389422e-14)

		game:GetService("ReplicatedStorage").Events.BuildingEvent:FireServer(ohNumber1, ohString2, ohCFrame3)



		local ohNumber1 = 1
		local ohString2 = "Wooden Wall (1x2)"
		local ohCFrame3 = CFrame.new(7, 0, 0, 0, 3.33601961e-14, -1, 1, -4.37113883e-08, 1.19248806e-08, -4.37113883e-08, -1, 3.28389422e-14)

		game:GetService("ReplicatedStorage").Events.BuildingEvent:FireServer(ohNumber1, ohString2, ohCFrame3)


		local ohNumber1 = 1
		local ohString2 = "Wooden Wall (1x2)"
		local ohCFrame3 = CFrame.new(-7, 0, 0, 0, 3.33601961e-14, -1, 1, -4.37113883e-08, 1.19248806e-08, -4.37113883e-08, -1, 3.28389422e-14)

		game:GetService("ReplicatedStorage").Events.BuildingEvent:FireServer(ohNumber1, ohString2, ohCFrame3)



		local ohNumber1 = 1
		local ohString2 = "Wooden Wall (1x2)"
		local ohCFrame3 = CFrame.new(-7, 0, 10, 0, 3.33601961e-14, -1, 1, -4.37113883e-08, 1.19248806e-08, -4.37113883e-08, -1, 3.28389422e-14)

		game:GetService("ReplicatedStorage").Events.BuildingEvent:FireServer(ohNumber1, ohString2, ohCFrame3)
		notice:Fire("Staressentials", "baseplate created", 1);
	end
	if Value == false then
		game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(4)
		notice:Fire("Staressentials", "baseplate deleted", 1);
	end
end)

-- combat


local d2damage = combat.AddToggle("x2 damage", false, function(Value)
	if Value == true then
		_G.weaponMultiplierEnabled = true;
	end
	if Value == false then
		_G.weaponMultiplierEnabled = false;
	end
end)

-- Crafting

local M1911C = crafting.AddButton("M1911", function()
	local nombre = game.Players.LocalPlayer.Name
	local estacion = "Weapon Station"

	local ohNumber1 = 3
	local ohNumber2 = 1

	game:GetService("ReplicatedStorage").Events.MenuEvent:FireServer(ohNumber1, ohNumber2)

	local ohNumber1 = 2
	local ohString2 = "M1911 Shipment"
	local ohInstance3 = workspace.Buildings[nombre][estacion]
	local ohNumber4 = 8

	game:GetService("ReplicatedStorage").Events.MenuEvent:FireServer(ohNumber1, ohString2, ohInstance3, ohNumber4)

	local ohNumber1 = 3
	local ohNumber2 = 0

	game:GetService("ReplicatedStorage").Events.MenuEvent:FireServer(ohNumber1, ohNumber2)
end)



pcall(function()
	auroAureusRun();
	autoScavRun();
	runAutoPrinter();
	doPrinterStuffy();
	autoCornFarmRun();
end)






-- Apartado T

function addButton(buttonText, frame, func)
	howMuch = 0;
	pcall(function()
		lastItem = nil;
		for i,v in pairs(frame:GetChildren()) do
			if v.ClassName == "ImageButton" or v.ClassName == "TextLabel" then
				lastItem = v;
			end
		end
		if lastItem ~= nil then
			howMuch = lastItem.Position.Y.Offset + 35;
		end
	end)

	lhImgButtonAdd = Instance.new("ImageButton");
	lhImgButtonAdd.Name = "lhButton";
	lhImgButtonAdd.Image = "rbxassetid://725697201"
	lhImgButtonAdd.Position = UDim2.new(0, 238, 0, howMuch);
	lhImgButtonAdd.BackgroundTransparency = 1;
	lhImgButtonAdd.ImageColor3 = Color3.fromRGB(154, 110, 79);
	lhImgButtonAdd.AnchorPoint = Vector2.new(0.5, 0);
	lhImgButtonAdd.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	lhImgButtonAdd.ZIndex = 1;
	lhImgButtonAdd.Size = UDim2.new(1, -14, 0, 30);
	lhImgButtonAdd.ScaleType = 1;
	lhImgButtonAdd.SliceCenter = Rect.new(34, 34, 34, 34);

	lhTextLabelAdd = Instance.new("TextLabel");
	lhTextLabelAdd.Name = "TextLabel";
	lhTextLabelAdd.Font = 4;
	lhTextLabelAdd.Text = buttonText;
	lhTextLabelAdd.Parent = lhImgButtonAdd;
	lhTextLabelAdd.BackgroundTransparency = 1;
	lhTextLabelAdd.AnchorPoint = Vector2.new(0.5, 0.5);
	lhTextLabelAdd.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	lhTextLabelAdd.Position = UDim2.new(0, 240, 0.5, 0);
	lhTextLabelAdd.Size = UDim2.new(1, 0, 0, 0);
	lhTextLabelAdd.TextSize = 20;
	lhTextLabelAdd.TextColor3 = Color3.fromRGB(255, 255, 255);
	lhTextLabelAdd.TextStrokeTransparency = 0.5;
	lhTextLabelAdd.ZIndex = 3;

	lhImgButtonAdd.Parent = frame;

	oldColor = lhImgButtonAdd.ImageColor3;

	--lhImgButtonAdd.MouseEnter:connect(function()
	--	lhImgButtonAdd.ImageColor3 = Color3.fromRGB(54, 49, 44);
	--end);

	--lhImgButtonAdd.MouseLeave:connect(function()
	--	lhImgButtonAdd.ImageColor3 = oldColor;
	--end);


	lhImgButtonAdd.Activated:Connect(func);

	return true;
end


function addCategory(catName, frame)
	howMuch = 0;
	pcall(function()
		lastItem = nil;
		for i,v in pairs(frame:GetChildren()) do
			if v.ClassName == "ImageButton" or v.ClassName == "TextLabel" then
				lastItem = v;
			end
		end
		if lastItem ~= nil then
			howMuch = lastItem.Position.Y.Offset + 40;
		end
	end)


	lhTextLabel = Instance.new("TextLabel");
	lhTextLabel.Name = "categoriesHeader";
	lhTextLabel.Font = 14;
	lhTextLabel.Text = "[" .. catName .. "]";
	lhTextLabel.Parent = frame;
	lhTextLabel.BackgroundTransparency = 1;
	lhTextLabel.AnchorPoint = Vector2.new(0, 0);
	lhTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	lhTextLabel.Position = UDim2.new(0, 0, 0, howMuch);
	lhTextLabel.Size = UDim2.new(1, 0, 0, 20);
	lhTextLabel.TextSize = 24;
	lhTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
	lhTextLabel.TextStrokeTransparency = 0.5;
	lhTextLabel.ZIndex = 1;
	return true;
end


lhOptions = Instance.new("Frame");
lhOptions.Name = "lhOptions";
lhOptions.BorderColor3 = Color3.fromRGB(27, 42, 53);
lhOptions.Position = UDim2.new(0, 56, 0, 315);
lhOptions.AnchorPoint = Vector2.new(0.5, 0.5);
lhOptions.Size = UDim2.new(0, 70, 0, 70);
lhOptions.BackgroundTransparency = 1;

lhImgButton = Instance.new("ImageButton");
lhImgButton.Name = "lhOptions";
lhImgButton.Image = "rbxassetid://553151967"
lhImgButton.Position = UDim2.new(0, 0, 0, 0);
lhImgButton.BackgroundTransparency = 1;
lhImgButton.ImageColor3 = Color3.fromRGB(91, 84, 75);
lhImgButton.AnchorPoint = Vector2.new(0.5, 0.5);
lhImgButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
lhImgButton.ZIndex = 10;
lhImgButton.Size = UDim2.new(0, 60, 0, 60);

lhTextLabel = Instance.new("TextLabel");
lhTextLabel.Name = "TextLabel";
lhTextLabel.Font = 14;
lhTextLabel.Text = "Staressentials";
lhTextLabel.Parent = lhImgButton;
lhTextLabel.BackgroundTransparency = 1;
lhTextLabel.AnchorPoint = Vector2.new(0, 1);
lhTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
lhTextLabel.Position = UDim2.new(0, 0, 1, -5);
lhTextLabel.Size = UDim2.new(1, 0, 0, 15);
lhTextLabel.TextSize = 12;
lhTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
lhTextLabel.TextStrokeTransparency = 0.5;
lhTextLabel.ZIndex = 11;

lhImageLabel = Instance.new("ImageLabel");
lhImageLabel.Name = "icon";
lhImageLabel.Image = "rbxassetid://560667850";
lhImageLabel.Parent = lhImgButton;
lhImageLabel.BackgroundTransparency = 1;
lhImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
lhImageLabel.Position = UDim2.new(0.5, 2, 0.5, -2);
lhImageLabel.Size = UDim2.new(0.5, 0.5, 0.5, 0.5);
lhImageLabel.ImageRectOffset = Vector2.new(0, 0);
lhImageLabel.ImageRectSize = Vector2.new(0, 0);
lhImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255);

lhImageLabel.ZIndex = 10;
lhImgButton.Parent = lhOptions;
lhOptions.Parent = game.Players.LocalPlayer.PlayerGui.Client.Menu.Catagories;


lhFrame = Instance.new("Frame");
lhFrame.Name = "Staressentials";
lhFrame.BorderColor3 = Color3.fromRGB(27, 42, 53);
lhFrame.Visible = false;
lhFrame.Parent = game.Players.LocalPlayer.PlayerGui.Client.Menu;
lhFrame.Size = UDim2.new(1, 1, 1, 1);
lhFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
lhFrame.BackgroundTransparency = 1;

spawn(function()
	while true do
		pcall(function()
			lmao = game.Players.LocalPlayer.PlayerGui.Client.Menu;
			if lmao.Rules.Visible or lmao.Shop.Visible or lmao.Action.Visible or lmao.Jobs.Visible then
				lhFrame.Visible = false;
				lhImgButton.ImageColor3 = Color3.fromRGB(91, 84, 75);
			end
			wait();
		end)
	end
end)


lhImgButton.MouseEnter:connect(function()
	if lhFrame.Visible then
		return;
	end;
	lhImgButton.ImageColor3 = Color3.fromRGB(54, 49, 44);
end);

lhImgButton.MouseLeave:connect(function()
	if lhFrame.Visible then
		return;
	end;
	lhImgButton.ImageColor3 = Color3.fromRGB(91, 84, 75);
end);


lhImgButton.Activated:Connect(function()
	game.Players.LocalPlayer.PlayerGui.Client.Menu.Rules.Visible = false;
	game.Players.LocalPlayer.PlayerGui.Client.Menu.Shop.Visible = false;
	game.Players.LocalPlayer.PlayerGui.Client.Menu.Action.Visible = false;
	game.Players.LocalPlayer.PlayerGui.Client.Menu.Jobs.Visible = false;
	game.Players.LocalPlayer.PlayerGui.Client.Menu.Catagories[1][1].ImageColor3 = Color3.fromRGB(91, 84, 75);
	game.Players.LocalPlayer.PlayerGui.Client.Menu.Catagories[2][2].ImageColor3 = Color3.fromRGB(91, 84, 75);
	game.Players.LocalPlayer.PlayerGui.Client.Menu.Catagories[3][3].ImageColor3 = Color3.fromRGB(91, 84, 75);
	game.Players.LocalPlayer.PlayerGui.Client.Menu.Catagories[4][4].ImageColor3 = Color3.fromRGB(91, 84, 75);
	lhImgButton.ImageColor3 = Color3.fromRGB(54, 49, 44);
	lhFrame.Visible = true;
end)





mainMenuScrollingFrame = Instance.new("ScrollingFrame");
mainMenuScrollingFrame.Name = "ScrollingFrame";
mainMenuScrollingFrame.BorderColor3 = Color3.fromRGB(27, 42, 53);
mainMenuScrollingFrame.Visible = true;
mainMenuScrollingFrame.Position = UDim2.new(0, 5, 0, 5);
mainMenuScrollingFrame.Size = UDim2.new(1, -10, 1, -10);
mainMenuScrollingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
mainMenuScrollingFrame.BackgroundTransparency = 0.5;
mainMenuScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 966);
mainMenuScrollingFrame.Parent = lhFrame



addCategory("Credits", mainMenuScrollingFrame);
addButton("Script creator - migu", mainMenuScrollingFrame, function() 
	print("migu")
end)

addButton("Gun donator: Kid Noob", mainMenuScrollingFrame, function() 
	print("Kid noob")
end)

game.Players.LocalPlayer.PlayerGui.Client.Inventory.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 15, 0);
