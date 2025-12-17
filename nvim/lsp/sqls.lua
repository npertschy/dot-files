return {
  cmd = { 'sqls' },
  filetypes = { 'sql' },
  settings = {
    sqls = {
      connections = {
        {
          driver = 'postgresql',
          dataSourceName = 'host=localhost port=5432 user=postgres password=admin dbname=db',
        },
      },
    },
  },
}
