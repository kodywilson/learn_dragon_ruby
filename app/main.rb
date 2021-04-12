# test game while learning DragonRuby
def tick args
  defaults args
  render args
  input args
  calc args
end

# NOTE: the size and speed of the box is set to lower values for running within
#       DragonRuby's Online Sandbox. Change these values to 50, and 1 if you are
#       want to run the game locally with the full blown engine. You can purchase
#       a license to the engine at dragonruby.org. If you bought Itch.io's Bundle
#       for Racial Justice, you already have a license :-)
def defaults args
  args.state.colors       = [:red, :orange, :green, :blue, :indigo, :violet]
  args.state.box.size     = 50
  args.state.box.speed    = 5
  args.state.box.x      ||= args.grid.w.half - args.state.box.size.half
  args.state.box.y      ||= args.grid.h.half - args.state.box.size.half
  args.state.box.dx     ||= [1, -1].sample
  args.state.box.dy     ||= [1, -1].sample
  args.state.box.status ||= :moving
  set_box_color args    if !args.state.box.color
end

def render args
  args.outputs.sprites << [
    args.state.box.x,
    args.state.box.y,
    args.state.box.size,
    args.state.box.size,
    "sprites/square/#{args.state.box.color}.png"
  ]
end

def input args
  return unless args.inputs.keyboard.key_down.space
  if args.state.box.status == :moving
    args.state.box.status = :stopped
  else
    args.state.box.status = :moving
  end
end

def calc args
  return unless args.state.box.status == :moving

  args.state.box.x += args.state.box.dx * args.state.box.speed
  args.state.box.y += args.state.box.dy * args.state.box.speed

  if (args.state.box.x + args.state.box.size) > args.grid.w
    args.state.box.x  = args.grid.w - args.state.box.size
    args.state.box.dx = -1
    set_box_color args
  elsif args.state.box.x < 0
    args.state.box.x  = 0
    args.state.box.dx = 1
    set_box_color args
  end

  if (args.state.box.y + args.state.box.size) > args.grid.h
    args.state.box.y  = args.grid.h - args.state.box.size
    args.state.box.dy = -1
    set_box_color args
  elsif args.state.box.y < 0
    args.state.box.y  = 0
    args.state.box.dy = 1
    set_box_color args
  end
end

def set_box_color args
  args.state.box.color = (args.state.colors - [args.state.box.color]).sample
end