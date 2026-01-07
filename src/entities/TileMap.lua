
local TileMap = {}

function TileMap:createTileMap(tileSize)
    local grid = {}
    self.size = tileSize
    self.height = self.screen_height*self.zoom/tileSize
    self.width = self.screen_width*self.zoom/tileSize
    for i = 1, self.width do
        grid[i] = {}
        for j = 1, self.height do
            grid[i][j] = 0
        end
    end

    setmetatable(grid, {
        __index = 
        function(t, key)
            if not table[key] then
                return {}
            else
                return table[key]
            end
        end})
    self.tileMap = grid
end

function TileMap:createPlatform(x1, x2, y1, y2)
    for i = x1, x2 do
        for j = y1, y2 do
            self.tileMap[i][j] = 1
        end
    end
end

local function checkNeighbors(tileMap, visited, i, j, mesh, size)
    
    local neighbors = {{i-1, j}, {i, j-1}, {i + 1, j}, {i, j+1}, {i-1, j-1}, {i + 1, j - 1}, {i + 1, j + 1}, {i - 1, j + 1}}

    
    -- if (tileMap[(neighbors[1][1])][(neighbors[1][2])] == 0 or tileMap[(neighbors[1][1])][(neighbors[1][2])] == nil) and 
    -- (tileMap[(neighbors[2][1])][(neighbors[2][2])] == 0 or tileMap[(neighbors[2][1])][(neighbors[2][2])] == nil) then
    --     table.insert(mesh, {(i - 1)* size, (j - 1) * size, 0, 0, 1, 1, 1})
    -- end

    -- if (tileMap[(neighbors[3][1])][(neighbors[3][2])] == 0 or tileMap[(neighbors[3][1])][(neighbors[3][2])] == nil) and 
    -- (tileMap[(neighbors[2][1])][(neighbors[2][2])] == 0 or tileMap[(neighbors[2][1])][(neighbors[2][2])] == nil) then
    --     table.insert(mesh, {(i) * size, (j - 1) * size, 0, 0, 1, 1, 1})
    -- end

    -- if (tileMap[(neighbors[3][1])][(neighbors[3][2])] == 0 or tileMap[(neighbors[3][1])][(neighbors[3][2])] == nil) and 
    -- (tileMap[(neighbors[4][1])][(neighbors[4][2])] == 0 or tileMap[(neighbors[4][1])][(neighbors[4][2])] == nil) then
    --     table.insert(mesh, {(i) * size, (j) * size, 0, 0, 1, 1, 1})
    -- end

    -- if (tileMap[(neighbors[1][1])][(neighbors[1][2])] == 0 or tileMap[(neighbors[1][1])][(neighbors[1][2])] == nil) and 
    -- (tileMap[(neighbors[4][1])][(neighbors[4][2])] == 0 or tileMap[(neighbors[4][1])][(neighbors[4][2])] == nil) then
    --     table.insert(mesh, {(i - 1)* size, (j) * size, 0, 0, 1, 1, 1})
    -- end

    -- if (tileMap[(neighbors[1][1])][(neighbors[1][2])] == 1 or tileMap[(neighbors[1][1])][(neighbors[1][2])] == nil) and 
    -- (tileMap[(neighbors[2][1])][(neighbors[2][2])] == 1 or tileMap[(neighbors[2][1])][(neighbors[2][2])] == nil) and 
    -- tileMap[(neighbors[5][1])][(neighbors[5][2])] == 0 then
    --     table.insert(mesh, {(i - 1)* size, (j - 1) * size, 0, 0, 1, 1, 1})
    -- end

    -- if (tileMap[(neighbors[3][1])][(neighbors[3][2])] == 1 or tileMap[(neighbors[3][1])][(neighbors[3][2])] == nil) and 
    -- (tileMap[(neighbors[2][1])][(neighbors[2][2])] == 1 or tileMap[(neighbors[2][1])][(neighbors[2][2])] == nil) and 
    -- tileMap[(neighbors[6][1])][(neighbors[6][2])] == 0 then
    --     table.insert(mesh, {(i) * size, (j - 1) * size, 0, 0, 1, 1, 1})
    -- end

    -- if (tileMap[(neighbors[3][1])][(neighbors[3][2])] == 1 or tileMap[(neighbors[3][1])][(neighbors[3][2])] == nil) and 
    -- (tileMap[(neighbors[4][1])][(neighbors[4][2])] == 1 or tileMap[(neighbors[4][1])][(neighbors[4][2])] == nil) and 
    -- tileMap[(neighbors[7][1])][(neighbors[7][2])] == 0  then
    --     table.insert(mesh, {(i) * size, (j) * size, 0, 0, 1, 1, 1})
    -- end

    -- if (tileMap[(neighbors[1][1])][(neighbors[1][2])] == 1 or tileMap[(neighbors[1][1])][(neighbors[1][2])] == nil) and 
    -- (tileMap[(neighbors[4][1])][(neighbors[4][2])] == 1 or tileMap[(neighbors[4][1])][(neighbors[4][2])] == nil) and 
    -- tileMap[(neighbors[8][1])][(neighbors[8][2])] == 0 then
    --     table.insert(mesh, {(i - 1)* size, (j) * size, 0, 0, 1, 1, 1})
    -- end

    table.insert(mesh, {(i - 1)* size, (j - 1) * size, 0, 0, 1, 1, 1})
    table.insert(mesh, {(i) * size, (j - 1) * size, 0, 0, 1, 1, 1})
    table.insert(mesh, {(i - 1)* size, (j) * size, 0, 0, 1, 1, 1})

    table.insert(mesh, {(i) * size, (j - 1) * size, 0, 0, 1, 1, 1})
    table.insert(mesh, {(i) * size, (j) * size, 0, 0, 1, 1, 1})
    table.insert(mesh, {(i - 1)* size, (j) * size, 0, 0, 1, 1, 1})

    for index, v in ipairs(neighbors) do
        if (visited[v[1]][v[2]] == 0) then
            visited[v[1]][v[2]] = 1
            if(tileMap[v[1]][v[2]] == 1) then
                checkNeighbors(tileMap, visited, v[1], v[2], mesh, size)
            end
        end
    end
