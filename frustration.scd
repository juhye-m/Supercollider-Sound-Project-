//==========================
//JUHYE MUN
//AUGUST 17, 2017
//Supercollider Workshop
//Final project
//==========================

//Frustration
//disonant and minor chords played in aggressive, fortissimo fashion, buzzing

//builds up until the person cannot take it any longer and distorts/EXPLODES

~goat = Buffer.read(s, "C:/Users/Girls Who Code/Downloads/Funny Goats Screaming like Humans.wav");
~goat.play;

(
~dimchrom =
Pbind(
	\instrument, "saw",
	\note, Pseq([[0,3,6], [1,4,7], [2,5,8], [3,6,9], [4,7,10], [5,8,11]] - 12, 13),
	\ctranspose, Pstutter(6, Pseries(0,2,inf)) + Pn(Pseries(0,2,6),inf),
	// \dur, Pdefn(\accel, 0.5),
	\dur, Pgeom(2, 0.93, inf).max(0.05),
	\amp, 0.4,
	\tempo, 60/60,
	\legato, 0.9
	/*\amp, Pgeom(0.2, 1.03).min(0.5)*/
	/*\dur, Pgeom(Pdefn(\accel, 0.5), 0.97, 12), //an accelerando!
	\amp, Pgeom(Pdefn(\cresc, 0.2), 1.05, 18)*/
)
)

(
SynthDef("saw",{arg freq, amp = 0.2;
	var snd, env;
	env = Env.perc(attackTime:0.01, releaseTime:4,level:amp).kr(doneAction:2);
	snd = Pulse.ar(freq: freq, mul: env);
	Out.ar([0,1], snd);
}).add;
)

(
Pbind(
	\instrument, "saw",
	\freq, 440,
).play;
)

(
SynthDef("grr",
    { Out.ar([0,1], Saw.ar(freq: MouseX.kr(30, 100), mul: 0.4)) }
).add;
)

max(rrand(0,20), 10);

//PLAY ME!! FRUSTRATION >:(
(
Pspawner({ arg frustration;
	~grr = Synth("grr");
	frustration.seq(~dimchrom);
	1.wait;
	{PlayBuf.ar(numChannels:2, bufnum:~goat, rate:1, doneAction:2)}.play;
	frustration.suspendAll;
	~grr.free;
}).play;
)
{PlayBuf.ar(numChannels:2, bufnum:~goat, rate:1.5, doneAction:2)};