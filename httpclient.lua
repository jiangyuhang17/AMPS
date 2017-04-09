local moduleName = ...
local M = {}
_G[moduleName] = M
local socket
function M.SendValue(st,sh,pm,jq)
	socket=net.createConnection(net.TCP, 0)
	postdata=",;temperature,"..st..";humidity,"..sh..";PM2.5,"..pm..";jiaquan,"..jq
	socket:connect(80,"183.230.40.33")
	socket:on("connection",function(sck,response)
	    print(response)
	    socket:send("POST /devices/3152221/datapoints?type=5 HTTP/1.1\r\n")
		socket:send("api-key: XINEf4RfzPM=GBvp=ygZKi7=c3E=\r\n")
		socket:send("Host: api.heclouds.com\r\n")
		socket:send("Content-Length: "..string.len(postdata).."\r\n\r\n")
		socket:send(postdata.."\r\n\r\n")
		postdata=nil
	end)
	socket:on("receive", function(sck, response)
        postdata= nil
        socket:close()        
    end)
	
end
return M