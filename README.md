# ```camctrl```
Qt-based UI for camera control on the Raspberry Pi's 7" touch display.

## Applications

- Embedded DIY DSLM camera
- Synchronous timelapse controller for CNC manufacturing processes, such as 3D printing, milling, or turning
- Camera controller for optical microscopy

## Examples

# Installation
###### Before proceeding, please read the notice at the bottom of this README

# Notice
```camctrl``` is designed to be used as a standalone, embedded application on a *dedicated* Raspberry Pi. I recommend against using it on a device you need for something else. The program uses root privileges, and is intended to autostart on boot. I offer no insurance the software is bug-free. I've put a lot of work into this, but I'm not perfect. 

If you want/need ```camctrl``` to not autostart (such as for debugging, you only want to use some of its command-line tools, or you aren't using it on an embedded system), there is a configuration option to make it so. When you run ./configure immediately before installation, answer no to "Do you want camctrl to autostart on boot (embedded applications)?"

The application uses sudo priviliges for fast memory mapping over /dev/mem. I know /dev/gpiomem is available and does not require root. However, I have chosen to remain with /dev/mem for two reasons: I will need it for planned future features, and the program's nature as an (intended) embedded application effectively necessitates its backend to have elevated privileges. Privileges in the "userspace"/frontend are normal. 

Read the scripts and make sure you understand them before you run them. Always know what you are installing on your devices.
