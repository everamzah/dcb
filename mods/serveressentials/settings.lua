--AFK_CHECK = true --Whether or not to automatically kick afk players
AFK_CHECK = minetest.setting_get("afk_check") or true
--MAX_AFK_TIME = 600 --Max time allowed afk before kick 
MAX_AFK_TIME = minetest.setting_get("max_afk_time") or 600
AFK_CHECK_INTERVAL = minetest.setting_get("afk_check_interval") or 1
AFK_WARN_TIME = minetest.setting_get("afk_warn_time") or 20

SHOW_FIRST_TIME_JOIN_MSG = minetest.setting_get("show_first_time_join_msg") or true

local name = minetest.setting_get("server_name") or "[SERVER]"
FIRST_TIME_JOIN_MSG = " has joined the server for the first time!  Welcome to "..name

BROADCAST_PREFIX = minetest.setting_get("broadcast_prefix") or "[SERVER: "..name.."]" or "[SERVER]"

REMOVE_BONES = minetest.setting_get("remove_bones") or false
REMOVE_BONES_TIME = minetest.setting_get("remove_bones_time") or 600

KICK_CHATSPAM = minetest.setting_get("kick_chatspam") or true
MAX_CHAT_MSG_LENGTH = minetest.setting_get("max_chat_msg_length") or 400




DISALLOWED_NODES = {
	"tnt:tnt",
}

