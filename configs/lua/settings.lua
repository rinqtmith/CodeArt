-- Defining alias for vim.opt.
local opt = vim.opt
local exec = vim.api.nvim_exec

local NoWhitespace = exec(
    [[
    function! NoWhitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfunction
    call NoWhitespace()
    ]],
    true
)

-- Number settings.
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true

-- Set signcolumn width to 2
vim.opt.signcolumn = "yes:3"

-- Remove showing mode.
opt.showmode = false

-- True collor support.
opt.termguicolors = true

-- Enable clipboard.
opt.clipboard = "unnamedplus"

-- Enable mouse in all modes.
opt.mouse = "a"

-- Enable cursor line.
opt.cursorline = true

-- Setting colorcolumn. This is set because of
-- this (https://github.com/lukas-reineke/indent-blankline.nvim/issues/59)
-- indent-blankline bug.
opt.colorcolumn = "9999"

-- With set hidden you’re telling Neovim that you can
-- have unsaved worked that’s not displayed on your screen.
opt.hidden = true

-- Set indentation stuf.
opt.tabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.smartcase = true
opt.expandtab = true
opt.smarttab = true

-- Set searching stuf.
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true

-- Set terminal bidirectual.
-- For writing in right to left languages like arabic, persian and hebrew.
opt.termbidi = true

-- Without this option some times backspace did not work correctly.
opt.backspace = "indent,eol,start"

-- For opening splits on right or bottom.
opt.splitbelow = true
opt.splitright = true

-- Enabling ruler and statusline.
opt.ruler = true

-- Setting time that Neovim wait after each keystroke.
opt.ttimeoutlen = 20
opt.timeoutlen = 1000

-- Setting up autocomplete menu.
opt.completeopt = "menuone,noselect"

-- Add cursorline and diasable it in terminal
vim.cmd("autocmd WinEnter,BufEnter * if &ft is \"toggleterm\" | set nocursorline | else | set cursorline | endif")

-- Set line number for help files.
vim.cmd
[[
augroup help_config
  autocmd!
  autocmd FileType help :set number
augroup END
]]

-- Trim Whitespace
exec([[au BufWritePre * call NoWhitespace()]], false)

-- Auto open nvim-tree when writing (nvim .) in command line
-- and auto open Dashboard when nothing given as argument.
vim.cmd
[[
if index(argv(), ".") >= 0
  autocmd VimEnter * NvimTreeOpen
  bd1
elseif len(argv()) == 0
  autocmd VimEnter * Dashboard
endif
]]

vim.cmd
[[
if has("win32")
  command CodeArtUpdate !powershell.exe -executionpolicy bypass -file "$HOME\AppData\Local\nvim\CodeArtUpdate.ps1"
else
  command CodeArtUpdate !bash ~/.config/nvim/CodeArtUpdate.sh
endif
]]

-- NOTE: Your shell must be powershell in bellow code block because of :CodeArtUpdate command
vim.cmd
[[
if has("win32")
  set shell=powershell " Your shell must be powershell
  let &shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  let &shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  let &shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  set shellquote= shellxquote=
endif
]]

vim.cmd("command CodeArtTransparent lua make_codeart_transparent()")