end

function TileMap:createMesh()
    local meshes = {}
    local visited = {}

    setmetatable(visited, {
        __index = 
        function(t, key)
            if not table[key] then
                return {}
            else
                return table[key]
            end
        end})

    for i = 1, self.width do
        visited[i] = {}
        for j = 1, self.height do
            visited[i][j] = 0
        end
    end

    for i = 1, self.width do
        for j = 1, self.height do
            if visited[i][j] == 0 and self.tileMap[i][j] == 1 then
                local mesh = {}
                visited[i][j] = 1
                checkNeighbors(self.tileMap, visited, i, j, mesh, self.size)
                table.insert(meshes, mesh)
            else
                visited[i][j] = 1
            end
        end
    end

    self.meshList = {}
    for i, v in ipairs(meshes) do
        local minX = 999999
        local minY = 999999
        local maxX = -999
        local maxY = -999
        for i, v in ipairs(v) do
            if v[1] < minX then minX = v[1] end
            if v[2] < minY then minY = v[2] end
            if v[1] > maxX then maxX = v[1] end
            if v[2] > maxY then maxY = v[2] end
        end

        table.insert(self.meshList, {love.graphics.newMesh(v, "triangles"), minX, minY, maxX, maxY})
    end
end

function TileMap:draw()
    love.graphics.setCanvas(self.canvas)
    love.graphics.clear(0, 0, 0, 0)
    love.graphics.setBlendMode("alpha")
    for i, v in ipairs(self.meshList) do
        love.graphics.draw(v[1], 0, 0)
    end
    love.graphics.setCanvas()
    --love.graphics.draw(self.meshList[2][1], self.meshList[2][2], self.meshList[2][3])
    self.ditheredGradientShaderY:send("fun", self.funNumberHappyTimes)
    -- love.graphics.draw(self.meshList[1][1], self.meshList[1][2], self.meshList[1][3])
    --love.graphics.print(self.funNumberHappyTimes, 0, 0)
    for i, v in ipairs(self.meshList) do
        
        --love.graphics.print("base: ".. v[3] .. " range: " .. v[5], i*200, 32)
        self.ditheredGradientShaderY:send("base", v[3])
        self.ditheredGradientShaderY:send("range", v[5])
        love.graphics.setShader(self.ditheredGradientShaderY)
        love.graphics.draw(v[1], 0, 0)
        love.graphics.setShader()
    end
    love.graphics.setShader(self.outlineShader)
    love.graphics.draw(self.canvas)
    love.graphics.setShader()

    --[[
    for i, v in ipairs(self.vertexMaps) do
        for j, w in ipairs(v) do
            love.graphics.circle("fill", w[1], w[2], 10)
        end
    end
    --]]

    --[[
    for i = 1, TileMap.width do
        for j = 1, TileMap.height do
            love.graphics.rectangle("line", self.size * (i - 1), self.size * (j - 1), self.size, self.size)
            love.graphics.print(i .. ", " .. j, self.size * (i - 1) + 5, self.size * (j - 1) + 5, 0, .6, .6)
        end
    end
    --]]
