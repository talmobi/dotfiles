
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

ffmpeg -i "$sourcefile" \
       -c:v libx264 -preset medium -crf 23 -g 60 -keyint_min 30 \
       -c:a aac -b:a 128k \
       -f mp4 \
       -movflags empty_moov+frag_keyframe+default_base_moof+omit_tfhd_offset \
       -frag_size 512000 \
       -reset_timestamps 1 \
       "$output_filename"
