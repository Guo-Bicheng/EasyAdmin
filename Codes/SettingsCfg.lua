local Elements = {
	-----------[[ ADMINS ]]-----------------
	Ranks = {
		["Owner"] = {"brandonisabillionare", "Player1"}; -- All commands, full power, stops admin, and other ownery things
		["Admin"] = {"FoodForDays345"}; -- Most commands, can kick, ban, crash, and has power in servers
		["Member"] = {"Friend", "Other Friend"}; -- Some commands, no kick, ban, crash, shutdown, no real power
		["Banned"] = {"Noob", "Butt"}; -- Can't join
		["Crashed"] = {"TurdHead", "BiggerNoob"}; -- Get's lagged >:D
		["Muted"] = {"Hacker", "Exploiter"}; -- Can join server, but they can't chat(Great for nooby hackers)
	};
	----------------------------------------

	-----------[[ SETTINGS ]]---------------
	FUN = true; -- Eveyone likes fun! so why not me true! If your place is a military place and you have no scene of humor you can change it to false 
	LagTime = 5; -- The crash command disconnects the player. then the time set here will count down until lag
	Prefix = ";"; -- What you say before a command. The ";" in [ ;kill me ]
	Bet = " "; -- Separates arguments(Cannot be slash or dash or it will become space)
	EnableAdminMenu = true; -- Set true or false if you want to enable the admin menu
	Filter = {"GetObjects"}; -- Used for Anti-Exploits. If someone says anything on this list they will be kicked.
	ServerLocked = false; -- Used to kick non-admins when they join
	DisableAbuse = false; -- Disables abusive command like kill,fling,loopfling,ect... (FOR MEMBER RANK ONLY)
	--------------------------------------

	-----------[[ VIPS ]]-----------------
	VIPMemberID = 0; -- Put the gamepass ID for people to have member access, leave 0 if you do not want it
	VIPAdminID = 0; -- Put the gamepass ID for people to have admin access, leave 0 if you do not want it
	--------------------------------------

	-----------[[ GROUPS ]]---------------
	GroupID = 0; -- Links group to admin, leave 0 if you do not want to do so
	GroupMemberRank = 0; -- the lowest rank that will get admin commands[Member Rank], If you have linked a group to this DO NOT make 0
	GroupAdminRank = 0; -- the lowest rank that will get admin commands[Admin Rank], If you have linked a group to this DO NOT make 0
	GroupOwnerRank = 0; -- the lowest rank that will get admin commands[Owner Rank], If you have linked a group to this DO NOT make 0
	RankBan = 0; -- 1st arguments is what action a rank will be from a group, 2nd is the rank
	--------------------------------------

	-----------[[ BADGES ]]---------------
	BadgeID = 0; -- Leave 0 if you don't want people to have admin when they get a badge[Member Rank], otherwise, put in badge ID
	--------------------------------------
} return Elements
