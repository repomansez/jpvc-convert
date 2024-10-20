#!/bin/sh


check_prerequisites() {
	if [ $(id -u) = 0 ]; then
		echo "Please do not run this script as root, run it as the user you'll use to play the game"
		exit 1
	elif ! [ $(command -v xdelta3) ]; then
		echo "xdelta3 not found. please install it."
		exit 1
	fi
	if ! [ -f gta-vc.exe ]; then ## REMEMBER TO ADD !
		echo "Please unpack and run this script in the same directory as your Vice City installation"
		exit 1
	elif [ -z ${WINE_PREFIX} ]; then
		echo "Please set your WINE_PREFIX variable with export WINE_PREFIX=/path/to/your/prefix"
		exit 1
	elif ! [ -d ${WINE_PREFIX} ]; then
		echo "Invalid WINE_PREFIX, please check for typos and permission issues"
		exit 1
	fi
}

patch_files() {
	echo "Patching files..."
	while read -r file; do
		mv "$file" "$file.old"
		xdelta3 -d -f -s "$file.old" jp_cnvrt_files/patches/${file}.xdelta ${file}
		rm -f "${file}.old"
	done < jp_cnvrt_files/files_to_patch.txt ## REMEMBER TO REMOVE ..
}

delete_files() {
	echo "Deleting files that aren't on the japanese version"
	while read -r file; do
		rm "${file}"
	done < jp_cnvrt_files/files_to_delete.txt
}

copy_files() {
	echo "Copying japanese-exclusive files"
	cp -r jp_cnvrt_files/extra_files/* $(pwd)
}

copy_set() {
	echo "Copying set file"
	documents="${WINE_PREFIX}/drive_c/users/$(whoami)/Documents"
	user_files="${documents}/GTA Vice City User Files"
	mkdir -p "${documents}"
	mkdir -p "${user_files}"
	cp jp_cnvrt_files/gta_vc.set "${user_files}"
}

test_files() {
	echo "Testing files..."
	incorrectFiles=0
	while IFS=',' read -r expectedHash filePath; do
    		expectedHash=$(echo "$expectedHash" | xargs)
    		filePath=$(echo "$filePath" | xargs)

    		if [[ -e "$filePath" ]]; then
        		actualHash=$(md5sum "$filePath" | awk '{print $1}' | tr '[:lower:]' '[:upper:]')

        		if [[ "$expectedHash" != "$actualHash" ]]; then
			echo "Incorrect file: $filePath"
            		((incorrectFiles++))
        		fi
    		fi
	done < "jp_cnvrt_files/files_to_check.txt"
	
	if ! [ $incorrectFiles = 0 ]; then
		echo "Number of incorrect files: $incorrectFiles"
		echo "Please verify the integrity of your game on Steam and try again"
	else
		echo "Conversion successful!"
	fi
}

main() {
	echo -e "\nWelcome to the GTA: Vice City - English to Japanese Converter - Linux edition"
	echo "This converts everything in such a way that your new copy will be identical to the Japanese copy (with a No-CD EXE)."
	sleep 3
	echo -e "\nPlease make sure to unpack and run this script in the same directory as your Vice City installation"
	echo -e "\nPlease make sure to set your Wine Prefix in the WINE_PREFIX environment variable"
	echo -e "\nPress enter to continue"

	read nothing

	check_prerequisites
	patch_files
	copy_files
	copy_set
	test_files
}

main
