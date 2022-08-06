// Run this first ('turn reverb on' -- you won't hear anything at first)
r = {Out.ar(0, FreeVerb.ar(In.ar(55, 2), mix: 0.5, room: 0.9, mul: 0.4))}.play;

// Now run this second ('feed the busy tone into the reverb bus')
a = {Out.ar(55, SinOsc.ar([440, 480], mul: LFPulse.ar(0.22)))}.play;
a.free;

/* IMPORTANT: Due to multichannel expansion, when (in synth a) we route the sound to bus 55, two buses are actually being used up—number 55, and the immediately adjacent bus 56.
In the reverb (synth r), we indicate with In.ar(55, 2) that we want to read 2 channels starting from bus 55: so both 55 and 56 get into the reverb.
The output of the reverb is in turn also expanded to two channels, so because we set this synth to bus 0, synth r sends sound out to buses 0 and 1 (left and right channels of our sound card).*/


// Bus objects
/* How inconvenient it would be if we had to keep track of bus numbers ourselves. As soon as our patches grew in complexity, imagine the nightmare:
“What bus number did I choose again for reverb? Was it 59 or 95? What about the bus number for my delay? I guess it was 27? Can’t recall...” and so on and so forth.
SuperCollider takes care of this for you with Bus objects.*/

// Create the bus - first argument 's' stands for server, second argument is the number of channels we want
~myBus = Bus.audio(s, 2);

// Turn on the reverb: read from myBus (source sound)
r = {Out.ar(0, FreeVerb.ar(In.ar(~myBus, 2), mix: 0.5, room: 0.9, mul: 0.4))}.play;

// Feed the busy tone into ~myBus
b = {Out.ar(~myBus, SinOsc.ar([800, 880], mul: LFPulse.ar(2)))}.play;

// Free both synths
r.free; b.free;