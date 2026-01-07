-- Formatter
return {
   "stevearc/conform.nvim",
   opts = {},
   event = "LspAttach",
   config = function()
      require("conform").setup({
         formatters_by_ft = {
            php = { "php_cs_fixer" },
            lua = { "stylua" },
            dart = { "dart_format" },
            rust = { "rustfmt" },
            java = { "google-java-format" },
            javascript = { "prettierd" },
            javascriptreact = { "prettierd" },
            typescrip = { "prettierd" },
            typescriptreact = { "prettierd" },
            yaml = { "prettierd" },
            vue = { "prettierd" },
            html = { "prettierd" },
            svelte = { "prettierd" },
            css = { "prettierd" },
            sh = { "beautysh" },
            markdown = { "prettierd" },
            cs = { "csharpier" },
            typst = { "prettypst" },
            sql = { "poor_mans_tsql" }
         },
         -- format_on_save = {
         -- 	lsp_format = "fallback",
         -- 	timeout_ms = 500,
         -- },
         formatters = {
            poor_mans_tsql = {
               command = "sqlformat",
               args = {
                  "-f", "$FILENAME",
                  "--no-expandCaseStatements",
                  "--inputEncoding",
                  -- "utf-8",
                  "utf-16le"
                  -- "--suppress-output-if-no-changes",
                  -- "--expand-comma-lists", "true", -- Example option
                  -- "--uppercase-keywords", "true", -- Example option
               },
            },
         },
      })
   end,
}
