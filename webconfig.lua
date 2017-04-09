if( file.open("network_user_cfg.lua") ~= nil) then
	require("network_user_cfg")    
          wifi.setmode(wifi.STATION)
          wifi.sta.config(ssid,password)
          wifi.sta.connect()
          cnt = 0
          tmr.alarm(1, 1000, 1, function()
               if (wifi.sta.getip() == nil) and (cnt < 10) then                  
                    cnt = cnt + 1
               else
                    tmr.stop(1)
                    if (cnt < 10) then 
                         print(wifi.sta.getip())
						 display.dispwang(1)          
                         ssid= nil
                         password = nil
                         
                    else 
                         wifi.sta.disconnect()
						 display.dispwang(0)
                    end  
					end             
               end)
else
	display.dispwang(0)
end
collectgarbage()
