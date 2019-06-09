//==========================
//JUHYE MUN
//AUGUST 17, 2017
//Supercollider Workshop
//Final project
//==========================

//Trampoline jump
//"A falsetto "oo-whoop" that is immediately followed by an identical "woo" down"

(
SynthDef(
	name:"whoop",
	ugenGraphFunc:
{arg freq=440, amp=0.2, pos=0;

		var snd, env;
		env = Env.perc(attackTime: 0.01, releaseTime: 1, level: amp).kr(doneAction: 2);
		// freq = XLine.kr(start:freq, end:freq*4, dur: 0.05);
		freq = Env.pairs([[0, freq], [0.1, freq*1.2], [0.8, freq*5]], -2).kr;

		snd = SinOsc.ar(freq: freq, mul: SinOsc.kr(freq:0.5).range(0.2,0.9));
		snd = Pan2.ar(snd, pos);
		Out.ar(0, snd * env);
}
).add;

SynthDef(
	name:"dwhoop",
	ugenGraphFunc:
{arg freq=440, amp=0.2, pos=0;

		var snd, env;
		env = Env.perc(attackTime: 0.01, releaseTime: 1, level: amp).kr(doneAction: 2);
		// freq = XLine.kr(start:freq, end:freq*4, dur: 0.05);
		freq = Env.pairs([[0, freq*5], [0.2, freq*4.8], [0.8, freq]], -2).kr;

		snd = SinOsc.ar(freq: freq, mul: SinOsc.kr(freq:0.5).range(0.2,0.9));
		snd = Pan2.ar(snd, pos);
		Out.ar(0, snd * env);
}
).add;
)


//PLAY ME! JUMP
(
~jump =
Pbind(
	\instrument, "whoop",
	\degree, Pseq([0, 2, -3, 0], inf),
	\dur, 1,
	\ctranspose,-12,
	\tempo, 60/60,
	\amp, 0.8,
).play;

~fall =
Pbind(
	\instrument, "dwhoop",
	\degree, Pseq([2], inf),
	\dur, Pseq([Rest(0.5), 0.5],inf),
	\ctranspose,-12,
	\tempo, 60/60,
	\amp, 0.6
).play;

)