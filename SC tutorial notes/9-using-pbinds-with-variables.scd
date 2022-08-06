// Using the same sequence of numbers a lot? Save it in a variable:
c = [0, 2, 3, 5, 7, 8, 11, 12];

// Now you can just refer to it:
Pbind(\note, Pseq(c, 1), \dur, 0.15).play;
Pbind(\note, Prand(c, 6), \dur, 0.15).play;
Pbind(\note, Pslide(c, 5, 3, 1), \dur, 0.15).play;

/*Another example to practice using variables: let’s say we want to play two Pbinds simultaneously. One of them does an ascending major scale, the other does a descending major scale one octave above. Both use the same list of durations. Here is one way of writing this:*/

~scale = [0, 1, 2, 3, 4, 5, 6, 7];
~durs = [0.4, 0.2, 0.2, 0.4, 0.8, 0.2, 0.2, 0.2];
(
Pbind(
	\degree, Pseq(~scale),
	\dur, Pseq(~durs)
).play;

Pbind(
	\degree, Pseq(~scale.reverse + 7),
	\dur, Pseq(~durs)
).play;
)