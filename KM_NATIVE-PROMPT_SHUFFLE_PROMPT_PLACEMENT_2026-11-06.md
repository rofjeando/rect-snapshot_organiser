# SHUFFLE before/after macro and native prompt placement (2026-11-06)

## Problem
1. R2C12 (`ik_2MoveImage+ imageSpa ALTERNATIVE`) places the selected image at X + imageSpacing. The user wanted an optional before/after demonstration: place the new image on top of the previous one, flip it back and forth so workshop participants see what the student corrected, then move it to X + imageSpacing.
2. Native prompts (Prompt for User Input) often opened on the other display and were not keyboard-active.

## Fix
- New macro `ik_2MoveImage+ imageSpa SHUFFLE [Claude Import Test]3.0` (UID 1035C7C6-C8B6-4627-8C7D-7C13DEE2509F), a copy of the original, imported disabled into `__PaletteAffinityDesigner`. File: `/Users/tsukadjed/Library/CloudStorage/Dropbox/Automation/rect-snapshot_organiser/implementation/km_macros/ik_2MoveImage+ imageSpa SHUFFLE [Claude Import Test]3.0.kmmacros`.
- Prompt 1 "Shuffle before/after?" (Yes/ is the Return default, No/N, Cancel/.). No = old behaviour. Yes = paste X, Y, W, H, R at x+0, then Forward One at once (new image in front), pause, then Back, Forward, Back, Forward with pauses, so the comparison ends on the After image in front. Prompt 2 "Another shuffle?" (Place/, Again/A); Again repeats Back, Forward, Back, Forward. Place adds imageSpacing to the old X, pastes only X, then runs Back One once more (images no longer overlap, so it is invisible) to restore the layer order for the next image.
- The next image sits directly below the previous one in the layers panel, so it starts behind it: the sequence starts with Forward One. Version 3.0 ends with the new image in front and restores the order after the move, so the next image's neighbour is correct. Move to Front was rejected: from image 3 on it would swap with the wrong layer.
- Menu items come from `[AFDES] Back One Move selected` and `[AFDES] Forward One Move selected` (Layer, Arrange, Move Back/Forward One), so the Stream Deck R3C11/R3C12 keys can be removed once this works.
- Pause is `afDesign_shufflePause` (default 3, kept once set).
- Prompt placement: a `SetNextEngineWindow` action (MoveWindowTo) before each prompt, position from `afDesign_promptX` / `afDesign_promptY` (defaults 1566 / 983, on the LG). Coordinates are global: 125,125 appears on the MacBook.

## Caveats
- Not yet run by the user at the time of writing; keyboard focus of the prompt without a click is unverified.
- Fixed coordinates break if the displays are rearranged: change the two variables.
- The new copy keeps the original's HotKey and Stream Deck R2C12 triggers; disable the original before enabling the copy. If the Stream Deck key calls the macro by UID it still points at the old one.
- `[INA] QUICK SNAPSHOT (ctrl Return)`: the user switched its "Confirm that image has been written" action to a notification; Display Large has no screen option.

KB entries: `/Users/tsukadjed/Library/CloudStorage/Dropbox/Automation/ProjectTemplate/docs/km_native_prompts_guide.md` and `km_xml_import_guide.md` (2026-11-06).
