local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

-- Only load for specific filetypes
ls.add_snippets("javascriptreact", {
  s(
    "fcc",
    fmt(
      [[
  import './{}.css'

  const {} = () => {{
    return (
      <div className="{}">{}</div>
    )
  }}

  export default {}
    ]],
      {
        f(function(_, snip)
          return snip.env.TM_FILENAME_BASE:lower()
        end),
        f(function(_, snip)
          return snip.env.TM_FILENAME_BASE:gsub("^%l", string.upper)
        end),
        f(function(_, snip)
          return snip.env.TM_FILENAME_BASE:lower()
        end),
        f(function(_, snip)
          return snip.env.TM_FILENAME_BASE:gsub("^%l", string.upper)
        end),
        f(function(_, snip)
          return snip.env.TM_FILENAME_BASE:gsub("^%l", string.upper)
        end),
      }
    )
  ),

  s(
    "fcs",
    fmt(
      [[
  import './{}.scss'

  function {}() {{
    return (
      <div className="{}">{}</div>
    )
  }}

  export default {}
    ]],
      {
        f(function(_, snip)
          return snip.env.TM_FILENAME_BASE:lower()
        end),
        f(function(_, snip)
          return snip.env.TM_FILENAME_BASE:gsub("^%l", string.upper)
        end),
        f(function(_, snip)
          return snip.env.TM_FILENAME_BASE:lower()
        end),
        f(function(_, snip)
          return snip.env.TM_FILENAME_BASE:gsub("^%l", string.upper)
        end),
        f(function(_, snip)
          return snip.env.TM_FILENAME_BASE:gsub("^%l", string.upper)
        end),
      }
    )
  ),

  s(
    "acs",
    fmt(
      [[
  import './{}.scss'

  const {} = () => {{
    return (
      <div className="{}">{}</div>
    )
  }}

  export default {}
    ]],
      {
        f(function(_, snip)
          return snip.env.TM_FILENAME_BASE:lower()
        end),
        f(function(_, snip)
          return snip.env.TM_FILENAME_BASE:gsub("^%l", string.upper)
        end),
        f(function(_, snip)
          return snip.env.TM_FILENAME_BASE:lower()
        end),
        f(function(_, snip)
          return snip.env.TM_FILENAME_BASE:gsub("^%l", string.upper)
        end),
        f(function(_, snip)
          return snip.env.TM_FILENAME_BASE:gsub("^%l", string.upper)
        end),
      }
    )
  ),

  s(
    "comp",
    fmt(
      [[
  const {} = () => {{
    return (
      <div>{}</div>
    )
  }}

  export default {}
    ]],
      {
        f(function(_, snip)
          return snip.env.TM_FILENAME_BASE:gsub("^%l", string.upper)
        end),
        f(function(_, snip)
          return snip.env.TM_FILENAME_BASE:gsub("^%l", string.upper)
        end),
        f(function(_, snip)
          return snip.env.TM_FILENAME_BASE:gsub("^%l", string.upper)
        end),
      }
    )
  ),

  s(
    "compt",
    fmt(
      [[
  const {} = () => {{
    return (
      <div className="">{}</div>
    )
  }}

  export default {}
    ]],
      {
        f(function(_, snip)
          return snip.env.TM_FILENAME_BASE:gsub("^%l", string.upper)
        end),
        f(function(_, snip)
          return snip.env.TM_FILENAME_BASE:gsub("^%l", string.upper)
        end),
        f(function(_, snip)
          return snip.env.TM_FILENAME_BASE:gsub("^%l", string.upper)
        end),
      }
    )
  ),
})

-- Add the same snippets for TypeScript React
ls.add_snippets("typescriptreact", ls.get_snippets "javascriptreact")
