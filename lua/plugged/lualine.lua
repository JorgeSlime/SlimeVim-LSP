return {
    {
        'linrongbin16/lsp-progress.nvim',
        config = function()
          require('lsp-progress').setup()
        end
    },
    {
        -- Configuración para lualine.nvim
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons',opt=true },  -- Dependencia de nvim-web-devicons
        config = function()
            local function lspClient()
                local msg=""
                local buf_ft= vim.api.nvim_buf_get_option(0,"filetype")
                local clients= vim.lsp.get_active_clients()
                if next(clients)==nil then
                    return msg
                end
                for _,client in ipairs(clients) do
                    local filetypes =client.config.filetypes
                    if filetypes and vim.fn.index(filetypes,buf_ft)~=-1 then
                        return client.name
                    end
                end
                return msg
            end
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                    ignore_focus = {},
                    always_divide_middle = false,
                    globalstatus = false,
                  },
                  sections = {
                    lualine_a = {
                        {
                            "mode",
                            right_padding=2,
                            icon="",
                        },
                    },
                    lualine_b = {
                        { "diagnostics",source={"nvim_diagnostic"}},
                        {
                            "filename",
                            simbols={
                                unammed = "Empty Buffer",
                                newfile = "New File",
                            },
                        },
                        { "branch", icon=""},
                    },
                    lualine_c = {},
                    lualine_x = {
                        {
                            require("lazy.status").updates,
                            cond=require("lazy.status").has_updates,
                            color={fg="#ff9e64"},
                        },
                        --{
                        --    function()
                        --        return require('lsp-progress').progress()
                        --    end,
                        --},
                    },
                    lualine_y = {{lspClient,icon=""},"filetype","progress","searchcount"},
                    lualine_z = {{'location',left_padding=2,}}
                  },
                  inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                  },
                  tabline = {},
                  winbar = {},
                  inactive_winbar = {},
                  extensions = {}
                }
        end
    }
}

