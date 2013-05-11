arDrone = require 'ar-drone'

client = arDrone.createClient()

module.exports = (line) ->
  console.log line