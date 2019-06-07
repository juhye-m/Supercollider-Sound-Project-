//==========================
//JUHYE MUN
//AUGUST 17, 2017
//Supercollider Workshop
//Final project
//==========================

//Maraschino cherry
//"High pitched, loud, nonsensical noise and a bit annoying"

//nonsensical annoying high pitched sound --> Pwhite for nonsensical, high freqs
(
~nonsense =
Pbind(
	\freq, Pwhite(4000, 8000),
	\dur, Pwhite(0.2, 0.6, 200),
);


//annoying happy bright melody -->annoying bc it is the same thing and very basic

~cherry =
Pbind(
	\degree, Pseq([2, 1, 0, 4, 3, 2, 1, 0], 20),
	\octave, 7,
	\dur, 0.2,
	\tempo, 60/60,
)
)

//PLAY ME! Maraschino Cherry!!!
(
Pspawner({arg mcherry;
	mcherry.par(~nonsense);
	mcherry.seq(~cherry);
	mcherry.suspendAll;
}).play;
)





NEXT ONE
//trampoline jump
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

/*~squeak =
Pbind(
	\instrument, "trianglewavebells",
	\freq, Pseq([88, 44],inf),
	\dur, Pseq([Rest(0.5), 1/4, 1/4, Rest(0.5), 1/4, Rest(1/4), Rest(0.5), 1/4, 1/4, Rest(0.5), 1/4, Rest(1/4) ], inf),
).play;*/

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








//ignore below

SynthDef("trianglewavebells",{
	arg out = 0, pan = 0.0, freq = 440, amp = 1.0, gate = 1, att = 0.01, dec = 0.1, sus = 1, rel = 0.5, lforate = 10, lfowidth = 0.0, cutoff = 100, rq = 0.5;

	var osc1, osc2, vibrato, filter, env;
	vibrato = SinOsc.ar(lforate, Rand(0, 2.0));
	osc1 = Saw.ar(freq * (1.0 + (lfowidth * vibrato)), 0.75);
	osc2 = Mix(LFTri.ar((freq.cpsmidi + [11.9, 12.1]).midicps));
	filter = RHPF.ar((osc1 + (osc2 * 0.5)) * 0.5, cutoff, rq);
	env = EnvGen.ar(
		envelope: Env.adsr(att, dec, sus, rel, amp),
		gate: gate,
		doneAction: 2);
	Out.ar(out, Pan2.ar(filter * env, pan));
}).add;


NEXT
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

//

(
Pbind(
	\freq, 440
).play;
Pbind(
	\freq, 659.25,
).play;)

next
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

next

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



next
//oblivion - a sucking sound, like water going down a drain.

//melody goes down like water swirls the drain

~drain1 = Buffer.read(s, "C:/Users/Girls Who Code/Downloads/less than giant sucking sound (1).wav");

(
SynthDef("drain-1",
	{/*arg rate;*/
		var snd, env;
		env = Env.perc(releaseTime:7).kr;
		snd = PlayBuf.ar(numChannels: 2, bufnum: ~drain1, rate: 1, loop:1);
	    Out.ar([0,1], snd * env);
}).add;
)

//draining
( ~drain =
Pbind(
	\instrument, "drain-1",
	\dur, Pseq([3.97], 10),
	\tempo, 60/60
);

~obliv =
Pbind(
	\instrument, "tri",
	\note, Pseq([Rest(1),4,11, 7,6,4,6,7,3,4,-1,0,-3,-1,-5,-3,-6,-8,-10,-12,-13,-15,-17,-18,-20] , 1),
	\dur, Pseq([Rest(1),0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,1],inf)
)
)

//PLAY ME! OBLIVION
(
Pspawner({arg oblivion;
	oblivion.par(~drain);
	oblivion.seq(~obliv);
	oblivion.suspendAll;
}).play;
)

(
SynthDef("lowbuzz",
	{/*arg amp = 0.2;*/
		var snd, env;
		env = Env.perc().kr;
		snd = PinkNoise.ar();
		Out.ar([0,1], snd *env);
}).add;
)

//buzzing
(
Pbind(
	\instrument, "lowbuzz",
).play;
)

~buf1.numChannels;
~buf1.duration;
~buf1.sampleRate;

~drain2 = Buffer.read(s, "C:/Users/Girls Who Code/Downloads/less than giant sucking sound (2).wav");
~drain2.play;

~drain3 = Buffer.read(s, "C:/Users/Girls Who Code/Downloads/Sink draining sound effect water down the plug hole sounds.wav");
~drain3.play;