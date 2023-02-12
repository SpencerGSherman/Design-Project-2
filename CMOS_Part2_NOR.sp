* This is the model for a 45-nm CMOS Inverter *

.OPTION POST
.include 'W:\Digital Electronics\device_45_nm.lib'

.param len= 45nm
.param Wp= 270nm
.param Wn= 90nm

vdd vdd gnd dc 1V

*FOR TRANSIENT ANALYSIS 
*PULSE (V1 V2 	Td  Tr  Tf  PW  Period)
V1 VA gnd PULSE (1 0 0n 0.01n 0.01n 4n 8n)
V2 VB gnd PULSE (1 0 0n 0.01n 0.01n 7.99n 16n)


* TRANSISTOR CONNECTION

*UDN	Drain	Gate 	Source	Sub	device_type	Width	Length
MUA 	P1 	VA 	vdd 	vdd	pmos 		W= Wp 	L= len
MUB 	VY 	VB 	P1 	P1	pmos 		W= Wp 	L= len
MDA 	VY 	VA 	gnd 	gnd 	nmos 		W= Wn 	L= len
MDB 	VY 	VB 	gnd 	gnd 	nmos 		W= Wn 	L= len

CL VY gnd 3f

* MEASURING DELAY IN TRANSIENT ANALYSIS
.tran 20p 50n
.measure tpLH TRIG V(VA) VAL=0.5V FALL=1 TARG V(VY) VAL=0.5V RISE=1
.measure tpHL TRIG V(VA) VAL=0.5V RISE=2 TARG V(VY) VAL=0.5V FALL=2
.measure tp PARAM = '(tpLH + tpHL)/2'
.measure TRAN iavg AVG i(vdd) FROM=17e-9 TO=19e-9



.PRINT V(Vout) V(Vin)
.end