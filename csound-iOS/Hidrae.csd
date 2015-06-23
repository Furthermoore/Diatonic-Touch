
Hidrae 1.0 by Giorgio Zucco
Modified 2015 for iOS - Boulanger Labs

<CsoundSynthesizer>
<CsOptions>
-odac
-dm0
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 16
0dbfs = 1
nchnls = 2

gaL init 0
gaR init 0

massign 0, 1

;turnon 2
;turnon 3
;turnon 4

; ***************************
; GLOBAL TABLES
; ***************************
gibell  ftgen 0,0,1024,9,1,1,0,1.02,.28,0,.98,.14,0,4,.22,0,7,.39,0 ;bell
gifof1  ftgen 0,0,1024,11,1
gifof2  ftgen 0,0,1024,19,0.5,0.5,270,0.5
gichord ftgen 0,0,1024,9,1,1,0,1.25,.08,0,1.49,.28,0,2,.52,0,2.52,.74,0 ; chord
giblend ftgen 0,0,1024,-19,1,0.5,270,0.5
gitemp  ftgen 40, 0, 1024, 10, .8, 1, .8, .7, .6, .5, .4, .3, 0, 0, 0, 0, 0, 0, 0, .1, 0, 0, 0, .1, .1, 0, 0, 0, 0, .05, 0, 0, 0, .05, 0, 0, 0, 0, 0, 0, 0, 0, 0, .05, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, .05, 0, 0, 0, 0, 0, 0, .5
gitemp  ftgen 41, 0, 1024, 10, 1, 1, 1, 0, 1
gitemp  ftgen 42, 0, 1024, 10, 1, 1, 0, 5, 0, 3, 0, 1
gitemp  ftgen 43, 0, 1024, 10, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1
gitemp  ftgen 44, 0, 1024, 10, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1
gitemp  ftgen 45, 0, 1024, 8, 8, 2032, 1, 32, -1, 2032, -8 ; cubic spline 1
gitemp  ftgen 46, 0, 1024, 10, 1, 0, .5, 0, 0, 0, 0, .1, 0, .1, 0, .1, 0, .1, 0, .1, 0, .05, 0, .05, 0, .05, 0, .05, 0, 0, 0, 0, 0, .1, 0, .1, 0, 0, 0, .1, 0, .1, 0, 0, 0, 0, 0, .1, 0, .1
gitemp  ftgen 47, 0, 1024, 10, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, .1, 0, 0, 0, .1, 0, 0.1
gitemp  ftgen 48, 0, 1024, 10, 1, 0, 0, 0, 0, .3, .1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, .1, 0, 0, 0, .1, 0, 0, .1
gitemp  ftgen 49, 0, 1024, 10, 1, 0, .2, .2, .03, .12, .22, .11, .022, .0101, .0167
gitemp  ftgen 200, 0, 4096, 10, 0.081672, 0.785854, 0.808302, 0.221447, 0.136644, 0.103608, 0.051154, 0.040070, 0.071067, 0.358903, 0.053101, 0.090036, 0.033729, 0.068969, 0.060398, 0.147336, 0.060769, 0.055245, 0.044695, 0.022179, 0.058528, 0.083706, 0.029581, 0.013173
gitemp  ftgen 201, 0, 4096, 10, 0.150333, 0.205756, 0.869097, 0.723941, 0.707935, 0.116871, 0.238125, 0.330962, 0.443031, 0.325212, 0.131256, 0.267361, 0.273576, 0.146568, 0.209758, 0.158564, 0.179271, 0.084668, 0.112177, 0.118845, 0.124993, 0.096945, 0.128906, 0.125534, 0.125534

; *************************************
; USER DEFINED OPCODES
; *************************************
    opcode StepLfo, k, kkkkkkkkkkkkkkkki

kamp1, kamp2, kamp3, kamp4, kamp5, kamp6, kamp7, kamp8, kcps1, kcps2, kcps3, kcps4, kcps5, kcps6, kcps7, kcps8, itype xin

k1 lfo kamp1, kcps1, itype
k2 lfo kamp2, kcps2, itype
k3 lfo kamp3, kcps3, itype
k4 lfo kamp4, kcps4, itype
k5 lfo kamp5, kcps5, itype
k6 lfo kamp6, kcps6, itype
k7 lfo kamp7, kcps7, itype
k8 lfo kamp8, kcps8, itype

klfo = k1+k2+k3+k4+k5+k6+k7+k8

xout klfo

    endop

    opcode StepLfo2, k, kki 

kratioamp, kratiocps, itype xin

kamp1 randomi 0, 2, 1
kamp2 randomi 0, 2, 1.5
kamp3 randomi 0, 2, 2
kamp4 randomi 0, 2, 2.5
kcps1 randomi 0, 0.5, 0.5
kcps2 randomi 0, 1, 1
kcps3 randomi 0, 1.5, 1.5
kcps4 randomi 0, 2, 2

k1 lfo kamp1*kratioamp, kcps1*kratiocps, itype
k2 lfo kamp2*kratioamp, kcps2*kratiocps, itype
k3 lfo kamp3*kratioamp, kcps3*kratiocps, itype
k4 lfo kamp4*kratioamp, kcps4*kratiocps, itype

klfo = k1+k2+k3+k4

xout klfo

    endop

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

    opcode multivco2, a, kkkk

gisine ftgen 0, 0, 1024, 10, 1

kamp, kcps, kdetune, kpw xin

krnd1 poscil kdetune, .1, gisine
krnd2 poscil kdetune, .2, gisine
krnd3 poscil kdetune, .3, gisine
krnd4 poscil kdetune, .4, gisine
krnd5 poscil kdetune, .5, gisine
krnd6 poscil kdetune, .6, gisine
krnd7 poscil kdetune, .7, gisine
krnd8 poscil kdetune, .8, gisine

a1  vco2 kamp, kcps, 10, kpw
a2  vco2 kamp, kcps+kdetune, 10, kpw
a3  vco2 kamp, kcps+(kdetune+krnd1)*.1, 10, kpw
a4  vco2 kamp, kcps+(kdetune+krnd2)*.1, 10, kpw
a5  vco2 kamp, kcps+(kdetune+krnd3)*.1, 10, kpw
a6  vco2 kamp, kcps+(kdetune+krnd4)*.1, 10, kpw
a7  vco2 kamp, kcps+(kdetune+krnd5)*.1, 10, kpw
a8  vco2 kamp, kcps+(kdetune+krnd6)*.1, 10, kpw
a9  vco2 kamp, kcps+(kdetune+krnd7)*.1, 10, kpw
a10 vco2 kamp, kcps+(kdetune+krnd8)*.1, 10, kpw

asum sum a1, a2, a3, a4, a5, a6, a7, a8, a9, a10

