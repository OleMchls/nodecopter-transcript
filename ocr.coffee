parse = require './lib/parser.coffee'
nodecr = require 'nodecr'
arDrone = require 'ar-drone'
fs = require 'fs'
_ = require 'underscore'
easyimg = require 'easyimage'

client = arDrone.createClient()

parseFile = (path) ->
  nodecr.process path , (err, text) ->
    if err
      console.error err
    else
      console.log text

pngStream = client.createPngStream()
pngStream.on 'data', _.throttle((content) ->
  path = "/tmp/image.png"
  fs.writeFile path, content, (err) ->
    if err 
      console.log err 
    else
      convert path
      console.log "The file was saved!"
), 1000

convert = (path) ->
  easyimg.convert {src:path, dst:'/tmp/image.jpg', quality:10}, (err, stdout, stderr) ->
      console.log err if err
      console.log 'Converted PNG to JPG, quality set at 10/100'
      parseFile '/tmp/image.jpg'
  