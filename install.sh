#!/bin/bash

this="$PWD"

cd ~
echo Copying pisstv script, replacing HOMEDIR with "$PWD"
sed s@HOMEDIR@"$PWD"@g "$this"/scripts/pisstv.sh > pisstv.sh

echo Setting pisstv script as executable
chmod +x pisstv.sh

echo Installing Pi-FM-RDS Dependancies
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

echo Installing PySSTV
sudo apt-get update
sudo apt-get install python-pip
pip install PySSTV

echo Installing Python Imaging
sudo apt-get install python-imaging imagemagick

read -r -p \
  'Do you want me to overwrite your /etc/rc.local with ours? If you have modified it, probably best not to... (y/N) ' overwrite
if [ "$overwrite" = "y" ]; then
  echo Replacing rc.local, replacing HOMEDIR with "$PWD"
  sed s@HOMEDIR@"$PWD"@g "$this"/config/rc.local | sudo tee /etc/rc.local
else
  echo Please add \""$PWD"/pisstv.sh \&\" to your rc.local or equivalent
fi
echo All done. Reboot your Pi and it should start beeping!
