#!/bin/bash
echo
echo Downloading Latest Spybot Includes File
curl https://www.safer-networking.org/updates/files/spybotsd_includes.exe -o "/Users/bigmac/Desktop/Flash Drive/Anti-Virus/Ninite Quick Installers/spybot_includes.exe"
echo
echo Downloading Latest Tweaking.com Windows Repair
curl http://www.tweaking.com/files/setups/tweaking.com_windows_repair_aio.zip -o "/Users/bigmac/Desktop/Flash Drive/Tools/tweaking.com_win_repair.zip"
echo
echo Downloading Latest Windows 10 Updater
curl https://go.microsoft.com/fwlink/?LinkID=799445  -L -o "/Users/bigmac/Desktop/Flash Drive/Tools/windows10Updater.exe"
echo
echo Unzipping Windows Repair  
unzip -qqo /Users/bigmac/Desktop/Flash\ Drive/Tools/tweaking.com_win_repair.zip -d /Users/bigmac/Desktop/Flash\ Drive/Tools
echo
echo Removing Windows Repair Zip File
rm -f /Users/bigmac/Desktop/Flash\ Drive/Tools/tweaking.com_win_repair.zip 
echo
diskutil list | grep UTIL >~/Desktop/drives.tmp
loops=$(wc -l < ~/Desktop/drives.tmp | cut -c 7,8)
echo Found $loops drives
iter=1
diskutil eraseVolume MS-DOS UTILITIES "/Volumes/UTILITIES"
echo
while [ $iter -lt $loops ]; do
	diskutil eraseVolume MS-DOS UTILITIES "/Volumes/UTILITIES "$iter
	let iter=iter+1
	echo
done
let iter=1
echo Copying Utilities to /Volumes/UTILITIES
echo
rsync -a /Users/bigmac/Desktop/Flash\ Drive/* "/Volumes/UTILITIES" 
while [ $iter -lt $loops ]; do
	echo Copying Utilities to /Volumes/UTILITIES $iter
	rsync -a /Users/bigmac/Desktop/Flash\ Drive/* "/Volumes/UTILITIES "$iter
	let iter=iter+1
	echo
done
let iter=1
diskutil eject "/Volumes/UTILITIES"
while [ $iter -lt $loops ]; do
	diskutil eject "/Volumes/UTILITIES "$iter
	let iter=iter+1
done 
rm -f ~/Desktop/drives.tmp 
say All Drives Completed
exit