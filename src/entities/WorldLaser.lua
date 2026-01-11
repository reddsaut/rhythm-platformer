class = require("lib.30log")

local WorldLaser = class("WorldLaser")

function WorldLaser:init (rowSpawns)
    self.x = 0
    self.y = 0
    self.width = 1
    self.height = 32
    self.drawMode = "fill"
    self.vel = {x = 0, y = 0}
    self.pew = 0
    self.morph = true

    self.shoot = false
    self.warn = false
    self.warnTimer = 0

    self.rowSpawns = rowSpawns
    self.y = self.rowSpawns[love.math.random(1,#self.rowSpawns)] * 32


    self.loop_length = 8
    self.loop_hits = {}
    self.actionLoop = 2
    self.loop_hits[2] = true
    self.loop_hits[1] = true
    self.loop_hits[0] = true

    self.isHazard = false
    self.laserShader = love.graphics.newShader([[
        
        vec4 resultCol;
        vec4 bayersMatrix[16];
        uniform float x;
        uniform float width;
        float alpha;
        vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords )
        {
            bayersMatrix[0] = vec4(00.0/64.0, 32.0/64.0, 08.0/64.0, 40.0/64.0);
            bayersMatrix[1] = vec4(02.0/64.0, 34.0/64.0, 10.0/64.0, 42.0/64.0);
            bayersMatrix[2] = vec4(48.0/64.0, 16.0/64.0, 56.0/64.0, 24.0/64.0);
            bayersMatrix[3] = vec4(50.0/64.0, 18.0/64.0, 58.0/64.0, 26.0/64.0);
            bayersMatrix[4] = vec4(12.0/64.0, 44.0/64.0, 04.0/64.0, 36.0/64.0);
            bayersMatrix[5] = vec4(14.0/64.0, 46.0/64.0, 06.0/64.0, 38.0/64.0);
            bayersMatrix[6] = vec4(60.0/64.0, 28.0/64.0, 52.0/64.0, 20.0/64.0);
            bayersMatrix[7] = vec4(62.0/64.0, 30.0/64.0, 54.0/64.0, 22.0/64.0);
            bayersMatrix[8] = vec4(03.0/64.0, 35.0/64.0, 11.0/64.0, 43.0/64.0);
            bayersMatrix[9] = vec4(01.0/64.0, 33.0/64.0, 9.0/64.0, 41.0/64.0);
            bayersMatrix[10] = vec4(51.0/64.0, 19.0/64.0, 59.0/64.0, 27.0/64.0);
            bayersMatrix[11] = vec4(49.0/64.0, 17.0/64.0, 57.0/64.0, 25.0/64.0);
            bayersMatrix[12] = vec4(15.0/64.0, 47.0/64.0, 07.0/64.0, 39.0/64.0);
            bayersMatrix[13] = vec4(13.0/64.0, 45.0/64.0, 05.0/64.0, 37.0/64.0);
            bayersMatrix[14] = vec4(63.0/64.0, 31.0/64.0, 55.0/64.0, 23.0/64.0);
            bayersMatrix[15] = vec4(61.0/64.0, 29.0/64.0, 53.0/64.0, 21.0/64.0);
            
            float xPos = screen_coords.x - x;
            alpha = xPos/width;
            
            int index_one = (int(mod(screen_coords[0],8))*2) + (int(mod(screen_coords[1], 8))/4);
            int index_two = int(mod(screen_coords[1],4));
            if(alpha > bayersMatrix[index_one][index_two]){
                resultCol = vec4( 1.0f, 0.0f, 0.0f, 1.0f);
            }
            else {
                resultCol = vec4( 0.0f, 0.0f, 0.0f, 0.0f);
            }
            return resultCol;
        }

        ]])
        self.warnShader = love.graphics.newShader([[
        
        vec4 resultCol;
        vec4 bayersMatrix[16];
        float alpha;
        vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords )
        {
            bayersMatrix[0] = vec4(00.0/64.0, 32.0/64.0, 08.0/64.0, 40.0/64.0);
            bayersMatrix[1] = vec4(02.0/64.0, 34.0/64.0, 10.0/64.0, 42.0/64.0);
            bayersMatrix[2] = vec4(48.0/64.0, 16.0/64.0, 56.0/64.0, 24.0/64.0);
            bayersMatrix[3] = vec4(50.0/64.0, 18.0/64.0, 58.0/64.0, 26.0/64.0);
            bayersMatrix[4] = vec4(12.0/64.0, 44.0/64.0, 04.0/64.0, 36.0/64.0);
            bayersMatrix[5] = vec4(14.0/64.0, 46.0/64.0, 06.0/64.0, 38.0/64.0);
            bayersMatrix[6] = vec4(60.0/64.0, 28.0/64.0, 52.0/64.0, 20.0/64.0);
            bayersMatrix[7] = vec4(62.0/64.0, 30.0/64.0, 54.0/64.0, 22.0/64.0);
            bayersMatrix[8] = vec4(03.0/64.0, 35.0/64.0, 11.0/64.0, 43.0/64.0);
            bayersMatrix[9] = vec4(01.0/64.0, 33.0/64.0, 9.0/64.0, 41.0/64.0);
            bayersMatrix[10] = vec4(51.0/64.0, 19.0/64.0, 59.0/64.0, 27.0/64.0);
            bayersMatrix[11] = vec4(49.0/64.0, 17.0/64.0, 57.0/64.0, 25.0/64.0);
            bayersMatrix[12] = vec4(15.0/64.0, 47.0/64.0, 07.0/64.0, 39.0/64.0);
            bayersMatrix[13] = vec4(13.0/64.0, 45.0/64.0, 05.0/64.0, 37.0/64.0);
            bayersMatrix[14] = vec4(63.0/64.0, 31.0/64.0, 55.0/64.0, 23.0/64.0);
            bayersMatrix[15] = vec4(61.0/64.0, 29.0/64.0, 53.0/64.0, 21.0/64.0);
            
            alpha = .025;
            
            int index_one = (int(mod(screen_coords[0],8))*2) + (int(mod(screen_coords[1], 8))/4);
            int index_two = int(mod(screen_coords[1],4));
            if(alpha > bayersMatrix[index_one][index_two]){
                resultCol = vec4( 1.0f, 0.0f, 0.0f, 1.0f);
            }
            else {
                resultCol = vec4( 0.0f, 0.0f, 0.0f, 0.0f);
            }
            return resultCol;
        }

        ]])
