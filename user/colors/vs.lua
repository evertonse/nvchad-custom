local M = {}

M.code =  {
  None              = "NONE",
  Debug             = "#FF00FF",
  DeadCode          = "#616161",
  Comment           = "#435f37",
  Args              = "#909090",
  -- Parameter         = "#9a9a9a",
  Parameter         = "#909090",
  Type              = "#4EC9B0",
  Construtor        = "#4EC9B0",
  ConstrutorOnClass = "#DCd97D",
  Namespace         = "#cffae4",
  Global            = "#F8D1EF",
  FileScope         = "#e8D7D7",
  Property          = "#DADADA",
  SelfParameter     = "#CAC4FF",
  Numeric           = "#b5cea8",
  Invalid           = "#f44747",
  MacroFunction     = "#cac4ff",
  Macro             = "#bbafff",
  Normal            = "#DADADA",
  Preprocessor      = "#9b9b9b",
  Unnecessary       = "#919191",
  Keyword           = "#569CD6",
  VariableLocal     = "#9CDCFE",
  Variable          = "#9CDCFE",
  VariableBuiltin   = "#2369a2",
  ControlFlow       = "#C586C0",
  Label             = "#C586C0",
  Method            = "#DCDCAA",
  Function          = '#DCDCAA',
  FunctionCall      = '#DCDCAA',
  Native            = "#D7BA7D",
  Special           = "#D7BA7D",
  Constant          = "#A5797A",
  EnumConstant      = "#A9797A",
  BuiltInConstant   = "#BA797A",

}

M.text = {
  Background        = "NONE",
  DiffAdd           = "#81b88b",
  Title             = "#D7BA7D",
  DiffDelete        = "#f44747",
}

M.editor = { -- VS Code
  None = "NONE",
  Front = "#D4D4D4",
  Back = "#1E1E1E",

  TabCurrent = "#1E1E1E",
  TabOther = "#2D2D2D",
  TabOutside = "#252526",

  LeftDark = "#252526",
  LeftMid = "#373737",
  LeftLight = "#636369",

  PopupFront = "#BBBBBB",
  PopupBack = "#272727",
  PopupHighlightBlue = "#004b72",
  PopupHighlightGray = "#343B41",

  SplitLight = "#898989",
  SplitDark = "#444444",
  SplitThumb = "#424242",

  CursorDarkDark = "#222222",
  CursorDark = "#51504F",
  CursorLight = "#AEAFAD",
  Selection = "#264F78",
  LineNumber = "#5A5A5A",

  DiffRedDark = "#4B1818",
  DiffRedLight = "#6F1313",
  DiffRedLightLight = "#FB0101",
  DiffGreenDark = "#373D29",
  DiffGreenLight = "#4B5632",
  SearchCurrent = "#515c6a",
  Search = "#613315",

  GitAdded = "#81b88b",
  GitModified = "#e2c08d",
  GitDeleted = "#c74e39",
  GitRenamed = "#73c991",
  GitUntracked = "#73c991",
  GitIgnored = "#8c8c8c",
  GitStageModified = "#e2c08d",
  GitStageDeleted = "#c74e39",
  GitConflicting = "#e4676b",
  GitSubmodule = "#8db9e2",

  Context = "#404040",
  ContextCurrent = "#707070",

  FoldBackground = "#202d39",

  -- Syntax colors
  Gray = "#808080",
  Violet = "#646695",
  Blue = "#569CD6",
  DarkBlue = "#223E55",
  MediumBlue = "#18a2fe",
  LightBlue = "#9CDCFE",
  Green = "#6A9955",
  BlueGreen = "#4EC9B0",
  LightGreen = "#B5CEA8",
  Red = "#F44747",
  Orange = "#CE9178",
  LightRed = "#D16969",
  YellowOrange = "#D7BA7D",
  Yellow = "#DCDCAA",
  Pink = "#C586C0",
}

return M
