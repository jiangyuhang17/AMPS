local luaFile ={"sht20.lua","pmjq.lua","judgepmjq.lua","display.lua","httpclient.lua","network_default.lua","webconfig.lua","runall.lua"}
for i, f in ipairs(luaFile) do
	if file.open(f) then
      file.close()
      node.compile(f)
      file.remove(f)
	end
	collectgarbage()
 end
luaFile = nil
require("display")
gpio.mode(2,gpio.INPUT)
local b=0
tmr.alarm(3,1000,1,function()
     if gpio.read(2)==0 and b==0 then 
		 b=1
		 display.dispwang(3)
	     dofile("network_default.lc") end		
end)
dofile("webconfig.lc")
dofile("runall.lc")

	


