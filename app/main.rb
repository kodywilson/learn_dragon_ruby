# test game while learning DragonRuby

def tick args
  if args.inputs.keyboard.key_down.space
    args.state.starting_tick = args.state.tick_count
  end

  number_of_sprites = 7
  number_of_frames_per_sprite = 6
  does_animation_loop = false
  sprite_index = args.state.starting_tick.frame_index(
                   number_of_sprites,
                   number_of_frames_per_sprite,
                   does_animation_loop
                 )
  sprite_index ||= 0
  args.outputs.sprites << {
    x: 50,
    y: 20,
    w: 50,
    h: 50,
    path: 'sprites/misc/explosion-sheet.png',
    tile_x: 0 + (sprite_index * 32),
    tile_y: 0,
    tile_w: 32,
    tile_h: 32,
  }

  args.outputs.labels << [80, 1.from_top,
                          "press space to animate",
                          -7.5,
                          1]
end