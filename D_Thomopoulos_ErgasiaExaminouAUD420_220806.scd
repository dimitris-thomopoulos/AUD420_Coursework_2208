// ΔΗΜΗΤΡΗΣ ΘΩΜΟΠΟΥΛΟΣ- TX2020044
// Διαδραστικά Συστήματα Ήχου - Τελική εργαία (Σεπτέμβριος 2022)

// Όνομα μουσικής σύνθεσης: 'PADOU'
// Listen with headphones  )))d[-_-]b(((

s.boot;
s.reboot;
Server.killAll;
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

// χρήση του Buffer.read - εισάγουμε το έτοιμο sample μπότας (kick), τις κιθάρες και τις μαράκες (shakers) από τον φάκελο των samples:
~kickdrum = Buffer.read(s, thisProcess.nowExecutingPath.dirname+/+"/samples/GrvKick06.wav");
~shakers = Buffer.read(s, thisProcess.nowExecutingPath.dirname+/+"/samples/shaker.wav");
~bamboo = Buffer.read(s, thisProcess.nowExecutingPath.dirname+/+"/samples/bamboo.wav");

~guitar = Buffer.read(s, thisProcess.nowExecutingPath.dirname+/+"/samples/guitar.wav");
~guitar2 = Buffer.read(s, thisProcess.nowExecutingPath.dirname+/+"/samples/guitar2.wav");
~guitarShort = Buffer.read(s, thisProcess.nowExecutingPath.dirname+/+"/samples/guitarShort.wav");
~guitarOutro = Buffer.read(s, thisProcess.nowExecutingPath.dirname+/+"/samples/guitarOutro.wav");



(
SynthDef.new(\kickdrum, {
	arg atk=0.01, rel=1, c1=1, c2=(-1), amp=0.1, out=0;
	var sig, env;
	env = Env([0, 1, 0], [atk,rel], [c1,c2]).kr(2);
	sig = PlayBuf.ar(2, ~kickdrum.bufnum);
	sig = sig * env;
	Out.ar(out,sig);
}).add;
);

(
SynthDef.new(\guitar, {
	var out=0, sig;
	sig = PlayBuf.ar(2, ~guitar.bufnum, doneAction: 2);
	Out.ar(out,sig);
}).add;
);

(
SynthDef.new(\guitar2, {
	var out=0, sig;
	sig = PlayBuf.ar(2, ~guitar2.bufnum, doneAction: 2);
	Out.ar(out,sig);
}).add;
);

(
SynthDef.new(\guitarShort, {
	var out=0, sig;
	sig = PlayBuf.ar(2, ~guitarShort.bufnum, doneAction: 2);
	Out.ar(out,sig);
}).add;
);

(
SynthDef.new(\guitarOutro, {
	var out=0, sig;
	sig = PlayBuf.ar(2, ~guitarOutro.bufnum, doneAction: 2);
	Out.ar(out,sig);
}).add;
);

(
SynthDef.new(\shakers, {
	arg atk=0.01, rel=1, c1=1, c2=(-1), out=0;
	var sig, env;
	env = Env([0, 1, 0], [atk,rel], [c1,c2]).kr(2);
	sig = PlayBuf.ar(2, ~shakers.bufnum);
	sig = sig * env;
	Out.ar(out,sig);
}).add;
);

(
SynthDef.new(\bamboo, {
	arg atk=0.01, rel=1, c1=1, c2=(-1), out=0;
	var sig, env;
	env = Env([0, 1, 0], [atk,rel], [c1,c2]).kr(2);
	sig = PlayBuf.ar(2, ~bamboo.bufnum);
	sig = sig * env;
	Out.ar(out,sig);
}).add;
);


// με τη χρήση του SynthDef και των envelopes φτιάχνουμε τους βασικούς ήχους:

// με το SynthDef φτιάχνουμε το μπάσο:

