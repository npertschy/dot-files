return {
  url = 'https://gitlab.com/schrieveslaach/sonarlint.nvim',
  config = function()
    local data_dir = vim.fn.stdpath 'data'
    require('sonarlint').setup {
      server = {
        cmd = {
          'sonarlint-language-server.cmd',
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
        'ts',
        'vue',
      },
    }
  end,
}
