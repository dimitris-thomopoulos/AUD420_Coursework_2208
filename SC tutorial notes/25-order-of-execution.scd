// Create an audio bus
~fxBus = Bus.audio(s, 1);
~masterBus = Bus.audio(s, 1);

// Create SynthDefs
(
SynthDef("noise", {Out.ar(~fxBus, WhiteNoise.ar(0.5))}).add;
SynthDef("filter", {Out.ar(~masterBus, BPF.ar(in: In.ar(~fxBus), freq: MouseY.kr(1000, 5000), rq: 0.1))}).add;
SynthDef("masterOut", {arg amp = 1; Out.ar(0, In.ar(~masterBus) * Lag.kr(amp, 1))}).add;
)

// Open Node Tree window:
s.plotTree;

// Play synths (watch Node Tree)
m = Synth("masterOut");
f = Synth("filter");
n = Synth("noise");

// Master volume
m.set(\amp, 0.1);


/*
First, two audio buses assigned to the variables ~fxbus and ~masterBus.
Second, three SynthDefs are created:
• "noise" is a noise source that sends white noise to an effects bus;
• "filter" is a band pass filter which takes its input from the effects bus, and sends the processed sound out to the master bus;
• "masterOut" takes in the signal from the master bus and applies a simple volume control to it, sending the final sound with adjusted volume to the loudspeakers.

Watch the Node Tree as you run the synths in order.
*/

// This is the right order we want: reading from top to bottom, the noise source flows into the filter, and result of the filter flows into the master bus.
// If you now try running the example again, but evaluating the lines m, f, and n in reverse order, you will hear nothing, because the signals are being calculated in the wrong order.



/*
Evaluating the right lines in the right order is fine, but it might get tricky as your code becomes more complex.
In order to make this job easier, SuperCollider allows you to explicitly define where to place synths in the Node Tree.
For this, we use the target and addAction arguments:
*/
n = Synth("noise", addAction: 'addToHead');
m = Synth("masterOut", addAction: 'addToTail');
f = Synth("filter", target: n, addAction: 'addAfter');

// Now, no matter in what order you execute the lines above, you can be sure that nodes will fall in the right places.
// The "noise" synth is explicitly told to be added to the head of the Node Tree; "masterOut" is added to the tail; and filter is explicitly added right after target n (the noise synth).