SynthDef(
	"sawbass",
	{
		|note = 35, amp = 1.2, cutoff = 350, decay = 2, c2 =100|
		var env, audio;
		env = EnvGen.kr(Env.new([0,1,0], [0.1,2],[3,c2]),doneAction:2);
		audio = RLPF.ar(Saw.ar(note.midicps,amp), cutoff)*env;
		audio = CombC.ar(audio, 1, 0, decay);
		Out.ar([0,1],audio);
	}
).store;

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
p = Pbind(
 	\note, Pseq([~d_sharp, ~c_sharp, 6, ~b_minor, -6, 3, 5, 6, ~a_sharp]),
 	\dur, Pseq([8, 6, 2, 5.5, 0.5, 0.75, 0.75, 0.5, 8]),
 	\strum, Pseq([0.02, 0.05, 0, 0.05, 0, 0, 0, 0, 0.02]),
	\legato, Pseq([1, 1.3, 1, 1.35, 1.1, 1, 1, 1, 1]),
	\amp, Pseq([0.1, 0.1, 0.1, 0.1, 0.08, 0.085, 0.09, 0.095, 0.1]);
 );
~piano = p.play(t);

// συνδυάζουμε δύο διαφορετικά layers για το μπάσο της εισαγωγής:
Pbind(
	\instrument, "sawbass",
	\note, Pseq([39, 37, 35, 34]),
	\dur, Pseq([8, 8, 8, 8]),
	\amp, 0.008,
	\cutoff, 1050,
).play(t);

Pbind(
	\instrument, "sawbass",
	\note, Pseq([39, 37, 35, 34]),
	\dur, Pseq([8, 8, 8, 8]),
	\amp, 0.008,
	\cutoff, 450,
).play(t);

SystemClock.sched(2.02,
	{
		Pbind(
			\instrument, "sawbass",
			\note, Pseq([39, 37, 35, 34]),
			\dur, Pseq([8, 8, 8, 8]),
			\amp, 0.008,
			\cutoff, 1050,
		).play(t);

		Pbind(
			\instrument, "sawbass",
			\note, Pseq([39, 37, 35, 34]),
			\dur, Pseq([8, 8, 8, 8]),
			\amp, 0.008,
			\cutoff, 450,
		).play(t);
});


// χρήση του multichannel expansion - προσθέτουμε ένα ηχητικό εφέ σαν ήχο τηλεφώνου:
~callingWet = {Out.ar(0, FreeVerb.ar(In.ar(16, 2), mix: 0.5, room: 0.2, mul: 0.4, damp: 1))}.play;
~callingDry = {Out.ar(16, SinOsc.ar([440, 480], mul: LFPulse.ar(0.22, mul: 0.05)))}.play;

// μετά από 17 δευτερόλεπτα, ελευθερώνουμε το node του ήχου τηλεφώνου (το σταματάμε):
SystemClock.sched(17.77,
	{
		~callingDry.free;
});

)



/////////////////////////////((((1st VERSE))))/////////////////////////////
// στο επόμενο block σταματάμε το εφέ, χαμηλώνουμε τη μελωδία και εισάγουμε τα drums και το μπάσο:

