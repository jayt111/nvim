-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- CPP keybinds
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "h", "hpp", "cmake" },
  callback = function(ev)
    local wk = require("which-key")
    wk.add({
      { "<leader>h", group = "CPP Assist", icon = "󰙲", buffer = ev.buf },
    })

    vim.keymap.set("n", "<leader>hi", "<cmd>ImplementInSource<CR>", {
      desc = "Implement Function in Source",
      buffer = ev.buf,
      silent = true,
    })

    vim.keymap.set("n", "<leader>hh", "<cmd>SwitchSourceAndHeader<CR>", {
      desc = "Switch Between Source and Header",
      buffer = ev.buf,
      silent = true,
    })

    vim.keymap.set("n", "<leader>hc", "<cmd>CMakeCloseRunner<CR>", {
      desc = "Close CMake Runner",
      buffer = ev.buf,
      silent = true,
    })
    vim.keymap.set("n", "<F29>", "<cmd>CMakeRun<CR>", {
      desc = "Run CMake",
      buffer = ev.buf,
      silent = true,
    })
    vim.keymap.set("n", "<leader>hr", "<cmd>CMakeRun<CR>", {
      desc = "Run CMake",
      buffer = ev.buf,
      silent = true,
    })
    vim.keymap.set("n", "<leader>ht", "<cmd>CMakeRunTest<CR>", {
      desc = "Run Tests",
      buffer = ev.buf,
      silent = true,
    })
    vim.keymap.set("n", "<leader>hg", "<cmd>CMakeGenerate<CR>", {
      desc = "CMake Generate",
      buffer = ev.buf,
      silent = true,
    })
    vim.keymap.set("n", "<leader>hb", "<cmd>CMakeBuild<CR>", {
      desc = "CMake Build",
      buffer = ev.buf,
      silent = true,
    })
    vim.keymap.set("n", "<leader>ho", "<cmd>ImplementOutOfClass<CR>", {
      desc = "Implement in header",
      buffer = ev.buf,
      silent = true,
    })
    vim.keymap.set("n", "<leader>hv", "<cmd>GotoHeaderFile<CR>", {
      desc = "Go to header",
      buffer = ev.buf,
      silent = true,
    })
  end,
})

-- Agda keybinds
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "agda" },
  callback = function(ev)
    local wk = require("which-key")
    wk.add({
      { "<leader>h", group = "Agda Mode", icon = "󰯬", buffer = ev.buf },
    })

    vim.keymap.set(
      "n",
      "<leader>hl",
      "<cmd>CornelisLoad<CR>",
      { desc = "Load Agda File", buffer = ev.buf, silent = true }
    )

    vim.keymap.set(
      "n",
      "<leader>hc",
      "<cmd>CornelisTypeContext<CR>",
      { desc = "Show Type Context", buffer = ev.buf, silent = true }
    )

    vim.keymap.set("n", "<leader>hg", "<cmd>CornelisGoals<CR>", { desc = "Show Goals", buffer = ev.buf, silent = true })

    vim.keymap.set("n", "<leader>hs", "<cmd>CornelisSolve<CR>", { desc = "Solve Goal", buffer = ev.buf, silent = true })

    vim.keymap.set(
      "n",
      "<leader>ha",
      "<cmd>CornelisAuto<CR>",
      { desc = "Auto Solve Goal", buffer = ev.buf, silent = true }
    )

    vim.keymap.set(
      "n",
      "<leader>hr",
      "<cmd>CornelisRefine<CR>",
      { desc = "Refine Goal", buffer = ev.buf, silent = true }
    )

    vim.keymap.set(
      "n",
      "<leader>hn",
      "<cmd>CornelisNormalize<CR>",
      { desc = "Normalize Expression", buffer = ev.buf, silent = true }
    )

    vim.keymap.set(
      "n",
      "<leader>ht",
      "<cmd>CornelisTypeInfer<CR>",
      { desc = "Infer Type", buffer = ev.buf, silent = true }
    )

    vim.keymap.set(
      "n",
      "<leader>hm",
      "<cmd>CornelisMakeCase<CR>",
      { desc = "Make Case", buffer = ev.buf, silent = true }
    )

    vim.keymap.set("n", "<leader>hh", "<cmd>CornelisGive<CR>", { desc = "Give", buffer = ev.buf, silent = true })
    -- Insert Unicode symbol picker
    vim.keymap.set("i", "<localleader>u", function()
      require("telescope.builtin").symbols({
        prompt_title = "Insert Unicode Symbol",
        sources = { "math", "greek", "latex", "arrows" },
      })
    end, { desc = "Insert Unicode symbol", buffer = ev.buf, silent = true })

    -- Auto load on save
    vim.api.nvim_create_autocmd("BufWritePost", {
      buffer = ev.buf,
      callback = function()
        -- safety check
        if vim.fn.exists(":CornelisLoad") == 2 then
          vim.cmd("CornelisLoad")
        end
      end,
    })

    vim.cmd([[call cornelis#bind_input("lam", "λ")]])
  end,
})
-- Hide CMakeTools runner terminal from buffer list (buffer gets renamed after TermOpen)
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function(ev)
    vim.defer_fn(function()
      if not vim.api.nvim_buf_is_valid(ev.buf) then
        return
      end

      local name = vim.api.nvim_buf_get_name(ev.buf)
      if name:match("%[CMakeTools%]: Runner Terminal") then
        vim.bo[ev.buf].buflisted = false
      end
    end, 50) -- small delay so the plugin has time to rename it
  end,
})
