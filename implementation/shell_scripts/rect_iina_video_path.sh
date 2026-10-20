#!/bin/bash
# Print the full path of the video shown in IINA, for KM variable Appoints_wFilePath.
# Called by KM macro "[INA] ImageNameModel" (Execute Shell Script, results to variable).
#
# Input:  KMVAR_Appoints_wFilePath (kept if it is a file that exists)
# Output: the video's full path on stdout. Exit 1 if there is no IINA video window.

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:$PATH"

AS=/opt/homebrew/bin/aerospace
IINA_ID="com.colliderli.iina"
SEP="  —  "

if [ -n "$KMVAR_Appoints_wFilePath" ] && [ -e "$KMVAR_Appoints_wFilePath" ]; then
    printf '%s' "$KMVAR_Appoints_wFilePath"
    exit 0
fi

# IINA's window title is "<file name>  —  <folder>"
TITLE=$("$AS" list-windows --monitor all --app-bundle-id "$IINA_ID" --format '%{window-title}' |
    grep -F -m1 "$SEP")
if [ -z "$TITLE" ]; then
    echo "ERROR: no IINA video window found" >&2
    exit 1
fi
NAME="${TITLE%%"$SEP"*}"
DIR="${TITLE#*"$SEP"}"

if [ -e "$DIR/$NAME" ]; then
    printf '%s' "$DIR/$NAME"
    exit 0
fi

# Title folder may be shortened: look the file up by name
FOUND=$(mdfind -name "$NAME" | grep -F -m1 "/$NAME")
if [ -z "$FOUND" ]; then
    echo "ERROR: $NAME not found (title folder: $DIR)" >&2
    exit 1
fi
printf '%s' "$FOUND"
