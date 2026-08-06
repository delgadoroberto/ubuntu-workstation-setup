-- Neovim configuration

-- Plugin manager: lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"

  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})

    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- Plugin configuration
require("lazy").setup({

  -- Catppuccin theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,

    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
      })

      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Treesitter syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",

    config = function()
      require("nvim-treesitter").setup()

      require("nvim-treesitter").install({
        "lua",
        "vim",
        "vimdoc",
        "bash",
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "lua", "vim", "vimdoc", "bash" },
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
})

-- Editor options

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight the current line
vim.opt.cursorline = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Search behavior
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- UI
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.updatetime = 250
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Cursor style
-- Block cursor for Normal, Visual, and Command-line modes
vim.opt.guicursor = "n-v-c:block"