xout asum * 0.3

    endop

    opcode multivco3, a, kkkk

gisine ftgen 0, 0, 1024, 10, 1

kamp, kcps, kdetune, kpw xin

krnd1 poscil kdetune, 0.1, gisine
krnd2 poscil kdetune, 0.2, gisine
krnd3 poscil kdetune, 0.3, gisine
krnd4 poscil kdetune, 0.4, gisine
krnd5 poscil kdetune, 0.5, gisine
krnd6 poscil kdetune, 0.6, gisine
krnd7 poscil kdetune, 0.7, gisine
krnd8 poscil kdetune, 0.8, gisine

a1  vco2 kamp, kcps, 12, kpw
a2  vco2 kamp, kcps+kdetune, 12, kpw
a3  vco2 kamp, kcps+(kdetune+krnd1)*.1, 12, kpw
a4  vco2 kamp, kcps+(kdetune+krnd2)*.1, 12, kpw
a5  vco2 kamp, kcps+(kdetune+krnd3)*.1, 12, kpw
a6  vco2 kamp, kcps+(kdetune+krnd4)*.1, 12, kpw
a7  vco2 kamp, kcps+(kdetune+krnd5)*.1, 12, kpw
a8  vco2 kamp, kcps+(kdetune+krnd6)*.1, 12, kpw
a9  vco2 kamp, kcps+(kdetune+krnd7)*.1, 12, kpw
a10 vco2 kamp, kcps+(kdetune+krnd8)*.1, 12, kpw

asum sum a1, a2, a3, a4, a5, a6, a7, a8, a9, a10

xout asum * 0.3

    endop

    opcode polyosc1, a, kkkii 

gisine ftgen 0, 0, 1024, 10, 1

kamp, kcps, kdetune, ifunc1, ifunc2 xin

krnd1 poscil kdetune, 0.1, gisine
krnd2 poscil kdetune, 0.2, gisine
krnd3 poscil kdetune, 0.3, gisine
krnd4 poscil kdetune, 0.4, gisine
krnd5 poscil kdetune, 0.5, gisine
krnd6 poscil kdetune, 0.6, gisine
krnd7 poscil kdetune, 0.7, gisine
krnd8 poscil kdetune, 0.8, gisine

a1  poscil kamp, kcps, ifunc1
a2  poscil kamp, kcps+kdetune, ifunc2
a3  poscil kamp, kcps+(kdetune+krnd1)*.1, ifunc1
a4  poscil kamp, kcps+(kdetune+krnd2)*.1, ifunc2
a5  poscil kamp, kcps+(kdetune+krnd3)*.1, ifunc1
a6  poscil kamp, kcps+(kdetune+krnd4)*.1, ifunc2
a7  poscil kamp, kcps+(kdetune+krnd5)*.1, ifunc1
a8  poscil kamp, kcps+(kdetune+krnd6)*.1, ifunc2
a9  poscil kamp, kcps+(kdetune+krnd7)*.1, ifunc1
a10 poscil kamp, kcps+(kdetune+krnd8)*.1, ifunc2

asum sum a1, a2, a3, a4, a5, a6, a7, a8, a9, a10

xout asum * 0.3

    endop

    opcode Stereo_chorus, aa, aakk

a1, a2, kdepth, krate xin

k1    randomi 0.01, kdepth, krate
adel1 vdelay  a1, k1, 1000

k2    randomi 0.01, kdepth*0.1, krate*0.1
adel2 vdelay  a2, k2, 1000

k3    randomi 0.01, kdepth*0.2, krate*0.2
adel3 vdelay  a1, k3, 1000

k4    randomi 0.01, kdepth*0.3, krate*0.3
adel4 vdelay  a2, k4, 1000

k5    randomi 0.01, kdepth*0.4, krate*0.4
adel5 vdelay  a1, k5, 1000

k6    randomi 0.01, kdepth*0.5, krate*0.5
adel6 vdelay  a2, k6, 1000

k7    randomi 0.01, kdepth*0.6, krate*0.6
adel7 vdelay  a1, k7, 1000

k8    randomi 0.01, kdepth*0.7, krate*0.7
adel8 vdelay  a2, k8, 1000

aout1 = (adel1+adel2+adel3+adel4)
aout2 = (adel5+adel6+adel7+adel8)

xout aout1, aout2

    endop

    opcode Phaser2x, aa, aakk

asig1, asig2, krate, kfreq xin

kPhQ = 0.5 ; (range 0.25 - 4)

klfo lfo 0.5, krate
kmod =   kfreq*(1+klfo) ; range 200 - 8000
istages = 5 ; range 1 - 16

aphs1 phaser2 asig1, kmod, kPhQ, istages, 2, 1, 0.4
aphs2 phaser2 asig2, kmod, kPhQ, istages, 2, 1, 0.4

xout aphs1, aphs2

    endop

    opcode StChorus, aa, aakkkk

asigr, asigl, kdepth, kdepthl, krate, kratel  xin

k1ch randi  kdepth/2, krate, 1
ar1  vdelay asigr, kdepth/2+k1ch, 10
k2ch randi  kdepth/2, krate*0.9, 0.2
ar2  vdelay asigr, kdepth/2+k2ch, 10
k3ch randi  kdepth/2, krate*1.1, 0.2
ar3  vdelay asigr, kdepth/2+k3ch, 10
k4ch randi  kdepth/2, krate*1.3, 0.1
ar4  vdelay asigr, kdepth/2+k4ch, 10

k1chl randi  kdepthl/2, kratel, 1
ar1l  vdelay asigl, kdepthl/2+k1chl, 10
k2chl randi  kdepthl/2, kratel*0.9, 0.2
ar2l  vdelay asigl, kdepthl/2+k2chl, 10
k3chl randi  kdepthl/2, krate*1.1, 0.2
ar3l  vdelay asigl, kdepthl/2+k3chl, 10
k4chl randi  kdepthl/2, krate*1.3, 0.1
ar4l  vdelay asigl, kdepthl/2+k4chl, 10

aL = (ar1+ar2+ar3+ar4)/2
aR = (ar1l+ar2l+ar3l+ar4l)/2

xout aL, aR

    endop


    opcode VintageEcho, aa, aiik 

asig, ilevl, iecho, kfilter xin

idelay = 1

afdbk init 0
ifdbk = 0.5
asig  = asig + afdbk*ifdbk
atemp delayr 1 ; create 1 second delay
atap1 deltap 0.0396*idelay 
atap2 deltap 0.0662*idelay
atap3 deltap 0.1194*idelay
atap4 deltap 0.1726*idelay
atap5 deltap 0.2790*idelay
atap6 deltap 0.3328*idelay
delayw asig
afdbk butterlp atap6, kfilter ; LOWPASS filter feedback
abbd1 sum atap1, atap2, atap3 ; sum taps
abbd2 sum atap4, atap5, atap6 ; sum taps
abbd3 butterlp abbd1, kfilter ; LOWPASS filter output
abbd4 butterlp abbd2, kfilter ; LOWPASS filter output

