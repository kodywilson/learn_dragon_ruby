# test game while learning DragonRuby
def tick args
  defaults args
  render args
  calc args
end

def calc args
  args.state.stars.each do |star|
    star[:x] += star[:angle].vector_x * star[:s]
    star[:y] += star[:angle].vector_y * star[:s]

    # track the distance the star has moved
    star[:d] += star[:s]
    # increase the speed of the star by 20%
    star[:s] *= 1.2

    # change to width and height of the
    # star to grow as the distance increases
    # as if it's moving towards you
    star[:w] = 1 + 15 * star[:d].fdiv(100)
    star[:h] = 1 + 15 * star[:d].fdiv(100)
    star[:x] += star[:angle].vector_x *
                star[:w].fdiv(2)
    star[:y] += star[:angle].vector_y *
                star[:h].fdiv(2)
  end

  args.state.stars.find_all do |star|
    !star.intersect_rect? args.grid.rect
  end.each do |star|
    # reset stars, but initialize
    # them with a new random speed
    star[:x] = star[:initial_x]
    star[:y] = star[:initial_y]
    star[:s] = 0.1 * rand
    star[:d] = 0
    star[:w] = 1
    star[:h] = 1
  end
end

def render args
  args.outputs.background_color = [0, 0, 0]
  args.outputs.solids << args.state.stars
end

def defaults args
  args.grid.origin_center!
  args.state.warp_tunnel_size = 10;
  args.state.stars ||= 100.map do |i|
    rand(360)
  end.map do |random_angle|
    { initial_x: random_angle.vector_x *
                 args.state.warp_tunnel_size,
      initial_y: random_angle.vector_y *
                 args.state.warp_tunnel_size,
          angle: random_angle,
              r: 128,
              g: rand(128) + 128,
              b: rand(128) + 128 }
  end.map do |star|
    star.merge x: star[:initial_x],
               y: star[:initial_y],
               w: 1, h: 1,
               # make the speed a very small
               # random number
               s: 0.1 * rand,
               # initialize a property
               # to keep track of distance
               # traveled
               d: 0
  end
end