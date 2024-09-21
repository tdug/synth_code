# Synth Code

The goal of this repository is to have a collection of sounds that can be used. Mainly, targeting SuperCollider, but this repo can also be used for PureData, csound, ChucK, or others.

### SuperCollider SynthDef Base

In order to ensure quality, there will be some expectations. The following is a decent base for a stereo synth.
```sclang
SynthDef(\readme_example, { |freq=440, amp=0.5, gate=1, out=0, pan=0|
    var atk = NamedControl(\atk, 0.025, spec: ControlSpec(0.01, 0.05));   
    var dec = NamedControl(\dec, 0.15, spec: ControlSpec(0.10, 0.25));
    var sus = NamedControl(\sus, 0.75, spec: ControlSpec(0.50, 1.00));
    var dec = NamedControl(\dec, 0.25, spec: ControlSpec(0.10, 0.50));

    var env = EnvGen.kr(Env.adsr(atk, dec, sus, rel), gate: gate, doneAction: 2);
    var sig = SinOsc.ar(freq);
    sig = sig * env * amp;
    sig = Pan2.ar(sig, pan);
    Out.ar(out, sig);
}).add;
```
Take whatever creative liberties needed to make sounds though. Make sure Synths are closed properly though, and can terminate themselves.
