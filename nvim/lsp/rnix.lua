return {
  cmd = { 'rnix-lsp' },
  filetypes = { 'nix' },
  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, '.git') or vim.uv.os_homedir())
  end,
  settings = {},
  init_options = {},
}
