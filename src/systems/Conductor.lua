local conductor = Tiny.processingSystem()

local music = love.audio.newSource("music/song_looping.wav", "stream")
local bpm = 100.0
local quarter = 60.0 / bpm
local song_position = 0
local last_beat = -1
local beat_num = 0
local trigger = false
local crotchet = 0

conductor.filter = Tiny.requireAll("beat", "loop_length", "loop_hits")

function conductor:onAddToWorld()
    music:setLooping(true)
    music:play()
end

function conductor:preProcess()
    song_position = music:tell("seconds")
    if last_beat == -1 then
        trigger = true
        last_beat = 0
        crotchet = 0
    end
    if last_beat > song_position then --resets "last_beat" after song loops back to the start
        last_beat = 0
        crotchet = 0
        trigger = true
        beat_num = beat_num + 1
    elseif song_position > last_beat + quarter then
        last_beat = last_beat + quarter
        trigger = true
        beat_num = beat_num + 1
        crotchet = 0
    else
        crotchet = (song_position - last_beat)/quarter
        trigger = false
    end
end

function conductor:process(e)
    if trigger == true then
        local loop_num = beat_num % e.loop_length
        if e.loop_hits[loop_num] then
            e:beat(loop_num)
        end
    end
    if e.crotchet then
        e:crotchet(crotchet)
    end
end

return conductor