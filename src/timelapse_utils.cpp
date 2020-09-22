#include <stdio.h>
#include <stdlib.h>

#include "timelapse_utils.h"

int TimelapseUtils::encodingRate = 30;

void TimelapseUtils::stitch(const QString dirPath) {
	std::string cmd = "cd " + dirPath.toStdString() + " && \
					   ffmpeg -r " + std::to_string(encodingRate) + " -f image2 -i FRM_%04d.jpg -vcodec libx264 -crf 25 -pix_fmt yuv420p temp.mp4 && \
					   ls -l | grep LPS | wc -l | xargs printf \"%04d\" | xargs -I % mv temp.mp4 LPS_%.mp4 && \
					   rm FRM_*";

	system(cmd.c_str());
};


void TimelapseUtils::update_encodingRate(int rate) {
	encodingRate = rate;
};
