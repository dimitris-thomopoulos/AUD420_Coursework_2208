// open the GUI
s.plotTree;
// run these one by one (don't stop the sound) and watch the Node Tree:
w = { SinOsc.ar(60.midicps, 0, 0.1) }.play;
x = { SinOsc.ar(64.midicps, 0, 0.1) }.play;
y = { SinOsc.ar(67.midicps, 0, 0.1) }.play;
z = { SinOsc.ar(71.midicps, 0, 0.1) }.play;
w.free;
x.free;
y.free;
z.free;


// Evaluate and watch the Node Tree window for a few seconds
x = {WhiteNoise.ar(Line.kr(0.2, 0, 2))}.play;
x.free;


// The glorious 'doneAction: 2'
// without doneAction: 2
{WhiteNoise.ar(Line.kr(0.2, 0, 2))}.play;
{PlayBuf.ar(1, ~buf1)}.play; // PS. this assumes you still have your sound file loaded into ~buf1 from previous section

// with doneAction: 2
{WhiteNoise.ar(Line.kr(0.2, 0, 2, doneAction: 2))}.play;
{PlayBuf.ar(1, ~buf1, doneAction: 2)}.play;