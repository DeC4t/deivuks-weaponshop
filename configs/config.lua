config = {}

config.Legacy = true

config.currency = '€'

config.weapons = {
    {name = 'PISTOL', class = 'Hand Gun', weapon = 'weapon_pistol', rounds = 250, price = 5000},
    {name = 'CARBINE RIFLE', class = 'Automatic weapon', weapon = 'weapon_carbinerifle', rounds = 250, price = 50000}
}

config.attachments = {
    {name = 'SUPPRESSOR', class = 'Silent shooting', attachment = 'suppressor', price = 1300},
    {name = 'SCOPE', class = 'Long shoot', attachment = 'scope', price = 5500}
}

config.bullets = {
    {name = 'RIFLE AMMO ', class = 'Ammo for automatic weapons', bullet = 'ammunition_rifle', ammount = 20, price = 500},
    {name = 'HANDGUN AMMO', class = 'Ammo for hand guns', bullet = 'ammunition_pistol', ammount = 10, price = 100}
}

config.weapon_shops = {
    {name = 'PaletoBay', coords = vector3(-330.2026, 6085.0059, 31.4498), heading = 12.9072}
}