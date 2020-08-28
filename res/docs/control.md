# Controlling the camera

The control window consists of three main areas: a camera preview to the left, a control panel to the right, and a statusbar at the bottom.
###  

The control panel contains an interface for interacting with the camera, and the statusbar gives pertinent information about its state as well as that of the currently-active project.
###  

## Changing the capture mode

```camctrl``` allows capturing media in three different "modes": images, videos, and timelapses. When capturing a timelapse, each trigger event signals the camera to take a single frame. When the timelapse is stopped, these frames can be stitched into a video automatically, or moved to a folder and stored to be stitched at a later time.
###  

To change the capture mode, tap on the "Mode" tile. A menu will appear from which you may select the desired option.
#  

## Changing the trigger mode

The power of the application lies mostly here. ```camctrl``` controls media capture using a "triggering" system, similar to the shutter button on a physical camera. There are three options for what presses this "shutter": manual input from the user; an internal timer; or an external GPIO connection.
###  

To change the triggering mode, tap on the "Trigger" tile. A menu will appear from which you may select the desired option.
###  

### Additional trigger configuration

For information on setting up trigger settings (such as time intervals and GPIO), see the configuration documentation by tapping on the "Config" tile to the right of this screen.
#  

## Capturing media

The exact way media capture works depends on the above selections.
###  

### Images

#### User-controlled

> Tap the "Capture" tile to take a single image.

#### Timed triggering

> Tap the "Capture" tile to begin taking images. Images will be taken non-stop, separated by your specified time interval, until you tap "Stop".

#### External triggering

> Tap the "Capture" tile to begin taking images. An image will be taken each time an edge of your specified type is detected on your specified pin, until you tap "Stop".
##  

### Videos

#### User-controlled

> Tap the "Record" tile to start recording a video. Tap "Stop" to finish.

#### Timed triggering

> Tap the "Record" tile to start the process. Video will start recording after your specified delay time elapses. Video will continue recording until your specified duration time elapses, at which point it will pause. After another delay time, the recording resumes. The cycle will repeat indefinitely until you tap "Stop".

#### External triggering

> Tap the "Record" tile to start the process. Video will start recording when an edge of your specified type is detected on your specified pin. It will continue until another such edge is detected, at which point the video will pause. When another such edge is detected, the video recording resumes. This cycle will continue indefinitely until you tap "Stop".
##  

### Timelapses

#### User-controlled

> Tap the "Lapse" tile to start. Tap the "Capture" tile to take a frame. You may do this as many times as you wish. When you are done, tap "Stop".

#### Timed triggering

> Tap the "Lapse" tile to start. A frame will be taken every time your specified delay time elapses. This will continue until you tap "Stop".

#### External triggering

> Tap the "Lapse" tile to start. A frame will be taken every time an edge of your specified type is detected on your specified pin. This will continue until you tap "Stop".
#  

## The statusbar

The statusbar contains six pieces of information: the name of the currently-active project, the current capture mode, the current triggering mode, trigger-dependent information, the number of mediafiles of the current capture-type that are already in the project, and the current status of the application.
###  

### Capture mode

On a trigger event, the application will...

> IMG -- capture a single image  

> VID -- either start or stop video recording  

> LPS -- start capturing a timelapse  

> FRM -- capture a single timelapse frame  

##  

### Trigger mode

To serve as a trigger event, the application will use...

> USR -- user input  

> TMR -- the internal timer signal  

> EXT -- edges on a GPIO pin  

##  

### Trigger-dependent information

#### User-controlled
> Empty  

#### Timed triggering
> Displays delay time. When started, will count down to next trigger event. If capture mode is VID, when the recording starts the delay time will be replaced with the duration time, which will also count down.  

#### External triggering
> Displays the GPIO pin number to listen for edges on. An arrow is also displayed showing whether to listen for rising or falling edges.  

##  

### Application status  

#### IDLE
> The application is idle. No media is being captured.  

#### LISTENING
> The application is ready to accept a trigger event.  

#### RECORDING
> The application is currently recording video.  

#### CAPTURING
> The application is currently capturing an image or frame. Under typical circumstances, this process should be so fast that this status ought not ever be visible. 
