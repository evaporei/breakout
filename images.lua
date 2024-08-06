local fs = require('fs')

local base = 'assets/images/'

return fs.dirToTable(base, function (file)
    return love.graphics.newImage(base .. file)
end)
