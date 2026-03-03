*Custom Compiler Version V-2023.12
*Tue Mar  3 19:49:03 2026

.global gnd!
********************************************************************************
* Library          : HARSHIT_OTA
* Cell             : ota_2stage
* View             : schematic
* View Search List : hspice hspiceD cmos.sch cmos_sch schematic veriloga
* View Stop List   : hspice hspiceD veriloga
********************************************************************************
.subckt ota_2stage ibias vdd vin+ vin- vout gnd!
* --- Stage 1: Differential Pair & Current Mirror Load ---
M8 net1 vin- tail vdd p105 w=3u l=500n
M9 net2 vin+ tail vdd p105 w=3u l=500n
M2 net1 net1 gnd! gnd! n105 w=3u l=500n
M3 net2 net1 gnd! gnd! n105 w=3u l=500n

* --- Stage 2: Common Source Output Stage ---
M7 vout net2 gnd! gnd! n105 w=3u l=500n

* --- Bias Network (Corrected Connections) ---
M6 ibias ibias vdd vdd p105 w=3u l=500n
M4 tail ibias vdd vdd p105 w=3u l=500n
M5 vout ibias vdd vdd p105 w=3u l=500n

* --- Compensation & Output Load ---
C16 net2 vout 1p
C18 vout gnd! 1p
.ends ota_2stage