afxecho1 = (((abbd3*iecho) * 0.3) * ilevl)
afxecho2 = (((abbd4*iecho) * 0.3) * ilevl)
kfadecho linsegr 1, 0.01, 1, 0.33*idelay*(1+ifdbk)*(1+iecho), 0
afxL = afxecho1*kfadecho
afxR = afxecho2*kfadecho

xout afxL, afxR 

    endop

; *********************************
; INSTRUMENT SECTION
; *********************************

    instr 1 ; POLYSYNTH

midinoteonkey p4, p5 
inotenum = p4
iamp = p5 * 0.3 ; TODO velocity input from keyboard

; OSC 1 PITCH
kdetune init 0
ksemi   init 0
;kdetune chnget "detune"
;ksemi   chnget "semi"
kfreq   = cpsmidinn(inotenum+ksemi)
kdet    = cpsmidinn(inotenum+ksemi+kdetune)

; OSC 2 PITCH
kdetune2 init 0
ksemi2   init 0
;kdetune2 chnget "detune2"
;ksemi2   chnget "semi2"
kfreq2   = cpsmidinn(inotenum+ksemi2)
kdet2    = cpsmidinn(inotenum+ksemi2+kdetune2)

; AMPLITUDE ENVELOPE
iatt = 0.02
idec = 0.02
isus = p5 * 0.75
irel = 0.0
;iatt chnget "attack"
;idec chnget "decay"
;isus chnget "sustain"
;irel chnget "release"
kadsr linsegr 0, iatt, 1, idec, isus, irel, 0

; OSC 1 DRIVE 
kmod init 0
;kmod chnget "drive"
kdrive portk kmod, 0.01

; OSC 2 DRIVE
kmod2 init 0
;kmod2 chnget "drive2"
kdrive2 portk kmod2, 0.01

; OSC 1 & 2 SOURCE
kselect  init 0
kselect2 init 0
;kselect chnget "waves"
;kselect2 chnget "waves2"

; LFO
klefosel init 0
kamplfo init 0
kcpslfo init 0
;klefosel chnget "lfosel"
;kamplfo chnget "amplfo"
;kcpslfo chnget "cpslfo"

; SUB OSC
kselsub init 0
klevelsubx init 0
klevelsub init 0
;kselsub chnget "sub"
;klevelsubx chnget "levelsub"
;klevelsub portk klevelsubx, 0.01


if klefosel == 0 then
    klfo = 1
elseif klefosel == 1 then
    klfo lfo kamplfo, kcpslfo
elseif klefosel == 2 then
    klfo vibr kamplfo, kcpslfo, 1
elseif klefosel == 3 then
    klfo jitter kamplfo, 0, kcpslfo
elseif klefosel == 4 then
    klfo StepLfo kamplfo*0.1, kamplfo*0.2, kamplfo*0.3, kamplfo*0.4, kamplfo*0.5, kamplfo*0.6, kamplfo*0.7, kamplfo*0.8, kcpslfo*.1, kcpslfo*0.2, kcpslfo*0.3, kcpslfo*0.4, kcpslfo*0.5, kcpslfo*0.6, kcpslfo*0.7, kcpslfo*0.8, 2
; TABLE BASED
elseif klefosel == 5 then
    klfo poscil kamplfo, kcpslfo, 2
elseif klefosel == 6 then
    klfo poscil kamplfo, kcpslfo, 4
elseif klefosel == 7 then
    klfo poscil kamplfo, kcpslfo, 5
elseif klefosel == 8 then
    klfo poscil kamplfo, kcpslfo, 45
elseif klefosel == 9 then
    klfo poscil kamplfo, kcpslfo, 6
elseif klefosel == 10 then
    klfo poscil kamplfo, kcpslfo, 18
elseif klefosel == 11 then
    klfo poscil kamplfo, kcpslfo, 19
elseif klefosel == 12 then
    klfo poscil kamplfo, kcpslfo, 22
elseif klefosel == 13 then
    klfo StepLfo2 kamplfo, kcpslfo, 1
endif

if kselect == 0 then  ; GUITAR
    a1 pluck iamp, (kdet+klfo), 1000, 0,1,1,0
    a2 pluck iamp, (kfreq+klfo), 1000, 0,1,1,0
    aout1 pdclip a1, kdrive, 0, 1
    aout2 pdclip a2, kdrive, 0, 1
    aout1 = aout1 * 2
    aout2 = aout2 * 2
elseif kselect == 1 then
    a1 pluck iamp*4,(kdet+klfo),1000,0,1
    a2 pluck iamp*4, (kfreq+klfo), 1000,0,1
    aout1 poscil a1, 60+kdrive*kfreq+1, 1
    aout2 poscil a2, 60+kdrive*kdet+1, 1
elseif kselect == 2 then ; HIPERSAW
    a1 Hipersaw2 iamp, (kfreq+klfo),kdrive*8
    a2 Hipersaw2 iamp, (kdet+klfo), (1-kdrive*8)
    aout1 = a1
    aout2 = a2
elseif kselect == 3 then ; WAVESHAPE
    a1 poscil iamp, (kfreq+klfo), 1
    a2 poscil iamp, (kdet+klfo), 1
    aout1 pdclip a1, kdrive, 0, 1
    aout2 pdclip a2, kdrive, 0, 1
elseif kselect == 4 then ; FM
    amod poscil kdrive*5000, kdet, 1
    aout1 poscil iamp, (kfreq+klfo)+amod, 1
    aout2 poscil iamp, (kdet+klfo)+amod, 1
elseif kselect == 5 then ; ALGO
    kmelody1 randomh 60, kdet, kdrive*20
    kmelody2 randomh 60, kfreq, kdrive*20
    aout1 poscil iamp, (kmelody1+klfo), gibell
    aout2 poscil iamp, (kmelody2+klfo), gibell
elseif kselect == 6 then ; ADDITIVE
    a1 buzz iamp, (kdet+klfo), abs(kdrive*100), 1
    a2 buzz iamp, (kfreq+klfo), abs(kdrive*100), 1
    aout1 = (a1 * (abs(kdrive*100) / 75 + 1)) * 2
    aout2 = (a2 * (abs(kdrive*100) / 75 + 1)) * 2
elseif kselect == 7 then
    a1 poscil iamp, (kdet+klfo), 2
    a2 poscil iamp, (kfreq+klfo), 2
    aout1 pdclip a1, kdrive, 0, 1
    aout2 pdclip a2, kdrive, 0, 1
