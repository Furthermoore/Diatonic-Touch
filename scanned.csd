<CsoundSynthesizer> 
<CsOptions> 
-o dac -d -+msg_color=0
</CsOptions>
<CsInstruments>


sr     = 44100
ksmps  = 32
nchnls = 2
0dbfs = 1

massign 0,1

;XSCANTABLES
gitemp	ftgen 2000, 0, 128, -7, 1, 128, 1

gitemp	ftgen  3000, 0, 128, -7, 0, 64, 100, 64, 0

gitemp	ftgen  4000, 0, 128, -7, 1, 128, 1

gitemp	ftgen  5000, 0, 128, -7, 0, 128, 0

gitemp	ftgen  29, 0, 4096, 10, 1

;************************************************

;TUNING TABLES
; USING GEN02, YOU MAY CREATE YOUR OWN TUNING SYSTEMS
; CHECKOUT CPSTMIDI & CPSTUN OPCODES, IF YOU'D LIKE TO DO THE SAME
; FORMAT FOR EACH TABLE:
;       giTableName ftgen 0, 64, -2, nTonesPerOctave, freqIntervalBetweenOctaves, baseFreq, baseFreqMIDINoteNum

; STANDARD TUNING - 12 TONE EQUAL TEMPERMENT
gitemp	ftgen 101,0,64,-2,12,2,261.626,60,1,1.059463,1.1224619,1.1892069,1.2599207,1.33483924,1.414213,1.4983063,1.5874001,1.6817917,1.7817962,1.8877471,2

; QUARTER-TONES
gitemp	ftgen 102,0,64,-2,24,2,261.626,60,1,1.0293022,1.059463,1.0905076,1.1224619,1.1553525,1.1892069,1.2240532,1.2599207,1.2968391,1.33483924,1.3739531,1.414213,1.4556525,1.4983063,1.54221,1.5874001,1.6339145,1.6817917,1.73107,1.7817962,1.8340067,1.8877471,1.9430623,2

; DECATONIC
gitemp	ftgen 103,0,64,-2,10,2,261.626,60,1,1.0717734,1.148698,1.2311444,1.3195079,1.4142135,1.5157165,1.6245047,1.7411011,1.8660659,2

; PYTHAGOREAN
gitemp	ftgen 104,0,64,-2,8 ,2,261.626,60,1,1.125,1.265625,1.3333333333333333333333333333333,1.5,1.6875,1.8984375,2

; THIRD-TONES
gitemp	ftgen 105,0,64,-2,36,2,261.626,60,1,1.0194406,1.0392591,1.059463,1.0800596,1.1010566,1.1224618,1.1442831,1.1665286,1.1892067,1.2123255,1.2358939,1.2599204,1.284414,1.3093838,1.334839,1.3607891,1.3872436,1.4142125,1.4417056,1.4697332,1.4983057,1.5274337,1.5571279,1.5873994,1.6182594,1.6497193,1.6817909,1.7144859,1.7478165,1.7817951,1.8164343,1.8517469,1.8877459,1.9244448,1.9618572,2

; DETUNED
gitemp	ftgen 106,0,16,-2,12,2,261.626,60,1,1.111111111,1.142857143,1.25,1.285714286,1.388888889,1.428571429,1.5,1.607142857,1.666666667,1.714285714,1.928571429

; HARMONIC
gitemp	ftgen 107,0,64,-2,36,2,30.5,24,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36

; CHINESE
gitemp	ftgen 108,0,64,-2,7 ,2,261.626,60,1,1.125,1.265625,1.423828125,1.5,1.6875,1.8984375,2

; MAJOR-TRIAD
gitemp	ftgen 109,0,64,-2,7 ,2,261.626,60,1,1.125,1.25,1.3333333333333333333333333333333,1.5,1.6666666666666666666666666666667,1.875,2

; PENTATONIC
gitemp	ftgen 110,0,64,-2,5 ,2,261.626,60,1,1.125,1.25,1.5,1.6666666666666666666666666666667

; BOHLEN-PIERCE
gitemp	ftgen 111,0,64,-2,13 ,3,261.626,60,1.08,1.1904761904761904761904761904762,1.2857142857142857142857142857143,1.4,1.5306122448979591836734693877551,1.6666666666666666666666666666667,1.8,1.96,2.1428571428571428571428571428571,2.3333333333333333333333333333333,2.52,2.7777777777777777777777777777778,3

; BHARATA-TUNING
gitemp	ftgen 112,0,64,-2,23 ,2,261.626,60,1.0000,1.0404,1.0813,1.1226,1.1644,1.2066,1.2493,1.2925,1.3361,1.3802,1.4248,1.4699,1.5155,1.5616,1.6082,1.6553,1.7030,1.7511,1.7998,1.8490,1.8988,1.9491,2.0000 ;Narsing

; INDIAN-SHRUTI
gitemp	ftgen 113,0,64,-2,22 ,2,261.626,60,1,1.0534979423868312757201646090535,1.0666666666666666666666666666667,1.1111111111111111111111111111111,1.125,1.1851851851851851851851851851852,1.2,1.25,1.265625,1.3333333333333333333333333333333,1.35,1.40625,1.423828125,1.5,1.5802469135802469135802469135802,1.6,1.6666666666666666666666666666667,1.6875,1.7777777777777777777777777777778,1.8,1.875,1.8984375 ;indian

