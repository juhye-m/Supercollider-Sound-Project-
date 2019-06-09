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

//PLAY ME! Maraschino Cherry
(
Pspawner({arg mcherry;
	mcherry.par(~nonsense);
	mcherry.seq(~cherry);
	mcherry.suspendAll;
}).play;
)
