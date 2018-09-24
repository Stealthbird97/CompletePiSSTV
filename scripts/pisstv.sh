#!/bin/bash

cd HOMEDIR
while true; do
  echo taking
  date
  raspistill --width 320 --height 240 -o sstv.jpg
  echo superimposing
  date
  convert sstv.jpg -fill white -stroke black -pointsize 16 -annotate +50+50 'G3KMI de M0YCH\nQTH: University of Southampton\nWelcome!' sstv-out.jpg
  echo converting
  date
  ./pisstv/pisstv -p r36 sstv-out.jpg
  touch lock
  echo moving
  mv sstv-out.jpg.wav sstv-out.wav
  rm -f lock
  echo sending
  date
  while [ -f lock ]; do
    true
  done
  cat sstv-out.wav | sudo ./PiFmRds/src/pi_fm_rds -freq 145.200 -audio - -ps G3KMI -rt "G3KMI SSTV"
  echo repeating
  date
done
