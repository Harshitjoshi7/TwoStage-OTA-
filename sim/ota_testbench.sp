* ============================================================
* Master LTspice Testbench: DC, AC, and Transient
* ============================================================

* Generic MOS Models
.model n105 NMOS (Level=1 Vto=0.3 Kp=100u Lambda=0.02)
.model p105 PMOS (Level=1 Vto=-0.3 Kp=50u Lambda=0.02)

* --- CORRECTED 2-STAGE OTA SUBCIRCUIT ---
.subckt ota_2stage ibias vdd vinp vinn vout
M6 ibias ibias vdd vdd p105 W=3u L=500n
M4 tail ibias vdd vdd p105 W=3u L=500n
M5 vout ibias vdd vdd p105 W=3u L=500n
M8 net1 vinn tail vdd p105 W=3u L=500n
M9 net2 vinp tail vdd p105 W=3u L=500n
M2 net1 net1 0 0 n105 W=3u L=500n
M3 net2 net1 0 0 n105 W=3u L=500n
M7 vout net2 0 0 n105 W=3u L=500n
C16 net2 vout 1p
.ends ota_2stage

* ============================================================
* Power Supply & Bias
* ============================================================
VDD vdd 0 1.05
* Fixed Bias: Pulls 10uA from ibias to ground to turn on PMOS mirror
IBIAS ibias 0 10u

* ============================================================
* The "Universal" Input Signal
* Includes DC offset (for .op), AC amplitude (for .ac), and Sine wave (for .tran)
* ============================================================
VINP vinp 0 SINE(0.5 10m 1Meg) AC 1 DC 0.5

* Instantiate OTA
X1 ibias vdd vinp vinn vout ota_2stage
CLOAD vout 0 2p

* ============================================================
* FEEDBACK WIRING (Choose ONE configuration below)
* ============================================================

* WIRING A: "The Huge LC Trick" (USE THIS FOR .AC BODE PLOTS AND .OP)
* Keeps DC stable but completely opens the loop for AC frequency sweeps.
L_FB vout vinn 1G
C_FB vinn 0 1G

* WIRING B: Unity Gain Buffer (USE THIS FOR .TRAN SINE WAVES)
* Connects output straight to input so the sine wave doesn't clip.
* To use this, remove the '*' on the next line, and put a '*' in front of L_FB and C_FB above.
* R_FB vout vinn 1m 

* ============================================================
* SIMULATION COMMANDS (Choose ONE to run)
* ============================================================

* 1. AC SWEEP (Bode Plot)
.ac dec 100 1 1G

* Measurement Directives
.meas AC DC_Gain_dB MAX mag(V(vout)/V(vinp))
.meas AC GBW_Hz WHEN mag(V(vout)/V(vinp))=1
.meas AC Phase_Margin PARAM ph(V(vout)/V(vinp))+180 WHEN mag(V(vout)/V(vinp))=1

.options plotwinsize=0
.end

* 2. TRANSIENT (Time-based Sine Wave)
* Setup: Use Wiring B (Unity Gain). Comment out the .ac command and uncomment this:
* .tran 1n 5u

* 3. DC OPERATING POINT (Resting Voltages & Currents)
* Setup: Works with Wiring A. Comment out .ac and uncomment this:
* .op

.options plotwinsize=0
.end
