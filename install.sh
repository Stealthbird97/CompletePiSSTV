#!/bin/bash

this="$PWD"

cd ~
echo Copying pisstv script, replacing HOMEDIR with "$PWD"
sed s@HOMEDIR@"$PWD"@g "$this"/scripts/pisstv.sh > pisstv.sh

echo Setting pisstv script as executable
chmod +x pisstv.sh

echo Update Repositories
sudo apt-get update

echo Installing build essentials
sudo apt-get install build-essential

echo Installing Pi-FM-RDS dependancies
sudo apt-get install libsndfile1-dev

echo Clone Pi-FM-RDS
git clone https://github.com/F5OEO/PiFmRds.git
cd PiFmRds/src
git clone https://github.com/F5OEO/librpitx.git
cd librpitx/src
echo Make Pi-FM-RDS
make
cd ../../
make clean
make

cd ~
echo Installing PiSSTV dependancies
sudo apt-get install libgd-dev libmagic-dev imagemagick

echo Clone PiSSTV
git clone https://github.com/sp2ong/pisstv.git
cd pisstv
make pisstv

read -r -p \
  'Do you want me to overwrite your /etc/rc.local with ours? If you have modified it, probably best not to... (y/N) ' overwrite
if [ "$overwrite" = "y" ]; then
  echo Replacing rc.local, replacing HOMEDIR with "$PWD"
  sed s@HOMEDIR@"$PWD"@g "$this"/config/rc.local | sudo tee /etc/rc.local
else
  echo Please add \""$PWD"/pisstv.sh \&\" to your rc.local or equivalent
fi
echo All done. Reboot your Pi and it should start beeping!
