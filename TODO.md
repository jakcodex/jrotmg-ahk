# <span style="color: #005abc;">Main Program TODO List</span>
1. Config should be relocated to the app storage folder
2. Program source should be copied to the app storage folder
   a. The idea here being to make updating easier
3. Screenshot filter regions fully customizable with easy region setup
4. Move Timelapse to its own class
5. Add voice recording capabilities (possibly paired with low-hp detection) 
   - Segment audio like shared bitmap to provide recent playback
   - Low-hp Nexuses or deaths could have small video clips created to highlight your despair or relief
6. Video Recording Mode (because why not - https://ffmpeg.org/ffmpeg-devices.html#gdigrab)
   - Same low-hp detection features as voice recording

## <a title="timelapsevideo" style="color: #005abc;">Timelapse Video Creator</a>
Requires ffmpeg which will not be provided in the release due to size. 

Reference: http://ffmpeg.zeranoe.com/builds/

#### <span style="color: #177cdf;">Video Modes</span>
   
##### Mode: session
This mode will record video from that point up until timelapse is disabled. 

##### Mode: timed
This mode will record video from that point up until the clock expires.
 
##### Mode: relative
This mode will record video of existing timelapse footage going back the specified length in time.

##### Mode: stitch
This mode will record video between multiple timelapse points as defined by the user. User will select start/stop points
from existing timelapse footage to stitch together the required video parts.

## <a title="voicerecorder" style="color: #005abc;">Voice Recorder</a>
Keeps computer and/or microphone audio from the past x seconds like the PixelState SharedBitmap.

## <a title="newfeatures" style="color: #005abc;">Potential New Features</a>

#### <span style="color: #177cdf;">Record That</span>
Create a clip of the previous x seconds. Modes of operation: timelapse+audio, video

##### Mode: timelapse+audio
A timelapse clip is created with game/voice audio dubbed over.
 
##### Mode: video
A video clip is created using the shared video data.
 
#### <span style="color: #177cdf;">Danger Zone Clips</span>
When nexusing at low hp or upon death a timelapse clip or video can be created (same modes as Record That)

# <span style="color: #005abc;">Manage Utility TODO List</span>
1. Installations using setup.ahk store the app source in StoragePath/src
2. config.ahk is rewritten to redirect the include to StoragePath/src
3. Literally everything including rewriting the initial code (those were baby steps)