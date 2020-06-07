//
// Introducción a SuperCollider - Interactivas 2020
//
// NO OLVIDAR!!!!
StageLimiter.activate;

////////////////////////////////////////////////////////////////////////////////
// Funciones
////////////////////////////////////////////////////////////////////////////////

e = { BrownNoise.ar(mul: 0.5!2) }.play;

//
// Una función
//
{ BrownNoise.ar(mul: 0.5!2) };

f = { 1 + 2 };

f;
f.value;

// Función con parámetros

(
f = {
	arg a, b;
	a + b * 2;
};
)

f;
f.value;
f.value(2,3);
f.value(4,5);

// Función con parámetros y variables locales

(
g = {
	arg a, b;
	var result;
	result = a + b * 2;
};
)

g.value(3,4);

// Funciones + .play
{ BrownNoise.ar(mul: 0.5!2) }.play;


////////////////////////////////////////////////////////////////////////////////
// Sintetizadores
////////////////////////////////////////////////////////////////////////////////


//
// Creación de sinte
//
(
SynthDef(\ruido, {

	var sig;
	sig = BrownNoise.ar(mul: 0.5!2);
	Out.ar(0, sig);

}).add;
)

//
// Uso de sinte
//

a = Synth(\ruido);
a.free;

//
// Creación de sinte con parámetros
//
(
SynthDef(\tonoBinaural, {

	arg freq1=440, freq2=450;
	var sig;

	sig = SinOsc.ar(freq: [freq1, freq2], mul: 0.5!2);
	Out.ar(0, sig);

}).add;
)

b = Synth(\tonoBinaural);
c = Synth(\tonoBinaural, [\freq1, 100, \freq2, 900]);
c.free;
b.free;


////////////////////////////////////////////////////////////////////////////////
// Cambiando parámetros de sintetizadores
////////////////////////////////////////////////////////////////////////////////

//
// Cambio de amplitud (volumen) y tono
//
(
SynthDef(\tonoBinaural2, {

	arg freq = 440, incrementoFreq = 5, amp = 0.5;
	var sig;

	sig = SinOsc.ar(freq: [freq, freq + incrementoFreq], mul: amp!2);
	Out.ar(0, sig);

}).add;
)

e = Synth(\tonoBinaural2, [\freq, 200, amp: 0.4]);
e.set(\amp, 0);
e.set(\amp, 0.5);

e.set(\freq, 200);
e.set(\freq, 225);
e.set(\freq, 250);
e.set(\freq, 11/8 * 200);
e.set(\freq, 300);
e.set(\freq, 350);
e.set(\freq, 400);

e.free;


////////////////////////////////////////////////////////////////////////////////
// Envolventes
////////////////////////////////////////////////////////////////////////////////

//
// Sinte percusivo controlado por señal "puerta" (gate)
//

Env.new(levels: [0, 1, 0], times: [0.1, 1], curve: 'lin').plot;

(
SynthDef(\tonoBinaural3, {

	arg freq = 440, incrementoFreq = 5, amp = 0.5, gate = 1;
	var sig, env;

	env = EnvGen.kr(
		Env.new(
			levels: [0, 1, 0],
			times: [0.1, 1],
			curve: 'lin'
		),
		gate: gate
	);

	sig = SinOsc.ar(freq: [freq, freq + incrementoFreq], mul: amp!2);
	Out.ar(0, sig * env);

}).add;
)

e = Synth(\tonoBinaural3, [\freq, 200, amp: 0.4]);
e.set(\gate, 0);
e.set(\gate, 1);

//
// Sinte percusivo que se auto-termina
//
(
SynthDef(\tonoBinaural4, {

	arg freq = 440, incrementoFreq = 5, amp = 0.5, gate = 1;
	var sig, env;

	env = EnvGen.kr(
		Env.new(
			levels: [0, 1, 0],
			times: [0.1, 1],
			curve: 'lin'
		),
		doneAction: 2  // Esto termina el sinte cuando la envolvente termina
	);

	sig = SinOsc.ar(freq: [freq, freq + incrementoFreq], mul: amp!2);
	Out.ar(0, sig * env);

}).add;
)

f = Synth(\tonoBinaural4, [\freq, 200, amp: 0.4]);


//
// Pequeña secuencia
//

(
Pdef(\goodvibes, Pbind(
	\instrument, \tonoBinaural4,
	\dur, Pseq([1,1,2,2,2], inf),
	\tempo, 2,
	\note, Pseq([-5, 7, 5, 4, 5], inf),
	\octave, 5
));
)

p = Pdef(\goodvibes).play;