elseif kselect == 8 then
    a1 poscil iamp, (kdet+klfo), 5
    a2 poscil iamp, (kfreq+klfo), 5
    aout1 pdclip a1, kdrive, 0, 1
    aout2 pdclip a2, kdrive, 0, 1
elseif kselect == 9 then
    a1 poscil iamp, (kdet+klfo), 6
    a2 poscil iamp, (kfreq+klfo), 6
    aout1 pdclip a1, kdrive, 0, 1
    aout2 pdclip a2, kdrive, 0, 1
elseif kselect == 10 then ; BUZZ
    a1 poscil iamp, (kdet+klfo), 16
    a2 poscil iamp, (kfreq+klfo), 16
    aout1 fofilter a1, kdrive*1000, 0.007, 0.03
    aout2 fofilter a2, kdrive*1000, 0.007, 0.03
elseif kselect == 11 then ; SID
    a1 poscil iamp, (kdet+klfo), 4
    a2 poscil iamp, (kfreq+klfo), 5
    kvalues pow 2, ((0.9-kdrive*0.9)*15)+1
    k16bit pow 2, 16
    aout1 = (int((a1*32768*kvalues)/k16bit)/32768)*(k16bit/kvalues)
    aout2 = (int((a2*32768*kvalues)/k16bit)/32768)*(k16bit/kvalues)
elseif kselect == 12 then
    kform1 = kdrive*2000
    kbn1 = 100
    kfund1 = (kdet+klfo)
    kfund2 = (kfreq+klfo)
    koct = 0
    kris = 0.003
    kdur = 0.02
    kdec = 0.007
    iolaps = 1000
    ifna = gifof1 ; FUNZIONE SINUSOID
    ifnb = gifof2 ; FUNZOINE ATTACK, DECAY
    idur = 36000
    kphs = 0 ; NO PHASE MODULATION
    kgliss randomi 0, 0.9, 2
    a1 fof2 iamp, kfund1*0.5, kform1, koct, kbn1, kris, kdur, kdec, iolaps, ifna, ifnb, idur, kphs, kgliss
    a2 fof2 iamp, kfund2*0.5, kform1, koct, kbn1, kris, kdur, kdec, iolaps, ifna, ifnb, idur, kphs, kgliss
    aout1 = a1
    aout2 = a2
elseif kselect == 13 then
    a1 poscil iamp, (kdet+klfo), 2
    a2 poscil iamp, (kfreq+klfo)*abs(1+kdrive), 5
    aout1 = a1
    aout2 = a2
elseif kselect == 14 then
    a1 poscil iamp, (kdet+klfo), 40
    a2 poscil iamp, (kfreq+klfo)*abs(1+kdrive), 40
    aout1 = a1
    aout2 = a2
elseif kselect == 15 then
    a1 poscil iamp, (kdet+klfo), 46
    a2 poscil iamp, (kfreq+klfo)*abs(1+kdrive), 46
    aout1 = a1
    aout2 = a2
elseif kselect == 16 then
    a1 poscil iamp, (kdet+klfo), 47
    a2 poscil iamp, (kfreq+klfo)*abs(1+kdrive), 47
    aout1 = a1
    aout2 = a2
elseif kselect == 17 then
    a1 poscil iamp, (kdet+klfo), 48
    a2 poscil iamp, (kfreq+klfo)*abs(1+kdrive), 48
    aout1 = a1
    aout2 = a2
elseif kselect == 18 then
    a1 poscil iamp, (kdet+klfo), 49
    a2 poscil iamp, (kfreq+klfo)*abs(1+kdrive), 49
    aout1 = a1
    aout2 = a2
elseif kselect == 19 then
    a1 vco2 iamp, (kfreq+klfo), 2, 0.01+kdrive
    a2 vco2 iamp, (kdet+klfo), 2, 0.01+kdrive
    aout1 = a1
    aout2 = a2
elseif kselect == 20 then
    a1 poscil iamp, (kdet+klfo), 47
    a2 poscil iamp, (kfreq+klfo), 49
    aout1 = a1
    aout2 = a2
elseif kselect == 21 then
    a1 multivco2 iamp, (kfreq+klfo), kdrive*8, kdrive
    a2 multivco2 iamp, (kdet+klfo), (1-kdrive*8), kdrive
    aout1 = a1
    aout2 = a2
elseif kselect == 22 then
    a1 poscil iamp, (kdet+klfo), 200
    a2 poscil iamp, (kfreq+klfo), 200
    aout1 pdclip a1, kdrive, 0, 1
    aout2 pdclip a2, kdrive, 0, 1
elseif kselect == 23 then
    a1 poscil iamp, (kdet+klfo), 201
    a2 poscil iamp, (kfreq+klfo), 201
    aout1 pdclip a1, kdrive, 0, 1
    aout2 pdclip a2, kdrive, 0, 1
elseif kselect == 24 then
    a1 vco2 iamp, (kfreq+klfo),4,0.01+kdrive
    a2 vco2 iamp, (kdet+klfo),4,0.01+kdrive
    aout1 = a1
    aout2 = a2
elseif kselect == 25 then
    a1 polyosc1 iamp, (kfreq+klfo), kdrive*12, 46, 47
    a2 polyosc1 iamp, (kdet+klfo), 1-kdrive*12, 46, 47
    aout1 = a1
    aout2 = a2
elseif kselect == 26 then
    a1 polyosc1 iamp, (kfreq+klfo), kdrive*12, 48, 49
    a2 polyosc1 iamp, (kdet+klfo), 1-kdrive*12, 48, 49
    aout1 = a1
    aout2 = a2
elseif kselect == 27 then
    a1 polyosc1 iamp, (kfreq+klfo), kdrive*12, 40, 41
    a2 polyosc1 iamp, (kdet+klfo), 1-kdrive*12, 42, 43
    aout1 = a1
    aout2 = a2
elseif kselect = 28 then ; WAVETERRAIN
    a1 wterrain iamp, (kfreq+klfo), 0.1+kdrive, 0.1+kdrive, 0.1+-kdrive, 1-kdrive, 1, 5
    a2 wterrain iamp, (kdet+klfo), 0.1+kdrive, 0.1+kdrive, 0.1+-kdrive, 1-kdrive, 1, 5
    aout1 = a1*2
    aout2 = a2*2

elseif kselect == 29 then
    a1 wterrain iamp, (kfreq+klfo), .1+kdrive, .1+kdrive, .1+-kdrive, .1+kdrive, gibell, gifof1
    a2 wterrain iamp, (kdet+klfo), .1+kdrive, .1+kdrive, .1+-kdrive, .1+kdrive, gibell, gifof1
    aout1 = a1*2
    aout2 = a2*2
