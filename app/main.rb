# test game while learning DragonRuby
def tick args
# A simple border
  #                        X   Y   W   H
  args.outputs.borders << [20, 20, 70, 50]

  # A colorful border
  args.outputs.borders << [
    60,      # X
    30,      # Y
    70,      # W
    50,      # H
    lavender # RGB
  ]

  # A colorful fading border
  args.outputs.borders << [
    50,                  # X
    10,                  # Y
    50,                  # W
    40,                  # H
    fading_crimson(args) # RGBA
  ]

  # A simple solid
  #                        X   Y   W   H
  args.outputs.solids << [100, 100, 70, 50]

  # A colorful solid
  args.outputs.solids << [
    200,      # X
    200,      # Y
    70,      # W
    50,      # H
    lavender # RGB
  ]

  # A colorful fading solid
  args.outputs.solids << [
    300,                  # X
    300,                  # Y
    50,                  # W
    40,                  # H
    fading_crimson(args) # RGBA
  ]

  # A simple label
  #                        X   Y   TEXT
  args.outputs.labels << [5, 85, 'Simple']

  # A small label
  #                        X   Y   TEXT   SIZE
  args.outputs.labels << [5, 65, 'Small', -7]

  # A big label
  #                        X   Y   TEXT  SIZE
  args.outputs.labels << [5, 55, 'Big',   7]

  # A left-aligned label
  args.outputs.labels << [
    args.grid.left.shift_right(5), # X
    args.grid.bottom.shift_up(10), # Y
    'Left',                        # TEXT
    -6,                            # SIZE
    0                              # ALIGN
  ]

  # A center-aligned label
  args.outputs.labels << [
    args.grid.center.x,            # X
    args.grid.bottom.shift_up(10), # Y
    'Center',                      # TEXT
    -6,                            # SIZE
    1                              # ALIGN
  ]

  # A right-aligned label
  args.outputs.labels << [
    args.grid.right.shift_left(5), # X
    args.grid.bottom.shift_up(10), # Y
    'Right',                       # TEXT
    -6,                            # SIZE
    2                              # ALIGN
  ]

  # A colorful label
  args.outputs.labels << [
    args.grid.center.x.shift_right(10), # X
    args.grid.center.y.shift_up(10),    # Y
    'Color',                            # TEXT
    -3,                                 # SIZE
    0,                                  # ALIGN
    lavender                            # RGB
  ]

  # A fading label
  args.outputs.labels << [
    args.grid.center.x.shift_right(10), # X
    args.grid.center.y.shift_down(10),  # Y
    'Fade',                             # TEXT
    -3,                                 # SIZE
    0,                                  # ALIGN
    fading_crimson(args)                # RGBA
  ]

  # A simple sprite
  args.outputs.sprites << [
    400,                            # X
    25,                            # Y
    40,                            # W
    40,                            # H
    'sprites/isometric-violet.png' # PATH
  ]

  # A rotating sprite
  args.outputs.sprites << [
    500,                          # X
    25,                          # Y
    40,                          # W
    40,                          # H
    'sprites/circle-blue.png',   # PATH
    args.state.tick_count        # ANGLE
  ]

  # A fading sprite
  args.outputs.sprites << [
    600,                                # X
    25,                                 # Y
    40,                                 # W
    40,                                 # H
    'sprites/hexagon-orange.png',       # PATH
    0,                                  # ANGLE
    255 - args.state.tick_count % 255   # ALPHA
  ]
end

def lavender
  [171, 127, 251]
end

def fading_crimson args
  [175, 40, 91,
    255 - args.state.tick_count % 255]
end