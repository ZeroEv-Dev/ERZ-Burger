ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('erz_burger:Product')
AddEventHandler('erz_burger:Product', function(item, reqItem)
    local src = source 
    local xPlayer = ESX.GetPlayerFromId(src)
     if type(item) == "table" then
      if reqItem ~= nil then
         for i,z in pairs(reqItem) do 
            if xPlayer.getInventoryItem(z.name).count >= z.count then
               xPlayer.removeInventoryItem(z.name, z.count)
            else
               xPlayer.showNotification("Non hai i prodotti necessari")
               return false
            end
         end
      end
      TriggerEvent('erz_burger:additem', src, item)
    end
end) 

RegisterServerEvent('erz_burger:additem')
AddEventHandler('erz_burger:additem', function(source, item)
   local src = source 
   local xPlayer = ESX.GetPlayerFromId(src)
   for k,v in pairs(item) do
      xPlayer.addInventoryItem(v.name, v.count)
   end
end)


RegisterNetEvent("erz_burger:Sell")
AddEventHandler("erz_burger:Sell", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('hamburger').count > 0 then
                local money = Config.Prezzo
                local count = xPlayer.getInventoryItem('hamburger').count
                xPlayer.removeInventoryItem('hamburger', count)
                dclog(xPlayer, '** '..count.. ' Hamburger Venduti ' ..money.. 'per $ **')
                xPlayer.addMoney(money*count)
            elseif xPlayer.getInventoryItem('hamburger').count < 1 then
                xPlayer.showNotification("Non hai i prodotti necessari")
            end
        end
    end)

function dclog(xPlayer, text)
    local playerName = Sanitize(xPlayer.getName())
  
    local discord_webhook = "TUOWEBHOOK"
    if discord_webhook == '' then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "ERZ LOG | HAMBURGER",
      ["avatar_url"] = "TUOAVATAR",
      ["embeds"] = {{
        ["author"] = {
          ["name"] = playerName .. ' - ' .. xPlayer.identifier
        },
        ["color"] = 1942002,
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
      }}
    }
    data['embeds'][1]['description'] = text
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end

function Sanitize(str)
    local replacements = {
        ['&' ] = '&amp;',
        ['<' ] = '&lt;',
        ['>' ] = '&gt;',
        ['\n'] = '<br/>'
    }

    return str
        :gsub('[&<>\n]', replacements)
        :gsub(' +', function(s)
            return ' '..('&nbsp;'):rep(#s-1)
        end)
end