(

// παίζουμε το πιο "χαμηλό" πιάνο:
Pbind(
	\note, Pseq([~d_sharp, ~c_sharp, 6, ~b_minor, -6, 3, 5, 6, ~a_sharp], 3),
	\dur, Pseq([8, 6, 2, 5.5, 0.5, 0.75, 0.75, 0.5, 8], 3),
	\strum, Pseq([0.02, 0.05, 0, 0.05, 0, 0, 0, 0, 0.02], 3),
	\legato, Pseq([1, 1.3, 1, 1.35, 1.1, 1, 1, 1, 1], 3),
	\amp, Pseq([0.08, 0.08, 0.08, 0.08, 0.06, 0.065, 0.07, 0.075, 0.08], 3);
).play(t);

~newKick = Pbind(
	\instrument, \kickdrum,
	\buf, ~kickdrum,
	\note, Pseq([0, -2, 0, 0, 0, -2, 0, 0], 3),
	\dur, Pser([7.5, 0.5, 6, 2, 7.5, 0.5, 6, 2], 23),
	\rel, 1,
	\out, 0
).play(t);

SystemClock.sched(0.44,
	{
		Pbind(
			\instrument, "snare",
			\note, Pseq([Pn(0, 11)], 11),
			\dur, Pseq([0.75, 0.5, 0.5, 0.5, 1, 0.75, 0.75, 0.5, 0.5, 0.5, 1.75], 11),
			\sinfreq, Pseq([228, 228, 200, 150, 228, 228, 228, 228, 220, 150, 228], 11),
			\ffreq, Pseq([2000, 2000, 200, 200, 2000, 2000, 2000, 2000, 200, 200, 2000], 11),
			\att, 0.01,
			\rel, 0.1,
			\amp, 0.25
		).play(t);
	}
);

SystemClock.sched(1.9,
	{
		Pbind(
			\instrument, "bamboo",
			\note, Pseq([0,0], 23),
			\dur,Pser([0.25, 3.75], 43),
			\ffreq, 20,
			\amp, 0.1
		).play(t);
	}
);

Pbind(
	\instrument, \sawbass,
	\note, Pseq([Pn(39,6), Pn(37,6), Pn(35,6), Pn(34,6)]),
	\dur, Pseq([2, 0.5, 1.5], 8),
	\amp, 0.3,
	\cutoff, 150,
	\c2, -20,
).play(t);

SystemClock.sched(17.78,
	{
		Pbind(
			\instrument, "sawbass",
			\note, Pseq([39, 37, 35, 34], 2),
			\dur, Pseq([8, 8, 8, 8], 2),
			\amp, 0.1,
			\cutoff, 200,
		).play(t);

		Pbind(
			\instrument, \shakers,
			\note, Pser([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 224),
			\dur, Pseq([Pn(0.25,16)], 15)
		).play(t);
});

SystemClock.sched(19.8,
	{
		Pbind(
			\instrument, "sawbass",
			\note, Pser([39, 37, 32, 35, 32, 34, 44, 32, 39], 15),
			\dur, Pser([8, 3.7, 4.3, 3.7, 4.3, 2.5, 0.5, 0.5, 4.5], 15),
			\c2, Pser([20, 20, -5, 20, -5, 7, -5, -5, 20,     20, 20, -5, 20, -5, 7, -5, -5, -5], 15),
			\amp, 0.1,
			\cutoff, 200,
		).play(t);
});


)


(


/////////////////////////////((((CHORUS))))/////////////////////////////
// εισάγουμε την κιθάρα και τα πιατίνια(hi-hats):

Pbind(
	\note, Pseq([~d_sharp, ~c_sharp, 6, ~b_minor, -6, 3, 5, 6, ~a_sharp], 5),
	\dur, Pseq([8, 6, 2, 5.5, 0.5, 0.75, 0.75, 0.5, 8], 5),
	\strum, Pseq([0.02, 0.05, 0, 0.05, 0, 0, 0, 0, 0.02], 5),
	\legato, Pseq([1, 1.3, 1, 1.35, 1.1, 1, 1, 1, 1], 5),
	\amp, Pseq([0.08, 0.08, 0.08, 0.08, 0.06, 0.065, 0.07, 0.075, 0.08], 5);
).play(t);

Pbind(
	\instrument, "sawbass",
	\note, Pseq([39, 37, 35, 34], 2),
	\dur, Pseq([8, 8, 8, 8], 2),
	\amp, 0.1,
	\legato, 2,
	\cutoff, 200,
).play(t);

SystemClock.sched(2.02,
	{
		Pbind(
			\instrument, "sawbass",
			\note, Pseq([39, 37, 32, 35, 32, 34, 44, 32, 39], 2),
			\dur, Pseq([8, 3.7, 4.3, 3.7, 4.3, 2.5, 0.5, 0.5, 4.5],2),
			\c2, Pseq([20, 20, -5, 20, -5, 7, -5, -5, 20,     20, 20, -5, 20, -5, 7, -5, -5, -5]),
			\amp, 0.1,
			\cutoff, 200,
		).play(t);
});

~newKick = Pbind(
	\instrument, \kickdrum,
	\buf, ~kickdrum,
	\note, Pseq([0, -2, 0, 0, 0, -2, 0, 0], 4),
	\dur, Pseq([7.5, 0.5, 6, 2, 7.5, 0.5, 6, 2], 4),
	\rel, 1,
	\out, 0
).play(t);

SystemClock.sched(0.44,
	{
		Pbind(
			\instrument, "snare",
			\note, Pseq([Pn(0, 11)], 16),
			\dur, Pseq([0.75, 0.5, 0.5, 0.5, 1, 0.75, 0.75, 0.5, 0.5, 0.5, 1.75], 16),
			\sinfreq, Pseq([228, 228, 200, 150, 228, 228, 228, 228, 220, 150, 228], 16),
			\ffreq, Pseq([2000, 2000, 200, 200, 2000, 2000, 2000, 2000, 200, 200, 2000], 16),
			\att, 0.01,
			\rel, 0.1,
			\amp, 0.25
		).play(t);
	}
);

SystemClock.sched(1.9,
	{
		Pbind(
			\instrument, "bamboo",
			\note, Pseq([0,0], 32),
			\dur,Pseq([0.25, 3.75], 32),
			\ffreq, 20,
			\amp, 0.1
		).play(t);
	}
);

Pbind(
	\instrument, \shakers,
	\note, Pser([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 256),
	\dur, Pseq([Pn(0.25,16)], 16)
).play(t);


// κιθάρα:

Pbind(
	\instrument, \guitar,
	\dur, Pseq([66],1),
	\buf, ~guitar.bufnum;
).play(t);


// πιατίνια:

SystemClock.sched(1.4,
	{
		Pbind(
			\instrument, "cymbal",
			\note, 0,
			\dur, Pseq([16], 4),
			\att, 0.01,
			\rel, 0.5,
			\sinfreq, 0,
			\ffreq, 14000,
			\amp, 0.3;
		).play(t);
	}
);

Pbind(
	\instrument, "hihat",
	\note, Pseq([0, 0, 0, 0, 0, 0, 0, 0, 0], 8),
	\dur , Pseq([1, 1, 0.25, 1.5, 1.25, 1, 0.25, 1.5, 0.25], 8),
	\att, 0.01,
	\rel, 0.08,
	\sinfreq, 0,
	\ffreq, 14000,
	\amp, Pseq([Pn(0.4,9)], 94);
).play(t);


/////////////////////////////((((2nd VERSE))))/////////////////////////////
// αλλάζουμε το ρυθμό και την ένταση του μπάσου και ξαναβάζουμε τις μαράκες:

SystemClock.sched(35.55,
	{
		Pbind(
			\instrument, \sawbass,
			\note, Pseq([Pn(39,6), Pn(37,6), Pn(35,6), Pn(34,6)]),
			\dur, Pseq([2, 0.5, 1.5], 8),
			\amp, 0.3,
			\cutoff, 150,
			\c2, -20,
		).play(t);
});

SystemClock.sched(53.32,
	{
		Pbind(
			\instrument, "sawbass",
			\note, Pseq([39, 37, 35, 34], 2),
			\dur, Pseq([8, 8, 8, 8], 2),
			\amp, 0.1,
			\legato, 2,
			\cutoff, 200,
		).play(t);

		Pbind(
			\instrument, \shakers,
			\note, Pseq([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 8),
			\dur, Pseq([Pn(0.25,16)], 8)
).play(t);

});

SystemClock.sched(55.34,
	{
		Pbind(
			\instrument, "sawbass",
			\note, Pser([39, 37, 32, 35, 32, 34, 44, 32, 39], 15),
			\dur, Pser([8, 3.7, 4.3, 3.7, 4.3, 2.5, 0.5, 0.5, 4.5], 15),
			\c2, Pser([20, 20, -5, 20, -5, 7, -5, -5, 20,     20, 20, -5, 20, -5, 7, -5, -5, -5], 15),
			\amp, 0.1,
			\cutoff, 200,
		).play(t);
});

SystemClock.sched(53.33,
	{
		Pbind(
			\instrument, \guitarShort,
			\dur, Pseq([34],1),
			\buf, ~guitarShort.bufnum;
		).play(t);
});

SystemClock.sched(78.89,
	{
	Pbind(
		\instrument, \guitar2,
			\dur, Pseq([6], 1),
		\buf, ~guitar2.bufnum;
	).play(t);
});

)


(

/////////////////////////////((((FINAL CHORUS))))/////////////////////////////
Pbind(
	\note, Pseq([~d_sharp, ~c_sharp, 6, ~b_minor, -6, 3, 5, 6, ~a_sharp], 3),
	\dur, Pseq([8, 6, 2, 5.5, 0.5, 0.75, 0.75, 0.5, 8], 3),
	\strum, Pseq([0.02, 0.05, 0, 0.05, 0, 0, 0, 0, 0.02], 3),
	\legato, Pseq([1, 1.3, 1, 1.35, 1.1, 1, 1, 1, 1], 5),
	\amp, Pseq([0.08, 0.08, 0.08, 0.08, 0.06, 0.065, 0.07, 0.075, 0.08], 3);
).play(t);

Pbind(
	\instrument, "sawbass",
	\note, Pseq([39, 37, 35, 34], 3),
	\dur, Pseq([8, 8, 8, 8], 3),
	\amp, 0.1,
	\legato, 2,
	\cutoff, 200,
).play(t);

SystemClock.sched(2.02,
	{
		Pbind(
			\instrument, "sawbass",
			\note, Pseq([39, 37, 32, 35, 32, 34, 44, 32, 39], 3),
			\dur, Pseq([8, 3.7, 4.3, 3.7, 4.3, 2.5, 0.5, 0.5, 4.5],3),
			\c2, Pseq([20, 20, -5, 20, -5, 7, -5, -5, 20,     20, 20, -5, 20, -5, 7, -5, -5, -20,   20, 20, -5, 20, -5, 7, -5, -5, -5]),
			\amp, 0.1,
			\cutoff, 200,
		).play(t);
});

~newKick = Pbind(
	\instrument, \kickdrum,
	\buf, ~kickdrum,
	\note, Pseq([0, -2, 0, 0, 0, -2, 0, 0], 2),
	\dur, Pseq([7.5, 0.5, 6, 2, 7.5, 0.5, 6, 2], 2),
	\rel, 1,
	\out, 0
).play(t);

SystemClock.sched(0.44,
	{
		Pbind(
			\instrument, "snare",
			\note, Pseq([Pn(0, 11)], 8),
			\dur, Pseq([0.75, 0.5, 0.5, 0.5, 1, 0.75, 0.75, 0.5, 0.5, 0.5, 1.75], 8),
			\sinfreq, Pseq([228, 228, 200, 150, 228, 228, 228, 228, 220, 150, 228], 8),
			\ffreq, Pseq([2000, 2000, 200, 200, 2000, 2000, 2000, 2000, 200, 200, 2000], 8),
			\att, 0.01,
			\rel, 0.1,
			\amp, 0.25
		).play(t);
	}
);

SystemClock.sched(1.9,
	{
		Pbind(
			\instrument, "bamboo",
			\note, Pseq([0,0], 16),
			\dur,Pseq([0.25, 3.75], 16),
			\ffreq, 20,
			\amp, 0.1
		).play(t);
	}
);

Pbind(
	\instrument, \shakers,
	\note, Pser([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 256),
	\dur, Pseq([Pn(0.25,16)], 16)
).play(t);


// κιθάρα:

Pbind(
	\instrument, \guitar,
	\dur, Pseq([66],1),
	\buf, ~guitar.bufnum;
).play(t);


// πιατίνια:

SystemClock.sched(1.4,
	{
		Pbind(
			\instrument, "cymbal",
			\note, 0,
			\dur, Pseq([16], 4),
			\att, 0.01,
			\rel, 0.5,
			\sinfreq, 0,
			\ffreq, 14000,
			\amp, 0.3;
		).play(t);
	}
);

Pbind(
	\instrument, "hihat",
	\note, Pseq([0, 0, 0, 0, 0, 0, 0, 0, 0], 8),
	\dur , Pseq([1, 1, 0.25, 1.5, 1.25, 1, 0.25, 1.5, 0.25], 8),
	\att, 0.01,
	\rel, 0.08,
	\sinfreq, 0,
	\ffreq, 14000,
	\amp, Pseq([Pn(0.4,9)], 94);
).play(t);



/////////////////////////////((((OUTRO))))/////////////////////////////

SystemClock.sched(43.33,
	{
		Pbind(
			\instrument, \guitar2,
			\dur, Pseq([6],1),
			\buf, ~guitar2.bufnum;
		).play(t);
});

SystemClock.sched(47.77,
	{
		Pbind(
			\instrument, \guitarOutro,
			\dur, Pseq([18],1),
			\buf, ~guitarOutro.bufnum;
		).play(t);
});

)