#!/bin/bash

# Set the target directory
dir="./"

# Make a new directory to store the output
mkdir "$dir/output"

# Create a list of all png files in the directory
files=$(find "$dir" -maxdepth 1 -type f -name "*.png")

#Set output file name
output_file="all_images.png"

#set border color 
border_color=""

#number of random files to pick
file_count=5

while getopts "bwr:" opt; do
  case $opt in
    b)
      border_color="black"
      ;;
    w)
      border_color="white"
      ;;
    r)
      file_count="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

if [ $file_count -gt 0 ]; then
  #pick random files
  random_files=$(shuf -n $file_count -e $files)
  files=$random_files
fi

#Check if output file already exists
if [ -f "$dir/output/$output_file" ]; then
  i=1
  #If output file already exists, append number to the file name
  while [ -f "$dir/output/${output_file%.*}($i).png" ]; do
    ((i++))
  done
  output_file="${output_file%.*}($i).png"
fi

# Use the 'convert' command to add a 10px border around each image and combine all images in the list
if [ ! -z "$border_color" ]; then
    gm convert $files -bordercolor $border_color -border 10x10 +append "$dir/output/$output_file"
else
    gm convert $files +append "$dir/output/$output_file"
fi
