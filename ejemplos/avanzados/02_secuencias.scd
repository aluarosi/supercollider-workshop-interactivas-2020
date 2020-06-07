//
// Introducción a SuperCollider - Interactivas 2020
//
// NO OLVIDAR!!!!
StageLimiter.activate;

//////////////////////////////////////////////////////////////////////////////
// Secuenciación
//////////////////////////////////////////////////////////////////////////////

(
Pdef(\tema1,
	Pbind(
		\note, Pseq([Rest,7,  0,Rest,0, 7,5,7, 0,Rest,0, 3,Rest,5, 7,5,7, 5,Rest,3, 5,3,5], inf),
		\dur,  Pseq([   4,2,  1,1,1,    1,1,1, 1,1,1,    1,1,1,    1,1,1, 1,1,1,    4,1,1], inf),
		\tempo, 4,
		\amp, 1,
		\instrument, \bpfsaw6,
		\atk, 0.1,
		\rel, 1
	);
);
)

~p1 = Pdef(\tema1).play;
~p1.stop;


(
Pdef(\bajo1,
	Pbind(
		\note, Pseq([0!10], inf),
		\dur,  Pseq([12], inf),
		\amp, 0.3,
		\tempo, 4,
		\octave, 3,
		\instrument, \bpfsaw6
	);
);
)

~bajo1 = Pdef(\bajo1).play;
~bajo1.stop;