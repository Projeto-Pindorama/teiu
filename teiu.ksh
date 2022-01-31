#!/bin/ksh
# Teiu - The really tiny² installation system for Copacabana Linux

function main {
	echo 'What would you like to do?'
	select opt in 'install Copacabana Linux' \
		'exit to single user shell'; do
		case $REPLY in
			1) setup  ;;
			\?|2) exit ;;
		esac
		break
	done
}

function setup { 
	echo 'Beginning system instalation — looking for disks...' 
	disk_lookup
	
}

function disk_lookup {
	# We're backuping the current $IFS, since we'll need it later
	OLDIFS=$IFS
	# Set a new IFS as a special character and then create an array
	# containing fdisk output listing avaible disks.
	IFS=§ disk_proprieties=($(fdisk -l | awk '/^Disk \// {$1=""; print $0}' | tr '\n' '§'))
	# Now reload the backuped $IFS ($OLDIFS) and then create an array
	# containing disk identifiers
	IFS=$OLDIFS disk_id=($(fdisk -l | awk -F '[ ,:]' '/^Disk \// {print $2}'))
	
	echo 'Which disk do you want to be your system disk?'	
	PS3='Select a disk unit: ' 
	IFS=§
	select disk in ${disk_proprieties[@]}; do
		# Set $disk as the disk selected, since
		# n(disk_id) is always equal n(disk_proprieties).
		# The only difference here is that we're always
		# deducting 1 from $REPLY, since array elements
		# are counted from 0 to n, unlike select, which
		# counts from 1 to n.
		disk=${disk_id[$(( $REPLY - 1))]}
		break	
	done
	IFS=$OLDIFS printf '%s, %s' $disk $REPLY
}

main
