if minetest.setting_getbool("replace_legacy_fences") then
	if setting_getbool("log_mods") then
		minetest.log("action", "[legacy_replacer] Fences will be replaced.")
	end
	-- default:fence_wood places xconnected:fence_c4
	minetest.register_abm({
		nodenames = {"default:fence_wood"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="xconnected:fence_c4"})
		end,
	})
	-- xdecor:fence_wrought_iron places xdecor:fence_wrought_iron_c4
	minetest.register_abm({
		nodenames = {"xdecor:fence_wrought_iron"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="xdecor:fence_wrought_iron_c4"})
		end,
	})
end

if minetest.setting_getbool("replace_legacy_panes") then
	if minetest.setting_getbook("log_mods") then
		minetest.log("action", "[legacy_replacer] Panes will be replaced.")
	end
	-- xpanes:bar to xconnected:bar_c4
	minetest.register_abm({
		nodenames = {"xpanes:bar_1", "xpanes:bar_2", "xpanes:bar_3", "xpanes:bar_4",
			"xpanes:bar_5", "xpanes:bar_6", "xpanes:bar_7", "xpanes:bar_8",
			"xpanes:bar_9", "xpanes:bar_10", "xpanes:bar_11", "xpanes:bar_12",
			"xpanes:bar_13", "xpanes:bar_14", "xpanes:bar_15"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="xconnected:bar_c4"})
		end,
	})
	-- xdecor:rust_bar to xdecor:rust_bar_c4
	minetest.register_abm({
		nodenames = {"xdecor:rust_bar_1", "xdecor:rust_bar_2", "xdecor:rust_bar_3", "xdecor:rust_bar_4",
			"xdecor:rust_bar_5", "xdecor:rust_bar_6", "xdecor:rust_bar_7", "xdecor:rust_bar_8", 
			"xdecor:rust_bar_9", "xdecor:rust_bar_10", "xdecor:rust_bar_11", "xdecor:rust_bar_12", 
			"xdecor:rust_bar_13", "xdecor:rust_bar_14", "xdecor:rust_bar_15"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="xdecor:rust_bar_c4"})
		end,
	})
	-- xdecor:bamboo_frame to xdecor:bamboo_frame_c4
	minetest.register_abm({
		nodenames = {"xdecor:bamboo_frame_1", "xdecor:bamboo_frame_2", "xdecor:bamboo_frame_3",
			"xdecor:bamboo_frame_4", "xdecor:bamboo_frame_5", "xdecor:bamboo_frame_6",
			"xdecor:bamboo_frame_7", "xdecor:bamboo_frame_8", "xdecor:bamboo_frame_9",
			"xdecor:bamboo_frame_10", "xdecor:bamboo_frame_11", "xdecor:bamboo_frame_12",
			"xdecor:bamboo_frame_13", "xdecor:bamboo_frame_14", "xdecor:bamboo_frame_15"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="xdecor:bamboo_frame_c4"})
		end,
	})

	-- Glass panes white
	local legacy_panes_white = {"xpanes:pane_1", "xpanes:pane_2", "xpanes:pane_3",
		"xpanes:pane_4", "xpanes:pane_5", "xpanes:pane_6", "xpanes:pane_7",
		"xpanes:pane_8", "xpanes:pane_9", "xpanes:pane_10", "xpanes:pane_11",
		"xpanes:pane_12", "xpanes:pane_13", "xpanes:pane_14", "xpanes:pane_15"}
	for _, node_name in ipairs(legacy_panes_white) do
		minetest.register_node(":"..node_name, {
			groups = {legacy_pane_white=1},
		})
	end
	minetest.register_abm({
		nodenames = {"group:legacy_pane_white"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="xconnected:pane_glass_white_c4"})
		end,
	})
	-- Glass panes gray
	local legacy_panes_gray = {"xpanes:pane_gray_1", "xpanes:pane_gray_2", "xpanes:pane_gray_3",
		"xpanes:pane_gray_4", "xpanes:pane_gray_5", "xpanes:pane_gray_6", "xpanes:pane_gray_7",
		"xpanes:pane_gray_8", "xpanes:pane_gray_9", "xpanes:pane_gray_10", "xpanes:pane_gray_11",
		"xpanes:pane_gray_12", "xpanes:pane_gray_13", "xpanes:pane_gray_14", "xpanes:pane_gray_15"}
	for _, node_name in ipairs(legacy_panes_gray) do
		minetest.register_node(":"..node_name, {
			groups = {legacy_pane_gray=1},
		})
	end
	minetest.register_abm({
		nodenames = {"group:legacy_pane_gray"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="xconnected:pane_glass_gray_c4"})
		end,
	})
	-- Glass panes darkgray
	local legacy_panes_darkgray = {"xpanes:pane_darkgray_1", "xpanes:pane_darkgray_2", "xpanes:pane_darkgray_3",
		"xpanes:pane_darkgray_4", "xpanes:pane_darkgray_5", "xpanes:pane_darkgray_6", "xpanes:pane_darkgray_7",
		"xpanes:pane_darkgray_8", "xpanes:pane_darkgray_9", "xpanes:pane_darkgray_10", "xpanes:pane_darkgray_11",
		"xpanes:pane_darkgray_12", "xpanes:pane_darkgray_13", "xpanes:pane_darkgray_14", "xpanes:pane_darkgray_15"}
	for _, node_name in ipairs(legacy_panes_darkgray) do
		minetest.register_node(":"..node_name, {
			groups = {legacy_pane_darkgray=1},
		})
	end
	minetest.register_abm({
		nodenames = {"group:legacy_pane_darkgray"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="xconnected:pane_glass_darkgray_c4"})
		end,
	})
	-- Glass panes black
	local legacy_panes_black = {"xpanes:pane_black_1", "xpanes:pane_black_2", "xpanes:pane_black_3",
		"xpanes:pane_black_4", "xpanes:pane_black_5", "xpanes:pane_black_6", "xpanes:pane_black_7",
		"xpanes:pane_black_8", "xpanes:pane_black_9", "xpanes:pane_black_10", "xpanes:pane_black_11",
		"xpanes:pane_black_12", "xpanes:pane_black_13", "xpanes:pane_black_14", "xpanes:pane_black_15"}
	for _, node_name in ipairs(legacy_panes_black) do
		minetest.register_node(":"..node_name, {
			groups = {legacy_pane_black=1},
		})
	end
	minetest.register_abm({
		nodenames = {"group:legacy_pane_black"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="xconnected:pane_glass_black_c4"})
		end,
	})
	-- Glass panes violet
	local legacy_panes_violet = {"xpanes:pane_violet_1", "xpanes:pane_violet_2", "xpanes:pane_violet_3",
		"xpanes:pane_violet_4", "xpanes:pane_violet_5", "xpanes:pane_violet_6", "xpanes:pane_violet_7",
		"xpanes:pane_violet_8", "xpanes:pane_violet_9", "xpanes:pane_violet_10", "xpanes:pane_violet_11",
		"xpanes:pane_violet_12", "xpanes:pane_violet_13", "xpanes:pane_violet_14", "xpanes:pane_violet_15"}
	for _, node_name in ipairs(legacy_panes_violet) do
		minetest.register_node(":"..node_name, {
			groups = {legacy_pane_violet=1},
		})
	end
	minetest.register_abm({
		nodenames = {"group:legacy_pane_violet"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="xconnected:pane_glass_violet_c4"})
		end,
	})
	-- Glass panes blue
	local legacy_panes_blue = {"xpanes:pane_blue_1", "xpanes:pane_blue_2", "xpanes:pane_blue_3",
		"xpanes:pane_blue_4", "xpanes:pane_blue_5", "xpanes:pane_blue_6", "xpanes:pane_blue_7",
		"xpanes:pane_blue_8", "xpanes:pane_blue_9", "xpanes:pane_blue_10", "xpanes:pane_blue_11",
		"xpanes:pane_blue_12", "xpanes:pane_blue_13", "xpanes:pane_blue_14", "xpanes:pane_blue_15"}
	for _, node_name in ipairs(legacy_panes_blue) do
		minetest.register_node(":"..node_name, {
			groups = {legacy_pane_blue=1},
		})
	end
	minetest.register_abm({
		nodenames = {"group:legacy_pane_blue"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="xconnected:pane_glass_blue_c4"})
		end,
	})
	-- Glass panes cyan
	local legacy_panes_cyan = {"xpanes:pane_cyan_1", "xpanes:pane_cyan_2", "xpanes:pane_cyan_3",
		"xpanes:pane_cyan_4", "xpanes:pane_cyan_5", "xpanes:pane_cyan_6", "xpanes:pane_cyan_7",
		"xpanes:pane_cyan_8", "xpanes:pane_cyan_9", "xpanes:pane_cyan_10", "xpanes:pane_cyan_11",
		"xpanes:pane_cyan_12", "xpanes:pane_cyan_13", "xpanes:pane_cyan_14", "xpanes:pane_cyan_15"}
	for _, node_name in ipairs(legacy_panes_cyan) do
		minetest.register_node(":"..node_name, {
			groups = {legacy_pane_cyan=1},
		})
	end
	minetest.register_abm({
		nodenames = {"group:legacy_pane_cyan"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="xconnected:pane_glass_cyan_c4"})
		end,
	})
	-- Glass panes darkgreen
	local legacy_panes_darkgreen = {"xpanes:pane_darkgreen_1", "xpanes:pane_darkgreen_2", "xpanes:pane_darkgreen_3",
		"xpanes:pane_darkgreen_4", "xpanes:pane_darkgreen_5", "xpanes:pane_darkgreen_6", "xpanes:pane_darkgreen_7",
		"xpanes:pane_darkgreen_8", "xpanes:pane_darkgreen_9", "xpanes:pane_darkgreen_10", "xpanes:pane_darkgreen_11",
		"xpanes:pane_darkgreen_12", "xpanes:pane_darkgreen_13", "xpanes:pane_darkgreen_14", "xpanes:pane_darkgreen_15"}
	for _, node_name in ipairs(legacy_panes_darkgreen) do
		minetest.register_node(":"..node_name, {
			groups = {legacy_pane_darkgreen=1},
		})
	end
	minetest.register_abm({
		nodenames = {"group:legacy_pane_darkgreen"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="xconnected:pane_glass_darkgreen_c4"})
		end,
	})
	-- Glass panes green
	local legacy_panes_green = {"xpanes:pane_green_1", "xpanes:pane_green_2", "xpanes:pane_green_3",
		"xpanes:pane_green_4", "xpanes:pane_green_5", "xpanes:pane_green_6", "xpanes:pane_green_7",
		"xpanes:pane_green_8", "xpanes:pane_green_9", "xpanes:pane_green_10", "xpanes:pane_green_11",
		"xpanes:pane_green_12", "xpanes:pane_green_13", "xpanes:pane_green_14", "xpanes:pane_green_15"}
	for _, node_name in ipairs(legacy_panes_green) do
		minetest.register_node(":"..node_name, {
			groups = {legacy_pane_green=1},
		})
	end
	minetest.register_abm({
		nodenames = {"group:legacy_pane_green"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="xconnected:pane_glass_green_c4"})
		end,
	})
	-- Glass panes yellow
	local legacy_panes_yellow = {"xpanes:pane_yellow_1", "xpanes:pane_yellow_2", "xpanes:pane_yellow_3",
		"xpanes:pane_yellow_4", "xpanes:pane_yellow_5", "xpanes:pane_yellow_6", "xpanes:pane_yellow_7",
		"xpanes:pane_yellow_8", "xpanes:pane_yellow_9", "xpanes:pane_yellow_10", "xpanes:pane_yellow_11",
		"xpanes:pane_yellow_12", "xpanes:pane_yellow_13", "xpanes:pane_yellow_14", "xpanes:pane_yellow_15"}
	for _, node_name in ipairs(legacy_panes_yellow) do
		minetest.register_node(":"..node_name, {
			groups = {legacy_pane_yellow=1},
		})
	end
	minetest.register_abm({
		nodenames = {"group:legacy_pane_yellow"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="xconnected:pane_glass_yellow_c4"})
		end,
	})
	-- Glass panes brown
	local legacy_panes_brown = {"xpanes:pane_brown_1", "xpanes:pane_brown_2", "xpanes:pane_brown_3",
		"xpanes:pane_brown_4", "xpanes:pane_brown_5", "xpanes:pane_brown_6", "xpanes:pane_brown_7",
		"xpanes:pane_brown_8", "xpanes:pane_brown_9", "xpanes:pane_brown_10", "xpanes:pane_brown_11",
		"xpanes:pane_brown_12", "xpanes:pane_brown_13", "xpanes:pane_brown_14", "xpanes:pane_brown_15"}
	for _, node_name in ipairs(legacy_panes_brown) do
		minetest.register_node(":"..node_name, {
			groups = {legacy_pane_brown=1},
		})
	end
	minetest.register_abm({
		nodenames = {"group:legacy_pane_brown"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="xconnected:pane_glass_brown_c4"})
		end,
	})
	-- Glass panes orange
	local legacy_panes_orange = {"xpanes:pane_orange_1", "xpanes:pane_orange_2", "xpanes:pane_orange_3",
		"xpanes:pane_orange_4", "xpanes:pane_orange_5", "xpanes:pane_orange_6", "xpanes:pane_orange_7",
		"xpanes:pane_orange_8", "xpanes:pane_orange_9", "xpanes:pane_orange_10", "xpanes:pane_orange_11",
		"xpanes:pane_orange_12", "xpanes:pane_orange_13", "xpanes:pane_orange_14", "xpanes:pane_orange_15"}
	for _, node_name in ipairs(legacy_panes_orange) do
		minetest.register_node(":"..node_name, {
			groups = {legacy_pane_orange=1},
		})
	end
	minetest.register_abm({
		nodenames = {"group:legacy_pane_orange"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="xconnected:pane_glass_orange_c4"})
		end,
	})
	-- Glass panes red
	local legacy_panes_red = {"xpanes:pane_red_1", "xpanes:pane_red_2", "xpanes:pane_red_3",
		"xpanes:pane_red_4", "xpanes:pane_red_5", "xpanes:pane_red_6", "xpanes:pane_red_7",
		"xpanes:pane_red_8", "xpanes:pane_red_9", "xpanes:pane_red_10", "xpanes:pane_red_11",
		"xpanes:pane_red_12", "xpanes:pane_red_13", "xpanes:pane_red_14", "xpanes:pane_red_15"}
	for _, node_name in ipairs(legacy_panes_red) do
		minetest.register_node(":"..node_name, {
			groups = {legacy_pane_red=1},
		})
	end
	minetest.register_abm({
		nodenames = {"group:legacy_pane_red"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="xconnected:pane_glass_red_c4"})
		end,
	})
	-- Glass panes magenta
	local legacy_panes_magenta = {"xpanes:pane_magenta_1", "xpanes:pane_magenta_2", "xpanes:pane_magenta_3",
		"xpanes:pane_magenta_4", "xpanes:pane_magenta_5", "xpanes:pane_magenta_6", "xpanes:pane_magenta_7",
		"xpanes:pane_magenta_8", "xpanes:pane_magenta_9", "xpanes:pane_magenta_10", "xpanes:pane_magenta_11",
		"xpanes:pane_magenta_12", "xpanes:pane_magenta_13", "xpanes:pane_magenta_14", "xpanes:pane_magenta_15"}
	for _, node_name in ipairs(legacy_panes_magenta) do
		minetest.register_node(":"..node_name, {
			groups = {legacy_pane_magenta=1},
		})
	end
	minetest.register_abm({
		nodenames = {"group:legacy_pane_magenta"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="xconnected:pane_glass_magenta_c4"})
		end,
	})
	-- Glass panes pink
	local legacy_panes_pink = {"xpanes:pane_pink_1", "xpanes:pane_pink_2", "xpanes:pane_pink_3",
		"xpanes:pane_pink_4", "xpanes:pane_pink_5", "xpanes:pane_pink_6", "xpanes:pane_pink_7",
		"xpanes:pane_pink_8", "xpanes:pane_pink_9", "xpanes:pane_pink_10", "xpanes:pane_pink_11",
		"xpanes:pane_pink_12", "xpanes:pane_pink_13", "xpanes:pane_pink_14", "xpanes:pane_pink_15"}
	for _, node_name in ipairs(legacy_panes_pink) do
		minetest.register_node(":"..node_name, {
			groups = {legacy_pane_pink=1},
		})
	end
	minetest.register_abm({
		nodenames = {"group:legacy_pane_pink"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="xconnected:pane_glass_pink_c4"})
		end,
	})
end
