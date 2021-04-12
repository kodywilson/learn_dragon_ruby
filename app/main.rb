# test game while learning DragonRuby
def tick args
  args.outputs.labels  << [640, 500, 'This is really cool!', 5, 1]
  args.outputs.sprites << [576, 280, 128, 101, 'dragonruby.png']
end
