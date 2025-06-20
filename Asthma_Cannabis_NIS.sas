libname data "D:\Data_Warehouse\NIS\NIS_SAS";
libname dir  "H:\H_Data_Warehouse\CREATED\Asthma_Cannabis";

/*https://hcup-us.ahrq.gov/db/nation/nis/nisarchive.jsp*/
/****** IP - if Diag 1 thru 3 includes asthma  *****/

%macro CVT (year);
PROC IMPORT OUT=data.NIS_&year 
            DATAFILE="D:\Data_Warehouse\NIS\NIS_SPSS\NIS_&YEAR._MASTER.SAV"
            DBMS=SPSS REPLACE;
RUN;
%mend CVT;
%CVT (2010);

/*Static Parameters Start*/
%let dxA9  = '493' ;                                                                    /* Asthma       */ 
%let dxA10 = 'J45' ;                                                                    /* Asthma       */

%let dxB9  = '30430' '30431' '30433' '30520' '30521' '30522' '30523';                   /* Cannabis     */
%let dxB10 = 'F12' ;                                                                    /* Cannabis     */

/* Other sympstoms for revision */
%let R93 = '460';                                                                       /* Rhinitis     */ 
%let R94 = '4770' '4771' '4772' '4778' '4779' '4720';                                   /* Rhinitis     */ 
%let R04 = 'J309' 'J310' 'J301' 'J302' 'J305' 'J309' 'J310';                            /* Rhinitis     */
%let R05 = 'J3081' 'J3089' ;                                                            /* Rhinitis     */
%let A95 = '30000' '30001'  '30002' '30009' '30010' '30020' '30021' '30022' '30023' ;   /* Anxiety      */ 
%let A04 = 'F419' ;                                                                     /* Anxiety      */
%let P95 = '26020' '26021' '26022' '26023' '26024' '26025' '26026' ;                    /* Depression   */ 
%let P03 = 'F32' 'F33' ;                                                                /* Depression   */ 
%let P04 = 'F341' ;                                                                     /* Depression   */ 
%let C94 = '3384';                                                                      /* Chronic pain */ 
%let C95 = '33829' '33821' '33822' '33828';                                             /* Chronic pain */
%let C04 = 'G892' ;                                                                     /* Chronic pain */
%let C05 = 'G8921' 'G8922' 'G8929' ;                                                    /* Chronic pain */ 
%let T94 = '3051' ;                                                                     /* Tobacco use  */ 
%let T04 = 'Z720'  ;                                                                    /* Tobacco use  */
%let T06 = 'F17200' 'F17210' 'F17220' 'F17290' 'F17203' 'F17213' ;                      /* Tobacco use  */ 


/* STEP 1.1 -  IDENTIFY A PRIMARY DISEASE in IP */

%macro DA9 (year);

data dir.DX1_&year
(keep=Age Amonth FEMALE Dx1-Dx15 LOS RACE TOTCHG PAY1 YEAR dyear D1 D3 R1 A1 P1 C1 T1 ); 
set data.NIS_&year;

array DXA (1:3) Dx1-Dx3;
length D1 $8; D1='0';

do i=1 to 3;
if (YEAR <  2015 and                (substr(DXA{i}, 1,3) in (&dxA9)  )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(DXA{i}, 1,3) in (&dxA9)  )) or 
   (YEAR =  2015 and AMONTH >9  and (substr(DXA{i}, 1,3) in (&dxA10) )) 
    then D1='1';
end;

/* Cannabis */
array DXB (1:15) dx1-dx15;
length D3 $8; D3='0';

do i=1 to 15;
if (YEAR <  2015 and                (substr(DXB{i}, 1,5) in (&dxB9) )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(DXB{i}, 1,5) in (&dxB9)  )) or 
   (YEAR =  2015 and AMONTH >9  and (substr(DXB{i}, 1,3) in (&dxB10) )) or 
   (YEAR >= 2016 and                (substr(DXB{i}, 1,3) in (&dxB10) ))
then D3='1';
end;

/* Rhinitis  */
array RX (1:15) Dx1-Dx15;
length R1 $8; R1='0';

do i=1 to 15;
if (YEAR <  2015 and                (substr(RX{i}, 1,3) in (&R93) )) or 
   (YEAR <  2015 and                (substr(RX{i}, 1,4) in (&R94) )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(RX{i}, 1,3) in (&R93) )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(RX{i}, 1,4) in (&R94) )) or 
   (YEAR =  2015 and AMONTH >9  and (substr(RX{i}, 1,4) in (&R04) )) or
   (YEAR =  2015 and AMONTH >9  and (substr(RX{i}, 1,5) in (&R05) ))  
    then R1='1';
end;

/* Anxiety */
array AX (1:15) Dx1-Dx15;
length A1 $8; A1='0';

do i=1 to 15;
if (YEAR <  2015 and                (substr(AX{i}, 1,5) in (&A95) )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(AX{i}, 1,5) in (&A95) )) or 
   (YEAR =  2015 and AMONTH >9  and (substr(AX{i}, 1,4) in (&A04) ))
    then A1='1';
end;

/* Depression */
array PX (1:15) Dx1-Dx15;
length P1 $8; P1='0';

do i=1 to 15;
if (YEAR <  2015 and                (substr(PX{i}, 1,5) in (&P95) )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(PX{i}, 1,5) in (&P95) )) or 
   (YEAR =  2015 and AMONTH >9  and (substr(PX{i}, 1,3) in (&P03) )) or
   (YEAR =  2015 and AMONTH >9  and (substr(PX{i}, 1,4) in (&P04) ))  
    then P1='1';
end;

/* Chronic Pain */
array CX (1:15) Dx1-Dx15;
length C1 $8; C1='0';

do i=1 to 15;
if (YEAR <  2015 and                (substr(CX{i}, 1,4) in (&C94) )) or 
   (YEAR <  2015 and                (substr(CX{i}, 1,5) in (&C95) )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(CX{i}, 1,4) in (&C94) )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(CX{i}, 1,5) in (&C95) )) or 
   (YEAR =  2015 and AMONTH >9  and (substr(CX{i}, 1,4) in (&C04) )) or
   (YEAR =  2015 and AMONTH >9  and (substr(CX{i}, 1,5) in (&C05) ))  
    then C1='1';
end;

/* Tobacco Use  */
array TX (1:15) Dx1-Dx15;
length T1 $8; T1='0';

do i=1 to 15;
if (YEAR <  2015 and                (substr(TX{i}, 1,4) in (&T94) )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(TX{i}, 1,4) in (&T94) )) or 
   (YEAR =  2015 and AMONTH >9  and (substr(TX{i}, 1,4) in (&T04) )) or
   (YEAR =  2015 and AMONTH >9  and (substr(TX{i}, 1,6) in (&T06) ))  
    then T1='1';
end;

dyear=&year;

run;

%mend DA9;
%DA9 (1998);
%DA9 (1999);
%DA9 (2000);
%DA9 (2001);
%DA9 (2002);
%DA9 (2003);
%DA9 (2004);
%DA9 (2005);
%DA9 (2006);
%DA9 (2007);
%DA9 (2008);
%DA9 (2009);
%DA9 (2010);
%DA9 (2011);
%DA9 (2012);
%DA9 (2013);
%DA9 (2014);
%DA9 (2015);
/*
proc freq data=dir.dx1_1998; table D1 D3 R1 A1 D1 C1 T1; run; 
*/

%macro DA10 (year);

data dir.DX1_&year
(keep=Age Amonth FEMALE I10_DX1-I10_DX15 LOS RACE TOTCHG PAY1 YEAR DYEAR D1 D3 R1 A1 P1 C1 T1); 
set data.NIS_&year;

array DXA1 (1:3) I10_DX1-I10_DX3;
length D1 $8; D1='0';

do i=1 to 3;
if (YEAR <  2015 and                (substr(DXA1{i}, 1,3) in (&dxA9)  )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(DXA1{i}, 1,3) in (&dxA9)  )) or 
   (YEAR =  2015 and AMONTH >9  and (substr(DXA1{i}, 1,3) in (&dxA10) )) or 
   (YEAR >= 2016 and                (substr(DXA1{i}, 1,3) in (&dxA10) ))
then D1='1';
end;

/* Cannabis */
array DXB1 (1:15)  I10_DX1-I10_DX15;
length D3 $8; D3='0';

do i=1 to 15;
if (YEAR >= 2016 and (substr(DXB1{i}, 1,3) in (&dxB10) ))
then D3='1';
end;

/*  Rhinitis */
array RXO (1:15) I10_DX1-I10_DX15;
length R1 $8; R1='0';

