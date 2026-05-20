return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader><leader>",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
    },
    opts = {
      picker = {
        actions = {
          toggle_hidden_with_env = function(picker)
            picker.opts.hidden = not picker.opts.hidden
            picker.opts._env_include = picker.opts._env_include
              or { ".env", ".env.*", "*/.env", "*/.env.*" }

            local include = vim.deepcopy(picker.opts.include or {})
            include = vim.tbl_filter(function(pattern)
              return not vim.tbl_contains(picker.opts._env_include, pattern)
            end, include)

            if picker.opts.hidden then
              vim.list_extend(include, picker.opts._env_include)
            end

            picker.opts.include = include
            picker.list:set_target()
            picker:find()
          end,
        },
        sources = {
          explorer = {
            win = {
              list = {
                keys = {
                  ["H"] = "toggle_hidden_with_env",
                },
              },
            },
            layout = {
              layout = {
                position = "right",
              },
            },
          },
        },
      },
    },
  },
}
