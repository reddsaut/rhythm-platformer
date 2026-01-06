

local TileMap = {}

function TileMap:createTileMap(tileSize)
    local grid = {}
    self.size = tileSize
    self.height = love.graphics.getHeight()/tileSize
    self.width = love.graphics.getWidth()/tileSize
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

    table.insert(mesh, {(i - 1)* size, (j - 1) * size, 0, 0, 0, 0, 0})
    table.insert(mesh, {(i) * size, (j - 1) * size, 0, 0, 0, 0, 0})
    table.insert(mesh, {(i - 1)* size, (j) * size, 0, 0, 0, 0, 0})

    table.insert(mesh, {(i) * size, (j - 1) * size, 0, 0, 0, 0, 0})
    table.insert(mesh, {(i) * size, (j) * size, 0, 0, 0, 0, 0})
    table.insert(mesh, {(i - 1)* size, (j) * size, 0, 0, 0, 0, 0})

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
        for i, v in ipairs(v) do
            if v[1] < minX then minX = v[1] end
            if v[2] < minY then minY = v[2] end
        end
        --table.insert(v, v[1])
        self.vertexMaps = meshes
        table.insert(self.meshList, {love.graphics.newMesh(v, "triangles"), 0, 0})
    end
end

function TileMap:draw()

    love.graphics.setShader(self.shader)
    for i, v in ipairs(self.meshList) do
        
       love.graphics.draw(v[1], v[2], v[3])
    end
    love.graphics.setShader()

    -- for i, v in ipairs(self.vertexMaps) do
    --     for j, w in ipairs(v) do
    --         love.graphics.circle("fill", w[1], w[2], 10)
    --     end
    -- end

    -- for i = 1, TileMap.width do
    --     for j = 1, TileMap.height do
    --         love.graphics.rectangle("line", self.size * (i - 1), self.size * (j - 1), self.size, self.size)
    --         love.graphics.print(TileMap.tileMap[i][j], self.size * (i - 1), self.size * (j - 1))
    --     end
    -- end
end


function TileMap:init(tileSize)
    self:createTileMap(tileSize)
    self.shader = love.graphics.newShader([[

        vec4 resultCol;

        vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords )
        {
            resultCol = vec4( 1.0f, 1.0f, 1.0f, screen_coords[0]/1024);
            return resultCol;
        }

        ]])
    --self.shader:send("stepSize", {1/(self.width * self.size),1/(self.height * self.size)} )
end

return TileMap