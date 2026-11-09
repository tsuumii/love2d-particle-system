-- particle_objects: list of emitters
-- particle_object: one emitter (settings, image, and a pool of particles)
-- particles[i]: one particle: (x, y, vx, vy, life, rotation...)

-- 1. newObject: builds a fixed pool of "dead" particles
-- 2. emit: finds "dead" ones and brings them to life with random starting values (reset_particle).
-- 3. update: moves live ones every frame and counts down their life. (die at 0)
-- 4. draw: draws each live particle.
-- 5. dead particle sits in the pool until emit reuses it.

-----------------------------------------------------------------------------------------------------
-- AI credits:
-----------------------------------------------------------------------------------------------------
-- helped think of a solution of how to recreate curves:
-- turn a list of keys into a graph, sample connects the points with straight lines 
-- sampleNumber = slightly different curve for each particle
-- helped think of a way to keep particle pools in a fixed size:
-- alive/dead particles, emit() finds dead ones and resets them to alive with random starting values
-----------------------------------------------------------------------------------------------------

local particleVfx = {}

-- put keys together in a list to make a curve for each property
-- reads the curve (keys in a list) with sample() or sampleNumber()

-- key:
-- make 1 number per curve point
function particleVfx.key(time, value, envelope)
    if envelope == nil then
        envelope = 0
    end

    return { time = time, value = value, envelope = envelope }
end

-- colorKey:
-- same idea, instead of a single value, store R, G and B per curve point
function particleVfx.colorKey(time, red, green, blue)
    return { time = time, red = red, green = green, blue = blue }
end

-- sample reads a curve at time t
-- field = which value to read: "value", "envelope", "red", "green" or "blue".
-- a[field] is the same as a.value when field is "value", so one function handles BOTH numbers and colors

