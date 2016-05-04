#!/usr/bin/env bash

BUILDIR=$1
TTY=$2
BOARD=$3

family_sconngkp7in="sconngkp7in"
mach_sconngkp7in="at91sama5d4x-ek"
dtb_sconngkp7in="sconngkp7in.dtb"

family_sama5d4_xplained="sama5d4_xplained"
mach_sama5d4_xplained="at91sama5d4x-ek"
dtb_sama5d4_xplained="at91-sama5d4_xplained.dtb"

usage() {
	cat << EOF
Usage:
  $0 <builddir_path> <interface> <board>

Available boards:
  at91sam9rlek
  at91sam9g15ek
  at91sam9g25ek
  at91sam9x25ek
  at91sam9g35ek
  at91sam9x35ek
  sama5d31ek
  sama5d33ek
  sama5d34ek
  sama5d35ek
  sama5d36ek
  sama5d31ek_revc (Until rev. C)
  sama5d33ek_revc (Until rev. C)
  sama5d34ek_revc (Until rev. C)
  sama5d35ek_revc (Until rev. C)
  sama5d36ek_revc (Until rev. C)
  sama5d3_xplained
  sama5d4ek
  sama5d4_xplained
  sconngkp7in

Example:
  $0 ./output /dev/ttyACM0 at91sam9g45m10ek
EOF
}

F="family_$BOARD"
M="mach_$BOARD"
D="dtb_$BOARD"

if [[ $# != 3 || -z ${!F} ]]; then
	usage
	exit 1
fi

video_mode="video=LVDS-1:800x480-16"
if [[ $BOARD == "*pda4" ]]; then
	video_mode="video=LVDS-1:480x272-16"
fi

echo "Executing: ${!F} O=$1/images $1/host/opt/sam-ba/sam-ba $TTY ${!M} $(dirname $0)/nandflash.tcl -- ${!F} ${!D} $video_mode"
export O=$1/images
$1/host/opt/sam-ba/sam-ba $TTY ${!M} $(dirname $0)/nandflash.tcl -- ${!F} ${!D} $video_mode

