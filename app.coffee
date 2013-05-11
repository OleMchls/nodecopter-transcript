fs = require 'fs'
readline = require 'readline'

rd = readline.createInterface {
    input: fs.createReadStream('example.trip')
    output: process.stdout
    terminal: false
}

rd.on 'line', (line) -> 
    console.log line