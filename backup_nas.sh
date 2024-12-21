#!/usr/bin/bash

# Restore function that is the inverse of backup_nas_other
function restore_nas_other(){
  local restore_data=$1
  local restore_music=$2
  local restore_photo=$3
  local restore_path="/mnt/backup/archive/2024"
  local restore_log="restore_$(date +'%m_%d_%Y_%H_%M').log"
  local data_path="/volume1/data"
  local music_path="/volume1/music"
  local photo_path="/volume1/photo"
  if [ -d $restore_path ]; then
    if [ -d $data_path ]; then
      cd $data_path
      echo "Restoring file $restore_data with tar" 2>&1 | tee $restore_log
      time tar -vxf $restore_path/$restore_data 2>&1 | tee -a $restore_log
    else
      echo "$data_path not found"
    fi

    if [ -d $music_path ]; then
      cd $music_path
      echo "Restoring file $restore_music with tar" 2>&1 | tee $restore_log
      time tar -vxf $restore_path/$restore_music 2>&1 | tee -a $restore_log
    else
      echo "$music_path not found"
    fi

    if [ -d $photo_path ]; then
      cd $photo_path
      echo "Restoring file $restore_photo with tar" 2>&1 | tee $restore_log
      time tar -vxf $restore_path/$restore_photo 2>&1 | tee -a $restore_log
    else
      echo "$photo_path not found"
    fi
  else
    echo "couldn't find restore $restore_path directory, bailing"
  fi
}

# Check the space required and ensure you have enough space
# before starting the tar's
function backup_nas_other(){
  local backup_path="/media/$(whoami)/nas_backup/archive"
  local backup_log="backup_$(date +'%m_%d_%Y_%H_%M').log"
  local data_path="/mnt/nas/data"
  local music_path="/mnt/nas/music"
  local photo_path="/mnt/nas/photo"
  if [ -d $backup_path ]; then
    mkdir -p $backup_path/$(date +'%Y')
    if [ -d $data_path ]; then
      echo "Backing up the $data_path folder with tar" 2>&1 | tee $backup_log
      time tar -czf $backup_path/$(date +'%Y')/data_$(date +'%m_%d_%Y_%H_%M').tar.gz $data_path 2>&1 | tee -a $backup_log
    else
      echo "$data_path not found"
    fi

    if [ -d $music_path ]; then
      echo "Backing up the $music_path folder with tar" 2>&1 | tee -a $backup_log
      time tar -czf $backup_path/$(date +'%Y')/music_09.29.2024.tar.gz $music_path 2>&1 | tee -a $backup_log
    else
      echo "$music_path not found"
    fi

    if [ -d $photo_path ]; then
      echo "Backing up the $photo_path folder with tar" 2>&1 | tee -a $backup_log
      time tar -czf $backup_path/$(date +'%Y')/photo_$(date +'%m_%d_%Y_%H_%M').tar.gz $photo_path 2>&1 | tee -a $backup_log
    else
      echo "$photo_path not found"
    fi
  else
    echo "couldn't find backup $backup_path directory, bailing"
  fi
}

# Check the space required and ensure you have enough space
# before starting the rsync
function backup_nas_tv(){
  local backup_path="/mnt/backup/tv_shows"
  local backup_log="tv_shows_$(date +'%m_%d_%Y_%H_%M').log"
  local tv_path="/volume1/video/tv_shows"
  echo "tv_path is $tv_path"
  if [ -d $backup_path ]; then
    if [ -d $tv_path ]; then
      date 2>&1 | tee $backup_log
      echo "Backing up the $tv_path folder with tar" 2>&1 | tee -a $backup_log
      time sudo rsync -avR --progress $tv_path $backup_path 2>&1 | tee -a $backup_log
    else
      echo "$tv_path not found"
    fi

  else
    echo "couldn't find backup $backup_path directory, bailing"
  fi
}


# Check the space required and ensure you have enough space
# before starting the rsync
function backup_nas_movies(){
  local backup_path="/mnt/backup/movies"
  local backup_log="movies_$(date +'%m_%d_%Y_%H_%M').log"
  local movie_path="/mnt/backup/movies"
  if [ -d $backup_path ]; then
    if [ -d $movie_path ]; then
      date
      echo "Backing up the $movie_path folder with rsync" 2>&1 | tee $backup_log
      time sudo rsync -avR --progress $movie_path $backup_path 2>&1 | tee tv_$(date +'%m_%d_%Y_%H_%M').log
    else
      echo "$movie_path not found"
    fi

  else
    echo "couldn't find backup $backup_path directory, bailing"
  fi
}

usage() {
  echo "Usage: $0
         [-d backup data/music/photo (~0.5TB)]
         [-t backup video/tv shows (~5.5TB)]
         [-m backup video/movies (~4.4TB)]" 1>&2;
  exit 1;
}

while getopts ":dtm" o; do
    case "${o}" in
        d)
            d=True
            ;;
        t)
            t=True
            ;;
        m)
            m=True
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${d}" ] && [ -z "${t}" ] && [ -z "${m}" ]; then
    usage
fi

if [ ${d} ]; then
  backup_nas_other
fi
if [ ${t} ]; then
  backup_nas_tv
fi
if [ ${m} ]; then
  backup_nas_movies
fi
