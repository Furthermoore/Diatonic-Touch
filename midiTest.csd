<CsoundSynthesizer>
<CsOptions>
-o dac -+rtmidi=null -+rtaudio=null -d -+msg_color=0 -M0 -m0
</CsOptions>
<CsInstruments>
nchnls=2
0dbfs=1
ksmps=64
sr = 44100

massign 0, 1

ga1 init 0

instr 1

midinoteonkey p4, p5

; INIT PASS
iNote = p4   ; MIDI NOTE #
iAmp  = p5   ; AMPLITUDE VALUE (0 - 1)

iAttack = 0.2
iDecay = 0.2
iSustain = 0.7
iRelease = 0.3


; CONTROL RATE
kDetune1 chnget "detune1"  ; chnget opcode READS FROM iOS SOFTWARE BUS
kSemi1   chnget "semi1"
kFreq1   = cpsmidinn(iNote+kSemi1+kDetune1) ; CONVERT MIDI VALUE TO FREQUENCY REPRESENTAION IN Hz

kDetune2 chnget "detune2"
kSemi2   chnget "semi2"
kFreq2   = cpsmidinn(iNote+kSemi2+kDetune2)



k2 linsegr 0, iAttack, iAmp, iDecay, iSustain, iRelease, 0
aOsc1 vco2 k2 * 0.2, kFreq1
aOsc2 vco2 k2 * 0.2, kFreq2

ga1 = ga1 + ((aOsc1 + aOsc2) * 0.5)

endin






instr 2

kcutoff init 18000
kresonance init 0.2
;kcutoff chnget "cutoff"
;kresonance chnget "resonance"

a1 moogladder ga1, kcutoff, kresonance

aL, aR reverbsc a1, a1, .72, 5000

outs aL, aR

ga1 = 0

endin

instr allNotesOff
turnoff2 1, 0, 1
turnoff
endin

</CsInstruments>
<CsScore>
f1 0 16384 10 1

i2 0 360000
 
</CsScore>
</CsoundSynthesizer>
