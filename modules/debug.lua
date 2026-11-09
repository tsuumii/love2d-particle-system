local debugModule = {}

-- edit this to change the tracked properties
local watched_properties = { "x", "y" }

-- do not uncomment this, this will kill your device.
-- local watched_properties = { "x", "y", "vx", "vy", "life", "max_life", "rotation", "rotation_speed", "size_seed", "transparency_seed", "squash_seed" }

local debug_text
local debug_count
local debug_visible
local key_was_down

function debugModule.setupDebug()
    debug_text = ""
    debug_count = 0
    debug_visible = false
    key_was_down = false
end

function debugModule.addDebug(text)
    -- this whole chunk of code is literally in the slides, do i really need to comment this?
    debug_text = text .. "\n" .. debug_text
    debug_count = debug_count + 1

    if debug_count > 1000 then
        debug_count = 0
        debug_text = ""
    end
end

-- adds one line for one particle
function debugModule.addParticle(name, particle_object, particle_index)
    -- for one specific particle in emitter (particle_object):
    local particle = particle_object.particles[particle_index]

    -- if particle is dead, do not send anything
    if not particle.alive then
        return
    end

    -- text represents the whole string, but this is in case we keep track of multiple properties
    local text = name .. " #" .. particle_index

    -- for each property in watched_properties (currently, only x and y), add it to the text
    for i = 1, #watched_properties do
        local property = watched_properties[i]
        text = text .. " | " .. property .. ":" .. particle[property]
    end

    -- end result should be something like this:
    -- "particle_name #index | property1: value1 | property2: value2 ..."

    debugModule.addDebug(text)
end

function debugModule.drawDebug()
    
    -- panel flickers because .isDown("/") is checked every frame

    -- if love.keyboard.isDown("/") then
    --     debug_visible = not debug_visible
    -- end

    -- only flip the state on the frame the key goes down to prevent panel flickering
    if love.keyboard.isDown("/") and not key_was_down then
        debug_visible = not debug_visible
    end
    key_was_down = love.keyboard.isDown("/")

    -- black box covered the entire text cuz wrong layering
 
    -- if debug_visible then
    --     love.graphics.setColor(1, 1, 1, 1)
    --     love.graphics.print(debug_text, 0, 0)
    --
    --     love.graphics.setColor(0, 0, 0, 0.7)
    --     love.graphics.rectangle("fill", 0, 0, 350, love.graphics.getHeight())
    -- end

    -- draw the layer first, not the black box
    if debug_visible then
        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle("fill", 0, 0, 350, love.graphics.getHeight())

        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print(debug_text, 0, 0)
    end
end

return debugModule