do i=1 to 15;
if (YEAR >= 2016 and (substr(RXO{i}, 1,4) in (&R04) )) or
   (YEAR >= 2016 and (substr(RXO{i}, 1,5) in (&R05) )) 
    then R1='1';
end;

/* Anxiety */
array AXO (1:15) I10_DX1-I10_DX15;
length A1 $8; A1='0';

do i=1 to 15;
if (YEAR >= 2016 and (substr(AXO{i}, 1,3) in (&A04) ))
    then A1='1';
end;

/*  Depression */
array PXO (1:15) I10_DX1-I10_DX15;
length P1 $8; P1='0';

do i=1 to 15;
if (YEAR >= 2016 and (substr(PXO{i}, 1,4) in (&P03) )) or
   (YEAR >= 2016 and (substr(PXO{i}, 1,5) in (&P04) )) 
    then P1='1';
end;

/* Chronic Pain */
array CXO (1:15) I10_DX1-I10_DX15;
length C1 $8; C1='0';

do i=1 to 15;
if (YEAR >= 2016 and (substr(CXO{i}, 1,4) in (&C04) )) or
   (YEAR >= 2016 and (substr(CXO{i}, 1,5) in (&C05) )) 
    then C1='1';
end;

/* Tobacco Use */
array TXO (1:15) I10_DX1-I10_DX15;
length T1 $8; T1='0';

do i=1 to 15;
if (YEAR >= 2016 and (substr(TXO{i}, 1,4) in (&T04) )) or
   (YEAR >= 2016 and (substr(TXO{i}, 1,6) in (&T06) )) 
    then T1='1';
end;

dyear=&year;

run;

data dir.DX1_&year; set dir.DX1_&year;
rename I10_DX1-I10_Dx15=Dx1-Dx15;
run;


%mend DA10;
%DA10 (2016);
%DA10 (2017);
%DA10 (2018);
%DA10 (2019);
%DA10 (2020);
%DA10 (2021);

/*
proc freq data=dir.dx1_2016; table D1 D3 R1 A1 D1 C1 T1; run; 
*/

/* Cannabis */
/*
%macro DC (year);

data dir.DX1_&year; set dir.DX1_&year;

array DXC (1:15) dx1-dx15;
length D3 $8; D3='0';

do i=1 to 15;
if (dYEAR <  2015 and (substr(DXC{i}, 1,5) in (&dxB9) )) or 
   (dYEAR =  2015 and AMONTH <10 and (substr(DXC{i}, 1,5) in (&dxB9)  )) or 
   (dYEAR =  2015 and AMONTH >9  and (substr(DXC{i}, 1,3) in (&dxB10) )) or 
   (dYEAR >= 2016 and                (substr(DXC{i}, 1,3) in (&dxB10) ))
then D3='1';
end;

%mend DC;
%DC (1998);
%DC (1999);
%DC (2000);
%DC (2001);
%DC (2002);
%DC (2003);
%DC (2004);
%DC (2005);
%DC (2006);
%DC (2007);
%DC (2008);
%DC (2009);
%DC (2010);
%DC (2011);
%DC (2012);
%DC (2013);
%DC (2014);
%DC (2015);
%DC (2016);
%DC (2017);
%DC (2018);
%DC (2019);
%DC (2020);
%DC (2021);
*/

data dir.AC_R; set dir.dx1_1998-dir.dx1_2021; run;
data dir.AC_R; set dir.AC_R;
length yrmo 6;
length agegrp $8;
yrmo=dyear*100+amonth;
if age<20 then agegrp ='under 20';
else if age < 45 then agegrp ='20-44';
else if age < 65 then agegrp ='45-64';
else if age > 64 then agegrp ='65 up';
if R1='1' or A1='1' or P1='1' or C1='1' or T1='1' then CO='1'; else CO='0';
/*if R1 in ('1') or A1 in ('1') or P1 in ('1') or C1 in ('1') or T1 in ('1') then CO ='1;*/

where 0< amonth<13 and 1997 < year < 2022;
run;


/* All ages */
proc sql; create table dir.ALL as select

yrmo
,count(*) as CT
,sum(D1='1') as CT_A
,sum(D1='1' and D3='1') as CT_C
,sum(D1='1' and D3='1' and CO='1') as CT3
,sum(D1='1' and D3='1')/sum(D1='1')*100000 as R_C
,sum(CO='1' and D1='1' and D3='1')/sum(D1='1')*100000 as R_CC
,sum(D1='0' and D3='1')/count(*)*100000 as NR_C           /* Cannabis / All  */
,sum(R1='1' or A1='1' or P1='1' or C1='1' or T1='1') as CT_CC
,sum((R1='1' or A1='1' or P1='1' or C1='1' or T1='1') and D1='1' and D3='1') as CCC1
,sum((R1='1' or A1='1' or P1='1' or C1='1' or T1='1') and D1='1' and D3='1')/sum(D1='1')*100000 as R_CC

/* Children only: <19 */
,sum(case when age <20                                         then 1 else 0 end)                                                             as CT1
,sum(case when age < 20 and D1='1'                             then 1 else 0 end)                                                             as CT_A1
,sum(case when age < 20 and D1='1' and D3='1'                  then 1 else 0 end)                                                             as CT_C1
,sum(case when age < 20 and D1='1' and D3='1'                  then 1 else 0 end)/sum(case when age < 20 and D1='1' then 1 else 0 end)*100000 as R_C1
,sum(case when age < 20 and CO='1'                             then 1 else 0 end)                                                             as CT_C1
,sum(case when age < 20 and D1='1' and D3='1' and CO='1'       then 1 else 0 end)/sum(case when age < 20 and D1='1' then 1 else 0 end)*100000 as R_CC1
,sum(case when age < 20 and D1='0' and D3='1'                  then 1 else 0 end)/sum(case when age < 20            then 1 else 0 end)*100000 as NR_C1      

/* Ages: 19 - 35 -> 20 - 44 */
,sum(case when 20 <= age < 45                                  then 1 else 0 end)                                                                   as CT2
,sum(case when 20 <= age < 45 and D1='1'                       then 1 else 0 end)                                                                   as CT_A2
,sum(case when 20 <= age < 45 and D1='1' and D3='1'            then 1 else 0 end)                                                                   as CT_C2
,sum(case when 20 <= age < 45 and D1='1' and D3='1'            then 1 else 0 end)/sum(case when 20 <= age < 45 and D1='1' then 1 else 0 end)*100000 as R_C2
,sum(case when 20 <= age < 45 and CO='1'                       then 1 else 0 end)                                                                   as CT_C2
,sum(case when 20 <= age < 45 and D1='1' and D3='1' and CO='1' then 1 else 0 end)/sum(case when 20 <= age < 45 and D1='1' then 1 else 0 end)*100000 as R_CC2
,sum(case when 20 <= age < 45 and D1='0' and D3='1'            then 1 else 0 end)/sum(case when 20 <= age < 45            then 1 else 0 end)*100000 as NR_C2      

/* Ages: 45-64 */
,sum(case when 45 <= age < 65                                  then 1 else 0 end)                                                                   as CT3
,sum(case when 45 <= age < 65 and D1='1'                       then 1 else 0 end)                                                                   as CT_A3
,sum(case when 45 <= age < 65 and D1='1' and D3='1'            then 1 else 0 end)                                                                   as CT_C3
,sum(case when 45 <= age < 65 and D1='1' and D3='1'            then 1 else 0 end)/sum(case when 45 <= age < 65 and D1='1' then 1 else 0 end)*100000 as R_C3
,sum(case when 45 <= age < 65 and CO='1'                       then 1 else 0 end)                                                                   as CT_C3
,sum(case when 45 <= age < 65 and D1='1' and D3='1' and CO='1' then 1 else 0 end)/sum(case when 45 <= age < 65 and D1='1' then 1 else 0 end)*100000 as R_CC3
,sum(case when 45 <= age < 65 and D1='0' and D3='1'            then 1 else 0 end)/sum(case when 45 <= age < 65            then 1 else 0 end)*100000 as NR_C3     

/* Ages: 65+ */
,sum(case when 65 <= age                                       then 1 else 0 end)                                                                   as CT4
,sum(case when 65 <= age  and D1='1'                           then 1 else 0 end)                                                                   as CT_A4
,sum(case when 65 <= age  and D1='1' and D3='1'                then 1 else 0 end)                                                                   as CT_C4
,sum(case when 65 <= age  and D1='1' and D3='1'                then 1 else 0 end)/sum(case when 65 <= age and D1='1'      then 1 else 0 end)*100000 as R_C4
,sum(case when 65 <= age  and CO='1'                           then 1 else 0 end)                                                                   as CT_C4
,sum(case when 65 <= age  and D1='1' and D3='1' and CO='1'     then 1 else 0 end)/sum(case when 65 <= age and D1='1'      then 1 else 0 end)*100000 as R_CC4
,sum(case when 65 <= age  and D1='0' and D3='1'                then 1 else 0 end)/sum(case when 65 <= age                 then 1 else 0 end)*100000 as NR_C4     

