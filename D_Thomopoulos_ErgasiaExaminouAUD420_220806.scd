// ΔΗΜΗΤΡΗΣ ΘΩΜΟΠΟΥΛΟΣ- TX2020044
// Διαδραστικά Συστήματα Ήχου - Τελική εργαία (Σεπτέμβριος 2022)

// Όνομα μουσικής σύνθεσης: 'PADOU'

s.boot;
s.meter;
s.volume.gui;

(
// αρχικά, ορίζουμε τα BPM της μουσικής σύνθεσης (108):
t = TempoClock(108/60).permanent_(true);

// ορίζουμε τις συγχωρδίες (chords) που θα χρησιμοποιήσουμε στο πιάνο:
~d_sharp = [-9, -6, 3, 6];
~c_sharp = [-11, -7, 1, 5];
~b_minor = [-13, -9, -1, 3];
~a_sharp = [-14, -2, 2, 5];

// εισάγουμε το έτοιμο sample μπότας (kick) από τον φάκελο των samples:
~kickdrum = Buffer.read(s, thisProcess.nowExecutingPath.dirname+/+"/samples/GrvKick06.wav");

(
SynthDef.new(\kickdrum, {
	arg atk=0.01, rel=1, c1=1, c2=(-1), amp=0.1, buf, out=0;
	var sig, env;
	env = Env([0, 1, 0], [atk,rel], [c1,c2]).kr(2);
	sig = PlayBuf.ar(2, buf);
	sig = sig * env;
	Out.ar(out,sig);
}).add;
);


// με τη χρήση του SynthDef και των envelopes φτιάχνουμε τους βασικούς ήχους:

// plucks:
SynthDef("pluck", {arg freq = 440, amp = 0.1;
	var env = Env.perc(level: amp).kr(2);
	var snd = SinOsc.ar(freq, 1, env);
	Out.ar(0, snd);
}).add;

// με το SynthDef φτιάχνουμε το μπάσο:

SynthDef("bass", { arg freq = 440, amp = 0.2, att = 0.1, rel = 10, lofreq = 50, hifreq = 340;
    var env, snd;
    env = Env.perc(
		attackTime: att,
		releaseTime: rel,
		level: amp
	).kr(doneAction: 2);
    snd = Saw.ar(freq: freq * [0, 1, 1, 1], mul: env);
	snd = LPF.ar(
		in: snd,
		freq: LFNoise2.kr(1).range(lofreq, hifreq)
	);
    snd = Splay.ar(snd);
    Out.ar(0, snd);
}).add;


// με το SynthDef φτιάχνουμε την μπότα του κομματιού (kick):
// SynthDef.new(\kick, {
// 	arg
// 	/*values for frequency sweep*/
// 	freqA=523, freqB=50, freqC=10, freqDur1=0.01, freqDur2=0.2, /*curve frequencies*/ freqC1=1, freqC2=(-1),
// 	/*values for our signal envelope*/
// 	atk=0.01, rel=1, /*curve values*/ c1=1, c2=(-12),
// 	amp=0.8, pan=0, out=0;
// 	var sig, env, freqSweep;
// 	freqSweep = Env([freqA, freqB, freqC], [freqDur1, freqDur2], [freqC1, freqC2]).ar;
// 	env = Env([0, 1, 0], [atk, rel], [c1, c2]).kr(2); // .kr(2) is a doneAction: 2 value
// 	sig = SinOsc.ar(freqSweep, pi/2);
// 	sig = sig * env;
// 	sig = Pan2.ar(sig, pan, amp);
// 	Out.ar(out, sig);
// }).add;



// με παρόμοιο τρόπο φτιάχνουμε το snare τύμπανο και τα hi-hat (πιατίνια):

SynthDef("snare", {arg out = 0, amp = 0.1, sinfreq = 228, att = 0.01, rel = 0.2, ffreq = 2000, pan = 0;
	var env, snd1, snd2, sum;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	snd1 = HPF.ar(
		in: WhiteNoise.ar,
		freq: ffreq,
		mul: env
	);
	snd2 = SinOsc.ar(freq: sinfreq, mul: env);
	sum = snd1 + snd2;
	Out.ar(out, Pan2.ar(sum, pan));
}).add;


SynthDef("perc1", {arg out = 0, amp = 0.1, sinfreq = 200, att = 0.01, rel = 0.2, ffreq = 200, pan = 0;
	var env, snd1, snd2, sum;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	snd1 = HPF.ar(
		in: WhiteNoise.ar,
		freq: ffreq,
		mul: env
	);
	snd2 = SinOsc.ar(freq: sinfreq, mul: env);
	sum = snd1 + snd2;
	Out.ar(out, Pan2.ar(sum, pan));
}).add;


SynthDef("perc2", {arg out = 0, amp = 0.1, sinfreq = 150, att = 0.01, rel = 0.2, ffreq = 200, pan = 0;
	var env, snd1, snd2, sum;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	snd1 = HPF.ar(
		in: WhiteNoise.ar,
		freq: ffreq,
		mul: env
	);
	snd2 = SinOsc.ar(freq: sinfreq, mul: env);
	sum = snd1 + snd2;
	Out.ar(out, Pan2.ar(sum, pan));
}).add;



SynthDef("hihat", {arg out = 0, amp = 0.5, att = 0.01, rel = 0.2, ffreq = 6000, pan = 0;
	var env, snd;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	snd = WhiteNoise.ar;
	snd = HPF.ar(in: snd, freq: ffreq, mul: env);
	Out.ar(out, Pan2.ar(snd, pan));
}).add;


SynthDef('cymbal', {arg out = 0, amp = 0.1, sinfreq = 180, att = 0.01, rel = 0.2, ffreq = 2000, pan = 0;
	var env, snd1, snd2, sum;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	snd1 = HPF.ar(
		in: WhiteNoise.ar,
		freq: ffreq,
		mul: env
	);
	snd2 = SinOsc.ar(freq: sinfreq, mul: env);
	sum = snd1 + snd2;
	Out.ar(out, Pan2.ar(sum, pan));
}).add;
);



