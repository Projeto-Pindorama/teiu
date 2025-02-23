#!/bin/ksh
# Teiú - The really tiny*10⁻² installation wizard for Copacabana Linux.
# Copyright (c) 2021-2025 Pindorama
# 			  Luiz Antônio Rangel
# SPDX-Licence-Identifier: NCSA

function main {
	printerr 'What would you like to do?'
	select opt in 'install Copacabana Linux' \
		'exit to user shell'; do
		case $REPLY in
			1) setup ;;
			\? | 2) exec "$(readlink -f /proc/$$/exe)" ;; # Expects ksh
		esac
		break
	done
}

function setup {
	printerr 'Beginning system instalation — looking for disks...'
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

	printerr 'Which disk do you want to be your system disk?'
	PS3='Select a disk unit: '
	IFS=§
	select disk in ${disk_proprieties[@]}; do
		# Set $disk as the disk selected, since
		# n(disk_id) is always equal n(disk_proprieties).
		# The only difference here is that we're always
		# deducting 1 from $REPLY, since array elements
		# are counted from 0 to n, unlike select, which
		# counts from 1 to n.
		disk="${disk_id[$((REPLY - 1))]}"
		break
	done
	IFS=$OLDIFS printf 'Selected disk unit "%s"\n.' $disk

	# export the $disk variable, we will be using it later on.
	export disk
}

function check_network {
	# First strip *// from the start of the string
	mirror_basename="${1#*//}"
	# Then strip the rest
	mirror_basename=${mirror_basename%%/*}

	# And tada! You have just the domain name
	printf 'GET %s HTTP/1.0\n\n' $mirror_basename |
		netcat "$mirror_basename" 80 >/dev/null 2>&1
	retval="$?"

	return $retval
}

function printerr {
	printf "$@" 1>&2
}

# Function plain-copied from cmd/download_sources.bash
function realpath {
	file_basename="$(basename "$1")"
	file_dirname="$(dirname "$1")"
	# get the absolute directory name
	# example: ./sources.txt -> /usr/src/copacabana-repo/sources.txt
	echo "$(
		cd "${file_dirname}"
		pwd -P
	)/${file_basename}"
}

main
