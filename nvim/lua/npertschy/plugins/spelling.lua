return {
  'ravibrock/spellwarn.nvim',
  event = 'VeryLazy',
  config = true,
  opts = {
    severity = {
      spellbad = 'HINT',
      spellcap = 'HINT',
      spelllocal = 'HINT',
      spellrare = 'INFO',
    },
  },
}
