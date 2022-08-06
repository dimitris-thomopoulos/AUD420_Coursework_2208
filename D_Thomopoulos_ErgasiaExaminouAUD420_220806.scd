// ΔΗΜΗΤΡΗΣ ΘΩΜΟΠΟΥΛΟΣ- TX2020044
// Διαδραστικά Συστήματα Ήχου - Τελική εργαία (Σεπτέμβριος 2022)

// Όνομα μουσικής σύνθεσης: 'PADOU'

s.boot;
s.meter;
s.volume.gui;

// αρχικά, ορίζουμε τα BPM της μουσικής σύνθεσης (108):
t = TempoClock(108/60);

// ορίζουμε τις συγχωρδίες (chords) που θα χρησιμοποιήσουμε:
(
~d_sharp = [-9, -6, 3, 6];
~c_sharp = [-11, -7, 1, 5];
~b_minor = [-13, -9, -1, 3];
~a_sharp = [-14, -2, 2, 5];
)

// χρήση synth και envelopes
(
SynthDef("pluck", {arg freq = 440, amp = 0.1;
	var env = Env.perc(level: amp).kr(2);
	var snd = SinOsc.ar(freq, 1, env);
	Out.ar(0, snd);
}).add;
)



// IDEA: make the ambient bass in the intro of the song using a BPF on a LFNoise0

// χρήση των Patterns - με τον προεπιλεγμένο ήχο πιάνου του SC, συνθέτουμε τη βασική μελωδία προσθέτωντας νότες μεταξύ των chords:
(
t = TempoClock(108/60);
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
)

// στο επόμενο block σταματάμε το εφέ, χαμηλώνουμε τη μελωδία και εισάγουμε τα drums:
(
~callingDry.free; // σταματάμε το εφέ

t = TempoClock(108/60);
Pbind(
	\note, Pseq([~d_sharp, ~c_sharp, 6, ~b_minor, -6, 3, 5, 6, ~a_sharp], inf),
	\dur, Pseq([8, 6, 2, 5.5, 0.5, 0.75, 0.75, 0.5, 8], inf),
	\strum, Pseq([0.02, 0.05, 0, 0.05, 0, 0, 0, 0, 0.02], inf),
	\legato, Pseq([1, 1.3, 1, 1.35, 1.1, 1, 1, 1, 1], inf),
	\amp, Pseq([0.05, 0.05, 0.05, 0.05, 0.03, 0.035, 0.04, 0.045, 0.05], inf);
).play(t);
)

// παίζουμε το synth που ορίσαμε προηγουμένως μέσα σε μία PBind

// Synth("pluck", [\freq, 932, \amp, 0.05]);
// Synth("pluck", [\freq, 830, \amp, 0.05]);