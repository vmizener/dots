-- See `:help dap.txt` for documentation on how nvim-dap functions
-- local dap = require("dap")
-- local utils = require("utils")

require('dap-python').setup(vim.g['python3_host_prog'])
require('dap-go').setup()

-- local bazel = require('bazel')
-- Get current buffer full filepath
-- vim.api.nvim_buf_get_name(0)


-- dap.adapters.bazel = {
--     type = "executable",
-- }
