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

    -- shared colors
    red = { colorKey(0, 1, 0.05, 0.05), colorKey(1, 1, 0.05, 0.05) }
    dark_red = { colorKey(0, 0.5, 0, 0), colorKey(1, 0.5, 0, 0) }

    -- MOON (4.0s - 14.5s)

    -- background starfield, two layers that blink at different times
    stars_settings = makeSettings()
    stars_settings.min_life = 8
    stars_settings.max_life = 8
    stars_settings.size = { key(0, 6.5), key(1, 6.5) }
    stars_settings.transparency = {
        key(0, 1), key(0.04, 0.8), key(0.1, 0.5),
        key(0.17, 0.6), key(0.25, 0.8), key(0.33, 0.6), key(0.4, 0.4),
        key(0.47, 0.6), key(0.55, 0.8), key(0.63, 0.6), key(0.7, 0.4),
        key(0.78, 0.55), key(0.85, 0.7), key(0.93, 0.88), key(1, 1)
    }
    stars_settings.color = { colorKey(0, 0.8, 0.85, 1), colorKey(1, 0.8, 0.85, 1) }

    stars2_settings = makeSettings()
    stars2_settings.min_life = 8
    stars2_settings.max_life = 8
    stars2_settings.min_rotation = math.pi / 2
    stars2_settings.max_rotation = math.pi / 2
    stars2_settings.size = { key(0, 5), key(1, 5) }
    stars2_settings.transparency = {
        key(0, 1), key(0.05, 0.9), key(0.1, 0.8),
        key(0.17, 0.6), key(0.25, 0.4), key(0.33, 0.6), key(0.4, 0.8),
        key(0.47, 0.6), key(0.55, 0.4), key(0.63, 0.6), key(0.7, 0.8),
        key(0.78, 0.65), key(0.85, 0.5), key(0.93, 0.8), key(1, 1)
    }
    stars2_settings.color = { colorKey(0, 0.8, 0.85, 1), colorKey(1, 0.8, 0.85, 1) }

    -- the moon "zooms out" in steps, then turns a little red at the end
    -- extra keys in between each step make the zoom ease in and out
    -- instead of moving at one constant speed
    moon_settings = makeSettings()
    moon_settings.min_life = 10.5
    moon_settings.max_life = 10.5
    moon_settings.size = {
        key(0, 0.6), key(0.1, 0.56), key(0.2, 0.52), key(0.28, 0.5),
        key(0.2925, 0.469), key(0.305, 0.4), key(0.3175, 0.331), key(0.33, 0.3),
        key(0.5, 0.26),
        key(0.5125, 0.2475), key(0.525, 0.22), key(0.5375, 0.1925), key(0.55, 0.18),
        key(0.76, 0.15), key(0.95, 0.13),
        key(0.9625, 0.125), key(0.975, 0.11), key(0.9875, 0.085), key(1, 0.05)
    }
    moon_settings.transparency = {
        key(0, 1), key(0.03, 0.6), key(0.06, 0.25), key(0.09, 0.05), key(0.12, 0),
        key(0.96, 0), key(0.98, 0.3), key(1, 1)
    }
    moon_settings.color = {
        colorKey(0, 0.7, 0.7, 0.75),
        colorKey(0.1, 1, 1, 1),
        colorKey(0.76, 1, 1, 1),
        colorKey(0.85, 1, 0.85, 0.85),
        colorKey(1, 1, 0.6, 0.6)
    }

    -- long blue lens line going through the moon
    -- negative squash = wide and flat
    moon_line_settings = makeSettings()
    moon_line_settings.min_life = 8
    moon_line_settings.max_life = 8
    moon_line_settings.size = { key(0, 3), key(1, 2.5) }
    moon_line_settings.squash = { key(0, -4.3), key(1, -4.3) }
    moon_line_settings.transparency = {
        key(0, 1), key(0.05, 0.75), key(0.1, 0.5), key(0.15, 0.4),
        key(0.85, 0.5), key(0.92, 0.7), key(0.97, 0.92), key(1, 1)
    }
    moon_line_settings.color = { colorKey(0, 0.55, 0.6, 1), colorKey(1, 0.55, 0.6, 1) }

    -- RED BURST (12.0s - 14.5s)

    -- black disc behind the moon (moon image painted black)
    moon_shadow_settings = makeSettings()
    moon_shadow_settings.min_life = 2.5
    moon_shadow_settings.max_life = 2.5
    moon_shadow_settings.size = {
        key(0, 0.1), key(0.03, 0.18), key(0.06, 0.22), key(0.1, 0.24),
        key(0.85, 0.24), key(0.9, 0.22), key(0.95, 0.17), key(1, 0.1)
    }
    moon_shadow_settings.transparency = {
        key(0, 1), key(0.03, 0.5), key(0.06, 0.15), key(0.1, 0),
        key(0.9, 0), key(0.95, 0.4), key(1, 1)
    }
    moon_shadow_settings.color = { colorKey(0, 0, 0, 0), colorKey(1, 0, 0, 0) }

    red_glow_settings = makeSettings()
    red_glow_settings.min_life = 2.5
    red_glow_settings.max_life = 2.5
    red_glow_settings.size = {
        key(0, 0.2), key(0.03, 0.4), key(0.06, 0.5), key(0.1, 0.55),
        key(0.85, 0.6), key(0.9, 0.57), key(0.95, 0.48), key(1, 0.3)
    }
    red_glow_settings.transparency = {
        key(0, 1), key(0.03, 0.6), key(0.06, 0.35), key(0.1, 0.2),
        key(0.85, 0.3), key(0.9, 0.4), key(0.95, 0.65), key(1, 1)
    }
    red_glow_settings.color = red

    red_rays_settings = makeSettings()
    red_rays_settings.min_life = 2.5
    red_rays_settings.max_life = 2.5
    red_rays_settings.min_rotation_speed = 0.4
    red_rays_settings.max_rotation_speed = 0.4
    red_rays_settings.size = {
        key(0, 0.4), key(0.03, 0.85), key(0.06, 1.1), key(0.1, 1.2),
        key(0.85, 1.3), key(0.9, 1.25), key(0.95, 1.05), key(1, 0.6)
    }
    red_rays_settings.transparency = {
        key(0, 1), key(0.03, 0.5), key(0.06, 0.2), key(0.1, 0.1),
        key(0.85, 0.2), key(0.9, 0.3), key(0.95, 0.6), key(1, 1)
    }
    red_rays_settings.color = red

    red_glare_settings = makeSettings()
    red_glare_settings.min_life = 2.5
    red_glare_settings.max_life = 2.5
    red_glare_settings.min_rotation_speed = -0.3
    red_glare_settings.max_rotation_speed = -0.3
    red_glare_settings.size = {
        key(0, 0.2), key(0.03, 0.42), key(0.06, 0.54), key(0.1, 0.6),
        key(0.85, 0.65), key(0.9, 0.62), key(0.95, 0.5), key(1, 0.3)
    }
    red_glare_settings.transparency = {
        key(0, 1), key(0.03, 0.65), key(0.06, 0.42), key(0.1, 0.3),
        key(0.9, 0.3), key(0.95, 0.6), key(1, 1)
    }
    red_glare_settings.color = red

    -- 8 sparkles placed in a circle around the moon
    -- they drift sideways a little so the circle looks like it's turning
    sparkle_objects = {}
    for i = 1, 8 do
        angle = (i - 1) / 8 * math.pi * 2 + math.pi / 8
        sparkle_settings = makeSettings()
        sparkle_settings.spawn_x = 400 + math.cos(angle) * 210
        sparkle_settings.spawn_y = 300 + math.sin(angle) * 210
        sparkle_settings.direction = angle + math.pi / 2
        sparkle_settings.min_speed = 30
        sparkle_settings.max_speed = 30
        sparkle_settings.min_life = 2.5
        sparkle_settings.max_life = 2.5
        sparkle_settings.min_rotation = angle
        sparkle_settings.max_rotation = angle
        sparkle_settings.min_rotation_speed = 0.5
        sparkle_settings.max_rotation_speed = 0.5
        sparkle_settings.size = {
            key(0, 0), key(0.03, 0.07), key(0.06, 0.105), key(0.1, 0.12),
            key(0.85, 0.12), key(0.9, 0.105), key(0.95, 0.06), key(1, 0)
        }
        sparkle_settings.transparency = { key(0, 0), key(1, 0) }
        sparkle_settings.color = { colorKey(0, 1, 0.5, 0.5), colorKey(1, 1, 0.3, 0.3) }
        sparkle_objects[i] = particleVfx.newObject("assets/RiftStar.png", sparkle_settings)
    end

    -- red fog clouds behind the moon, slowly spinning
    burst_fog_settings = makeSettings()
    burst_fog_settings.count = 8
    burst_fog_settings.spawn_spread_x = 60
    burst_fog_settings.spawn_spread_y = 60
    burst_fog_settings.spread_angle = math.pi
    burst_fog_settings.min_speed = 10
    burst_fog_settings.max_speed = 40
    burst_fog_settings.min_life = 2.5
    burst_fog_settings.max_life = 2.5
    burst_fog_settings.min_rotation = 0
    burst_fog_settings.max_rotation = math.pi * 2
    burst_fog_settings.min_rotation_speed = -0.4
    burst_fog_settings.max_rotation_speed = 0.4
    burst_fog_settings.size = {
        key(0, 0.3, 0.05), key(0.05, 0.6, 0.1), key(0.1, 0.75, 0.15),
        key(0.85, 0.9, 0.2), key(0.93, 0.8, 0.2), key(1, 0.5, 0.1)
    }
    burst_fog_settings.transparency = {
        key(0, 1), key(0.05, 0.75), key(0.1, 0.55), key(0.15, 0.5),
        key(0.85, 0.55), key(0.93, 0.75), key(1, 1)
    }
    burst_fog_settings.color = { colorKey(0, 0.8, 0.05, 0.05), colorKey(1, 0.5, 0, 0) }

    -- small red stars drifting out from behind the moon
    burst_stars_settings = makeSettings()
    burst_stars_settings.count = 60
    burst_stars_settings.rate = 30
    burst_stars_settings.spawn_spread_x = 40
    burst_stars_settings.spawn_spread_y = 40
    burst_stars_settings.spread_angle = math.pi
    burst_stars_settings.min_speed = 40
    burst_stars_settings.max_speed = 140
    burst_stars_settings.drag = 0.5
    burst_stars_settings.min_life = 1
    burst_stars_settings.max_life = 1.8
    burst_stars_settings.min_rotation_speed = -3
    burst_stars_settings.max_rotation_speed = 3
    burst_stars_settings.size = {
        key(0, 0, 0), key(0.15, 0.02, 0.008), key(0.3, 0.025, 0.01),
        key(0.7, 0.02, 0.008), key(0.85, 0.012, 0.005), key(1, 0)
    }
    burst_stars_settings.transparency = {
        key(0, 1), key(0.1, 0.4), key(0.2, 0.1), key(0.7, 0.2), key(0.85, 0.5), key(1, 1)
    }
    burst_stars_settings.color = { colorKey(0, 1, 0.6, 0.6), colorKey(1, 1, 0.1, 0.1) }

    -- FLASH + EXPLOSION (14.5s - 16.0s)

    white_flash_settings = makeSettings()
    white_flash_settings.min_life = 0.12
    white_flash_settings.max_life = 0.12
    white_flash_settings.size = { key(0, 45), key(1, 45) }
    white_flash_settings.transparency = { key(0, 0), key(0.3, 0.1), key(0.6, 0.4), key(1, 1) }
    white_flash_settings.color = { colorKey(0, 1, 1, 1), colorKey(1, 1, 1, 1) }

    red_screen_settings = makeSettings()
    red_screen_settings.min_life = 1.5
    red_screen_settings.max_life = 1.5
    red_screen_settings.size = { key(0, 45), key(1, 45) }
    red_screen_settings.transparency = { key(0, 0), key(0.1, 0.15), key(0.3, 0.6), key(0.6, 0.85), key(1, 1) }
    red_screen_settings.color = { colorKey(0, 0.45, 0, 0), colorKey(1, 0.2, 0, 0) }

    pythios_flash_settings = makeSettings()
    pythios_flash_settings.min_life = 0.6
    pythios_flash_settings.max_life = 0.6
    pythios_flash_settings.size = { key(0, 0.45), key(0.5, 0.49), key(1, 0.5) }
    pythios_flash_settings.transparency = { key(0, 0), key(0.4, 0.05), key(0.6, 0.2), key(0.8, 0.5), key(1, 1) }
    pythios_flash_settings.color = red

    ritual_settings = makeSettings()
    ritual_settings.min_life = 1.3
    ritual_settings.max_life = 1.3
    ritual_settings.min_rotation_speed = 0.8
    ritual_settings.max_rotation_speed = 0.8
    ritual_settings.size = { key(0, 0.3), key(0.15, 0.42), key(0.4, 0.47), key(1, 0.5) }
    ritual_settings.transparency = {
        key(0, 1), key(0.08, 0.5), key(0.2, 0.1), key(0.6, 0.2), key(0.8, 0.5), key(1, 1)
    }
    ritual_settings.color = red

    explode_fog_settings = makeSettings()
    explode_fog_settings.count = 14
    explode_fog_settings.spawn_spread_x = 30
    explode_fog_settings.spawn_spread_y = 30
    explode_fog_settings.spread_angle = math.pi
    explode_fog_settings.min_speed = 150
    explode_fog_settings.max_speed = 350
    explode_fog_settings.drag = 2
    explode_fog_settings.min_life = 1.2
    explode_fog_settings.max_life = 1.8
    explode_fog_settings.min_rotation = 0
    explode_fog_settings.max_rotation = math.pi * 2
    explode_fog_settings.min_rotation_speed = -0.5
    explode_fog_settings.max_rotation_speed = 0.5
    explode_fog_settings.size = {
        key(0, 0.2, 0.05), key(0.15, 0.55, 0.1), key(0.4, 0.78, 0.15), key(1, 0.9, 0.2)
    }
    explode_fog_settings.transparency = {
        key(0, 1), key(0.05, 0.6), key(0.15, 0.3), key(0.6, 0.5), key(0.85, 0.8), key(1, 1)
    }
    explode_fog_settings.color = { colorKey(0, 1, 0.1, 0.1), colorKey(1, 0.6, 0, 0) }

    -- RING (16.0s - 17.6s)

    big_ring_settings = makeSettings()
    big_ring_settings.min_life = 1.6
    big_ring_settings.max_life = 1.6
    big_ring_settings.size = { key(0, 1.1), key(0.2, 1.5), key(0.5, 1.8), key(1, 2) }
    big_ring_settings.transparency = {
        key(0, 0.6), key(0.05, 0.1), key(0.3, 0.1), key(0.6, 0.35), key(0.85, 0.7), key(1, 1)
    }
    big_ring_settings.color = red

    ring_fog_settings = makeSettings()
    ring_fog_settings.min_life = 1.6
    ring_fog_settings.max_life = 1.6
    ring_fog_settings.min_rotation_speed = 0.3
    ring_fog_settings.max_rotation_speed = 0.3
    ring_fog_settings.size = { key(0, 1.2), key(0.3, 1.5), key(0.6, 1.7), key(1, 1.8) }
    ring_fog_settings.transparency = { key(0, 0.8), key(0.1, 0.3), key(0.5, 0.5), key(0.8, 0.8), key(1, 1) }
    ring_fog_settings.color = { colorKey(0, 0.7, 0, 0), colorKey(1, 0.4, 0, 0) }

    spiky_star_settings = makeSettings()
    spiky_star_settings.min_life = 1.6
    spiky_star_settings.max_life = 1.6
    spiky_star_settings.min_rotation_speed = 0.6
    spiky_star_settings.max_rotation_speed = 0.6
    spiky_star_settings.size = { key(0, 0.4), key(0.07, 0.6), key(0.2, 0.7), key(1, 0.8) }
    spiky_star_settings.transparency = { key(0, 0.5), key(0.05, 0), key(0.6, 0.1), key(0.8, 0.4), key(1, 1) }
    spiky_star_settings.color = red

    red_line_settings = makeSettings()
    red_line_settings.min_life = 1.6
    red_line_settings.max_life = 1.6
    red_line_settings.size = { key(0, 3), key(1, 3) }
    red_line_settings.squash = { key(0, -4.3), key(1, -4.3) }
    red_line_settings.transparency = { key(0, 0.5), key(0.05, 0), key(0.5, 0.2), key(0.8, 0.6), key(1, 1) }
    red_line_settings.color = red

    -- RED FOG EMBLEM (17.6s - 21.5s)

    red_bg_settings = makeSettings()
    red_bg_settings.min_life = 3.9
    red_bg_settings.max_life = 3.9
    red_bg_settings.size = { key(0, 45), key(1, 45) }
    red_bg_settings.transparency = {
        key(0, 1), key(0.05, 0.4), key(0.1, 0), key(0.85, 0.1), key(0.95, 0.5), key(1, 1)
    }
    red_bg_settings.color = { colorKey(0, 0.75, 0, 0), colorKey(1, 0.45, 0, 0) }

    bg_fog_settings = makeSettings()
    bg_fog_settings.count = 10
    bg_fog_settings.spawn_spread_x = 400
    bg_fog_settings.spawn_spread_y = 300
    bg_fog_settings.spread_angle = math.pi
    bg_fog_settings.min_speed = 5
    bg_fog_settings.max_speed = 20
    bg_fog_settings.min_life = 3.9
    bg_fog_settings.max_life = 3.9
    bg_fog_settings.min_rotation = 0
    bg_fog_settings.max_rotation = math.pi * 2
    bg_fog_settings.min_rotation_speed = -0.1
    bg_fog_settings.max_rotation_speed = 0.1
    bg_fog_settings.size = { key(0, 0.8, 0.2), key(1, 1, 0.2) }
    bg_fog_settings.transparency = {
        key(0, 1), key(0.05, 0.8), key(0.1, 0.65), key(0.15, 0.6),
        key(0.85, 0.6), key(0.92, 0.75), key(0.97, 0.92), key(1, 1)
    }
    bg_fog_settings.color = { colorKey(0, 0.25, 0, 0), colorKey(1, 0.25, 0, 0) }

    emblem_ring_settings = makeSettings()
    emblem_ring_settings.min_life = 3.9
    emblem_ring_settings.max_life = 3.9
    emblem_ring_settings.min_rotation_speed = 0.05
    emblem_ring_settings.max_rotation_speed = 0.05
    emblem_ring_settings.size = { key(0, 0.3), key(0.5, 0.285), key(1, 0.27) }
    emblem_ring_settings.transparency = {
        key(0, 1), key(0.05, 0.6), key(0.1, 0.4), key(0.15, 0.3),
        key(0.85, 0.4), key(0.92, 0.6), key(0.97, 0.88), key(1, 1)
    }
    emblem_ring_settings.color = red

    emblem_moon_settings = makeSettings()
    emblem_moon_settings.min_life = 3.9
    emblem_moon_settings.max_life = 3.9
    emblem_moon_settings.size = { key(0, 0.2), key(0.5, 0.19), key(1, 0.18) }
    emblem_moon_settings.transparency = {
        key(0, 1), key(0.05, 0.6), key(0.1, 0.4), key(0.15, 0.3),
        key(0.85, 0.4), key(0.92, 0.6), key(0.97, 0.88), key(1, 1)
    }
    emblem_moon_settings.color = red

    -- SIGIL ZOOM (21.5s - 25.0s)

    sigil_settings = makeSettings()
    sigil_settings.min_life = 3.5
    sigil_settings.max_life = 3.5
    sigil_settings.min_rotation_speed = 0.1
    sigil_settings.max_rotation_speed = 0.1
    sigil_settings.size = {
        key(0, 0.3), key(0.2, 0.33), key(0.4, 0.35),
        key(0.44, 0.38), key(0.48, 0.45), key(0.52, 0.52), key(0.56, 0.55),
        key(0.85, 0.6), key(0.93, 0.65), key(1, 0.7)
    }
    sigil_settings.transparency = {
        key(0, 1), key(0.03, 0.6), key(0.06, 0.25), key(0.1, 0),
        key(0.8, 0), key(0.88, 0.3), key(0.95, 0.75), key(1, 1)
    }
    sigil_settings.color = red

    sigil_glow_settings = makeSettings()
    sigil_glow_settings.min_life = 3.5
    sigil_glow_settings.max_life = 3.5
    sigil_glow_settings.size = {
        key(0, 0.3), key(0.4, 0.35),
        key(0.44, 0.42), key(0.48, 0.5), key(0.52, 0.57), key(0.56, 0.6),
        key(1, 0.8)
    }
    sigil_glow_settings.transparency = {
        key(0, 1), key(0.05, 0.6), key(0.1, 0.4), key(0.8, 0.3), key(0.9, 0.6), key(1, 1)
    }
    sigil_glow_settings.color = dark_red

    sigil_halo_settings = makeSettings()
    sigil_halo_settings.min_life = 3.5
    sigil_halo_settings.max_life = 3.5
    sigil_halo_settings.min_rotation_speed = -0.08
    sigil_halo_settings.max_rotation_speed = -0.08
    sigil_halo_settings.size = {
        key(0, 0.55), key(0.4, 0.6),
        key(0.44, 0.7), key(0.48, 0.82), key(0.52, 0.91), key(0.56, 0.95),
        key(1, 1.1)
    }
    sigil_halo_settings.transparency = {
        key(0, 1), key(0.05, 0.7), key(0.1, 0.5), key(0.8, 0.5), key(0.9, 0.75), key(1, 1)
    }
    sigil_halo_settings.color = red

    sigil_fill_settings = makeSettings()
    sigil_fill_settings.min_life = 1.5
    sigil_fill_settings.max_life = 1.5
    sigil_fill_settings.size = { key(0, 45), key(1, 45) }
    sigil_fill_settings.transparency = {
        key(0, 1), key(0.1, 0.75), key(0.2, 0.5), key(0.3, 0.4), key(0.6, 0.5), key(0.8, 0.8), key(1, 1)
    }
    sigil_fill_settings.color = { colorKey(0, 0.6, 0, 0), colorKey(1, 0.2, 0, 0) }

    -- RED CLOUD (27.5s - 31.3s)

    runes_settings = makeSettings()
    runes_settings.min_life = 3.8
    runes_settings.max_life = 3.8
    runes_settings.min_rotation_speed = 0.12
    runes_settings.max_rotation_speed = 0.12
    runes_settings.size = { key(0, 1.4), key(0.3, 1.55), key(0.6, 1.65), key(1, 1.7) }
    runes_settings.transparency = { key(0, 1), key(0.07, 0.75), key(0.14, 0.55), key(0.2, 0.5), key(1, 0.5) }
    runes_settings.color = dark_red

    cloud_halo_settings = makeSettings()
    cloud_halo_settings.min_life = 3.8
    cloud_halo_settings.max_life = 3.8
    cloud_halo_settings.min_rotation_speed = -0.1
    cloud_halo_settings.max_rotation_speed = -0.1
    cloud_halo_settings.size = { key(0, 0.4), key(0.3, 0.58), key(0.6, 0.69), key(1, 0.75) }
    cloud_halo_settings.transparency = { key(0, 1), key(0.07, 0.75), key(0.14, 0.55), key(0.2, 0.5), key(1, 0.4) }
    cloud_halo_settings.color = dark_red

    cloud_settings = makeSettings()
    cloud_settings.count = 4
    cloud_settings.min_life = 3.8
    cloud_settings.max_life = 3.8
    cloud_settings.min_rotation = 0
    cloud_settings.max_rotation = math.pi * 2
    cloud_settings.min_rotation_speed = -0.4
    cloud_settings.max_rotation_speed = 0.4
    cloud_settings.size = {
        key(0, 0.3, 0.05), key(0.25, 1.1, 0.15), key(0.5, 1.9, 0.25), key(0.75, 2.5, 0.35), key(1, 3, 0.4)
    }
    cloud_settings.transparency = { key(0, 1), key(0.05, 0.7), key(0.1, 0.5), key(0.15, 0.4), key(1, 0.3) }
    cloud_settings.color = { colorKey(0, 0.5, 0, 0), colorKey(1, 0.7, 0.05, 0.05) }

    swirl_settings = makeSettings()
    swirl_settings.min_life = 3.8
    swirl_settings.max_life = 3.8
    swirl_settings.min_rotation_speed = 1
    swirl_settings.max_rotation_speed = 1
    swirl_settings.size = { key(0, 0.2), key(0.3, 0.6), key(0.6, 1), key(1, 1.3) }
    swirl_settings.transparency = { key(0, 1), key(0.07, 0.75), key(0.14, 0.55), key(0.2, 0.5), key(1, 0.4) }
    swirl_settings.color = dark_red

    center_moon_settings = makeSettings()
    center_moon_settings.min_life = 3.8
    center_moon_settings.max_life = 3.8
    center_moon_settings.min_rotation = math.pi / 2
    center_moon_settings.max_rotation = math.pi / 2
    center_moon_settings.size = { key(0, 0.15), key(1, 0.22) }
    center_moon_settings.transparency = { key(0, 1), key(0.07, 0.6), key(0.14, 0.4), key(0.2, 0.3), key(1, 0.2) }
    center_moon_settings.color = { colorKey(0, 0.3, 0, 0), colorKey(1, 0.3, 0, 0) }

    center_line_settings = makeSettings()
    center_line_settings.min_life = 3.8
    center_line_settings.max_life = 3.8
    center_line_settings.size = { key(0, 0.8), key(1, 1.2) }
    center_line_settings.squash = { key(0, -3.5), key(1, -3.5) }
    center_line_settings.transparency = { key(0, 1), key(0.07, 0.7), key(0.14, 0.5), key(0.2, 0.4), key(1, 0.3) }
    center_line_settings.color = { colorKey(0, 0.3, 0, 0), colorKey(1, 0.3, 0, 0) }

    -- FINAL FLASH (31.3s - 35.5s)

    final_flash_settings = makeSettings()
    final_flash_settings.min_life = 4.2
    final_flash_settings.max_life = 4.2
    final_flash_settings.size = { key(0, 45), key(1, 45) }
    final_flash_settings.transparency = {
        key(0, 0), key(0.2, 0), key(0.4, 0.15), key(0.6, 0.4), key(0.8, 0.75), key(1, 1)
    }
    final_flash_settings.color = {
        colorKey(0, 1, 0, 0),
        colorKey(0.4, 0.6, 0, 0),
        colorKey(1, 0.15, 0, 0)
    }

    -- OPENING (0s - 4s): a dim clock ticking in the dark

    clock_settings = makeSettings()
    clock_settings.min_life = 4.2
    clock_settings.max_life = 4.2
    clock_settings.min_rotation_speed = 0.05
    clock_settings.max_rotation_speed = 0.05
    clock_settings.size = { key(0, 0.5), key(0.5, 0.47), key(1, 0.45) }
    clock_settings.transparency = {
        key(0, 1), key(0.1, 0.92), key(0.2, 0.85), key(0.3, 0.8),
        key(0.8, 0.8), key(0.9, 0.88), key(0.96, 0.96), key(1, 1)
    }
    clock_settings.color = { colorKey(0, 0.6, 0.6, 0.7), colorKey(1, 0.7, 0.5, 0.55) }

    numeral_ring_settings = makeSettings()
    numeral_ring_settings.min_life = 4.2
    numeral_ring_settings.max_life = 4.2
    numeral_ring_settings.min_rotation_speed = -0.03
    numeral_ring_settings.max_rotation_speed = -0.03
    numeral_ring_settings.size = { key(0, 0.75), key(0.5, 0.72), key(1, 0.7) }
    numeral_ring_settings.transparency = {
        key(0, 1), key(0.15, 0.93), key(0.3, 0.88),
        key(0.8, 0.88), key(0.92, 0.95), key(1, 1)
    }
    numeral_ring_settings.color = { colorKey(0, 0.6, 0.6, 0.7), colorKey(1, 0.7, 0.5, 0.55) }

    opening_dust_settings = makeSettings()
    opening_dust_settings.count = 30
    opening_dust_settings.rate = 6
    opening_dust_settings.spawn_spread_x = 400
    opening_dust_settings.spawn_spread_y = 300
    opening_dust_settings.spread_angle = 0.5
    opening_dust_settings.min_speed = 5
    opening_dust_settings.max_speed = 15
    opening_dust_settings.min_life = 2
    opening_dust_settings.max_life = 3
    opening_dust_settings.size = {
        key(0, 0), key(0.2, 0.008, 0.003), key(0.5, 0.01, 0.003), key(0.8, 0.008, 0.003), key(1, 0)
    }
    opening_dust_settings.transparency = { key(0, 1), key(0.3, 0.5), key(0.7, 0.5), key(1, 1) }
    opening_dust_settings.color = { colorKey(0, 0.7, 0.7, 0.8), colorKey(1, 0.7, 0.7, 0.8) }

    -- MOON EXTRAS (4s - 12s)

    -- pale halo behind the moon, same size curve as the moon times 1.6
    moon_halo_settings = makeSettings()
    moon_halo_settings.min_life = 10.5
    moon_halo_settings.max_life = 10.5
    moon_halo_settings.min_rotation_speed = 0.05
    moon_halo_settings.max_rotation_speed = 0.05
    moon_halo_settings.size = {
        key(0, 0.96), key(0.1, 0.896), key(0.2, 0.832), key(0.28, 0.8),
        key(0.2925, 0.75), key(0.305, 0.64), key(0.3175, 0.53), key(0.33, 0.48),
        key(0.5, 0.416),
        key(0.5125, 0.396), key(0.525, 0.352), key(0.5375, 0.308), key(0.55, 0.288),
        key(0.76, 0.24), key(1, 0.2)
    }
    moon_halo_settings.transparency = {
        key(0, 1), key(0.06, 0.85), key(0.12, 0.7),
        key(0.7, 0.7), key(0.74, 0.8), key(0.77, 1), key(1, 1)
    }
    moon_halo_settings.color = { colorKey(0, 0.6, 0.7, 1), colorKey(1, 0.6, 0.7, 1) }

    -- glitter slowly falling through the night sky, blinking as it falls
    moon_glitter_settings = makeSettings()
    moon_glitter_settings.count = 40
    moon_glitter_settings.rate = 6
    moon_glitter_settings.spawn_spread_x = 400
    moon_glitter_settings.spawn_spread_y = 300
    moon_glitter_settings.direction = math.pi / 2
    moon_glitter_settings.spread_angle = 0.3
    moon_glitter_settings.min_speed = 8
    moon_glitter_settings.max_speed = 20
    moon_glitter_settings.min_life = 4
    moon_glitter_settings.max_life = 6
    moon_glitter_settings.min_rotation_speed = -1
    moon_glitter_settings.max_rotation_speed = 1
    moon_glitter_settings.size = {
        key(0, 0), key(0.15, 0.012), key(0.35, 0.006), key(0.55, 0.013), key(0.75, 0.006), key(1, 0)
    }
    moon_glitter_settings.transparency = {
        key(0, 1), key(0.15, 0.3), key(0.35, 0.7), key(0.55, 0.2), key(0.75, 0.7), key(1, 1)
    }
    moon_glitter_settings.color = { colorKey(0, 0.8, 0.85, 1), colorKey(1, 0.7, 0.75, 1) }

    -- BURST EXTRA (12s - 14.5s): spinning rune circle behind the black disc

    burst_glyph_settings = makeSettings()
    burst_glyph_settings.min_life = 2.5
    burst_glyph_settings.max_life = 2.5
    burst_glyph_settings.min_rotation_speed = -0.6
    burst_glyph_settings.max_rotation_speed = -0.6
    burst_glyph_settings.size = {
        key(0, 0.1), key(0.03, 0.25), key(0.06, 0.32), key(0.1, 0.35),
        key(0.85, 0.37), key(0.9, 0.33), key(0.95, 0.25), key(1, 0.1)
    }
    burst_glyph_settings.transparency = {
        key(0, 1), key(0.05, 0.6), key(0.1, 0.4), key(0.9, 0.4), key(0.95, 0.7), key(1, 1)
    }
    burst_glyph_settings.color = red

    -- FLASH EXTRAS (14.5s): the screen cracks and glass shards fly out

    flash_cracks_settings = makeSettings()
    flash_cracks_settings.min_life = 1.2
    flash_cracks_settings.max_life = 1.2
    flash_cracks_settings.size = { key(0, 1.6), key(0.3, 1.68), key(1, 1.75) }
    flash_cracks_settings.transparency = {
        key(0, 0), key(0.2, 0.1), key(0.5, 0.5), key(0.8, 0.85), key(1, 1)
    }
    flash_cracks_settings.color = { colorKey(0, 1, 0.7, 0.7), colorKey(1, 1, 0.2, 0.2) }

    flash_shards_settings = makeSettings()
    flash_shards_settings.count = 14
    flash_shards_settings.spread_angle = math.pi
    flash_shards_settings.min_speed = 250
    flash_shards_settings.max_speed = 650
    flash_shards_settings.drag = 1.5
    flash_shards_settings.min_life = 0.8
    flash_shards_settings.max_life = 1.4
    flash_shards_settings.min_rotation = 0
    flash_shards_settings.max_rotation = math.pi * 2
    flash_shards_settings.min_rotation_speed = -6
    flash_shards_settings.max_rotation_speed = 6
    flash_shards_settings.size = {
        key(0, 0.02, 0.01), key(0.1, 0.06, 0.02), key(0.5, 0.05, 0.02), key(1, 0.03, 0.01)
    }
    flash_shards_settings.transparency = { key(0, 0), key(0.6, 0.2), key(0.85, 0.6), key(1, 1) }
    flash_shards_settings.color = { colorKey(0, 1, 0.7, 0.7), colorKey(1, 0.8, 0.1, 0.1) }

    -- BELL EXTRAS (16s - 17.6s): a red clock behind the ring,
    -- and shockwaves that pulse out like a bell striking

    bell_clock_settings = makeSettings()
    bell_clock_settings.min_life = 1.6
    bell_clock_settings.max_life = 1.6
    bell_clock_settings.min_rotation_speed = 0.8
    bell_clock_settings.max_rotation_speed = 0.8
    bell_clock_settings.size = { key(0, 0.5), key(0.1, 0.58), key(0.2, 0.62), key(1, 0.68) }
    bell_clock_settings.transparency = {
        key(0, 0.7), key(0.05, 0.4), key(0.1, 0.3), key(0.5, 0.45), key(0.8, 0.75), key(1, 1)
    }
    bell_clock_settings.color = red

    bell_waves_settings = makeSettings()
    bell_waves_settings.count = 4
    bell_waves_settings.rate = 2.5
    bell_waves_settings.min_life = 1
    bell_waves_settings.max_life = 1
    bell_waves_settings.size = { key(0, 0.2), key(0.2, 0.8), key(0.5, 1.4), key(1, 1.8) }
    bell_waves_settings.transparency = { key(0, 0.2), key(0.3, 0.4), key(0.6, 0.7), key(1, 1) }
    bell_waves_settings.color = { colorKey(0, 1, 0.4, 0.4), colorKey(1, 0.8, 0, 0) }

    -- EMBLEM EXTRAS (17.6s - 21.5s): embers rising and diamonds floating

    embers_settings = makeSettings()
    embers_settings.count = 70
    embers_settings.rate = 18
    embers_settings.spawn_y = 620
    embers_settings.spawn_spread_x = 420
    embers_settings.spread_angle = 0.3
    embers_settings.min_speed = 40
    embers_settings.max_speed = 100
    embers_settings.acceleration_y = -15
    embers_settings.min_life = 2.5
    embers_settings.max_life = 4
    embers_settings.min_rotation_speed = -3
    embers_settings.max_rotation_speed = 3
    embers_settings.size = { key(0, 0), key(0.1, 0.25, 0.08), key(0.7, 0.18, 0.06), key(1, 0) }
    embers_settings.transparency = { key(0, 1), key(0.1, 0.3), key(0.7, 0.4), key(1, 1) }
    embers_settings.color = { colorKey(0, 1, 0.45, 0.2), colorKey(1, 0.8, 0, 0) }

    float_diamonds_settings = makeSettings()
    float_diamonds_settings.count = 10
    float_diamonds_settings.rate = 2.5
    float_diamonds_settings.spawn_spread_x = 380
    float_diamonds_settings.spawn_spread_y = 260
    float_diamonds_settings.spread_angle = 0.5
    float_diamonds_settings.min_speed = 10
    float_diamonds_settings.max_speed = 25
    float_diamonds_settings.min_life = 3
    float_diamonds_settings.max_life = 4
    float_diamonds_settings.min_rotation_speed = -1
    float_diamonds_settings.max_rotation_speed = 1
    float_diamonds_settings.size = { key(0, 0), key(0.2, 0.04, 0.01), key(0.8, 0.045, 0.01), key(1, 0) }
    float_diamonds_settings.transparency = { key(0, 1), key(0.2, 0.5), key(0.8, 0.5), key(1, 1) }
    float_diamonds_settings.color = red

    -- BLACK PAUSE EXTRA (25s - 27.5s): two heartbeats ("lub-dub, lub-dub")
    -- one particle, the curves jump back to small while it's invisible
    -- and grow again for the next beat
    heart_pulse_settings = makeSettings()
    heart_pulse_settings.min_life = 3.5
    heart_pulse_settings.max_life = 3.5
    heart_pulse_settings.size = {
        key(0, 0.15), key(0.4, 0.15), key(0.43, 0.45), key(0.48, 0.7),
        key(0.49, 0.15), key(0.5, 0.15), key(0.53, 0.5), key(0.58, 0.8),
        key(0.59, 0.15), key(0.72, 0.15), key(0.75, 0.45), key(0.8, 0.7),
        key(0.81, 0.15), key(0.82, 0.15), key(0.85, 0.5), key(0.9, 0.8), key(1, 0.8)
    }
    heart_pulse_settings.transparency = {
        key(0, 1), key(0.4, 1), key(0.41, 0.35), key(0.48, 1),
        key(0.5, 1), key(0.51, 0.3), key(0.58, 1),
        key(0.72, 1), key(0.73, 0.4), key(0.8, 1),
        key(0.82, 1), key(0.83, 0.35), key(0.9, 1), key(1, 1)
    }
    heart_pulse_settings.color = red

    heart_glow_settings = makeSettings()
    heart_glow_settings.min_life = 3.5
    heart_glow_settings.max_life = 3.5
    heart_glow_settings.size = { key(0, 0.25), key(1, 0.25) }
    heart_glow_settings.transparency = {
        key(0, 1), key(0.4, 1), key(0.42, 0.5), key(0.48, 1),
        key(0.5, 1), key(0.52, 0.4), key(0.6, 1),
        key(0.72, 1), key(0.74, 0.55), key(0.8, 1),
        key(0.82, 1), key(0.84, 0.45), key(0.92, 1), key(1, 1)
    }
    heart_glow_settings.color = dark_red

    -- CLOUD EXTRAS (27.5s - 31.3s): glyph behind the cloud,
    -- and red streaks pulled into the center from 8 directions

    cloud_glyph_settings = makeSettings()
    cloud_glyph_settings.min_life = 3.8
    cloud_glyph_settings.max_life = 3.8
    cloud_glyph_settings.min_rotation_speed = 0.2
    cloud_glyph_settings.max_rotation_speed = 0.2
    cloud_glyph_settings.size = { key(0, 0.45), key(0.3, 0.57), key(0.6, 0.65), key(1, 0.7) }
    cloud_glyph_settings.transparency = { key(0, 1), key(0.1, 0.7), key(0.2, 0.55), key(1, 0.5) }
    cloud_glyph_settings.color = dark_red

    pull_objects = {}
    for i = 1, 8 do
        angle = (i - 1) / 8 * math.pi * 2
        pull_settings = makeSettings()
        pull_settings.count = 20
        pull_settings.rate = 6
        pull_settings.spawn_x = 400 + math.cos(angle) * 320
        pull_settings.spawn_y = 300 + math.sin(angle) * 320
        pull_settings.spawn_spread_x = 20
        pull_settings.spawn_spread_y = 20
        pull_settings.direction = angle + math.pi
        pull_settings.spread_angle = 0.1
        pull_settings.min_speed = 200
        pull_settings.max_speed = 260
        pull_settings.min_life = 1.2
        pull_settings.max_life = 1.4
        pull_settings.min_rotation_speed = -4
        pull_settings.max_rotation_speed = 4
        pull_settings.size = { key(0, 0), key(0.2, 0.02), key(0.8, 0.015), key(1, 0) }
        pull_settings.transparency = { key(0, 1), key(0.2, 0.3), key(0.8, 0.4), key(1, 1) }
        pull_settings.color = red
        pull_objects[i] = particleVfx.newObject("assets/star.png", pull_settings)
    end

    -- FINAL EXTRAS (31.3s): a shine burst, black cracks and dark shards over the red flash

    final_shine_settings = makeSettings()
    final_shine_settings.min_life = 1.2
    final_shine_settings.max_life = 1.2
    final_shine_settings.size = { key(0, 0.4), key(0.1, 1), key(0.4, 1.4), key(1, 1.6) }
    final_shine_settings.transparency = { key(0, 0), key(0.2, 0.2), key(0.5, 0.7), key(1, 1) }
    final_shine_settings.color = { colorKey(0, 1, 0.85, 0.85), colorKey(1, 1, 0.4, 0.4) }

    final_cracks_settings = makeSettings()
    final_cracks_settings.min_life = 3
    final_cracks_settings.max_life = 3
    final_cracks_settings.min_rotation = math.pi / 5
    final_cracks_settings.max_rotation = math.pi / 5
    final_cracks_settings.size = { key(0, 1.7), key(0.2, 1.8), key(1, 1.85) }
    final_cracks_settings.transparency = {
        key(0, 0), key(0.2, 0.1), key(0.5, 0.4), key(0.8, 0.8), key(1, 1)
    }
    final_cracks_settings.color = { colorKey(0, 0.1, 0, 0), colorKey(1, 0.1, 0, 0) }

    final_shards_settings = makeSettings()
    final_shards_settings.count = 18
    final_shards_settings.spread_angle = math.pi
    final_shards_settings.min_speed = 200
    final_shards_settings.max_speed = 600
    final_shards_settings.drag = 1.2
    final_shards_settings.min_life = 1.5
    final_shards_settings.max_life = 2.5
    final_shards_settings.min_rotation = 0
    final_shards_settings.max_rotation = math.pi * 2
    final_shards_settings.min_rotation_speed = -4
    final_shards_settings.max_rotation_speed = 4
    final_shards_settings.size = {
        key(0, 0.02, 0.01), key(0.1, 0.07, 0.02), key(0.5, 0.06, 0.02), key(1, 0.04, 0.01)
    }
    final_shards_settings.transparency = { key(0, 0), key(0.6, 0.2), key(0.85, 0.6), key(1, 1) }
    final_shards_settings.color = { colorKey(0, 0.2, 0, 0), colorKey(1, 0.1, 0, 0) }

    -- BACKGROUND EXTRAS (4s - 31.3s)

    -- broken clock pieces in two opposite corners
    -- the clock's center sits exactly on the corner, so only the arc curves into the screen
    -- they swing very slowly, start blue-grey and turn red at the flash (t = 0.385 = 14.5s)
    corner_clock_tl_settings = makeSettings()
    corner_clock_tl_settings.spawn_x = 0
    corner_clock_tl_settings.spawn_y = 0
    corner_clock_tl_settings.min_life = 27.3
    corner_clock_tl_settings.max_life = 27.3
    corner_clock_tl_settings.min_rotation = -0.2
    corner_clock_tl_settings.max_rotation = -0.2
    corner_clock_tl_settings.min_rotation_speed = 0.015
    corner_clock_tl_settings.max_rotation_speed = 0.015
    corner_clock_tl_settings.size = { key(0, 1.25), key(0.5, 1.3), key(1, 1.35) }
    corner_clock_tl_settings.transparency = {
        key(0, 1), key(0.02, 0.9), key(0.04, 0.8), key(0.06, 0.75),
        key(0.76, 0.75), key(0.78, 0.88), key(0.85, 0.88), key(0.87, 0.75),
        key(0.97, 0.75), key(1, 1)
    }
    corner_clock_tl_settings.color = {
        colorKey(0, 0.6, 0.65, 0.8), colorKey(0.36, 0.6, 0.65, 0.8),
        colorKey(0.38, 0.8, 0.3, 0.3), colorKey(0.4, 0.8, 0.1, 0.1), colorKey(1, 0.8, 0.1, 0.1)
    }

    -- same as the top-left one, but in the bottom-right corner and turned around (math.pi)
    corner_clock_br_settings = makeSettings()
    corner_clock_br_settings.spawn_x = 800
    corner_clock_br_settings.spawn_y = 600
    corner_clock_br_settings.min_life = 27.3
    corner_clock_br_settings.max_life = 27.3
    corner_clock_br_settings.min_rotation = math.pi - 0.2
    corner_clock_br_settings.max_rotation = math.pi - 0.2
    corner_clock_br_settings.min_rotation_speed = 0.015
    corner_clock_br_settings.max_rotation_speed = 0.015
    corner_clock_br_settings.size = corner_clock_tl_settings.size
    corner_clock_br_settings.transparency = corner_clock_tl_settings.transparency
    corner_clock_br_settings.color = corner_clock_tl_settings.color

    -- dark red fog drifting in the same two corners (after the flash)
    corner_fog_tl_settings = makeSettings()
    corner_fog_tl_settings.count = 8
    corner_fog_tl_settings.rate = 1.2
    corner_fog_tl_settings.spawn_x = 60
    corner_fog_tl_settings.spawn_y = 60
    corner_fog_tl_settings.spawn_spread_x = 80
    corner_fog_tl_settings.spawn_spread_y = 80
    corner_fog_tl_settings.spread_angle = math.pi
    corner_fog_tl_settings.min_speed = 5
    corner_fog_tl_settings.max_speed = 15
    corner_fog_tl_settings.min_life = 5
    corner_fog_tl_settings.max_life = 7
    corner_fog_tl_settings.min_rotation = 0
    corner_fog_tl_settings.max_rotation = math.pi * 2
    corner_fog_tl_settings.min_rotation_speed = -0.15
    corner_fog_tl_settings.max_rotation_speed = 0.15
    corner_fog_tl_settings.size = { key(0, 0.5, 0.1), key(0.5, 0.7, 0.15), key(1, 0.8, 0.15) }
    corner_fog_tl_settings.transparency = {
        key(0, 1), key(0.15, 0.85), key(0.3, 0.75), key(0.7, 0.75), key(0.85, 0.85), key(1, 1)
    }
    corner_fog_tl_settings.color = { colorKey(0, 0.6, 0, 0), colorKey(1, 0.35, 0, 0) }

    corner_fog_br_settings = makeSettings()
    corner_fog_br_settings.count = 8
    corner_fog_br_settings.rate = 1.2
    corner_fog_br_settings.spawn_x = 740
    corner_fog_br_settings.spawn_y = 540
    corner_fog_br_settings.spawn_spread_x = 80
    corner_fog_br_settings.spawn_spread_y = 80
    corner_fog_br_settings.spread_angle = math.pi
    corner_fog_br_settings.min_speed = 5
    corner_fog_br_settings.max_speed = 15
    corner_fog_br_settings.min_life = 5
    corner_fog_br_settings.max_life = 7
    corner_fog_br_settings.min_rotation = 0
    corner_fog_br_settings.max_rotation = math.pi * 2
    corner_fog_br_settings.min_rotation_speed = -0.15
    corner_fog_br_settings.max_rotation_speed = 0.15
    corner_fog_br_settings.size = corner_fog_tl_settings.size
    corner_fog_br_settings.transparency = corner_fog_tl_settings.transparency
    corner_fog_br_settings.color = corner_fog_tl_settings.color

    -- faint shapes drifting behind everything in the dark red scenes, like soft light spots
    bg_hexagons_settings = makeSettings()
    bg_hexagons_settings.count = 6
    bg_hexagons_settings.rate = 0.8
    bg_hexagons_settings.spawn_spread_x = 380
    bg_hexagons_settings.spawn_spread_y = 280
    bg_hexagons_settings.spread_angle = math.pi
    bg_hexagons_settings.min_speed = 5
    bg_hexagons_settings.max_speed = 15
    bg_hexagons_settings.min_life = 5
    bg_hexagons_settings.max_life = 7
    bg_hexagons_settings.min_rotation = 0
    bg_hexagons_settings.max_rotation = math.pi * 2
    bg_hexagons_settings.min_rotation_speed = -0.15
    bg_hexagons_settings.max_rotation_speed = 0.15
    bg_hexagons_settings.size = { key(0, 0.35, 0.1), key(0.5, 0.42, 0.12), key(1, 0.48, 0.12) }
    bg_hexagons_settings.transparency = {
        key(0, 1), key(0.15, 0.97), key(0.3, 0.94), key(0.7, 0.94), key(0.85, 0.97), key(1, 1)
    }
    bg_hexagons_settings.color = red

    bg_octagons_settings = makeSettings()
    bg_octagons_settings.count = 6
    bg_octagons_settings.rate = 0.6
    bg_octagons_settings.spawn_spread_x = 380
    bg_octagons_settings.spawn_spread_y = 280
    bg_octagons_settings.spread_angle = math.pi
    bg_octagons_settings.min_speed = 5
    bg_octagons_settings.max_speed = 15
    bg_octagons_settings.min_life = 5
    bg_octagons_settings.max_life = 7
    bg_octagons_settings.min_rotation = 0
    bg_octagons_settings.max_rotation = math.pi * 2
    bg_octagons_settings.min_rotation_speed = -0.1
    bg_octagons_settings.max_rotation_speed = 0.1
    bg_octagons_settings.size = { key(0, 0.25, 0.08), key(0.5, 0.3, 0.1), key(1, 0.35, 0.1) }
    bg_octagons_settings.transparency = bg_hexagons_settings.transparency
    bg_octagons_settings.color = red

    stars = particleVfx.newObject("assets/Specs.png", stars_settings)
    stars2 = particleVfx.newObject("assets/Specs.png", stars2_settings)
    moon_line = particleVfx.newObject("assets/square.png", moon_line_settings)
    moon = particleVfx.newObject("assets/Moon.png", moon_settings)
    moon_shadow = particleVfx.newObject("assets/Moon.png", moon_shadow_settings)
    red_glow = particleVfx.newObject("assets/impact_debrislight.png", red_glow_settings)
    red_rays = particleVfx.newObject("assets/Flare.png", red_rays_settings)
    red_glare = particleVfx.newObject("assets/Glare.png", red_glare_settings)
    burst_fog = particleVfx.newObject("assets/fog.png", burst_fog_settings)
    burst_stars = particleVfx.newObject("assets/star.png", burst_stars_settings)
    white_flash = particleVfx.newObject("assets/square.png", white_flash_settings)
    red_screen = particleVfx.newObject("assets/square.png", red_screen_settings)
    pythios_flash = particleVfx.newObject("assets/Pythios.png", pythios_flash_settings)
    ritual = particleVfx.newObject("assets/Ritual.png", ritual_settings)
    explode_fog = particleVfx.newObject("assets/fog.png", explode_fog_settings)
    big_ring = particleVfx.newObject("assets/impact_circle.png", big_ring_settings)
    ring_fog = particleVfx.newObject("assets/CrackShadow.png", ring_fog_settings)
    spiky_star = particleVfx.newObject("assets/Spawn.png", spiky_star_settings)
    red_line = particleVfx.newObject("assets/square.png", red_line_settings)
    red_bg = particleVfx.newObject("assets/square.png", red_bg_settings)
    bg_fog = particleVfx.newObject("assets/fog.png", bg_fog_settings)
    emblem_ring = particleVfx.newObject("assets/Halo.png", emblem_ring_settings)
    emblem_moon = particleVfx.newObject("assets/Remembrance.png", emblem_moon_settings)
    sigil_glow = particleVfx.newObject("assets/impact_debrislight.png", sigil_glow_settings)
    sigil_halo = particleVfx.newObject("assets/Halo.png", sigil_halo_settings)
    sigil = particleVfx.newObject("assets/Pythios.png", sigil_settings)
    sigil_fill = particleVfx.newObject("assets/square.png", sigil_fill_settings)
    runes = particleVfx.newObject("assets/Runes.png", runes_settings)
    cloud_halo = particleVfx.newObject("assets/Halo.png", cloud_halo_settings)
    cloud = particleVfx.newObject("assets/CrackShadow.png", cloud_settings)
    swirl = particleVfx.newObject("assets/SwirlFog.png", swirl_settings)
    center_line = particleVfx.newObject("assets/square.png", center_line_settings)
    center_moon = particleVfx.newObject("assets/Remembrance.png", center_moon_settings)
    final_flash = particleVfx.newObject("assets/square.png", final_flash_settings)

    -- extra effects
    clock = particleVfx.newObject("assets/Clock.png", clock_settings)
    numeral_ring = particleVfx.newObject("assets/NumeralRing.png", numeral_ring_settings)
    opening_dust = particleVfx.newObject("assets/star.png", opening_dust_settings)
    moon_halo = particleVfx.newObject("assets/Shine.png", moon_halo_settings)
    moon_glitter = particleVfx.newObject("assets/star.png", moon_glitter_settings)
    burst_glyph = particleVfx.newObject("assets/glyph_outline.png", burst_glyph_settings)
    flash_cracks = particleVfx.newObject("assets/Cracks.png", flash_cracks_settings)
    flash_shards = particleVfx.newObject("assets/Shard.png", flash_shards_settings)
    bell_clock = particleVfx.newObject("assets/Clock.png", bell_clock_settings)
    bell_waves = particleVfx.newObject("assets/impact_circle.png", bell_waves_settings)
    embers = particleVfx.newObject("assets/square.png", embers_settings)
    float_diamonds = particleVfx.newObject("assets/Diamond.png", float_diamonds_settings)
    heart_pulse = particleVfx.newObject("assets/impact_circle.png", heart_pulse_settings)
    heart_glow = particleVfx.newObject("assets/impact_debrislight.png", heart_glow_settings)
    cloud_glyph = particleVfx.newObject("assets/glyph.png", cloud_glyph_settings)
    final_shine = particleVfx.newObject("assets/Shine.png", final_shine_settings)
    final_cracks = particleVfx.newObject("assets/Cracks.png", final_cracks_settings)
    final_shards = particleVfx.newObject("assets/Shard.png", final_shards_settings)
    corner_clock_tl = particleVfx.newObject("assets/HalfBrokenClock.png", corner_clock_tl_settings)
    corner_clock_br = particleVfx.newObject("assets/HalfBrokenClock.png", corner_clock_br_settings)
    corner_fog_tl = particleVfx.newObject("assets/fog.png", corner_fog_tl_settings)
    corner_fog_br = particleVfx.newObject("assets/fog.png", corner_fog_br_settings)
    bg_hexagons = particleVfx.newObject("assets/Hexagon.png", bg_hexagons_settings)
    bg_octagons = particleVfx.newObject("assets/Octagon.png", bg_octagons_settings)

    -- list order = draw order (first in list is drawn at the back)
    particleVfx.particle_objects = {
        corner_fog_tl, corner_fog_br, bg_hexagons, bg_octagons, corner_clock_tl, corner_clock_br,
        clock, numeral_ring, opening_dust,
        stars, stars2, moon_glitter, moon_halo,
        burst_fog, burst_stars, red_rays, red_glow, red_glare, burst_glyph,
        moon_line, moon_shadow, moon
    }

    for i = 1, #sparkle_objects do
        particleVfx.particle_objects[#particleVfx.particle_objects + 1] = sparkle_objects[i]
    end

    for i = 1, #pull_objects do
        particleVfx.particle_objects[#particleVfx.particle_objects + 1] = pull_objects[i]
    end

    top_objects = {
        red_screen, explode_fog, ritual, pythios_flash, flash_cracks, flash_shards,
        bell_clock, ring_fog, bell_waves, big_ring, red_line, spiky_star,
        red_bg, bg_fog, embers, float_diamonds, emblem_ring, emblem_moon,
        sigil_glow, sigil_halo, sigil, sigil_fill,
        heart_glow, heart_pulse,
        cloud_glyph, runes, cloud_halo, cloud, swirl, center_line, center_moon,
        final_flash, final_shine, final_cracks, final_shards, white_flash
    }

    for i = 1, #top_objects do
        particleVfx.particle_objects[#particleVfx.particle_objects + 1] = top_objects[i]
    end

    -- the original video's audio, so every stage time below lines up with it
    music = love.audio.newSource("assets/rfm-audio.mp3", "stream")
    music:play()

    -- TEXT
    -- the text is not a particle, so it is drawn in love.draw
    -- these curves use seconds (effect_time) as their time instead of particle age,
    -- and the value is how visible the text is (0 = hidden, 1 = fully visible)

    subtitle_font = love.graphics.newFont("assets/Fondamento/Fondamento-Italic.ttf", 20)
    title_font = love.graphics.newFont("assets/Fondamento/Fondamento-Italic.ttf", 34)

    -- Fondamento has no Japanese letters, so Japanese uses Shippori Mincho
    jp_subtitle_font = love.graphics.newFont("assets/ShipporiMincho/ShipporiMincho-Regular.ttf", 18)
    jp_title_font = love.graphics.newFont("assets/ShipporiMincho/ShipporiMincho-Regular.ttf", 44)
    jp_chosen_font = love.graphics.newFont("assets/ShipporiMincho/ShipporiMincho-Regular.ttf", 30)
    jp_big_font = love.graphics.newFont("assets/ShipporiMincho/ShipporiMincho-Regular.ttf", 170)
    jp_huge_font = love.graphics.newFont("assets/ShipporiMincho/ShipporiMincho-Regular.ttf", 260)

    world_text = "A World Bathed in Moonlight"
    world_alpha = {
        key(6.0, 0), key(6.3, 0.35), key(6.6, 0.75), key(6.8, 0.95), key(7.0, 1),
        key(9.0, 1), key(9.2, 0.75), key(9.4, 0.3), key(9.6, 0)
    }

    moon_text = "A full moon hung in the night sky."
    -- how many letters are shown, so the line "types" itself out (fast first, then slower)
    moon_letters = {
        key(9.6, 0), key(9.9, 14), key(10.2, 25), key(10.5, 31), key(10.8, 34)
    }
    moon_alpha = {
        key(9.6, 1), key(12.2, 1), key(12.5, 0.6), key(12.8, 0.15), key(13.0, 0)
    }

    bell_text = "Hell's bell sounds in time with midnight"
    bell_alpha = {
        key(14.8, 0), key(15.0, 0.3), key(15.2, 0.7), key(15.4, 1),
        key(17.0, 1), key(17.2, 0.7), key(17.4, 0.3), key(17.6, 0)
    }

    -- Japanese subtitles (shown under the English ones, same fade curves)
    world_jp = "月の光に照らされた世界"
    moon_jp = "夜空には満月が浮かんでいた"
    bell_jp = "地獄の鐘が真夜中に合わせて鳴り響く"

    -- big 赤 (red) on the left and 月 (moon) on the right, fully on screen,
    -- slowly sliding toward the moon
    red_moon_alpha = {
        key(10.4, 0), key(10.7, 0.25), key(11.0, 0.45), key(11.2, 0.5),
        key(12.0, 0.5), key(12.2, 0.3), key(12.4, 0.1), key(12.5, 0)
    }
    red_kanji_x = { key(10.4, 20), key(11.0, 50), key(11.6, 65), key(12.5, 75) }
    moon_kanji_x = { key(10.4, 610), key(11.0, 580), key(11.6, 565), key(12.5, 555) }

    -- "you have been chosen", spaced out over the moon emblem
    chosen_jp = "貴 方 は 選 ば れ ま し た"
    chosen_alpha = {
        key(18.2, 0), key(18.5, 0.4), key(18.8, 0.8), key(19.0, 1),
        key(21.0, 1), key(21.2, 0.6), key(21.4, 0.2), key(21.5, 0)
    }

    -- huge dark 赤 behind the sigil
    sigil_kanji_alpha = {
        key(21.6, 0), key(21.9, 0.3), key(22.2, 0.55), key(22.4, 0.6),
        key(24.2, 0.6), key(24.5, 0.3), key(24.8, 0)
    }

    title_jp = "赤い満月"

    title_text = "The Red Full Moon"
    title_alpha = {
        key(28.3, 0), key(28.6, 0.25), key(28.9, 0.6), key(29.2, 0.9), key(29.5, 1),
        key(31.0, 1), key(31.2, 0.4), key(31.3, 0)
    }

    -- opening clock starts right away
    particleVfx.emit(clock)
    particleVfx.emit(numeral_ring)
    opening_dust.settings.enabled = true

    effect_time = 0
    effect_stage = 0
end

function love.update(dt)
    effect_time = effect_time + 1 / 60


    if effect_stage == 0 and effect_time >= 4.0 then
        -- moon appears
        particleVfx.emit(stars)
        particleVfx.emit(stars2)
        particleVfx.emit(moon_line)
        particleVfx.emit(moon)
        particleVfx.emit(moon_halo)
        particleVfx.emit(corner_clock_tl)
        particleVfx.emit(corner_clock_br)
        opening_dust.settings.enabled = false
        moon_glitter.settings.enabled = true
        effect_stage = 1
    elseif effect_stage == 1 and effect_time >= 12.0 then
        -- red burst around the moon
        particleVfx.emit(moon_shadow)
        particleVfx.emit(red_glow)
        particleVfx.emit(red_rays)
        particleVfx.emit(red_glare)
        for i = 1, #sparkle_objects do
            particleVfx.emit(sparkle_objects[i])
        end
        particleVfx.emit(burst_fog)
        burst_stars.settings.enabled = true
        particleVfx.emit(burst_glyph)
        moon_glitter.settings.enabled = false
        effect_stage = 2
    elseif effect_stage == 2 and effect_time >= 14.5 then
        -- flash, then the red explosion
        particleVfx.emit(white_flash)
        particleVfx.emit(red_screen)
        particleVfx.emit(pythios_flash)
        particleVfx.emit(ritual)
        particleVfx.emit(explode_fog)
        burst_stars.settings.enabled = false
        particleVfx.emit(flash_cracks)
        particleVfx.emit(flash_shards)
        corner_fog_tl.settings.enabled = true
        corner_fog_br.settings.enabled = true
        effect_stage = 3
    elseif effect_stage == 3 and effect_time >= 16.0 then
        -- big red ring with the spiky star
        particleVfx.emit(ring_fog)
        particleVfx.emit(big_ring)
        particleVfx.emit(red_line)
        particleVfx.emit(spiky_star)
        particleVfx.emit(bell_clock)
        bell_waves.settings.enabled = true
        bg_hexagons.settings.enabled = true
        bg_octagons.settings.enabled = true
        effect_stage = 4
    elseif effect_stage == 4 and effect_time >= 17.6 then
        -- red fog screen with the moon emblem
        particleVfx.emit(red_bg)
        particleVfx.emit(bg_fog)
        particleVfx.emit(emblem_ring)
        particleVfx.emit(emblem_moon)
        bell_waves.settings.enabled = false
        embers.settings.enabled = true
        float_diamonds.settings.enabled = true
        effect_stage = 5
    elseif effect_stage == 5 and effect_time >= 21.5 then
        -- sigil zooming in
        particleVfx.emit(sigil_glow)
        particleVfx.emit(sigil_halo)
        particleVfx.emit(sigil)
        embers.settings.enabled = false
        float_diamonds.settings.enabled = false
        effect_stage = 6
    elseif effect_stage == 6 and effect_time >= 24.0 then
        -- red wash over the sigil before the black pause
        particleVfx.emit(sigil_fill)
        particleVfx.emit(heart_glow)
        particleVfx.emit(heart_pulse)
        effect_stage = 7
    elseif effect_stage == 7 and effect_time >= 27.5 then
        -- rune ring and the growing red cloud
        particleVfx.emit(runes)
        particleVfx.emit(cloud_halo)
        particleVfx.emit(cloud)
        particleVfx.emit(swirl)
        particleVfx.emit(center_line)
        particleVfx.emit(center_moon)
        particleVfx.emit(cloud_glyph)
        for i = 1, #pull_objects do
            pull_objects[i].settings.enabled = true
        end
        effect_stage = 8
    elseif effect_stage == 8 and effect_time >= 31.3 then
        -- final red flash, fades to black
        particleVfx.emit(final_flash)
        particleVfx.emit(final_shine)
        particleVfx.emit(final_cracks)
        particleVfx.emit(final_shards)
        corner_fog_tl.settings.enabled = false
        corner_fog_br.settings.enabled = false
        bg_hexagons.settings.enabled = false
        bg_octagons.settings.enabled = false
        for i = 1, #pull_objects do
            pull_objects[i].settings.enabled = false
        end
        effect_stage = 9
    end

    particleVfx.update(dt)
end

function love.draw()
    -- huge 赤 is drawn BEFORE the particles so the sigil appears in front of it
    love.graphics.setFont(jp_huge_font)
    love.graphics.setColor(0.4, 0, 0, particleVfx.sample(sigil_kanji_alpha, effect_time, "value"))
    love.graphics.printf("赤", 0, 300 - 190, 800, "center")

    particleVfx.draw()

    -- TEXT (drawn on top of the particles)
    -- particleVfx.sample reads a curve, here at the current time in seconds

    -- grey subtitle under the moon
    world_visible = particleVfx.sample(world_alpha, effect_time, "value")
    love.graphics.setColor(0.75, 0.75, 0.8, world_visible)
    love.graphics.setFont(subtitle_font)
    love.graphics.printf(world_text, 0, 500, 800, "center")
    love.graphics.setFont(jp_subtitle_font)
    love.graphics.printf(world_jp, 0, 528, 800, "center")

    -- typing subtitle: string.sub cuts the text down to the first few letters
    moon_letter_count = math.floor(particleVfx.sample(moon_letters, effect_time, "value"))
    moon_visible = particleVfx.sample(moon_alpha, effect_time, "value")
    love.graphics.setColor(0.75, 0.75, 0.8, moon_visible)
    love.graphics.setFont(subtitle_font)
    love.graphics.printf(string.sub(moon_text, 1, moon_letter_count), 0, 500, 800, "center")
    -- the Japanese line only shows once the English one has started typing
    if moon_letter_count > 0 then
        love.graphics.setFont(jp_subtitle_font)
        love.graphics.printf(moon_jp, 0, 528, 800, "center")
    end

    -- big 赤 and 月 on the sides of the screen
    red_moon_visible = particleVfx.sample(red_moon_alpha, effect_time, "value")
    love.graphics.setFont(jp_big_font)
    love.graphics.setColor(0.45, 0, 0, red_moon_visible)
    love.graphics.print("赤", particleVfx.sample(red_kanji_x, effect_time, "value"), 300 - 120)
    love.graphics.print("月", particleVfx.sample(moon_kanji_x, effect_time, "value"), 300 - 120)

    -- light red subtitle during the ring
    bell_visible = particleVfx.sample(bell_alpha, effect_time, "value")
    love.graphics.setColor(1, 0.35, 0.35, bell_visible)
    love.graphics.setFont(subtitle_font)
    love.graphics.printf(bell_text, 0, 500, 800, "center")
    love.graphics.setFont(jp_subtitle_font)
    love.graphics.printf(bell_jp, 0, 528, 800, "center")

    -- "you have been chosen" across the emblem, dark red on the red fog
    chosen_visible = particleVfx.sample(chosen_alpha, effect_time, "value")
    love.graphics.setFont(jp_chosen_font)
    love.graphics.setColor(0.25, 0, 0, chosen_visible)
    love.graphics.printf(chosen_jp, 0, 300 - 20, 800, "center")

    -- dark title in the middle of the red cloud (English above, Japanese below)
    title_visible = particleVfx.sample(title_alpha, effect_time, "value")
    love.graphics.setColor(0.15, 0, 0, title_visible)
    love.graphics.setFont(title_font)
    love.graphics.printf(title_text, 0, 300 - 62, 800, "center")
    love.graphics.setFont(jp_title_font)
    love.graphics.printf(title_jp, 0, 300 - 24, 800, "center")
end
