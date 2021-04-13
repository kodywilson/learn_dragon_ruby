# test game while learning DragonRuby

def tick args
  args.state.rotation  ||= 0
  args.state.x ||= 620
  args.state.y ||= 250
  ticks = args.state.tick_count
  @start_tick ||= -60

  if args.inputs.mouse.click && ticks > 10 && @start_tick == -60
    @start_tick = ticks
    args.outputs.sounds << 'sounds/bass-loops-002-with-drums-short-loop.wav'
  end

  if @start_tick + 30 > ticks
    args.state.y += 3
    args.state.rotation  -= 5
  elsif
    @start_tick + 60 > ticks
    args.state.y -= 3
    args.state.rotation  -= 5
  else
    @start_tick = -60
    args.state.rotation = 0
  end
  #Mist_Covered_Mountains.mp3
  args.outputs.labels << [650, 350, "Jumping Cat! Click to hop!",
  -5, 1, 200, 050, 100, 255] if ticks < 600
  args.outputs.labels << [80, 60, ticks, -5, 0, 200, 050, 100, 125]
  args.state.cat_frame = ticks.idiv(4).mod(8)
  args.state.cat_path = "sprites/cat/Run-#{args.state.cat_frame}.png"
  args.outputs.sprites << [args.state.x, args.state.y,
  60, 50, args.state.cat_path, args.state.rotation]
end
