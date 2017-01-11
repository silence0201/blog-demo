local json = require("dkjson");

local tbl = getDeviceInfo(10);

local str = json.encode (tbl, { indent = true })

print (str)
