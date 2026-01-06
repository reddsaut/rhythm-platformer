local conductor = Tiny.processingSystem()

local music = love.audio.newSource("music/song_looping.wav", "stream")
local bpm = 100.0
local quarter = 60.0 / bpm
local song_position = 0
local last_beat = 0
local beat_num = 0
local trigger = false

conductor.filter = Tiny.requireAll("beat")

function conductor:onAddToWorld()
    music:setLooping(true)
    music:play()
end

function conductor:preProcess()
    song_position = music:tell("seconds")
    if last_beat > song_position then --resets "last_beat" after song loops back to the start
        last_beat = 0
        trigger = true
        beat_num = beat_num + 1
    elseif song_position > last_beat + quarter then
        last_beat = last_beat + quarter
        trigger = true
        beat_num = beat_num + 1
    else
        trigger = false
    end
end

function conductor:process(e)
    if trigger == true then
        e:beat(beat_num)
    end
end

return conductor