(
SynthDef(\slide, { |freq=440, amp=0.5, gate=1, out=0, pan=0, glide=0.25|
    var env = EnvGen.kr(Env.adsr(releaseTime: 0.25), gate: gate, doneAction: 2);

    var freq_ = Lag.kr(freq, glide);
    var detune = [0.985, 1.0, 1.015];
    var sig;
    var osc0 = LFPulse.ar(freq_).bipolar;
    var osc1 = LFTri.ar(freq_ * detune, iphase: [Rand(), Rand(), Rand()]);
    var osc2 = LFSaw.ar(freq_ * detune, iphase: [Rand(), Rand(), Rand()]);

    sig = osc0!2 + Splay.ar(osc1) + Splay.ar(osc2);
    sig = RLPF.ar(sig, 1250, 1.3);
    sig = Pan2.ar(sig, pan);
    sig = sig * env * amp;
    Out.ar(out, sig);
}).add;
)

(
t = t ?? TempoClock(80/60);
PmonoArtic(\slide,
    \dur, Pseq([
        0.25, 0.25, 0.25, 0.25, 0.5, 0.5, Rest(0.5)
    ], 2),
    \degree, Pseq([
        0,1,2,1,0,-2,\,
        -2,0,-1,-2,-3,-5,\
    ]),
    \legato, Pseq([1,1,1,1,0.8,0.8,\],2),
    \octave, 6,
    \ctranspose, 2
).play(t, quant: 4);
)