end

function WorldLaser:beat(loop_num) 
    if loop_num == self.actionLoop then
        self.shoot = true
        self.isHazard = true
    else
        self.warnTimer = 100
    end
    
end

function WorldLaser:draw()
    if self.shoot then
        self.pew = self.pew + 70
        if self.pew > love.graphics.getWidth() * 5 then
            self.pew = 1
            self.x = 0
            self.shoot = false
            self.isHazard = false
            self.y = self.rowSpawns[love.math.random(1,#self.rowSpawns)] * 32
        end
        if(self.x == 0 and self.width < love.graphics.getWidth() + 200) then
            self.width = self.pew;
        end
        if (self.pew > love.graphics.getWidth()) then
            self.x = (self.pew * 1.1) - (love.graphics.getWidth() + 500)
            if love.graphics.getWidth() - self.x > 0 then self.width = love.graphics.getWidth() - self.x end
        end
        love.graphics.setColor(1, 0, 0)
        self.laserShader:send("x", self.x)
        self.laserShader:send("width", self.width)
        love.graphics.setShader(self.laserShader)
        love.graphics.rectangle(self.drawMode, self.x, self.y, self.width, self.height)
        love.graphics.setColor(1, 1, 1)
        love.graphics.setShader()
    end
    if self.warnTimer > 0 then
        love.graphics.setColor(1, 0, 0)
        --self.warnShader:send("timer", self.warnTimer)
        love.graphics.setShader(self.warnShader)
        love.graphics.rectangle(self.drawMode, 0, self.y, love.graphics.getWidth(), self.height)
        love.graphics.setColor(1, 1, 1)
        love.graphics.setShader()
        self.warnTimer = self.warnTimer - 10
    end
    --love.graphics.print(self.y, 500, 50)
end

return WorldLaser