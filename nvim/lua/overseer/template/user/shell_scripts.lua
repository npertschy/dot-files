local files = require 'overseer.files'

local function find_repo_root(start_dir)
  -- Find nearest .git upward and take its parent dir as repo root
  local git_dir = vim.fs.find('.git', { path = start_dir, upward = true })[1]
  if git_dir then
    return vim.fs.dirname(git_dir)
  end
  -- Fallback: current working directory if no .git found
  return vim.fn.getcwd()
end

local function normalize(p)
  return vim.fs.normalize(p)
end

local function is_descendant(path, root)
  path, root = normalize(path), normalize(root)
  -- Ensure root has trailing separator semantics
  if not root:match '/$' then
    root = root .. '/'
  end
  return path:sub(1, #root) == root
end

---@type overseer.TemplateFileProvider
return {
  generator = function(opts)
    local repo_root = find_repo_root(opts.dir)
    local backend_root = vim.fs.joinpath(repo_root, 'backend')

    -- Only offer these templates when we are *in* backend/*
    if not is_descendant(opts.dir, backend_root) then
      return {}
    end

    -- Choose where scripts live:
    --  - if you keep them directly under backend/, scan backend_root
    --  - if you keep them under backend/scripts/, scan that if it exists
    local scripts_dir = vim.fs.joinpath(backend_root, 'scripts')
    if vim.uv and vim.uv.fs_stat and vim.uv.fs_stat(scripts_dir) then
      -- scripts/ exists
    else
      scripts_dir = backend_root
    end

    local scripts = vim.tbl_filter(function(filename)
      return filename:match '%.sh$'
    end, files.list_files(scripts_dir))

    local ret = {}
    for _, filename in ipairs(scripts) do
      table.insert(ret, {
        name = 'backend: ' .. filename,
        builder = function()
          return {
            cmd = { vim.fs.joinpath(scripts_dir, filename) },
            cwd = backend_root, -- run from backend root (usually what you want)
            components = { 'default' },
          }
        end,
      })
    end

    return ret
  end,
}