/////////////////////////////((((INTRO))))/////////////////////////////
//χρήση των Patterns - με τον προεπιλεγμένο ήχο πιάνου του SC, συνθέτουμε τη βασική μελωδία. Χρησιμοποιούμε τα chords που ορίσαμε πριν και προσθέτουμε μερικές νότες μεταξύ τους:

(
Pbind(
 	\note, Pseq([~d_sharp, ~c_sharp, 6, ~b_minor, -6, 3, 5, 6, ~a_sharp]),
 	\dur, Pseq([8, 6, 2, 5.5, 0.5, 0.75, 0.75, 0.5, 8]),
 	\strum, Pseq([0.02, 0.05, 0, 0.05, 0, 0, 0, 0, 0.02]),
 	\legato, Pseq([1, 1.3, 1, 1.35, 1.1, 1, 1, 1, 1]),
	\amp, Pseq([0.1, 0.1, 0.1, 0.1, 0.08, 0.085, 0.09, 0.095, 0.1]);
	// χρησιμοποιούμε το \amp keyword για να δημιουργήσουμε μία δυναμική στις νότες της μελωδίας
 ).play(t);

// χρήση του multichannel expansion - προσθέτουμε ένα ηχητικό εφέ σαν ήχο τηλεφώνου:
~callingWet = {Out.ar(0, FreeVerb.ar(In.ar(16, 2), mix: 0.5, room: 0.2, mul: 0.4, damp: 1))}.play;
~callingDry = {Out.ar(16, SinOsc.ar([440, 480], mul: LFPulse.ar(0.22, mul: 0.07)))}.play;

// μπάσο:
// Pbind(
// 	\instrument, "bass",
// 	\note, Pseq([-21, -23, -25, -26]),
// 	\dur, Pseq([8, 8, 8, 8]),
// 	\att, 0.05,
// 	\rel, 8,
// 	\amp, 0.05
// ).play(t);
)



