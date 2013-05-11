commmand_queue = require 'queue.coffee'

# Make a command queue
queue = new command_queue()

# Copter command map
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

# Returns any copter command directive in a line
getCommand: (line) ->
  command = null
  for match, cmd of command_map
    if line.match(new RegExp(match))
      command = cmd
      break
  return command
  
# Processes a human readable line
module.exports = (line) ->
  if line.match /takeoff/
    return commmand_queue.push { command: 'takeoff', time: 5000 }
    
  time = getTime(line)
  speed = getSpeed(line)
  command = getCommand(line) 

  # Don't do anything unless we are able to parse a command
  return unless command?

  # Queue it
  queue.push { time: time, speed: speed, command: command }

