//
// A Function
//
(

f = {
	arg a, b;
	a + b;
};

)

f.value(3,4);


//
// Theremin
//

(
f = {
	SinOsc.ar(
		MouseX.kr(27.5!2, 14080, warp: 'exponential'),
		0,
		MouseY.kr(0, 1, warp: 0)
	);
};
)

f.play;





(

SynthDef(\theremin1, {
	//
	// Notes to frequencies
	// A0 -->  27.5 Hz
	// A1 -->    55 Hz
	// A2 -->   110 Hz
	// A3 -->   220 Hz
	// A4 -->   440 Hz
	// A5 -->   880 Hz
	// A6 -->  1760 Hz
	// A7 -->  3520 Hz
	// A8 -->  7040 Hz
	// A9 --> 14080 Hz
	//
	arg freqmin = 27.5, freqmax = 14080;
	var sig, xpos, ypos;

	xpos = MouseX.kr(freqmin, freqmax, warp: 'exponential');
	ypos = MouseY.kr(0,1);
	sig = SinOsc.ar(
		freq: xpos,
		mul: ypos
	);
	Out.ar(0, sig!2);

}).add;

)

~theremin = Synth(\theremin1);
~theremin.free;

//
// - Arguments
// - Binaural detuning
//

(

SynthDef(\theremin2, {

	arg freqmin = 27.5, freqmax = 14080, detune = 1.1;
	var sig, xpos, ypos;

	xpos = MouseX.kr(freqmin, freqmax, warp: 'exponential').poll;
	ypos = MouseY.kr(0,1);
	sig = SinOsc.ar(
		freq: [xpos, xpos*detune],
		mul: ypos
	);
	Out.ar(0, sig);

}).add;

)

~theremin = Synth(\theremin2);
~theremin.set(\detune, 2);
~theremin.free;

//
// - CONTROL signals
// - Low freq noise
// - Phase modulation
// - Tremolo
// - Vibrato
//

(

SynthDef(\theremin3, {

	arg freqmin = 27.5, freqmax = 14080, detune = 1.01, freqPhase = 8, tremDepth = 0.1, vibDepth = 0.01;
	var sig, xpos, ypos, tremolo, vibrato;

	xpos = MouseX.kr(freqmin, freqmax, warp: 'exponential').poll;
	ypos = MouseY.kr(0,1);
	tremolo = SinOsc.kr(2);
	vibrato = xpos * (1 + (vibDepth * SinOsc.kr(10)));
	sig = SinOsc.ar(
		freq: [vibrato, vibrato*detune],
		phase: LFNoise0.kr(
			freq: freqPhase.poll,
			mul: pi,
			add: 0
		)
	);
	Out.ar(0, sig * (0.9 + (tremDepth * tremolo)));

}).add;

)

~theremin = Synth(\theremin3);
~theremin.set(\detune, 2);
~theremin.set(\freqPhase, 0);
~theremin.set(\tremDepth, 0.01);
~theremin.set(\vibDepth, 0.01);
~theremin.free;

(
{
	LFNoise2.kr(10);
}.plot(10);
)


//
// - Patterns
//


(

SynthDef(\theremin4, {

	arg freqmin = 27.5, freqmax = 14080, detune = 1.01,
	    freqPhase = 8, tremDepth = 0.1, vibDepth = 0.01,
	    freq = 110;
	var sig, xpos, ypos, tremolo, vibrato;

	xpos = MouseX.kr(freqmin, freqmax, warp: 'exponential').poll;
	ypos = MouseY.kr(0,1);
	tremolo = SinOsc.kr(2);
	vibrato = freq * (1 + (vibDepth * SinOsc.kr(10)));
	sig = SinOsc.ar(
		freq: [freq, freq],
		phase: LFNoise0.kr(
			freq: freqPhase.poll,
			mul: pi,
			add: 0
		)
	);
	Out.ar(0, sig * (0.9 + (tremDepth * tremolo)));

}).add;

)

(
Pdef(\goodvibes, Pmono(
	\theremin4,
	\dur, Pseq([1,1,2,2,2], inf),
	\tempo, 2,
	\freqPhase, 0,
	\note, Pseq([-5, 7, 5, 4, 5], inf),
	\octave, 4
));
)

p = Pdef(\goodvibes).play;