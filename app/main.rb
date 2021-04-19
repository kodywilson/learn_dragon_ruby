# test game while learning DragonRuby

def tick args
  args.state.click_count ||= 0
  args.state.direction ||= 0
  args.state.rotation  ||= 0
  args.state.x ||= 620
  args.state.y ||= 250
  args.state.cat_x ||= 100
  args.state.cat_y ||= 100
  args.state.movement_speed ||= 5
  ticks = args.state.tick_count
  @start_tick ||= -60
  @cat_jump_counter ||= 0
  @bass_loop_counter ||= -1

  if ( args.state.click_count >= 3 || args.inputs.keyboard.key_held.space ) && @start_tick == -60
    @start_tick = ticks
    args.state.direction = 0 if args.state.rotation == 0
    args.state.direction = 180 if args.state.rotation == 180
    #args.state.cat_x += 50
    #args.state.cat_y += 50
    if @bass_loop_counter == -1
      args.outputs.sounds << 'sounds/bass-loops-002-with-drums-short-loop.wav'
      @bass_loop_counter = 1
    end
    args.state.click_count = 0
  end

  args.state.click_count += 1 if args.inputs.mouse.up

  if @bass_loop_counter > 0 && @bass_loop_counter <= 960
    @bass_loop_counter += 1
  else
    @bass_loop_counter = -1
  end

  if @start_tick + 30 > ticks
    args.state.y += 3
    #args.state.rotation  -= 6 # Use for flip effect
  elsif
    @start_tick + 60 > ticks
    args.state.y -= 3
    #args.state.rotation  -= 6 # Use for flip effect
  else
    @start_tick = -60
    #args.state.rotation = args.state.direction
  end

  # Move sprite around with keypress
  if args.inputs.keyboard.key_held.right# && @start_tick + 60 < ticks
    args.state.rotation = 0
    args.state.direction = args.state.rotation
    args.state.x += args.state.movement_speed #unless args.state.x > 1175 #create right bound
    args.state.x = -20 if args.state.x > 1200 # allow right wrap
  elsif args.inputs.keyboard.key_held.left# && @start_tick + 60 < ticks
    args.state.rotation = 180
    args.state.direction = args.state.rotation
    args.state.x -= args.state.movement_speed# if args.state.x > 0 # create left bounds
    args.state.x = 1200 if args.state.x < 20 # allow left wrap
  end
  
  # Label text as array
  args.outputs.labels << [670, 400, "Jumping Cat! Click to hop!",
  0, 1, 050, 050, 200, 255] if ticks < 600
  # Label text as hash - example
  # args.outputs.labels << {
  #   x: 670,
  #   y: 250,
  #   text: "Hello Kitty!",
  #   size_enum: -3,
  #   alignment_enum: 1,
  #   r: 200,
  #   g: 050,
  #   b: 200,
  #   a: 255,
  #   font: "fonts/manaspc.ttf"
  # }
  #args.outputs.borders << [0, 0, 1440, 720, 255, 255, 255, 255]
  args.outputs.solids << [0, 240, 1440, 10, 100, 200, 100, 255]
  args.outputs.solids << [0, 0, 1440, 240, 160, 82, 45, 255]
  args.outputs.labels << [80, 60, ticks, -5, 0, 200, 050, 100, 125]
  args.state.cat_frame = ticks.idiv(4).mod(8)
  #args.state.cat_path = "sprites/cat/Walk-#{args.state.cat_frame}.png"
  args.state.cat_path = "sprites/circle/blue.png"
  args.state.dog_path = "sprites/dog/Slide-#{args.state.cat_frame}.png"
  args.outputs.sprites << [args.state.x, args.state.y,
  args.state.cat_x, args.state.cat_y, args.state.cat_path, args.state.rotation]
  #args.outputs.sprites << [args.state.x, 500,
  #200, 200, args.state.dog_path, args.state.rotation]
end
