local moduleName = ...
local M = {}
_G[moduleName] = M
function M.dispall(pm25,jq,STemp,SHumi)
	 id=0
	 a=jq/1000
	 b=jq%1000/100
	 c=jq%100/10
	 d=jq%10
	 str2="t2.txt=\""..pm25.."\""
	 str1="t4.txt=\""..a.."."..b..c..d.."\""
	 str3="t0.txt=\""..STemp.."\""
	 str4="t1.txt=\""..SHumi.."\""
	 uart.setup(id,9600,8,0,1,0)
	 uart.write(id,str2,0xff,0xff,0xff)
	 uart.write(id,str2,0xff,0xff,0xff)
	 uart.write(id,str1,0xff,0xff,0xff)
	 uart.write(id,str3,0xff,0xff,0xff)
	 uart.write(id,str4,0xff,0xff,0xff)
end
function M.dispwang(a)
	if a == 1	then
	strs="xstr 343,26,101,31,0,BLUE,2,1,1,0,\"已联网\""
	elseif	a==0 then
	strs="xstr 343,26,101,31,0,RED,2,1,1,0,\"请按键\""
	else 
	strs="xstr 343,26,101,31,0,RED,2,1,1,0,\"配置中\""
	end
	uart.setup(0,9600,8,0,1,0)
	for i =1, 3, 1
	do uart.write(0,strs,0xff,0xff,0xff)
	end
end
return M