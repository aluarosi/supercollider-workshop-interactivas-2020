//
// Introducción a SuperCollider - Interactivas 2020
//
// NO OLVIDAR!!!!
StageLimiter.activate;

////////////////////////////////////////////////////////////////////////////////
//
// Escribir a la ventana de mensajes
//
"¡Hola, SuperCollider!".postln;

//
// Arrancar el servidor de audio (scsynth)
//
Server.local.boot;

// Otra forma:
s.boot;

// Otra forma:
//   Ctrl-B

// Otra forma:
//   Menú de aplicación

s == Server.local;

//
// Parar el servidor de audio
//
s.quit;

// Otra forma:
//   Menu de aplicación

////////////////////////////////////////////////////////////////////////////////

//
// Primeros sonidos
//

{ SinOsc.ar(440) }.play;

// Arrancar Scope + Freqscope

// Parar el sonido
//   Ctrl+.

//
// Más sonidos
//

// Estéreo
{ SinOsc.ar([440, 440]) }.play;
{ SinOsc.ar([440, 441]) }.play;

// Documentación
//    Ctrl-D sobre el código (objeto)

// Parámetros
{ SinOsc.ar(freq: [440, 660], phase: 0, mul: 0.5) }.play;

//
// Varios sonidos a la vez
//

a = { WhiteNoise.ar(mul: 0.5) }.play ;

// Qué es a? Un **sintetizador**
a;

// Abrimos árbol de nodos --> Menú de la aplicación

// Parar el sintetizador
a.free;

// Creamos varios sintes
a = { WhiteNoise.ar(mul: 0.5) }.play ;
b = { SinOsc.ar(freq: [440, 660], phase: 0, mul: 1.0) }.play;
c = { Pulse.ar(freq: [55, 55], mul: 1.0) }.play;
d = { Saw.ar(freq:880!2, mul: 0.5) }.play;
e = { BrownNoise.ar(mul: 0.5!2) }.play;
f = { Impulse.ar(freq: 100!2, mul: 1) }.play;

// Paramos uno
a.free;
b.free;

// Paramos todos
s.freeAll;

//
// Investigar más generadores de sonido en
// Docs > Tour of UGens
//

////////////////////////////////////////////////////////////////////////////////

//
// Explicación: sclang <--> scsynth
//

////////////////////////////////////////////////////////////////////////////////


