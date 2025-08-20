return {
   "yetone/avante.nvim",
   -- event = "VeryLazy",
   enabled = function ()
      local os_name = vim.loop.os_uname().sysname
      return os_name == "Linux"
   end,
   version = false, -- Never set this value to "*"! Never!
   keys = {
      "<leader>aa"
   },
   opts = {
      -- add any opts here
      -- for example
      provider = "gemini",
      providers = {
         gemini = {
            -- @see https://ai.google.dev/gemini-api/docs/models/gemini
            model = "gemini-2.0-flash", -- your desired model (or use gpt-4o, etc.)
            timeout = 30000, -- timeout in milliseconds
            temperature = 0, -- adjust if needed
            max_tokens = 4096,
         },
      },
   },
   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
   build = "make",
   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
   dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick",       -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua",            -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      -- "zbirenbaum/copilot.lua", -- for providers='copilot'
      'Kaiser-Yang/blink-cmp-avante',
      {
         -- support for image pasting
         "HakonHarnes/img-clip.nvim",
         -- event = "VeryLazy",
         opts = {
            -- recommended settings
            default = {
               embed_image_as_base64 = false,
               prompt_for_file_name = false,
               drag_and_drop = {
                  insert_mode = true,
               },
               -- required for Windows users
               use_absolute_path = true,
            },
         },
      },
      {
         -- Make sure to set this up properly if you have lazy=true
         'MeanderingProgrammer/render-markdown.nvim',
         opts = {
            file_types = {
               -- "markdown",
               "Avante",
            },
         },
         ft = {
            -- "markdown",
            "Avante",
         },
      },
   },
}
