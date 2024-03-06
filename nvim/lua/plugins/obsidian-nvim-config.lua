require("obsidian").setup({
   workspaces = {
      {
        name = "personal",
        path = "~/NotesVaults/notes",
      },
      {
         name = "mainvault",
         path = "~/NotesVaults/mainVault"
      }
   },
   disable_frontmatter = false,
   note_frontmatter_func = function(note)
    -- Add the title of the note as an alias.
    if note.title then
      note:add_alias(note.title)
    end

    local date = os.date("%Y-%m-%d")

    local out = {
         -- id = note.id,
         date = date,
         tags = note.tags
    }

    -- `note.metadata` contains any manually added fields in the frontmatter.
    -- So here we just make sure those fields are kept in the frontmatter.
    if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
      for k, v in pairs(note.metadata) do
        out[k] = v
      end
    end
      return out
   end,
   mappings = {
      ["gd"] = {
         action = function()
           return require("obsidian").util.gf_passthrough()
         end,
         opts = { noremap = false, expr = true, buffer = true },
      },
      ["zt"] = {
         action = function()
           return require("obsidian").util.toggle_checkbox()
         end,
         opts = { buffer = true },
      },
   },
})
