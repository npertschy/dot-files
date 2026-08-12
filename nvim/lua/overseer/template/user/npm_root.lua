local npm = require 'overseer.template.npm'

return {
  name = 'npm (root)',
  generator = function(opts, cb)
    local root = vim.fn.getcwd()
    local candidates = {}

    for _, path in ipairs { root .. '/package.json', root .. '/frontend/package.json' } do
      if vim.fn.filereadable(path) == 1 then
        table.insert(candidates, vim.fn.fnamemodify(path, ':h'))
      end
    end

    local tasks = {}
    local frontend_dir = ''
    for _, dir in ipairs(candidates) do
      local result = npm.generator(vim.tbl_extend('force', opts, { dir = dir }))
      if type(result) == 'table' then
        for _, t in ipairs(result) do
          t.components = { 'default' }
          table.insert(tasks, t)
        end

        if frontend_dir == '' then
          frontend_dir = dir
        end
      end
    end

    if #tasks > 0 then
      table.insert(tasks, {
        name = 'npm ci',
        builder = function()
          return {
            cmd = { 'npm', 'ci' },
            cwd = frontend_dir,
          }
        end,
      })
    end

    cb(tasks)
  end,
  condition = {
    callback = function()
      local root = vim.fn.getcwd()
      return vim.fn.filereadable(root .. '/package.json') == 1 or vim.fn.filereadable(root .. '/frontend/package.json') == 1
    end,
  },
}
