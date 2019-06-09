//==========================
//JUHYE MUN
//AUGUST 17, 2017
//Supercollider Workshop
//Final project
//==========================

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