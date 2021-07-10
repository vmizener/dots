local gl = require('galaxyline')
local gls = gl.section

local colors = require('galaxyline.theme').default

local separators = {
    left_soft = '',
    left_hard = '',
    right_soft = '',
    right_hard = '',
}

require('galaxyline').section.left = {
    { ViMode = {
        icon = function()
            local icons = {
                n      = ' ',
                i      = ' ',
                c      = 'ﲵ ',
                V      = ' ',
                [''] = ' ',
                v      = ' ',
                C      = 'ﲵ ',
                R      = '﯒ ',
                t      = ' ',
            }
            return icons[vim.fn.mode()]
        end,
        provider = function()
            -- auto change color according the vim mode
            local alias = {
                n      = 'N',
                i      = 'I',
                c      = 'C',
                V      = 'VL',
                [''] = 'V',
                v      = 'V',
                C      = 'C',
                ['r?'] = ':CONFIRM',
                rm     = '--MORE',
                R      = 'R',
                Rv     = 'R&V',
                s      = 'S',
                S      = 'S',
                ['r']  = 'HIT-ENTER',
                [''] = 'SELECT',
                t      = 'T',
                ['!']  = 'SH',
            }
            local mode_color = {n = colors.yellow, i = colors.green,v=colors.blue,
                          [''] = colors.blue,V=colors.blue,
                          c = colors.magenta,no = colors.red,s = colors.orange,
                          S=colors.orange,[''] = colors.orange,
                          ic = colors.yellow,R = colors.violet,Rv = colors.violet,
                          cv = colors.red,ce=colors.red, r = colors.cyan,
                          rm = colors.cyan, ['r?'] = colors.cyan,
                          ['!']  = colors.red,t = colors.red}

            local vim_mode = vim.fn.mode()
            vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim_mode])
            return alias[vim_mode]
        end,
        highlight = {colors.line_bg, colors.line_bg},
    }},
    
	{FileIcon = {
		provider  = {space, 'FileIcon'},
		highlight = {_HEX_COLORS.bar.side, get_file_icon_color},
		separator = _SEPARATORS.left,
		separator_highlight = {_HEX_COLORS.bar.side, get_file_icon_color}
	}},

    { SSize = {
            provider = 'FileSize',
            condition = function()
              if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
                return true
              end
              return false
              end,
            icon = '   ',
            highlight = {colors.green,colors.purple},
            separator = separators['right_hard'],
            --separator_highlight = {colors.purple,colors.darkblue},
            separator_highlight = {nil, colors.darkblue},
    }}
}
