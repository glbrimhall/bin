#!/bin/bash
for dir in bluray1 bluray2 bluray3 bluray4 dvd1 dvd2 data1; do
  if [ "$USER" = "root" ]; then
    #mkdir -p /reaper/$dir
    #mount reaper:/$dir /reaper/$dir -t nfs4 -o tcp,rw,soft,noatime
    mount /reaper/$dir 
  else
    #mkdir -p /reaper/$dir
    echo "mount reaper/$dir"
    mount ~/reaper/$dir
  fi
done