/* By race */
,sum(D1='1' and D3='1' and CO='1' and race=1)/sum(D1='1' and race=1)*100000 as R_CCW
,sum(D1='1' and D3='1' and CO='1' and race=2)/sum(D1='1' and race=2)*100000 as R_CCB
,sum(D1='1' and D3='1' and CO='1' and race=3)/sum(D1='1' and race=3)*100000 as R_CCH

from dir.ac_r
group by yrmo;
quit;


/******************** EXPORT DATA *********************/

proc EXPORT data= dir.ALL
	outfile = 
	DBMS=xlsx REPLACE;
	sheet="ALL";
run;

proc import datafile=
     out=dir.ALL;
     sheet='ALL';
     getnames=YES;
run;

/* CL - Cannabis Legalization */
proc import datafile=
     out=dir.CL;
     sheet='CL';
     getnames=YES;
run;


/* Time data */

%macro Time (var);

data &var;
  set dir.&var; 
  format t yymmn6.; /* Define the desired time format */
  t = input(put(yrmo, 6.), yymmn6.); /* Convert the old_time variable */
 if yrmo <201201 then YD=0;  else if yrmo >=201201 then YD=1;
 if yrmo <201301 then YD1=0; else if yrmo >=201301 then YD1=1;
 if yrmo <201401 then YD2=0; else if yrmo >=201401 then YD2=1;
 if yrmo <201501 then YD3=0; else if yrmo >=201501 then YD3=1;
 drop yrmo;
run;

proc sort data=&var;
  by t;
run;

%mend Time;
%time (ACR);
%time (ac_age);
%time (ALL);


/* Merge MCL/RCL variables */

data CL;
  set dir.CL; 
  format t yymmn6.; /* Define the desired time format */
  t = input(put(t, 6.), yymmn6.); /* Convert the old_time variable */
  pop=pctpop*100;
run;


proc sql; create table dir.ALL_CL as select
a.*,
b.*

from ALL     as a
left join CL as b on a.t=b.t;
run;

/* RCL %POP - FINAL MODELS 4/10/25 */

%MACRO AR (VAR);
proc arima data=dir.ALL_CL; 
   identify var=&VAR(0) stationarity=(adf) crosscorr=(POP);
   estimate p=1 q=0 input=(POP);
run;
%MEND AR;
%AR (R_CC1); /* (1,0,1) - 3683  (1,0,0) 3694 */
%AR (R_CC2); /* (1,0,0) - (2,0) 4034 (1.1) not 3984 (1,0) 4090 (2.1) no */
%AR (R_CC3); /* (1,0,0) - (2.0) 3855 (1,1) no (1,0) 3951 */
%AR (R_CC4);
%AR (R_CCW); /* (1,0,0) - 27.0 (1,0) 3718 (2,0) not (1,1) not (2,1) not */
%AR (R_CCB); /* (1,0,0) -41.1 (1,0) 4085 (2,0) ? (1,1) not (2,1) not  */
%AR (R_CCH); /* (1,0,0) -28.5 (1,0) 3971 (2,0) 3942 (1,1) not (2,1) 3904 */




proc sort data=dir.ac_r; by race; run;

data test(keep=race ca); set dir.ac_r;
if d1 in ('1') and d3 in ('1') then ca='1'; else ca='0';
run;

proc freq data=test; tables ca*race; run;





/***************************** By Age group ****************************/

/* All ages */
proc sql; create table data.ac_rA as select

yrmo,
count(*) as CT,
sum(D1='1') as CT_A,
sum(D1='1' and D3='1') as CT_C,
sum(D1='1' and D3='1' and CO='1') as CT3,
sum(D1='1' and D3='1')/sum(D1='1')*100000 as R_C,
sum(CO='1' and D1='1' and D3='1')/sum(D1='1')*100000 as R_CC,
sum(D1='0' and D3='1')/count(*)*100000 as NR_C,           /* Cannabis / All  */
sum(R1='1' or A1='1' or P1='1' or C1='1' or T1='1') as CT_CC,
sum((R1='1' or A1='1' or P1='1' or C1='1' or T1='1') and D1='1' and D3='1') as CCC1,
sum((R1='1' or A1='1' or P1='1' or C1='1' or T1='1') and D1='1' and D3='1')/sum(D1='1')*100000 as R_CC

from dir.ac_r
group by yrmo;
quit;

/* Children only: <19 */

/* previously 
0-18/ 19-35/ 36-54/ 55-64/ 65 up 
*/

proc sql; create table dir.AC_r1 as select

 yrmo
,sum(case when age <20                                   then 1 else 0 end)                                                             as CT1
,sum(case when age < 20 and D1='1'                       then 1 else 0 end)                                                             as CT_A1
,sum(case when age < 20 and D1='1' and D3='1'            then 1 else 0 end)                                                             as CT_C1
,sum(case when age < 20 and D1='1' and D3='1'            then 1 else 0 end)/sum(case when age < 20 and D1='1' then 1 else 0 end)*100000 as R_C1
,sum(case when age < 20 and CO='1'                       then 1 else 0 end)                                                             as CT_C1
,sum(case when age < 20 and D1='1' and D3='1' and CO='1' then 1 else 0 end)/sum(case when age < 20 and D1='1' then 1 else 0 end)*100000 as R_CC1
,sum(case when age < 20 and D1='0' and D3='1'            then 1 else 0 end)/sum(case when age < 20            then 1 else 0 end)*100000 as NR_C1      

from dir.ac_r
group by yrmo;
quit;

/* Ages: 19 - 35 -> 20 - 44 */
proc sql; create table dir.AC_r2 as select

 yrmo
,sum(case when 20 <= age < 45                                  then 1 else 0 end)                                                                   as CT2
,sum(case when 20 <= age < 45 and D1='1'                       then 1 else 0 end)                                                                   as CT_A2
,sum(case when 20 <= age < 45 and D1='1' and D3='1'            then 1 else 0 end)                                                                   as CT_C2
,sum(case when 20 <= age < 45 and D1='1' and D3='1'            then 1 else 0 end)/sum(case when 20 <= age < 45 and D1='1' then 1 else 0 end)*100000 as R_C2
,sum(case when 20 <= age < 45 and CO='1'                       then 1 else 0 end)                                                                   as CT_C2
,sum(case when 20 <= age < 45 and D1='1' and D3='1' and CO='1' then 1 else 0 end)/sum(case when 20 <= age < 45 and D1='1' then 1 else 0 end)*100000 as R_CC2
,sum(case when 20 <= age < 45 and D1='0' and D3='1'            then 1 else 0 end)/sum(case when 20 <= age < 45            then 1 else 0 end)*100000 as NR_C2      

from dir.ac_r
group by yrmo;
quit;


/* Ages: 45-64 */
proc sql; create table dir.AC_r3 as select

 yrmo
,sum(case when 45 <= age < 65                                  then 1 else 0 end)                                                                   as CT3
,sum(case when 45 <= age < 65 and D1='1'                       then 1 else 0 end)                                                                   as CT_A3
,sum(case when 45 <= age < 65 and D1='1' and D3='1'            then 1 else 0 end)                                                                   as CT_C3
,sum(case when 45 <= age < 65 and D1='1' and D3='1'            then 1 else 0 end)/sum(case when 45 <= age < 65 and D1='1' then 1 else 0 end)*100000 as R_C3
,sum(case when 45 <= age < 65 and CO='1'                       then 1 else 0 end)                                                                   as CT_C3
,sum(case when 45 <= age < 65 and D1='1' and D3='1' and CO='1' then 1 else 0 end)/sum(case when 45 <= age < 65 and D1='1' then 1 else 0 end)*100000 as R_CC3
,sum(case when 45 <= age < 65 and D1='0' and D3='1'            then 1 else 0 end)/sum(case when 45 <= age < 65            then 1 else 0 end)*100000 as NR_C3     

from dir.ac_r
group by yrmo;
quit;

/* Ages: 65 up */
proc sql; create table dir.AC_r4 as select

 yrmo
