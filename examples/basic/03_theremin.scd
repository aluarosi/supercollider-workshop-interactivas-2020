//
// Introducción a SuperCollider - Interactivas 2020
//
// NO OLVIDAR!!!!
StageLimiter.activate;

//////////////////////////////////////////////////////////////////////////////
// Theremin virtual
//////////////////////////////////////////////////////////////////////////////
(
SynthDef(\theremin, {

	var sig, amp, freq;

	freq = MouseX.kr(minval: 20, maxval: 10000, warp: 'exponential');
	amp = MouseY.kr(minval: 0.001, maxval: 1, warp: 'exponential');
	freq.poll; amp.poll;
	sig = SinOsc.ar(freq: [freq,freq], mul: amp);

	Out.ar(0, sig);

}).add;
)

t = Synth(\theremin);
t.free;

//
// Theremin con señal en diente de sierra
//
(
SynthDef(\thereminSaw, {

	var sig, amp, freq;

	freq = MouseX.kr(minval: 1, maxval: 10000, warp: 'exponential');
	amp = MouseY.kr(minval: 0.001, maxval: 1, warp: 'exponential');
	freq.poll; amp.poll;
	sig = Saw.ar(freq: [freq,freq], mul: amp);

	Out.ar(0, sig);

}).add;
)

t = Synth(\thereminSaw);
t.free;

//
// Theremin como "flauta de ruido"
//
(
SynthDef(\thereminRuido, {

	arg vol = 1;
	var sig, sig1, sig2, amp, freq;

	freq = MouseX.kr(minval: 50, maxval: 10000, warp: 'exponential');
	amp = MouseY.kr(minval: 0.001, maxval: 1, warp: 'exponential');
	freq.poll; amp.poll;
	sig1 = PinkNoise.ar(amp);
	sig2 = PinkNoise.ar(amp);
	sig = Resonz.ar(in: [sig1, sig2], freq: freq, bwr: 0.1, mul:vol);

	Out.ar(0, sig);

}).add;
)

r = Synth(\thereminRuido, [\vol, 100]);
r.free;
