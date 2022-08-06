// Env is the object we will be using to define all sorts of envelopes. It has many available methods, you can learn more about them in the Help file.

// Env.perc is a handy way to get a percussive envelope. It takes in four arguents: attackTime, releaseTime, level, and curve.

Env.perc.plot; // using all default args
Env.perc(0.5).plot; // attackTime: 0.5
Env.perc(attackTime: 0.3, releaseTime: 2, level: 0.4).plot;
Env.perc(0.3, 2, 0.4, 0).plot; // same as above, but curve:0 means straight lines

// now we can simply hook it up in a synth like this:
{PinkNoise.ar(Env.perc.kr(doneAction: 2))}.play; // default Env.perc args
{PinkNoise.ar(Env.perc(0.5).kr(doneAction: 2))}.play;
{PinkNoise.ar(Env.perc(0.3, 2, 0.4).kr(2))}.play; // notice how we can skip explicitly declaring the 'doneAction' argument
{PinkNoise.ar(Env.perc(0.3, 2, 0.4, 0).kr(2))}.play;


// Env.triangle
// Env.triangle takes only two arguments: duration, and level.

// See it:
Env.triangle.plot;

// Hear it:
{SinOsc.ar([440, 442], mul: Env.triangle.kr(2))}.play;

// By the way, an envelope can be a multiplier anywhere in your code
{SinOsc.ar([440, 442]) * Env.triangle.kr(2)}.play;


// Env.linen
// Env.linen decribes an envelope with attack, sustain portion, and release. You can also specify level and curve type.

// See it:
Env.linen.plot;

// Hear it:
{SinOsc.ar([300, 350], mul: Env.linen(0.01, 2, 1, 0.2).kr(2))}.play;


// Env.pairs
// With Env.pairs we can have envelopes of any shape and duration we want.
// Env.pairs takes two arguments: an array of [time, level] pairs, and a type of curve (see the Env Help file for all available curve types).

(
{
	var env = Env.pairs([[0, 0], [0.4, 1], [1, 0.2], [1.1, 0.5], [2, 0]], \lin);
	env.plot;
	SinOsc.ar([440, 442], mul: env.kr(2));
}.play;
)

// Read the array of pairs like this:
/*
At time 0, be at level 0
At time 0.4, be at level 1
At time 1, be at level 0.2
At time 1.1, be at level 0.5
At time 2, be at level 0
*/

// Nothing is stopping us from using these same shapes to control something other than amplitude.
// We just need to scale them to the desired range of numbers. For example, we can create an envelope to control change of frequencies over time:
(
{
	var freqEnv = Env.pairs([[0, 100], [0.4, 1000], [0.9, 400], [1.1, 555], [2,440]], \lin);
	SinOsc.ar(freqEnv.kr, mul: 0.2);
}.play;
)


// ADSR Envelope ("sustained enevelope")

// ASR
// Play note ('press key')
// attackTime: 0.5 seconds, sustainLevel: 0.8, releaseTime: 3 seconds
x = {arg gate = 1, freq = 440; SinOsc.ar(freq: freq, mul: Env.asr(0.5, 0.8, 3).kr(doneAction: 2, gate: gate))}.play;

// Stop note ('finger off the key' - activate release stage)
x.set(\gate, 0); // alternatively, x.release

// ADSR (attack, decay, sustain, release)
// Play note:
(
d = {arg gate = 1;
	var snd, env;
	env = Env.adsr(0.01, 0.4, 0.7, 2);
	snd = Splay.ar(BPF.ar(Saw.ar((32.1, 32.2..33)), LFNoise2.kr(12).range(100,1000), 0.05, 10));
	Out.ar(0, snd * env.kr(doneAction: 2, gate: gate));
}.play;
)
// Stop note:
d.release; // this is equivalent to d.set(\gate, 0);


// Attack: The time (in seconds) that it takes to go from zero (silence) to peak amplitude
// Decay: The time (in seconds) that it takes to go down from peak amplitude to sustain amplitude
// Sustain: The amplitude (between 0 and 1) at which to hold the note (important: this has nothing to do with time)
// Release: The time (in seconds) that it takes to go from sustain level to zero (silence).

// Since sustained envelopes do not have a total duration known in advance, they need a notification as to when to start (trigger the attack) and when to stop (trigger the release).
// This notification is called a gate. The gate is what tells the envelope to ’open’ (1) and ’close’ (0), thus starting and stopping the note.


// For an ASR or ADSR envelope to work in our synth, we must declare a gate argument.
// Normally the default is gate = 1 because we want the synth to start playing right away.
// When we want the synth to stop, we simply send either the .release or .set(\gate, 0) message: the release portion of the envelope will be then triggered.



// EnvGen
// For the record, you should know that the construction you learned in this section to generate envelopes is a shortcut, as shown in the code below.

// This:
{ SinOsc.ar * Env.perc.kr(doneAction: 2) }.play;
// ... is a shortcut for this:
{ SinOsc.ar * EnvGen.kr(Env.perc, doneAction: 2) }.play;

// EnvGen is the UGen that actually plays back breakpoint envelopes defined by Env. These two notations (shortcut - EnvGen) are equivalent.






