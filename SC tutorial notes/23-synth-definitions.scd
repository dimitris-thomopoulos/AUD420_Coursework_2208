// Synth definition with SynthDef object
SynthDef("mySine1", {Out.ar(0, SinOsc.ar(770, 0, 0.1))}).add;

// Play a note with Synth object
x = Synth("mySine1");
x.free;

// A slightly more flexible example using arguments
// and a self-terminating envelope (doneAction: 2)
(
SynthDef("mySine2", {arg freq = 440, amp = 0.1;
	var env = Env.perc(level: amp).kr(2);
	var snd = SinOsc.ar(freq, 0, env);
	Out.ar(0, snd);
}).add;
)

Synth("mySine2"); // using default values
Synth("mySine2", [\freq, 920, \amp, 0.2]);
Synth("mySine2", [\freq, 830, \amp, 0.1]);
Synth("mySine2", [\freq, 346, \amp, 0.3]);
Synth("mySine2", [\freq, rrand(440, 880)]);

/*
After we have created one or more synth definitions with SynthDef, we can play them with
Synth: the first argument is the name of the synth definition we want to use, and the second
(optional) argument is an array with any parameters we may want to specify (freq, amp, etc.)
*/

s.reboot;

// Create SynthDef
(
SynthDef("wow", {arg freq = 60, amp = 0.1, gate = 1, wowrelease = 3;
	var chorus, source, filtermod, env, snd;
	chorus = Lag.kr(freq, 2) * LFNoise2.kr([0.4, 0.5, 0.7, 1, 2, 5, 10]).range(1, 1.02);
	source = LFSaw.ar(chorus) * 0.5;
	filtermod = SinOsc.kr(1/16).range(1, 10);
	env = Env.asr(1, amp, wowrelease).kr(2, gate);
	snd = LPF.ar(in: source, freq: freq * filtermod, mul: env);
Out.ar(0, Splay.ar(snd))
}).add;
)

// Watch the Node Tree
s.plotTree;

// Create a 6-note chord
a = Array.fill(6, {Synth("wow", [\freq, rrand(40, 70).midicps, \amp, rrand(0.1, 0.5)])}); // all in a single line

// Release notes one by one
a[0].set(\gate, 0);
a[1].set(\gate, 0);
a[2].set(\gate, 0);
a[3].set(\gate, 0);
a[4].set(\gate, 0);
a[5].set(\gate, 0);

// ADVANCED: run 6-note chord again, then evaluate this line.
// Can you figure out what is happening?
SystemClock.sched(0, {a[5.rand].set(\freq, rrand(40, 70).midicps); rrand(3, 10)});


// When you do this:
{SinOsc.ar(440)}.play;
// What SC is doing is this:
{Out.ar(0, SinOsc.ar(440))}.play;
// Which in turn is really this:
SynthDef("tempName", {Out.ar(0, SinOsc.ar(440))}).play;

// And all of them are shortcuts to this two-step operation:
SynthDef("tempName", {Out.ar(0, SinOsc.ar(440))}).add; // create a synth definition
Synth("tempName"); // play it





