// Expanding your pattern vocabulary

// Pser
(
Pbind(
	\note, Pseq([0, 2, 3, 5, 7, 8, 11, 12], 11),
	\dur, 0.15;
).play;
7)

// The difference between Pseq and Pser is that Pseq counts cycles using the whole list as a single repeat, while Pser counts cycles using each list item as a single repeat.


/*Another popular member of the Pattern family is Pwhite. It is an equal distribution random
number generator (the name comes from “white noise”). For example, Pwhite(100, 500) will
get you random numbers between 100 and 500.*/

(
Pbind(
	\freq, Pwhite(100, 500),
	\dur, Prand([0.15, 0.25, 0.3], inf),
	\amp, 0.2,
	\legato, 0.3
).trace.play;
)

// Pxrand - lke Prand, but Pxrand never repeats the same element twice in a row.
// Both prand and pxrand count each list item as a single repeat.
// Compare with Prand to hear the difference
(
p = Pbind(
	\note, Pxrand([0, 2, 3, 5, 7, 8, 11, 12],3),
	\dur, 0.15;
).play;
)

// Pshuf - seqientially embeds values in a list in constant, but random order in each evaluation. Pshuf counts the whole list as a single repeat.
(
p = Pbind(
	\note, Pshuf([0, 2, 3, 5, 7, 8, 11, 12], 6),
	\dur, 0.15;
).play;
)

// Pslide - slides over a list of values and embed them
// Takes 4 arguments: list, repeats, length, step
(
Pbind(
	\note, Pslide([0, 2, 3, 5, 7, 8, 11, 12], 7, 3, 1),
	\dur, 0.15;
).play;
)

// Pseries -arithmetic series pattern
// Takes three arguments: start, step, length
(
Pbind(
	\note, Pseries(0, 2, 15),
	\dur, 0.15;
).play;
)

// Pgeom - geometric series pattern
// Takes three arguments: start, grow, length
(
Pbind(
	\note, Pseq([0, 2, 3, 5, 7, 8, 11, 12], inf),
	\dur, Pgeom(0.1, 1.1, 25);
).play;
)

// Pn - repeatedly embeds a pattern
(
Pbind(
	\note, Pseq([0, Pn(2,3), 3, Pn(5,3), 7, Pn(8,3), 11, 12], 1),
	\dur, 0.15;
).play;
)







