local moduleName = ...
local M = {}
_G[moduleName] = M
function M.disp(pm,jq)
	if	jq <= 80	then
		str1="xstr 364,262,85,31,0,BLUE,2,1,1,0,\"���\""
		else
		str1="xstr 364,262,85,31,0,RED,2,1,1,0,\"����\""
	end
	if	pm < 35	then
		str2="xstr 361,156,104,31,0,GREEN,2,1,1,0,\"��\""
		elseif pm >= 35 and pm < 75	then
		str2="xstr 361,156,104,31,0,BLUE,2,1,1,0,\"��\""
		elseif pm >= 75 and pm < 115 then
		str2="xstr 361,156,104,31,0,BROWN,2,1,1,0,\"�����Ⱦ\""
		elseif pm >= 115 and pm < 150 then
		str2="xstr 361,156,104,31,0,YELLOW,2,1,1,0,\"�ж���Ⱦ\""
		elseif pm >= 150 and pm < 250 then
		str2="xstr 361,156,104,31,0,GRAY,2,1,1,0,\"�ض���Ⱦ\""
		elseif pm >= 250 and pm < 500 then
		str2="xstr 361,156,104,31,0,RED,2,1,1,0,\"������Ⱦ\""
	end
	uart.setup(0,9600,8,0,1,0)
	 uart.write(0,str1,0xff,0xff,0xff)
	 uart.write(0,str2,0xff,0xff,0xff)
end
return M