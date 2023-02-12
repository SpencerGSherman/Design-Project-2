* This is the model for a 45-nm CMOS Inverter *

.OPTION POST
.include 'W:\Digital Electronics\device_45_nm.lib'

.param len= 45nm
.param WIp= 135nm
.param WIn= 90nm
.param Wp= 270nm
.param Wn= 180nm

vdd vdd gnd dc 1V

*FOR TRANSIENT ANALYSIS 
*PULSE (V1 V2 	Td  Tr  Tf  PW  Period)
V1 VA gnd PULSE (1 0 0n 0.01n 0.01n 4n 8n)
V2 VB gnd PULSE (1 0 0n 0.01n 0.01n 8n 16n)


* TRANSISTOR CONNECTION

*UDN	Drain	Gate 	Source	Sub	device_type	Width	Length
MIUA 	VIA 	VA 	vdd 	vdd	pmos 		W= WIp 	L= len
M1DA 	VIA 	VA 	gnd 	gnd 	nmos 		W= WIn 	L= len

MIUB 	VIB 	VB 	vdd 	vdd	pmos 		W= WIp 	L= len
M1DB 	VIB 	VB 	gnd 	gnd 	nmos 		W= WIn 	L= len

MUNB 	P1 	VB 	vdd 	vdd	pmos 		W= Wp 	L= len
MUNA 	VY 	VA 	P1 	P1	pmos 		W= Wp 	L= len
MUIB 	P2 	VIB 	vdd 	vdd	pmos 		W= Wp 	L= len
MUIA 	VY 	VIA 	P2 	P2	pmos 		W= Wp 	L= len

MDIA 	VY 	VIA 	P3 	P3 	nmos 		W= Wn 	L= len
MDNB 	P3 	VB 	gnd 	gnd 	nmos 		W= Wn 	L= len
MDNA 	VY 	VA 	P4 	P4 	nmos 		W= Wn 	L= len
MDIB 	P4 	VIB 	gnd 	gnd 	nmos 		W= Wn 	L= len

CL VY gnd 3f

* MEASURING DELAY IN TRANSIENT ANALYSIS
.tran 20p 50n
.measure tpLH TRIG V(VA) VAL=0.5V FALL=1 TARG V(VY) VAL=0.5V RISE=1
.measure tpHL TRIG V(VA) VAL=0.5V RISE=2 TARG V(VY) VAL=0.5V FALL=2
.measure tp PARAM = '(tpLH + tpHL)/2'
.measure TRAN iavg AVG i(vdd) FROM=13e-9 TO=18e-9



.PRINT V(Vout) V(Vin)
.end