libname data "D:\Data_Warehouse\NIS\NIS_SAS";
libname dir  "D:\Data_Warehouse\CREATED\HI_MH";


/*https://hcup-us.ahrq.gov/db/nation/nis/nisarchive.jsp*/

/***************** Static Parameters Start *************************************************************************************************************************/

/* Housing instability  */
%let dxHI = 'Z59';                                                                                                                  /* Housing      - ICD-10   */      
/* Housing instability  */
/*%let dxHI = 'Z5981'; */

/* Instability */
%let dxHS = 'Z598';

/* Homelessness */
%let dxHL = 'Z590';

/* Inadequate */
%let dxHA = 'Z591';

/* Inadequate Housing   */      
/*%let dxHI = 'Z591';*/


/************ Mental Illness *******************/
/* Mood Disorders */
%let SMD103 = 'F39';                                                                                                                    /* Mood disorder - ICD-10   */ 
%let SMD104 = 'F312' 'F302' 'F303' 'F308' 'F309' 'F310' 'F314' 'F315' 'F319' 'F320' 'F321' 'F322' 'F323' 'F324' 'F328' 'F329' 'F330' 
              'F331' 'F332' 'F333' 'F338' 'F339' 'F340' 'F341' 'F348' 'F349'; 
%let SMD105 = 'F3010' 'F3011' 'F3012' 'F3013' 'F3110' 'F3111' 'F3112' 'F3113' 'F3130' 'F3131' 'F3132' 'F3160' 'F3161' 'F3162' 'F3163'
              'F3164' 'F3170' 'F3171' 'F3173' 'F3175' 'F3177' 'F3181' 'F3189' 'F3340' 'F3341';                                         /* Mood disorder - ICD-10   */

/* Depressive Disorders */
%let SDD104 = 'F320' 'F321' 'F322' 'F323' 'F324' 'F325' 'F328' 'F329' 'F32A' 
              'F330' 'F331' 'F332' 'F333' 'F338' 'F339' 
              'F340' 'F341' 'F348' 'F349'; 
%let SDD105 = 'F3340' 'F3341';                                       

/* Schizophrenia and Other Non-Mood Psychotic Disorder */
%let SSP103 = 'F21' 'F22' 'F23' 'F24' 'F28' 'F29';                                                                                     /* Schizophrenia - ICD-10   */ 
%let SSP104 = 'F200' 'F201' 'F202' 'F203' 'F205' 'F209' 'F250' 'F251' 'F258' 'F259';                                                   /* Schizophrenia - ICD-10   */ 
%let SSP105 = 'F2081' 'F2089';                                                                                                         

/* Anxiety, Stress-related Somantoform disorder */
%let SAS104 = 'F408' 'F409' 'F430' 'F438' 'F439' 'F440' 'F441' 'F442' 'F444' 'F445' 'F446' 'F447' 'F449' 'F450' 'F451' 'F458' 'F459' 
              'F481' 'F482' 'F488' 'F489';                                                                                             /* Anxiety, stress-related, somatoform disorders - ICD-10   */
%let SAS105 = 'F4000' 'F4001' 'F4002' 'F4010' 'F4011' 'F4310' 'F4311' 'F4312' 'F4320' 'F4321' 'F4322' 'F4323' 'F4324' 'F4325' 'F4329'
              'F4481' 'F4489' 'F4520' 'F4521' 'F4522' 'F4529' 'F4541' 'F4542';                                                         /* Anxiety, stress-related, somatoform disorders - ICD-10 */
%let SAS106 = 'F40210' 'F40218' 'F40220' 'F40228' 'F40230' 'F40231' 'F40232' 'F40233' 'F40240' 'F40241' 'F40242' 'F40243' 
              'F40248' 'F40290' 'F40291' 'F40298';                                                                                     /* Anxiety, stress-related, somatoform disorders - ICD-10 */

/************ Substance Use Disorder *******************/

%let SSM104 = 'Z720';                                                                                                                   /* Smoking - ICD-10 */                           
%let SSM105 = 'F1720' 'F1721' 'F1722' 'F1729' 'Z7722';                                                                                  /* Smoking - ICD-10 */                           

