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
        sources = {
          explorer = {
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
