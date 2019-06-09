//==========================
//JUHYE MUN
//AUGUST 17, 2017
//Supercollider Workshop
//Final project
//==========================

//Mistake
//daunting, nervous, oh NO

(
SynthDef("tri",{arg freq, amp = 0.2;
	var snd, env;
	env = Env.perc(attackTime:0.01, releaseTime:4,level:amp).kr(doneAction:2);
	snd = LFTri.ar(freq: freq, mul: env);
	Out.ar([0,1], snd);
}).add;
)

(
Pbind(
	\instrument, "tri",
	\note, Pseq([0, 3, 2, [-5,-1,1], 2, -2, -6, [-10,-6,-2,4,6]], 1),
	\octave,5,
	\dur, Pseq([1,1,1,3,1,1,1,3], inf),
	\amp, Pseq([0.1, 0.3, 0.7, 0.9], inf),
	\strum, Pseq([0, 0, 0, 0.05, 0, 0, 0, 0.1], inf),
	\legato, Pseq([0.97, 0.97, 0.97, 0.85, 0.97, 0.97, 0.97, 0.7], inf),
	\tempo, 50/60
).trace(\amp).play;
)