; W.CARLOS-ALPHA
gitemp	ftgen 114,0,64,-2,19 ,2.25,261.626,60,1, 1.05, 1.09375, 1.1428571428571428571428571428571, 1.2, 1.25, 1.3125, 1.3714285714285714285714285714286, 1.4285714285714285714285714285714,1.5,1.575, 1.6666666666666666666666666666667, 1.7142857142857142857142857142857,1.8, 1.875, 1.96875, 2.0571428571428571428571428571429, 2.1428571428571428571428571428571, 2.25


;**********************************************************************
;**********************************************************************
;**********************************************************************
;**********************************************************************
opcode Stereo_chorus,aa,aakk

a1,a2,kdepth,krate xin

k1	randomi	.01,kdepth,krate
adel1	vdelay	a1,k1,1000

k2	randomi	.01,kdepth*0.1,krate*0.1
adel2	vdelay	a2,k2,1000 

k3	randomi	.01,kdepth*0.2,krate*0.2
adel3	vdelay	a1,k3,1000 

k4	randomi	.01,kdepth*0.3,krate*0.3
adel4	vdelay	a2,k4,1000 

k5	randomi	.01,kdepth*0.4,krate*0.4
adel5	vdelay	a1,k5,1000

k6	randomi	.01,kdepth*0.5,krate*0.5
adel6	vdelay	a2,k6,1000 

k7	randomi	.01,kdepth*0.6,krate*0.6
adel7	vdelay	a1,k7,1000 

k8	randomi	.01,kdepth*0.7,krate*0.7
adel8	vdelay	a2,k8,1000 



aout1 =	(adel1+adel2+adel3+adel4)
aout2 =(adel5+adel6+adel7+adel8)

xout	aout1,aout2

endop


;*************************************
;PHASER2X

opcode Phaser2x,aa,aakk


;al,ar   Phaser2x   asig1,asig2,krate,kmod


asig1,asig2,krate,kfreq xin  



kPhQ = .5                       ;(range =  .25 to 4 )

klfo    lfo   .5,krate
kmod    = kfreq*(1+klfo)        ;(range = 200 to 8000)
istages = 8                   ;( range = 1  to  16 iorder)
;kPhSep  = .4                   ;(range =  .25 a 4 )
;kPhFdbk = .5                   ;(-.99 a .95)


aphs1   phaser2 asig1, kmod, kPhQ, istages,2,1,.4
aphs2   phaser2 asig2, kmod, kPhQ, istages,2,1,.4


xout  aphs1 ,aphs2         ; write output


       endop


;*******************************************
opcode StChorus,aa,aakkkk

asigr,asigl,kdepth,kdepthl,krate,kratel  xin   ;legge i parametri in entrata

;ar,al  StChorus asigr,asigl,kdepth,kdepthl,krate,kratel


k1ch  randi       kdepth/2,krate,1
ar1   vdelay asigr,kdepth/2+k1ch,10
k2ch  randi       kdepth/2,krate*0.9,.2
ar2   vdelay asigr,kdepth/2+k2ch,10
k3ch  randi       kdepth/2,krate*1.1,.2
ar3   vdelay asigr,kdepth/2+k3ch,10
k4ch  randi       kdepth/2,krate*1.3,.1
ar4   vdelay asigr,kdepth/2+k4ch,10

k1chl  randi       kdepthl/2,kratel,1
ar1l   vdelay asigl,kdepthl/2+k1chl,10
k2chl  randi       kdepthl/2,kratel*0.9,.2
ar2l   vdelay asigl,kdepthl/2+k2chl,10
k3chl  randi       kdepthl/2,kratel*1.1,.2
ar3l   vdelay asigl,kdepthl/2+k3chl,10
k4chl  randi       kdepthl/2,kratel*1.3,.1
ar4l   vdelay asigl,kdepthl/2+k4chl,10


aL   =    (ar1+ar2+ar3+ar4)/2
aR  =    (ar1l+ar2l+ar3l+ar4l)/2
xout aL,aR           ; write output

       endop



;********************************************
;********************************************
;********************************************
;********************************************
;***************RESONATORS OPCODES***********
;********************************************
;********************************************
opcode Chladni_plates,a,akk

;[1, 1.72581, 5.80645, 7.41935, 13.91935] ratios 

asig,kpitch,kq xin



a1 mode  asig,1,kq
a2 mode  asig,kpitch*1.72581,kq
a3 mode  asig,kpitch*5.80645,kq
a4 mode  asig,kpitch*7.41935,kq
a5 mode  asig,kpitch*13.91935,kq

asum  sum  a1,a2,a3,a4,a5

aout = asum
aout2  balance  aout,asig

xout aout2            ; write output

       endop
;********************************************
;********************************************
;********************************************

opcode Tibetan_bowl ,a,akk

asig,kpitch,kq xin