,sum(case when 65 <= age                                   then 1 else 0 end)                                                              as CT4
,sum(case when 65 <= age  and D1='1'                       then 1 else 0 end)                                                              as CT_A4
,sum(case when 65 <= age  and D1='1' and D3='1'            then 1 else 0 end)                                                              as CT_C4
,sum(case when 65 <= age  and D1='1' and D3='1'            then 1 else 0 end)/sum(case when 65 <= age and D1='1' then 1 else 0 end)*100000 as R_C4
,sum(case when 65 <= age  and CO='1'                       then 1 else 0 end)                                                              as CT_C4
,sum(case when 65 <= age  and D1='1' and D3='1' and CO='1' then 1 else 0 end)/sum(case when 65 <= age and D1='1' then 1 else 0 end)*100000 as R_CC4
,sum(case when 65 <= age  and D1='0' and D3='1'            then 1 else 0 end)/sum(case when 65 <= age            then 1 else 0 end)*100000 as NR_C4     

from dir.ac_r
group by yrmo;
quit;

/* By age group */
proc sql; create table dir.AC_r as select

a.*,
b.R_CC1,
c.R_CC2,
d.R_CC3,
e.R_CC4

from      dir.ac_ra as a
left join dir.ac_r1 as b on a.yrmo=b.yrmo
left join dir.ac_r2 as c on a.yrmo=c.yrmo
left join dir.ac_r3 as d on a.yrmo=d.yrmo
left join dir.ac_r4 as e on a.yrmo=e.yrmo;
/*left join data.ac_cac5 as f on a.yrmo=f.yrmo;*/

quit;




/******************** EXPORT DATA *********************/

proc EXPORT data= dir.ac_r
	outfile = 
	DBMS=xlsx REPLACE;
	sheet="ACR";
run;

proc import datafile=
     out=dir.ACR;
     sheet='ACR';
     getnames=YES;
run;

/* By age group */
proc EXPORT data= data.ac_cac_age
	outfile =
	DBMS=xlsx REPLACE;
	sheet="AC_AGE2";
run;

proc import datafile=
     out=dir.AC_Age;
     sheet='AC_AGE2';
     getnames=YES;
run;

/* CL - Cannabis Legalization */
proc import datafile=
     out=dir.CL;
     sheet='CL';
     getnames=YES;
run;


/* Time data */

%macro Time (var);

data &var;
  set dir.&var; 
  format t yymmn6.; /* Define the desired time format */
  t = input(put(yrmo, 6.), yymmn6.); /* Convert the old_time variable */
 if yrmo <201201 then YD=0;  else if yrmo >=201201 then YD=1;
 if yrmo <201301 then YD1=0; else if yrmo >=201301 then YD1=1;
 if yrmo <201401 then YD2=0; else if yrmo >=201401 then YD2=1;
 if yrmo <201501 then YD3=0; else if yrmo >=201501 then YD3=1;
 drop yrmo;
run;

proc sort data=&var;
  by t;
run;

%mend Time;
%time (ACR);
%time (ac_age);


/* Merge MCL/RCL variables */

data CL;
  set dir.CL; 
  format t yymmn6.; /* Define the desired time format */
  t = input(put(t, 6.), yymmn6.); /* Convert the old_time variable */
  pop=pctpop*100;
run;


proc sql; create table ACR_CL as select
a.*,
b.*

from ACR     as a
left join CL as b on a.t=b.t;
run;


/* Exponential smoothing */

%MACRO ES (AGE);

proc esm data=cl_age outfor=forecasted&AGE lead=120;
    id t interval=month; /* Change interval as needed: day, week, year */
    forecast R_C&AGE / model=winters; /* Other options: simple, damptrend, winters */
	where R_C&AGE not in (0);
run;

%MEND (ES);
%ES (1);
%ES (2);
%ES (3);
%ES (4);

/* Excel file for ggplot */
proc sql; create table fc_all as select

a.t,
a.actual as A1,
a.predict as P1,
b.actual as A2,
b.predict as P2,
c.actual as A3,
c.predict as P3,
d.actual as A4,
d.predict as P4

from forecasted1 as a 
left join forecasted2 as b on a.t=b.t
left join forecasted3 as c on a.t=c.t
left join forecasted4 as d on a.t=d.t;
quit;


/************ ITS ****************/

Proc autoreg data=cl_age;
Model R_C = t YD2 /Method=ml nlag=5 backstep dwpob;
Output out=out p=fitted;
Run;

/* YD2: sig. */


/******Non-Linear regression******/

/* Not working */
proc nlin data=cl_age;
    parameters a=265 b=0.1;
    model R_C = a*exp(b*t); /* Exponential growth model */
    output out=forecasted p=predicted;
run;

/*** Log Transformation -> Estimating Growth rate ***/
data log_transform;
    set ac_age;
    logRC=log(R_C); /* Apply log transformation */
run;

proc reg data=log_transform;
    model logRC = t;
    output out=estimates p=log_pred;
run;


/************ ARIMA(X) ****************/

/** Unit Root test**/
proc arima data=cl_age; /* No unit root -> d=0*/ 
   identify var=R_C(0) stationarity=(adf=(0,1,2)); 
run;

proc arima data=cl_age; /* No unit root -> d=0*/ 
   identify var=R_C3(0) stationarity=(adf=(0,1,2)); 
run;

proc arima data=cl_age; 
   identify var=R_C5(0) stationarity=(adf) crosscorr=(YD3);
   estimate p=1 q=0 input=(YD3);
run;

/* Interruption 
 
R_C: Insig
R_C1: YD, YD1, YD2 YD3
R_C2: YD1, YD2 
R_C3: YD, YD1, YD2 YD3
R_C4: YD, YD1, YD2 YD3
R_C5: YD, YD1, YD2 YD3

*/

/* MCL/RCL/TCL */

proc arima data=cl_age; 
   identify var=R_C5(0) stationarity=(adf) crosscorr=(RCL);
   estimate p=2 q=0 input=(RCL);
run;


/* FINAL MODELS (RCL)

R_C (2,0) Insig
R_C1 (2,0) Sig
R_C2 (2,0) Sig
R_C3 (1,0) Sig
R_C4 (2,0) Sig
R_C5 (2,0) Sig


*/


/* 
Individually in parantheis 
R_C: MCL TCL      ( )
R_C1: TCL         (MCL RCL TCL)
R_C2: TCL         (MCL RCL TCL)
R_C3: TCL         (MCL RCL TCL)
R_C4: MCL RCL TCL (MCL RCL TCL)
R_C5: TCL         (MCL RCL TCL)


*/

/* RCL %POP - FINAL MODELS 4/9/25 */

%MACRO AR (VAR);

proc arima data=ACR_CL; 
   identify var=&VAR(0) stationarity=(adf) crosscorr=(POP);
   estimate p=1 q=0 input=(POP);
run;

%MEND AR;
%AR (R_CC1);
%AR (R_CC2);
%AR (R_CC3);
%AR (R_CC4);


/*****************************************************************************/
/******************************* By race *************************************/
/*****************************************************************************/

data dir.AC_WB; set dir.AC_R;
if race in (1,2);
run;

/***************************** By Age group ****************************/


/* Children only: <19 */

/* previously 
0-18/ 19-35/ 36-54/ 55-64/ 65 up 
*/

proc sql; create table dir.AC_r1 as select

 yrmo
,sum(case when age <20                                   then 1 else 0 end)                                                             as CT1
,sum(case when age < 20 and D1='1'                       then 1 else 0 end)                                                             as CT_A1
,sum(case when age < 20 and D1='1' and D3='1'            then 1 else 0 end)                                                             as CT_C1
,sum(case when age < 20 and D1='1' and D3='1'            then 1 else 0 end)/sum(case when age < 20 and D1='1' then 1 else 0 end)*100000 as R_C1
,sum(case when age < 20 and CO='1'                       then 1 else 0 end)                                                             as CT_C1
,sum(case when age < 20 and D1='1' and D3='1' and CO='1' then 1 else 0 end)/sum(case when age < 20 and D1='1' then 1 else 0 end)*100000 as R_CC1
,sum(case when age < 20 and D1='0' and D3='1'            then 1 else 0 end)/sum(case when age < 20            then 1 else 0 end)*100000 as NR_C1      

from dir.ac_r
group by yrmo;
quit;

/* Ages: 19 - 35 -> 20 - 44 */
proc sql; create table dir.AC_r2 as select

 yrmo
