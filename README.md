# :chart_with_upwards_trend: NWT - Farming Simulator 25 Net Worth Tracker
NWT adds a new screen to FS25 with two tabs to easily view your farm's value and track the value over time. 

![screenshot 1](https://github.com/EvanKirsch/fs25_nwt/blob/master/screenshots/Screenshot_1.jpg)

## :desktop_computer: Dev Console Commands
  - `nwtBuildHistory` - rebuilds fake value history from previous day
  - `nwtToggleDebug` - toggles debug mode for the mod
  - `nwtGetFarmValue` - calculates the current farm value
  - `nwtFarmValueToCSV <file location>` - exports the farms current value to CSV. Optional param of the absolute file location of the file to be saved. The default save location is `<save game location>/nwt_farm_value.csv`
  - `nwtFarmValueHistoryToCSV <file location>` - exports the farms value history to CSV. Optional param of the absolute file location of the file to be saved. The default save location is `<save game location>/nwt_famr_value_history.csv`

## :gear: Manual Install Instructions
1. Download `FS25_NetWorthTracker_update.zip` from the latest release on the [releases page](https://github.com/EvanKirsch/fs25_nwt/releases)
1. Move your downloaded copy of `FS25_NetWorthTracker_update.zip` to `Documents\My Games\Farming Simulator 2025\mods`

Additional installation support available in my [YouTube demo](https://youtu.be/nhx3g8MrU3E) of the mod

## :hammer_and_wrench: Manual Build Instructions
`git archive -o FS25_NetWorthTracker.zip HEAD`

## :rocket: Release
Create and push a tag on the desired release commit following the pattern `[0-9]+.[0-9]+.[0-9]+.[0-9]+`

```bash
git tag <tagname>
git push origin <tagname>
```
