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

    glyph = particleVfx.newObject("assets/glyph.png", glyph_settings)

    particleVfx.particle_objects = {
        glyph
    }

    cast_sound = love.audio.newSource("assets/sounds/cast.ogg", "static")

    cast_sound:play()
    effect_time = 0
    effect_stage = 0
    particleVfx.emit(glyph)
end

function love.update(dt)
    effect_time = effect_time + 1 / 60

    if effect_stage == 0 and effect_time >= 1.6 then
        effect_stage = 1
    elseif effect_stage == 1 and effect_time >= 2.0 then
        effect_stage = 2
    end
    
    particleVfx.update(dt)
end

function love.draw()
    particleVfx.draw()
end
