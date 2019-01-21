-- get the path to the mac_install
tell application "Finder"
	set current_path to container of (path to me) as alias
	set DIR to POSIX path of current_path
end tell

set usr to short user name of (system info)

display dialog "This installer will download and install Virtualbox and its extension pack, then import the CompSci.ova file to set up the Virtual Machine. 

The process will take several minutes and require 30gb of free space on your computer.

 - ITS Service Desk - 
servicedesk.snc.edu" buttons {"Cancel", "Continue"} default button 2 cancel button 1 with title "CompSci Vbox Installer"

repeat
	display dialog "Please enter password to continue:" default answer "" buttons {"Cancel", "Submit"} default button 2 cancel button 1 with title "CompSci Vbox Installer" with icon caution with hidden answer
	set pswd to text returned of the result
	try
		do shell script "echo test" user name usr password pswd with administrator privileges
		exit repeat
	end try
end repeat

tell application "Terminal"
	do script "sudo -S -v <<< " & pswd & " 2> /dev/null"
	activate
	do script "clear" in front window
	do script "rm -f /tmp/virtualbox.pkg" in front window
	do script "VBOX_LATEST_VERSION=$(curl http://download.virtualbox.org/virtualbox/LATEST.TXT)" in front window
	do script "VBOX_LATEST_FILE_OSX=$(curl http://download.virtualbox.org/virtualbox/${VBOX_LATEST_VERSION}/MD5SUMS | grep -i \"OSX.dmg\" | cut -d\"*\" -f2)" in front window
	do script "curl http://download.virtualbox.org/virtualbox/${VBOX_LATEST_VERSION}/${VBOX_LATEST_FILE_OSX} --output /tmp/virtualbox.dmg" in front window
	do script "hdiutil mount /tmp/virtualbox.dmg" in front window
	do script "sudo installer -pkg /Volumes/VirtualBox/VirtualBox.pkg -target \"/Volumes/Macintosh HD\"" in front window
	do script "hdiutil unmount /Volumes/VirtualBox" in front window
	do script "curl http://download.virtualbox.org/virtualbox/${VBOX_LATEST_VERSION}/Oracle_VM_VirtualBox_Extension_Pack-${VBOX_LATEST_VERSION}.vbox-extpack > /tmp/Oracle_VM_VirtualBox_Extension_Pack-${VBOX_LATEST_VERSION}.vbox-extpack" in front window
	do script "echo y | sudo VBoxManage extpack install --replace /tmp/Oracle_VM_VirtualBox_Extension_Pack-${VBOX_LATEST_VERSION}.vbox-extpack" in front window
	do script "VBoxManage import \"" & DIR & "CompSci.ova\"" in front window
	do script "VBoxManage sharedfolder add CompSci --name LocalMachine --hostpath / --automount" in front window
	do script "open /Applications/Virtualbox.app/" in front window
end tell