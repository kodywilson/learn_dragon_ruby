# test game while learning DragonRuby

def tick args
  args.state.click_count ||= 0
  args.state.rotation  ||= 0
  args.state.x ||= 620
  args.state.y ||= 250
  args.state.cat_x ||= 100
  args.state.cat_y ||= 100
  ticks = args.state.tick_count
  @start_tick ||= -60
  @cat_jump_counter ||= 0
  @bass_loop_counter ||= -1

  if ( args.state.click_count >= 3 || args.inputs.keyboard.key_held.space ) && @start_tick == -60
    @start_tick = ticks
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
    args.state.rotation  -= 5
  elsif
    @start_tick + 60 > ticks
    args.state.y -= 3
    args.state.rotation  -= 5
  else
    @start_tick = -60
    args.state.rotation = 0
  end

  # Move sprite around with keypress
  if args.inputs.keyboard.key_held.right
    args.state.x += 5 unless args.state.x > 1175
  elsif args.inputs.keyboard.key_held.left
    args.state.x -= 5 if args.state.x > 0
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
  args.outputs.labels << [80, 60, ticks, -5, 0, 200, 050, 100, 125]
  args.state.cat_frame = ticks.idiv(4).mod(8)
  #args.state.cat_path = "sprites/cat/Walk-#{args.state.cat_frame}.png"
  args.state.cat_path = "sprites/hexagon/blue.png"
  args.state.dog_path = "sprites/dog/Slide-#{args.state.cat_frame}.png"
  args.outputs.sprites << [args.state.x, args.state.y,
  args.state.cat_x, args.state.cat_y, args.state.cat_path, args.state.rotation]
  #args.outputs.sprites << [args.state.x, 500,
  #200, 200, args.state.dog_path, args.state.rotation]
end
