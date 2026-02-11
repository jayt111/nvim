return {
  "Kohirus/cppassist.nvim",
  opts = true,
  ft = { "cpp", "hpp", "c", "h", "cmake" },
  config = function()
    require("cppassist").setup()
  end,
}
