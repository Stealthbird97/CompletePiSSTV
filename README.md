# CompletePiSSTV

Automated install of a number of packages for SSTV on a Raspberry Pi.



## Installation
This program utilises submodules. Be sure to use:
```
git clone --recursive
```
otherwise you will not have everything required.

Run install.sh as non-root user on a reasonably vanilla Raspbian installation.
This script has been tested to work on a Raspberry Pi model A running Raspbian Stretch Lite, however, as all programs are built by the script, it should work on any Pi model and any debian based OS
.
It's a rather messy script because it was all hacked together, but it should work. Some attempt to clean it up has been made but that is mainly a result that the script uses completely different programs than used by the original by Muzer.

## Packages
This script automates installation of
* Pi-FM-RDS (Generate FM signal on Pi GPIO 4)
* PiSSTV (Converts image from camera into chosen SSTV mode)
