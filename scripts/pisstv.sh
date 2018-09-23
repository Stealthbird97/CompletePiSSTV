#!/bin/bash

cd HOMEDIR
while true; do
  echo taking
  date
  raspistill --width 320 --height 240 -o sstv.jpg
  echo superimposing
  date
  convert sstv.jpg -fill white -stroke black -pointsize 16 -annotate +50+50 'G3KMI de M0HWY\nQTH: University of Southampton\nWelcome!' sstv-out.jpg
  echo converting
  date
  PYTHONPATH=HOMEDIR/.local/lib/python2.7/site-packages/pysstv python -m pysstv --mode Robot36 sstv-out.jpg sstv-out-tmp.wav
  touch lock
  echo moving
  mv sstv-out-tmp.wav sstv-out.wav
  rm -f lock
done &
while true; do
  echo sending
  date
  while [ -f lock ]; do
    true
  done
  cat HOMEDIR/sstv-out.wav | ./pi_fm_rds -freq 145.200 -audio - -ps G3KMI -rt "G3KMI SSTV"
  ./pifm sstv-out.wav 145.200 48000
  echo repeating
  date
done
