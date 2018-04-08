
sourcefile=$1
destfile=$2

# Overly simple validation
if [ ! -e "$sourcefile" ]; then
  echo 'Please provide an existing input file.'
  exit
fi

if [ "$destfile" == "" ]; then
  echo 'Please provide an output preview file name.'
  exit
fi

# check that ffmpeg and ffprobe exists
command -v ffmpeg >/dev/null || {
  echo 'ffmpeg command not found, aborting.'
  exit 1
}

ffmpeg -i $sourcefile -acodec libmp3lame -ab 128k "$sourcefile.mp3"
