# test game while learning DragonRuby

def tick args
  # The frame at which the animation should begin
  starting_tick = 0

  # The number of sprites in the animation
  number_of_sprites = 7

  # The number of frames for each sprite
  # of the animation
  number_of_frames_per_sprite = 6

  # Whether the animation should loop
  does_animation_loop = true

  # A function that calculates the current sprite index
  sprite_index = starting_tick.frame_index(
                   number_of_sprites,
                   number_of_frames_per_sprite,
                   does_animation_loop
                 )
  # Draws the animation
  args.outputs.sprites << [
    50,                                      # X
    20,                                      # Y
    50,                                      # W
    50,                                      # H
    "sprites/misc/explosion-#{sprite_index}.png", # PATH
  ]
end