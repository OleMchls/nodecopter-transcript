#fs = require 'fs'
#readline = require 'readline'
parse = require './lib/parser.coffee'
liner = require 'line-reader'
filename = null

for arg in process.argv
  if arg.match(/\.trip$/)
    filename = arg 
    break


unless filename?
  console.log "You must specify a .trip file!"
  process.exit(1)


console.log "Scheduling your trip!\n"

[i, lines] = [1, []]

lineHelper = (line) ->
  console.log "    #{i++}) #{line}"
  lines.push line

liner.eachLine(filename, lineHelper).then ->
  parse(line) for line in lines 
  parse("quit")
  

#console.log lines
#liner.eachLine filename, (line) -> parser line





