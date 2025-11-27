return {
  'iamkarasik/sonarqube.nvim',
  config = function()
    local extension_path = vim.fn.stdpath 'data' .. '/mason/packages/sonarlint-language-server/extension'
    require('sonarqube').setup {
      lsp = {
        cmd = {
          'java',
          '-jar',
          extension_path .. '/server/sonarlint-ls.jar',
          '-stdio',
          '-analyzers',
          extension_path .. '/analyzers/sonarhtml.jar',
          extension_path .. '/analyzers/sonarjava.jar',
          extension_path .. '/analyzers/sonarjs.jar',
          extension_path .. '/analyzers/sonartext.jar',
          extension_path .. '/analyzers/sonarxml.jar',
        },
      },
    }
  end,
}
