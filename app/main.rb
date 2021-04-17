# test game while learning DragonRuby

def tick args
  args.state.rotation  ||= 0
  args.state.x ||= 620
  args.state.y ||= 250
  args.state.cat_x ||= 200
  args.state.cat_y ||= 200
  ticks = args.state.tick_count
  @start_tick ||= -60
  @cat_jump_counter ||= 0
  @bass_loop_counter ||= -1

  if args.inputs.mouse.click && ticks > 10 && @start_tick == -60
    @start_tick = ticks
    args.state.cat_x += 50
    args.state.cat_y += 50
    if @bass_loop_counter == -1
      args.outputs.sounds << 'sounds/bass-loops-002-with-drums-short-loop.wav'
      @bass_loop_counter = 1
    end
  end

  if @bass_loop_counter > 0 && @bass_loop_counter <= 960
    @bass_loop_counter += 1
  else
    @bass_loop_counter = -1
  end

  args.state.x += 0

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
  # Label text as array
  args.outputs.labels << [670, 400, "Jumping Cat! Click to hop!",
  0, 1, 050, 050, 200, 255] if ticks < 600
  # Label text as hash
  args.outputs.labels << {
    x: 670,
    y: 250,
    text: "Hello Kitty!",
    size_enum: -3,
    alignment_enum: 1,
    r: 200,
    g: 050,
    b: 200,
    a: 255,
    font: "fonts/manaspc.ttf"
  }
  args.outputs.labels << [80, 60, ticks, -5, 0, 200, 050, 100, 125]
  args.state.cat_frame = ticks.idiv(4).mod(8)
  args.state.cat_path = "sprites/cat/Walk-#{args.state.cat_frame}.png"
  args.state.dog_path = "sprites/dog/Slide-#{args.state.cat_frame}.png"
  args.outputs.sprites << [args.state.x, args.state.y,
  args.state.cat_x, args.state.cat_y, args.state.cat_path, args.state.rotation]
  #args.outputs.sprites << [args.state.x, 500,
  #200, 200, args.state.dog_path, args.state.rotation]
end
