return {
  url = 'https://gitlab.com/schrieveslaach/sonarlint.nvim',
  config = function()
    local data_dir = vim.fn.stdpath 'data'
    local command
    if vim.fn.has 'win32' == 1 then
      command = 'sonarlint-language-server.cmd'
    else
      command = 'sonarlint-language-server'
    end
    require('sonarlint').setup {
      server = {
        cmd = {
          command,
          '-stdio',
          '-analyzers',
          vim.fn.expand(data_dir .. '/mason/share/sonarlint-analyzers/sonarhtml.jar'),
          vim.fn.expand(data_dir .. '/mason/share/sonarlint-analyzers/sonarjava.jar'),
          vim.fn.expand(data_dir .. '/mason/share/sonarlint-analyzers/sonarjs.jar'),
          vim.fn.expand(data_dir .. '/mason/share/sonarlint-analyzers/sonartext.jar'),
          vim.fn.expand(data_dir .. '/mason/share/sonarlint-analyzers/sonarxml.jar'),
        },
      },
      filetypes = {
        'java',
        'gradle',
        'js',
        'jsx',
        'ts',
        'tsx',
        'vue',
        'md',
      },
    }
  end,
}
