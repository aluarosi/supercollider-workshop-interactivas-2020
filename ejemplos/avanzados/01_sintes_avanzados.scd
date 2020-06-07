//
// Introducción a SuperCollider - Interactivas 2020
//
// NO OLVIDAR!!!!
StageLimiter.activate;

//////////////////////////////////////////////////////////////////////////////
// Sinte Eli Fieldsteel - https://youtu.be/ZVTbRNu2BI0
// Blip based - Eli's tutorial about Touch OSC
//////////////////////////////////////////////////////////////////////////////

SynthDef(\blip, {
	arg freq=40, nharm=12, detune=0.02, gate=1, pan=0, amp=1, out=0;
	var sig, env;

	env = EnvGen.kr( Env.adsr(0.05, 0.1, 0.5, 3), gate, doneAction: 0);

	sig = Blip.ar(
		freq
		* LFNoise1.kr(0.2!16).bipolar(detune).midiratio,
		nharm);
	sig = sig * LFNoise1.kr(0.5!16).exprange(0.1, 1) * env;
	sig = Splay.ar(sig);
	Out.ar(out, sig);
}).add;

a = Synth(\blip);
a.set(\freq, 40);
a.set(\nharm, 4);
a.set(\detune, 0.02);
a.set(\gate,1);
a.set(\gate,0);
a.free;

//////////////////////////////////////////////////////////////////////////////
// Sinte Eli Fieldsteel - https://youtu.be/LKGGWsXyiyo
//////////////////////////////////////////////////////////////////////////////

(
SynthDef.new(\pulseTest, {
	arg ampHz=4, fund=40, maxPartial=4, width=0.5;
	var amp1, amp2, freq1, freq2, sig1, sig2;
	// Alternation between L and R channels
	amp1 = LFPulse.kr(ampHz, iphase: 0, width: 0.12) * 0.75;
	amp2 = LFPulse.kr(ampHz, iphase: 0.5, width: 0.12) * 0.75;
	// Subtlety: adds a little of 1st harmonic (octave)
	freq1 = LFNoise0.kr(4).exprange(fund, fund*maxPartial).round(fund);
	freq2 = LFNoise0.kr(4).exprange(fund, fund*maxPartial).round(fund);
	freq1 = freq1 * LFPulse.kr(8, add:1);
	freq2 = freq2 * LFPulse.kr(6, add:1);
	sig1 = Pulse.ar(freq1, width, amp1);
	sig2 = Pulse.ar(freq2, width, amp2);
	sig1 = FreeVerb.ar(sig1, mix: 0.7, room: 0.8, damp: 0.25);
	sig2 = FreeVerb.ar(sig2, mix: 0.7, room: 0.8, damp: 0.25);
	Out.ar(0, sig1);
	Out.ar(1, sig2);
}).add;

)

x = Synth.new(\pulseTest);
y = Synth.new(\pulseTest);
x.set(\fund, 80, \maxPartial, 1, \ampHz, 1, \width, 0.7);
y.set(\fund, 40, \maxPartial, 4, \ampHz, 1, \width, 0.2);
x.free;
y.free;

x = Synth.new(\pulseTest, [
	\ampHz, 3.3,
	\fund, 48,
	\maxPartial, 4,
	\width, 0.15
]);

//////////////////////////////////////////////////////////////////////////////
// Dron - co34pt https://theseanco.github.io/howto_co34pt_liveCode/5-1-Drones
//////////////////////////////////////////////////////////////////////////////

(
SynthDef(\dron, {
	arg freq = 50 , res = 1.1;
	var sig;

	sig = DFM1.ar(
		SinOsc.ar(
			freq: [freq, freq*1.01],
			phase: 0,
			mul: 0.1
		),
		freq: freq*2,
		res: SinOsc.kr(0.05).range(0.9,res),
		inputgain: 1,
		type: 0,
		noiselevel: 0.0003,
		mul: 0.5
	);
	Out.ar(0, sig);
}).add;
)

x = Synth.new(\dron);
y = Synth.new(\dron);
x.set(\res, 1.1);
x.set(\freq, 100);



//////////////////////////////////////////////////////////////////////////////
// Sinte Eli Fieldsteel - https://youtu.be/P85X1Ut3Hfc
//////////////////////////////////////////////////////////////////////////////

(
SynthDef(\bpfsaw6, {
	arg atk=2, sus=0, rel=3, c1=1, c2=(-1),
		freq=500, detune=0.2, pan=0,cfhzmin=0.1, cfhzmax= 0.3,
		cfmin=500, cfmax=2000, rqmin=0.1, rqmax=0.2,
		lsf=200, ldb=0, amp=1, out=0;
	var sig, env;

	env = EnvGen.kr(Env([0,1,1,0], [atk,sus,rel],[c1,0,c2]), doneAction:2);
	sig = Saw.ar(freq * { LFNoise1.kr(0.5, detune).midiratio }!2);
	sig = BPF.ar(
		sig,
		{ LFNoise1.kr(
			LFNoise1.kr(4).exprange(cfhzmin,cfhzmax)
		).exprange(cfmin, cfmax) }!2,
		{ LFNoise1.kr(0.1).exprange(rqmin, rqmax) }!2
	);
	// For boosting or atenuating low freqs. Initially to 0db, same as bypass
	sig = BLowShelf.ar(sig, lsf, 0.5, ldb);
	sig = Balance2.ar(sig[0], sig[1], pan);
	sig = sig * env * amp;
	Out.ar(out, sig);
}).add;
)


//////////////////////////////////////////////////////////////////////////////
// Notas individuales
//////////////////////////////////////////////////////////////////////////////

Synth(\bpfsaw6);
Synth(\bpfsaw6, [\atk, 0.1, \rel, 0.1]);
Synth(\bpfsaw6, [\freq, 40]);


//////////////////////////////////////////////////////////////////////////////
// Acumulación de notas y texturas
//////////////////////////////////////////////////////////////////////////////

// Check multiple overlays for ambience
// Also bubbly efects
(
10.do {
	var f=50;
	Synth(\bpfsaw6,
		[
			\freq,  f,
			\amp, 0.2,
			\cfmin, f*2,
			\cfmax, f*50,
			//\rqmin, 0.005,
			//\rqmax, 0.03,
			\rqmin, 0.1,
			\rqmax, 0.2,
			\detune, 0.1,
			\pan, 0,
			\
		]
	);
}
)

//
// Bubbly textures!
// Play with \cfhzmin, \cfhzmax, \cfmin, \cfmax
//
(
10.do {
	Synth(
		\bpfsaw6,
		[
			\freq, 50,
			\amp, 0.5,
			\cfmin, 50*2,
			\cfmax, 50*50,
			\rqmin, 0.01,
			\rqmax, 0.05,
			\cfhzmin, 5,
			\cfhzmax, 40,
			// Resonances stand out
			//\cfhzmin, 1,
			//\cfhzmax, 6
			// Bubbly texture
			\cfhzmin, 30,
			\cfhzmax, 40
		]
	)
}
)


