# test game while learning DragonRuby
def tick args
  # Some simple lines
  #                        X   Y  X2  Y2
  args.outputs.lines  << [ 0,  0, 50, 50]
  args.outputs.lines  << [50, 80, 80, 40]

  # Colorful blue line
  args.outputs.lines  << [
    20, # X
    40, # Y
    70, # X2
    90, # Y2
    35, # R
    72, # G
    254 # B
  ]
  # [x, y, x2, y2, [r, g, b]] also works
  # Can be used to alias RGB values
  args.outputs.lines << [
    30,      # X
    70,      # Y
    60,      # X2
    60,      # Y2
    lavender # RGB
  ]

  # The alpha parameter affects transparency
  # 255 is the max alpha and is fully opaque
  # [x, y, x2, y2, r, g, b, a] or
  # [x, y, x2, y2, [r, g, b, a]]
  args.outputs.lines << [
    20, 20, 140, 20,            # X Y X2 Y2
    28, 178, 54,                # R G B
    args.state.tick_count % 255 # A
  ]
end

def lavender
  # R    G    B
  [171, 127, 251]
end


