-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/rvonmize/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/rvonmize/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/rvonmize/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/rvonmize/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/rvonmize/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  black = {
    loaded = true,
    path = "/Users/rvonmize/.local/share/nvim/site/pack/packer/start/black"
  },
  ["gitsigns.nvim"] = {
    after = { "lualine.nvim" },
    loaded = true,
    only_config = true
  },
  ["gruvbox-material"] = {
    config = { "\27LJ\2\n€\1\0\0\3\0\t\0\0146\0\0\0009\0\1\0005\2\2\0B\0\2\0016\0\0\0009\0\3\0005\2\4\0B\0\2\0016\0\5\0009\0\6\0009\0\a\0'\2\b\0B\0\2\1K\0\1\0!colorscheme gruvbox-material\17nvim_command\bapi\bvim\1\0\1 gruvbox_material_background\vmedium\18apply_globals\1\0\2\18termguicolors\2\15background\tdark\18apply_options\nutils\0" },
    loaded = true,
    path = "/Users/rvonmize/.local/share/nvim/site/pack/packer/start/gruvbox-material"
  },
  indentLine = {
    config = { "\27LJ\2\nÖ\1\0\0\5\0\a\0\v6\0\0\0009\0\1\0005\2\2\0B\0\2\0016\0\0\0009\0\3\0'\2\4\0'\3\5\0'\4\6\0B\0\4\1K\0\1\0\27:IndentLinesToggle<CR>\14<Leader>i\6n\bmap\1\0\1\20indentLine_char\b‚îÜ\18apply_globals\nutils\0" },
    loaded = true,
    path = "/Users/rvonmize/.local/share/nvim/site/pack/packer/start/indentLine"
  },
  ["lsp-rooter.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15lsp-rooter\frequire\0" },
    loaded = true,
    path = "/Users/rvonmize/.local/share/nvim/site/pack/packer/start/lsp-rooter.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nË\3\0\0\a\0\25\0+6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\19\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0034\4\3\0005\5\f\0005\6\r\0=\6\14\5>\5\1\4=\4\15\0035\4\16\0005\5\17\0>\5\2\4=\4\18\3=\3\20\0025\3\21\0004\4\0\0=\4\5\0034\4\0\0=\4\a\0035\4\22\0=\4\t\0034\4\3\0005\5\23\0>\5\1\4=\4\v\0034\4\0\0=\4\15\0034\4\0\0=\4\18\3=\3\24\2B\0\2\1K\0\1\0\22inactive_sections\1\2\1\0\rlocation\ticon\bÓÇ°\1\2\0\0\rfilename\1\0\0\rsections\1\0\0\14lualine_z\1\2\1\0\rlocation\ticon\bÓÇ°\1\2\0\0\rprogress\14lualine_y\fsources\1\2\0\0\rnvim_lsp\1\2\0\0\16diagnostics\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\1\2\0\0\rfilename\14lualine_b\1\3\0\0\vbranch\22b:gitsigns_status\14lualine_a\1\0\0\1\2\0\0\tmode\nsetup\flualine\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/rvonmize/.local/share/nvim/site/pack/packer/opt/lualine.nvim"
  },
  ["nvim-bufferline.lua"] = {
    config = { "\27LJ\2\nU\0\2\6\0\5\0\14\18\4\1\0009\2\0\1'\5\1\0B\2\3\2\15\0\2\0X\3\2Ä'\2\2\0X\3\1Ä'\2\3\0'\3\4\0\18\4\2\0\18\5\0\0&\3\5\3L\3\2\0\6 \bÔÅ±\bÔÅó\nerror\nmatchò\1\1\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0003\4\4\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\foptions\1\0\0\26diagnostics_indicator\0\1\0\2\fnumbers\14buffer_id\16diagnostics\rnvim_lsp\nsetup\15bufferline\frequire\0" },
    loaded = true,
    path = "/Users/rvonmize/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n∆\b\0\2\t\0!\0b6\2\0\0009\2\1\2'\4\2\0'\5\3\0B\2\3\0015\2\4\0006\3\0\0009\3\5\3'\5\6\0'\6\a\0'\a\b\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\t\0'\a\n\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\v\0'\a\f\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\r\0'\a\14\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\15\0'\a\16\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\17\0'\a\18\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\19\0'\a\20\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\21\0'\a\22\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\23\0'\a\24\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\25\0'\a\26\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\27\0'\a\28\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\29\0'\a\30\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\31\0'\a \0\18\b\2\0B\3\5\1K\0\1\0*<cmd>lua vim.lsp.buf.formatting()<CR>\14<Leader>f0<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>\14<Leader>k0<cmd>lua vim.lsp.diagnostic.goto_next()<cr>\14<Leader>j<<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>\15<Leader>ee+<cmd>lua vim.lsp.buf.code_action()<cr>\15<Leader>ca&<cmd>lua vim.lsp.buf.rename()<cr>\15<Leader>rn/<cmd>lua vim.lsp.buf.type_definition()<cr>\agt.<cmd>lua vim.lsp.buf.implementation()<cr>\agi*<cmd>lua vim.lsp.buf.references()<cr>\agr.<cmd>lua vim.lsp.buf.signature_help()<cr>\n<C-k>%<cmd>lua vim.lsp.buf.hover()<cr>\6K*<cmd>lua vim.lsp.buf.definition()<cr>\agd+<cmd>lua vim.lsp.buf.declaration()<cr>\agD\6n\fbuf_map\1\0\2\vsilent\2\fnoremap\2\27v:lua.vim.lsp.omnifunc\romnifunc\15buf_option\nutilsÆ\1\1\0\f\0\n\0\0196\0\0\0'\2\1\0B\0\2\0023\1\2\0005\2\3\0006\3\4\0\18\5\2\0B\3\2\4X\6\aÄ8\b\a\0009\b\5\b5\n\6\0=\1\a\n5\v\b\0=\v\t\nB\b\2\1E\6\3\3R\6˜K\0\1\0\nflags\1\0\1\26debounce_text_changes\3ñ\1\14on_attach\1\0\0\nsetup\vipairs\1\2\0\0\fpyright\0\14lspconfig\frequire\0" },
    loaded = true,
    path = "/Users/rvonmize/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nÁ\1\0\0\4\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\2B\0\2\1K\0\1\0\16textobjects\1\0\1\venable\2\26incremental_selection\1\0\1\venable\2\vindent\1\0\1\venable\2\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/Users/rvonmize/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/rvonmize/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/rvonmize/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/rvonmize/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/rvonmize/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n∂\5\0\0\b\0 \0:6\0\0\0009\0\1\0'\2\2\0'\3\3\0'\4\4\0B\0\4\0016\0\0\0009\0\1\0'\2\2\0'\3\5\0'\4\6\0B\0\4\0016\0\0\0009\0\1\0'\2\2\0'\3\a\0'\4\b\0B\0\4\0016\0\0\0009\0\1\0'\2\2\0'\3\t\0'\4\n\0B\0\4\0016\0\0\0009\0\1\0'\2\2\0'\3\v\0'\4\f\0B\0\4\0016\0\0\0009\0\1\0'\2\2\0'\3\r\0'\4\14\0B\0\4\0016\0\15\0'\2\16\0B\0\2\0026\1\15\0'\3\17\0B\1\2\0029\1\18\0015\3\30\0005\4\26\0005\5\24\0005\6\20\0009\a\19\0=\a\21\0069\a\22\0=\a\23\6=\6\25\5=\5\27\0045\5\28\0=\5\29\4=\4\31\3B\1\2\1K\0\1\0\rdefaults\1\0\0\25file_ignore_patterns\1\4\0\0\f.git/.*\20node_modules/.*\n%.pyc\rmappings\1\0\1\20layout_strategy\rvertical\6i\1\0\0\n<C-k>\28move_selection_previous\n<C-j>\1\0\0\24move_selection_next\nsetup\14telescope\22telescope.actions\frequire,:Telescope lsp_document_diagnostics<CR>\15<Leader>od\29:Telescope help_tags<CR>\15<Leader>oh\27:Telescope buffers<CR>\15<Leader>ob\29:Telescope live_grep<CR>\15<Leader>og\30:Telescope find_files<CR>\15<Leader>of :Telescope file_browser<CR>\15<Leader>ot\6n\bmap\nutils\0" },
    loaded = true,
    path = "/Users/rvonmize/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-cool"] = {
    loaded = true,
    path = "/Users/rvonmize/.local/share/nvim/site/pack/packer/start/vim-cool"
  },
  ["vim-css-color"] = {
    loaded = true,
    path = "/Users/rvonmize/.local/share/nvim/site/pack/packer/start/vim-css-color"
  },
  ["vim-fugitive"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/Users/rvonmize/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-peekaboo"] = {
    loaded = true,
    path = "/Users/rvonmize/.local/share/nvim/site/pack/packer/start/vim-peekaboo"
  },
  ["vim-sneak"] = {
    config = { "\27LJ\2\n”\2\0\0\5\0\17\0)6\0\0\0009\0\1\0005\2\2\0B\0\2\0016\0\0\0009\0\3\0'\2\4\0'\3\5\0'\4\6\0B\0\4\0016\0\0\0009\0\3\0'\2\4\0'\3\a\0'\4\b\0B\0\4\0016\0\0\0009\0\3\0'\2\4\0'\3\t\0'\4\n\0B\0\4\0016\0\0\0009\0\3\0'\2\4\0'\3\v\0'\4\f\0B\0\4\0016\0\0\0009\0\3\0'\2\4\0'\3\r\0'\4\14\0B\0\4\0016\0\0\0009\0\3\0'\2\4\0'\3\15\0'\4\16\0B\0\4\1K\0\1\0\18<Plug>Sneak_T\6T\18<Plug>Sneak_t\6t\18<Plug>Sneak_F\6F\18<Plug>Sneak_f\6f\23<Plug>SneakLabel_S\6S\23<Plug>SneakLabel_s\6s\6n\bmap\1\0\2\21sneak#use_ic_scs\3\1\16sneak#label\3\1\18apply_globals\nutils\0" },
    loaded = true,
    path = "/Users/rvonmize/.local/share/nvim/site/pack/packer/start/vim-sneak"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/Users/rvonmize/.local/share/nvim/site/pack/packer/start/vim-startify"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: vim-sneak
time([[Config for vim-sneak]], true)
try_loadstring("\27LJ\2\n”\2\0\0\5\0\17\0)6\0\0\0009\0\1\0005\2\2\0B\0\2\0016\0\0\0009\0\3\0'\2\4\0'\3\5\0'\4\6\0B\0\4\0016\0\0\0009\0\3\0'\2\4\0'\3\a\0'\4\b\0B\0\4\0016\0\0\0009\0\3\0'\2\4\0'\3\t\0'\4\n\0B\0\4\0016\0\0\0009\0\3\0'\2\4\0'\3\v\0'\4\f\0B\0\4\0016\0\0\0009\0\3\0'\2\4\0'\3\r\0'\4\14\0B\0\4\0016\0\0\0009\0\3\0'\2\4\0'\3\15\0'\4\16\0B\0\4\1K\0\1\0\18<Plug>Sneak_T\6T\18<Plug>Sneak_t\6t\18<Plug>Sneak_F\6F\18<Plug>Sneak_f\6f\23<Plug>SneakLabel_S\6S\23<Plug>SneakLabel_s\6s\6n\bmap\1\0\2\21sneak#use_ic_scs\3\1\16sneak#label\3\1\18apply_globals\nutils\0", "config", "vim-sneak")
time([[Config for vim-sneak]], false)
-- Config for: nvim-bufferline.lua
time([[Config for nvim-bufferline.lua]], true)
try_loadstring("\27LJ\2\nU\0\2\6\0\5\0\14\18\4\1\0009\2\0\1'\5\1\0B\2\3\2\15\0\2\0X\3\2Ä'\2\2\0X\3\1Ä'\2\3\0'\3\4\0\18\4\2\0\18\5\0\0&\3\5\3L\3\2\0\6 \bÔÅ±\bÔÅó\nerror\nmatchò\1\1\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0003\4\4\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\foptions\1\0\0\26diagnostics_indicator\0\1\0\2\fnumbers\14buffer_id\16diagnostics\rnvim_lsp\nsetup\15bufferline\frequire\0", "config", "nvim-bufferline.lua")
time([[Config for nvim-bufferline.lua]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\nÌ\1\0\1\n\0\n\0-9\1\0\0009\2\1\0009\3\2\0004\4\0\0\15\0\1\0X\5\nÄ)\5\0\0\1\5\1\0X\5\aÄ6\5\3\0009\5\4\5\18\a\4\0'\b\5\0\18\t\1\0&\b\t\bB\5\3\1\15\0\2\0X\5\nÄ)\5\0\0\1\5\2\0X\5\aÄ6\5\3\0009\5\4\5\18\a\4\0'\b\6\0\18\t\2\0&\b\t\bB\5\3\1\15\0\3\0X\5\nÄ)\5\0\0\1\5\3\0X\5\aÄ6\5\3\0009\5\4\5\18\a\4\0'\b\a\0\18\t\3\0&\b\t\bB\5\3\0016\5\3\0009\5\b\5\18\a\4\0'\b\t\0D\5\3\0\6 \vconcat\6-\6~\6+\vinsert\ntable\fremoved\fchanged\nadded°\2\1\0\6\0\17\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0023\3\6\0=\3\a\2B\0\2\0016\0\b\0009\0\t\0'\2\n\0'\3\v\0'\4\f\0005\5\r\0B\0\5\0016\0\b\0009\0\t\0'\2\n\0'\3\14\0'\4\15\0005\5\16\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2\28:Gitsigns prev_hunk<CR>\15<Leader>gk\1\0\2\vsilent\2\fnoremap\2\28:Gitsigns next_hunk<CR>\15<Leader>gj\6n\bmap\nutils\21status_formatter\0\tyadm\1\0\0\1\0\1\venable\2\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: gruvbox-material
time([[Config for gruvbox-material]], true)
try_loadstring("\27LJ\2\n€\1\0\0\3\0\t\0\0146\0\0\0009\0\1\0005\2\2\0B\0\2\0016\0\0\0009\0\3\0005\2\4\0B\0\2\0016\0\5\0009\0\6\0009\0\a\0'\2\b\0B\0\2\1K\0\1\0!colorscheme gruvbox-material\17nvim_command\bapi\bvim\1\0\1 gruvbox_material_background\vmedium\18apply_globals\1\0\2\18termguicolors\2\15background\tdark\18apply_options\nutils\0", "config", "gruvbox-material")
time([[Config for gruvbox-material]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nÁ\1\0\0\4\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\2B\0\2\1K\0\1\0\16textobjects\1\0\1\venable\2\26incremental_selection\1\0\1\venable\2\vindent\1\0\1\venable\2\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: indentLine
time([[Config for indentLine]], true)
try_loadstring("\27LJ\2\nÖ\1\0\0\5\0\a\0\v6\0\0\0009\0\1\0005\2\2\0B\0\2\0016\0\0\0009\0\3\0'\2\4\0'\3\5\0'\4\6\0B\0\4\1K\0\1\0\27:IndentLinesToggle<CR>\14<Leader>i\6n\bmap\1\0\1\20indentLine_char\b‚îÜ\18apply_globals\nutils\0", "config", "indentLine")
time([[Config for indentLine]], false)
-- Config for: vim-fugitive
time([[Config for vim-fugitive]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "vim-fugitive")
time([[Config for vim-fugitive]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n∆\b\0\2\t\0!\0b6\2\0\0009\2\1\2'\4\2\0'\5\3\0B\2\3\0015\2\4\0006\3\0\0009\3\5\3'\5\6\0'\6\a\0'\a\b\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\t\0'\a\n\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\v\0'\a\f\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\r\0'\a\14\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\15\0'\a\16\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\17\0'\a\18\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\19\0'\a\20\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\21\0'\a\22\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\23\0'\a\24\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\25\0'\a\26\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\27\0'\a\28\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\29\0'\a\30\0\18\b\2\0B\3\5\0016\3\0\0009\3\5\3'\5\6\0'\6\31\0'\a \0\18\b\2\0B\3\5\1K\0\1\0*<cmd>lua vim.lsp.buf.formatting()<CR>\14<Leader>f0<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>\14<Leader>k0<cmd>lua vim.lsp.diagnostic.goto_next()<cr>\14<Leader>j<<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>\15<Leader>ee+<cmd>lua vim.lsp.buf.code_action()<cr>\15<Leader>ca&<cmd>lua vim.lsp.buf.rename()<cr>\15<Leader>rn/<cmd>lua vim.lsp.buf.type_definition()<cr>\agt.<cmd>lua vim.lsp.buf.implementation()<cr>\agi*<cmd>lua vim.lsp.buf.references()<cr>\agr.<cmd>lua vim.lsp.buf.signature_help()<cr>\n<C-k>%<cmd>lua vim.lsp.buf.hover()<cr>\6K*<cmd>lua vim.lsp.buf.definition()<cr>\agd+<cmd>lua vim.lsp.buf.declaration()<cr>\agD\6n\fbuf_map\1\0\2\vsilent\2\fnoremap\2\27v:lua.vim.lsp.omnifunc\romnifunc\15buf_option\nutilsÆ\1\1\0\f\0\n\0\0196\0\0\0'\2\1\0B\0\2\0023\1\2\0005\2\3\0006\3\4\0\18\5\2\0B\3\2\4X\6\aÄ8\b\a\0009\b\5\b5\n\6\0=\1\a\n5\v\b\0=\v\t\nB\b\2\1E\6\3\3R\6˜K\0\1\0\nflags\1\0\1\26debounce_text_changes\3ñ\1\14on_attach\1\0\0\nsetup\vipairs\1\2\0\0\fpyright\0\14lspconfig\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: lsp-rooter.nvim
time([[Config for lsp-rooter.nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15lsp-rooter\frequire\0", "config", "lsp-rooter.nvim")
time([[Config for lsp-rooter.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n∂\5\0\0\b\0 \0:6\0\0\0009\0\1\0'\2\2\0'\3\3\0'\4\4\0B\0\4\0016\0\0\0009\0\1\0'\2\2\0'\3\5\0'\4\6\0B\0\4\0016\0\0\0009\0\1\0'\2\2\0'\3\a\0'\4\b\0B\0\4\0016\0\0\0009\0\1\0'\2\2\0'\3\t\0'\4\n\0B\0\4\0016\0\0\0009\0\1\0'\2\2\0'\3\v\0'\4\f\0B\0\4\0016\0\0\0009\0\1\0'\2\2\0'\3\r\0'\4\14\0B\0\4\0016\0\15\0'\2\16\0B\0\2\0026\1\15\0'\3\17\0B\1\2\0029\1\18\0015\3\30\0005\4\26\0005\5\24\0005\6\20\0009\a\19\0=\a\21\0069\a\22\0=\a\23\6=\6\25\5=\5\27\0045\5\28\0=\5\29\4=\4\31\3B\1\2\1K\0\1\0\rdefaults\1\0\0\25file_ignore_patterns\1\4\0\0\f.git/.*\20node_modules/.*\n%.pyc\rmappings\1\0\1\20layout_strategy\rvertical\6i\1\0\0\n<C-k>\28move_selection_previous\n<C-j>\1\0\0\24move_selection_next\nsetup\14telescope\22telescope.actions\frequire,:Telescope lsp_document_diagnostics<CR>\15<Leader>od\29:Telescope help_tags<CR>\15<Leader>oh\27:Telescope buffers<CR>\15<Leader>ob\29:Telescope live_grep<CR>\15<Leader>og\30:Telescope find_files<CR>\15<Leader>of :Telescope file_browser<CR>\15<Leader>ot\6n\bmap\nutils\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd lualine.nvim ]]

-- Config for: lualine.nvim
try_loadstring("\27LJ\2\nË\3\0\0\a\0\25\0+6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\19\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0034\4\3\0005\5\f\0005\6\r\0=\6\14\5>\5\1\4=\4\15\0035\4\16\0005\5\17\0>\5\2\4=\4\18\3=\3\20\0025\3\21\0004\4\0\0=\4\5\0034\4\0\0=\4\a\0035\4\22\0=\4\t\0034\4\3\0005\5\23\0>\5\1\4=\4\v\0034\4\0\0=\4\15\0034\4\0\0=\4\18\3=\3\24\2B\0\2\1K\0\1\0\22inactive_sections\1\2\1\0\rlocation\ticon\bÓÇ°\1\2\0\0\rfilename\1\0\0\rsections\1\0\0\14lualine_z\1\2\1\0\rlocation\ticon\bÓÇ°\1\2\0\0\rprogress\14lualine_y\fsources\1\2\0\0\rnvim_lsp\1\2\0\0\16diagnostics\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\1\2\0\0\rfilename\14lualine_b\1\3\0\0\vbranch\22b:gitsigns_status\14lualine_a\1\0\0\1\2\0\0\tmode\nsetup\flualine\frequire\0", "config", "lualine.nvim")

time([[Sequenced loading]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
