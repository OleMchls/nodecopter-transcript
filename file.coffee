fs = require 'fs'
readline = require 'readline'
parser = require './lib/parser.coffee'

rd = readline.createInterface {
    input: fs.createReadStream(process.argv[2])
    output: process.stdout
    terminal: false
}

rd.on 'line', (line) -> 
    parser line

rd.on 'close', ->
    process.exit()