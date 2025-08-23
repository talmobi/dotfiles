
sourcefile=$1
destination=$2
suffix=".mp4"

# check that ffmpeg exists
command -v ffmpeg >/dev/null || {
  echo 'ffmpeg command not found, aborting.'
  exit 1
}

# Overly simple validation
if [ ! -e "$sourcefile" ]; then
  echo 'Please provide an existing input file. (arg 1)'
  exit
fi

if [ "$destination" == "" ]; then
  echo 'Please provide an output file name. (arg 2)'
  exit
fi

# Check if destination already ends with the suffix
if [[ "$destination" == *"$suffix" ]]; then
  output_filename="$destination"  # Already has suffix, use as-is
else
  output_filename="$destination$suffix"  # Append the suffix
fi


# ffmpeg -i $sourcefile -codec copy -movflags +faststart "$destination.mp4"
ffmpeg -i "$sourcefile" -c:v libx264 -crf 23 -c:a aac -movflags faststart "$output_filename"
