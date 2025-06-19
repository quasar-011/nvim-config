local Terminal = require("toggleterm.terminal").Terminal

-- Function to run code based on file type
local function run_code()
  local filename = vim.fn.expand("%:p") -- Get full file path
  local filetype = vim.bo.filetype -- Get file type
  local cmd = nil -- Default to nil

  if filetype == "c" then
    cmd = "gcc '" .. filename .. "' -o out && ./out; rm out"
  elseif filetype == "cpp" then
    cmd = "g++ '" .. filename .. "' -o out && ./out; rm out"
  elseif filetype == "python" then
    cmd = "python3 '" .. filename .. "'"
  elseif filetype == "java" then
    cmd = "javac '" .. filename .. "' && java " .. vim.fn.expand("%:t:r")
  elseif filetype == "javascript" then
    cmd = "node '" .. filename .. "'"
  elseif filetype == "typescript" then
    cmd = "ts-node '" .. filename .. "'"
  elseif filetype == "sh" then
    cmd = "bash '" .. filename .. "'"
  elseif filetype == "lua" then
    cmd = "lua '" .. filename .. "'"
  elseif filetype == "rust" then
    cmd = "cargo run"
  elseif filetype == "go" then
    cmd = "go run '" .. filename .. "'"
  elseif filetype == "php" then
    cmd = "php '" .. filename .. "'"
  else
    vim.notify("No run command for filetype: " .. filetype, vim.log.levels.WARN)
    return
  end

  -- Open a floating terminal and run the command
  Terminal:new({ cmd = cmd, direction = "float", close_on_exit = false }):toggle()
end

-- Assign F5 to run code
vim.keymap.set("n", "<F5>", run_code, { desc = "Run code in floating terminal", noremap = true, silent = true })

-- Additional Keymaps for LuaSnip Snippet Expansion
local ls = require("luasnip")

vim.keymap.set({ "i", "s" }, "<Tab>", function()
  if ls.expand_or_jumpable() then
    return "<Plug>luasnip-expand-or-jump"
  else
    return "<Tab>"
  end
end, { expr = true, silent = true })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  if ls.jumpable(-1) then
    return "<Plug>luasnip-jump-prev"
  else
    return "<S-Tab>"
  end
end, { expr = true, silent = true })
