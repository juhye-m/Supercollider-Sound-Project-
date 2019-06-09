//==========================
//JUHYE MUN
//AUGUST 17, 2017
//Supercollider Workshop
//Final project
//==========================

//WATER
//"A deep, lightly pulsing hum with a pure, clear ringing over the top. Some higher plinking notes as well."

//flow --> pans from left to right and amp "pulses", therefore "flowing" from left to right to left,etc
//perfect 5th sounds "pure"
//plinks --> like drops of water

(
SynthDef(
	name:"flowdeep",
	ugenGraphFunc:
	{arg freq=110, pos=0;

		var snd;
		freq = freq;
		snd = SinOsc.ar(freq: freq, mul: SinOsc.kr(freq:0.5).range(0.1,0.3));
		snd = Pan2.ar(snd, SinOsc.kr(freq: 0.5));
		Out.ar(0, snd);
}
).add;

SynthDef(
	name:"flowlow",
	ugenGraphFunc:
	{arg freq=329.63, pos=0;

		var snd;
		freq = freq;
		snd = SinOsc.ar(freq: freq, mul: SinOsc.kr(freq:0.5).range(0.1,0.3));
		snd = Pan2.ar(snd, SinOsc.kr(freq: 0.5));
		Out.ar(0, snd);
}
).add;

SynthDef(
	name:"ping",
	ugenGraphFunc:
{arg freq=440, amp=0.2, pos=0;

		var snd, env, env2;
		env = Env.perc(attackTime: 0.01, releaseTime: 0.1, level: amp).kr;
		env2 = Env.linen(attackTime:0.01, sustainTime:1, releaseTime:0.1).kr(doneAction: 2);  //second env that allows space for reverb to sound
		// freq = XLine.kr(start:freq, end:freq*4, dur: 0.05);
		freq = Env.pairs([[0, freq], [0.03, freq*1.2], [0.2, freq*5]], -2).kr;

		snd = SinOsc.ar(freq: freq, mul: SinOsc.kr(freq:0.5).range(0.2,0.9));
		snd = Pan2.ar(snd, pos) * env;  //put env here
		snd = FreeVerb.ar(
			in: snd,
			mix: 0.5,
			room: 0.9
		);
		Out.ar(0, snd * env2);  //if you put env here, that it multiplies to zero at the end so tou cannot hear reverb in env2
}
).add;
)

Synth("flow");

(
~pings =
Pbind(
	\instrument, "ping",
	\freq, Pwhite(400,600, 200),
	\amp, Pwhite(0.5, 1),
	\dur, Pwhite(0.2, 1),
	\pos, Pwhite(-1, 1)
)
)

//PLAY ME!!! WATER
(
Pspawner({ arg water;

	Synth("flowdeep");
	Synth("flowlow");
    water.seq(~pings);
	water.suspendAll;

	}).play
)