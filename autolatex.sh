#!/bin/bash
# Author: Antonio Carretero Sahuquillo
#
# The following script compile a latex file passed as 
# argument and, optionaly, cleans the aux and log file.
#
# It recives as parameter the name (without extension)
# of the file .tex

# Local var
FILE=
FILE_NAME=
OPT=


# Error codes
E_ARGS=1
E_OPT=2
E_FILE=3


# Argument check & assignments
if [[ $# -eq 1 ]]
then
	FILE=$1
elif [[ $# -eq 2 ]]
then
	FILE=$2
	OPT=$1
else 
	echo -e "\n [AUTOLATEX-ERR]: Introduce only one or two arguments!\n"
	exit $E_ARGS 
fi

# File & option check
if [[ ! -f $FILE ]]
then
	echo -e "\n [AUTOLATEX-ERR]: File doesn't exist!\n"
	exit $E_FILE
fi
FILE_NAME="${FILE%.*}"

if [ $# -eq 2 ] && [ "${OPT}" != "-c" ] 
then
	echo -e "\n [AUTOLATEX-ERR]: $OPT is not a valid option.\n"
	exit $E_OPT
fi

# Generate the pdf and the extra files
echo "[AUTOLATEX-GEN]: Generating files..."
pdflatex $FILE > /dev/null

# Clean or not to clean?
if [[ $# -eq 1 ]]
then
	echo ""
	read -p "[AUTOLATEX-CLEAN]: Remove extra files? [y/n]: " -n 1 -r CLEAN

	if [[ $CLEAN == 'y' ]] || [[ $CLEAN == 'Y' ]]
	then
		# Cleaning the actual workspace
		echo -e "\n[AUTOLATEX-CLEAN]: Cleaning workspace..."
		echo "[AUTOLATEX-CLEAN]: Removing auxiliar latex file $FILE_NAME.aux..."
		rm "$FILE_NAME.aux"
		echo "[AUTOLATEX-CLEAN]: Removing log latex file $FILE_NAME.log..."
		rm "$FILE_NAME.log"
		echo -e "\n Workspace cleaned!"
	fi
fi

if [[ $# -eq 2 ]]
then
	# Cleaning the actual workspace
	echo -e "\n[AUTOLATEX-CLEAN]: Cleaning workspace..."
	echo "[AUTOLATEX-CLEAN]: Removing auxiliar latex file $FILE_NAME.aux..."
	rm "$FILE_NAME.aux"
	echo "[AUTOLATEX-CLEAN]: Removing log latex file $FILE_NAME.log..."
	rm "$FILE_NAME.log"
	echo -e "\n Workspace cleaned!"
fi
echo ""

exit 0
