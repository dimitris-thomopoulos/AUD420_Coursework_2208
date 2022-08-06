// Simple example of panning for 2-channel stereo using Pan2:
p = {Pan2.ar(in: PinkNoise.ar, pos: SinOsc.kr(2), level: 0.1)}.play;
p.free;

// Another, more complex example:
(
x = {
	var lfn = LFNoise2.kr(1);
	var saw = Saw.ar(
		freq: 30,
		mul: LFPulse.kr(
		freq: LFNoise1.kr(1).range(1, 10),
		width: 0.1));
	var bpf = BPF.ar(in: saw, freq: lfn.range(500, 2500), rq: 0.01, mul: 20);
	Pan2.ar(in: bpf, pos: lfn);
}.play;
)
x.free;




// Mix and Splay
// We can use multichannel expansion to generate complex sounds, and then mix it all down to mono or stereo with Mix or Splay:

// 5 channels output (watch Meter window)
a = { SinOsc.ar([100, 300, 500, 700, 900], mul: 0.1) }.play;
a.free;

// Mix it down to mono:
b = { Mix(SinOsc.ar([100, 300, 500, 700, 900], mul: 0.1)) }.play;
b.free;

// Mix it down to stereo (spread evenly from left to right)
c = { Splay.ar(SinOsc.ar([100, 300, 500, 700, 900], mul: 0.1)) }.play;
c.free

// Fun with Splay:
(
d = {
	arg fundamental = 110;
	var harmonics = [1, 2, 3, 4, 5, 6, 7, 8, 9];
	var snd = BPF.ar(
		in: Saw.ar(32, LFPulse.ar(harmonics, width: 0.1)),
		freq: harmonics * fundamental,
		rq: 0.01,
		mul: 20);
	Splay.ar(snd);
}.play;
)

d.set(\fundamental, 100); // change fundamental just for fun
d.free;


// Instant cluster generator
c = { Mix.fill(16, {SinOsc.ar(rrand(100, 3000), mul: 0.01)}) }.play;
c.free;
// A note with 12 partials of decreasing amplitudes - first argument: size of array we want to create, second argument: a function that will be used to fill up the array.
(
n = { Mix.fill(12,
	{arg counter;
	var partial = counter + 1; // we want it to start from 1, not 0
	SinOsc.ar(partial * 440, mul: 1/partial.squared) * 0.1
 })
}.play;
FreqScope.new;
)
n.free;