;[1, 2.77828, 5.18099, 8.16289, 11.66063, 15.63801, 19.99 ratios

a1 mode  asig,kpitch*1,kq
a2 mode  asig,kpitch*2.77828,kq
a3 mode  asig,kpitch*5.18099,kq
a4 mode  asig,kpitch*8.16289,kq
a5 mode  asig,kpitch*11.66063,kq
a6 mode  asig,kpitch*15.63801,kq
a7 mode  asig,kpitch*19.99,kq


asum  sum  a1,a2,a3,a4,a5,a6,a7

aout = asum


aout2  balance  aout,asig


xout aout2            ; write output

       endop

;********************************************
;********************************************
;********************************************


;********************************************
;********************************************
;********************************************



opcode Tibetan_bowl2 ,a,akk

asig,kpitch,kq xin

;[1, 2.66242, 4.83757, 7.51592, 10.64012, 14.21019, 18.14027] ratios

a1 mode  asig,kpitch*1,kq
a2 mode  asig,kpitch*2.66242,kq
a3 mode  asig,kpitch*4.83757,kq
a4 mode  asig,kpitch*7.51592,kq
a5 mode  asig,kpitch*10.64012,kq
a6 mode  asig,kpitch*14.21019,kq
a7 mode  asig,kpitch*18.14027,kq


asum  sum  a1,a2,a3,a4,a5,a6,a7

aout = asum


aout2  balance  aout,asig


xout aout2            ; write output

       endop

;********************************************
;********************************************
;********************************************


;********************************************
;********************************************
;********************************************



opcode Tibetan_bowl3 ,a,akk

asig,kpitch,kq xin

;[1, 2.76515, 5.12121, 7.80681, 10.78409] ratios 

a1 mode  asig,kpitch*1,kq
a2 mode  asig,kpitch*2.76515,kq
a3 mode  asig,kpitch*5.12121,kq
a4 mode  asig,kpitch*7.80681,kq
a5 mode  asig,kpitch*10.78409,kq


asum  sum  a1,a2,a3,a4,a5

aout = asum


aout2  balance  aout,asig


xout aout2            ; write output

       endop

;********************************************
;********************************************
;********************************************

opcode Small_Handbell ,a,akk


asig,kpitch,kq xin

;[ 1, 1.0019054878049, 1.7936737804878, 1.8009908536585, 2.5201981707317, 2.5224085365854,

; 2.9907012195122, 2.9940548780488, 3.7855182926829, 3.8061737804878, 4.5689024390244, 

;4.5754573170732, 5.0296493902439, 5.0455030487805, 6.0759908536585, 5.9094512195122,

; 6.4124237804878, 6.4430640243902, 7.0826219512195, 7.0923780487805, 7.3188262195122, 

;7.5551829268293 ] ratios 

a1 mode  asig,kpitch*1,kq
a2 mode  asig,kpitch*1.0019054878049,kq
a3 mode  asig,kpitch*1.7936737804878,kq
a4 mode  asig,kpitch*1.8009908536585,kq
a5 mode  asig,kpitch*2.5201981707317,kq
a6 mode  asig,kpitch*2.5224085365854,kq
a7 mode  asig,kpitch*2.9907012195122,kq
a8 mode  asig,kpitch*2.9940548780488,kq
a9 mode  asig,kpitch*3.7855182926829,kq
a10 mode  asig,kpitch*3.8061737804878,kq
a11 mode  asig,kpitch*4.5689024390244,kq
a12 mode  asig,kpitch*4.5754573170732,kq
a13 mode  asig,kpitch*5.0296493902439,kq
a14 mode  asig,kpitch*5.0455030487805,kq
a15 mode  asig,kpitch*6.0759908536585,kq
a16 mode  asig,kpitch*5.9094512195122,kq
a17 mode  asig,kpitch*6.4124237804878,kq
a18 mode  asig,kpitch*6.4430640243902,kq
a19 mode  asig,kpitch*7.0826219512195,kq
a20 mode  asig,kpitch*7.0923780487805,kq
a21 mode  asig,kpitch*7.3188262195122,kq
a22 mode  asig,kpitch*7.5551829268293,kq



aout = (a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11+a12+a13+a14+a15+a16+a17+a18+a19+a20+a21+a22+a22)

aout2  balance  aout,asig

xout aout2            ; write output

       endop


;********************************************
;********************************************
;********************************************

opcode Spinel_sphere ,a,akk


asig,kpitch,kq xin


;[ 1, 1.026513174725, 1.4224916858532, 1.4478690202098, 1.4661959580455,

; 1.499452545408, 1.7891839345101, 1.8768994627782, 1.9645945254541, 1.9786543873113,

; 2.0334612432847, 2.1452852391916, 2.1561524686621, 2.2533435661294,;

; 2.2905090816065, 2.3331798413917, 0, 2.4567715528268, 2.4925556408289, 2.5661806088514,

; 2.6055768738808, 2.6692760296751, 2.7140956766436, 2.7543617293425, 2.7710411870043 ] ratios 



a1 mode  asig,kpitch*1,kq
a2 mode  asig,kpitch*1.026513174725,kq
a3 mode  asig,kpitch*1.4224916858532,kq
a4 mode  asig,kpitch*1.4478690202098,kq
a5 mode  asig,kpitch*1.4661959580455,kq
a6 mode  asig,kpitch*1.499452545408,kq
a7 mode  asig,kpitch*1.7891839345101,kq
a8 mode  asig,kpitch*1.8768994627782,kq
a9 mode  asig,kpitch*1.9645945254541,kq
a10 mode  asig,kpitch*1.9786543873113,kq
a11 mode  asig,kpitch*2.0334612432847,kq
a12 mode  asig,kpitch*2.1452852391916,kq
a13 mode  asig,kpitch*2.1561524686621,kq
a14 mode  asig,kpitch*2.2533435661294,kq
a15 mode  asig,kpitch*2.2905090816065,kq
a16 mode  asig,kpitch*2.3331798413917,kq
;a17 mode  asig,kpitch*0,kq
a18 mode  asig,kpitch*2.4567715528268,kq
a19 mode  asig,kpitch*2.4925556408289,kq
a20 mode  asig,kpitch*2.5661806088514,kq
a21 mode  asig,kpitch*2.6055768738808,kq
a22 mode  asig,kpitch*2.6692760296751,kq
a23 mode  asig,kpitch*2.7140956766436,kq

a24 mode  asig,kpitch*2.7543617293425,kq

a25 mode  asig,kpitch*2.7710411870043,kq


aout = (a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11+a12+a13+a14+a15+a16+a18+a19+a20+a21+a22+a22+a23+a24+a25)

aout2  balance  aout,asig

xout aout2            ; write output

       endop

;*********************************************************************
;*********************************************************************
;*********************************************************************
;*********************************************************************

;*********************************************************************
opcode Vibraphone1 ,a,akk



asig,kpitch,kq xin


;[1, 3.984, 10.668, 17.979, 23.679, 33.642] 

a1 mode  asig,kpitch*1,kq
a2 mode  asig,kpitch*3.984,kq
a3 mode  asig,kpitch*10.668,kq
a4 mode  asig,kpitch*17.979,kq
a5 mode  asig,kpitch*23.679,kq
a6 mode  asig,kpitch*33.642,kq

asum  sum  a1,a2,a3,a4,a5,a6

aout = asum


aout2  balance  aout,asig


xout aout2            ; write output

       endop


;********************************************************
;*******************************************************

;*********************************************************************
;*********************************************************************
;*********************************************************************
;*********************************************************************

;*********************************************************************
opcode Vibraphone2 ,a,akk



asig,kpitch,kq xin


;[1, 3.997, 9.469, 15.566, 20.863, 29.440] 

a1 mode  asig,kpitch*1,kq
a2 mode  asig,kpitch*3.997,kq
a3 mode  asig,kpitch*9.469,kq
a4 mode  asig,kpitch*15.566,kq
a5 mode  asig,kpitch*20.863,kq
a6 mode  asig,kpitch*29.440,kq

asum  sum  a1,a2,a3,a4,a5,a6

aout = asum


aout2  balance  aout,asig


xout aout2            ; write output

       endop


;********************************************************
;*******************************************************




opcode Wine_Glass ,a,akk




asig,kpitch,kq xin

;[1, 2.32, 4.25, 6.63, 9.38] 

a1 mode  asig,kpitch*1,kq
a2 mode  asig,kpitch*2.32,kq
a3 mode  asig,kpitch*4.25,kq
a4 mode  asig,kpitch*6.63,kq
a5 mode  asig,kpitch*9.38,kq


asum  sum  a1,a2,a3,a4,a5

aout = asum


aout2  balance  aout,asig


xout aout2            ; write output

       endop


;***********************************************
;***********************************************
;***********************************************
;***********************************************
;***********************************************
;***********************************************
;***********************************************

opcode Membrane ,a,akk



asig,kpitch,kq xin



a1 mode  asig,kpitch*1,kq
a2 mode  asig,kpitch*1.59334,kq
a3 mode  asig,kpitch*2.13555,kq
a4 mode  asig,kpitch*2.65307,kq
a5 mode  asig,kpitch*2.29542,kq
a6 mode  asig,kpitch*2.9173,kq
a7 mode  asig,kpitch*3.50015,kq
a8 mode  asig,kpitch*4.05893,kq
a9 mode  asig,kpitch*3.59848,kq
a10 mode  asig,kpitch*4.23044,kq
a11 mode  asig,kpitch*4.83189,kq
a12 mode  asig,kpitch*5.41212,kq
a13 mode  asig,kpitch*4.90328,kq
a14 mode  asig,kpitch*5.5404,kq
a15 mode  asig,kpitch*6.15261,kq
a16 mode  asig,kpitch*6.74621,kq



aout = (a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11+a12+a13+a14+a15+a16)/15


aout2  balance  aout,asig


xout aout2            ; write output

       endop

;********************************************
;********************************************
;********************************************

;Dahina tabla
;[1, 2.89, 4.95, 6.99, 8.01, 9.02] 

opcode Dahina_tabla,a,akk

asig,kpitch,kq xin

kfreq1 = 1
kfreq2 = 2.89
kfreq3 = 4.95
kfreq4 = 6.99
kfreq5 = 8.01
kfreq6 = 9.02


a1 mode  asig,kpitch*kfreq1,kq
a2 mode  asig,kpitch*kfreq2,kq
a3 mode  asig,kpitch*kfreq3,kq
a4 mode  asig,kpitch*kfreq4,kq
a5 mode  asig,kpitch*kfreq5,kq
a6 mode  asig,kpitch*kfreq6,kq


asum  sum  a1,a2,a3,a4,a5,a6

aout = asum
aout2  balance  aout,asig

xout aout2            ; write output

       endop
;********************************************
;********************************************
;********************************************




;********************************************
;********************************************
;********************************************

;Bayan tabla
;[1, 2.0, 3.01, 4.01, 4.69, 5.63] 

opcode Bayan_tabla,a,akk

asig,kpitch,kq xin

kfreq1 = 1
kfreq2 = 2.0
kfreq3 = 3.01
kfreq4 = 4.01
kfreq5 = 4.69
kfreq6 = 5.63


a1 mode  asig,kpitch*kfreq1,kq
a2 mode  asig,kpitch*kfreq2,kq
a3 mode  asig,kpitch*kfreq3,kq
a4 mode  asig,kpitch*kfreq4,kq
a5 mode  asig,kpitch*kfreq5,kq
a6 mode  asig,kpitch*kfreq6,kq


asum  sum  a1,a2,a3,a4,a5,a6

aout = asum
aout2  balance  aout,asig

xout aout2            ; write output

       endop
;********************************************
;********************************************
;********************************************

;********************************************
;********************************************
;********************************************

;Red Cedar wood plate
;[1, 1.47, 2.09, 2.56] 

opcode Red_Cedar,a,akk

asig,kpitch,kq xin

kfreq1 = 1
kfreq2 = 1.47
kfreq3 = 2.09
kfreq4 = 2.56



a1 mode  asig,kpitch*kfreq1,kq
a2 mode  asig,kpitch*kfreq2,kq
a3 mode  asig,kpitch*kfreq3,kq
a4 mode  asig,kpitch*kfreq4,kq



asum  sum  a1,a2,a3,a4

aout = asum
aout2  balance  aout,asig

xout aout2            ; write output

       endop
;********************************************
;********************************************
;********************************************
;********************************************
;********************************************
;********************************************

;Redwood wood plate
;[1, 1.47, 2.11, 2.57] 

opcode Redwood,a,akk

asig,kpitch,kq xin

kfreq1 = 1
kfreq2 = 1.47
kfreq3 = 2.11
kfreq4 = 2.57



a1 mode  asig,kpitch*kfreq1,kq
a2 mode  asig,kpitch*kfreq2,kq
a3 mode  asig,kpitch*kfreq3,kq
a4 mode  asig,kpitch*kfreq4,kq



asum  sum  a1,a2,a3,a4

aout = asum
aout2  balance  aout,asig

xout aout2            ; write output

       endop
;********************************************
;********************************************
;********************************************

;********************************************
;********************************************
;********************************************

;Douglas Fir wood plate
;[1, 1.42, 2.11, 2.47] 

opcode Douglas_Fir_wood,a,akk

asig,kpitch,kq xin

kfreq1 = 1
kfreq2 = 1.42
kfreq3 = 2.11
kfreq4 = 2.47



a1 mode  asig,kpitch*kfreq1,kq
a2 mode  asig,kpitch*kfreq2,kq
a3 mode  asig,kpitch*kfreq3,kq
a4 mode  asig,kpitch*kfreq4,kq



asum  sum  a1,a2,a3,a4

aout = asum
aout2  balance  aout,asig

xout aout2            ; write output

       endop
;********************************************
;********************************************
;********************************************

;********************************************
;********************************************
;********************************************

;uniform wooden bar
;[1, 2.572, 4.644, 6.984, 9.723] 

opcode Wooden_bar,a,akk

asig,kpitch,kq xin

kfreq1 = 1
kfreq2 = 2.572
kfreq3 = 4.644
kfreq4 = 6.984
kfreq5 = 9.723


a1 mode  asig,kpitch*kfreq1,kq
a2 mode  asig,kpitch*kfreq2,kq
a3 mode  asig,kpitch*kfreq3,kq
a4 mode  asig,kpitch*kfreq4,kq
a5 mode  asig,kpitch*kfreq5,kq


asum  sum  a1,a2,a3,a4,a5

aout = asum
aout2  balance  aout,asig

xout aout2            ; write output

       endop
;********************************************
;********************************************
;********************************************

;********************************************
;********************************************
;********************************************

;uniform aluminum bar
;[1, 2.756, 5.423, 8.988, 13.448, 18.680] 

opcode Aluminum_bar,a,akk

asig,kpitch,kq xin

kfreq1 = 1
kfreq2 = 2.756
kfreq3 = 5.423
kfreq4 = 8.988
kfreq5 = 13.448
kfreq6 = 18.680

a1 mode  asig,kpitch*kfreq1,kq
a2 mode  asig,kpitch*kfreq2,kq
a3 mode  asig,kpitch*kfreq3,kq
a4 mode  asig,kpitch*kfreq4,kq
a5 mode  asig,kpitch*kfreq5,kq
a6 mode  asig,kpitch*kfreq6,kq

asum  sum  a1,a2,a3,a4,a5,a6

aout = asum
aout2  balance  aout,asig

xout aout2            ; write output

       endop
;********************************************
;********************************************
;********************************************

;********************************************
;********************************************
;********************************************

;Xylophone
;[1, 3.932, 9.538, 16.688, 24.566, 31.147] 

opcode Xylophone,a,akk

asig,kpitch,kq xin

kfreq1 = 1
kfreq2 = 3.932
kfreq3 = 9.538
kfreq4 = 16.688
kfreq5 = 24.566
kfreq6 = 31.147

a1 mode  asig,kpitch*kfreq1,kq
a2 mode  asig,kpitch*kfreq2,kq
a3 mode  asig,kpitch*kfreq3,kq
a4 mode  asig,kpitch*kfreq4,kq
a5 mode  asig,kpitch*kfreq5,kq
a6 mode  asig,kpitch*kfreq6,kq

asum  sum  a1,a2,a3,a4,a5,a6

aout = asum
aout2  balance  aout,asig

xout aout2            ; write output

       endop
;********************************************
;********************************************
;********************************************

;********************************************
;********************************************
;********************************************

;jegogan bars


;1    2.7   5.2     8.4    12.2



opcode Jegogan_bars,a,akk

asig,kpitch,kq xin

kfreq1 = 1
kfreq2 = 2.7
kfreq3 = 5.2
kfreq4 = 8.4
kfreq5 = 12.2


a1 mode  asig,kpitch*kfreq1,kq
a2 mode  asig,kpitch*kfreq2,kq
a3 mode  asig,kpitch*kfreq3,kq
a4 mode  asig,kpitch*kfreq4,kq
a5 mode  asig,kpitch*kfreq5,kq


asum  sum  a1,a2,a3,a4,a5

aout = asum
aout2  balance  aout,asig

xout aout2            ; write output

       endop
;********************************************
;********************************************
;********************************************


;********************************************
;********************************************
;********************************************



opcode Chime_tube1,a,akk

asig,kpitch,kq xin

kfreq1 = 0.22
kfreq2 = 0.61
kfreq3 = 1.21
kfreq4 = 2
kfreq5 = 2.99
kfreq6 = 4.17
kfreq7 = 5.56
kfreq8 = 7.14



a1 mode  asig,kpitch*kfreq1,kq
a2 mode  asig,kpitch*kfreq2,kq
a3 mode  asig,kpitch*kfreq3,kq
a4 mode  asig,kpitch*kfreq4,kq
a5 mode  asig,kpitch*kfreq5,kq
a6 mode  asig,kpitch*kfreq6,kq
a7 mode  asig,kpitch*kfreq7,kq
a8 mode  asig,kpitch*kfreq8,kq

asum  sum  a1,a2,a3,a4,a5,a6,a7,a8

aout = asum
aout2  balance  aout,asig

xout aout2            ; write output

       endop
;********************************************
;********************************************
;********************************************

;********************************************
;********************************************
;********************************************



opcode Chime_tube2,a,akk

asig,kpitch,kq xin

kfreq1 = 0.24
kfreq2 = 0.64
kfreq3 = 1.23
kfreq4 = 2
kfreq5 = 2.91
kfreq6 = 3.96
kfreq7 = 5.12
kfreq8 = 6.37



a1 mode  asig,kpitch*kfreq1,kq
a2 mode  asig,kpitch*kfreq2,kq
a3 mode  asig,kpitch*kfreq3,kq
a4 mode  asig,kpitch*kfreq4,kq
a5 mode  asig,kpitch*kfreq5,kq
a6 mode  asig,kpitch*kfreq6,kq
a7 mode  asig,kpitch*kfreq7,kq
a8 mode  asig,kpitch*kfreq8,kq

asum  sum  a1,a2,a3,a4,a5,a6,a7,a8

aout = asum
aout2  balance  aout,asig

xout aout2            ; write output

       endop
;********************************************
;********************************************
;********************************************

;********************************************
;********************************************
;********************************************



opcode Chime_tube3,a,akk

asig,kpitch,kq xin

kfreq1 = 0.24
kfreq2 = 0.63
kfreq3 = 1.22
kfreq4 = 2
kfreq5 = 2.93
kfreq6 = 4.01
kfreq7 = 5.21
kfreq8 = 6.50



a1 mode  asig,kpitch*kfreq1,kq
a2 mode  asig,kpitch*kfreq2,kq
a3 mode  asig,kpitch*kfreq3,kq
a4 mode  asig,kpitch*kfreq4,kq
a5 mode  asig,kpitch*kfreq5,kq
a6 mode  asig,kpitch*kfreq6,kq
a7 mode  asig,kpitch*kfreq7,kq
a8 mode  asig,kpitch*kfreq8,kq

asum  sum  a1,a2,a3,a4,a5,a6,a7,a8

aout = asum
aout2  balance  aout,asig

xout aout2            ; write output

       endop
;********************************************
;********************************************
;********************************************
;********************************************
;********************************************
;********************************************



opcode Chime_tube4,a,akk

asig,kpitch,kq xin

kfreq1 = 0.5
kfreq2 = 1
kfreq3 = 1.2
kfreq4 = 2
kfreq5 = 2.5
kfreq6 = 3
kfreq7 = 4
kfreq8 = 5.33
kfreq9 = 6.67


a1 mode  asig,kpitch*kfreq1,kq
a2 mode  asig,kpitch*kfreq2,kq
a3 mode  asig,kpitch*kfreq3,kq
a4 mode  asig,kpitch*kfreq4,kq
a5 mode  asig,kpitch*kfreq5,kq
a6 mode  asig,kpitch*kfreq6,kq
a7 mode  asig,kpitch*kfreq7,kq
a8 mode  asig,kpitch*kfreq8,kq
a9 mode  asig,kpitch*kfreq9,kq

asum  sum  a1,a2,a3,a4,a5,a6,a7,a8,a9

aout = asum
aout2  balance  aout,asig

xout aout2            ; write output

       endop
;********************************************
;********************************************
;********************************************
;********************************************
;********************************************
;********************************************
;********************************************
;********************************************

; 	

;[ 1, 3.2, 6.23, 6.27, 9.92, 14.15] ratios

opcode Pot_lit,a,akk

asig,kpitch,kq xin

kfreq1 = 1
kfreq2 = 3.2
kfreq3 = 6.23
kfreq4 = 6.27
kfreq5 = 9.92
kfreq6 = 14.15



a1 mode  asig,kpitch*kfreq1,kq
a2 mode  asig,kpitch*kfreq2,kq
a3 mode  asig,kpitch*kfreq3,kq
a4 mode  asig,kpitch*kfreq4,kq
a5 mode  asig,kpitch*kfreq5,kq
a6 mode  asig,kpitch*kfreq6,kq


asum  sum  a1,a2,a3,a4,a5,a6

aout = asum
aout2  balance  aout,asig

xout aout2            ; write output

       endop
;********************************************
;********************************************
;********************************************
;#include	"resonatori.h"

instr  	1

midinoteonkey p4, p5

iNote = p4
iAmp  = p5

kTuning	chnget	"tuning"
kTrig init 1
kIndex init iNote
kFreq	cpstun	kTrig, kIndex, kTuning

                                ;kbend   pchbend 0,2  ;pitch bend

iAttack     chnget	"attack"
iDecay      chnget	"decay"
iSustain	chnget	"sustain"
iRelease	chnget	"release"

kAmpLFO     chnget	"amplfo"
kFreqLFO	chnget	"cpslfo"
iLFOType       chnget	"lfotype"
iCondFn     chnget	"initial"



;aout scantable kamp, kpch, ipos, imass, istiff, idamp, ivel

kLFO	lfo	kAmpLFO,kFreqLFO,iLFOType

;*powoftwo(kbend)
kDetune	chnget	"detMult"

kADSR	madsr	iAttack, iDecay, iSustain, iRelease

;four scanned trajectorys
a1 scantable  iAmp*kADSR, i(kFreq), iCondFn, 2000 , 3000, 4000, 5000
a2 scantable  iAmp*kADSR, (i(kFreq)*kDetune), iCondFn, 2000 , 3000, 4000, 5000

;outputs
aLeft	=	a1+a2	;left
aRight	=	a1+a2	;right

;*************************************
; FILTERS SECTION
kSelFilter	chnget	"filters"
kCutoffX	chnget	"cutoff"
kResoX      chnget	"res"

kCutoff	tonek	kCutoffX,10
kReso	tonek	kResoX,10

if	kSelFilter	==	0	then ; BYPASS
    aFilt1	=	aLeft
    aFilt2	=	aRight
elseif	kSelFilter	==	1	then ; MOOGLADDER
    aMoog1	moogladder	aLeft, kCutoff*kADSR, kReso
    aMoog2	moogladder	aRight, kCutoff*kADSR, kReso
    aFilt1	balance 	aMoog1, aLeft
    aFilt2	balance 	aMoog2, aRight
elseif	kSelFilter	==	2	then ; STRING-RESON
    ast1	streson	aLeft, kCutoff/10, .9
    ast2	streson	aRight, kCutoff/10, .9
    aFilt1	balance 	ast1, aLeft
    aFilt2	balance 	ast2, aRight
elseif	kSelFilter	==	3	then ; BANDPASS
    abubp1	butterbp	aLeft, (kCutoff/2)*kADSR, kReso*3000
    abubp2	butterbp	aRight, (kCutoff/2)*kADSR, kReso*3000
    aFilt1	balance 	abubp1, aLeft
    aFilt2	balance 	abubp2, aRight
elseif	kSelFilter	==	4	then ; WAVEGUIDE
    awg1	wguide2	aLeft, kReso*100, kReso*1000, kCutoff/2, kCutoff/3, .2, .2
    awg2	wguide2	aRight, kReso*100, kReso*1000, kCutoff/2, kCutoff/3, .2, .2
    aFilt1	balance 	awg1, aLeft
    aFilt2	balance 	awg2, aRight
elseif	kSelFilter	==	5	then ; LOWPASS
    abulp1	butterlp	aLeft, kCutoff*kADSR
    abulp2	butterlp	aRight, kCutoff*kADSR
    aFilt1	balance 	abulp1, aLeft
    aFilt2	balance 	abulp2, aRight
elseif	kSelFilter	==	6	then ; NOTCH
    anotch1	butterbr	aLeft, kCutoff*4, kReso*2000
    anotch2	butterbr	aRight, kCutoff*4, kReso*2000
    aFilt1	balance 	anotch1, aLeft
    aFilt2	balance 	anotch2, aRight
elseif	kSelFilter	==	7	then ; FOFILTER
    afof1	fofilter	aLeft, kCutoff/10, kReso/1000, kReso/100
    afof2	fofilter	aRight, kCutoff/10, kReso/1000, kReso/100
    aFilt1	balance 	afof1, aLeft
    aFilt2	balance 	afof2, aRight
elseif	kSelFilter	==	8	then ; HIGHPASS
    abuhp1	butterhp	aLeft, (kCutoff*.5)*kADSR
    abuhp2	butterhp	aRight, (kCutoff*.5)*kADSR
    aFilt1	balance 	abuhp1, aLeft
    aFilt2	balance 	abuhp2, aRight

;RESONATORS
elseif	kSelFilter	==	9	then ; MEMBRANE
    aFilt1	Membrane aLeft, kCutoff*.05, kReso*100
    aFilt2	Membrane aRight, kCutoff*.05, kReso*100
elseif	kSelFilter	==	10	then ; CHIME-TUBE
    aFilt1	Chime_tube2 aLeft, kCutoff*.08, kReso*100
    aFilt2	Chime_tube2 aRight, kCutoff*.08, kReso*100
elseif	kSelFilter	==	11	then ; JEGOGAN-BARS
    aFilt1	Jegogan_bars aLeft, kCutoff*.05, kReso*100
    aFilt2	Jegogan_bars aRight, kCutoff*.05, kReso*100
elseif	kSelFilter	==	12	then ; ALUMINUM
    aFilt1	Aluminum_bar aLeft, kCutoff*.03, kReso*100
    aFilt2	Aluminum_bar aRight, kCutoff*.03, kReso*100
elseif	kSelFilter	==	13	then ; REDWOOD
    aFilt1	Redwood aLeft, kCutoff*.1, kReso*100
    aFilt2	Redwood aRight, kCutoff*.1, kReso*100
elseif	kSelFilter	==	14	then ; TABLA
    aFilt1	Dahina_tabla aLeft, kCutoff*.07, kReso*100
    aFilt2	Dahina_tabla aRight, kCutoff*.07, kReso*100
elseif	kSelFilter	==	15	then ; WINE-GLASS
    aFilt1	Wine_Glass aLeft, kCutoff*.05, kReso*100
    aFilt2	Wine_Glass aRight, kCutoff*.05, kReso*100
elseif	kSelFilter	==	16	then ; VIBRAPHONE
    aFilt1	Vibraphone1 aLeft, kCutoff*.01, kReso*100
    aFilt2	Vibraphone1 aRight, kCutoff*.01, kReso*100
elseif	kSelFilter	==	17	then ; SPINEL-SPHERE
    aFilt1	Spinel_sphere aLeft, kCutoff*.1, kReso*100
    aFilt2	Spinel_sphere aRight, kCutoff*.1, kReso*100
elseif	kSelFilter	==	18	then ; SMALL-HANDBELL
    aFilt1	Small_Handbell aLeft, kCutoff*.06, kReso*100
    aFilt2	Small_Handbell aRight, kCutoff*.06, kReso*100
elseif	kSelFilter	==	19	then ; TIBETAN-BOWL
    aFilt1	Tibetan_bowl aLeft, kCutoff*.03, kReso*100
    aFilt2	Tibetan_bowl aRight, kCutoff*.03, kReso*100
endif


;*************************************
;section multifx
kfx1rt      chnget	"fxrate"
kfx2dt      chnget	"fxdepth"
kmultifx	chnget	"effects"
kdrywet     chnget	"fxmix"

kfxrate	tonek	kfx1rt,10
kfxdepth	tonek	kfx2dt,10


if	kmultifx	==	0	then	;bypass
    afxL	=	aFilt1
    afxR	=	aFilt2
elseif	kmultifx	==	1	then ; CHORUS
    acho1,acho2	StChorus	aFilt1, aFilt2, kfxdepth/400, kfxdepth/600, kfxrate/4, kfxrate/2
    afxL	=	aFilt1*(1-kdrywet)+acho1*kdrywet
    afxR	=	aFilt2*(1-kdrywet)+acho2*kdrywet
elseif	kmultifx	==	2	then ; FLANGER
    adelfl1	oscili	kfxdepth/10000, kfxrate/2000, 29
    adelfl2	oscili	kfxdepth/10000, kfxrate/1700, 29
    adelfl3	oscili	kfxdepth/10000, kfxrate/1400, 29
    adelfl4	oscili	kfxdepth/10000, kfxrate/1000, 29
    kfeedfl	=	.5	;feedback
    afl1	flanger	aFilt1, adelfl1, kfeedfl
    afl2	flanger	aFilt2, adelfl2, kfeedfl
    afl3	flanger	aFilt1, adelfl3, kfeedfl
    afl4	flanger	aFilt2, adelfl4, kfeedfl
    afxL	=	aFilt1*(1-kdrywet)+(afl1+afl3)*kdrywet
    afxR	=	aFilt2*(1-kdrywet)+(afl2+afl4)*kdrywet
elseif	kmultifx	==	3	then ; RINGMOD
    aringmod	oscili	kfxdepth/1000, kfxrate*200, 29, -1
    afxL	=	aFilt1*aringmod
    afxR	=	aFilt2*aringmod
elseif	kmultifx	==	4	then ; AUTOPAN
    kpan	oscili	1, kfxrate, 29
    afxL, afxR	pan2	(aFilt1+aFilt2),kpan
elseif	kmultifx	==	5	then ; RANDOM-PAN
    kpan	randomi	0, 1, kfxrate
    afxL, afxR	pan2	(aFilt1+aFilt2), kpan

elseif	kmultifx	==	6	then ; PHASER
    aphl,aphr   Phaser2x   aFilt1, aFilt2, kfxrate*.5, kfxdepth*4
    afxL	=	aFilt1*(1-kdrywet)+aphl*kdrywet
    afxR	=	aFilt2*(1-kdrywet)+aphr*kdrywet
elseif	kmultifx	==	7	then ; COMB
    acomb1	vcomb	aFilt1, kfxdepth*.01, .1+i(kfxrate)*.01, 1, 1
    acomb2	vcomb	aFilt1, kfxdepth*.01, .1+i(kfxrate)*.01, 1, 1
    afxL	=	aFilt1*(1-kdrywet)+(acomb1*kdrywet)*.5
    afxR	=	aFilt2*(1-kdrywet)+(acomb2*kdrywet)*.5
endif

adc1 dcblock2 afxL
adc2 dcblock2 afxR

aout1	clip	adc1,0,.9	
aout2	clip	adc2,0,.9

kMaster chnget "master"
outs	aout1*kADSR*kMaster,aout2*kADSR*kMaster

endin


/*
instr	reverbx

krevlvl	chnget	"reverb"
ksize	chnget	"room"
kfilt	chnget	"revfilt"

a1	inleta	"rev_outL"	;segnale ingresso da instr scanned
a2	inleta	"rev_outR"
konoff	chnget	"onoff"

al,ar	reverbsc	a1*.8,a2*.8,ksize,kfilt,sr,.2,0

asigld	dcblock	al
asigrd	dcblock ar

if	konoff	=	1	then

asigl	clip	asigld, 2, .8
asigr	clip	asigrd, 2, .8

elseif	konoff	=	0	then
	
asigl	= a1*0
asigr	= a2*0
endif

outs	asigl*krevlvl,asigr*krevlvl

endin
*/

</CsInstruments>

<CsScore>

;Initial Condition/State
f50    0 128 7 0 30 0 2 1 2 0 30 0 30 0 2 -1 2 0 30 0
f51    0 128 7 0 30 0 2 1 2 0 30 0
f52    0 128 10 1 0 1 0 1
f53    0 128 10 1 .9 .8 .7 .6 .5 .4 .3 .2
f54    0 128 10 1 0 2 1 0 0 1 0 2 1
f55    0 128 10 1 1 0 1 2 1 0 1 2 1 0 
f56  0 128 7 0 128 0
f57  0 128 7 0 64 1 64 0
f58  0 128 10 1 1 0 1 0 1 0 1 0 1 0 0 1 0 1 0 1 0 1
f59  0 128 7 0 32 1 32 0 32 1 32 0



f0 360000

</CsScore>

</CsoundSynthesizer>