elseif kselect == 30 then
    a1 wterrain iamp, (kfreq+klfo), .1+kdrive, .1+kdrive, .1+-kdrive, .1+kdrive, 3, 40
    a2 wterrain iamp, (kdet+kfreq), .1+kdrive, .1+kdrive, .1+-kdrive, .1+kdrive, 3, 40
    aout1 = a1*2
    aout2 = a2*2
elseif kselect == 31 then
    k1 randomi 0.1, kdrive-.1, 2
    k2 randomi 0.1, kdrive-.1, 2
    a1 wterrain iamp, (kfreq+klfo), k1, k2, -k1, k2, 3, 40
    a2 wterrain iamp, (kdet+klfo), k1, k2, -k1, k2, 3, 40
    aout1 = a1*2
    aout2 = a2*2
elseif kselect == 32 then ; SIMPLE SINE
    aout1 poscil iamp, (kfreq+klfo), 1
    aout2 poscil iamp, (kdet+klfo), 1
elseif kselect == 33 then
    a1 poscil iamp, (kfreq+klfo), 23
    a2 poscil iamp, (kdet+klfo), 23
    aout1 pdclip a1, kdrive, 0, 1
    aout2 pdclip a2, kdrive, 0, 1
elseif kselect == 34 then
    a1 poscil iamp, (kfreq+klfo), 24
    a2 poscil iamp, (kdet+klfo), 24
    aout1 pdclip a1, kdrive, 0, 1
    aout2 pdclip a2, kdrive, 0, 1
elseif kselect == 35 then
    a1 poscil iamp, (kfreq+klfo), 25
    a2 poscil iamp, (kdet+klfo), 25
    aout1 pdclip a1, kdrive, 0, 1
    aout2 pdclip a2, kdrive, 0, 1
elseif kselect == 36 then
    a1 poscil iamp, (kfreq+klfo), 26
    a2 poscil iamp, (kdet+klfo), 26
    aout1 pdclip a1, kdrive, 0, 1
    aout2 pdclip a2, kdrive, 0, 1
elseif kselect == 37 then
    a1 poscil iamp, (kfreq+klfo), 27
    a2 poscil iamp, (kdet+klfo), 27
    aout1 pdclip a1, kdrive, 0, 1
    aout2 pdclip a2, kdrive, 0, 1
elseif kselect == 38 then
    a1 poscil iamp, (kfreq+klfo), 28
    a2 poscil iamp, (kdet+klfo), 28
    aout1 pdclip a1, kdrive, 0, 1
    aout2 pdclip a2, kdrive, 0, 1
elseif kselect == 39 then
    a1 poscil iamp, (kfreq+klfo), 29
    a2 poscil iamp, (kdet+klfo), 29
    aout1 pdclip a1, kdrive, 0, 1
    aout2 pdclip a2, kdrive, 0, 1
elseif kselect == 40 then
    a1 poscil iamp, (kfreq+klfo), 30
    a2 poscil iamp, (kdet+klfo), 30
    aout1 pdclip a1, kdrive, 0, 1
    aout2 pdclip a2, kdrive, 0, 1
endif

; SUB OSC

if kselsub == 0 then
    asub1 poscil iamp, (kfreq*.5+klfo), 1
    asub2 poscil iamp, (kdet*.5+klfo), 1
elseif kselsub == 1 then
    asub1 poscil iamp, (kfreq*.5+klfo), 2
    asub2 poscil iamp, (kdet*.5+klfo), 2
elseif kselsub == 2 then
    asub1 poscil iamp, (kfreq*.5+klfo), 3
    asub2 poscil iamp, (kdet*.5+klfo), 3
elseif kselsub == 3 then
    asub1 poscil iamp, (kfreq*.5+klfo), 4
    asub2 poscil iamp, (kdet*.5+klfo), 4
elseif kselsub == 4 then
    asub1 poscil iamp, (kfreq*.5+klfo), 5
    asub2 poscil iamp, (kdet*.5+klfo), 5
elseif kselsub == 5 then
    asub1 poscil iamp, (kfreq*.5+klfo), 6
    asub2 poscil iamp, (kdet*.5+klfo), 6
elseif kselsub == 6 then
    asub1 poscil iamp, (kfreq*.5+klfo), 18
    asub2 poscil iamp, (kdet*.5+klfo), 18
elseif kselsub == 7 then
    asub1 poscil iamp, (kfreq*.5+klfo), 19
    asub2 poscil iamp, (kdet*.5+klfo), 19
endif

asum1 = aout1+asub1*klevelsub
asum2 = aout2+asub2*klevelsub


; OSC 2

; guitar
if kselect2 == 0 then
    a1b pluck iamp, (kdet2+klfo), 1000, 0,1,1,0
    a2b pluck iamp, (kfreq2+klfo), 1000, 0,1,1,0
    aout1b pdclip a1b, kdrive2,0,1
    aout2b pdclip a2b, kdrive2,0,1
    aout1b = aout1b * 2
    aout2b = aout2b * 2
elseif kselect2 == 1 then
    a1b pluck iamp*4, (kdet2+klfo),1000,0,1
    a2b pluck iamp*4, (kfreq2+klfo),1000,0,1
    aout1b poscil a1b, 60+kdrive2*kfreq2+1,1
    aout2b poscil a2b, 60+kdrive2*kdet2+1, 1
elseif kselect2 == 2 then ; HYPERSAW
    a1b Hipersaw2 iamp,(kfreq2+klfo),kdrive2*8
    a2b Hipersaw2 iamp,(kdet2+klfo), 1-kdrive2*8
    aout1b = a1b
    aout2b = a2b
elseif kselect2 == 3 then ; WAVESHAPE
    a1b poscil iamp, (kfreq2+klfo), 1
    a2b poscil iamp, (kdet2+klfo), 1
    aout1b pdclip a1b, kdrive2, 0, 1
    aout2b pdclip a2b, kdrive2, 0, 1
elseif kselect2 == 4 then ; FM
    amod2 poscil kdrive2*5000, kdet2, 1
    aout1b poscil iamp, (kfreq2+klfo) + amod2, 1
    aout2b poscil iamp, (kdet2+klfo) + amod2, 1
elseif kselect2 == 5 then ; ALGO
    kmelody1b randomh 60, kdet2, kdrive2*20
    kmelody2b randomh 60, kfreq2, kdrive2*20
    aout1b poscil iamp, (kmelody1b+klfo), gibell
    aout2b poscil iamp, (kmelody2b+klfo), gibell
elseif kselect2 == 6 then ; ADDITIVE
    a1b buzz iamp, (kdet2+klfo), abs(kdrive2*100), 1
    a2b buzz iamp, (kfreq2+klfo), abs(kdrive2*100), 1
    aout1b = (a1b * (abs(kdrive2*100) /75 + 1)) * 2
    aout2b = (a2b * (abs(kdrive2*100) /75 + 1)) * 2