%let SAC105 = 'F1010' 'F1014' 'F1019' 'F1020' 'F1024'  /* 'T5191' 'T5192' 'T5193' 'T5194' */ 'F1025' 'F1026' 'F1027' 'F1028' 'F1029' 
              'F1092' 'F1094' 'F1095' 'F1096' 'F1097' 'F1098' 'F1099';                                                                  /* Alcohol - ICD-10    */   
%let SAC106 = 'F10120' 'F10121' 'F10129' 'F10150' 'F10151' 'F10159' 'F10180' 'F10181' 'F10182' 'F10188' 'F10220' 'F10221' 
              'F10229' 'F10230' 'F10231' 
          /*  'T510X1' 'T510X2' 'T510X3' 'T510X4' 'T511X1' 'T511X2' 'T511X3' 'T511X4' 'T512X1' 
              'T512X2' 'T512X3' 'T512X4' 'T513X1' 'T513X2' 'T513X3' 'T513X4' 'T518X1' 'T518X2' 'T518X3' 'T518X4' */
			  ; 

%let SOP105 = 'F1110' 'F1114' 'F1119' 'F1120' 'F1123' 'F1124' 'F1129' 'F1190' 'F1193' 'F1194' 'F1199';                                 /* Opioid - ICD-10   */  
%let SOP106 = 'F11120' 'F11121' 'F11122' 'F11129' 'F11150' 'F11151' 'F11159' 'F11181' 'F11182' 'F18188' 'F11220' 'F11221' 'F11222' 'F11229' 'F11250' 
              'F11251' 'F11259' 'F11281' 'F11282' 'F11288' 'F11920' 'F11921' 'F11922' 'F11929' 'F11950' 'F11951' 'F11959' 'F11981' 'F11982' 'F11988' 
           /* 'T400X1' 'T400X2' 'T400X3' 'T400X4' 'T400X5' 'T400X6' 'T402X1' 'T402X2' 'T402X3' 'T402X4' 'T402X5' 'T402X6' 'T403X1' 'T403X2' 'T403X3' 
              'T403X4' 'T403X5' 'T403X6' 'T404X1' 'T404X2' 'T404X3' 'T404X4' 'T404X5' 'T404X6' 'T40601' 'T40602' 'T40603' 'T40604' 'T40605' 'T40606' 
              'T40691' 'T40692' 'T40693' 'T40694' 'T40695' 'T40696' */;

%let SCA105 = 'F1210' 'F1229' 'F1290' 'F1219' 'F1220' 'F1299';                                                                          /* Cannabis - ICD-10   */
%let SCA106 = 'F12188' 'F12120' 'F12121' 'F12122' 'F12129' 'F12150' 'F12151' 'F12159' 'F12180' 'F12220' 'F12221' 'F12222' 'F12229' 
              'F12250' 'F12251' 'F12259' 'F12280' 'F12288' 'F12920' 'F12921' 'F12922' 'F12929' 'F12950' 'F12951' 'F12959' 'F12980' 
              'F12988' /* 'T407X1' 'T407X2' 'T407X3' 'T407X4' 'T407X5' 'T407X6'*/ ;

%let SCC105 = 'F1410' 'F1414' 'F1420' 'F1419' 'F1423' 'F1424' 'F1429' 'F1490' 'F1494' 'F1499';                                          /* Cocaine - ICD-10   */
%let SCC106 = 'F14120' 'F14121' 'F14122' 'F14129' 'F14150' 'F14151' 'F14159' 'F14180' 'F14181' 'F14182' 'F14188' 
              'F14220' 'F14221' 'F14222' 'F14229' 'F14250' 'F14251' 'F14259' 'F14280' 'F14281' 'F14282' 'F14288' 
              'F14920' 'F14921' 'F14922' 'F14929' 'F14950' 'F14951' 'F14959' 'F14980' 'F14981' 'F14982' 'F14988' 
           /* 'T405X1' 'T405X2' 'T405X3' 'T405X4' 'T405X5' 'T405X6'*/ ;

