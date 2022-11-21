<CsoundSynthesizer>
<CsOptions>
-i adc -o dac
</CsOptions>
<CsInstruments>
;uses the file "fox.wav" (distributed with the Csound Manual)
sr = 22050
ksmps = 32
nchnls = 1
0dbfs = 1

cpuprc 1, 0
cpuprc 2, 100

;general values for fourier transform
gifftsiz  =         1024
gioverlap =         256
giwintyp  =         1 ;von hann window

instr 1 ;soundfile to fsig
asig      soundin   "fox.wav"
fsig      pvsanal   asig, gifftsiz, gioverlap, gifftsiz*2, giwintyp
aback     pvsynth   fsig
          outs      aback, aback
endin

instr 2 ;live input to fsig
          prints    "LIVE INPUT NOW!%n"
ain       inch      1 ;live input from channel 1

fsig      pvsanal   ain, gifftsiz, gioverlap, gifftsiz, giwintyp

arand rand 1, 10, 1
arand2 rand 1, 10, 1
arand3 rand 1, 10, 1

frand      pvsanal   arand, gifftsiz, gioverlap, gifftsiz, giwintyp
frand2      pvsanal   arand2, gifftsiz, gioverlap, gifftsiz, giwintyp
frand3      pvsanal   arand2, gifftsiz, gioverlap, gifftsiz, giwintyp

krand random 90, 110
krand=krand/100

ffilter1	pvsfilter	frand, fsig, 1, 17
ffilter2	pvsfilter	frand2, ffilter1, 1, 27
ffilter3	pvsfilter	frand3, ffilter2, 1, 18

ftps  pvscale   ffilter3, krand, 1, 1          ; transpose it keeping formants

alisten   pvsynth   ftps

 ;input of rand: amplitude, fixed seed (0.5), bit size
aNoise     rand       0.05, 10, 32
aNoise2    rand       0.05, 10, 32
aoutput=(((alisten/20)*19)+aNoise)-aNoise2

          outs      aoutput, aoutput
endin

</CsInstruments>
<CsScore>
;i 1 0 1
i 2 0 44100
</CsScore>
</CsoundSynthesizer> 
