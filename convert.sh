#!/bin/sh

check_prerequisites() {
    if [ "$(id -u)" = 0 ]; then
        echo "Please do not run this script as root, run it as the user you'll use to play the game"
        exit 1
    elif ! [ "$(command -v xdelta3)" ]; then
        echo "xdelta3 not found. Please install it."
        exit 1
    elif ! [ -f gta-vc.exe ]; then 
        echo "Please unpack and run this script in the same directory as your Vice City installation"
        exit 1
    elif [ -z "${WINE_PREFIX}" ]; then
        echo "Please set your WINE_PREFIX variable with export WINE_PREFIX=/path/to/your/prefix"
        exit 1
    elif ! [ -d "${WINE_PREFIX}" ]; then
        echo "Invalid WINE_PREFIX, please check for typos and permission issues"
        exit 1
    elif [ -f TEXT/Japanese.gxt ]; then
        echo "This game has already been converted, exiting."
        exit 0
    fi
}

patch_files() { # Reads the files from the TXT file and uses xdelta3 to patch them one by one 
    echo "Patching files..."
    while read -r file; do
        mv "$file" "$file.old"
        xdelta3 -d -f -s "$file.old" "jp_cnvrt_files/patches/${file}.xdelta" "${file}"
        rm -f "${file}.old"
    done < jp_cnvrt_files/files_to_patch.txt 
}

delete_files() {
    echo "Deleting files that aren't on the Japanese version"
    sleep 2
    while read -r file; do
        if [ -f "${file}" ]; then
            rm "${file}" 1> /dev/null
        fi
    done < jp_cnvrt_files/files_to_delete.txt
}

copy_files() {
    echo "Copying Japanese-exclusive files"
    sleep 2
    cp -r jp_cnvrt_files/extra_files/* "$(pwd)"
}

copy_set() { # Copies the JP set file to your documents directory on the WINE_PREFIX
    echo "Copying set file"
    sleep 2
    documents="${WINE_PREFIX}/drive_c/users/$(whoami)/Documents"
    user_files="${documents}/GTA Vice City User Files"
    mkdir -p "${documents}"
    mkdir -p "${user_files}"
    cp jp_cnvrt_files/gta_vc.set "${user_files}"
}

test_files() { # Calculates the MD5 hash and compares them to the table, making sure they've been converted properly
    echo "Testing files..."
    incorrectFiles=0
    while IFS=',' read -r expectedHash filePath; do
        expectedHash=$(echo "$expectedHash" | xargs)
        filePath=$(echo "$filePath" | xargs)

        if [ -e "$filePath" ]; then
            actualHash=$(md5sum "$filePath" | awk '{print $1}' | tr '[:lower:]' '[:upper:]')

            if [ "$expectedHash" != "$actualHash" ]; then
                echo "Incorrect file: $filePath"
                incorrectFiles=$((incorrectFiles+1))
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
    clear
    printf "\nWelcome to the GTA: Vice City - English to Japanese Converter - Linux edition"
    printf "This converts everything in such a way that your new copy will be identical to the Japanese copy (with a No-CD EXE)."
    sleep 3
    printf "\nPlease make sure to unpack and run this script in the same directory as your Vice City installation"
    printf "\nPlease make sure to set your Wine Prefix in the WINE_PREFIX environment variable"
    printf "\nPress enter to continue"

    read -r nothing

    check_prerequisites
    patch_files
    delete_files
    copy_files
    copy_set
    test_files
}

main

