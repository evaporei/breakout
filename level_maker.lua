local Brick = require('brick')

local LevelMaker = {}

function LevelMaker.createMap()
    local bricks = {}

    local numRows = math.random(1, 5)
    local numCols = math.random(7, 13)

    for y = 1, numRows do
        for x = 1, numCols do
            local brick = Brick.new(
                (x - 1)                -- tables are 1-idx and coords are 0
                * 32                   -- brick width
                + 8                    -- padding; we can fit 13 cols + 16 pixels total
                + (13 - numCols) * 16, -- left-side padding for when there are < 13 columns

                y * 16
            )

            table.insert(bricks, brick)
        end
    end

    return bricks
end

return LevelMaker
