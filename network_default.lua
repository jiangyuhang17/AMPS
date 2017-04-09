function decodeURI(s)
    s = string.gsub(s, '%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)
    return s.gsub(s,'\+',' ')
end
local WS="no"
wifi.setmode(wifi.SOFTAP)
cfg={}
cfg.ssid="NodeMoniter"
cfg.pwd="12345678"
wifi.ap.config(cfg)
print(wifi.ap.getip())

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
     conn:on("receive",function(conn,payload)
          local i = 0
          local j = 0
          while true do
               i = string.find(payload, "\n", i+1)
               if i == nil then break
               else 
               j=i
               end    
          end
          paraStr = string.sub(payload,j)                   
          if (string.find(paraStr,"=")~=nil) then
               file.open("network_user_cfg.lua","w+")
               for name, value in string.gfind(paraStr, "([^&=]+)=([^&=]+)") do
                 file.writeline(decodeURI(name).."=\""..decodeURI(value).."\"")
               end              
               WS="Saved"
               file.close()
          end
          paraStr = nil

          conn:send("HTTP/1.0 200 OK\r\nContent-type: text/html\r\nServer: ESP8266\r\n\n")
          conn:send("<!DOCTYPE html><html><head>")
		  conn:send("<meta http-equiv=\"content-type\" content=\"text/html;charset=gbk\">")
		  if(WS=="Saved") then
          conn:send("<meta http-equiv=\"refresh\" content=\"20\">")
          end
          conn:send("</head>")
		  conn:send("<body bgcolor=\"#ccffcc\"><div style=\"text-align:center;color:#000000;font-size:20px;\">") 
		  conn:send("<font color=\"#666666 \" size=\"+4\"><h1>智能环境监测项目</h1></font><br><br>") 
          if(WS=="Saved") then
          conn:send("<br>请等待20秒...<br>浏览器跳转后设备自动联网!")
          else
		      conn:send("<table width=\"300\" height=\"150\">")
	          conn:send("<FORM action=\"\" method=\"POST\"><tr><td></td></tr>")
	          conn:send("<tr><td>")
	          conn:send("<tr><td>wifi名</td><td><input type=\"text\" name=\"ssid\" value=\"\"></td></tr>")  
		      conn:send("<tr><td>wifi密码</td><td><input type=\"password\" name=\"password\" value=\"\"></td></tr>")
		      conn:send("<tr><td><input type=\"submit\" value=\"保存\"></td></tr>")  
	          conn:send("</form>")
              conn:send("</table></div>")
	          conn:send("</body>")
	          conn:send("</html>")
		  end
	      conn:close()
		if(WS=="Saved") then
	           srv:close()
			   WS=nil
               tmr.alarm(0,2000,0,function()node.restart() end )
        end
     end)
end)



