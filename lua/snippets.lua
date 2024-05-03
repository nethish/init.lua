local keymap = vim.keymap



local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

--------------------------------------------------- KEYMAP BEGIN ---------------------------------------------------


vim.keymap.set({"i"}, "<C-K>", function() print('hello') ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

vim.keymap.set({"n"}, "<leader>ss", "<cmd>source ~/.config/nvim/lua/snippets.lua<CR>")

--------------------------------------------------- KEYMAP END ---------------------------------------------------


--------------------------------------------------- SNIPPET BEGIN ---------------------------------------------------


ls.add_snippets("all", {
  s("--", fmt("--------------------------------------------------", { })),
  s("==", fmt("==================================================", { })),
})



ls.add_snippets("lua", {
  s("req", fmt("local {} = require('{}' local {})", { i(1, "default"), rep(1), i(2) })),
})


ls.add_snippets("go", {
  s("ie", fmt("if {} != nil {{\n\t{}\n}}", { i(1, "err"), i(2) })),
  s("var", fmt("{}, {} = {}({})", { i(1, "ret"), i(2, "err", "_"), i(3, "fun"), i(4, "")})),
  s("func", fmt("func {}({}) {}{{\n\t{}\nreturn\n}}", { i(1, "Function"), i(2), i(3, ""), i(4, "")})),
})


--------------------------------------------------- SNIPPET END ---------------------------------------------------
