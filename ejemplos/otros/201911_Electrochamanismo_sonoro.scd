////////////////////////////////////////////////////////////////////////////////
//
// Electro Chamanismo Sonoro - Interactivas Noviembre 2019
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Filtrado de frecuencias
////////////////////////////////////////////////////////////////////////////////

//
// Pink noise
//
(
{
	PinkNoise.ar(0.5)!2;
}.play;
)

//
// Band-pass filtering pink noise
//
(
{
	BPF.ar(
		PinkNoise.ar(1)!2,
		freq: MouseX.kr(50, 10000, warp:1),
		rq: 0.1,
		mul: 1.0
	);
}.play;
)

////////////////////////////////////////////////////////////////////////////////
// Afinación justa vs. temperada
////////////////////////////////////////////////////////////////////////////////

//
// Intervalo justo vs temperado
//
(
{
	var note1, note2, phase, la;

	la = 57;
	note1 = 220; note2 = note1 * 5/4;
	//note1 = la.midicps; note2 = (la+4).midicps;

	phase = MouseX.kr(0,2*pi);

	SinOsc.ar(
		[note1, note2],
		[0, phase]
	);
}.play;
)

//
// Intervalo justo vs temperado - Explorando relaciones con el ratón
//
(
{
	var note1, note2, phase, num, den;

	num = MouseX.kr(8,16).round.poll;
	den = MouseY.kr(8,16).round.poll;
	note1 = 60.midicps; note2 = note1 * num / den;

	SinOsc.ar(
		[note1, note2]
	);
}.play;
)

//
// Acorde justo vs temperado
//
(
{
	var note1, note2,note3,note4, phase, do, mi, sol, do2;

	do = 60; mi = do+4; sol= do+7; do2 = do+12;
	note1 = do.midicps; note2 = note1 * 3/2; note3 = note1 * 5/4; note4 = note1 * 7/4;
	//note1 = do.midicps; note2 = sol.midicps; note3 = mi.midicps; note4 = do2.midicps;

	phase = MouseX.kr(0,2*pi);

	[
		SinOsc.ar(note1, phase) + SinOsc.ar(note3, phase),
		SinOsc.ar(note2, phase) + SinOsc.ar(note4, phase)
	]
}.play;
)

//
// Intervalo justo vs temperado - Modulando la "afinación" y la fase para añadir complejidad
//
(
{
	var note1, note2, la, phase;

	la = 57;
	note1 = 220;
	note2 = note1 * 3/2 +  SinOsc.ar( MouseX.kr(0,20).round.poll, phase:0, mul: MouseY.kr(0,10).poll) ;

	phase = MouseX.kr(0,2*pi);

	SinOsc.ar(
		[note1, note2],
		[0, phase]
	);
}.play;
)

////////////////////////////////////////////////////////////////////////////////
// "Arrastre" (entrainment) de ondas cerebrales
////////////////////////////////////////////////////////////////////////////////

//
// Onda simple en diente de sierra
//
(
{
	var freq;

	freq = MouseX.kr(1,100, warp: 1).round.poll;
	//SinOsc.ar(freq!2);
	Saw.ar(freq!2);

}.play;
)

//
// Barrido de filtro en frecuencias
//
(
{
	var freq;

	freq = MouseX.kr(1,100, warp: 1).round.poll;

	Resonz.ar(
		[ ClipNoise.ar(1.7), ClipNoise.ar(1.8) ],
		SinOsc.ar(freq).range(50,600),
		mul: 0.5
	);

}.play
)



////////////////////////////////////////////////////////////////////////////////
// Binaural beats
////////////////////////////////////////////////////////////////////////////////

(
{
	var freq, note;

	note = 200;
	freq = MouseX.kr(1,100, warp: 1).round.poll;
	SinOsc.ar([note, note+freq]);

}.play;
)