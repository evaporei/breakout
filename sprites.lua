local fs = require('fs')

local base = 'assets/sprites/'

return fs.dirToTable(base, function (file)
    return love.graphics.newImage(base .. file)
end)
