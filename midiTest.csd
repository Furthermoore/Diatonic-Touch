<CsoundSynthesizer>
<CsOptions>
-o dac -+rtmidi=null -+rtaudio=null -d -+msg_color=0 -M0 -m0
</CsOptions>
<CsInstruments>
nchnls=2
0dbfs=1
ksmps=64
sr = 44100

massign 0, 2

gkWave1 init 0
gkWave2 init 0
ga1 init 0

opcode Hipersaw2, a, kkk

gisine ftgen 0, 0, 1024, 10, 1

kamp, kcps, kdetune xin

krnd1 poscil kdetune, .1, gisine
krnd2 poscil kdetune, .2, gisine
krnd3 poscil kdetune, .3, gisine
krnd4 poscil kdetune, .4, gisine
krnd5 poscil kdetune, .5, gisine
krnd6 poscil kdetune, .6, gisine
krnd7 poscil kdetune, .7, gisine
krnd8 poscil kdetune, .8, gisine

a1  vco2 kamp, kcps, 0
a2  vco2 kamp, kcps+kdetune, 0
a3  vco2 kamp, kcps+(kdetune+krnd1)*.1, 0
a4  vco2 kamp, kcps+(kdetune+krnd2)*.1, 0
a5  vco2 kamp, kcps+(kdetune+krnd3)*.1, 0
a6  vco2 kamp, kcps+(kdetune+krnd4)*.1, 0
a7  vco2 kamp, kcps+(kdetune+krnd5)*.1, 0
a8  vco2 kamp, kcps+(kdetune+krnd6)*.1, 0
a9  vco2 kamp, kcps+(kdetune+krnd7)*.1, 0
a10 vco2 kamp, kcps+(kdetune+krnd8)*.1, 0

asum sum a1, a2, a3, a4, a5, a6, a7, a8, a9, a10

xout asum * 0.3

endop

opcode	cpsmid, i, i

imid	xin

#define MIDI2CPS(xmidi) # (440.0*exp(log(2.0)*(($xmidi)-69.0)/12.0)) #
icps	=	$MIDI2CPS(imid)

xout	icps

endop

instr 1

if p4 == 0 then ; wave1 needs updating
    gkWave1 = p5
elseif p4 == 1 then ; wave2 needs updating
    gkWave2 = p5
endif
turnoff
endin

instr 2

midinoteonkey p4, p5

; INIT PASS
iNote = p4   ; MIDI NOTE #
iFreqGuess cpsmid iNote
iAmp  = p5   ; AMPLITUDE VALUE (0 - 1)

iAttack  chnget "attack"
iDecay   chnget "decay"
iSustain chnget "sustain"
iRelease chnget "release"


; CONTROL RATE
kVolume1 chnget "volume1"
kVolume2 chnget "volume2"

kDetune1 chnget "detune1"  ; chnget opcode READS FROM iOS SOFTWARE BUS
kSemi1   chnget "semi1"
kFreq1   = cpsmidinn(iNote+kSemi1+kDetune1) ; CONVERT MIDI VALUE TO FREQUENCY REPRESENTAION IN Hz

kDetune2 chnget "detune2"
kSemi2   chnget "semi2"
kFreq2   = cpsmidinn(iNote+kSemi2+kDetune2)

kDrive1 chnget "drive1"
kDrive2 chnget "drive2"

kEnv linsegr 0, iAttack, iAmp, iDecay, iSustain, iRelease, 0

; AUDIO RATE

; OSC 1
if gkWave1 == 0 then    ; PLUCK
    aOsc1 pluck kEnv*0.1, kFreq1, iFreqGuess, 0, 1, 1, 0
elseif gkWave1 == 1 then
    aOsc1 Hipersaw2 kEnv*0.1, kFreq1, kDrive1 * 1
elseif gkWave1 == 2 then
    a1 pluck kEnv*4, kFreq1, iFreqGuess, 0, 1
    aOsc1 poscil a1*0.1, 60 + kDrive1 * kFreq1, 1
endif

; OSC 2
if gkWave2 == 0 then
    iFreqGuess cpsmid iNote
    aOsc2 pluck kEnv*0.2, kFreq2, iFreqGuess, 0,1,1,0
elseif gkWave2 == 1 then
    aOsc2 Hipersaw2 kEnv*0.1, kFreq2, kDrive2 * 8
elseif gkWave2 == 2 then
    a2 pluck kEnv*4, kFreq2, iFreqGuess, 0, 1
    aOsc2 poscil a2*0.1, 60 + kDrive2 * kFreq2, 1
endif

ga1 = ga1 + ((aOsc1*kVolume1 + aOsc2*kVolume2) * 0.5)

endin

instr 3

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

i3 0 360000
 
</CsScore>
</CsoundSynthesizer>
