# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build

To package the mod for distribution:
```
git archive -o FS25_netWorthTracker.zip HEAD
```

The mod runs directly from the source directory — there is no compile step. The game loads Lua files at runtime.

## Testing

There is no automated test suite. Testing requires running the mod inside Farming Simulator 25. Use the in-game dev console commands to exercise functionality:

- `nwtToggleDebug` — enable debug output
- `nwtGetFarmValue` — calculate and print current farm value
- `nwtBuildHistory` — generate fake history records from the earliest recorded day backward (useful for testing the history tab without waiting in-game days)
- `nwtFarmValueToCSV [path]` — export current farm value to CSV
- `nwtFarmValueHistoryToCSV [path]` — export history to CSV

## Architecture

This is a Farming Simulator 25 Lua mod. Entry point is `src/NWT_netWorthTracker.lua`, which sources all other files and registers event listeners via `addModEventListener`. All class definitions follow the GIANTS Lua OOP pattern (`Class(Child, Parent)`).

**Data flow:**
1. `NWT_netWorthCalcUtil` + `NWT_fillCalcUtil` query FS25 game globals (`g_currentMission`, `g_farmManager`, etc.) to build a list of `NWT_entry` objects representing assets/liabilities
2. `NWT_historyManager` subscribes to `MessageType.DAY_CHANGED` and records total farm value as `NWT_history` objects (server-side only)
3. `NWT_historyDao` persists history to `<savegame>/nwt_history.xml` by hooking into `Mission00.loadItemsFinished` and `FSCareerMissionInfo.saveToXMLFile`
4. `NWT_inGameMenuNetWorthTracker` (extends `TabbedMenuFrameElement`) renders two tabs — current farm value and historical values — using FS25's list/table GUI system with delegate pattern

**Key files:**
- `src/NWT_netWorthTracker.lua` — main entry point, sources all modules, injects the menu tab into `InGameMenu`
- `src/NWT_historyManager.lua` — singleton `g_nwt_historyManager`, holds in-memory history array and triggers daily recording
- `src/dao/NWT_historyDao.lua` — XML persistence for history; hooks into game save/load lifecycle
- `src/util/NWT_netWorthCalcUtil.lua` — calculates entries for cash, loans, equipment, farmland, placeables, and livestock
- `src/util/NWT_fillCalcUtil.lua` — calculates fill inventory entries; dispatches to per-spec implementations via a lookup table (avoids Lua reflection)
- `src/gui/NWT_inGameMenuNetWorthTracker.lua` — GUI controller; sorts entry data client-side, re-renders on tab switch
- `src/gui/NWT_farmValueDelegate.lua` / `NWT_historyDelegate.lua` — data delegates for the two list tables
- `gui/NWT_inGameMenuNetWorthTracker.xml` — GUI layout definition; `gui/NWT_guiProfiles.xml` — GUI style profiles

**Livestock pricing:** Animals use a health/fitness modifier applied to the base sell price. Standard animals: `price * (0.4 + 0.6 * health)`. Horses additionally factor fitness: `price * (0.3 + 0.5 * health + 0.2 * fitness)`.

**Fill inventory aggregation:** All fill entries are keyed by `fillType` ID in a flat table so quantities across silos, vehicles, and bales are summed into a single row per fill type before being added to `entryTable`.

**Mod compatibility:** New placeable specs can be supported by adding an entry to the `placeableFillEntryImpls` table in `NWT_fillCalcUtil.lua`. Mod vehicles and livestock are automatically supported as long as they implement the documented FS25 spec interfaces.

## Translations

Add a new translation file at `translations/translation_XX.xml` using an existing file as a template. The `modDesc.xml` references `translations/translation` as the filename prefix; GIANTS engine appends the language code automatically.

## Lua tooling

`.luarc.json` points the Lua language server for FS25 API type stubs.
