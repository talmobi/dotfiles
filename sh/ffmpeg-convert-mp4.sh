
sourcefile=$1
destfile=$2

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

if [ "$destfile" == "" ]; then
  echo 'Please provide an output preview file name. (arg 2)'
  exit
fi

ffmpeg -i $sourcefile -codec copy -movflags +faststart "$sourcefile.mp4"
