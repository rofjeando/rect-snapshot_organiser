# F Firsts Snapshot: regex fails on iina_windowName (2026-10-20)

## Problem
`F Firsts Snapshot` cancelled with "Search Regular Expression failed to match
((\d{8})_((\d{2})h_)?(.+)(\'s)?\s(\d{1,3})).(.{2}).+$ (while executing Search Variable
"iina_windowName")". It had worked for months.

## Cause
The regex was fine. `iina_windowName` held the literal text `%Appoints_wFilePath%`
because `[INA] ImageNameModel` (C296A2E4-AE3C-4FD8-8AEE-7C34C2B1A7EC) starts with
Set Variable `iina_windowName` to `%Appoints_wFilePath%`, and that variable was empty.
It is normally filled by the session-prepare macros (WORKSP_Prepare Session From DayAgenda,
search videoPath). This time the video was opened by an unrelated macro, so nothing set it.
No macro changed: the actions are identical in the KM revisions 2026-10-02 to 2026-10-18.

## Fix
New first action in `[INA] ImageNameModel`: Execute Shell Script, results to variable
`Appoints_wFilePath`, running
`/Users/tsukadjed/Library/CloudStorage/Dropbox/Automation/rect-snapshot_organiser/implementation/shell_scripts/rect_iina_video_path.sh`.

The script keeps `KMVAR_Appoints_wFilePath` if it is an existing file. Otherwise it reads the
IINA window title through `aerospace list-windows --app-bundle-id com.colliderli.iina
--format '%{window-title}'`. The title is `<file name>  —  <folder>`, so the path is folder +
`/` + name; if that does not exist it falls back to `mdfind -name`. No IINA video window:
exit 1 with a message.

## Caveats
- Needs the AeroSpace binary at /opt/homebrew/bin/aerospace.
- `[INA]FileName in use in iina CollectData` (C640B456-...) sets `iina_fileName`, not
  `Appoints_wFilePath`.
- Export: `/Users/tsukadjed/Library/CloudStorage/Dropbox/Automation/rect-snapshot_organiser/implementation/km_macros/[INA] ImageNameModel.kmmacros`
  (written from the live xml, wrapped in its group, imported disabled).
