-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}
local c = require "custom.user.colors.vscode"
local vs = require "custom.user.colors.vs"
local is_transparent = require("custom.user.vars").transparency
-- @important check https://github.com/NvChad/base46/blob/v2.0/lua/base46/integrations/tbline.lua
-- for better ideia of highlight groups
-- @imporant also check https://github.com/NvChad/ui/blob/v2.0/lua/nvchad_ui/tabufline/modules.lua for default config
-- of statusline and tabline
-- @important highlights https://github.com/folke/tokyonight.nvim/blob/284667adfff02b9a0adc65968c553c6096b543b6/lua/tokyonight/theme.lua#L182
M.override = {
  ---@type Base46HLGroupsList
  -----------------EDITOR------------------------------
  Normal = { fg = c.vscFront, bg = is_transparent and "none" or c.vscCursorDarkDark },
  ColorColumn = { fg = "NONE", bg = is_transparent and "none" or c.vscCursorDarkDark },
  Cursor = {
    fg = c.vscCursorDark, --[[ bg = c.vscCursorLight ]]
  },
  CursorLine = { bg = c.vscCursorDarkDark },
  CursorColumn = { fg = "NONE", bg = c.vscCursorDarkDark },
  Directory = {
    fg = vs.Method, --[[ bg = c.vscBack ]]
  },
  DiffAdd = { fg = "NONE", bg = c.vscDiffGreenLight },
  DiffChange = { fg = "NONE", bg = c.vscDiffRedDark },
  DiffDelete = { fg = "NONE", bg = c.vscDiffRedLight },
  DiffText = { fg = "NONE", bg = c.vscDiffRedLight },
  EndOfBuffer = { fg = c.vscBack, bg = "NONE" },
  ErrorMsg = {
    fg = c.vscRed, --[[ bg = c.vscBack ]]
  },
  VertSplit = {
    fg = c.vscSplitDark, --[[ bg = c.vscBack ]]
  },
  Folded = {
    fg = "NONE", --[[ bg = c.vscFoldBackground ]]
  },
  FoldColumn = {
    fg = c.vscLineNumber, --[[ bg = c.vscBack ]]
  },
  SignColumn = {
    fg = "NONE", --[[ bg = c.vscBack ]]
  },
  IncSearch = { fg = c.vscNone, bg = c.vscSearchCurrent },
  LineNr = {
    fg = c.vscLineNumber, --[[bg = c.vscBack]]
  },
  CursorLineNr = {
    fg = c.vscPopupFront, --[[bg = c.vscBack ]]
  },
  MatchParen = { fg = c.vscNone, bg = c.vscCursorDark },
  ModeMsg = {
    fg = c.vscFront, --[[ bg = c.vscLeftDark ]]
  },
  MoreMsg = {
    fg = c.vscFront, --[[ bg = c.vscLeftDark ]]
  },
  NonText = {
    fg = c.vscLineNumber, --[[bg = c.vscNone]]
  },
  Pmenu = {
    fg = c.vscPopupFront, --[[ bg = c.vscPopupBack ]]
  },
  PmenuSel = { fg = c.vscPopupFront, bg = c.vscPopupHighlightBlue },
  PmenuSbar = {
    fg = "NONE", --[[ bg = c.vscPopupHighlightGray ]]
  },
  PmenuThumb = {
    fg = "NONE", --[[ bg = c.vscPopupFront ]]
  },
  Question = {
    fg = c.vscBlue, --[[ bg = c.vscBack ]]
  },
  Search = { fg = c.vscNone, bg = c.vscSearch },
  SpecialKey = { fg = c.vscBlue, bg = c.vscNone },
  --StatusLine      =   { fg = c.vscFront, --[[ bg = c.vscLeftMid ]] },
  StatusLineNC = {
    fg = c.vscFront, --[[ bg = c.vscLeftDark ]]
  },
  Todo = {
    fg = c.vscYellowOrange,--[[ bg = c.vscBack ]]
    bold = true,
  },
  TabLine = { fg = c.vscFront, bg = c.vscTabOther },
  TabLineFill = { fg = c.vscFront, bg = c.vscTabOutside },
  TabLineSel = { fg = c.vscFront, bg = c.vscTabCurrent },
  Title = { --[[ fg = c.vscNone, bg = c.vscNone, ]]
    bold = true,
  },
  Visual = { fg = c.vscNone, bg = c.vscSelection },
  VisualNOS = { fg = c.vscNone, bg = c.vscSelection },
  WarningMsg = { fg = c.vscRed, bg = c.vscBack, bold = true },
  WildMenu = { fg = c.vscNone, bg = c.vscSelection },
  ["@spell"] = { fg = vs.Normal, bg = vs.None, italic = true },
  ["@spell.markdown"] = { fg = vs.Normal, bg = vs.None, italic = true, bold = true },
  -------------------------------------------------------------------------

  --------------------------BASIC-----------------
  Comment = { fg = vs.Comment, bg = "NONE" },
  Variable = { fg = vs.Variable, bg = "None" },

  Constant = { fg = vs.Constant, bg = "NONE" },
  Global = { fg = vs.Global, bg = "NONE" },
  String = { fg = c.vscOrange, bg = "NONE" },
  Character = { fg = c.vscOrange, bg = "NONE" },
  Number = { fg = c.vscLightGreen, bg = "NONE" },
  Boolean = { fg = c.vscBlue, bg = "NONE" },
  Float = { fg = c.vscLightGreen, bg = "NONE" },
  Identifier = { fg = vs.Normal, bg = "NONE" },
  Function = { fg = c.vscYellow, bg = "NONE" },
  Statement = { fg = vs.Preprocessor, bg = "NONE" },
  Conditional = { fg = vs.ControlFlow, bg = "NONE" },
  Repeat = { fg = vs.ControlFlow, bg = "NONE" },
  Label = { fg = vs.ControlFlow, bg = "NONE" },
  Operator = { fg = vs.Normal, bg = "NONE" },
  Keyword = { fg = vs.Keyword, bg = "NONE" },
  Exception = { fg = vs.ControlFlow, bg = "NONE" },
  PreProc = { fg = vs.Preprocessor, bg = "NONE" },
  Include = { fg = vs.Preprocessor, bg = "NONE" },
  Define = { fg = vs.Preprocessor, bg = "NONE" },
  Macro = { fg = vs.Macro, bg = "NONE" },
  Type = { fg = vs.Type, bg = "NONE" },
  StorageClass = { fg = vs.Keyword, bg = "NONE" },
  Structure = { fg = vs.Type, bg = "NONE" },
  Typedef = { fg = vs.Type, bg = "NONE" },
  Special = { fg = c.vscYellowOrange, bg = "NONE" },
  Namespace = { fg = vs.Namespace },
  SpecialChar = { fg = c.vscFront, bg = "NONE" },
  Tag = { fg = c.vscFront, bg = "NONE" },
  Delimiter = { fg = c.vscFront, bg = "NONE" },
  SpecialComment = { fg = vs.Comment, bg = "NONE" },
  Debug = { fg = c.vscFront, bg = "NONE" },
  Underlined = { fg = c.vscNone, bg = "NONE", underline = true },
  Conceal = {
    fg = c.vscFront, --[[ bg = c.vscBack ]]
  },
  Ignore = { fg = c.vscFront, bg = "NONE" },
  Error = { fg = c.vscRed, bg = c.vscBack, undercurl = true, sp = c.vscRed },
  -- SpellBad = { fg = c.vscRed, bg = c.vscBack, undercurl = true, sp = c.vscRed },
  -- SpellCap = { fg = c.vscRed, bg = c.vscBack, undercurl = true, sp = c.vscRed },
  -- SpellRare = { fg = c.vscRed, bg = c.vscBack, undercurl = true, sp = c.vscRed },
  -- SpellLocal = { fg = c.vscRed, bg = c.vscBack, undercurl = true, sp = c.vscRed },

  --DiagnosticError = { fg = vs.}, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
  DiagnosticWarn = { fg = c.warning }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
  DiagnosticInfo = { fg = c.info }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
  DiagnosticHint = { fg = c.hint }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
  DiagnosticUnnecessary = { fg = vs.Unnecessary, bg = vs.None, italic=true, undercurl = true, sp = c.vscRed },

  --Whitespace      =   { fg = c.vscLineNumber },
  TODO = { fg = c.vscRed },
  LspGlobal = { fg = vs.Global, bg = "None", bold = true },
  GlobalScope = { fg = vs.Global, bg = "None", bold = true },
  ["@global"] = { fg = vs.Global, bg = "None", bold = true },
  LspGlobalScope = { fg = vs.Global, bg = "None", bold = true },
  LspNamespace = { fg = vs.Global, bg = "None", bold = true },
  namespace = { fg = vs.Global, bg = "None" },
  ["@class"] = { fg = vs.Type, bold = false, italic = false },
  ["@macro"] = { fg = vs.Macro, bold = false, italic = false },
  ["@namespace"] = { fg = vs.Namespace, bold = false, italic = false },
  ["@globalScope"] = { italic = true, bold = true },
  --['@variable#globalScope']  ={ fg = vs.Global,italic = true,  bold = true},
  ["@defaultLibrary.python"] = { fg = vs.Native },
  ["@defaultLibrary.lua"] = { fg = vs.Native },

  ["@comment"] = { fg = vs.Comment, bg = "NONE" },
  ["@keyword"] = { fg = vs.Keyword, bg = "NONE" },
  ["@keyword.return"] = { fg = vs.ControlFlow, bg = "NONE" }, -- return,
  ["@keyword.function"] = { fg = vs.Keyword, bg = "NONE" },
  ["@keyword.operator"] = { fg = vs.Keyword, bg = "NONE" },

  -- Fucntions
  ["@function"] = { fg = vs.Function, bg = "NONE" },
  ["@function.builtin"] = { fg = c.vscYellowOrange, bg = "NONE" },
  ["@function.macro"] = { fg = vs.MacroFunction, bg = "NONE" },
  ['@function.call']= { fg = vs.FunctionCall, bg = 'NONE' },

  ['@method.call.python']= { fg = vs.Method, bg = 'NONE' },
  ['@method.call']= { fg = vs.Method, bg = 'NONE' },
  ['@method']= { fg = vs.Method, bg = 'NONE' },

  --Literals
  ["@string.regex"] = { fg = c.vscOrange, bg = "NONE" },
  ["@string.escape"] = { fg = vs.Special, bg = "NONE" },
  ["@string"] = { fg = c.vscOrange, bg = vs.None },

  ["@character"] = { fg = c.vscOrange, bg = "NONE" },
  ["@number"] = { fg = c.vscLightGreen, bg = "NONE" },
  ["@boolean"] = { fg = c.vscBlue, bg = "NONE" },
  ["@float"] = { fg = c.vscLightGreen, bg = "NONE" },

  -- Variables
  ["@variable"] = { fg = vs.Variable, bg = "NONE" },
  ["@variable.builtin"] = { fg = vs.VariableBuiltin, bg = "NONE" },
  ["@field"] = { fg = vs.Normal, bg = "NONE" },
  ["@property"] = { fg = vs.Normal, bg = "NONE" },
  ["@reference"] = { fg = vs.Normal, bg = "NONE" },
  -- Preprocessores
  ["@preproc"] = { fg = vs.Preprocessor, bg = "NONE" },
  ["@define"] = { fg = vs.Preprocessor, bg = "NONE" },
  ["@include"] = { fg = vs.Preprocessor, bg = "NONE" },

  -- Parameteres:
  ["@parameter"] = { fg = vs.Parameter, bg = "NONE" },
  ["@parameter.reference"] = { fg = vs.Parameter, bg = "NONE" },

  -- @Types
  ["@type"] = { fg = vs.Type, bg = "NONE" },
  ["@type.qualifier"] = { fg = vs.Keyword, bg = "NONE" },
  ["@type.qualifier.cpp"] = { fg = vs.Keyword, bg = "NONE" },
  ["@type.qualifier.c"] = { fg = vs.Keyword, bg = "NONE" },
  ["@type.definition"] = { fg = vs.Keyword, bg = "NONE" },
  ["@type.builtin"] = { fg = vs.Keyword, bg = "NONE" },
  ["@type.builtin.py"] = { fg = vs.Type, bg = "NONE" },
  ["@type.builtin.python"] = { fg = vs.Type, bg = "NONE" },
  ['@storageclass']= { fg = vs.Keyword, bg = 'NONE' },
  --['@structure']= { fg = vs.Type, bg = 'NONE' },

  -- @Tags
  ["@tag.delimiter"] = { fg = c.vscGray, bg = "NONE" },
  ["@tag.attribute"] = { fg = c.Keyword, bg = "NONE" },

  ["@text.title"] = { fg = c.vscBlue, bold = true },
  ["@text.literal"] = { fg = c.vscFront, bg = "NONE" },
  ["@text.diff.delete.diff"]= { fg = c.vscDiffRedLight},
  ["@text.diff.add.diff"]= { fg = c.vscGitAdded },

  --['@definition.macro']= { fg = vs.Macro, bg = 'NONE' },
  --['@definition.var']= { fg = vs.Macro, bg = 'NONE' },

  --['@macro.cpp']= { fg = vs.Macro, bg = 'NONE' },
  ['@constant.macro.cpp']= { fg = vs.Macro, bg = 'NONE' },
  --['@error']= { fg = c.vscRed, bg = 'NONE' },
  --['@punctuation.bracket']= { fg = c.vscFront, bg = 'NONE' },
  ["@punctuation.special"] = { fg = c.vscYellow, bg = "NONE" },
  --['@constant']= { fg = c.Macro, bg = 'NONE' },
  ['@constant.builtin']= { fg = vs.BuiltInConstant, bg = 'NONE' },

  --['@annotation']= { fg = c.vscYellow, bg = 'NONE' },
  --['@attribute']= { fg = c.vscBlueGreen, bg = 'NONE' },

  ["@constructor"] = { fg = vs.Construtor },
  ["@constructor.cpp"] = { fg = vs.Construtor, bold = true },
  ["@constructor.py"] = { fg = vs.Construtor, bold = true },

  ["@conditional"] = { fg = vs.ControlFlow, bg = "NONE" },
  ["@repeat"] = { fg = vs.ControlFlow, bg = "NONE" },
  ["@label"] = { fg = vs.Label, bg = "NONE" },
  ["@operator"] = { fg = c.vscFront, bg = "NONE" },

  ["@exception"] = { fg = vs.ControlFlow, bg = "NONE" },
  ["@exception.python"] = { fg = vs.ControlFlow, bg = "NONE" },
  -- ['@variable.builtin']= { fg = vs.VariableBuiltin, bg = 'NONE' },
  -- ['@text']= { fg = c.vscFront, bg = 'NONE' },
  -- ['@text.underline']= { fg = c.vscYellowOrange, bg = 'NONE' },
  -- ['@tag']= { fg = vs.Normal, bg = 'NONE' },
  -- ['markdown@text.literal']= { fg = c.vscOrange, bg = 'NONE' },
  -- ['markdown_inline@text.literal']= { fg = c.vscOrange, bg = 'NONE' },
  -- ['@text.emphasis']= { fg = c.vscFront, bg = 'NONE', italic = true },
  -- ['@text.strong']= { fg = isDark and c.vscBlue or c.vscViolet, bold = true },
  -- ['@text.uri']= { fg = c.vscFront, bg = 'NONE' },
  -- ['@textReference']= { fg = isDark and c.vscOrange or c.vscYellowOrange },
  -- ['@punctuation.delimiter']= { fg = c.vscFront, bg = 'NONE' },
  -- ['@text.note']= { fg = c.vscBlueGreen, bg = 'NONE', bold = true },
  -- ['@text.warning']= { fg = c.vscYellowOrange, bg = 'NONE', bold = true },
  -- ['@text.danger']= { fg = c.vscRed, bg = 'NONE', bold = true },
  -- ['@scope']= { fg = c.vscRed, bg = 'NONE', bold = true },
  ----------------------TAB-----------------------------
  TblineFill = {
    bg = vs.None,
  },

  TbLineBufOn = {
    bg = vs.None,
  },

  TbLineBufOff = {
    bg = vs.None,
  },

  TbLineBufOnModified = {
    bg = vs.None,
  },

  TbBufLineBufOffModified = {
    bg = vs.None,
  },

  TbLineBufOnClose = {
    bg = vs.None,
  },

  TbLineBufOffClose = {
    bg = vs.None,
  },

  -- TblineTabNewBtn = {
  --   fg = colors.white,
  --   bg = colors.one_bg3,
  --   bold = true,
  -- },
  --
  -- TbLineTabOn = {
  --   fg = colors.black,
  --   bg = colors.nord_blue,
  --   bold = true,
  -- },
  --
  -- TbLineTabOff = {
  --   fg = colors.white,
  --   bg = colors.one_bg2,
  -- },
  --
  -- TbLineTabCloseBtn = {
  --   fg = colors.black,
  --   bg = colors.nord_blue,
  -- },
  --
  -- TBTabTitle = {
  --   fg = colors.black,
  --   bg = colors.white,
  -- },
  --
  -- TbLineThemeToggleBtn = {
  --   bold = true,
  --   fg = colors.white,
  --   bg = colors.one_bg3,
  -- },
  --
  -- TbLineCloseAllBufsBtn = {
  --   bold = true,
  --   bg = colors.red,
  --   fg = colors.black,
  -- },
  StatusLine = {
    bg = vs.None,
  },
  St_Mode = {
    fg = vs.None,
    bg = vs.None,
  },
  StText = {
    fg = vs.None,
    bg = vs.None,
  },
  St_EmptySpace = {
    fg = vs.None,
    bg = vs.None,
  },
  St_EmptySpace2 = {
    fg = vs.None,
    bg = vs.None,
  },
  -- St_pos_text = {
  --   fg = vs.None,
  --   bg = vs.None,
  -- },
  --
  NvimTreeOpenedFolderName = {
    --fg = "#9099dd",
    bold = true,
  },
}

---@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { --[[ fg = "#9098dd" ]]
    bold = true,
  },
}

return M
--return {override={}, add={}}
