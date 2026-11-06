# SHUFFLE before/after macro and native prompt placement (2026-11-06)

## Problem
1. R2C12 (`ik_2MoveImage+ imageSpa ALTERNATIVE`) places the selected image at X + imageSpacing. The user wanted an optional before/after demonstration: place the new image on top of the previous one, flip it back and forth so workshop participants see what the student corrected, then move it to X + imageSpacing.
2. Native prompts (Prompt for User Input) often opened on the other display and were not keyboard-active.

## Fix
- New macro `ik_2MoveImage+ imageSpa SHUFFLE [Claude Import Test]2.0` (UID 31396414-FA03-49ED-AD8A-7AE69047B7F0), a copy of the original, imported disabled into `__PaletteAffinityDesigner`. File: `/Users/tsukadjed/Library/CloudStorage/Dropbox/Automation/rect-snapshot_organiser/implementation/km_macros/ik_2MoveImage+ imageSpa SHUFFLE [Claude Import Test]2.0.kmmacros`.
- Prompt 1 "Shuffle before/after?" (No/N, Yes/Y, Cancel/.). No = old behaviour. Yes = paste X, Y, W, H, R at x+0, then Forward One, pause, Back One, pause, Forward One, pause, Back One (restores layer order), then Prompt 2 "Another shuffle?" (Place/, Again/A). Place adds imageSpacing to the old X and pastes only X.
- The next image sits directly below the previous one in the layers panel, so it starts behind it: the sequence starts with Forward One. Move to Front was rejected: from image 3 on it would swap with the wrong layer.
- Menu items come from `[AFDES] Back One Move selected` and `[AFDES] Forward One Move selected` (Layer, Arrange, Move Back/Forward One), so the Stream Deck R3C11/R3C12 keys can be removed once this works.
- Pause is `afDesign_shufflePause` (default 3, kept once set).
- Prompt placement: a `SetNextEngineWindow` action (MoveWindowTo) before each prompt, position from `afDesign_promptX` / `afDesign_promptY` (defaults 1566 / 983, on the LG). Coordinates are global: 125,125 appears on the MacBook.

## Caveats
- Not yet run by the user at the time of writing; keyboard focus of the prompt without a click is unverified.
- Fixed coordinates break if the displays are rearranged: change the two variables.
- The new copy keeps the original's HotKey and Stream Deck R2C12 triggers; disable the original before enabling the copy. If the Stream Deck key calls the macro by UID it still points at the old one.
- `[INA] QUICK SNAPSHOT (ctrl Return)`: the user switched its "Confirm that image has been written" action to a notification; Display Large has no screen option.

KB entries: `/Users/tsukadjed/Library/CloudStorage/Dropbox/Automation/ProjectTemplate/docs/km_native_prompts_guide.md` and `km_xml_import_guide.md` (2026-11-06).
