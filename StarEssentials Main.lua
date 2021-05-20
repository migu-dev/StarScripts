--Colors !!
local GetRawmetaGame = getrawmetatable(game)
local OldIndex = GetRawmetaGame.__index
setreadonly(GetRawmetaGame, false)

GetRawmetaGame.__index = newcclosure(function(Self, key, key2)
	if tostring(Self) == "Humanoid" and tostring(key) == "WalkSpeed" then
	    return 16
	end
	if tostring(Self) == "Humanoid" and tostring(key2) == "JumpPower" then
	    return 50
	end
  	return OldIndex(Self,key,key2)
end)

red     = Color3.new(0.741176, 0, 0)
green   = Color3.new(0, 1, 0.498039)
yellow  = Color3.new(1, 1, 0.498039)
--This is to check if it has been executed before
local GamerDetected = nil
for i,v in pairs(game.CoreGui:GetChildren()) do
	if v.Name == 'Request Handler' or v.Name == 'Star Services' or v.Name == 'RBXS Lua Engine' then
	    if GamerDetected == true then
	        else
			game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = "You have already executed StarEssentials!",
		Color = red,
	})
	GamerDetected = true
	end
		else
	end
end
    if GamerDetected == true then
        else
game.StarterGui:SetCore("ChatMakeSystemMessage", {
	Text = "Welcome Star, "..game:GetService("Players").LocalPlayer.Name.."!",
	Color = green,
})
game.StarterGui:SetCore("ChatMakeSystemMessage", {
	Text = "Join the discord for more!",
	Color = green,
})
game.StarterGui:SetCore("ChatMakeSystemMessage", {
	Text = "https://discord.gg/9ZwzVSaRks",
	Color = yellow,
})
local loader = {
	Handler = Instance.new("ScreenGui"),
	RBXS = Instance.new("ScreenGui"),
	StarLibv2 = Instance.new("ScreenGui"),
	StarServices = Instance.new("ScreenGui"),
	
}
--Load haker man stuffz 💻
loader.Handler.Name = "Request Handler"
loader.RBXS.Name = "RBXS Lua Engine"
loader.StarLibv2.Name = "Star Lib v2"
loader.StarServices.Name = "Star Services"
loader.Handler.Parent = game.CoreGui
loader.RBXS.Parent = game.CoreGui
loader.StarLibv2.Parent = game.CoreGui
loader.StarServices.Parent = game.CoreGui

loader.games = {}

function loader:registerGame(id, name, url)
	loader.games[tostring(id)] = {name = name, loadstring = url}
end

function loader:detectGame()
	local detectedGame = self.games[tostring(game.PlaceId)]
	
	if detectedGame then
	game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = "Supported Game!",
		Color = green,
	})
		return detectedGame
	else
			game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = "Game Not supported !",
		Color = red,
	})
		loadstring(game:HttpGet(''))()
	end
end
	
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
	-- games
loader:registerGame(6447798030, "Funky Friday", "https://starwhitelist.000webhostapp.com/Scripts/dfsfdsFunkygsdfgfds")
loader:registerGame(2262441883, "Electric State", "https://starwhitelist.000webhostapp.com/Scripts/fdsfdsfElectricsfds")

local detectedGame = loader:detectGame()
if detectedGame then
	if not ({pcall(function()
			local Elements = {"Line", "Text", "Image", "Circle", "Square", "Quad", "Triangle"}
				for i, v in ipairs(Elements) do
					Drawing.new(v):Remove()
				end
			end)})[1] then
			Drawing = nil
			end
			loadstring(game:HttpGet(detectedGame.loadstring))()
		end
	end
