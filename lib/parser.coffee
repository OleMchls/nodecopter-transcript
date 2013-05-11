commmand_queue = require 'queue.coffee'

# Returns any time directive in a line in milliseconds
getTime = (line) ->
  m = line.match /(\d+|\d+\.\d+)\s*(seconds|sec|s)/
  return 5000 unless m?
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
  return 0.1


# Map of client commands
command_map =
  'stop': 'stop'
  'higher|up|raise': 'up'
  'lower|down': 'down'
  'land|give up|settle down|simmer down': 'land'
  '(move\s+)?left': 'left'
  '(move\s+)?right': 'right'
  'turn (left|counterclockwise)': 'counterclockwise'
  'turn (right|clockwise)': 'clockwise'
  'forward|front': 'front'
  'backward|back': 'back'

queue = new command_queue();  

module.exports = (line) ->
  if line.match /takeoff/
    return commmand_queue.push { command: 'takeoff', time: 5000 }
    
  time = getTime(line)
  speed = getSpeed(line)
  command = ''

  for match, cmd of command_map
    if line.match(new RegExp(match))
      command = cmd
      break

  # Queue it
  queue.push { time: time, speed: speed, command: command }

  #console.log "client.after(#{time}, -> @stop(); @['#{command}'](#{speed}))"

  #console.log "client['#{command}'](#{speed})"
  #console.log "setTimeout (-> client.stop()), #{time}"


  #if line.match /(go)?(higher|up)/

>>>>>>> Stashed changes

