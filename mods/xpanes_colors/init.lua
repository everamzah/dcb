local xpanes_colors = {}

xpanes_colors.dyes = {
	{"grey",	"Grey",		"#9C9C9C"},
	{"dark_grey",	"Dark Grey",	"#494949"},
	{"black",	"Black",	"#292929"},
	{"violet",	"Violet",	"#480680"},
	{"blue",	"Blue",		"#00519D"},
	{"cyan",	"Cyan",		"#00959D"},
	{"dark_green",	"Dark Green", 	"#2B7B00"},
	{"green",	"Green",	"#67EB1C"},
	{"yellow",	"Yellow",	"#FCF611"},
	{"brown",	"Brown",	"#6C3800"},
	{"orange",	"Orange",	"#E0601A"},
	{"red",		"Red",		"#C91818"},
	{"magenta",	"Magenta",	"#D80481"},
	{"pink",	"Pink",		"#FFA5A5"},
}

for i, v in ipairs(xpanes_colors.dyes) do
	local name = v[1]
	local desc = v[2]
	local hex = v[3]
	xpanes.register_pane("pane_"..name, {
		description = "Glass Pane ("..desc..")",
		tiles = {"xpanes_space.png"},
		drawtype = "airlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		air_equivalent = true,
		textures = {
			"default_glass.png^[colorize:"..hex,
			"xpanes_pane_half.png^[colorize:"..hex,
			"xpanes_white.png^[colorize:"..hex
		},
		inventory_image = "default_glass.png^[colorize:"..hex,
		wield_image = "default_glass.png^[colorize:"..hex,
		sounds = default.node_sound_glass_defaults(),
		groups = {snappy=2, cracky=3, oddly_breakable_by_hand=3, pane=1},
		recipe = {
			{'dye:'..name, 'dye:'..name, 'dye:'..name},
			{'default:glass', 'default:glass', 'default:glass'},
			{'default:glass', 'default:glass', 'default:glass'}
		}
	})
end
