# test game while learning DragonRuby
def tick args
  args.state.rotation  ||= 0
  args.state.x ||= 620
  args.state.y ||= 250

  if args.inputs.mouse.click
    args.state.x = args.inputs.mouse.click.point.x - 10
    args.state.y = args.inputs.mouse.click.point.y - 10
  end

  args.outputs.labels << [650, 350, "Hello World",
  -5, 1, 200, 050, 100, 255]
  ticks = args.state.tick_count
  args.outputs.labels << [80, 60, ticks, -5, 0, 200, 050, 100, 125]
  args.state.cat_frame = ticks.idiv(4).mod(8)
  args.state.cat_path = "sprites/cat/Run-#{args.state.cat_frame}.png"
  args.outputs.sprites << [args.state.x, args.state.y,
  60, 50, args.state.cat_path, args.state.rotation]
  args.state.rotation  -= 1
end