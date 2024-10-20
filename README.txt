Welcome to the GTA: Vice City - English to Japanese Converter.
Created by zoton2.

NOTE: This converter should work for most versions of "GTA: Vice City" that I know about;
if you do have any issues please notify me (see below).

This tool will convert the English version of "GTA: Vice City" into the rarer/harder
to find Japanese version of the game, including a No-CD EXE. The patcher mainly uses binary
difference patches to convert the big files, to keep the size of the converter to a
minimum. This tool is mainly made for speedrunners (seeing as the Japanese version is
faster, but harder/more expensive to get hold of). The conversion you will get will
have identical files to that of the original Japanese install (which is also verfied
at the end of the conversion).

To use, copy the "Convert_to_JP" batch file and the "jp_cnvrt_files" folder
into your "GTA: Vice City" directory. I advise you make a copy of the game's
folder, this can usually be found at:
- STEAM:  C:\Program Files (x86)\Steam\SteamApps\common\Grand Theft Auto Vice City
- RETAIL: C:\Program Files (x86)\Rockstar Games\Grand Theft Auto Vice City
(remove the (x86) if you are running a 32-bit Windows version), and use that copy,
just in case you also want to use the English one at some point, or in case the
conversion messes up.
Once this is done, run the "Convert_to_JP" batch file and follow the prompts.

NOTE: This version uses the same settings folder in your Documents as the English version,
and the saves from that one won't work, so you may want to back that up first too.

If you are having issues, I advise you verify your game cache through Steam/reinstall and then
run this converter again. If you still have problems, please contact me:
- Mention me @zoton2 on Twitter
- Make a post at: http://www.speedrun.com/gtavc/forum

Thanks to:
Mhmd_FVC - For supplying me with the original Japanese version.
unknown - For the No-CD EXE this converter is supplied with (I don't know who made it, sorry!)
xdelta - The program which this converter uses to patch certain files.
md5 - The program which this converter uses to check files are correct.
PhamousVegas - Copied batch code from his GTASA downgrader.
LanceVanceDance - For removing the CD-ROM drive check from the No-CD.

CHANGELOG:
V5 - Fixed delays, Cloudflare bought the 1.1.1.1 domain.
   - Removed RADIO .adf and two mission audio files from checks, caused confusion for RGL version users.
   - Added a .set file drop in the User Files folder.

V4 - Fixed the No-CD EXE so it no longer checks for a CD-ROM drive (thanks to LanceVanceDance).
   - Updated the MD5 hash for the modified No-CD EXE.
   - Removed the "No CD-ROM Drive Found" workaround stuff because of the above change.
   - Updated the README to remove information about the "No CD-ROM Drive Found" workaround.

V3 - Added a fix/workaround for the "No CD-ROM Drive Found" issue.
   - Updated the README with information about the above issue.
   - Updated the README with some more credits I forgot about before.

V2 - Added a check to make sure the final converted files are the same as the Japanese copy.
   - Made it so the converter will remove read-only attributes from files before it patches them.
   - Included the full No-CD EXE so this tool can work with versions with different EXEs than Steam.
   - Checks before it deletes non-Japanese files (so you don't get errors for files only in Steam release).

V1 - Original release.