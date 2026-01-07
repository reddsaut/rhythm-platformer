

local TileMap = {}

function TileMap:createTileMap(tileSize)
    local grid = {}
    self.height = 800/tileSize
    self.width = 1024/tileSize
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
                return -1
            else
                return table[key]
            end
        end})
    self.tileMap = grid
end

function TileMap:createPlatform(x1, y1, x2, y2)
    for i = x1, x2 do
        for j = y1, y2 do
            self.tileMap[i][j] = 1
        end
    end
    print("nice!!")
end

local function checkNeighbors(tileMap, visited, i, j, mesh, size)
    
    local neighbors = {{i-1, j}, {i, j-1}, {i + 1, j}, {i, j+1}}
    -- local b = neighbors[1][1]
    -- print(b)
    -- print(type(b))
    -- local a = tileMap[b][1]
    
    if tileMap[neighbors[3][1]][neighbors[3][2]] == 0 and tileMap[neighbors[4][1]][neighbors[4][2]] == 0 then
        table.insert(mesh, {i * size, j * size, 0, 0, 1, 1, 1})
    end

    if tileMap[(neighbors[1][1])][(neighbors[1][2])] == 0 and tileMap[(neighbors[2][1])][(neighbors[2][2])] == 0 then
        table.insert(mesh, {i - 1* size, j - 1 * size, 0, 0, 1, 1, 1})
    end

    if tileMap[neighbors[2][1]][neighbors[2][2]] == 0 and tileMap[neighbors[3][1]][neighbors[3][2]] == 0 then
        table.insert(mesh, {i * size, j - 1 * size, 0, 0, 1, 1, 1})
    end

    if tileMap[neighbors[3][1]][neighbors[3][2]] == 0 and tileMap[neighbors[4][1]][neighbors[4][2]] == 0 then
        table.insert(mesh, {i * size, j * size, 0, 0, 1, 1, 1})
    end

    if tileMap[neighbors[1][1]][neighbors[1][2]] == 0 and tileMap[neighbors[4][1]][neighbors[4][2]] == 0 then
        table.insert(mesh, {i - 1* size, j * size, 0, 0, 1, 1, 1})
    end


    for index, v in ipairs(neighbors) do
        if (visited[v[1]][v[2]] == 0) then
            visited[v[1]][v[2]] = 1
            if(tileMap[v[1]][v[2]] == 1) then
                checkNeighbors(tileMap, visited, v[1], v[2], mesh)
            end
        end
    end
end

function TileMap:createMesh()
    local meshes = {}
    local visited = {}

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
                checkNeighbors(self.tileMap, visited, i, j, mesh)
                table.insert(meshes, mesh)
            else
                visited[i][j] = 1
            end
        end
    end

    self.meshList = {}
    for i, v in ipairs(meshes) do
        table.insert(self.meshList, love.graphics.createMesh(v, "fan"))
    end
end

function TileMap:init(tileSize)
    self:createTileMap(tileSize)
    print("hooray")
end

TileMap:init(32)
TileMap:createPlatform(1, 5, 10, 5)
TileMap:createMesh()

-- if(screen_coords[0] >= fun){
--                 alpha = (texture_coords[0] - fun);
--             }
--             else{
--                 alpha = texture_coords[0];
--             }

    