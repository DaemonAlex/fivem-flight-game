# fivem-flight-game (WIP)
FiveM Flight Simulator with plane UI.

## Update 2024 April
- Added Flight Radio & Radio channels

<img alt="Coming in next update" src="https://github.com/Psykopaten/fivem-flight-game/assets/104300989/f450b0f9-9eee-43fa-8a23-9b2c21e570ca">


Preview of up coming features and existing features: https://streamable.com/52hqfk


## Requirements
- [NativeUI](https://github.com/FrazzIe/NativeUILua/archive/refs/tags/2.1.0.zip)
- Go into NativeUI/NativeUI.lua and goto line 2676 and change `if Item() == "UIMenuItem" then` to `if type(Item) == "table" and Item.__index == UIMenuItem then`
- PMA-Voice to make radio work

## Add this to server.cfg
```
ensure InteractionMenu
ensure vehicleControls
ensure planehud
ensure flight-radio
```

## Optional
You can also add this if you want the players to spawn at the airport
Step 1. Go into `[gamemodes]/[maps]/fivem-map-hipster` or `[gamemodes]/[maps]/fivem-map-skater`
Step 2. Go into the map.lua files and remove all lines that have a `spawnpoint` in the start and replace them with this:
```
spawnpoint 's_m_m_pilot_01' { x = -933.1028, y = -2967.3000, z = 13.9451 }
spawnpoint 's_m_m_pilot_01' { x = -934.6771, y = -2966.3225, z = 13.9451 }
spawnpoint 's_m_m_pilot_01' { x = -935.4889, y = -2967.6309, z = 13.9451 }
spawnpoint 's_m_m_pilot_01' { x = -933.5282, y = -2969.0061, z = 13.9451 }
```

### Coming up next update
- Advanced system or NUI
- Load and unload passengers system

## Socials
Joina my new discord server for support and updates
https://discord.gg/TJCKedg8SB

# Visitor Count
  <img src="https://profile-counter.glitch.me/fivem-flight-game/count.svg" />
