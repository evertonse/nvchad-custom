local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes
  b.formatting.clang_format.with {
    filetype = { "c", "cpp", "cs", "java" },
    extra_args = { "--style", "{IndentWidth: 4}" },
  },
  -- Lua
  b.formatting.stylua,
  b.code_actions.gitsigns,
  -- cpp
  b.formatting.clang_format,
  b.diagnostics.eslint,
  b.completion.spell,

  --b.diagnostics.shellcheck,
}

null_ls.setup {
  debug = true,
  sources = sources,
  on_init = function(new_client, _)
    new_client.offset_encoding = "utf-16"
    
  end,
}
