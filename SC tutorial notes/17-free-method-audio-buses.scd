// Run one line at a time (don't stop the sound in between):
a = { Saw.ar(LFNoise2.kr(8).range(1000, 2000), mul: 0.2) }.play;
b = { Saw.ar(LFNoise2.kr(7).range(100, 1000), mul: 0.2) }.play;
c = { Saw.ar(LFNoise0.kr(15).range(2000, 3000), mul: 0.1) }.play;

// Stop synths individually:
a.free;
b.free;
c.free;


// the set message changes synth parameters on the fly (while synth is running)

x = {arg freq = 440, amp = 0.1; SinOsc.ar(freq, 0, amp)}.play;
x.set(\freq, 778);
x.set(\amp, 0.5);
x.set(\freq, 920, \amp, 0.2);
x.free;



// AUDIO BUSES (128 buses)
// 0-7 audio buses are reserved for output channels of our sound card. 0 for left channel and 1 for right channel. The rest (3-7) are for 8-channel sound cards.
// 8-15 audio buses are reserved for input channels of our sound card
// the rest (16-128) buses are free for any kind of use

{Out.ar(1, SinOsc.ar(440, 0, 0.1))}.play; // right channel

// lets make a new effect
//start the effect (In.ar is the UGen we use to read from an audio bus; in this case, we use bus 55). 'rq' is the argument that defines the Q (width) of the BandPassFilter
f = {Out.ar(0, BPF.ar(in: In.ar(55), freq: MouseY.kr(500, 5000), rq: 0.1))}.play;
// start the source
n = {Out.ar(55, WhiteNoise.ar(0.5))}.play;

// order of execution matters, if we first started the source and THEN started the effect, it wouldn't work.




// Multichannel Expansion (open the meter with Ctrl + M)
// the amplitude slowly rises from 0 to 1 with a linear way (sound fade-in effect)
{Out.ar(0, Saw.ar(freq: [440, 570], mul: Line.kr(0, 1, 10)))}.play;

s.volume.gui;

/*
IMPORTANT NOTES (for the above line):
if you use an array anywhere as one of the arguments of a UGen, the entire patch
is duplicated. The number of copies created is the number of items in the array. These duplicated
UGens are sent out to as many adjacent buses as needed, starting from the bus specified as the
first argument of Out.ar. This is the reason why the above line produces stereo sound and not only sound coming from the left speaker (which corresponds to bus 0).
*/

// using multichannel expansion for another effct: calling tone
a = {Ou>t.ar(0, SinOsc.ar(freq: [440, 480], mul: LFPulse.ar(0.4)))}.play;
a.free;