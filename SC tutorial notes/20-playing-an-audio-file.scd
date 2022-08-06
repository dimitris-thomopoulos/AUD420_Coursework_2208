// Load files into buffers:
~buf1 = Buffer.read(s, "/home/Music/wheels􀀀mono.wav"); // one sound file
~buf2 = Buffer.read(s, "/home/Music/mussorgsky.wav"); // another sound file

// Playback:
{PlayBuf.ar(1, ~buf1)}.play; // number of channels and buffer
{PlayBuf.ar(1, ~buf2)}.play;

// Get some info about the files:
[~buf1.bufnum, ~buf1.numChannels, ~buf1.path, ~buf1.numFrames];
[~buf2.bufnum, ~buf2.numChannels, ~buf2.path, ~buf2.numFrames];

// Changing playback speed with 'rate'
{PlayBuf.ar(numChannels: 1, bufnum: ~buf1, rate: 2, loop: 1)}.play;
{PlayBuf.ar(1, ~buf1, 0.5, loop: 1)}.play; // play at half the speed
{PlayBuf.ar(1, ~buf1, Line.kr(0.5, 2, 10), loop: 1)}.play; // speeding up
{PlayBuf.ar(1, ~buf1, MouseY.kr(0.5, 3), loop: 1)}.play; // mouse control

// Changing direction (reverse)
{PlayBuf.ar(1, ~buf2, 􀀀1, loop: 1)}.play; // reverse sound
{PlayBuf.ar(1, ~buf2, 􀀀0.5, loop: 1)}.play; // play at half the speed AND reversed