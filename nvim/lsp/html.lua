return {
   cmd = { 'vscode-html-language-server', '--stdio' },
   filetypes = {
      'html',
      'templ',
      "rust",
      'htmldjango',
      'cshtml',
      'razor'
   },
   root_markers = { 'package.json', '.git' },
   settings = {},
   init_options = {
      provideFormatter = true,
      embeddedLanguages = { css = true, javascript = true },
      configurationSection = { 'html', 'css', 'javascript' },
   },
}
