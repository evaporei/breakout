local Brick = require('brick')

NONE = 1
SINGLE_PYRAMID = 2
MULTI_PYRAMID = 3

SOLID = 1
ALTERNATE = 2

local LevelMaker = {}

function LevelMaker.createMap(level)
    local bricks = {}

    local numRows = math.random(1, 5)
    local numCols = math.random(7, 13)
    -- -- debug
    -- local numRows = math.random(1)
    -- local numCols = math.random(1)
    numCols = numCols % 2 == 0 and (numCols + 1) or numCols

    local highestTier = math.min(3, math.floor(level / 5))
    local highestColor = math.min(5, level % 5 + 3)
    -- -- debug
    -- local highestTier = 1
    -- local highestColor = 1

    for y = 1, numRows do
        local skipPattern = math.random(2) == 1 and true or false
        local alternatePattern = math.random(2) == 1 and true or false

        local alternateColor1 = math.random(1, highestColor)
        local alternateColor2 = math.random(1, highestColor)
        local alternateTier1 = math.random(1, highestTier)
        local alternateTier2 = math.random(1, highestTier)

        local skipFlag = math.random(2) and true or false
        local alternateFlag = math.random(2) and true or false

        local solidColor = math.random(1, highestColor)
        local solidTier = math.random(0, highestTier)

        for x = 1, numCols do
            if skipPattern and skipFlag then
                skipFlag = not skipFlag

                goto continue
            else
                skipFlag = not skipFlag
            end

            local brick = Brick.new(
                (x - 1)                -- tables are 1-idx and coords are 0
                * 32                   -- brick width
                + 8                    -- padding; we can fit 13 cols + 16 pixels total
                + (13 - numCols) * 16, -- left-side padding for when there are < 13 columns

                y * 16
            )

            if alternatePattern then
                if alternateFlag then
                    brick.color = alternateColor1
                    brick.tier = alternateTier1
                else
                    brick.color = alternateColor2
                    brick.tier = alternateTier2
                end
                alternateFlag = not alternateFlag
            else
                brick.color = solidColor
                brick.tier = solidTier
            end

            table.insert(bricks, brick)

            ::continue::
        end
    end

    if #bricks == 0 then
        return LevelMaker.createMap(level)
    end

    return bricks
end

return LevelMaker
