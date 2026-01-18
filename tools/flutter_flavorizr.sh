#!/bin/bash

# Run flutter_flavorizr using the configuration at tools/flavorizr.yaml

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$SCRIPT_DIR/.."

# Ask user if they want to override existing files
echo "flutter_flavorizr will generate/update flavor configuration files."
echo "This may create or replace files like flavors.dart, app.dart, main.dart, and pages."
echo ""
read -p "Do you want to override existing files? (yes/no): " override_choice

# Convert to lowercase for case-insensitive comparison
override_choice=$(echo "$override_choice" | tr '[:upper:]' '[:lower:]')

# If user doesn't want to override, ask which specific files to preserve
if [ "$override_choice" != "yes" ]; then
    echo ""
    echo "Which files do you want to preserve (skip generation)?"
    echo "You can exclude: flavors, app, pages, main"
    echo "Enter the names separated by commas (e.g., 'app,main' or 'none' to preserve all):"
    read -p "Files to preserve: " preserve_files
    
    preserve_files=$(echo "$preserve_files" | tr '[:upper:]' '[:lower:]' | tr -d ' ')
    
    # Build processor list excluding the ones user wants to preserve
    # Default processors that generate Flutter files
    declare -A processors_to_exclude
    if [[ "$preserve_files" == *"flavors"* ]]; then
        processors_to_exclude["flutter:flavors"]=1
    fi
    if [[ "$preserve_files" == *"app"* ]]; then
        processors_to_exclude["flutter:app"]=1
    fi
    if [[ "$preserve_files" == *"pages"* ]]; then
        processors_to_exclude["flutter:pages"]=1
    fi
    if [[ "$preserve_files" == *"main"* ]]; then
        processors_to_exclude["flutter:main"]=1
    fi
    
    # If user wants to preserve all or specified "none", run without force flag
    if [ -z "$preserve_files" ] || [ "$preserve_files" == "none" ] || [ ${#processors_to_exclude[@]} -eq 0 ]; then
        echo "Running without override (existing files will be preserved)..."
        dart run flutter_flavorizr
    else
        # Build custom processor list excluding the preserved files
        echo "Running with custom processor list (excluding preserved files)..."
        
        # Default processor list (excluding the ones user wants to preserve)
        default_processors=(
            "assets:download"
            "assets:extract"
            "android:androidManifest"
            "android:flavorizrGradle"
            "android:buildGradle"
            "android:dummyAssets"
            "android:icons"
            "ios:podfile"
            "ios:xcconfig"
            "ios:buildTargets"
            "ios:schema"
            "ios:dummyAssets"
            "ios:icons"
            "ios:plist"
            "ios:launchScreen"
            "macos:podfile"
            "macos:xcconfig"
            "macos:configs"
            "macos:buildTargets"
            "macos:schema"
            "macos:dummyAssets"
            "macos:icons"
            "macos:plist"
            "google:firebase"
            "huawei:agconnect"
            "assets:clean"
            "ide:config"
        )
        
        # Add Flutter processors if not excluded
        if [ -z "${processors_to_exclude[flutter:flavors]}" ]; then
            default_processors+=("flutter:flavors")
        fi
        if [ -z "${processors_to_exclude[flutter:app]}" ]; then
            default_processors+=("flutter:app")
        fi
        if [ -z "${processors_to_exclude[flutter:pages]}" ]; then
            default_processors+=("flutter:pages")
        fi
        if [ -z "${processors_to_exclude[flutter:main]}" ]; then
            default_processors+=("flutter:main")
        fi
        
        # Join processors with comma
        processor_list=$(IFS=','; echo "${default_processors[*]}")
        
        dart run flutter_flavorizr -p "$processor_list"
    fi
else
    echo "Running with override enabled..."
    dart run flutter_flavorizr -f
fi
