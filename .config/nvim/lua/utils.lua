local M = {}

-- Logging
function M._echo_multiline(msg)
  for _, s in ipairs(vim.fn.split(msg, "\n")) do
    vim.cmd("echom '" .. s:gsub("'", "''").."'")
  end
end

function M.info(msg)
  vim.cmd('echohl Directory')
  M._echo_multiline(msg)
  vim.cmd('echohl None')
end

function M.warn(msg)
  vim.cmd('echohl WarningMsg')
  M._echo_multiline(msg)
  vim.cmd('echohl None')
end

function M.err(msg)
  vim.cmd('echohl ErrorMsg')
  M._echo_multiline(msg)
  vim.cmd('echohl None')
end

-- Apply global options
function M.apply_options(opts)
  for k, v in pairs(opts) do vim.opt[k] = v end
end

function M.apply_globals(globals)
  for k, v in pairs(globals) do vim.g[k] = v end
end

function M.apply_colorscheme(name, mode)
  M.apply_options({
    termguicolors = true,
    guicursor = 'n-v-c-sm:block,i-ci-ve:ver50-Cursor,r-cr-o:hor50',
    background = mode
  })

  M.apply_globals({
    colors_name = name
  })

  vim.api.nvim_command('colorscheme ' .. name)
end

-- Map keys
function M.map(mode, key, fn, opts)
  vim.api.nvim_set_keymap(mode, key, fn, opts or {})
end

-- Buffer local keymap
function M.buf_map(...)
  vim.api.nvim_buf_set_keymap(0, ...)
end

-- Buffer local option
function M.buf_option(...)
  vim.api.nvim_buf_set_option(0, ...)
end

-- Check whether the current buffer is empty
function M.is_buffer_empty()
  return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

-- Check if the windows width is greater than a given number of columns
function M.has_width_gt(cols)
  return vim.fn.winwidth(0) / 2 > cols
end

-- Sudo commands
function M.sudo_exec(cmd, print_output)
  vim.fn.inputsave()
  local password = vim.fn.inputsecret("Password: ")
  vim.fn.inputrestore()
  if not password or #password == 0 then
      M.warn("Invalid password, sudo aborted")
      return false
  end
  local out = vim.fn.system(string.format("sudo -p '' -S %s", cmd), password)
  if vim.v.shell_error ~= 0 then
    print("\r\n")
    M.err(out)
    return false
  end
  if print_output then print("\r\n", out) end
  return true
end

function M.sudo_write(tmpfile, filepath)
  if not tmpfile then tmpfile = vim.fn.tempname() end
  if not filepath then filepath = vim.fn.expand("%") end
  if not filepath or #filepath == 0 then
    M.err("E32: No file name")
    return
  end
  -- `bs=1048576` is equivalent to `bs=1M` for GNU dd or `bs=1m` for BSD dd
  -- Both `bs=1M` and `bs=1m` are non-POSIX
  local cmd = string.format(
    "dd if=%s of=%s bs=1048576",
    vim.fn.shellescape(tmpfile),
    vim.fn.shellescape(filepath)
  )
  -- no need to check error as this fails the entire function
  vim.api.nvim_exec(string.format("write! %s", tmpfile), true)
  if M.sudo_exec(cmd) then
    M.info(string.format('\r\n"%s" written', filepath))
    vim.cmd("e!")
  end
  vim.fn.delete(tmpfile)
end

return M
