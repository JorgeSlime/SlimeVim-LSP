local ls =require("luasnip")
local s = ls.snippet
local t =ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node


--forma 1 
--ls.add_snippets("cpp", {
--    s("multi_line_example", {
--        t({"Primera línea."}),
--        t({"","Segunda línea."}),
--        t({"","Tercera línea."})
--    })
--})
