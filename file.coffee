#fs = require 'fs'
#readline = require 'readline'
parser = require './lib/parser.coffee'
liner = require 'line-reader'
filename = null

for arg in process.argv
  if arg.match(/\.trip$/)
    filename = arg 
    break


unless filename?
  console.log "You must specify a .trip file!"
  process.exit(1)


commands = []

console.log "Scheduling your trip!\n"
i = 1
liner.eachLine filename, (line, last) ->
  console.log "\t#{i++}) #{line}"
console.log "\n"
liner.eachLine filename, (line) -> parser line



