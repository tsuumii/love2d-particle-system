particleVfx = require("modules.particleVfx")
debugModule = require("modules.debug")

key = particleVfx.key
colorKey = particleVfx.colorKey

function makeSettings()
    return {
        count = 1,
        rate = 0, enabled = false,
        spawn_x = 400, spawn_y = 300, spawn_spread_x = 0, spawn_spread_y = 0,
        direction = -math.pi / 2, spread_angle = 0,
        min_speed = 0, max_speed = 0,
        acceleration_x = 0, acceleration_y = 0, drag = 0,
        min_life = 2.5, max_life = 2.5,
        min_rotation = 0, max_rotation = 0,
        min_rotation_speed = 0, max_rotation_speed = 0,
        size = { key(0, 0.3), key(1, 0.3) },
        transparency = { key(0, 0), key(1, 1) },
        squash = { key(0, 0), key(1, 0) },
        color = { colorKey(0, 1, 1, 1), colorKey(1, 1, 1, 1) }
    }
end

function love.load()
    -- added post debug.lua
    debugModule.setupDebug()

    particleVfx.load()

    -- CASTING

    glyph_settings = makeSettings()
    glyph_settings.min_life = 1.6
    glyph_settings.max_life = 1.6
    glyph_settings.min_rotation_speed = 0.6
    glyph_settings.max_rotation_speed = 0.6
    glyph_settings.size = { key(0, 0.9), key(0.12, 0.38), key(0.8, 0.38), key(1, 0.55) }
    glyph_settings.transparency = { key(0, 1), key(0.12, 0), key(0.8, 0), key(1, 1) }
    glyph_settings.color = { colorKey(0, 0.62, 0.5, 1), colorKey(0.8, 0.62, 0.5, 1), colorKey(1, 1, 0.85, 1) }

    outline_settings = makeSettings()
    outline_settings.min_life = 1.6
    outline_settings.max_life = 1.6
    outline_settings.min_rotation_speed = -1
    outline_settings.max_rotation_speed = -1
    outline_settings.size = { key(0, 0.2), key(0.15, 0.42), key(0.8, 0.42), key(1, 0.6) }
    outline_settings.transparency = {
        key(0, 1), key(0.15, 0.2),
        key(0.3, 0.6), key(0.45, 0.2),
        key(0.6, 0.6), key(0.75, 0.1),
        key(0.8, 0.1), key(1, 1)
    }
    outline_settings.color = { colorKey(0, 0.8, 0.6, 1), colorKey(1, 0.8, 0.6, 1) }

    outer_glyph_settings = makeSettings()
    outer_glyph_settings.min_life = 1.6
    outer_glyph_settings.max_life = 1.6
    outer_glyph_settings.min_rotation_speed = -0.25
    outer_glyph_settings.max_rotation_speed = -0.25
    outer_glyph_settings.size = { key(0, 0.3), key(0.2, 0.6), key(0.8, 0.62), key(1, 0.8) }
    outer_glyph_settings.transparency = { key(0, 1), key(0.2, 0.55), key(0.8, 0.55), key(1, 1) }
    outer_glyph_settings.color = { colorKey(0, 0.45, 0.3, 0.9), colorKey(1, 0.7, 0.5, 1) }

    inner_glyph_settings = makeSettings()
    inner_glyph_settings.min_life = 1.6
    inner_glyph_settings.max_life = 1.6
    inner_glyph_settings.min_rotation_speed = 2.5
    inner_glyph_settings.max_rotation_speed = 2.5
    inner_glyph_settings.size = { key(0, 0), key(0.15, 0.18), key(0.8, 0.18), key(1, 0.3) }
    inner_glyph_settings.transparency = { key(0, 1), key(0.15, 0), key(0.8, 0), key(1, 1) }
    inner_glyph_settings.color = { colorKey(0, 1, 0.8, 1), colorKey(1, 1, 0.95, 1) }

    stamp_ring_settings = makeSettings()
    stamp_ring_settings.min_life = 0.3
    stamp_ring_settings.max_life = 0.3
    stamp_ring_settings.size = { key(0, 2), key(1, 1) }
    stamp_ring_settings.transparency = { key(0, 1), key(0.5, 0.1), key(0.9, 0), key(1, 1) }
    stamp_ring_settings.color = { colorKey(0, 0.8, 0.6, 1), colorKey(1, 1, 0.9, 1) }

    stamp_flash_settings = makeSettings()
    stamp_flash_settings.min_life = 0.45
    stamp_flash_settings.max_life = 0.45
    stamp_flash_settings.size = { key(0, 0.3), key(0.66, 0.3), key(1, 0.7) }
    stamp_flash_settings.transparency = { key(0, 1), key(0.65, 1), key(0.66, 0.1), key(1, 1) }
    stamp_flash_settings.color = { colorKey(0, 1, 0.9, 1), colorKey(1, 0.7, 0.5, 1) }

    pulse_rings_settings = makeSettings()
    pulse_rings_settings.count = 6
    pulse_rings_settings.rate = 3
    pulse_rings_settings.enabled = true
    pulse_rings_settings.min_life = 0.6
    pulse_rings_settings.max_life = 0.6
    pulse_rings_settings.size = { key(0, 0.4), key(1, 1.3) }
    pulse_rings_settings.transparency = { key(0, 0.3), key(1, 1) }
    pulse_rings_settings.color = { colorKey(0, 0.8, 0.6, 1), colorKey(1, 0.5, 0.3, 0.9) }

    cast_fog_settings = makeSettings()
    cast_fog_settings.count = 4
    cast_fog_settings.spawn_spread_x = 80
    cast_fog_settings.spawn_spread_y = 30
    cast_fog_settings.spread_angle = math.pi
    cast_fog_settings.min_speed = 5
    cast_fog_settings.max_speed = 20
    cast_fog_settings.min_life = 1.6
    cast_fog_settings.max_life = 2
    cast_fog_settings.min_rotation = 0
    cast_fog_settings.max_rotation = math.pi * 2
    cast_fog_settings.min_rotation_speed = -0.3
    cast_fog_settings.max_rotation_speed = 0.3
    cast_fog_settings.size = { key(0, 0.3, 0.05), key(1, 0.7, 0.1) }
    cast_fog_settings.transparency = { key(0, 1), key(0.3, 0.6), key(1, 1) }
    cast_fog_settings.color = { colorKey(0, 0.35, 0.2, 0.6), colorKey(1, 0.15, 0.1, 0.3) }

    motes_settings = makeSettings()
    motes_settings.count = 90
    motes_settings.rate = 70
    motes_settings.enabled = true
    motes_settings.spawn_spread_x = 180
    motes_settings.spawn_spread_y = 150
    motes_settings.spread_angle = math.pi * 0.15
    motes_settings.min_speed = 60
    motes_settings.max_speed = 180
    motes_settings.min_life = 0.5
    motes_settings.max_life = 1
    motes_settings.min_rotation_speed = -3
    motes_settings.max_rotation_speed = 3
    motes_settings.size = { key(0, 0.014, 0.005), key(1, 0) }
    motes_settings.transparency = { key(0, 1), key(0.3, 0), key(1, 1) }
    motes_settings.color = { colorKey(0, 0.75, 0.6, 1), colorKey(1, 1, 0.8, 0.95) }

    sigil_burst_settings = makeSettings()
    sigil_burst_settings.count = 30
    sigil_burst_settings.spawn_spread_x = 60
    sigil_burst_settings.spawn_spread_y = 60
    sigil_burst_settings.spread_angle = math.pi
    sigil_burst_settings.min_speed = 60
    sigil_burst_settings.max_speed = 200
    sigil_burst_settings.drag = 3
    sigil_burst_settings.min_life = 0.5
    sigil_burst_settings.max_life = 0.9
    sigil_burst_settings.size = { key(0, 0.25, 0.1), key(1, 0) }
    sigil_burst_settings.color = { colorKey(0, 1, 0.85, 1), colorKey(1, 0.6, 0.4, 1) }

    -- DEATH

    death_settings = makeSettings()
    death_settings.min_life = 0.9
    death_settings.max_life = 0.9
    death_settings.size = { key(0, 0.5), key(0.08, 0.22), key(0.16, 0.26), key(0.5, 0.26), key(1, 0.05) }
    death_settings.squash = { key(0, 0.4), key(0.08, -0.2), key(0.16, 0), key(1, 0) }
    death_settings.transparency = { key(0, 1), key(0.08, 0), key(0.9, 0), key(1, 1) }
    death_settings.color = {
        colorKey(0, 1, 0.4, 0.55),
        colorKey(0.16, 0.95, 0.15, 0.3),
        colorKey(0.5, 0.95, 0.15, 0.3),
        colorKey(1, 1, 0.85, 0.7)
    }

    death_ring_settings = makeSettings()
    death_ring_settings.min_life = 0.5
    death_ring_settings.max_life = 0.5
    death_ring_settings.size = { key(0, 0.15), key(1, 0.9) }
    death_ring_settings.transparency = { key(0, 0.2), key(1, 1) }
    death_ring_settings.color = { colorKey(0, 0.85, 0.1, 0.35), colorKey(1, 0.35, 0.02, 0.2) }

    -- ACCUMULATION

    converge_ring_settings = makeSettings()
    converge_ring_settings.min_life = 0.5
    converge_ring_settings.max_life = 0.5
    converge_ring_settings.size = { key(0, 1.1), key(1, 0.05) }
    converge_ring_settings.transparency = { key(0, 1), key(0.3, 0.2), key(1, 0) }
    converge_ring_settings.color = { colorKey(0, 1, 0.7, 0.55), colorKey(1, 1, 0.95, 0.8) }

    core_glow_settings = makeSettings()
    core_glow_settings.min_life = 0.5
    core_glow_settings.max_life = 0.5
    core_glow_settings.size = { key(0, 0.01), key(1, 0.15) }
    core_glow_settings.transparency = { key(0, 1), key(1, 0) }
    core_glow_settings.color = { colorKey(0, 1, 0.6, 0.45), colorKey(1, 1, 0.95, 0.8) }

    converge_objects = {}
    for i = 1, 8 do
        angle = (i - 1) / 8 * math.pi * 2
        converge_settings = makeSettings()
        converge_settings.count = 12
        converge_settings.rate = 20
        converge_settings.spawn_x = 400 + math.cos(angle) * 170
        converge_settings.spawn_y = 300 + math.sin(angle) * 170
        converge_settings.spawn_spread_x = 10
        converge_settings.spawn_spread_y = 10
        converge_settings.direction = angle + math.pi
        converge_settings.spread_angle = 0.08
        converge_settings.min_speed = 340
        converge_settings.max_speed = 340
        converge_settings.min_life = 0.5
        converge_settings.max_life = 0.5
        converge_settings.min_rotation_speed = -4
        converge_settings.max_rotation_speed = 4
        converge_settings.size = { key(0, 0.01), key(1, 0.02) }
        converge_settings.transparency = { key(0, 1), key(0.3, 0), key(1, 0.3) }
        converge_settings.color = { colorKey(0, 1, 0.6, 0.45), colorKey(1, 1, 0.95, 0.8) }
        converge_objects[i] = particleVfx.newObject("assets/star.png", converge_settings)
    end

    -- RISE

    star_shine_settings = makeSettings()
    star_shine_settings.min_life = 0.25
    star_shine_settings.max_life = 0.25
    star_shine_settings.min_rotation_speed = 2
    star_shine_settings.max_rotation_speed = 2
    star_shine_settings.size = { key(0, 0.05), key(0.3, 0.35), key(1, 0) }
    star_shine_settings.transparency = { key(0, 0), key(1, 0) }
    star_shine_settings.color = { colorKey(0, 1, 1, 1), colorKey(1, 1, 0.9, 0.7) }

    star_shine_small_settings = makeSettings()
    star_shine_small_settings.min_life = 0.25
    star_shine_small_settings.max_life = 0.25
    star_shine_small_settings.min_rotation = math.pi / 4
    star_shine_small_settings.max_rotation = math.pi / 4
    star_shine_small_settings.min_rotation_speed = -2
    star_shine_small_settings.max_rotation_speed = -2
    star_shine_small_settings.size = { key(0, 0.03), key(0.3, 0.2), key(1, 0) }
    star_shine_small_settings.transparency = { key(0, 0), key(1, 0) }
    star_shine_small_settings.color = { colorKey(0, 1, 0.95, 0.8), colorKey(1, 1, 0.8, 0.6) }

    shine_circle_settings = makeSettings()
    shine_circle_settings.min_life = 0.25
    shine_circle_settings.max_life = 0.25
    shine_circle_settings.size = { key(0, 0.05), key(1, 0.6) }
    shine_circle_settings.color = { colorKey(0, 1, 1, 1), colorKey(1, 1, 0.85, 0.6) }

    -- FATHOM

    flash_settings = makeSettings()
    flash_settings.min_life = 0.35
    flash_settings.max_life = 0.35
    flash_settings.size = { key(0, 0.2), key(0.2, 0.8), key(1, 0.9) }
    flash_settings.color = { colorKey(0, 1, 1, 1), colorKey(1, 1, 0.85, 0.5) }

    impact_frame_settings = makeSettings()
    impact_frame_settings.min_life = 0.15
    impact_frame_settings.max_life = 0.15
    impact_frame_settings.size = { key(0, 45), key(1, 45) }
    impact_frame_settings.transparency = { key(0, 0.05), key(0.3, 0.4), key(1, 1) }
    impact_frame_settings.color = { colorKey(0, 1, 0.98, 0.9), colorKey(1, 1, 0.8, 0.55) }

    impact_black_settings = makeSettings()
    impact_black_settings.min_life = 0.25
    impact_black_settings.max_life = 0.25
    impact_black_settings.size = { key(0, 45), key(1, 45) }
    impact_black_settings.transparency = {
        key(0, 1), key(0.5, 1),
        key(0.51, 0), key(0.62, 0),  
        key(0.63, 1), key(0.9, 1),
        key(0.91, 0), key(1, 0)
    }
    impact_black_settings.color = { colorKey(0, 0.03, 0.02, 0.05), colorKey(1, 0.03, 0.02, 0.05) }

    white_frame_transparency = {
        key(0, 1), key(0.62, 1),
        key(0.63, 0), key(0.9, 0),
        key(0.91, 1), key(1, 1)
    }
    ink = { colorKey(0, 0.06, 0.03, 0.08), colorKey(1, 0.06, 0.03, 0.08) }

    impact_white_settings = makeSettings()
    impact_white_settings.min_life = 0.25
    impact_white_settings.max_life = 0.25
    impact_white_settings.size = { key(0, 45), key(1, 45) }
    impact_white_settings.transparency = white_frame_transparency
    impact_white_settings.color = { colorKey(0, 1, 0.97, 0.92), colorKey(1, 1, 0.97, 0.92) }

    impact_lines_settings = makeSettings()
    impact_lines_settings.count = 28
    impact_lines_settings.min_life = 0.25
    impact_lines_settings.max_life = 0.25
    impact_lines_settings.min_rotation = 0
    impact_lines_settings.max_rotation = math.pi * 2
    impact_lines_settings.size = { key(0, 2.3, 0.6), key(1, 2.3, 0.6) }
    impact_lines_settings.squash = { key(0, 3.9, 0.3), key(1, 3.9, 0.3) }
    impact_lines_settings.transparency = white_frame_transparency
    impact_lines_settings.color = ink

    impact_hole_settings = makeSettings()
    impact_hole_settings.min_life = 0.25
    impact_hole_settings.max_life = 0.25
    impact_hole_settings.size = { key(0, 0.4), key(1, 0.4) }
    impact_hole_settings.transparency = white_frame_transparency
    impact_hole_settings.color = { colorKey(0, 1, 0.97, 0.92), colorKey(1, 1, 0.97, 0.92) }

    impact_ring_settings = makeSettings()
    impact_ring_settings.min_life = 0.25
    impact_ring_settings.max_life = 0.25
    impact_ring_settings.size = { key(0, 0.5), key(0.63, 0.5), key(0.9, 0.75), key(1, 0.75) }
    impact_ring_settings.transparency = white_frame_transparency
    impact_ring_settings.color = ink

    impact_star_settings = makeSettings()
    impact_star_settings.min_life = 0.25
    impact_star_settings.max_life = 0.25
    impact_star_settings.min_rotation = math.pi / 8
    impact_star_settings.max_rotation = math.pi / 8
    impact_star_settings.min_rotation_speed = 3
    impact_star_settings.max_rotation_speed = 3
    impact_star_settings.size = { key(0, 0.3), key(0.63, 0.3), key(0.9, 0.4), key(1, 0.4) }
    impact_star_settings.transparency = white_frame_transparency
    impact_star_settings.color = ink

    explosion_settings = makeSettings()
    explosion_settings.min_life = 1.4
    explosion_settings.max_life = 1.4
    explosion_settings.size = { key(0, 0.1), key(0.07, 1.05), key(0.2, 0.85), key(1, 0.95) }
    explosion_settings.squash = { key(0, -0.35), key(0.07, 0.15), key(0.2, 0), key(1, 0) }
    explosion_settings.transparency = { key(0, 0), key(0.5, 0.3), key(1, 1) }
    explosion_settings.color = {
        colorKey(0, 1, 0.95, 0.75),
        colorKey(0.2, 1, 0.6, 0.25),
        colorKey(0.6, 0.85, 0.25, 0.3),
        colorKey(1, 0.35, 0.1, 0.25)
    }

    impact_circle_settings = makeSettings()
    impact_circle_settings.min_life = 0.7
    impact_circle_settings.max_life = 0.7
    impact_circle_settings.size = { key(0, 0.1), key(1, 1.2) }
    impact_circle_settings.squash = { key(0, -0.4), key(0.3, 0), key(1, 0) }
    impact_circle_settings.color = { colorKey(0, 1, 0.8, 0.5), colorKey(1, 1, 0.4, 0.35) }

    shockwave_settings = makeSettings()
    shockwave_settings.min_life = 0.35
    shockwave_settings.max_life = 0.35
    shockwave_settings.size = { key(0, 0.2), key(1, 2.2) }
    shockwave_settings.squash = { key(0, -0.25), key(1, -0.1) }
    shockwave_settings.transparency = { key(0, 0), key(1, 1) }
    shockwave_settings.color = { colorKey(0, 1, 1, 1), colorKey(1, 1, 0.85, 0.6) }

    fireballs_settings = makeSettings()
    fireballs_settings.min_life = 1.2
    fireballs_settings.max_life = 1.2
    fireballs_settings.min_rotation = 0
    fireballs_settings.max_rotation = math.pi * 2
    fireballs_settings.min_rotation_speed = -0.6
    fireballs_settings.max_rotation_speed = 0.6
    fireballs_settings.size = { key(0, 0.15), key(0.12, 1.3), key(1, 1.55) }
    fireballs_settings.transparency = { key(0, 0.2), key(0.4, 0.35), key(1, 1) }
    fireballs_settings.color = {
        colorKey(0, 1, 0.9, 0.6),
        colorKey(0.3, 1, 0.5, 0.25),
        colorKey(1, 0.4, 0.12, 0.25)
    }

    embers_settings = makeSettings()
    embers_settings.count = 60
    embers_settings.rate = 35
    embers_settings.spawn_spread_x = 90
    embers_settings.spawn_spread_y = 40
    embers_settings.spread_angle = math.pi * 0.25
    embers_settings.min_speed = 30
    embers_settings.max_speed = 110
    embers_settings.acceleration_y = -40
    embers_settings.min_life = 0.8
    embers_settings.max_life = 1.6
    embers_settings.size = { key(0, 0.15, 0.05), key(1, 0) }
    embers_settings.transparency = { key(0, 0), key(0.6, 0.2), key(1, 1) }
    embers_settings.color = { colorKey(0, 1, 0.85, 0.5), colorKey(1, 0.9, 0.3, 0.3) }

    fog_settings = makeSettings()
    fog_settings.count = 6
    fog_settings.spawn_spread_x = 40
    fog_settings.spawn_spread_y = 40
    fog_settings.spread_angle = math.pi
    fog_settings.min_speed = 10
    fog_settings.max_speed = 40
    fog_settings.drag = 1
    fog_settings.min_life = 2.5
    fog_settings.max_life = 3.2
    fog_settings.min_rotation_speed = -0.4
    fog_settings.max_rotation_speed = 0.4
    fog_settings.size = { key(0, 0.15, 0.03), key(1, 0.55, 0.1) }
    fog_settings.transparency = { key(0, 1), key(0.15, 0.4), key(1, 1) }
    fog_settings.color = {
        colorKey(0, 1, 0.6, 0.25),
        colorKey(0.4, 0.85, 0.4, 0.2),
        colorKey(1, 0.35, 0.15, 0.12)
    }

    fog_back_settings = makeSettings()
    fog_back_settings.count = 5
    fog_back_settings.spawn_spread_x = 60
    fog_back_settings.spawn_spread_y = 40
    fog_back_settings.spread_angle = math.pi
    fog_back_settings.min_speed = 5
    fog_back_settings.max_speed = 25
    fog_back_settings.drag = 0.8
    fog_back_settings.acceleration_y = -8
    fog_back_settings.min_life = 3.2
    fog_back_settings.max_life = 4
    fog_back_settings.min_rotation = 0
    fog_back_settings.max_rotation = math.pi * 2
    fog_back_settings.min_rotation_speed = -0.2
    fog_back_settings.max_rotation_speed = 0.2
    fog_back_settings.size = { key(0, 0.3, 0.05), key(1, 0.9, 0.15) }
    fog_back_settings.transparency = { key(0, 1), key(0.2, 0.55), key(1, 1) }
    fog_back_settings.color = {
        colorKey(0, 0.9, 0.45, 0.2),
        colorKey(0.4, 0.6, 0.25, 0.15),
        colorKey(1, 0.25, 0.1, 0.1)
    }

    fog_front_settings = makeSettings()
    fog_front_settings.count = 10
    fog_front_settings.spawn_spread_x = 30
    fog_front_settings.spawn_spread_y = 30
    fog_front_settings.spread_angle = math.pi
    fog_front_settings.min_speed = 80
    fog_front_settings.max_speed = 220
    fog_front_settings.drag = 2
    fog_front_settings.acceleration_y = -15
    fog_front_settings.min_life = 1.2
    fog_front_settings.max_life = 2
    fog_front_settings.min_rotation = 0
    fog_front_settings.max_rotation = math.pi * 2
    fog_front_settings.min_rotation_speed = -0.8
    fog_front_settings.max_rotation_speed = 0.8
    fog_front_settings.size = { key(0, 0.08, 0.02), key(1, 0.3, 0.06) }
    fog_front_settings.transparency = { key(0, 1), key(0.1, 0.5), key(1, 1) }
    fog_front_settings.color = {
        colorKey(0, 1, 0.75, 0.35),
        colorKey(0.3, 1, 0.55, 0.22),
        colorKey(1, 0.5, 0.2, 0.15)
    }

    star_settings = makeSettings()
    star_settings.count = 24
    star_settings.spawn_spread_x = 35
    star_settings.spawn_spread_y = 35
    star_settings.spread_angle = math.pi
    star_settings.min_speed = 150
    star_settings.max_speed = 700
    star_settings.drag = 2.5
    star_settings.min_rotation_speed = -3
    star_settings.max_rotation_speed = 3
    star_settings.size = { key(0, 0.035, 0.01), key(1, 0.035, 0.01) }
    star_settings.color = { colorKey(0, 1, 0.95, 0.8), colorKey(1, 1, 0.6, 0.5) }

    impact_debris_settings = makeSettings()
    impact_debris_settings.min_life = 0.9
    impact_debris_settings.max_life = 0.9
    impact_debris_settings.min_rotation = 0
    impact_debris_settings.max_rotation = math.pi * 2
    impact_debris_settings.min_rotation_speed = -0.5
    impact_debris_settings.max_rotation_speed = 0.5
    impact_debris_settings.size = { key(0, 0.3), key(0.15, 1.8), key(1, 2.2) }
    impact_debris_settings.transparency = { key(0, 0), key(0.4, 0.1), key(1, 1) }
    impact_debris_settings.color = { colorKey(0, 1, 0.55, 0.3), colorKey(1, 0.6, 0.2, 0.25) }

    halfdebris_settings = makeSettings()
    halfdebris_settings.min_life = 1.1
    halfdebris_settings.max_life = 1.1
    halfdebris_settings.min_rotation = 0
    halfdebris_settings.max_rotation = math.pi * 2
    halfdebris_settings.min_rotation_speed = -0.3
    halfdebris_settings.max_rotation_speed = 0.3
    halfdebris_settings.size = { key(0, 0.1), key(0.15, 0.75), key(1, 0.95) }
    halfdebris_settings.transparency = { key(0, 0), key(0.5, 0.1), key(1, 1) }
    halfdebris_settings.color = { colorKey(0, 0.85, 0.4, 0.3), colorKey(1, 0.4, 0.15, 0.2) }

    rocks_settings = makeSettings()
    rocks_settings.count = 10
    rocks_settings.spawn_spread_x = 12
    rocks_settings.spawn_spread_y = 12
    rocks_settings.spread_angle = math.pi * 0.4
    rocks_settings.min_speed = 200
    rocks_settings.max_speed = 460
    rocks_settings.acceleration_y = 600
    rocks_settings.min_rotation_speed = -4
    rocks_settings.max_rotation_speed = 4
    rocks_settings.size = { key(0, 0.04, 0.012), key(1, 0.04, 0.012) }
    rocks_settings.transparency = { key(0, 0), key(0.7, 0), key(1, 1) }
    rocks_settings.color = { colorKey(0, 0.55, 0.4, 0.45), colorKey(1, 0.35, 0.25, 0.35) }

    square_settings = makeSettings()
    square_settings.count = 140
    square_settings.spawn_spread_x = 25
    square_settings.spawn_spread_y = 25
    square_settings.spread_angle = math.pi
    square_settings.min_speed = 200
    square_settings.max_speed = 1400
    square_settings.drag = 2.5
    square_settings.acceleration_y = 60
    square_settings.min_life = 0.7
    square_settings.max_life = 2
    square_settings.min_rotation_speed = -8
    square_settings.max_rotation_speed = 8
    square_settings.size = { key(0, 0.35, 0.2), key(0.3, 0.25, 0.12), key(1, 0) }
    square_settings.transparency = { key(0, 0), key(0.7, 0.1), key(1, 1) }
    square_settings.color = { colorKey(0, 1, 0.95, 0.75), colorKey(1, 1, 0.45, 0.35) }

    glyph = particleVfx.newObject("assets/glyph.png", glyph_settings)
    glyph_outline = particleVfx.newObject("assets/glyph_outline.png", outline_settings)
    motes = particleVfx.newObject("assets/star.png", motes_settings)
    outer_glyph = particleVfx.newObject("assets/glyph.png", outer_glyph_settings)
    inner_glyph = particleVfx.newObject("assets/glyph.png", inner_glyph_settings)
    stamp_ring = particleVfx.newObject("assets/impact_circle.png", stamp_ring_settings)
    stamp_flash = particleVfx.newObject("assets/impact_debrislight.png", stamp_flash_settings)
    pulse_rings = particleVfx.newObject("assets/impact_circle.png", pulse_rings_settings)
    cast_fog = particleVfx.newObject("assets/fog.png", cast_fog_settings)
    sigil_burst = particleVfx.newObject("assets/square.png", sigil_burst_settings)
    death_symbol = particleVfx.newObject("assets/death.png", death_settings)
    death_ring = particleVfx.newObject("assets/impact_circle.png", death_ring_settings)
    converge_ring = particleVfx.newObject("assets/impact_circle.png", converge_ring_settings)
    core_glow = particleVfx.newObject("assets/impact_debrislight.png", core_glow_settings)
    star_shine = particleVfx.newObject("assets/star.png", star_shine_settings)
    star_shine_small = particleVfx.newObject("assets/star.png", star_shine_small_settings)
    shine_circle = particleVfx.newObject("assets/impact_circle.png", shine_circle_settings)
    flash = particleVfx.newObject("assets/impact_debrislight.png", flash_settings)
    explosion = particleVfx.newObject("assets/explosion.png", explosion_settings)
    impact_circle = particleVfx.newObject("assets/impact_circle.png", impact_circle_settings)
    impact_frame = particleVfx.newObject("assets/square.png", impact_frame_settings)
    impact_black = particleVfx.newObject("assets/square.png", impact_black_settings)
    impact_white = particleVfx.newObject("assets/square.png", impact_white_settings)
    impact_lines = particleVfx.newObject("assets/square.png", impact_lines_settings)
    impact_hole = particleVfx.newObject("assets/fog.png", impact_hole_settings)
    impact_ring = particleVfx.newObject("assets/impact_circle.png", impact_ring_settings)
    impact_star = particleVfx.newObject("assets/star.png", impact_star_settings)
    shockwave = particleVfx.newObject("assets/impact_circle.png", shockwave_settings)
    fireballs = particleVfx.newObject("assets/explosion.png", fireballs_settings)
    embers = particleVfx.newObject("assets/square.png", embers_settings)
    fog = particleVfx.newObject("assets/fog.png", fog_settings)
    fog_back = particleVfx.newObject("assets/fog.png", fog_back_settings)
    fog_front = particleVfx.newObject("assets/fog.png", fog_front_settings)
    star = particleVfx.newObject("assets/star.png", star_settings)
    impact_debris = particleVfx.newObject("assets/impact_debris.png", impact_debris_settings)
    halfdebris = particleVfx.newObject("assets/impact_halfdebris.png", halfdebris_settings)
    rocks = particleVfx.newObject("assets/rocks.png", rocks_settings)
    sparks = particleVfx.newObject("assets/square.png", square_settings)

    particleVfx.particle_objects = {
        fog_back, fog, cast_fog, outer_glyph, pulse_rings, glyph_outline, glyph, inner_glyph, motes, stamp_flash, stamp_ring, sigil_burst, death_ring, death_symbol, converge_ring
    }

    for i = 1, #converge_objects do
        particleVfx.particle_objects[#particleVfx.particle_objects + 1] = converge_objects[i]
    end

    top_objects = {
        impact_black,
        core_glow, shine_circle, star_shine, star_shine_small, embers, impact_circle, shockwave, flash, fireballs, explosion, fog_front, impact_debris, halfdebris, rocks, sparks, star, impact_frame, impact_white, impact_lines, impact_hole, impact_ring, impact_star
    }

    for i = 1, #top_objects do
        particleVfx.particle_objects[#particleVfx.particle_objects + 1] = top_objects[i]
    end

    cast_sound = love.audio.newSource("assets/sounds/cast.ogg", "static")
    death_sound = love.audio.newSource("assets/sounds/death.mp3", "static")
    impact_sound = love.audio.newSource("assets/sounds/impact.mp3", "static")
    windup_sound = love.audio.newSource("assets/sounds/windup.mp3", "static")
    impact2_sound = love.audio.newSource("assets/sounds/impact2.mp3", "static")

    particleVfx.emit(glyph)
    particleVfx.emit(glyph_outline)
    particleVfx.emit(outer_glyph)
    particleVfx.emit(inner_glyph)
    particleVfx.emit(stamp_ring)
    particleVfx.emit(stamp_flash)
    particleVfx.emit(cast_fog)
    cast_sound:play()
    effect_time = 0
    effect_stage = 0
    shake_time = 0.2
    shake_x = 0
    shake_y = 0
end

function setConvergeEnabled(enabled)
    for i = 1, #converge_objects do
        converge_objects[i].settings.enabled = enabled
    end
end

-- used in updateShake()
function moveAllParticles(dx, dy)
    for object_index = 1, #particleVfx.particle_objects do
        particle_object = particleVfx.particle_objects[object_index]
        for particle_index = 1, particle_object.max_count do
            particle = particle_object.particles[particle_index]
            if particle.alive then
                particle.x = particle.x + dx
                particle.y = particle.y + dy
            end
        end
    end
end

-- fake screenshake by moving all particles
function updateShake()
    shake_length = 0.5
    shake_strength = 16

    new_x = 0
    new_y = 0

    if shake_time > 0 then
        strength = shake_strength * shake_time / shake_length
        new_x = (math.random() * 2 - 1) * strength
        new_y = (math.random() * 2 - 1) * strength
        shake_time = math.max(shake_time - 1 / 60, 0)
    end

    moveAllParticles(new_x - shake_x, new_y - shake_y)
    shake_x = new_x
    shake_y = new_y
end

function love.update(dt)
    effect_time = effect_time + 1 / 60

    if effect_stage == 0 and effect_time >= 1.6 then
        motes.settings.enabled = false
        pulse_rings.settings.enabled = false
        particleVfx.emit(sigil_burst)
        particleVfx.emit(death_symbol)
        particleVfx.emit(death_ring)
        death_sound:play()
        effect_stage = 1
    elseif effect_stage == 1 and effect_time >= 2.0 then
        particleVfx.emit(converge_ring)
        particleVfx.emit(core_glow)
        setConvergeEnabled(true)
        windup_sound:play()
        effect_stage = 2
    elseif effect_stage == 2 and effect_time >= 2.5 then
        setConvergeEnabled(false)
        particleVfx.emit(star_shine)
        particleVfx.emit(star_shine_small)
        particleVfx.emit(shine_circle)
        particleVfx.emit(impact_black)
        particleVfx.emit(impact_white)
        particleVfx.emit(impact_lines)
        particleVfx.emit(impact_hole)
        particleVfx.emit(impact_ring)
        particleVfx.emit(impact_star)
        effect_stage = 3
    elseif effect_stage == 3 and effect_time >= 2.75 then
        particleVfx.emit(fog)
        particleVfx.emit(fog_back)
        particleVfx.emit(fog_front)
        particleVfx.emit(impact_circle)
        particleVfx.emit(flash)
        particleVfx.emit(explosion)
        particleVfx.emit(star)
        particleVfx.emit(impact_debris)
        particleVfx.emit(halfdebris)
        particleVfx.emit(rocks)
        particleVfx.emit(sparks)
        particleVfx.emit(impact_frame)
        particleVfx.emit(shockwave)
        particleVfx.emit(fireballs)
        embers.settings.enabled = true
        impact_sound:play()
        impact2_sound:play()
        shake_time = 0.5
        effect_stage = 4
    elseif effect_stage == 4 and effect_time >= 4.25 then
        embers.settings.enabled = false
        effect_stage = 5
    end

    updateShake()
    particleVfx.update(dt)

    -- added post debug.lua
    for i = 1, sparks.max_count do
        debugModule.addParticle("sparks", sparks, i)
    end
    -- for i = 1, embers.max_count do
    --     debugModule.addParticle("embers", embers, i)
    -- end
    -- for i = 1, sigil_burst.max_count do
    --     debugModule.addParticle("sigil_burst", sigil_burst, i)
    -- end
    -- for i = 1, death_symbol.max_count do
    --     debugModule.addParticle("death_symbol", death_symbol, i)
    -- end
    -- for i = 1, death_ring.max_count do
    --     debugModule.addParticle("death_ring", death_ring, i)
    -- end
    -- for i = 1, converge_ring.max_count do
    --     debugModule.addParticle("converge_ring", converge_ring, i)
    --end
end

function love.draw()
    particleVfx.draw()

    -- added post debug.lua
    debugModule.drawDebug()
end
