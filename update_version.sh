#!/bin/bash

# Find all directories matching 'repository.*' in '$PWD/repo'
dirs=($(find "$PWD/repo" -type d -name 'repository.*'))

# Display found repositories and let the user select one
echo "Found repositories:"
for i in "${!dirs[@]}"; do
	echo "[$i] ${dirs[$i]}"
done

read -p "Select a repository by entering the index: " selectedIndex
selectedRepo=${dirs[$selectedIndex]}

# Find the addon.xml file
addonXmlFile=$(find "$selectedRepo" -name 'addon.xml')

# Extract the current version from the addon tag
currentVersion=$(grep '<addon' "$addonXmlFile" | sed -nE 's/.*version="([^"]+)".*/\1/p')

# Prompt the user for a new version and replace the old version
read -p "Current version is $currentVersion. Enter new version: " newVersion
sed -i -E "s/(<addon[^>]*version=\")${currentVersion}/\1${newVersion}/" "$addonXmlFile"

echo "Version updated successfully. Exiting."

exit 0
