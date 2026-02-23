## jpvc-convert

A Linux tool to convert any GTA: Vice City version to the Japanese version of the game - based on zoton2's script but for Linux.

This script is feature-complete, so it should still work even if no commit has been made for years.

The usage of this tool is allowed on the official speedrun.com leaderboards.

## Dependencies
- GTA Vice City 
- xdelta3

## How to use
- Launch the game once to generate your Wine prefix;
- Export your WINEPREFIX environment variable, making it point to your prefix;
- Copy the files to your GTA VICE CITY installation folder and run `convert.sh`.

## How it works

This tool uses **XDelta**, a utility for generating binary patches by comparing two files: one representing the desired version and the other the original. For example, if you compare the Steam readme with the Japanese readme, the tool will create a patch that transforms the Steam version into the Japanese one.

## Process

1. **File Comparison**  
   Zoton2 manually analyzes all differences between the Steam and Japanese versions of the game, creating a patch for each discrepancy.

2. **Patch Application**  
   The tool applies these patches to your game files, converting them to the Japanese version.  
   *(Note: For the GTA SA script, I created the patches manually.)*

3. **Additional Tasks**  
   - Copies over extra files, such as the Japanese no-CD DVD.
   - Removes files that are absent in the Japanese version.
   - Verifies file integrity by comparing hashes against a template.

## Result

Once the process is complete, your **Steam version of Vice City** will be successfully converted to the **Japanese version**.

## Video tutorial
- Coming soon™

## License
The script itself is licensed under the GPL version 3, but the contents of the `jp_cnvrt_files` directory are copyrighted to their respective owners.  
#dontsuemetaketwo
