These are some install scripts and notes I put together to support our CS program's use of Virtualbox to replace lab computers. 

At some point I should add some context here on how this all works, but for this is mostly for my own purposes. If you have questions or would like to use my code yourself but can't figure things out, get in contact with me.


## Checklist of steps to perform updates, shrink the size of the image, and re-export to an OVA

### Updates
- [ ] windows update
- [ ] Chrome
- [ ] make sure guest additions are up to date
- [ ] ninite file in `c:\maintenance tools`


### Clean up Windows
- [ ] if you need to uninstall anything: revo uninstaller in `c:\maintenance tools`
- [ ] Disk Cleanup (System Files)
- [ ] ccleaner in `c:\maintenance tools`
- [ ] windirstat in `c:\maintenance tools`
- [ ] winsxs foler `Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase`

### Vbox specific stuff
We need to defrag the drive then write zeroes to the disk
- [ ] Defraggler in `c:\maintenance tools`
- [ ] [SDelete](https://technet.microsoft.com/en-us/sysinternals/bb897443.aspx) in `c:\maintenance tools`
  - `sdelete.exe c: -z`

### Convert .vmdk to .vdi and resize
This will write a new VHD file that is smaller
- [ ] `VboxManage.exe clonehd --format vdi [source].vmdk [target].vdi`

### Delete the .vmds file and add the .vdi file as a storage device
- [ ] Settings --> storage -> CompSci-disk001.vmdk [Delete] THEN
   - Add the vdi file, make sure to click on the sata controller

### Export the OVA
- [ ] File --> Export appliance

### Test DarkGDK
- [ ] `Desktop\sncDarkGDK2010-32first.sln` in Visual Studio
   - double click
   - Debug menu, Start without Debugging, Yes
