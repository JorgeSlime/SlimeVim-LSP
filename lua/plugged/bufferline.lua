vim.opt.termguicolors = true
--https://github.com/romgrk/barbar.nvim
return{
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
        -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
        animation = true,
        --insert_at_start = true, -- insertar en buffer abierto al princio
        buffer_number = true,
        --diagnostics = {
            --[vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
        --    [vim.diagnostic.severity.WARN] = {enabled = false},
        --    [vim.diagnostic.severity.INFO] = {enabled = false},
        --    [vim.diagnostic.severity.HINT] = {enabled = true},
        --},
    },
    version = '^1.x', -- optional: only update when a new 1.x version is released
}

--return {
--	'akinsho/bufferline.nvim',
--	dependencies = {
--		'famiu/bufdelete.nvim'
--	},
--	opts = {
--  		options = {
--    		numbers = "ordinal",
--    		indicator = {
--        		style = 'underline'
--    		},
--            hover = {
--                enabled = true,
--                --delay = 300,
--                reveal = {'close'}
--            },
--            underline=true,
--    		buffer_close_icon = '',
--    		modified_icon = '●',
--    		close_icon = '',
--    		left_trunc_marker = '',
--    		right_trunc_marker = '',
--    		diagnostics = "nvim_lsp",  --"coc"
--    		diagnostics_indicator = function(count, level, diagnostics_dict, context)
--      			return "("..count..")"
--    		end,
--    		show_buffer_icons = true,
--    		show_buffer_close_icons = true,
--    		show_close_icon = true,
--    		show_tab_indicators = true,
--    		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
--    		enforce_regular_tabs = false,
--    		--always_show_bufferline = true,
--    		separator_style = "thin" 
--  		}
--	}
--}