,sum(case when 20 <= age < 45                                  then 1 else 0 end)                                                                   as CT2
,sum(case when 20 <= age < 45 and D1='1'                       then 1 else 0 end)                                                                   as CT_A2
,sum(case when 20 <= age < 45 and D1='1' and D3='1'            then 1 else 0 end)                                                                   as CT_C2
,sum(case when 20 <= age < 45 and D1='1' and D3='1'            then 1 else 0 end)/sum(case when 20 <= age < 45 and D1='1' then 1 else 0 end)*100000 as R_C2
,sum(case when 20 <= age < 45 and CO='1'                       then 1 else 0 end)                                                                   as CT_C2
,sum(case when 20 <= age < 45 and D1='1' and D3='1' and CO='1' then 1 else 0 end)/sum(case when 20 <= age < 45 and D1='1' then 1 else 0 end)*100000 as R_CC2
,sum(case when 20 <= age < 45 and D1='0' and D3='1'            then 1 else 0 end)/sum(case when 20 <= age < 45            then 1 else 0 end)*100000 as NR_C2      

from dir.ac_r
group by yrmo;
quit;


/* Ages: 45-64 */
proc sql; create table dir.AC_r3 as select

 yrmo
,sum(case when 45 <= age < 65                                  then 1 else 0 end)                                                                   as CT3
,sum(case when 45 <= age < 65 and D1='1'                       then 1 else 0 end)                                                                   as CT_A3
,sum(case when 45 <= age < 65 and D1='1' and D3='1'            then 1 else 0 end)                                                                   as CT_C3
,sum(case when 45 <= age < 65 and D1='1' and D3='1'            then 1 else 0 end)/sum(case when 45 <= age < 65 and D1='1' then 1 else 0 end)*100000 as R_C3
,sum(case when 45 <= age < 65 and CO='1'                       then 1 else 0 end)                                                                   as CT_C3
,sum(case when 45 <= age < 65 and D1='1' and D3='1' and CO='1' then 1 else 0 end)/sum(case when 45 <= age < 65 and D1='1' then 1 else 0 end)*100000 as R_CC3
,sum(case when 45 <= age < 65 and D1='0' and D3='1'            then 1 else 0 end)/sum(case when 45 <= age < 65            then 1 else 0 end)*100000 as NR_C3     

from dir.ac_r
group by yrmo;
quit;

/* Ages: 65 up */
proc sql; create table dir.AC_r4 as select

 yrmo
,sum(case when 65 <= age                                   then 1 else 0 end)                                                              as CT4
,sum(case when 65 <= age  and D1='1'                       then 1 else 0 end)                                                              as CT_A4
,sum(case when 65 <= age  and D1='1' and D3='1'            then 1 else 0 end)                                                              as CT_C4
,sum(case when 65 <= age  and D1='1' and D3='1'            then 1 else 0 end)/sum(case when 65 <= age and D1='1' then 1 else 0 end)*100000 as R_C4
,sum(case when 65 <= age  and CO='1'                       then 1 else 0 end)                                                              as CT_C4
,sum(case when 65 <= age  and D1='1' and D3='1' and CO='1' then 1 else 0 end)/sum(case when 65 <= age and D1='1' then 1 else 0 end)*100000 as R_CC4
,sum(case when 65 <= age  and D1='0' and D3='1'            then 1 else 0 end)/sum(case when 65 <= age            then 1 else 0 end)*100000 as NR_C4     

from dir.ac_r
group by yrmo;
quit;

/* By age group */
proc sql; create table dir.AC_r as select

a.*,
b.R_CC1,
c.R_CC2,
d.R_CC3,
e.R_CC4

from      dir.ac_ra as a
left join dir.ac_r1 as b on a.yrmo=b.yrmo
left join dir.ac_r2 as c on a.yrmo=c.yrmo
left join dir.ac_r3 as d on a.yrmo=d.yrmo
left join dir.ac_r4 as e on a.yrmo=e.yrmo;
/*left join data.ac_cac5 as f on a.yrmo=f.yrmo;*/

quit;




/******************** EXPORT DATA *********************/

proc EXPORT data= dir.ac_r
	outfile = 
	DBMS=xlsx REPLACE;
	sheet="ACR";
run;

proc import datafile=
     out=dir.ACR;
     sheet='ACR';
     getnames=YES;
run;

/* By age group */
proc EXPORT data= data.ac_cac_age
	outfile =
	DBMS=xlsx REPLACE;
	sheet="AC_AGE2";
run;

proc import datafile=
     out=dir.AC_Age;
     sheet='AC_AGE2';
     getnames=YES;
run;

/* CL - Cannabis Legalization */
proc import datafile=
     out=dir.CL;
     sheet='CL';
     getnames=YES;
run;


/* Time data */

%macro Time (var);

data &var;
  set dir.&var; 
  format t yymmn6.; /* Define the desired time format */
  t = input(put(yrmo, 6.), yymmn6.); /* Convert the old_time variable */
 if yrmo <201201 then YD=0;  else if yrmo >=201201 then YD=1;
 if yrmo <201301 then YD1=0; else if yrmo >=201301 then YD1=1;
 if yrmo <201401 then YD2=0; else if yrmo >=201401 then YD2=1;
 if yrmo <201501 then YD3=0; else if yrmo >=201501 then YD3=1;
 drop yrmo;
run;

proc sort data=&var;
  by t;
run;

%mend Time;
%time (ACR);
%time (ac_age);


/* Merge MCL/RCL variables */

data CL;
  set dir.CL; 
  format t yymmn6.; /* Define the desired time format */
  t = input(put(t, 6.), yymmn6.); /* Convert the old_time variable */
  pop=pctpop*100;
run;


proc sql; create table ACR_CL as select
a.*,
b.*

from ACR     as a
left join CL as b on a.t=b.t;
run;


/* Exponential smoothing */

%MACRO ES (AGE);

proc esm data=cl_age outfor=forecasted&AGE lead=120;
    id t interval=month; /* Change interval as needed: day, week, year */
    forecast R_C&AGE / model=winters; /* Other options: simple, damptrend, winters */
	where R_C&AGE not in (0);
run;

%MEND (ES);
%ES (1);
%ES (2);
%ES (3);
%ES (4);

/* Excel file for ggplot */
proc sql; create table fc_all as select

a.t,
a.actual as A1,
a.predict as P1,
b.actual as A2,
b.predict as P2,
c.actual as A3,
c.predict as P3,
d.actual as A4,
d.predict as P4

from forecasted1 as a 
left join forecasted2 as b on a.t=b.t
left join forecasted3 as c on a.t=c.t
left join forecasted4 as d on a.t=d.t;
quit;


/************ ITS ****************/

Proc autoreg data=cl_age;
Model R_C = t YD2 /Method=ml nlag=5 backstep dwpob;
Output out=out p=fitted;
Run;

/* YD2: sig. */


/******Non-Linear regression******/

/* Not working */
proc nlin data=cl_age;
    parameters a=265 b=0.1;
    model R_C = a*exp(b*t); /* Exponential growth model */
    output out=forecasted p=predicted;
run;

/*** Log Transformation -> Estimating Growth rate ***/
data log_transform;
    set ac_age;
    logRC=log(R_C); /* Apply log transformation */
run;

proc reg data=log_transform;
    model logRC = t;
    output out=estimates p=log_pred;
run;


/************ ARIMA(X) ****************/

/** Unit Root test**/
proc arima data=cl_age; /* No unit root -> d=0*/ 
   identify var=R_C(0) stationarity=(adf=(0,1,2)); 
run;

proc arima data=cl_age; /* No unit root -> d=0*/ 
   identify var=R_C3(0) stationarity=(adf=(0,1,2)); 
run;

proc arima data=cl_age; 
   identify var=R_C5(0) stationarity=(adf) crosscorr=(YD3);
   estimate p=1 q=0 input=(YD3);
run;

/* Interruption 
 
R_C: Insig
R_C1: YD, YD1, YD2 YD3
R_C2: YD1, YD2 
R_C3: YD, YD1, YD2 YD3
R_C4: YD, YD1, YD2 YD3
R_C5: YD, YD1, YD2 YD3

*/

/* MCL/RCL/TCL */

proc arima data=cl_age; 
   identify var=R_C5(0) stationarity=(adf) crosscorr=(RCL);
   estimate p=2 q=0 input=(RCL);
run;


/* FINAL MODELS (RCL)

R_C (2,0) Insig
R_C1 (2,0) Sig
R_C2 (2,0) Sig
R_C3 (1,0) Sig
R_C4 (2,0) Sig
R_C5 (2,0) Sig


*/


/* 
Individually in parantheis 
R_C: MCL TCL      ( )
R_C1: TCL         (MCL RCL TCL)
R_C2: TCL         (MCL RCL TCL)
R_C3: TCL         (MCL RCL TCL)
R_C4: MCL RCL TCL (MCL RCL TCL)
R_C5: TCL         (MCL RCL TCL)


*/

/* RCL %POP - FINAL MODELS 4/9/25 */

