Macros for WoW Client

```lua
/run local t,z,sz,mid = {GetInstanceInfo()},GetZoneText(),GetSubZoneText(),C_Map.GetBestMapForUnit("player"); print(format("Instance: %s (%d)\nZone: %s in %s\nMap: %s (%d)",t[1],t[8],sz,z,C_Map.GetMapInfo(mid).name, mid))
```