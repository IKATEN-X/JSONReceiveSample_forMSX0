10 'SAVE"JSON.BAS",A
20 DEFINT A-Z:CLEAR 3000,&HB000
30 BLOAD "JSON.BIN",R
40 NL$=CHR$(13)+CHR$(10):HE$=NL$+NL$
50 PA$="msx/me/if/NET0/"
60 UR$="api.open-meteo.com"
70 RQ$="/v1/forecast?latitude=34.7565&longitude=135.054&daily=weathercode,temperature_2m_max,temperature_2m_min,precipitation_probability_max&timezone=Asia%2FTokyo&forecast_days=3"
80 '------------------- Connet
90 _IOTPUT(PA$+ "conf/addr",UR$)
100 _IOTPUT(PA$+ "conf/port",80)
110 _IOTPUT(PA$+ "connect",1)
120 '------------------- Check connect status
130 FOR I=0 TO 100:NEXT
140 _IOTGET(PA$+ "connect",S)
150 IF S<>1 THEN PRINT "Connect fail":GOTO 570
160 '------------------- Build message
170 SM$(0)="GET "+RQ$+" HTTP/1.0"+NL$
180 SM$(1)="Host: "+UR$+NL$
190 SM$(2)=NL$
200 SM$(3)=""
210 '------------------- Send request
220 PRINT NL$+"---- Send Request ----"
230 I=0
240 IF SM$(I)<>"" THEN _IOTPUT(PA$+ "msg",SM$(I)):PRINT SM$(I);:I=I+1:GOTO 240
245 '------------------- Wait receive
247 PRINT NL$+"---- Wait receive ----"
250 FOR I=0 TO 1000:NEXT
260 '------------------- Receive message
270 PRINT NL$+"---- Receive message ----"
280 AD=&H9000:MD=0:RM$=""
290 MO$=RM$:_IOTGET(PA$+ "msg",RM$):L=LEN(RM$):IF L=0 THEN 355
300 IF MD=1 THEN 330
310 PRINTRM$;:R$=MO$+RM$:HP=INSTR(R$,HE$):IF HP<>0 THEN RM$=RIGHT$(R$,LEN(R$)-HP-3):MD=1 ELSE 290
320 PRINT "---JSON DATA---"
330 PRINT RM$;:L=LEN(RM$):FOR I=1 TO L:POKE AD,ASC(MID$(RM$,I,1)):AD=AD+1:NEXT
340 GOTO 290
350 '------------------- Read JSON data
355 PRINT NL$+NL$+"---- Print result ----"
360 IF USR(&H9000)=0 THEN PRINT "Receive failed":WT=0:GOTO 560
370 WT=60
380 IF USR1("&latitude")<>0 THEN PRINT "Latitude:";USR2("&latitude")
390 IF USR1("&longitude")<>0 THEN PRINT "Longitude:";USR2("&longitude")
400 PRINT
410 IF USR1("&daily&time#0")<>0 THEN PRINT "Date:";USR2("&daily&time#0")
420 IF USR1("&daily&weathercode#0")<>0 THEN PRINT "  Weathercode:";USR2("&daily&weathercode#0")
430 IF USR1("&daily&temperature_2m_max#0")<>0 THEN PRINT "  Highest temp.:";USR2("&daily&temperature_2m_max#0")
440 IF USR1("&daily&temperature_2m_min#0")<>0 THEN PRINT "  Lowest temp.:";USR2("&daily&temperature_2m_min#0")
450 IF USR1("&daily&precipitation_probability_max#0")<>0 THEN PRINT "  PoP:";USR2("&daily&precipitation_probability_max#0");"%"
460 IF USR1("&daily&time#1")<>0 THEN PRINT "Date:";USR2("&daily&time#1")
470 IF USR1("&daily&weathercode#1")<>0 THEN PRINT "  Weathercode:";USR2("&daily&weathercode#1")
480 IF USR1("&daily&temperature_2m_max#1")<>0 THEN PRINT "  Highest temp.:";USR2("&daily&temperature_2m_max#1")
490 IF USR1("&daily&temperature_2m_min#1")<>0 THEN PRINT "  Lowest temp.:";USR2("&daily&temperature_2m_min#1")
500 IF USR1("&daily&precipitation_probability_max#1")<>0 THEN PRINT "  PoP:";USR2("&daily&precipitation_probability_max#1");"%"
510 IF USR1("&daily&time#2")<>0 THEN PRINT "Date:";USR2("&daily&time#2")
520 IF USR1("&daily&weathercode#2")<>0 THEN PRINT "  Weathercode:";USR2("&daily&weathercode#2")
530 IF USR1("&daily&temperature_2m_max#2")<>0 THEN PRINT "  Highest temp.:";USR2("&daily&temperature_2m_max#2")
540 IF USR1("&daily&temperature_2m_min#2")<>0 THEN PRINT "  Lowest temp.:";USR2("&daily&temperature_2m_min#2")
550 IF USR1("&daily&precipitation_probability_max#2")<>0 THEN PRINT "  PoP:";USR2("&daily&precipitation_probability_max#2");"%"
560 '------------------- Disconnet
570 _IOTPUT(PA$+ "connect",0)
580 '------------------- Wait
590 IF WT=0 THEN 80
600 PRINT NL$+"---- Wait (" + STR$(WT) + " sec ) ----"
610 TIME=0
620 IF TIME<WT*60 THEN GOTO 620
630 GOTO 80