end

function TileMap:beat(crotchet)
    self.funNumberHappyTimes = crotchet
end

function TileMap:crotchet(crotchet)
    self.funNumberHappyTimes = crotchet
end

function TileMap:init(tileSize, zoom)
    self.screen_width = love.graphics.getWidth()
    self.screen_height = love.graphics.getHeight()
    self.zoom = zoom
    self.loop_hits = {}
    for i = 0, 4 do
        self.loop_hits[i] = true
    end
    self.canvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())
    self.loop_length = 4
    self.funNumberHappyTimes = 0
    self:createTileMap(tileSize)
    self.ditheredGradientShaderX = love.graphics.newShader([[
        vec4 resultCol;
        uniform float fun;
        uniform float base;
        float alpha;
        vec4 bayersMatrix[16];
        vec4 hello = vec4(00.0/64.0, 32.0/64.0, 08.0/64.0, 40.0/64.0);
        
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
            if(screen_coords[0] >= fun + base){
                alpha = (screen_coords[0] - (fun + base))/love_ScreenSize.x;
            }
            else{
                alpha = screen_coords[0]/(fun + base);
            }
            int index_one = (int(mod(screen_coords[0],8))*2) + (int(mod(screen_coords[1], 8))/4);
            int index_two = int(mod(screen_coords[1],4));
            if(alpha < bayersMatrix[index_one][index_two]){
                resultCol = vec4( 1.0f, 1.0f, 1.0f, 1.0f);
            }
            else {
                resultCol = vec4( 0.0f, 0.0f, 0.0f, 0.0f);
            }
            return resultCol;
        }
            
        ]])
    self.ditheredGradientShaderY = love.graphics.newShader([[
        vec4 resultCol;
        uniform float fun;
        uniform float base;
        uniform float range;
        float alpha;
        vec4 bayersMatrix[16];
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
            float start = base + (3*(range - base));
            int offset = int((fun) * (start - base));
            //int distance = int(2 * (range - base));
            if (screen_coords[1] >= range - offset){
                alpha = ((screen_coords[1]) - (range - offset))/ offset;
            }else{
                alpha = 1;
            }
            //alpha = (screen_coords[1] - base)/(range-base);
            int index_one = (int(mod(screen_coords[0],8))*2) + (int(mod(screen_coords[1], 8))/4);
            int index_two = int(mod(screen_coords[1],4));
            if(alpha < bayersMatrix[index_one][index_two]){
                resultCol = vec4( 1.0f, 1.0f, 1.0f, 1.0f);
            }
            else {
                resultCol = vec4( 0.0f, 0.0f, 0.0f, 1.0f);
            }
            //resultCol = vec4(1.0f, 1.0f, 1.0f, alpha);
            return resultCol;
        }
            
        ]])
    self.gradientShader = love.graphics.newShader([[
        
        vec4 resultCol;
        uniform float fun;
        vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords )
        {
            if(screen_coords[0] >= fun){
                resultCol = vec4( 1.0f, 1.0f, 1.0f, (screen_coords[0] - fun)/love_ScreenSize.x);
            }
            else{
                resultCol = vec4( 1.0f, 1.0f, 1.0f, screen_coords[0]/fun);
            }
            return resultCol;
        }

        ]])
    self.outlineShader = love.graphics.newShader([[
        vec2 stepSize;
        vec4 resultCol;
        vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords )
        {
            stepSize[0] = 1.0/love_ScreenSize.x;
            stepSize[1] = 1.0/love_ScreenSize.y;
            float alpha = 4*texture2D( tex, texture_coords ).a;
            alpha -= Texel( tex, texture_coords + vec2( stepSize.x, 0.0f ) ).a;
            alpha -= Texel( tex, texture_coords + vec2( -1*stepSize.x, 0.0f ) ).a;
            alpha -= Texel( tex, texture_coords + vec2( 0.0f, stepSize.y ) ).a;
            alpha -= Texel( tex, texture_coords + vec2( 0.0f, -1*stepSize.y ) ).a;
            resultCol = vec4(1.0f, 1.0f, 1.0f, alpha);
            return resultCol;
        }

        ]])
    --self.shader:send("stepSize", {1/(self.width * self.size),1/(self.height * self.size)} )
end

return TileMap