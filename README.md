# gopro-metaxtractor
Windows GUI Tool for extracting GPS metadata from GoPro Action Camera videos (GPX Format)  Supports GoPro Hero 5 and later.

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

It's safe if you understand Powershell otherwise, who really knows, right?  ¯\\_(ツ)_/¯

## Usage
Just run the script from any directory.  No arguments.  If you double click to run, you'll get no console window.  If you run from the console, it'll minimize your console window.

```
./GoPro-Metaxtractor.ps1
```

Dependency Installer automagically elevates in order to install the new software using Winget and Choco.  Additionally, it'll create a stub file to let the program know that it's already done the dependency scan and/or install.

Main Screen where you can either process a single video file or a folder full of videos. 

![Main Screen](/gopromx1.png)

About page:

![About Page](/gopromx2.png)

## Known Issues
- Depending upon when the GoPro received it's GPS lock, the metadata may be skewed in time relative to the video requiring finnicky adjustment in whatever tool you're using.  This is mostly an issue for FPV pilots who just hit the record button and then take off letting the GoPro power on and start recording immediately.  If you power it up and let it get it's lock for a few minutes, you'll have no drift.
- GUI issues abound.  For whatever reason, I can't update the progress bar or the status text while it's running.  No clue why.  Feel free to show me how dumb I am.
- Writes the GPX file in the same directory as the script then moves it next to the original video file.  If you run the script in a directory you can't write to, it will break.  (Same for installing/validating dependencies.)
- I wrote it in PowerShell, which really has no business being a "programming language" with a GUI but here we are.  I could have done it in .Net but then y'all know how that beast is, no telling who has what installed and .Net runtime isn't a quick install for most folks.  Everyone has WPF and PowerShell.
- I need a hug, a pizza, and maybe a good night's sleep.
- It's hot buttery garbage.

# NEEDS MOAR COWBELL!