elseif kselect2 == 7 then
    ab1 poscil iamp, (kdet2+klfo), 2
    ab2 poscil iamp, (kfreq2+klfo), 2
    aout1b pdclip a1b, kdrive2, 0, 1
    aout2b pdclip a2b, kdrive2, 0, 1
elseif kselect2 == 8 then
    ab1 poscil iamp, (kdet2+klfo), 5
    ab2 poscil iamp, (kfreq2+klfo), 5
    aout1b pdclip a1b, kdrive2, 0, 1
    aout2b pdclip a2b, kdrive2, 0, 1
elseif kselect2 == 9 then
    ab1 poscil iamp, (kdet2+klfo), 6
    ab2 poscil iamp, (kfreq2+klfo), 6
    aout1b pdclip a1b, kdrive2, 0, 1
    aout2b pdclip a2b, kdrive2, 0, 1
elseif kselect2 == 10 then ; BUZZ
    ab1 poscil iamp, (kdet2+klfo), 16
    ab2 poscil iamp, (kfreq2+klfo), 16
    aout1b fofilter a1b, kdrive2*1000,0.007,0.03
    aout2b fofilter a2b, kdrive2*1000,0.007,0.03
elseif kselect2 == 11 then ; SID
    ab1 poscil iamp, (kdet2+klfo), 4
    ab2 poscil iamp, (kfreq2+klfo), 5
    kvalues pow 2, ((0.9-kdrive2*.9)*15)+1
    k16bit pow 2, 16
    aout1b = (int((a1b*32768*kvalues)/k16bit)/32768)*(k16bit/kvalues)
    aout2b = (int((a2b*32768*kvalues)/k16bit)/32768)*(k16bit/kvalues)
elseif kselect2 == 12 then ; FORMANT
    kbn1b = 100
    koctb = 0
    krisb = 0.003
    kdurb = 0.02
    kdecb = 0.007
    iolapsb = 1000
    ifnab = gifof1
    ifnbb = gifof2
    idurb = 36000
    kphsb = 0
    kglissb randomi 0,.9,2
    kform2 = kdrive2*2000
    kfund1b = (kdet2+klfo)
    kfund2b = (kfreq2+klfo)
    a1b fof2 iamp, kfund1b*.5, kform2, koctb, kbn1b, krisb, kdurb, kdecb, iolapsb, ifnab, ifnbb, idurb, kphsb, kglissb
    a2b fof2 iamp, kfund2b*.5, kform2, koctb, kbn1b, krisb, kdurb, kdecb, iolapsb, ifnab, ifnbb, idurb, kphsb, kglissb
    aout1b = a1b
    aout2b = a2b
elseif kselect2 == 13 then
    a1b poscil iamp, (kdet2+klfo), 2
    a2b poscil iamp, (kfreq2+klfo)*abs(1+kdrive2), 5
    aout1b = a1b
    aout2b = a2b
elseif kselect2 == 14 then
    a1b poscil iamp, (kdet2+klfo), 40
    a2b poscil iamp, (kfreq2+klfo)*abs(1+kdrive2), 40
    aout1b = a1b
    aout2b = a2b
elseif kselect2 == 15 then
    a1b poscil iamp, (kdet2+klfo), 46
    a2b poscil iamp, (kfreq2+klfo)*abs(1+kdrive2), 46
    aout1b = a1b
    aout2b = a2b
elseif kselect2 == 16 then
    a1b poscil iamp, (kdet2+klfo), 17
    a2b poscil iamp, (kfreq2+klfo)*abs(1+kdrive2), 17
    aout1b = a1b
    aout2b = a2b
elseif kselect2 == 17 then
    a1b poscil iamp, (kdet2+klfo), 48
    a2b poscil iamp, (kfreq2+klfo)*abs(1+kdrive2), 48
    aout1b = a1b
    aout2b = a2b
elseif kselect2 == 18 then
    a1b poscil iamp, (kdet2+klfo), 49
    a2b poscil iamp, (kfreq2+klfo)*abs(1+kdrive2), 49
    aout1b = a1b
    aout2b = a2b
elseif kselect2 == 19 then
    a1ba vco2 iamp, (kfreq2+klfo), 2, 0.01+kdrive
    a2ba vco2 iamp, (kdet2+klfo), 2, 0.01+kdrive
    aout1b = a1ba
    aout2b = a2ba
elseif kselect2 == 20 then
    a1b poscil iamp, (kdet2+klfo), 49
    a2b poscil iamp, (kfreq2+klfo)*abs(1+kdrive2), 49
    aout1b = a1b
    aout2b = a2b
elseif kselect2 == 21 then
    a1b multivco2 iamp, (kfreq2+klfo), kdrive2*8, kdrive2
    a2b multivco2 iamp, (kfreq2+klfo), kdrive2*8, kdrive2
    aout1b = a1b
    aout2b = a2b
elseif kselect2 == 22 then
    a1b poscil iamp, (kdet2+klfo), 200
    a2b poscil iamp, (kfreq2+klfo), 200
    aout1b pdclip a1b, kdrive2, 0, 1
    aout2b pdclip a2b, kdrive, 0, 1
elseif kselect2 == 23 then
    a1b poscil iamp, (kdet2+klfo), 201
    a2b poscil iamp, (kfreq2+klfo), 201
    aout1b pdclip a1b, kdrive2, 0, 1
    aout2b pdclip a2b, kdrive, 0, 1
elseif kselect2 == 24 then
    a1bb vco2 iamp, (kfreq2+klfo), 4, 0.01+kdrive2
    a2bb vco2 iamp, (kdet2+klfo), 4, 0.01+kdrive2
    aout1b = a1bb
    aout2b = a2bb
elseif kselect2 == 25 then
    a1b polyosc1 iamp, (kfreq2+klfo), kdrive2*12, 46, 47
    a2b polyosc1 iamp, (kdet2+klfo), 1-kdrive*12, 46, 47
    aout1b = a1b
    aout2b = a2b
elseif kselect2 == 26 then
    a1b polyosc1 iamp, (kfreq2+klfo), kdrive2*12, 48, 49
    a2b polyosc1 iamp, (kdet2+klfo), 1-kdrive*12, 48, 49
    aout1b = a1b
    aout2b = a2b
elseif kselect2 == 27 then
    a1b polyosc1 iamp, (kfreq2+klfo), kdrive2*12, 40, 41
    a2b polyosc1 iamp, (kdet2+klfo), 1-kdrive*12, 42, 43
    aout1b = a1b
    aout2b = a2b
