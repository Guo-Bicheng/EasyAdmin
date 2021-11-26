wait()
local Player = script:FindFirstChild("Owner").Value
local Script = script:FindFirstChild("Code").Value
local ScriptBase = ""

function MakeNode(Type, Text, User)
	if not User then User = {Name = "Nil"} end
	local Con = Instance.new("Configuration", game:GetService("Debris"))
	Con.Name = Type
	
	local Node = Instance.new("StringValue", Con)
	Node.Name = User.Name
	Node.Value = Text
end

function Handle(ErrorVar)
	local Base = ErrorVar
	if not ErrorVar or ErrorVar == "" then
		Base = "Unknown line: Unknown error(Suggestion: Probobly not in your level/identity)"
	else
		Base = ErrorVar:match'"*".:(.+)' or "Unknown line: "..ErrorVar
	end
	MakeNode("Error", "ERROR: "..Base, Player)
end

function CreateSpacing(...) 
	local String = ""
	for _,Get in pairs({...}) do 
		String = String..Get.."    " 
	end 
	return String 
end

function Load(Code)
	local Function
	local ErrorString
	Function, ErrorString = loadstring(Code)
	getfenv(Function).print = function(...) MakeNode("Print", CreateSpacing(...), Player) end
	getfenv(Function).error = function(...) MakeNode("Error", "ERROR: "..CreateSpacing(...), Player) end
	getfenv(Function).assert = function(Passed, ...) if not Passed then MakeNode("Error", "ERROR: "..CreateSpacing(...), Player) end end
	getfenv(Function).script = script
	if ErrorString then
		Handle(ErrorString)
	else
		coroutine.wrap(Function)()
	end
end

wait()

Load(ScriptBase.."        "..Script)