function particleVfx.sample(sequence, t, field)
    -- t at or before first key = return first key value
    if t <= sequence[1].time then
        return sequence[1][field]
    end

    -- read all the keys from the second one
    for i = 2, #sequence do
        local a = sequence[i - 1] -- previous key
        local b = sequence[i] -- current key
        if t <= b.time then -- t not past b, t sits between a and b

            -- return a straight line between two keys
            -- k = progress from a to b (0 -> 1)
            local k = (t - a.time) / (b.time - a.time)
            return a[field] + (b[field] - a[field]) * k
        end
    end

    -- t past last key = return last key value
    return sequence[#sequence][field]
end

-- sampleNumber = value + seed * envelope
-- seed is a random number from -1 to 1 picked once per particle when it spawns,
-- used in envelope (sets how far each particle can "stray" from the curve)
-- so each particle draws a slightly different curve.

function particleVfx.sampleNumber(sequence, t, seed)
    return particleVfx.sample(sequence, t, "value")
        + seed * particleVfx.sample(sequence, t, "envelope")
end

-- reset_particle = set particle to alive and rolling all its random starting values.

function particleVfx.reset_particle(particle, settings)
    particle.alive = true

    -- spawn point plus a random offset of up to spawn_spread in each direction
    particle.x = settings.spawn_x
        + (math.random() * 2 - 1) * settings.spawn_spread_x
    particle.y = settings.spawn_y
        + (math.random() * 2 - 1) * settings.spawn_spread_y

    -- velocity from an angle:
    -- cos and sin (makes angle to length 1) times speed = velocity.
    -- spread_angle = how far each side of direction the particle can go (math.pi = any direction),

    local angle = settings.direction
        + (math.random() * 2 - 1) * settings.spread_angle
    local speed = settings.min_speed
        + math.random() * (settings.max_speed - settings.min_speed)
    particle.vx = math.cos(angle) * speed
    particle.vy = math.sin(angle) * speed

    -- random life between min_life and max_life.
    particle.life = settings.min_life
        + math.random() * (settings.max_life - settings.min_life)
    particle.max_life = particle.life

    -- one seed per curve, each -1 to 1, used for the envelope
    particle.size_seed = math.random() * 2 - 1
    particle.transparency_seed = math.random() * 2 - 1
    particle.squash_seed = math.random() * 2 - 1

    particle.rotation = settings.min_rotation
        + math.random() * (settings.max_rotation - settings.min_rotation)
    particle.rotation_speed = settings.min_rotation_speed
        + math.random() * (settings.max_rotation_speed - settings.min_rotation_speed)
end

function particleVfx.newObject(image_path, settings)
    -- load image
    local image = love.graphics.newImage(image_path)

    -- build emitter
    -- settings, pool size, spawn rate, empty particle list, image
    local particle_object = {
        settings = settings,
        max_count = settings.count, 
        rate_counter = 0,          
        particles = {},
        image = image,

        -- set origin to image center
        origin_x = image:getWidth() / 2,
        origin_y = image:getHeight() / 2
    }

    -- fill the list with dead particles
    for i = 1, particle_object.max_count do
        particle_object.particles[i] = { alive = false }
    end

    return particle_object
end

-- sets particle to alive and gives its starting value
-- if count = nil, emit all dead particles

function particleVfx.emit(particle_object, count)
    -- default: use the full pool
    if count == nil then
        count = particle_object.max_count
    end

    -- count spawned so far
    local spawned = 0

    -- scan the pool for dead particles, reset them to alive and give them starting values
    for i = 1, particle_object.max_count do
        local particle = particle_object.particles[i]
        if spawned < count and not particle.alive then
            particleVfx.reset_particle(particle, particle_object.settings)
            spawned = spawned + 1
        end
    end
end

-- only changes emitter spawnpoint
function particleVfx.setPosition(particle_object, x, y)
    particle_object.settings.spawn_x = x
    particle_object.settings.spawn_y = y
end

-- set all particle to dead
function particleVfx.clear(particle_object)
    for i = 1, particle_object.max_count do
        particle_object.particles[i].alive = false
    end
end

-- creates the empty particle_objects list
function particleVfx.load()
    particleVfx.particle_objects = {}
end

function particleVfx.update(dt)
    local fps = 1 / 60

    -- loop emitters and grab each one's settings
    for object_index = 1, #particleVfx.particle_objects do
        local particle_object = particleVfx.particle_objects[object_index]
        local settings = particle_object.settings

        -- spawn particles only if enabled and rate > 0
        if settings.enabled and settings.rate > 0 then

            -- add this frame's spawn amount to the counter and add the decimal from last frame
            particle_object.rate_counter = particle_object.rate_counter + settings.rate * fps

            -- spawn_count = how many whole particles to spawn this frame
            local spawn_count = math.floor(particle_object.rate_counter)

            -- subtract the whole particles from the counter and leaving the decimal for next frame
            particle_object.rate_counter = particle_object.rate_counter - spawn_count
            particleVfx.emit(particle_object, spawn_count)
        end

        local drag_multiplier = 0.5 ^ (settings.drag * fps)

        -- loop through particle pool
        for particle_index = 1, particle_object.max_count do
            local particle = particle_object.particles[particle_index]

            -- skip dead particles
            if particle.alive then

                -- apply acceleration to velocity
                particle.vx = particle.vx + settings.acceleration_x * fps
                particle.vy = particle.vy + settings.acceleration_y * fps

                -- apply drag (air resistance) to velocity
                particle.vx = particle.vx * drag_multiplier
                particle.vy = particle.vy * drag_multiplier

                -- move by velocity
                particle.x = particle.x + particle.vx * fps
                particle.y = particle.y + particle.vy * fps

                -- turn by spin speed
                particle.rotation = particle.rotation + particle.rotation_speed * fps

                -- subtract frame time from life
                particle.life = particle.life - fps

                -- life at 0 or less, mark as dead
                if particle.life <= 0 then
                    particle.alive = false
                end
            end
        end
    end

    if dt < fps then
        love.timer.sleep(fps - dt)
    end
end

-- draws every live particle of every emitter.
function particleVfx.draw()
    -- loop emitters
    for object_index = 1, #particleVfx.particle_objects do
        -- grab each emitter's settings
        local particle_object = particleVfx.particle_objects[object_index]
        local settings = particle_object.settings

        -- loop through particle pool
        for particle_index = 1, particle_object.max_count do
            local particle = particle_object.particles[particle_index]

            -- skip dead ones
            if particle.alive then

                -- t = age ratio (0 = just spawned, 1 = dead)
                -- this is the time axis of every curve.
                local t = 1 - particle.life / particle.max_life

                -- read the curves at t
                -- each has their own seed
                local size = particleVfx.sampleNumber(
                    settings.size, t, particle.size_seed
                )
                local transparency = particleVfx.sampleNumber(
                    settings.transparency, t, particle.transparency_seed
                )
                local squash = particleVfx.sampleNumber(
                    settings.squash, t, particle.squash_seed
                )
                
                -- apply transparency to alpha
                local alpha = 1 - transparency
                -- make sure transparency stays between 0 and 1,
                -- envelope (particleVfx.sampleNumber) can make it go below 0 or above 1
                -- clamp alpha to 0-1
                alpha = math.max(0, math.min(alpha, 1))

                love.graphics.setColor(
                    particleVfx.sample(settings.color, t, "red"),
                    particleVfx.sample(settings.color, t, "green"),
                    particleVfx.sample(settings.color, t, "blue"),
                    alpha
                )

                -- squash = 0  -> drawn normally
                -- squash = 1  -> half as wide, twice as tall
                -- squash = -1 -> twice as wide, half as tall
                love.graphics.draw(
                    particle_object.image,
                    particle.x,
                    particle.y,
                    particle.rotation,
                    size / 2 ^ squash, -- x scale
                    size * 2 ^ squash, -- y scale
                    particle_object.origin_x,
                    particle_object.origin_y
                )
            end
        end
    end
end

return particleVfx
