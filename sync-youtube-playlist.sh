#!/bin/bash
if [ $# -lt 1 ]; then
  echo "Pass the path to a YouTube-dl archive file created with the --download-archive option. "
  echo "Usage: `basename $0` already_downloaded.txt"
  exit
else
  archive_file="$1"
  echo "Looking up videos in directory against $archive_file..."
  echo
  echo "The following files in the directory could not be found in $archive_file:"
  echo 
  shopt -s nullglob # Don't report when any of the below extensions can't be found
  for i in *.mp4 *.mkv *.webm *.mov; do # whitelist approach rather than having to conditionally check for non-video files
  filename="${i##*-}" # get video ID and extension 
  video_id="${filename%.*}" # strip extension
  if ! grep -iq "$video_id" "$archive_file"; then # look up the video against YouTube-DL archive file 
    ln=$((ln+=1)) # line numbers
    echo "$ln) $i"
  fi
  done
fi