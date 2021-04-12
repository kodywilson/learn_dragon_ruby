# test game while learning DragonRuby
def tick args
  defaults args
  render args, args.state.player
  calc args, args.state.player
  input args, args.state.player
end

def defaults args
  args.state.player.x ||= 0
  args.state.player.y ||= 0
  args.state.player.w ||= 15
  args.state.player.h ||= 15
  args.state.player.path ||= 'sprites/isometric/violet.png'
  args.state.player.speed ||= 1
  args.state.player.bullets ||= []
  args.state.player.bullet_size ||= 3
  args.state.player.bullet_speed ||= 1.5
  args.state.player.bullet_path ||= 'sprites/circle/violet.png'

  args.state.enemy_w ||= 15
  args.state.enemy_h ||= 15
  args.state.enemies ||= []
  args.state.enemy_bullets ||= []
  args.state.enemy_spawn_tick ||= 0
  args.state.enemy_bottom ||= args.grid.center.y
  args.state.enemy_bullet_size ||= 5
  args.state.enemy_bullet_speed ||= 1
  args.state.enemy_bullet_path ||= 'sprites/circle/red.png'
end

def render args, player
  args.outputs.sprites << [
    player.x,
    player.y,
    player.w,
    player.h,
    player.path,
  ]
  args.outputs.sprites << player.bullets
  args.outputs.sprites << args.state.enemies
  args.outputs.sprites << args.state.enemy_bullets
end

def calc args, player
  bound_player args, player
  update_player_bullets args, player
  spawn_enemies args
  update_enemies args

  args.state.enemy_bullets.each do | bullet |
    bullet.y -= args.state.enemy_bullet_speed
  end
end

def bound_player args, player
  player.x = player.x.greater(args.grid.left)
  player.x = player.x.lesser(args.grid.right - player.w)
  player.y = player.y.greater(args.grid.bottom)
  player.y = player.y.lesser(args.grid.top - player.h)
end

def update_player_bullets args, player
  player.bullets = player.bullets.select do |bullet|
    bullet.intersect_rect? args.grid
  end.each do |bullet|
    bullet.y += player.bullet_speed
  end
end

def spawn_enemies args
  if args.state.enemy_spawn_tick == args.state.tick_count
    if args.state.enemies.size < 3
      args.state.enemies << {
        x: args.grid.right.randomize(:ratio),
        y: args.grid.top - args.state.enemy_h,
        w: args.state.enemy_w,
        h: args.state.enemy_h,
        path: 'sprites/isometric/red.png',
        dx: args.state.enemy_bullet_speed
          .randomize(:sign),
        dy: -args.state.enemy_bullet_speed,
        bullet_spawn_tick: args.state.tick_count + 60,
      }
    end
    # Set the new time an enemy should spawn
    args.state.enemy_spawn_tick += (rand(4) + 1) * 60
  end
end

def update_enemies args
  args.state.enemies.each do | enemy |
    enemy[:x] += enemy[:dx]
    enemy[:y] += enemy[:dy]

    if enemy[:x] <= args.grid.left
      enemy[:x] = args.grid.left
      enemy[:dx] = 1
    end
    if enemy[:x] >= args.grid.right - enemy[:w]
      enemy[:x] = args.grid.right - enemy[:w]
      enemy[:dx] = -1
    end
    if enemy[:y] <= args.state.enemy_bottom
      enemy[:y] = args.state.enemy_bottom
      enemy[:dy] = 1
    end
    if enemy[:y] >= args.grid.top - enemy[:h]
      enemy[:y] = args.grid.top - enemy[:h]
      enemy[:dy] = -1
    end

    if enemy[:bullet_spawn_tick] == args.state.tick_count
      args.state.enemy_bullets << [
        # Centers the bullet on the center of the enemy
        enemy[:x] + enemy[:w] / 2 -
          args.state.enemy_bullet_size / 2,
        enemy[:y] + enemy[:h] / 2 -
          args.state.enemy_bullet_size / 2,
        args.state.enemy_bullet_size,
        args.state.enemy_bullet_size,
        args.state.enemy_bullet_path,
      ]
      enemy[:bullet_spawn_tick] += 60
    end
  end
end

def input args, player
  player.x += player.speed if args.inputs.keyboard.right
  player.x -= player.speed if args.inputs.keyboard.left
  player.y += player.speed if args.inputs.keyboard.up
  player.y -= player.speed if args.inputs.keyboard.down

  if args.inputs.keyboard.key_down.space
    player.bullets << [
      player.x + player.w / 2 - player.bullet_size / 2,
      player.y + player.h / 2 - player.bullet_size / 2,
      player.bullet_size,
      player.bullet_size,
      player.bullet_path,
    ]
  end
end