nodecopter-transcript
=====================


I'd like to controll the drone like:

```
The drone should takeoff
Then go higher for 2 seconds with full-speed
Then do a flip
Then land
```

# Usage

You can do this via *.trip files. See trips directory for examples. Call it like

```
coffee file.coffee trips/flip.trip
```

Or you can do it in the repl mode.

```
coffee repl.coffee --test
> takeoff
> do a right-flip
> let the leds be green
> give up
> Wooosh this was a trip!
powerd by @rsandor and @codestars
```

# Options

```
--test    -> do not send the commands to the drone
--verbose -> show what commands will be send to the drone
```

# License

MIT
