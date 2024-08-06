local fs = require('fs')

local base = 'assets/sounds/'

return fs.dirToTable(base, function (file)
    return love.audio.newSource(base .. file, 'static')
end)
