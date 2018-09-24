# CompletePiSSTV

Automated install of a number of packages for SSTV on a Raspberry Pi.



## installation
This program utilises submodules. Be sure to use:
```
git clone --recursive
```
otherwise you will not have everything required.

Run install.sh on a reasonably vanilla Raspbian installation.
It's a rather messy script because it was all hacked together, but it should work.

## Packages
This script automates installation of
* Pi-FM-RDS (Generate FM signal on Pi GPIO 4)
* PiSSTV (Converts image from camera into chosen SSTV mode)
