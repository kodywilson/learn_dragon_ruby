# test game while learning DragonRuby
def tick args
  # destructure args into local variables  
  state, outputs, grid = args.state, args.outputs, args.grid  
  # set some default values for the game  
  state.colors.background ||= [0, 0, 0]  
  state.colors.star       ||= [128, 200, 255]  
  state.colors.text       ||= [200, 200, 200]  
  state.colors.landmarks  ||= [255, 255, 255]  
  state.night             ||= [grid.rect, state.colors.background]  
  state.stars             ||= 200.map do
    [rand * grid.w,
     rand * grid.h,
     rand * 2 + 2,
     rand * 2 + 2,
     state.colors.star]
  end
  # start up some background music
  outputs.sounds  << "opening_fx.wav" if state.tick_count == 0
  # render the background and stars
  outputs.solids  << state.night
  outputs.solids  << state.stars
  # set a title for the game
  outputs.labels  << [grid.left + 50, grid.top  - 50,
                       "Ninja Game", state.colors.text]
  # set a sprite
  outputs.sprites << [50, 50, 50, 50, 'ninja.png']
  # create a line that represents the ground
  outputs.lines   << [grid.left,
                      grid.bottom + 50,
                      grid.right,
                      grid.bottom + 50,
                      state.colors.landmarks]
  # create a border to frame the game
  outputs.borders << [grid.left + 1,
                      grid.bottom + 1,
                      grid.right - 1,
                      grid.top - 1,
                      state.colors.landmarks]
  
  state.ninja.x ||= 100
  outputs.sprites << [
    state.ninja.x, 300, 50, 50,
    'ninja.png'
  ]
  if args.inputs.keyboard.key_held.right
    args.state.ninja.x += 10
  elsif args.inputs.keyboard.key_held.left
    args.state.ninja.x -= 10
  end
  # args.outputs.labels  << [640, 500, 'This is really cool!', 5, 1]
  # args.outputs.sprites << [576, 280, 128, 101, 'dragonruby.png']
  # args.outputs.labels << [100, 100, args.state.tick_count]
  # # draw a blue square that's half way faded out
  # args.outputs.solids << [100, 100, 50, 50, 0, 0, 255, 128]
  # # draw a red label
  # args.outputs.labels << [100, 200, "This is a label.", 255, 0, 0]
  # # draw a sprite turned 45 degrees and half way faded out
  # args.outputs.sprites << [200, 200, 50, 50, 'ninja.png', 45, 128]
  # # draw a diagonal green line from bottom left to top right
  # args.outputs.lines << [0, 0, 1280, 720, 0, 255, 0]
  # # draw a black border (unfilled square)
  # args.outputs.borders << [100, 100, 50, 50, 0, 0, 0, 255]
  # # play a sound every second
  # args.outputs.sounds << "ping.wav" if args.state.tick_count % 60 == 0
end
