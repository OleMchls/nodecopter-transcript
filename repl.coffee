readline = require 'readline'
parser = require './lib/parser.coffee'
rl = readline.createInterface process.stdin, process.stdout

# ✈ 🚀

rl.setPrompt '> '
rl.prompt()

rl.on 'line', (line) ->
  parser line 	
  rl.prompt()

rl.on 'close', ->
  console.log 'Wooosh this was a trip!'
  console.log 'powerd by @rsandor and @codestars'
  process.exit 0