%MACRO AR (VAR);

proc arima data=ACR_CL; 
   identify var=&VAR(0) stationarity=(adf) crosscorr=(POP);
   estimate p=1 q=0 input=(POP);
run;

%MEND AR;
%AR (R_CC1);
%AR (R_CC2);
%AR (R_CC3);
%AR (R_CC4);


/* FINAL MODELS (RCL)

** 4 age groups
R_C1 (1,1) Sig - No seasonality, White noise (AIC=3929)
R_C2 (1,1) Sig - seasonality, White noise
R_C3 (1,0) Sig - Seasonality, White noise 
R_C4 (2,0) Sig - Seasonality, White noise

** 5 age groups
R_C (2,0) Insig
R_C1 (2,0) Sig - No seasonality, White noise (AIC=3932)
R_C2 (1,1) Sig - No seasonality, White noise
R_C3 (1,0) Sig - Seasonality, White noise 
R_C4 (2,0) Sig - Seasonality, White noise
R_C5 (2,0) InSig - Seasonality, White noise
R_C5 (1,1) Sig - Higher AIC

*/


/* RCL %POP - FINAL MODELS 2/25/25 */

proc arima data=cl_age; 
   identify var=R_C3(0) stationarity=(adf) crosscorr=(POP);
   estimate p=1 q=0 input=(POP);
run;

/* FINAL MODELS (RCL)

** 4 age groups
R_C1 (1,1) Sig - No seasonality, White noise (AIC=3929)
R_C2 (1,1) Sig - seasonality, White noise
R_C3 (1,0) Sig - Seasonality, White noise 
R_C4 (2,0) Sig - Seasonality, White noise

** 5 age groups
R_C (2,0) Insig
R_C1 (2,0) Sig - No seasonality, White noise (AIC=3932)
R_C2 (1,1) Sig - No seasonality, White noise
R_C3 (1,0) Sig - Seasonality, White noise 
R_C4 (2,0) Sig - Seasonality, White noise
R_C5 (2,0) InSig - Seasonality, White noise
R_C5 (1,1) Sig - Higher AIC

*/

/*****************************************************************************/
/******************************* Table 1 *************************************/
/*****************************************************************************/

/* Use  dir.AC_All */
data dir.table1; set dir.ac_all; 
if D1 in ('1') and D3 in ('1') and female in (0,1); run;

proc freq data=dir.table1; table agegrp female race pay1; run;

proc freq data=dir.table1; table female race pay1; where age <20       and dyear in (1998, 1999, 2000, 2001, 2002, 2003); run;
proc freq data=dir.table1; table female race pay1; where 20 <= age <45 and dyear in (1998, 1999, 2000, 2001, 2002, 2003); run;
proc freq data=dir.table1; table female race pay1; where 45 <= age <64 and dyear in (1998, 1999, 2000, 2001, 2002, 2003); run;
proc freq data=dir.table1; table female race pay1; where 65 <= age     and dyear in (1998, 1999, 2000, 2001, 2002, 2003); run;

proc freq data=dir.table1; table female race pay1; where age <20       and dyear in (2004, 2005, 2006, 2007, 2008, 2009); run;
proc freq data=dir.table1; table female race pay1; where 20 <= age <45 and dyear in (2004, 2005, 2006, 2007, 2008, 2009); run;
proc freq data=dir.table1; table female race pay1; where 45 <= age <64 and dyear in (2004, 2005, 2006, 2007, 2008, 2009); run;
proc freq data=dir.table1; table female race pay1; where 65 <= age     and dyear in (2004, 2005, 2006, 2007, 2008, 2009); run;

proc freq data=dir.table1; table female race pay1; where age <20       and dyear in (2010, 2011, 2012, 2013, 2014, 2015); run;
proc freq data=dir.table1; table female race pay1; where 20 <= age <45 and dyear in (2010, 2011, 2012, 2013, 2014, 2015); run;
proc freq data=dir.table1; table female race pay1; where 45 <= age <64 and dyear in (2010, 2011, 2012, 2013, 2014, 2015); run;
proc freq data=dir.table1; table female race pay1; where 65 <= age     and dyear in (2010, 2011, 2012, 2013, 2014, 2015); run;

proc freq data=dir.table1; table female race pay1; where age <20       and dyear in (2016, 2017, 2018, 2019, 2020, 2021); run;
proc freq data=dir.table1; table female race pay1; where 20 <= age <45 and dyear in (2016, 2017, 2018, 2019, 2020, 2021); run;
proc freq data=dir.table1; table female race pay1; where 45 <= age <64 and dyear in (2016, 2017, 2018, 2019, 2020, 2021); run;
proc freq data=dir.table1; table female race pay1; where 65 <= age     and dyear in (2016, 2017, 2018, 2019, 2020, 2021); run;


proc means data=table1; var los; where age <19       and dyear in (1998, 1999, 2000, 2001, 2002, 2003); run;
proc means data=table1; var los; where 19 <= age <36 and dyear in (1998, 1999, 2000, 2001, 2002, 2003); run;
proc means data=table1; var los; where 36 <= age <55 and dyear in (1998, 1999, 2000, 2001, 2002, 2003); run;
proc means data=table1; var los; where 65 <= age     and dyear in (1998, 1999, 2000, 2001, 2002, 2003); run;

proc means data=table1; var los; where age <19       and dyear in (2004, 2005, 2006, 2007, 2008, 2009); run;
proc means data=table1; var los; where 19 <= age <36 and dyear in (2004, 2005, 2006, 2007, 2008, 2009); run;
proc means data=table1; var los; where 36 <= age <55 and dyear in (2004, 2005, 2006, 2007, 2008, 2009); run;
proc means data=table1; var los; where 65 <= age     and dyear in (2004, 2005, 2006, 2007, 2008, 2009); run;

proc means data=table1; var los; where age <19       and dyear in (2010, 2011, 2012, 2013, 2014, 2015); run;
proc means data=table1; var los; where 19 <= age <36 and dyear in (2010, 2011, 2012, 2013, 2014, 2015); run;
proc means data=table1; var los; where 36 <= age <55 and dyear in (2010, 2011, 2012, 2013, 2014, 2015); run;
proc means data=table1; var los; where 65 <= age     and dyear in (2010, 2011, 2012, 2013, 2014, 2015); run;

proc means data=table1; var los; where age <19       and dyear in (2016, 2017, 2018, 2019, 2020, 2021); run;
proc means data=table1; var los; where 19 <= age <36 and dyear in (2016, 2017, 2018, 2019, 2020, 2021); run;
proc means data=table1; var los; where 36 <= age <55 and dyear in (2016, 2017, 2018, 2019, 2020, 2021); run;
proc means data=table1; var los; where 65 <= age     and dyear in (2016, 2017, 2018, 2019, 2020, 2021); run;


/* Desc Stats */

proc freq data=dir.ac_all; tables FEMALE AGEGRP RACE PAY1 D1 D3; 
where D1 in ('1') and FEMALE in (0,1) and race in (1,2,3,4,5,6) ;run;

proc freq data=dir.ac_all; tables FEMALE AGEGRP RACE PAY1 D1 D3; 
where D1 in ('1') and D3 in('1') and FEMALE in (0,1) and race in (1,2,3,4,5,6) ;run;


proc freq data=dir.ac_all; tables FEMALE AGEGRP RACE PAY1 PL_NCHS DISPUNIFORM PL_NCHS2006 D1 D3; 
where D1 in ('1') and D3 IN ('0') and FEMALE in (0,1) and race in (1,2,3,4,5,6) and dyear <2012 ;run;
proc freq data=dir.ac_all; tables FEMALE AGEGRP RACE PAY1 PL_NCHS DISPUNIFORM PL_NCHS2006 D1 D3; 
where D1 in ('1') and D3 IN ('1') and female in (0,1) and race in (1,2,3,4,5,6) and dyear <2012 ;run;
proc freq data=dir.ac_all; tables FEMALE AGEGRP RACE PAY1 PL_NCHS DISPUNIFORM PL_NCHS2006 D1 D3; 
where D1 in ('1') and D3 IN ('0') and dyear >2011 and female in (0,1) and race in (1,2,3,4,5,6);run;
proc freq data=dir.ac_all; tables FEMALE AGEGRP RACE PAY1 PL_NCHS DISPUNIFORM PL_NCHS2006 D1 D3; 
where D1 in ('1') and D3 IN ('1') and dyear >2011 and female in (0,1) and race in (1,2,3,4,5,6);run;

