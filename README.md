# gopro-metaxtractor
Windows GUI Tool for extracting GPS metadata from GoPro Action Camera videos (GPX Format)

## Synopsis
So yeah, I just wanted a decent way of getting the GPS data out of my GoPro cameras for use with telemetry overlay applications such as RaceRender as well as directly ingesting the data into my various video workflows. It's kind of hot garbage right now, I'm working on it. when I have time.

## Prerequisites and Dependencies
Since, as you may have noticed, this is powershell, Windows would probably be best, especially since it relies solely on the Windows Presentation Foundation (It's a GUI!)

You should probably already have the following installed if you can.

- Python 3
- ffmpeg
- [gopro2gpx](https://github.com/juanmcasillas/gopro2gpx)

You don't necessarily have to worry about getting these setup manually.  My script has an automated dependencies check and can install the required dependencies for you.
If you're curious about what gets installed and how heres a quick list:

- Python 3 from WinGet
- Chocolatey from the official site
- Git from Chocolatey
- ffmpeg from Chocolatey
- gopro2gpx from Juan Casillas [Repository](https://github.com/juanmcasillas/gopro2gpx) here on github.

It's safe if you understand Powershell otherwise, who really knows, right?  ¯\_(ツ)_/¯

## Usage
Just run the script from any directory.  No arguments.

