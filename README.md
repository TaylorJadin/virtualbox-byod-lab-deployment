# Import the OVA file

# run updates
- [ ] windows update
- [ ] Chrome
- [ ] make sure guest additions are up to date
- [ ] ninite file in `c:\maintenance tools`


# windows cleaning
- [ ] if you need to uninstall anything: revo uninstaller in `c:\maintenance tools`
- [ ] Disk Cleanup (System Files)
- [ ] ccleaner in `c:\maintenance tools`
- [ ] windirstat in `c:\maintenance tools`
- [ ] winsxs foler `Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase`

# Vbox specific stuff
We need to defrag the drive then write zeroes to the disk
- [ ] Defraggler in `c:\maintenance tools`
- [ ] [SDelete](https://technet.microsoft.com/en-us/sysinternals/bb897443.aspx) in `c:\maintenance tools`
  - `sdelete.exe c: -z`

# Convert vmdk to vdi and resize
This will write a new VHD file that is smaller
- [ ] `VboxManage.exe clonehd --format vdi [source].vmdk [target].vdi`

# Delete the VMDK file and add the VDI file as a storage device
- [ ] Settings --> storage -> CompSci-disk001.vmdk [Delete] THEN
   - Add the vdi file, make sure to click on the sata controller

# Export the OVA
- [ ] File --> Export appliance

# Test DarkGDK
- [ ] `Desktop\sncDarkGDK2010-32first.sln` in Visual Studio
   - double click
   - Debug menu, Start without Debugging, Yes