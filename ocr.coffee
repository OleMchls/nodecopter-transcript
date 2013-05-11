parse = require './lib/parser.coffee'
nodecr = require 'nodecr'
arDrone = require 'ar-drone'
client = arDrone.createClient()

pngStream = client.createPngStream();
pngStream.on('data', console.log);

# Recognise text of any language in any format
###
nodecr.process(__dirname + '/path/to/image.jpg' , (err, text) ->
    if err
        console.error(err);
    else
        console.log(text);
###