// The values we provide to the \dur key of a Pbind are in number of beats, that is 1 means one beat, 0.5 means half a beat, and so on. Unless we specify otherwise, the default tempo is 60 BPM (beats per minute). To play at a different tempo, we simply create a new TempoClock. Here's a Pbind playing at 120 beats per minute (BPM):
(
Pbind(
	\degree, Pseq([0, 0.1, 1, 2, 3, 4, 5, 6, 7]), //notice how we omit the repeat argument
	\dur, 1;
).play(TempoClock(120/60)); //120 beats over 60 seconds: 120 BPM
)

// Notice how we omitted the repeat argument inside the Pseq pattern in the example above.
// In SuperCollider, all of the Patterns behave the same when we omit any of their arguments.
// If we skip an argument, SC will use a built-in default value for it. In this case, the default repeats for Pseq is 1.