elseif kselect2 == 28 then ; WAVE TERRAIN
    a1b wterrain iamp, (kfreq2+klfo), kdrive2, kdrive2, -kdrive2, 1-kdrive2, 1, 5
    a2b wterrain iamp, (kdet2+klfo), kdrive2, kdrive2, -kdrive2, 1-kdrive2, 1, 5
    aout1b = a1b*2
    aout2b = a2b*2
elseif kselect2 == 29 then
    a1b wterrain iamp, (kfreq2+klfo), kdrive2, kdrive2, -kdrive2, kdrive2, gibell, gifof1
    a2b wterrain iamp, (kdet2+klfo), kdrive2, kdrive2, -kdrive2, kdrive2, gibell, gifof1
    aout1b = a1b*2
    aout2b = a2b*2
elseif kselect2 == 30 then
    a1b wterrain iamp, (kfreq2+klfo), kdrive2, kdrive2, -kdrive2, kdrive2, 3, 40
    a2b wterrain iamp, (kdet2+klfo), kdrive2, kdrive2, -kdrive2, kdrive2, 3, 40
    aout1b = a1b*2
    aout2b = a2b*2
elseif kselect2 == 31 then
    k1b randomi 0.1, kdrive-.1,2
    k2b randomi 0.1, kdrive-.1,2
    a1b wterrain iamp, (kfreq2+klfo), k1b, k2b, -k1b, k2b, 3, 40
    a2b wterrain iamp, (kdet2+klfo), k1b, k2b, -k1b, k2b, 3, 40
    aout1b = a1b*2
    aout2b = a2b*2
elseif kselect2 == 32 then
    aout1b poscil iamp, (kfreq2+klfo),1
    aout2b poscil iamp, (kdet2+klfo),1
elseif kselect2 == 33 then
    a1b poscil iamp, (kdet2+klfo), 23
    a2b poscil iamp, (kfreq2+klfo), 23
    aout1b pdclip a1b, kdrive2, 0, 1
    aout2b pdclip a2b, kdrive, 0, 1
elseif kselect2 == 34 then
    a1b poscil iamp, (kdet2+klfo), 24
    a2b poscil iamp, (kfreq2+klfo), 24
    aout1b pdclip a1b, kdrive2, 0, 1
    aout2b pdclip a2b, kdrive, 0, 1
elseif kselect2 == 35 then
    a1b poscil iamp, (kdet2+klfo), 25
    a2b poscil iamp, (kfreq2+klfo), 25
    aout1b pdclip a1b, kdrive2, 0, 1
    aout2b pdclip a2b, kdrive, 0, 1
elseif kselect2 == 36 then
    a1b poscil iamp, (kdet2+klfo), 26
    a2b poscil iamp, (kfreq2+klfo), 26
    aout1b pdclip a1b, kdrive2, 0, 1
    aout2b pdclip a2b, kdrive, 0, 1
elseif kselect2 == 37 then
    a1b poscil iamp, (kdet2+klfo), 27
    a2b poscil iamp, (kfreq2+klfo), 27
    aout1b pdclip a1b, kdrive2, 0, 1
    aout2b pdclip a2b, kdrive, 0, 1
elseif kselect2 == 38 then
    a1b poscil iamp, (kdet2+klfo), 28
    a2b poscil iamp, (kfreq2+klfo), 28
    aout1b pdclip a1b, kdrive2, 0, 1
    aout2b pdclip a2b, kdrive, 0, 1
elseif kselect2 == 39 then
    a1b poscil iamp, (kdet2+klfo), 29
    a2b poscil iamp, (kfreq2+klfo), 29
    aout1b pdclip a1b, kdrive2, 0, 1
    aout2b pdclip a2b, kdrive, 0, 1
elseif kselect2 == 40 then
    a1b poscil iamp, (kdet2+klfo), 30
    a2b poscil iamp, (kfreq2+klfo), 30
    aout1b pdclip a1b, kdrive2, 0, 1
    aout2b pdclip a2b, kdrive, 0, 1
endif

kchange changed kselect2, kselect
if kchange == 1 then
    reinit play
endif
play:

asum1b = aout1b
asum2b = aout2b

; MIXER OSC1 OSC2 SUB-OSC
kspread init 0.6
gkspread init 0.6
;kspread chnget "spread"
;gkspread portk kspread,.010
aoutL = ((asum1 * gkspread) + (asum2 * (1 - gkspread))) * 0.5
aoutR = ((asum1 * (1 - gkspread)) + (asum2 * gkspread)) * 0.5

kspread2 init 0.6
gkspread2 init 0.6
;kspread2 chnget "spread2"
;gkspread2 portk kspread2, 0.010
aoutLb = ((asum1b * gkspread2) + (asum2b * (1 - gkspread2))) * 0.5
aoutRb = ((asum1b * (1 - gkspread2)) + (asum2b * gkspread2)) * 0.5

amaster1 = aoutL
amaster2 = aoutR 
amaster3 = aoutLb
amaster4 = aoutRb

; MIXER COMBINATIONS
kcombi init 2
;kcombi chnget "combinations"
kmorphing init 0.3
kdrywet init 0.3
;kmorphing chnget "morph"
;kdrywet portk kmorphing, 0.01

if kcombi == 0 then
    asnd1 = amaster1
    asnd2 = amaster2
elseif kcombi == 1 then
    asnd1 = amaster3
    asnd2 = amaster4
elseif kcombi == 2 then
    asnd1 = (amaster3+amaster1)
    asnd2 = (amaster4+amaster2)
elseif kcombi == 3 then
    asnd1 = (amaster3*amaster1)*10
    asnd2 = (amaster4*amaster2)*10
elseif kcombi == 4 then
    asnd1 = amaster1*(1-kdrywet)+(amaster3*kdrywet)
    asnd2 = amaster2*(1-kdrywet)+(amaster4*kdrywet)
endif

; FILTERS SECTION
gkattfl init 0.1
gkdecfl init 0.1
gksusfl init p5*0.75
gkrelfl init 0.10
;gkattfl chnget "attfl"
;gkdecfl chnget "decfl"
;gksusfl chnget "susfl"
;gkrelfl chnget "relfl"

kselfilter init 0
;kselfilter chnget "selfltrs"

;kcutoffx chnget "cutoff"
;khighpassx chnget "highpass"
;kresox chnget "reso"
kmorphfilter init 0.0
;kmorphfilter chnget "mrphfltr"

kamplfofl init 0.0
kcpslfofl init 0.0
itypefl init 0
;kamplfofl chnget "amplfofl"
;kcpslfofl chnget "cpslfofl"
;itypefl chnget "lfotypefl"

kcutoff init 18000.0
kreso init 0.65
khighpass init 2000.0

;kcutoff tonek kcutoffx, 10
;kreso tonek kresox, 10
;khighpass tonek khighpassx, 10