%let SSO105 = 'F1910' 'F1914' 'F1916' 'F1917' 'F1919' 'F1920' 'F1924' 'F1926' 'F1927' 'F1929' 'F1990' 'F1994' 'F1996' 'F1997' 'F1999';  /* Other substance - ICD-10   */
%let SSO106 = 'F19120' 'F19121' 'F19122' 'F19129' 'F19150' 'F19151' 'F19159' 'F19180' 'F19181' 'F19182' 'F19188' 'F19220' 
              'F19221' 'F19222' 'F19229' 'F19230' 'F19231' 'F19232' 'F19239' 'F19250' 'F19251' 'F19259' 'F19280' 'F19281' 
              'F19282' 'F19288' 'F19920' 'F19921' 'F19922' 'F19929' 'F19930' 'F19931' 'F19932' 'F19939' 'F19950' 'F19951' 
              'F19959' 'F19980' 'F19981' 'F19982' 'F19988'; 


/********************************************* END OF GLOBAL MACRO **********************************************/

			  /* STEP 1.1 -  IDENTIFY A PRIMARY DISEASE in IP */


%macro DA10 (year);

data dir.DX1_&year
(keep=KEY_NIS Age Amonth FEMALE /* I10_DX1-I10_DX15 */ LOS RACE TOTCHG PAY1 YEAR dyear DISPUNIFORM 
HI HS HL HA SMD SDD SSP SAS SSM SOP SCA SAC SCC SSO); 
/*(keep=Age Amonth Died DQTR FEMALE I10_DX1-I10_DX15 I10_PR1-I10_PR15 LOS RACE TOTCHG PAY1 APRDRG_Severity PL_NCHS YEAR DISPUNIFORM DYEAR PL_NCHS D1 LC HF PC MV EM); */
set data.NIS_&year;

/* Housing Instability  */
array DXHI (1:30) I10_DX1-I10_DX30;
length HI $8; HI='0';
do i=1 to 30;
if (substr(DXHI{i}, 1,3) in (&dxHI)) then HI='1';
end;

/* Instability */
array DXHS (1:30) I10_DX1-I10_DX30;
length HS $8; HS='0';
do i=1 to 30;
if (substr(DXHS{i}, 1,4) in (&dxHS)) then HS='1';
end;

/* Homelessness */
array DXHL (1:30) I10_DX1-I10_DX30;
length HL $8; HL='0';
do i=1 to 30;
if (substr(DXHL{i}, 1,4) in (&dxHL)) then HL='1';
end;

/* Inadequate */
array DXHA (1:30) I10_DX1-I10_DX30;
length HA $8; HA='0';
do i=1 to 30;
if (substr(DXHA{i}, 1,4) in (&dxHA)) then HA='1';
end;


/*********************** Mental Health - START **************************/

/* Mood Disorders */
array DMD (1:15) I10_DX1-I10_DX15;
length SMD $8; SMD='0';
do i=1 to 15;
if (substr(DMD{i}, 1,3) in (&SMD103)) or
   (substr(DMD{i}, 1,4) in (&SMD104)) or
   (substr(DMD{i}, 1,5) in (&SMD105)) 
   then SMD='1';
end;


/* Depressive Disorders */
array DDD (1:15) I10_DX1-I10_DX15;
length SDD $8; SDD='0';
do i=1 to 15;
if (substr(DDD{i}, 1,4) in (&SDD104)) or
   (substr(DDD{i}, 1,5) in (&SDD105)) 
   then SDD='1';
end;

/* Schizophrenia */
array DSP (1:15) I10_DX1-I10_DX15;
length SSP $8; SSP='0';
do i=1 to 15;
if (substr(DSP{i}, 1,3) in (&SSP103)) or
   (substr(DSP{i}, 1,4) in (&SSP104)) or
   (substr(DSP{i}, 1,5) in (&SSP105)) 
    then SSP='1';
end;

/*  Anxiety  */
array DAS (1:15) I10_DX1-I10_DX15;
length SAS $8; SAS='0';
do i=1 to 15;
if (substr(DAS{i}, 1,4) in (&SAS104)) or
   (substr(DAS{i}, 1,5) in (&SAS105)) or
   (substr(DAS{i}, 1,6) in (&SAS106)) 
   then SAS='1';
end;

/******************** Substance use disorders  *********************************/

