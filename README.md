These are some install scripts and notes I put together to support our CS program's use of Virtualbox to replace lab computers. 

At some point I should add some context here on how this all works, but for this is mostly for my own purposes. If you have questions or would like to use my code yourself but can't figure things out, get in contact with me.

## What's all this?

### Windows_Install.bat
A crusty old batch file that installs chocolatey then uses chocolatey to install VBox and its dependencies. Then it imports the OVA file. I use a a batch file because I can force it to ask for admin privileges. At some point I should use something like Autohotkey to give it a gui.

### macOS_Install.applescript
Applescript that I build to a .app file that students run to install Vbox and import the OVA file. This one does not depend on a package manager like chocolatey, it actaully downloads the install dmg and install Vbox all on its own. Eventually I would like to write the windows installer to work this way.

### prepFlashDrive.command
Just a two-liner bash script that renames a flash drive and copies the files over. I use this to quickly update our [sneakernet](https://en.wikipedia.org/wiki/Sneakernet) that we use to give Vbox and our image to students.

## Checklist of steps to perform updates

### Updates
- [x] windows update
- [x] Chrome
- [x] make sure guest additions are up to date
- [x] ninite file in `c:\maintenance tools`

## Shrink the size of the image

### Clean up Windows
- [x] if you need to uninstall anything: revo uninstaller in `c:\maintenance tools`
- [x] Disk Cleanup (System Files)
- [x] ccleaner in `c:\maintenance tools`
- [x] windirstat in `c:\maintenance tools`
- [x] winsxs foler `Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase`

### Vbox specific stuff
We need to defrag the drive then write zeroes to the disk
- [x] Defraggler in `c:\maintenance tools`
- [ ] [SDelete](https://technet.microsoft.com/en-us/sysinternals/bb897443.aspx) in `c:\maintenance tools`
  - `sdelete.exe c: -z`

### Convert .vmdk to .vdi and resize
This will write a new VHD file that is smaller
- [ ] `VboxManage.exe clonehd --format vdi [source].vmdk [target].vdi`

### Delete the .vmds file and add the .vdi file as a storage device
- [ ] Settings --> storage -> CompSci-disk001.vmdk [Delete] THEN
   - Add the vdi file, make sure to click on the sata controller

## Export steps

### Export the OVA
- [ ] File --> Export appliance

### Test DarkGDK
- [ ] `Desktop\sncDarkGDK2010-32first.sln` in Visual Studio
   - double click
   - Debug menu, Start without Debugging, Yes
