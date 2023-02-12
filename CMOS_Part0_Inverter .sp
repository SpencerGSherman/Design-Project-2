* This is the model for a 45-nm CMOS Inverter *


.OPTION POST
.include 'W:\Digital Electronics\device_45_nm.lib'

.param len= 45nm
.param Wp= 135nm
.param Wn= 90nm

vdd vdd gnd dc 1V

*FOR TRANSIENT ANALYSIS 
*PULSE (V1 V2 	Td  Tr  Tf  PW  Period)
V1 Vin gnd PULSE (0 1 0n 0.01n 0.01n 4n 8n)


* TRANSISTOR CONNECTION

*UDN	Drain	Gate 	Source	Sub	device_type	Width	Length
M2 	Vout 	Vin 	vdd 	vdd	pmos 		W= Wp 	L= len
M1 	Vout 	Vin 	gnd 	gnd 	nmos 		W= Wn 	L= len

CL Vout gnd 3f

* MEASURING DELAY IN TRANSIENT ANALYSIS
.tran 20p 50n
.measure tpLH TRIG V(Vin) VAL=0.5V FALL=1 TARG V(Vout) VAL=0.5V RISE=1
.measure tpHL TRIG V(Vin) VAL=0.5V RISE=2 TARG V(Vout) VAL=0.5V FALL=2
.measure tp PARAM = '(tpLH + tpHL)/2'



.PRINT V(Vout) V(Vin)
.end