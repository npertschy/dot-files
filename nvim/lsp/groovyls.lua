return {

  cmd = { 'java', '-jar', vim.fn.stdpath 'data' .. '/mason/packages/groovy-language-server/build/libs/groovy-language-server-all.jar' },
  filetypes = { 'groovy' },
  root_markers = { '.git', 'Jenkinsfile' },
}
