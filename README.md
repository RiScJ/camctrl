# ```camctrl```
Qt-based UI for camera control on the Raspberry Pi's 7" touch display.

## Applications

- Embedded DIY DSLM camera
- Synchronous timelapse controller for CNC manufacturing processes, such as 3D printing, milling, or turning
- Camera controller for optical microscopy

## Examples

# Installation
###### Before proceeding, please read the notice at the bottom of this README
#### Download
Clone the repository and change working directory:

`$ git clone https://github.com/RiScJ/camctrl && cd camctrl`

#### Retrieve and install dependencies
```camctrl``` is built in Qt and requires many of its modules. To install them, run:

`$ ./setup`

The list of dependencies is located in cfg/dependencies.

#### Configuration
The configuration script will make certain modifications to the programs behavior, including such things as autostart. While you can choose to enable autostart on your first installation, it isn't recommended you do so. Instead, you should ensure the program runs as expected for you first. When you are satisfied with your installation and its behavior for your application, you can enable it then. Details on how to do this are found below. To configure, run:

`$ ./configure`

You will be asked a variety of questions. They are important -- read them carefully!

#### Install
The installation script will handle the build process, and then copy binaries and static resources to /usr/local/bin and /usr/local/share/camctrl respectively. To install, run:

`$ ./install`

#### Clean
Before cleaning, it would be wise to test the installation. To do so, run:

`$ camctrl -t`

This will run through an array of tests, and return a report at the end. If all tests passed, you can remove our temporary directory:

`$ ./clean all`

If you want to retain the sources, but remove the intermediary build files, you can:

`$ ./clean build`

# Usage

```camctrl``` comes with a GUI (its main purpose), but it also comes with a set of commandline tools mostly designed for debugging before deploying to your application.

## Commandline

### -t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--test
Runs a series of tests on the application. Prints their results as they come in. At the end, a report is generated detailing any problems.

### -G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--gpio
Displays a live reading in the commandline of measured GPIO levels. Good for testing your external triggering circuits.

### -f&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--fuse
Enables autostart, beginning with the next boot. You'll be asked to confirm before continuing. This is of course just a software behavior, and not a real fuse. I call it that because if at a later time you decide you want to disable the autostart behavior, it's going to be somewhat of a nuisance. You'll have to remove the SD card, mount it on another machine, and edit rc.local.

## Graphical interface
Detailed instructions on using the graphical interface are located in /docs. This documentation is also available from within the application itself.

#  
#  
#  
#  

# Notice
```camctrl``` is designed to be used as a standalone, embedded application on a *dedicated* Raspberry Pi. I recommend against using it on a device you need for something else. The program uses root privileges, and is intended to autostart on boot. I offer no insurance the software is bug-free. I've put a lot of work into this, but I'm not perfect. 

If you want/need ```camctrl``` to not autostart (such as for debugging, you only want to use some of its command-line tools, or you aren't using it on an embedded system), there is a configuration option to make it so. When you run ./configure immediately before installation, answer no to "Do you want camctrl to autostart on boot (embedded applications)?"

The application uses sudo priviliges for fast memory mapping over /dev/mem. I know /dev/gpiomem is available and does not require root. However, I have chosen to remain with /dev/mem for two reasons: I will need it for planned future features, and the program's nature as an (intended) embedded application effectively necessitates its backend to have elevated privileges. Privileges in the "userspace"/frontend are normal. 

Read the scripts and make sure you understand them before you run them. Always know what you are installing on your devices.
&nbsp;
