return {
  name = 'Shell Scripts',
  desc = 'Alle Shell-Skripte im Projekt ausführen',

  -- Wird einmalig aufgerufen um alle Tasks zu generieren
  generator = function(opts, cb)
    local root = vim.fn.getcwd()

    -- Alle .sh-Dateien rekursiv finden (node_modules, .git etc. ausschließen)
    local scripts = vim.fn.systemlist(
      string.format("find %s -name '*.sh' -not -path '*/node_modules/*' -not -path '*/.git/*' -not -path '*/target/*'", vim.fn.shellescape(root))
    )

    local tasks = {}
    for _, script_path in ipairs(scripts) do
      -- Relativen Pfad für den Namen berechnen
      local rel_path = script_path:sub(#root + 2) -- "+2" wegen trailing slash

      table.insert(tasks, {
        name = 'sh: ' .. rel_path,
        builder = function()
          return {
            cmd = { 'bash', script_path },
            cwd = vim.fn.fnamemodify(script_path, ':h'), -- Skript-Verzeichnis als cwd
            components = {
              'default',
            },
          }
        end,
      })
    end

    cb(tasks)
  end,

  condition = {
    -- Nur anzeigen wenn mindestens ein .sh vorhanden ist
    callback = function(opts)
      local root = vim.fn.getcwd()
      local result = vim.fn.systemlist(string.format("find %s -maxdepth 4 -name '*.sh' -not -path '*/.git/*' -quit", vim.fn.shellescape(root)))
      return #result > 0
    end,
  },
}