/*  Smoking  */
array DHS (1:15) I10_DX1-I10_DX15;
length SSM $8; SSM='0';
do i=1 to 15;
if (substr(DHS{i}, 1,5) in (&SSM104)) or
   (substr(DHS{i}, 1,6) in (&SSM105)) 
   then SSM='1';
end;

/*  Opioid  */
array DHD (1:15) I10_DX1-I10_DX15;
length SOP $8; SOP='0';
do i=1 to 15;
if (substr(DHD{i}, 1,5) in (&SOP105)) or
   (substr(DHD{i}, 1,6) in (&SOP106)) 
   then SOP='1';
end;

/*  Cannabis  */
array DHE (1:15) I10_DX1-I10_DX15;
length SCA $8; SCA='0';
do i=1 to 15;
if (substr(DHE{i}, 1,5) in (&SCA105)) or
   (substr(DHE{i}, 1,6) in (&SCA106)) 
   then SCA='1';
end;

/*  Alcohol  */
array DHF (1:15) I10_DX1-I10_DX15;
length SAC $8; SAC='0';
do i=1 to 15;
if (substr(DHF{i}, 1,5) in (&SAC105)) or 
   (substr(DHF{i}, 1,6) in (&SAC106)) 
   then SAC='1';
end;

/*  Cocaine  */
array DHG (1:15) I10_DX1-I10_DX15;
length SCC $8; SCC='0';
do i=1 to 15;
if (substr(DHG{i}, 1,5) in (&SCC105)) or
   (substr(DHG{i}, 1,6) in (&SCC106)) 
   then SCC='1';
end;

/*  Other substance  */
array DHH (1:15) I10_DX1-I10_DX15;
length SSO $8; SSO='0';
do i=1 to 15;
if (substr(DHH{i}, 1,5) in (&SSO105)) or
   (substr(DHH{i}, 1,6) in (&SSO106)) 
    then SSO='1';
end;

dyear=&year;
run;

/*data dir.DX1_&year; set dir.DX1_&year;*/
/*rename I10_DX1-I10_Dx15=Dx1-Dx15;*/
/*rename I10_PR1-I10_PR15=Pr1-Pr15;*/
/*rename APRDRG_SEVERITY=APRDRG_S;*/
/*rename DXCCSR=DXCCS;*/
/*rename DXCCSR_DEFAULT_DX1=DXCCS;*/
run;

%mend DA10;
/*%DA10 (2016);*/
%DA10 (2017);
%DA10 (2018);
%DA10 (2019);
%DA10 (2020);
%DA10 (2021);
%DA10 (2022);


/* COMBINE DATA + DATA CLEANING + SEVERITY + PAYER REGROUP + AGE CATEGORY */
data dir.HIMH_ALL; set dir.dx1_2017-dir.dx1_2022; run;

data dir.HIMH ; set dir.HIMH_ALL;

if  SMD in ('1') or SDD in ('1') or SSP in ('1') or SAS in ('1') or SSM in ('1') or 
    SOP in ('1') or SCA in ('1') or SAC in ('1') or SCC in ('1') or SSO in ('1') 
    then MI='1'; else MI='0';

if  SSM in ('1') or SOP in ('1') or SCA in ('1') or SAC in ('1') or SCC in ('1') or SSO in ('1') 
    then SUD='1'; else SUD='0';

if female not in (0, 1) then delete;
if pay1 in (1)   then gov4='1'; else if pay1 in (2) then gov4='2'; else if pay1 in (3) then gov4='3'; else gov4='9';
/*if pay1 in (1,2) then gov2='1'; else if pay1 in (3) then gov2='2'; else gov2='9';*/
/*if pay1 in (1,2) then gov3='1'; else if pay1 in (3) then gov3='2'; else gov3='9';*/

     if race in (1) then race2='1';
else if race in (2) then race2='2';
else if race in (3) then race2='3';
else if race in (4) then race2='4';
else if race in (5) then race2='9';
else if race in (6) then race2='9';
/*else race2=9;*/
else delete;

if      age <18 then agegrp='0';
else if age <30 then agegrp='1';
else if age <45 then agegrp='2';
else if age <65 then agegrp='3';
else if age >64 then agegrp='4';
else delete;

