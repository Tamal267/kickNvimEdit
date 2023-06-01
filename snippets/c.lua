local ls = require("luasnip") --{{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })
local file_pattern = "*.c"

local baSe = s("a", t("it is a snippet"))
table.insert(snippets, baSe)

local For_satement = s( -- for([%w_]) CPP For Loop snippet{{{
	{ trig = "for([%w_])", regTrig = true, hidden = true },
	fmt(
		[[
for(int {} = 0; {} < {}; {}++) {{
  {}
}}
    ]],
		{
			d(1, function(_, snip)
				return sn(1, i(1, snip.captures[1]))
			end),
			rep(1),
			c(2, { i(1, "n"), sn(1, { i(1, "arr"), t(".size()") }) }),
			rep(1),
			i(3, ""),
		}
	)
) --}}}
table.insert(autosnippets, For_satement)


return snippets, autosnippets


