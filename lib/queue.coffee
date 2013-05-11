arDrone = require 'ar-drone'
client = arDrone.createClient()
sendCommands = !('--test' in process.argv)
showCommands = ('--verbose' in process.argv)

class Queue

  constructor: (@queue=[], @isRunning=false) ->
  
  push: (command) ->
    @queue.push command
    @run() unless @isRunning

  run: ->
    @isRunning = true
    c = @queue.shift()
    
    if c.command == 'quit'
      console.log 'Wooosh this was a trip!'
      console.log 'powerd by @rsandor and @codestars'
      process.exit 0
    else if m = c.command.match(/animate\s+(.*)/)
      console.log("client.animate('#{m[1]}')") if showCommands
      client.animate(m[1])
    else if m = c.command.match(/animateLeds\s+(.*)/)
      console.log("client.animateLeds('#{m[1]}')") if showCommands
      client.animateLeds(m[1])
    else if c.command == 'takeoff'
      console.log("client.takeoff()") if showCommands
      client.takeoff() if sendCommands
    else if c.command == 'land'
      console.log("client.land()") if showCommands
      client.land() if sendCommands
    else
      console.log("client[#{c.command}](#{c.speed})") if showCommands
      client[c.command](c.speed) if sendCommands

    console.log(c) if showCommands
    setTimeout (=> @finish(c)), (c.time or 5000)

  finish: (c) ->
    console.log("client.stop()") if showCommands
    client.stop() if sendCommands
    @isRunning = false
    @run() if @queue.length > 0


module.exports = Queue