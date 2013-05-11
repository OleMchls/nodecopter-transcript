arDrone = require 'ar-drone'

client = arDrone.createClient()

# Returns any time directive in a line in milliseconds
getTime = (line) ->
  m = line.match /(\d+|\d+\.\d+)\s*(seconds|sec|s)/
  return null unless m?
  (parseFloat(m[1])*1000)|0

# Returns any speed directive in a line
getSpeed = (line) ->
  if (m = line.match /full[- \t]*speed/)
    return 1.0
  else if (m = line.match /half[- \t]*speed/)
    return 0.5
  else if (m = line.match /quarter[- \t]*speed/)
    return 0.25
  else if (m = line.match /(\d+\.\d+)[- \t]*speed/)
    return parseFloat(m[1])


# Map of client commands
command_map =
  'higher|up|raise': 'up'
  'lower|down': 'down'


module.exports = (line) ->
  if line.match /takeoff/
    #client.takeoff()

    console.log "client.takeoff()"
    return
  
  time = getTime(line)
  speed = getSpeed(line)
  
  for match, command of command_map
    if line.match(new RegExp(match))
      #console.log "client.after(#{time}, -> @stop(); @['#{command}'](#{speed}))"

      console.log "client['#{command}'](#{speed})"
      console.log "setTimeout (-> client.stop()), #{time}"


  #if line.match /(go)?(higher|up)/


  #console.log line