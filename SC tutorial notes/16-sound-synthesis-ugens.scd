// UnitGenerators (UGens)

// Since we used Pbinds to make sound in SuperCollider so far, you may be tempted to think: “I see, so the Pbind is a Unit Generator!” That’s not the case. Pbind is not a Unit Generator—it is just a recipe for making musical events (score). “So the EventStreamPlayer, the thing that results when I call play on a Pbind, THAT must be a UGen!” The answer is still no. The EventStreamPlayer is just the player, like a pianist, and the pianist does not generate sound. In keeping with this limited metaphor, the instrument piano is the thing that actually vibrates and generates sound. That is a more apt analogy for a UGen: it’s not the score, nor the player: it’s the instrument. When you made music with Pbinds earlier, SC would create an EventStreamPlayer to play your score with the built-in piano synth. You didn’t have to worry about creating the piano or any of that—SuperCollider did all the work under the hood for you. That hidden piano synth is made of a combination of a few Unit Generators.


// an example of a simple synth that is a simulation of the Theremin, one of the oldest electronic instruments:
{SinOsc.ar(freq: MouseX.kr(300, 2500), mul: MouseY.kr(0, 1))}.play;

// other basic UGens:
{Saw.ar(freq: MouseX.kr(300, 2500), mul: MouseY.kr(0, 1))}.play;
{Pulse.ar(freq: MouseX.kr(300, 2500), mul: MouseY.kr(0, 1))}.play;

{ SinOsc.ar}.plot; // sine wave
{ Saw.ar }.plot; // sawtooth wave
{ Pulse.ar }.plot; // square wave

// monitor the waveform in real time as it plays:
{Saw.ar(freq: MouseX.kr(300, 2500), mul: MouseY.kr(0, 1))}.scope;


// the .ar and .kr messages stand for 'Audio Rate' and 'Control Rate'



// The poll method asks SC to print a few of the produced samples/numbers every second

// just watch the Post window (no sound)
{SinOsc.kr(1).poll}.play;

// hit ctrl+period, then evaluate the next line:
{LFPulse.kr(1).poll}.play;

//LowFrequencyNoise UGen is a bipolar UGen, meaning it produces numbes between -1 and +1
{LFNoise0.ar(1).poll}.play;



// UGen arguments
// to find which arguments each UGen accepts, select the UGen class/name and hit [Ctrl+D]

// minval and maxval provided in order, no keywords
{MouseX.kr(300, 2500).poll}.play;
// minval, maxval and lag provided, skipped warp
{MouseX.kr(minval: 300, maxval: 2500, lag: 10).poll}.play;





// scaling with the method 'range'

{SinOsc.ar(freq: LFNoise0.kr(10).range(500, 1500), mul: 0.1)}.play;

// 'range' takes the output of LFNoise0 (which is between -1 and +1) and scales it to a bigger range, whose starting and ending values are the arguments we declared inside 'range'.

// Breaking it down:
{LFNoise0.kr(1).poll}.play; // watch a simple LFNoise0 in action
{LFNoise0.kr(1).range(500, 1500).poll}.play; // now with .range
{LFNoise0.kr(10).range(500, 1500).poll}.play; // now faster

// scaling with 'mul' and 'add'

// This:
{SinOsc.kr(1).range(100, 200).poll}.play;
// ...is the same as this:
{SinOsc.kr(1, mul: 50, add: 150).poll}.play;

// This:
{LFPulse.kr(1).range(100, 200).poll}.play;
// ...is the same as this:
{LFPulse.kr(1, mul: 50, add: 100).poll}.play;



// scaling with 'linlin', 'linexp', 'explin', 'expexp'

// A bunch of numbers
a = [1, 2, 3, 4, 5, 6, 7];
// Rescale to 0-127, linear to linear
a.linlin(1, 7, 0, 127).round(1);
// Rescale to 0-127, linear to exponential
a.linexp(1, 7, 0.01, 127).round(1); // don't use zero for an exponential range