// The number inside Rest is the duration of the rest in beats. Rests can go anywhere in the Pbind, not just in the \dur line. A Rest may be used in event patterns to indicate that the resulting event should be a rest (i.e., silent). It should be used in one of the child patterns belonging to a Pbind.
(
Pbind(
	\degree, Pwhite(0,10),
	\dur, Pseq([0.1, 0.1, 0.3, 1, Rest(0.5), 0.25], inf);
).play;
)


// Playing two or more Pbinds together:
( //open big block
Pbind(
	\freq, Pn(Pseries(110, 111, 10)),
	\dur, 1/2,
	\legato, Pwhite(0.1, 1)
).play;

Pbind(
	\freq,Pn(Pseries(220, 222, 10)),
	\dur, 1/4,
	\legato, Pwhite(0.1, 1)
).play;

Pbind(
	\freq, Pn(Pseries(330, 333, 10)),
	\dur, 1/6,
	\legato, 0.1
).play;
) // close big clock

// In order to play Pbinds in a time-ordered fashion (other than simply evaluating them manually one after the other), you can use { }.fork:

// Basic fork example. Watch Post window:
(
{
	"one thing".postln;
	2.wait;
	"another thing".postln;
	1.5.wait;
	"one last thing".postln;
}.fork;
)

// A more interesting example:
(
t = TempoClock(76/60);
{
	Pbind(
		\note, Pseq([[4, 11], [6, 9]], 32),
		\dur, 1/6,
		\amp, Pseq([0.05, 0.03], inf)
	).play(t);
	2.wait;

	Pbind(
		\note, Pseq([[-25, -13, -1], [-20, -8, 4], \rest], 3),
		\dur, Pseq([1, 1, Rest(1)], inf),
		\amp, 0.1,
		\legato, Pseq([0.4, 0.7, \rest], inf)
	).play(t);

	2.75.wait;

	Pbind(
		\note, Pseq([23, 21, 25, 23, 21, 20, 18, 16, 20, 21, 23, 21], inf),
		\dur, Pseq([0.25, 0.75, 0.25, 1.75, 0.125, 0.125, 0.80, 0.20, 0.125, 0.125, 1], 1),
		\amp, 0.1,
		\legato, 0.5
	).play(t);
}.fork(t);
)

// Fore more advanced ways of playing Pbinds simultaneously and in sequence, check out Ppar and Pspawner.






















