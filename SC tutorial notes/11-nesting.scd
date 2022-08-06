// Nesting and proper indentation
(
{
				CombN.ar(
								SinOsc.ar(
												midicps(
																LFNoise1.ar(3, 24,
																				LFSaw.ar([5, 5.123], 0, 3, 80)
																 )
												),
												0, 0.4
								),
								1, 0.3, 2)
}.play;
)

/*
TIP: If for whatever reason your code has lost proper indentation, simply select all of it and
go to menu Edit!Autoindent Line or Region, and it will be fixed.
*/