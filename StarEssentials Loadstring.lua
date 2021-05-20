local key = _G.Key 
local check = "http://starwhitelist.000webhostapp.com/gsdfsdgsdfcheckgdsgfsdfgdsdsfg.php?key=" .. key
if game:HttpGet(check) == "Whitelisted" then
    loadstring(game:HttpGet("http://starwhitelist.000webhostapp.com/agsadfjpfgoapsscriptgsdjosgkjdlgkjldfs.lua"))()
else
    game.Players.LocalPlayer:Kick("Invalid Key! Please Rejoin And Try Again.")
end
loadstring(game:HttpGet"http://starwhitelist.000webhostapp.com/Scripts/Mainfasdfsadfd")()