# :chart_with_upwards_trend: NWT - Farming Simulator 25 Net Worth Tracker
NWT adds a new screen to FS25 with two tabs to easily view your farm's value and track the value over time. 

![screenshot 1](https://github.com/EvanKirsch/fs25_nwt/blob/master/screenshots/Screenshot_1.jpg)

## :desktop_computer: Dev Console Commands
  - `nwtBuildHistory` - rebuilds fake value history from previous day
  - `nwtToggleDebug` - toggles debug mode for the mod
  - `nwtGetFarmValue` - calculates the current farm value
  - `nwtFarmValueToCSV <file location>` - exports the farms current value to CSV. Optional param of the absolute file location of the file to be saved. The defualt save location is `<save game location>/nwt_farm_value.csv`
  - `nwtFarmValueHistoryToCSV <file location>` - exports the farms value history to CSV. Optional param of the absolute file location of the file to be saved. The defualt save location is `<save game location>/nwt_famr_value_history.csv`

## :gear: Manual Install Instructions
1. Download `FS25_netWorthTracker.zip` from the latest release on the [releases page](https://github.com/EvanKirsch/fs25_nwt/releases)
2. Move your downloaded copy of `FS25_netWorthTracker.zip` to `Documents\My Games\Farming Simulator 2025\mods`

Additional installation support available in my [YouTube demo](https://youtu.be/nhx3g8MrU3E) of the mod

## :hammer_and_wrench: Manual Build Instructions
`git archive -o FS25_netWorthTracker.zip HEAD`

## :spiral_notepad: Implementation Details
Produces a menu tallying the total value of a users farm. Entries are not included if they are for an amount equal to 0.

The types of entries:
  - Fill : Fill is any inventory for the user. Value is dictated by the item types `pricePerLiter` configuration. Entries are aggregated.
     - Placeables fill amounts and placeable mods will be included if the following specs are supported: 
        - `spec_silo` if included in`getFillLevels()`
        - `spec_siloExtension` if included in `storage.fillLevels`
        - `spec_husbandry` if included in `storage.fillLevels`
        - `spec_manureHeap` if included in `manureHeap.fillLevels` 
        - `spec_bunkerSilo` please see implementation for details
        - `spec_objectStorage` if include in `objectInfos[n].objects` and as either has either `baleAttributes` or `palletAttributes`
     - Vehicle fill amounts will be included if owned by the player. Vehicle Mod's fills will be included if `spec_fillUnit.fillUnits` is supported
     - Bales are included if registered and the objects are `Bale`
     - Production's fills are included if it is included in `productionChainManager.productionPoints` and is included in `production.outputFillTypeIdsArray` and `production.storage:getFillLevel()`
  - Livestock : Livestock owned by the user. The value is based on the sell price of the animal. Livestock is aggregated by placeable
    - Placeable Mods will be supported to include livestock if `spec_husbandry` is included
    - Livestock Mods will be supported if `spec_husbandry.clusterSystem.clusters` and `animalSystem.subTypes[].sellPrice:get()` are supported 
  - Equipment : Vehicles owned by the user. Value is the sell price of the equipment. Vehicles are not aggregated
    - Mods will be supported if `vehicle:getSellPrice()` and `vehicle.typeName` are supported
  - Farmland : Farmland owned by the user. Value is the sell price of the farmland. Farmland is not aggregated
    - Mods will be supported if `farmland.price` is supported
  - Placeables : Placeables owned by the user. Value is the sell price of the placeable. Placeables are not aggregated
    - Mods will be supported if `placeable:getSellPrice()` is supported
  - Cash : Cash in users account.
  - Loan : Amount of loan taken out by the user. This is natively aggregated by the loan system.
    - Mods to the loan system are currently not supported
