(
Pbind (
	\degree, Pseq([0, 1, 2, 3, 4, 5, 6, 7], 5),

	// here, we provide a sequence in place of the \dur value
	/* notice how we insert a sequence list of 6 elements, while we passed 8 notes in the first sequence. When we provide sequences of different sizes, pbind cycles through the sequences as needed */

	// A Pbind stops playing when the shortest internal pattern has finished playing (as determined by the repeats argument of each internal pattern).

	// The values we provide to the \dur key of a Pbind are in number of beats, that is 1 means one beat, 0.5 means half a beat, and so on.
	\dur, Pseq([0.2, 0.1, 0.1, 0.2, 0.2, 0.35], inf)
).play;
)