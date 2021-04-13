# test game while learning DragonRuby

def tick args
  args.state.rotation  ||= 0
  args.state.x ||= 620
  args.state.y ||= 250
  ticks = args.state.tick_count

  if args.inputs.mouse.click
    @start_tick = ticks
  end

  if @start_tick + 30 > ticks
    args.state.y += 3
    args.state.rotation  -= 5
  elsif
    @start_tick + 60 > ticks
    args.state.y -= 3
    args.state.rotation  -= 5
  else
    @start_tick = 0
    args.state.rotation = 0
  end

  args.outputs.labels << [650, 350, "Jumping Cat! Click to hop!",
  -5, 1, 200, 050, 100, 255] if ticks < 600
  args.outputs.labels << [80, 60, ticks, -5, 0, 200, 050, 100, 125]
  args.state.cat_frame = ticks.idiv(4).mod(8)
  args.state.cat_path = "sprites/cat/Run-#{args.state.cat_frame}.png"
  args.outputs.sprites << [args.state.x, args.state.y,
  60, 50, args.state.cat_path, args.state.rotation]
end
