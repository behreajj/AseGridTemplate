# Aseprite Grid Template Generator

This is a grid template generator for use with the [Aseprite](https://www.aseprite.org/) [scripting API](https://github.com/aseprite/api).

To download this script, click on the green Code button above, then select Download Zip. You can also click on the `gridTemplate.lua` file. Beware that some browsers will append a `.txt` file format to script files on download; Aseprite will not recognize the script until this is removed and the original `.lua` format is used. There can also be issues with copying and pasting. Be sure to click on the Raw file button; do not copy the formatted code.

To use this script, open Aseprite. In the menu bar, go to `File > Scripts > Open Scripts Folder`. Move the Lua script into the folder that opens. Return to Aseprite; go to `File > Scripts > Rescan Scripts Folder` (the default hotkey is `F5`). The script should now be listed under `File > Scripts`. Select `gridTemplate.lua` to launch the dialog.

If an error message in Aseprite's console appears, check if the script folder is on a file path that includes characters outside of [UTF-8](https://en.wikipedia.org/wiki/UTF-8), such as 'é' (e acute) or 'ö' (o umlaut).