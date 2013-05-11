arDrone = require 'ar-drone'
client = arDrone.createClient()

sendCommands = true

class Queue

  constructor: (@queue=[], @isRunning=false) ->
  
  push: (command) ->
    @queue.push command
    @run() unless @isRunning

  run: ->
    @isRunning = true
    c = @queue.shift()
    
    if m = c.command.match(/animate\s+(.*)/)
      console.log "client.animate('#{m[1]}', #{c.time})"
      client.animate(m[1], 1500)#, c.time)
    else if c.command == 'takeoff'
      console.log "client.takeoff()"
      client.takeoff() if sendCommands
    else
      console.log "client[#{c.command}](#{c.speed})"
      client[c.command](c.speed) if sendCommands

    console.log c
    setTimeout (=> @finish(c)), (c.time or 5000)

  finish: (c) ->
    console.log "client.stop()"
    client.stop() if sendCommands
    @isRunning = false
    @run() if @queue.length > 0


module.exports = Queue