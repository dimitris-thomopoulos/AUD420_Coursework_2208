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

// Now watch the magic happen:
(
Pbind(
	\instrument, "wow",
	\degree, Pwhite(-7, 7),
	\dur, Prand([0.125, 0.25], inf),
	\amp, Pwhite(0.5, 1),
	\wowrelease, 1
).play;
)

(
Pbind(
	\instrument, "wow",
	\scale, Pstutter(8, Pseq([
		Scale.lydian,
		Scale.major,
		Scale.mixolydian,
		Scale.minor,
		Scale.phrygian], inf)),
	\degree, Pseq([0, 1, 2, 3, 4, 5, 6, 7], inf),
	\dur, 0.2,
	\amp, Pwhite(0.5, 1),
	\wowrelease, 4,
	\legato, 0.1
).play;
)

/*
We use the Pbind key \instrument to declare the name of our SynthDef.
All the arguments of our SynthDef are accessible and controllable from inside Pbind:
We can simply use them as Pbind keys. For example, notice the argument called \wowrelease used above.
It is not one of the default keys understood by Pbind—rather, it is unique to the synth definition wow (the silly name was chosen on purpose).

In order to use all of the pitch conversion facilities of Pbind (the keys \degree, \note, and \midinote),
we need to make sure our SynthDef has an argument input for freq (it has to be spelled exactly like that). Pbind will do the math for us.

If using a sustained envelope such as Env.adsr, we need to make sure our synth has a default argument gate = 1
(gate has to be spelled exactly like that, because Pbind uses it behind the scenes to stop notes at the right times).

If not using a sustained envelope, we need to make sure our SynthDef includes a doneAction: 2 in an appropriate UGen, in order to automatically free synth nodes in the server.
*/

/*
Exercise: write one or more Pbinds to play the "pluck" SynthDef provided below.
For the mutedString argument, try values between 0.1 and 0.9.
Have one of your Pbinds play a slow sequence of chords. Try arpeggiating the chords with \strum.
*/
(
SynthDef("pluck", {arg amp = 0.1, freq = 440, decay = 5, mutedString = 0.1;
	var env, snd;
	env = Env.linen(0, decay, 0).kr(doneAction: 2);
	snd = Pluck.ar(
		in: WhiteNoise.ar(amp),
		trig: Impulse.kr(0),
		maxdelaytime: 0.1,
		delaytime: freq.reciprocal,
		decaytime: decay,
		coef: mutedString);
	Out.ar(0, [snd, snd]);
}).add;
)

// my answer:
(
Pbind (
	\instrument, "pluck",
	\mutedString, 0.2,
	\note, Pseq([[2, 5, 9, 0], [4, 9, 6, -1], [0, -3, 6, 9], [-9, -3, 0, 6]], inf),
	\amp, 0.3,
	\strum, 0.4;
).play
)


/* END OF NOTES */