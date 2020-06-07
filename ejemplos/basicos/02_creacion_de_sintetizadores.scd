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
// Cambio de amplitud (volumen)
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
