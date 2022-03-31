ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('d-weaponshop:GetUserData', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb({money = xPlayer.getAccount('money').money, bank = xPlayer.getAccount('bank').money})
end)

ESX.RegisterServerCallback('d-weaponshop:buyweapon', function(source, cb, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 1000
    data.item = '' ..data.item
    local item = 'suppressor'
    if data.item_type == 'weapon' then
        for k,v in ipairs(config.weapons) do
            if data.item == v.weapon then
                price = v.price
                item = v.name
            end
        end
    elseif data.item_type == 'attachment' then
        for k,v in ipairs(config.attachments) do
            if data.item == v.attachment then
                price = v.price
                item = v.name
            end
        end
    elseif data.item_type == 'bullet' then
        for k,v in ipairs(config.bullets) do
            if data.item == v.bullet then
                price = v.price
                item = v.name
            end
        end
    end
    if xPlayer.getAccount('' ..data.type).money >= price then
        if xPlayer.canCarryItem(data.item, 1) then
            xPlayer.removeAccountMoney(data.type, price)
            xPlayer.addInventoryItem(data.item, 1)
            TriggerClientEvent('d-weaponshop:notify', source, 'fa-solid fa-basket-shopping', locale['bought'] ..string.lower(item).. '.', 5000)
        else
            TriggerClientEvent('d-weaponshop:notify', source, 'fa-solid fa-person-circle-xmark', locale['full_inv'], 5000)
        end
    end
end)

ESX.RegisterServerCallback('d-weaponshop:getlicense', function(source, cb, data)
    if config.license then
        local xPlayer = ESX.GetPlayerFromId(source)
        local check = false
        TriggerEvent('esx_license:getLicenses', source, function(licenses)
            for i = 0, #licenses do
                if licenses == nil or licenses[i] == nil or licenses[i].type == nil then
                    check = false
                else
                    if licenses[i].type == 'weapon' then
                        check = true
                    end
                end
            end
        end)
        cb(check)
    else
        cb(true)
    end
end)

ESX.RegisterServerCallback('d-weaponshop:buylicense', function(source, cb, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getAccount('money').money >= data.price then
        TriggerEvent('esx_license:addLicense', source, 'weapon', function()
        end)
        TriggerClientEvent('d-weaponshop:notify', source, 'fa-solid fa-file-certificate', locale['bought_license'], 5000)
    end
end)