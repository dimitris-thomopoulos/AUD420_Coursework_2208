"Hello World".postln;

{SinOsc.ar}.play;

// s.volume.gui;

{SinOsc.ar(LFNoise0.kr(10).range(500, 1500), mul: 0.1)}.play;

{RLPF.ar(Dust.ar([12, 15]), LFNoise1.ar([5, 0.2]).range(100, 3000), 0.02)}.play;