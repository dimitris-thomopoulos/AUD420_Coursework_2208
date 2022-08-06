(
Pbind(
	\scale, Scale.harmonicMajor,
	\degree, Pseq([0, 1, 2, 3, 4, 5, 6, 7], 1),
	\dur, 0.15;
).play;
)

// Evaluate this line to see a list of all available scales:
Scale.directory;

// If you need a chromatic note in between scale degrees, do this:
(
Pbind(
	\degree, Pseq([0, 1, 2, 3, 3.1, 4], 1),
).play;
)
// The 3.1 above means one chromatic step above scale degree 3 (in this case, F# above F). Note that when you don't explicitly specify a \scale, Scale.major is assumed.

// Transposition - transfer a list of notes some octaves up or down
(
Pbind(
\note, Pser([0, 2, 3, 5, 7, 8, 11, 12], 11),
\ctranspose, 12, // transpose an octave above (= 12 semitones)
\dur, 0.15;
).play;
)

// Microtones with \note and \midinote:
Pbind(\note, Pseq([0, 0.5, 1, 1.5, 1.75, 2], 1)).play;
Pbind(\midinote, Pseq([60, 69, 68.5, 60.25, 70], 1)).play;

