; LFO FILTER
klfofilter lfo kamplfofl, kcpslfofl, itypefl

; ENVELOPE FILTERS
kadsrfilt linseg 0, i(gkattfl), 1, i(gkdecfl), i(gksusfl), i(gkrelfl), 0

; HIGHPASS
ahigh1 clfilt asnd1, (khighpass+klfofilter)*kadsrfilt, 1, 10
ahigh2 clfilt asnd2, (khighpass+klfofilter)*kadsrfilt, 1, 10
afilt1 balance ahigh1, asnd1
afilt2 balance ahigh2, asnd2

; LOWPASS
alow1 moogladder asnd1, (kcutoff+klfofilter)*kadsrfilt, kreso
alow2 moogladder asnd2, (kcutoff+klfofilter)*kadsrfilt, kreso
afilt1b balance alow1, asnd1
afilt2b balance alow2, asnd2

; COMBINE FILTERS
if kselfilter == 0 then
    afiltALL1 = asnd1
    afiltALL2 = asnd2
elseif kselfilter == 1 then
    afiltALL1 = afilt1
    afiltALL2 = afilt2
elseif kselfilter == 2 then
    afiltALL1 = afilt1b
    afiltALL2 = afilt2b
elseif kselfilter == 3 then
    afiltALL1 = afilt1*(1-kmorphfilter)+(afilt1b*kmorphfilter)
    afiltALL2 = afilt2*(1-kmorphfilter)+(afilt2b*kmorphfilter)
endif

; OUTPUTS
aclipoutL clip afiltALL1, 0, 0dbfs
aclipoutR clip afiltALL2, 0, 0dbfs

outs aclipoutL*kadsr, aclipoutR*kadsr

/*
gaL = aclipoutL * kadsr
gaR = aclipoutR * kadsr
*/
    endin
/*
    instr 2 ; MULTIFX

ktoggle chnget "FX"
if ktoggle == 1 then
    kfx1rt chnget "fxrate"
    kfx2dt chnget "fxdepth"
    kmultifx chnget "effect"
    kfxrate tonek kfx1rt, 10
    kfxdepth tonek kfx2dt, 10
    
    ; SELECT FX
    ; 0 = chorus
    ; 1 = flanger
    ; 2 = phaser
    
    if kmultifx == 0 then
        afxL, afxR StChorus gaL, gaR, kfxdepth/400, kfxdepth/600, kfxrate/4, kfxrate/2
    elseif kmultifx == 1 then
        adelfl1 poscil kfxdepth/10000, kfxrate/2000, 1
        adelfl2 poscil kfxdepth/10000, kfxrate/1700, 1
        kfeedfl = 0.5 ; feedback
        afxL flanger gaL*.5, adelfl1, kfeedfl
        afxR flanger gaR*.5, adelfl2, kfeedfl
    elseif kmultifx == 2 then
        afxL, afxR Phaser2x gaL, gaR, kfxrate*.5, kfxdepth*4
    endif

    kmix chnget "fxmix"
    gaL = (afxL * kmix) + (gaL * (1.0 - kmix))
    gaR = (afxR * kmix) + (gaR * (1.0 - kmix))

endif

    endin

    instr 3 ; REVERB

ktoggle chnget "reverb"
if ktoggle == 1 then
    ksize chnget "verbsize"
    kfilt chnget "verbfilt"
  
    al, ar reverbsc gaL*.8, gaR*.8, ksize, kfilt, sr, .2, 0

    asigld dcblock2 al
    asigrd dcblock2 ar
    asigl  clip asigld, 0, 0dbfs
    asigr  clip asigrd, 0, 0dbfs

    kmix chnget "verbmix"
    gaL  = (asigl * kmix) + (gaL * (1.0 - kmix))
    gaR  = (asigr * kmix) + (gaR * (1.0 - kmix))
endif

    endin

    instr 4 ; OUTPUT

; DCBLOCK
gaL dcblock gaL
gaR dcblock gaR

; MASTER GAIN STAGE
kvol chnget "master"
kmult scale kvol, 18.0, -18.0
kmult = ampdbfs(kmult)
gaL = gaL * kmult
gaR = gaR * kmult

;CLIP
gaL clip gaL, 0, 0dbfs
gaR clip gaR, 0, 0dbfs

; APPLY PAN
kpanL chnget "panL"
kpanR chnget "panR"
apanLL init 0
apanLR init 0
apanRR init 0
apanRL init 0

apanLL, apanLR pan2 gaL, kpanL, 0
apanRL, apanRR pan2 gaR, kpanR, 0
gaL = (apanLL + apanRL) / 2.0
gaR = (apanRR + apanLR) / 2.0

; OUTPUT IF NOT MUTED
kmute chnget "mute"
if kmute == 0 then
    outs gaL, gaR
endif

gaL = 0
gaR = 0

    endin

*/

</CsInstruments>
<CsScore>

; sine, triangle, triangle2, square1, square2, pulse, saw1, saw2

f1 0 1024 10 1
f2 0 4096 10 1 0 .111 0 .04 0 .02 0 .012 
f3 0 4096 10 1 0 .111 0 .04 0 .02 0 .012 0 .009 0 .007
f4 0 4096 10 1 0 .333333 0 .2 0 .142857 0 .111111 0 .090909 0 .076923
f5 0 4096 10 1 0 .3 0 .2 0 .14 0 .1 0 0.09 0 0.07 0 0.06 0 0.05
f6 0 4096 10 1 1 1 1 .7 .5 .3 .1

f13 0 4096 11 2
f14 0 4096 11 4
f15 0 4096 11 8
f16 0 4096 11 10
f17 0 4096 11 20

f18 0 4096 10 1 .5 .333 .25 .2 .167 .1428 .125 .111 .1 .0909 .0833 .0769 .0714 .0667 .0625
f19 0 256 7 0 128 1 0 -1 128 0
f20 0 4096 10 1 1 1 1 .7 .5 .3 .1
f21 0 8 -2 0 0 1 0 1 0 0 0 0 1 1 1 0 1 1
f22 0 8 -2 0 0 1 0 1 1 0 0 1 1 1 1 1 0 0 0 1 1 0 1 1 1 0 1 0 1 0 0 0 0 1

f23 0 4096 10 1 0 0 1
f24 0 4096 10 1 0 0 0 1
f25 0 4096 10 1 0 0 0 0 1
f26 0 4096 10 1 0 0 0 0 0 1
f27 0 4096 10 1 0 0 0 0 0 0 1
f28 0 4096 10 1 0 0 0 0 0 0 0 1
f29 0 4096 10 1 0 0 0 0 0 0 0 0 1
f30 0 65536 21 6 1

f0 360000


</CsScore>
</CsoundSynthesizer>