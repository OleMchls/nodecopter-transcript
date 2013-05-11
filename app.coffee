fs = require 'fs'
readline = require 'readline'
praser = require './lib/parser.coffee'

rd = readline.createInterface {
    input: fs.createReadStream('example.trip')
    output: process.stdout
    terminal: false
}

rd.on 'line', (line) -> 
    praser line