proc means data=dir.ac_all; var age LOS TOTCHG; where (D1 in ('1') and D3 IN ('0') and FEMALE in (0,1) and race in (1,2,3,4,5,6));run;
proc means data=dir.ac_all; var age LOS TOTCHG; where (D1 in ('1') and D3 IN ('1') and FEMALE in (0,1) and race in (1,2,3,4,5,6));run;
proc means data=dir.ac_all; var age LOS TOTCHG; where (D1 in ('1') and FEMALE in (0,1) and race in (1,2,3,4,5,6) ;run;


proc means data=dir.ac_all; var age LOS TOTCHG; where (D1 in ('1') and D3 IN ('0') and FEMALE in (0,1) and race in (1,2,3,4,5,6)) and dyear <2012 ;run;
proc means data=dir.ac_all; var age LOS TOTCHG; where (D1 in ('1') and D3 IN ('1') and FEMALE in (0,1) and race in (1,2,3,4,5,6)) and dyear <2012 ;run;
proc means data=dir.ac_all; var age LOS TOTCHG; where (D1 in ('1') and FEMALE in (0,1) and race in (1,2,3,4,5,6)) and dyear <2012 ;run;

proc means data=dir.ac_all; var age LOS TOTCHG; where (D1 in ('1') and D3 IN ('0') and FEMALE in (0,1) and race in (1,2,3,4,5,6)) and dyear >2012 ;run;
proc means data=dir.ac_all; var age LOS TOTCHG; where (D1 in ('1') and D3 IN ('1') and FEMALE in (0,1) and race in (1,2,3,4,5,6)) and dyear >2012 ;run;
proc means data=dir.ac_all; var age LOS TOTCHG; where (D1 in ('1') and FEMALE in (0,1) and race in (1,2,3,4,5,6)) and dyear >2012 ;run;



/*****************************************************************************/
/******************************* REVISION ************************************/
/*****************************************************************************/


/* ARIMA forecasting */

proc arima data=test; 
   identify var=R_C4(0); 
   estimate p=2 q=0;
   forecast lead=120 interval=month id=t out=results;
run;

proc print data=results;
run;

/* Fit an ARIMA model and forecast */
proc arima data=cl_age; 
   identify var=R_C3(1, 12) nlag=24;
   estimate p=1 q=1 method=ml;
   forecast lead=120 out=forecast; /* Forecasts next 12 time periods */
run;

/* Print the forecast results */
proc print data=forecast;
run;

/* Plot the forecast */
proc sgplot data=forecast;
    series x=t y=forecast / markers lineattrs=(color=blue);
    series x=t y=air / markers lineattrs=(color=red);
    xaxis label="Date";
    yaxis label="Air Passengers & Forecast";
    keylegend / location=inside position=topright;
run;


proc arima data=cl_age; 
   identify var=R_C3(0) ;
   estimate p=1 q=0 ;
    forecast out=test2 lead=12; /* Forecasts next 12 time periods */
run;


proc arima data=mydata;
   identify var=Value nlag=12; /* Identify the ARIMA order */
   estimate p=1 q=1; /* Specify ARIMA(1,0,1) model */
   forecast out=forecast lead=12; /* Forecast 12 periods ahead */
run;

proc sgplot data=forecast;
   series x=t y=R_C2 / lineattrs=(color=blue);
   series x=t y=Forecast / lineattrs=(color=red);
   title "ARIMA Forecasting Results";
run;



/* Step 5: Forecast future values */
proc arima data=mydata;
   identify var=Value nlag=12; /* Identify the ARIMA order */
   estimate p=1 q=1; /* Specify ARIMA(1,0,1) model */
   forecast out=forecast lead=12; /* Forecast 12 periods ahead */
run;


proc arima data=cl_age;
    identify var=R_C(12); /* Seasonal differencing with lag 12 */
    estimate P=2 Q=0 s=0 method=ML; /* Seasonal ARIMA(1,1,1) with period 12 */
    forecast lead=120 out=forecasted; /* Forecasts next 12 time periods */
run;
quit;


proc ssm data=cl_age;
   id t interval=month;                                    /* Define the state component for local level */
   state level(type=RW) cov(rwvar);                        /* Define the state component for seasonality (e.g., monthly seasonality) */
   state season(type=SEASON(period=12)) cov(seasonvar);    /* Define the observation equation */
   model R_C1 = level + season;
   /* Estimate the parameters and output the forecasts */
   output out=forecast lead=12; /* Forecast for 12 future periods */
run;


proc ucm data=cl_age;
by t;
id 


/* Step 1: Load Your Time Series Data */
data timeseries; set ac_age; /* Replace 'your_data' with the actual dataset name */
run;

/* Step 2: Visualize the Data to Check for Trends and Seasonality */
proc sgplot data=timeseries;
    series x=t y=R_C / markers lineattrs=(color=blue);
    xaxis label="Time";
    yaxis label="Value";
run;

/* Step 3: Identify the ARIMA Model */
proc arima data=timeseries;
    identify var=R_C nlag=20 stationarity=(adf); /* Check stationarity using ADF test */
run;

/* Step 4: Fit an ARIMA Model */
/* Adjust p, d, q values based on data analysis */

data test; set timeseries (obs=272);
run;

proc arima data=test;
    identify var=R_C(0); /* Identifies autocorrelation structure */
    estimate p=1 q=1 method=ML; /* Example ARIMA(1,1,1) model */
    forecast lead=36 out=forecasted; /* Forecasts next 10 time periods */
run;
quit;

proc arima data=test;
    identify var=R_C(12); /* Seasonal differencing with lag 12 */
    estimate P=1 Q=1 s=12 method=ML; /* Seasonal ARIMA(1,1,1) with period 12 */
    forecast lead=120 out=forecasted; /* Forecasts next 12 time periods */
run;
quit;

/* Step 5: Merge Actual and Forecasted Data */
data combined;
    merge timeseries forecasted;
    by t;
run;

/* Step 6: Plot Actual vs. Forecasted Values */
proc sgplot data=combined;
    series x=t y=R_C / markers lineattrs=(color=blue) legendlabel="Actual";
    series x=t y=forecast / markers lineattrs=(color=red) legendlabel="Forecast";
    xaxis label="Time";
    yaxis label="Value";
    keylegend / location=inside position=topright;
run;



/* Has Unit root 

CT_A3
CT_A4
CT_A5


*/


/* MA */
proc arima data=diff; /* ar(1) ma (0)*/
    identify var=diff_wb(12) nlag=36;
run;

/* ARIMA (p, d, q)= (1,0,1): Sig */
proc arima data=diff; /* Sig. Increasing: 0.01346 */
   identify var=diff_wb; estimate p=2 q=1 method=ml printall;
run;

proc arima data=diff; /* Sig. Increasing MU=96.09942 p=0.5132 */
   identify var=diff_wb(12) stationarity=(adf); /* Stationary, ADF: p<0.05 -> Stationary - 12 differencing (SARIMA) */
   estimate p=1 q=1 method=ml printall;
run;

proc arima data=diff; /* Sig. Increasing MU=1403.0 p<.0001 , AIC=4827 BIC=4838*/
   identify var=diff_wb stationarity=(adf); /* Stationary, ADF: p<0.05 -> Stationary - No seasonality */
   estimate p=1 q=1 method=ml printall;
run;


/************ State-Space model ****************/

/** Forcasting model **/

proc ssm data=AC_AGE;
   id t interval=month;  /* Time variable with monthly data */
      /* Define a level component with a random walk */
   state level(1) type=rw;
      /* Define the observation equation */
   component levelComp = level;
   model R_C = levelComp;
  
run;

proc ssm data=AC_AGE;
   id t interval=month;  /* Time variable with monthly data */
      /* Define a level component with a random walk */
   state level(1) type=rw;
      /* Define the observation equation */
   component levelComp = level;
   model R_C = levelComp;
   
   /* Save forecasts and smoothed values */
   output out=ssm_forecast 
          forecast 
          smoothed;  
run;

   
proc statespace data=ac_age out=forecast_data lead=12; 
  var R_C;
  id t; 
  model R_C = (level(1) + seasonal(12, period=12) + trend(1));  
run; 
	

/* Specify and estimate a state-space model with intervention */
proc ssm data=AC_AGE;
   id t interval=month;                          /* Define the time variable */
   /* Define the state-space model */
   state level(1) type=rw;                       /* Level component with random walk */
/* component interventionEffect = YD; */         /* Define the intervention effect */
   model R_C = level YD;                         /* Define the observation equation */
   output out=ssm_results;                       /* Estimate parameters */
run;

proc ssm data=AC_AGE;
   id t interval=month;
   state level(1) type=rw;
   model R_C = level;
   output out=ssm_results; 
   run;

proc ssm data=AC_AGE;
   id t interval=month;                          /* Define the time variable */
   state level(1) type=rw;                       /* Level component with random walk */
   model R_C = level;                          /* Define the observation equation */
   output out=ssm_results;                       /* Estimate parameters */
run;

proc ssm data=ac_age;
   state level(1) type=random;
   component level;
   model R_C = level;
run;

proc ssm data=ac_age;
   id t; /* Ensure time variable is specified */
   state level(1) type=random;
   component level;
   model R_C = level;
   output out=ssm_out; /* Saves output for debugging */
run;

proc ssm data=ac_age;
   id t; /* Ensure time variable is specified */
   state level type=random; /* Fix the syntax for random state */
   model R_C = level; /* Directly use state in model */
run;

proc ssm data=ac_age;
   id t; /* Ensure time variable is specified */
   state level; /* Specify state variable */
   model R_C = level; /* Model observed series as the level */
   /* No need for 'type=random' as it’s the default for random walk model */
run;


proc ssm data=ac_age;
   id t; /* Time variable */
   state level / type=random;
   model R_C = level;
run;


proc ssm data=ac_age;
   id t; /* Time variable */
   
   /* Define the state component as a random walk */
   state level / type=random;

   /* Use the state component in the model */
   model R_C = level;
run;


proc ssm data=ac_age;
   id t; /* Time variable */
   state level;
   model R_C = level;
run;

proc ssm data=ac_age;
   id t; /* Time variable */
   state level;
   component level;
   model R_C = level;
run;

proc ssm data=ac_age;
   id t; /* Time variable */
   state level; /* Define a state variable 'level' */
   model R_C = level;
run;


proc ssm data=ac_age;
   id t; /* Time variable */
   
   /* Define the state process */
   state level / prior=normal;

   /* Model R_C as a function of the state component 'level' */
   model R_C = level;
run;


proc ssm data=ac_age;
   id t; /* Time variable */
   
   /* Define the state component */
   state level / prior=normal;
   
   /* Define the model */
   model R_C = level;
run;


proc print data=ssm_out(obs=10); run;



proc ssm data=ac_age;
   id t; /* Time variable */
   state level;
   model R_C = level;
run;



/* Specify and estimate a state-space model with intervention */
proc ssm data=AC;
   id t interval=month;                          /* Define the time variable */
   /* Define the state-space model */
   state level(1) type=rw;                       /* Level component with random walk */
   component interventionEffect = YD;            /* Define the intervention effect */
   model R_C = level YD;                         /* Define the observation equation */
   output out=ssm_results;                       /* Estimate parameters */
run;



/* State-Space model */

data mydata;
	length yrmo 6;
	format yrmo $6.;
set ac_caA;
run;

data mydata2; set mydata;
year = substr(yrmo, 1, 10);
month = substr(yrmo, 11, 12);
date = mdy(month, 1, year);
    format date yymmdd10.;
run;


/* Step 4: Time series analysis using PROC UCM as an example */

proc ucm data=mydata2;
  id date interval=month;
  model R_C;
  irregular;
  level;
  season length=12 type=trig;
  slope;
  estimate;
  forecast out=forecasts lead=120;
run;


/* Calculate confidence intervals for the forecasted values */
data forecasts2;
    set forecasts;
    /* Compute upper and lower confidence bounds */
    upper_ci = forecast + UCL; /* 1.96 corresponds to the z-score for 95% confidence */
    lower_ci = forecast - LCL;
run;

/* Plot the forecast graph with confidence intervals */
proc sgplot data=forecasts2;
    series x=date y=R_C / lineattrs=(color=blue) legendlabel='Original';
    series x=date y=forecast / lineattrs=(color=red) legendlabel='Forecast';
    band x=date upper=UCL lower=LCL / transparency=0.3 legendlabel='95% CI';
    xaxis label='Year';
    yaxis label='Cannabis-Related Asthma per 100K';
    keylegend / location=inside position=topright across=1;
run;

proc sgplot data=forecasts2;
    series x=date y=R_C / lineattrs=(color=blue) legendlabel='Original';
    series x=date y=forecast / lineattrs=(color=red) legendlabel='Forecast';
    band x=date upper=UCL lower=LCL / transparency=0.3 legendlabel='95% CI';
    xaxis label='Year';
    yaxis label='Cannabis-Related Asthma per 100K';
    keylegend / location=inside position=topright across=1;
run;



/* Verify the number of observations */
proc contents data=mydata;
run;

/* Check the date format */
proc print data=mydata(obs=10); /* Print the first 10 observations */
run;


proc ucm data=mydata;
    id date interval=month;
    model R_C;
    irregular;
    level;
    season length=12 type=trig;
    estimate;
    forecast out=forecasts lead=12;
run;

/* View the forecast results */
proc print data=forecasts;
run;




/* Step 1: Create Sample Data */
data timeseries (keep=time x);
    do time = 1 to 100;
        x = time;
        y = 5 + 0.8 * time + rannor(1234); /* Simulated trend with noise */
        output;
    end;
run;

/* Step 2: Split Data into Training and Future Periods */
data train future;
    set timeseries;
    if time <= 90 then output train;
    else do;
        y = .; /* Missing values for future periods */
        output future;
    end;
run;

/* Step 3: Fit OLS Model */
proc reg data=train outest=estimates;
    model y = x;
    output out=predicted p=forecast;
run;
quit;

/* Step 4: Use Model to Forecast Future Values */
data future2;
    set future;
    if _N_ = 1 then set estimates(keep=Intercept x); /* Retrieve coefficients */
    forecast = 4.998+0.8*x; /* Compute forecast manually */
run;

/* Step 5: Combine Data for Visualization */
data combined;
    set train future2;
run;

/* Step 6: Plot the Forecast */
proc sgplot data=combined;
    series x=time y=y / markers lineattrs=(color=blue) legendlabel="Actual";
    series x=time y=forecast / markers lineattrs=(color=red) legendlabel="Forecast";
    xaxis label="Time";
    yaxis label="Value";
    keylegend / location=inside position=topright;
run;



/* Step 1: Create Sample Data */
data timeseries; set ac_age;
    do time = 1 to 100;
        x = time;
        output;
    end;
run;

data train future;
    set timeseries;
    if time <= 100 then output train;
    else do;
        y = .; /* Missing values for future periods */
        output future;
    end;
run;

/* Step 3: Fit OLS Model */
proc reg data=timeseries outest=estimates;
    model R_C = x;
    output out=predicted p=forecast;
run;
quit;

/* Step 4: Use Model to Forecast Future Values */
data future2;
    set future;
    if _N_ = 1 then set estimates(keep=Intercept x); /* Retrieve coefficients */
    forecast = 1487.33+0.00000000000238442*x; /* Compute forecast manually */
run;

/* Step 5: Combine Data for Visualization */
data combined;
    set timeseries future2;
run;

/* Step 6: Plot the Forecast */
proc sgplot data=combined;
    series x=time y=y / markers lineattrs=(color=blue) legendlabel="Actual";
    series x=time y=forecast / markers lineattrs=(color=red) legendlabel="Forecast";
    xaxis label="Time";
    yaxis label="Value";
    keylegend / location=inside position=topright;
run;



/******************************* 2/21/25 *******************************/
/* TO BE DELETED IF UNNECESSARY */

/* Step 1: Load Existing Time Series Data */
data timeseries;
    set AC_age; /* Replace 'your_data' with the actual dataset name */
run;

/* Step 2: Split Data into Training (1-90) and Future Periods (91-100) */
data train future;
    set timeseries;
    if time <= 100 then output train;
    else do;
        y = .; /* Set future y-values as missing */
        output future;
    end;
run;

/* Step 3: Fit OLS Model Using PROC REG */
proc reg data=ac_age outest=estimates;
    model y = time; /* Simple linear regression with time as predictor */
    output out=predicted p=forecast; /* Save predictions */
run;
quit;

/* Step 4: Generate Forecast for Future Periods */
data future;
    set future;
    if _N_ = 1 then set estimates(keep=Intercept time); /* Retrieve coefficients */
    forecast = Intercept + time * time; /* Compute forecast manually */
run;

/* Step 5: Combine Training and Forecasted Data */
data combined;
    set train future;
run;

/* Step 6: Plot the Actual vs. Forecasted Values */
proc sgplot data=combined;
    series x=time y=y / markers lineattrs=(color=blue) legendlabel="Actual";
    series x=time y=forecast / markers lineattrs=(color=red) legendlabel="Forecast";
    xaxis label="Time";
    yaxis label="Value";
    keylegend / location=inside position=topright;
run;


/******************************* 2/21/25 *******************************/

