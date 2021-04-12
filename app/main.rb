# test game while learning DragonRuby
def tick args
  args.outputs.labels  << [640, 500, 'This is really cool!', 5, 1]
  args.outputs.sprites << [576, 280, 128, 101, 'dragonruby.png']
  args.outputs.labels << [100, 100, args.state.tick_count]
  # draw a blue square that's half way faded out
  args.outputs.solids << [100, 100, 50, 50, 0, 0, 255, 128]
  # draw a red label
  args.outputs.labels << [100, 200, "This is a label.", 255, 0, 0]
end
