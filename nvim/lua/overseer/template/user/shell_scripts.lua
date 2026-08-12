local excluded_dirs = {
  node_modules = true,
  ['.git'] = true,
  target = true,
}

---@param dir string
---@param scripts string[]
local function scan(dir, scripts)
  local ok, entries = pcall(vim.fs.dir, dir)
  if not ok then
    return
  end
  for name, type in entries do
    if type == 'directory' then
      if not excluded_dirs[name] then
        scan(vim.fs.joinpath(dir, name), scripts)
      end
    elseif type == 'file' and name:match '%.sh$' then
      table.insert(scripts, vim.fs.joinpath(dir, name))
    end
  end
end

local function find_sh_scripts(root)
  local scripts = {}
  scan(root, scripts)
  return scripts
end

return {
  name = 'Shell Scripts',
  desc = 'Alle Shell-Skripte im Projekt ausführen',

  generator = function(opts, cb)
    local root = vim.fn.getcwd()
    local scripts = find_sh_scripts(root)

    local tasks = {}
    for _, script_path in ipairs(scripts) do
      local rel_path = script_path:sub(#root + 2)

      table.insert(tasks, {
        name = 'sh: ' .. rel_path,
        builder = function()
          return {
            cmd = { 'bash', script_path },
            cwd = vim.fn.fnamemodify(script_path, ':h'),
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
    callback = function()
      local root = vim.fn.getcwd()
      return #find_sh_scripts(root) > 0
    end,
  },
}

