#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <cstdlib>
#include <string>
#include <iterator>

#include "camera_utils.h"



void CameraUtils::start(QString mode) {
    switch (resolve(mode)) {
    case IMG: start_still(); break;
    case VID: start_vid(); break;
    case LPS: start_lapse(); break;
    default: break;
    };
};


void CameraUtils::stop(void) {
    stop_still();
    stop_vid();
    stop_lapse();
};


void CameraUtils::capture(QString mode) {
    switch (resolve(mode)) {
    case IMG: capture_still(); break;
    case FRM: capture_frame(); break;
    default: break;
    };
};


void CameraUtils::record(void) {
    std::string cmd;
    cmd = "pgrep raspivid | xargs -I % kill -USR1 % && \
        cd " + homeDir + ".camctrl/Projects/" + project + " && \
        ls -1 | grep VID | wc -l | xargs printf \"%04d\" | xargs -I % mv vid.h264 VID_%.h264";
    system(cmd.c_str());
};


void CameraUtils::set_project(QString proj) {
    project = proj.toStdString();
};


void CameraUtils::set_homeDir(std::string dir) {
    homeDir = dir;
}


// Private

std::string CameraUtils::homeDir = "/home/pi/";
std::string CameraUtils::project = "example";



std::string CameraUtils::get_preview_arg(void) {
    std::string arg = "-p '" +
            std::to_string(CAMERA_VIEWPORT_X) + "," +
            std::to_string(CAMERA_VIEWPORT_Y) + "," +
            std::to_string(CAMERA_VIEWPORT_WIDTH) + "," +
            std::to_string(CAMERA_VIEWPORT_HEIGHT) + "'";
    return arg;
};


void CameraUtils::start_still(void) {
    stop();
    std::string cmd = "raspistill " + get_preview_arg() +
            " -t 0 -s -o " + homeDir + ".camctrl/Projects/" +
        project + "/img.jpg &";
    system(cmd.c_str());
};


void CameraUtils::capture_still(void) {
    std::string cmd;
    cmd = "pgrep raspistill | xargs -I % kill -USR1 % && \
        cd " + homeDir + ".camctrl/Projects/" + project + " && \
        ls -1 | grep IMG | wc -l | xargs printf \"%04d\" | xargs -I % mv img.jpg IMG_%.jpg";
    system(cmd.c_str());
};


void CameraUtils::stop_still(void) {
    std::string cmd = "killall -q raspistill";
    system(cmd.c_str());
};


void CameraUtils::start_vid(void) {
    stop();
    std::string cmd = "raspivid " + get_preview_arg() +
            " -t 0 -b 17000000 -fps 30 -cd H264 -s -o " + homeDir + ".camctrl/Projects/" +
        project + "/vid.h264 &";
    system(cmd.c_str());
};


void CameraUtils::stop_vid(void) {
    std::string cmd = "killall -q raspivid";
    system(cmd.c_str());
};


void CameraUtils::start_lapse(void) {
    stop();
    std::string cmd = "raspistill " + get_preview_arg() +
            " -t 0 -s -o " + homeDir + ".camctrl/Projects/" +
        project + "/lps.jpg &";
    system(cmd.c_str());
};


void CameraUtils::capture_frame(void) {
    std::string cmd;
    cmd = "pgrep raspistill | xargs -I % kill -USR1 % && \
        cd " + homeDir + ".camctrl/Projects/" + project + " && \
        ls -1 | grep FRM | wc -l | xargs printf \"%04d\" | xargs -I % mv lps.jpg FRM_%.jpg";
    system(cmd.c_str());
};


void CameraUtils::stop_lapse(void) {
    std::string cmd = "killall -q raspistill";
    system(cmd.c_str());
};


Mode CameraUtils::resolve(QString mode) {
    if (mode == "IMG") return IMG;
    if (mode == "VID") return VID;
    if (mode == "LPS") return LPS;
    if (mode == "FRM") return FRM;
    return NUL;
}