/////////////////////////////((((1st VERSE - DRUMS))))/////////////////////////////
// στο επόμενο block σταματάμε το εφέ, χαμηλώνουμε τη μελωδία και εισάγουμε τα drums και το μπάσο:

(
~callingDry.free; // σταματάμε το εφέ

Pbind(
	\note, Pseq([~d_sharp, ~c_sharp, 6, ~b_minor, -6, 3, 5, 6, ~a_sharp], 3),
	\dur, Pseq([8, 6, 2, 5.5, 0.5, 0.75, 0.75, 0.5, 8], 3),
	\strum, Pseq([0.02, 0.05, 0, 0.05, 0, 0, 0, 0, 0.02], 3),
	\legato, Pseq([1, 1.3, 1, 1.35, 1.1, 1, 1, 1, 1], 3),
	\amp, Pseq([0.05, 0.05, 0.05, 0.05, 0.03, 0.035, 0.04, 0.045, 0.05], 3);
).play(t);

~newKick = Pbind(
	\instrument, \kickdrum,
	\buf, ~kickdrum,
	\note, Pseq([0, -2, 0, 0, 0, -2, 0, 0], 3),
	\dur, Pseq([7.5, 0.5, 6, 2, 7.5, 0.5, 6, 2], 3),
	\rel, 1,
	\out, 0
).play(t);

/*Pbind(
\instrument, "bass",
\note, Pseq([Pn(-21,6), Pn(-23, 6), Pn(-25, 6), Pn(-26,6)], 1),
\dur, Pseq([2, 0.5, 1.5, 2, 0.5, 1.5], inf),
\att, 0.05,
\rel,  0.5,
\amp, 0.02
).play(t);*/

SystemClock.sched(0.44, //start in 0.44 sec
	{
		Pbind(
			\instrument, "snare",
			\note, Pseq([Pn(0, 7)], 11),
			\dur, Pseq([0.75, 1.5, 1, 0.75, 0.75, 1.5, 1.75], 11),
			\att, 0.01,
			\rel, 0.1,
			\ffreq, 1000,
			\amp, 0.25
		).play(t);
	}
);

SystemClock.sched(1.11,
	{
		Pbind(
			\instrument, "perc1",
			\dur,Pseq([4], 22),
			\att, 0.01,
			\rel, 0.1,
			\ffreq, 20,
			\amp, 0.15
		).play(t);
	}
);

SystemClock.sched(1.39,
	{
		Pbind(
			\instrument, "perc2",
			\dur,Pseq([4], 22),
			\att, 0.01,
			\rel, 0.1,
			\ffreq, 20,
			\amp, 0.1
		).play(t);
	}
);

SystemClock.sched(1.4,
	{
		Pbind(
			\instrument, 'cymbal',
			\note, 0,
			\dur, 16,
			\att, 0.01,
			\rel, 0.5,
			\sinfreq, 0,
			\ffreq, 14000,
			\amp, 0.6;
		).play(t);
	}
);

Pbind(
	\instrument, 'hihat',
	\note, Pseq([0, 0, 0, 0, 0, 0, 0, 0, 0], 94),
	\dur , Pseq([1, 1, 0.25, 1.5, 1.25, 1, 0.25, 1.5, 0.25], 94),
	\att, 0.01,
	\rel, 0.08,
	\sinfreq, 0,
	\ffreq, 14000,
	\amp, Pseq([Pn(1,9)], 94);
).play(t);
)



/////////////////////////////((((1st VERSE - BASS & SHAKERS))))/////////////////////////////
// εισάγουμε το μπάσο και τις μαράκες (shakers)

(
Pbind(
	\instrument, "bass",
	\note, Pseq([-21, -23, -28, -25, -28, -25, -26, -16, -26, -21], 2),
	\dur, Pseq([8, 7.5, 0.5, 7, 0.5, 0.5, 6, 0.5, 0.5, 1], 2),
	\att, 0.05,
	\rel,  Pseq([8, 7.5, 0.5, 7, 0.5, 0.5, 6, 0.5, 0.5, 1], 2),
	\amp, 0.25
).play(t);
)