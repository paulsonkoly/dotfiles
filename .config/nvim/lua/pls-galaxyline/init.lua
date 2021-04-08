local gl = require('galaxyline')

local colors = {
  background = '#1e2132',
  foreground = '#9fa7bd',
  red = '#cc517a',
  maroon = '#70415e',
  green = '#668e3d',
  orange = '#c57339',
  blue = '#2d539e',
  purple = '#7759b4',
  cyan = '#3f83a6',
  ash = '#33374c',
  grey = '#8389a3'
}

local color_contexts = {
  background = colors.background,
  foreground = colors.foreground,
  normal_mode = colors.ash,
  insert_mode = colors.green,
  visual_mode = colors.blue,
  other_mode = colors.red
}

local condition = require('galaxyline.condition')
local gls = gl.section

gls.left[1] = {
    ViMode = {
        provider = function()
            -- auto change color according the vim mode
            local mode_color = {
                n = color_contexts.normal_mode,
                i = color_contexts.insert_mode,
                v = color_contexts.visual_mode,
                [''] = color_contexts.visual_mode,
                V = color_contexts.visual_mode,
                c = color_contexts.other_mode,
                no = color_contexts.other_mode,
                s = color_contexts.other_mode,
                S = color_contexts.other_mode,
                [''] = color_contexts.other_mode,
                ic = color_contexts.other_mode,
                R = color_contexts.other_mode,
                Rv = color_contexts.other_mode,
                cv = color_contexts.other_mode,
                ce = color_contexts.other_mode,
                r = color_contexts.other_mode,
                rm = color_contexts.other_mode,
                ['r?'] = color_contexts.other_mode,
                ['!'] = color_contexts.other_mode,
                t = colors.blue
            }
            vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color[vim.fn.mode()])
            return '▊ '
        end,
        highlight = { colors.red, colors.background }
    }
}

gls.left[2] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = condition.check_git_workspace,
        separator = ' ',
        separator_highlight = { 'NONE', colors.background },
        highlight = { colors.foreground, colors.background }
    }
}

gls.left[3] = {
    ShowLspClient = {
        provider = 'GetLspClient',
        condition = function()
            local tbl = {['dashboard'] = true, [' '] = true}
            if tbl[vim.bo.filetype] then return false end
            return true
        end,
        icon = '  ',
        highlight = { colors.purple, colors.background }
    }
}

gls.right[1] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = condition.hide_in_width,
        icon = ' ',
        highlight = { colors.green, colors.background }
    }
}
gls.right[2] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = condition.hide_in_width,
        icon = '柳',
        highlight = { colors.blue, colors.background }
    }
}
gls.right[3] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = condition.hide_in_width,
        icon = ' ',
        highlight = { colors.maroon, colors.background }
    }
}

gls.right[4] = {
  DiagnosticError = { provider = 'DiagnosticError', icon = '  ', highlight = { colors.red, colors.background } }
}
gls.right[5] = {
  DiagnosticWarn = { provider = 'DiagnosticWarn', icon = '  ', highlight = { colors.orange, colors.background } }
}
gls.right[6] = {
  DiagnosticHint = { provider = 'DiagnosticHint', icon = '  ', highlight = { colors.blue, colors.background } }
}
gls.right[7] = {
  DiagnosticInfo = { provider = 'DiagnosticInfo', icon = '  ', highlight = { colors.blue, colors.background } }
}
