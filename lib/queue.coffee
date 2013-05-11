arDrone = require 'ar-drone'
client = arDrone.createClient()

class Queue

  queue = []

  isRunning = false

  push = (command) ->
    queue.push command
    this.run unless isRunning

  run = ->
    command = queue.shift()

module.exports = Queue