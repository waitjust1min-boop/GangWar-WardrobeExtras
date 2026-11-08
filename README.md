# Gang War - Wardrobe Extras (source)

The full source of **GangWar_WardrobeExtras_1.0.12.zip**, the optional add-on of the GTA IV mod **Gang War**:
<https://www.nexusmods.com/gta4/mods/1515?tab=description>

The add-on lets the player's character, Niko, wear the hats, clothes, hairstyles and faces of the game's other
characters. These are the same files as in the Nexus zip, byte for byte (see `SHA256SUMS.txt`).

**Nothing in this repository is compiled, and there is no build step.** Every file is plain text: two Windows batch
files, PowerShell scripts, and C# source files that PowerShell compiles on the player's PC when the scripts run
(with its built-in `Add-Type`).

## How it runs

1. The player closes GTA IV and double-clicks `GangWar - Install wardrobe extras.bat`.
2. That batch file only starts two PowerShell scripts:
   `powershell -NoProfile -ExecutionPolicy Bypass -File "<script>.ps1"`.
   `-ExecutionPolicy Bypass` is only there so the scripts run when double-clicked. No Windows setting is changed.
3. The scripts:
   - stop if GTA IV is running;
   - read the archive key from the player's own `GTAIV.exe` (the game's archives are encrypted with it; the key is not
     in this repository);
   - read the player's own game files and build the new looks from them;
   - copy the two game files they change to `GangWar_backups\` first, and check the copies by hash;
   - replace a game file only after the rebuilt file has passed its checks.
4. `GangWar - Uninstall wardrobe extras.bat` runs the same scripts with `-Uninstall`: the originals are copied back.

## Files it reads (all in the player's GTA IV folder)

- `GTAIV.exe` (only to find the archive key)
- `pc\models\cdimages\pedprops.img`, `pc\models\cdimages\componentpeds.img`, `pc\models\cdimages\playerped.rpf`
- `common\data\peds.ide`
- the mod's own settings files `scripts\GangWar_*.txt`

## Files it writes

- `pc\models\cdimages\pedprops.img` and `pc\models\cdimages\playerped.rpf` (the two rebuilt game files)
- `GangWar_backups\pedprops.img.ORIGINAL` and `GangWar_backups\playerped.rpf.ORIGINAL` (the originals)
- small text files of the mod in `scripts\` (which extras are installed, the names of the new looks, the applied fit
  settings), and a log / lock file next to the scripts
- temporary build files in `%TEMP%\GangWarHats`

## What it does not do

No internet access of any kind (no downloads, no web requests, no sockets), no encoded or hidden commands, no registry
changes, no new programs, services or startup entries, and no administrator rights are needed (unless the game folder
itself is write-protected).

## How the main mod uses it

The main mod (`GangWar.cs`, in the mod's main file) has size, height and position sliders for these looks in its
WARDROBE menu. When the player changes one, the mod starts the same installer script minimized with
`-WaitPid <game process id>`. The script waits until the game has closed, because the game files are in use while it
runs, and then rebuilds the looks with the new sizes. If the add-on is not installed, nothing is started.

## The files

| File | What it does |
|---|---|
| `GangWar - Install wardrobe extras.bat` | starts the hats installer, then the clothes installer |
| `GangWar - Uninstall wardrobe extras.bat` | starts both with `-Uninstall` (restores the original files) |
| `README_WardrobeExtras.txt` | instructions for players |
| `scripts/GangWar_tools/clothes_installer/Install-GangWarClothes.ps1` | builds the clothes, hair and faces into `playerped.rpf` |
| `scripts/GangWar_tools/clothes_installer/load_tools.ps1` | loads the C# helper sources with `Add-Type` |
| `scripts/GangWar_tools/clothes_installer/ClothConv.cs` | converts a character's clothing mesh and textures for Niko |
| `scripts/GangWar_tools/clothes_installer/Rpf2.cs` | reads and writes the game's RPF archive format |
| `scripts/GangWar_tools/clothes_installer/Install_GangWar_Clothes.bat`, `Uninstall_GangWar_Clothes.bat` | the same, clothes only |
| `scripts/GangWar_tools/hats_installer/Install-GangWarHats.ps1` | builds the hats into `pedprops.img` |
| `scripts/GangWar_tools/hats_installer/build_safe.ps1` | the hats build step (called by `Install-GangWarHats.ps1`) |
| `scripts/GangWar_tools/hats_installer/hats.txt` | the list of hats (which character's hat, its name) |
| `scripts/GangWar_tools/hats_installer/Rsc.cs`, `MergeMany.cs`, `Chunks.cs`, `SafeBuild.cs` | read and write the game's resource and IMG formats |
| `scripts/GangWar_tools/hats_installer/IvImg.cs` | finds the archive key in `GTAIV.exe` (see the note below) |
| `scripts/GangWar_tools/hats_installer/Install_GangWar_Hats.bat`, `Uninstall_GangWar_Hats.bat` | the same, hats only |

**Note on `IvImg.cs`:** it also contains two functions, `Extract` and `DecodeSco`, left over from the author's
research of the game's files. The installers never call them. The only function of `IvImg.cs` they use is `FindKey`.

## Checking that these are the Nexus files

`SHA256SUMS.txt` lists the SHA-256 fingerprint of every file and of the Nexus zip. In PowerShell:

```powershell
Get-FileHash "<file>" -Algorithm SHA256
```

`LICENSE.txt` and `.gitattributes` belong to this repository only; they are not in the Nexus zip.
