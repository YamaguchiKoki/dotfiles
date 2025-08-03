local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.opt.langmenu = 'en_US.UTF-8'
vim.cmd('language message en_US.UTF-8')
vim.opt.clipboard = 'unnamedplus'

map('i', 'jk', '<ESC>', opts)
map("n", "<S-h>", "^", opts)
map("n", "<S-l>", "$", opts)
map("v", "<S-h>", "^", opts)
map("v", "<S-l>", "$", opts)
map("n", "+", "<C-a>", opts)
map("n", "-", "<C-x>", opts)

-- vscode only
--if vim.g.vscode then
--end
-- neovim only
-- VSCode統合の場合
-- リーダーキーをスペースに設定
vim.g.mapleader = " "

if vim.g.vscode then
  -- VSCode用の設定
  local vscode = require('vscode')

  -- ファイル操作
  vim.keymap.set({'n', 'x'}, '<leader>e', function() vscode.call('workbench.view.explorer') end)
  vim.keymap.set({'n', 'x'}, '<leader>f', function() vscode.call('workbench.action.quickOpen') end)
  vim.keymap.set({'n', 'x'}, '<leader>F', function() vscode.call('workbench.action.findInFiles') end)

  -- タブ操作
  vim.keymap.set('n', '<leader>x', function() vscode.call('workbench.action.closeActiveEditor') end)
  vim.keymap.set('n', '<leader>X', function() vscode.call('workbench.action.closeAllEditors') end)

  -- 画面分割
  vim.keymap.set('n', '<leader>v', function() vscode.call('workbench.action.splitEditor') end)
  vim.keymap.set('n', '<leader>s', function() vscode.call('workbench.action.splitEditorDown') end)

  -- コマンドパレット
  vim.keymap.set({'n', 'x'}, '<leader><leader>', function() vscode.call('workbench.action.showCommands') end)

  -- 定義ジャンプ
  vim.keymap.set('n', 'gd', function() vscode.call('editor.action.revealDefinition') end)
  vim.keymap.set('n', 'gr', function() vscode.call('editor.action.goToReferences') end)
else
  -- 通常のNeovim用の設定
  -- ...
end