if race=. then delete;

if DISPUNIFORM in (7) then disp='1';
else if DISPUNIFORM not in (7) then disp='0';

where (0< amonth<13) /* and (age >=18) and (HIT='1') and (DISPUNIFORM is not null) */;

run;


/***************** DESCRIPTIVE STATS  ******************* */

proc freq data=dir.HIMH; table 
FEMALE AGEGRP RACE2 PAY1 HI HS HL HA MI SMD SDD SSP SAS SSM SOP SCA SAC SCC SSO
;run;


/***************** Statistical Analysis ******************* */

/* Unadjusted */
%MACRO LRU(DV, IV);
proc logistic data=dir.HIMH descending;
class HI (ref='0')  HS (ref='0') HL (ref='0') HA (ref='0')  MI (ref='0')  SUD (ref='0') agegrp (ref='0') female (ref='0') race2 (ref='1') 
      gov4 (ref='1') dyear (ref='2017')/ param=ref;
model &DV (event='1')= &IV /link=glogit;
run;
%MEND (LRU);
%LRU (MI,  HI); 
%LRU (MI,  HS);
%LRU (MI,  HA); 
%LRU (MI,  HL); 
%LRU (SMD, HI); 
%LRU (SMD, HS); 
%LRU (SMD, HA); 
%LRU (SMD, HL); 
%LRU (SDD, HI); 
%LRU (SDD, HS); 
%LRU (SDD, HA); 
%LRU (SDD, HL); 
%LRU (SSP, HI); 
%LRU (SSP, HL); 
%LRU (SSP, HS); 
%LRU (SSP, HA); 
%LRU (SAS, HI); 
%LRU (SAS, HL); 
%LRU (SAS, HS); 
%LRU (SAS, HA); 
%LRU (SUD, HI); 
%LRU (SUD, HL); 
%LRU (SUD, HS); 
%LRU (SUD, HA); 

/* Adjusted */
%MACRO LRA(DV, IV);
proc logistic data=dir.HIMH descending;
class HI (ref='0')  HS (ref='0') HL (ref='0') HA (ref='0') MI (ref='0')  SUD (ref='0') agegrp (ref='0') female (ref='0') race2 (ref='1') 
      gov4 (ref='1') dyear (ref='2017')/ param=ref;
model &DV (event='1')= &IV female agegrp race2 gov4 dyear /link=glogit;
run;
%MEND (LRA);
%LRA (MI,  HS); 
%LRA (MI,  HA); 
%LRA (SMD, HS); 
%LRA (SMD, HA); 
%LRA (SDD, HS); 
%LRA (SDD, HA); 
%LRA (SSP, HS); 
%LRA (SSP, HA); 
%LRA (SAS, HS); 
%LRA (SAS, HA); 
%LRA (SUD, HS); 
%LRA (SUD, HA); 

%LRA (MI,  HI); 
%LRA (MI,  HL); 
%LRA (SMD, HI); 
%LRA (SMD, HL); 
%LRA (SDD, HI); 
%LRA (SDD, HL); 
%LRA (SSP, HI); 
%LRA (SSP, HL); 
%LRA (SAS, HI); 
%LRA (SAS, HL); 
%LRA (SUD, HI); 
%LRA (SUD, HL); 

/* 12/15/25 */

/* DESCRIPTIVE STATS */

proc freq data=dir.HIMH; 
table HI HS HL HA;
run;

proc freq data=dir.HIMH; 
table MI SMD SDD SSP SAS SUD;
run;

%MACRO DESC (var);
proc freq data=dir.HIMH; 
table agegrp female race2 gov4 MI SMD SDD SSP SAS SUD;
where &var in ('0');run;
%MEND DESC;
%DESC (HI); 
%DESC (HL); 
%DESC (HS); 
%DESC (HA); 

%MACRO DESC (var);
proc freq data=dir.HIMH; 
table agegrp female race2 gov4 MI SMD SDD SSP SAS SUD;
where &var in ('1');run;
%MEND DESC;
%DESC (HI); 
%DESC (HL); 
%DESC (HS); 
%DESC (HA); 

/* 12/24/25 */

