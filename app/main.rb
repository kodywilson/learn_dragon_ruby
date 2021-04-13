# test game while learning DragonRuby
def tick args
  args.outputs.labels << [650, 350, "Hello World",
  -5, 1, 200, 050, 100, 255]
  ticks = args.state.tick_count
  args.outputs.labels << [80, 60, ticks, -5, 0, 200, 050, 100, 125]
  args.state.cat_frame = ticks.idiv(4).mod(8)
  args.state.cat_path = "sprites/cat/Run-#{args.state.cat_frame}.png"
  args.outputs.sprites << [620, 250, 60, 50, args.state.cat_path]
end