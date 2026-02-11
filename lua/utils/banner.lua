local BIG_WIDTH = 60
local SMALL_WIDTH = 24

local M = {}

function M.insert_banner()
  vim.ui.select({ "Big", "Small" }, {
    prompt = "Select Size",
  }, function(choice)
    if not choice then
      return -- cancelled
    end

    local total_width = (choice == "Small") and SMALL_WIDTH or BIG_WIDTH

    vim.ui.input({ prompt = "Banner text: " }, function(title)
      if not title or title == "" then
        return -- cancelled/empty
      end

      -- Detect comment style
      local cs = vim.bo.commentstring
      if cs == "" or not cs:find("%%s") then
        cs = "// %s"
      end

      -- Extract comment prefix (e.g. "// " or "# ")
      local prefix = cs:match("^(.-)%%s") or "// "
      if prefix ~= "" and not prefix:match("%s$") then
        prefix = prefix .. " "
      end

      local content_width = math.max(1, total_width - #prefix)

      -- Format title with padding
      local text = " " .. title .. " "
      local fill = "-"

      if #text > content_width then
        text = text:sub(1, content_width)
      end

      local padding = content_width - #text
      local left = math.floor(padding / 2)
      local right = padding - left

      local banner = prefix .. string.rep(fill, left) .. text .. string.rep(fill, right)

      vim.api.nvim_put({ banner }, "l", true, true)
    end)
  end)
end

return M
