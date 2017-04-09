local moduleName = ...
local M = {}
_G[moduleName] = M
local pm25 = 0
local jq = 0
function M.readpm25jq()
uart.setup( 0, 9600, 8, 0, 1, 0 )
uart.on("data", 0, 
 function(data)
     if((string.len(data)==32) and (string.byte(data,1)==0x42) and (string.byte(data,2)==0x4d))  then
          pm25 = (string.byte(data,7)*256+string.byte(data,8))
          jq =(string.byte(data,29)*256+string.byte(data,30))
     end
end, 0)
return pm25,jq
end
return M
