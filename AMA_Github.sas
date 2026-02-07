/*libname data "D:\Data_Warehouse\NIS_SAS";*/
libname data "D:\Data_Warehouse\NIS\NIS_SAS";
/*libname dir  "D:\Data_Warehouse\Created\AMA";*/

/*libname data "H:\H_Data_Warehouse\NIS\NIS_SAS";*/
libname dir  "H:\H_Data_Warehouse\Created\AMA";


/*
PROC IMPORT OUT=data.nis_2010
            DATAFILE="D:\Data_Warehouse\NIS\NIS_SPSS\NIS_2010_MASTER.SAV"
            DBMS=SPSS REPLACE;
RUN;

D:\Data_Warehouse\NIS\NIS_SPSS
*/

data test; set data.NIS_2013;
/*if substr(dx1, 1,4) in ('2967');*/
if substr(dx3, 1,4) in ('V600');
run;



/*https://hcup-us.ahrq.gov/db/nation/nis/nisarchive.jsp*/

/***************** Static Parameters Start *************************************************************************************************************************/
/* https://docs.google.com/document/d/1y8keRTMO2UHfhrltEdJ5AwTBhgNEZ5n15wD1X28tKDQ/edit?tab=t.0 */

/* Housing instability  */
%let dxI9 =  'V600';                                                                                                                  /* Housing      - ICD-9    */   
%let dxI10 = 'Z590';                                                                                                                  /* Housing      - ICD-10   */      

/* Mistreatment - Primary/Secondary only */
%let dxM9  = '99580' '99581' '99582' '99583' '99584' '99585' 'V7181';                                                                  /* Mistreatment - ICD-9    */  
%let dxM10 = 'T7401' 'T7411' 'T7421' 'T7431' 'T7451' 'T7461' 'T7491' 'T7601' 'T7611' 'T7621' 'T7631' 'T7651' 'T7661' 'T7691' 'Z0471';  /* Mistreatment - ICD-10   */

/* Perpetrator  - Primary/Secondary only */
%let dxP9 = 'E9670' 'E9671' 'E9672' 'E9673' 'E9674' 'E9675' 'E9677' 'E9678' 'E9679';                                                   /* Perpetrator  - ICD-9    */ 
%let dxP10 = 'Y070' 'Y071' 'Y074' 'Y075' 'Y076' 'Y079';                                                                                /* Perpetrator  - ICD-10   */ 

/************ Mental health - ICD *******************/
%let SMD94 =  '2967';                                                                                                                  /* Mood disorder - ICD-9    */ 
%let SMD95 =  '29600' '29601' '29602' '29603' '29604' '29605' '29606' '29610' '29611' '29612' '29613' '29614' '29615' '29616' '29620'
              '29621' '29622' '29623' '29624' '29625' '29626' '29630' '29631' '29632' '29633' '29634' '29635' '29640' '29641' '29642'
              '29643' '29644' '29645' '29646' '29650' '29651' '29653' '29654' '29655' '29656' '29660' '29661' '29662' '29663' '29664' 
              '29665' '29666' '29680' '29681' '29682' '29689' '29690' '29699' '0794';                                                  /* Mood disorder - ICD-9    */ 

%let SMD103 = 'F39';                                                                                                                    /* Mood disorder - ICD-10   */ 
%let SMD104 = 'F312' 'F302' 'F303' 'F308' 'F309' 'F310' 'F314' 'F315' 'F319' 'F320' 'F321' 'F322' 'F323' 'F324' 'F328' 'F329' 'F330' 
              'F331' 'F332' 'F333' 'F338' 'F339' 'F340' 'F341' 'F348' 'F349'; 
%let SMD105 = 'F3010' 'F3011' 'F3012' 'F3013' 'F3110' 'F3111' 'F3112' 'F3113' 'F3130' 'F3131' 'F3132' 'F3160' 'F3161' 'F3162' 'F3163'
              'F3164' 'F3170' 'F3171' 'F3173' 'F3175' 'F3177' 'F3181' 'F3189' 'F3340' 'F3341';                                         /* Mood disorder - ICD-10   */

%let SSC94  = '2970' '2971' '2972' '2973' '2978' '2979' '2980' '2981' '2982' '2983' '2984' '2988'  /* '0794' */;                       /* Schizophrenia - ICD-9   */                                                                                       /* Schizophrenia - ICD-9    */ 
%let SSC103 = 'F21' 'F22' 'F23' 'F24' 'F28' 'F29';                                                                                     /* Schizophrenia - ICD-10   */ 
%let SSC105 = 'F2081' 'F2089';                                                                                                         /* Schizophrenia - ICD-10   */ 
%let SSC104 = 'F200' 'F201' 'F202' 'F203' 'F205' 'F209' 'F250' 'F251' 'F258' 'F259';                                                   /* Schizophrenia - ICD-10   */ 

%let SAS94 = '3003' '3004' '3005' '3006' '3007' '3080' '3081' '3082' '3083' '3094' '3091' '3093' '3098' '3099';                        /* Anxiety, stress-related, somatoform disorders - ICD-9  */ 
%let SAS95 = '30000' '30001' '30002' '30009' '30010' '30011' '30012' '30013' '30014' '30015' '30016' '30019' '30020' '30021' '30022' 
             '30023' '30029' '30081' '30082' '30089' '30151' '30921' '30924' '30981' '30982' '30983' '30989' ;

%let SAS104 = 'F408' 'F409' 'F430' 'F438' 'F439' 'F440' 'F441' 'F442' 'F444' 'F445' 'F446' 'F447' 'F449' 'F450' 'F451' 'F458' 'F459' 
              'F481' 'F482' 'F488' 'F489';                                                                                             /* Anxiety, stress-related, somatoform disorders - ICD-10   */
%let SAS105 = 'F4000' 'F4001' 'F4002' 'F4010' 'F4011' 'F4310' 'F4311' 'F4312' 'F4320' 'F4321' 'F4322' 'F4323' 'F4324' 'F4325' 'F4329'
              'F4481' 'F4489' 'F4520' 'F4521' 'F4522' 'F4529' 'F4541' 'F4542';                                                         /* Anxiety, stress-related, somatoform disorders - ICD-10 */
%let SAS106 = 'F40210' 'F40218' 'F40220' 'F40228' 'F40230' 'F40231' 'F40232' 'F40233' 'F40240' 'F40241' 'F40242' 'F40243' 
              'F40248' 'F40290' 'F40291' 'F40298';                                                                                     /* Anxiety, stress-related, somatoform disorders - ICD-10 */


/************ Substance use disorder - ICD *******************/

%let SSM94  = '3051' '9800' '9801' '9802' '9803' '9808' '9809';                                                                         /* Smoking - ICD-9 */
%let SSM95  = 'V1582';                                                                                                                  
%let SSM104 = 'Z720';                                                                                                                   /* Smoking - ICD-10 */                           
%let SSM105 = 'F1720' 'F1721' 'F1722' 'F1729' 'Z7722';                                                                                  /* Smoking - ICD-10 */                           

%let SAC94 = '7903' '9800' '9801' '9802' '9803' '9808' '9809';                                                                          /* Alcohol - ICD-9    */ 
%let SAC95 = '30300' '30301' '30302' '30390' '30391' '30392' '30500' '30501' '30502' /* 'E8600' 'E8601' 'E8602' 'E8609' */;                

%let SAC105 = 'F1010' 'F1014' 'F1019' 'F1020' 'F1024'  /* 'T5191' 'T5192' 'T5193' 'T5194' */ 'F1025' 'F1026' 'F1027' 'F1028' 'F1029' 
              'F1092' 'F1094' 'F1095' 'F1096' 'F1097' 'F1098' 'F1099';                                                                  /* Alcohol - ICD-10    */   
%let SAC106 = 'F10120' 'F10121' 'F10129' 'F10150' 'F10151' 'F10159' 'F10180' 'F10181' 'F10182' 'F10188' 'F10220' 'F10221' 
              'F10229' 'F10230' 'F10231' 
          /*  'T510X1' 'T510X2' 'T510X3' 'T510X4' 'T511X1' 'T511X2' 'T511X3' 'T511X4' 'T512X1' 
              'T512X2' 'T512X3' 'T512X4' 'T513X1' 'T513X2' 'T513X3' 'T513X4' 'T518X1' 'T518X2' 'T518X3' 'T518X4' */
			  ; 

%let SOP95  = '30400' '30401' '30402' '30403' '30470' '30471' '30472' '30550' '30551' '30552' '96500' '96502' '96509'
           /* 'E8501' 'E8502' 'E9351' 'E9352' */ ;                                                                                     /* Opioid - ICD-9    */ 
%let SOP105 = 'F1110' 'F1114' 'F1119' 'F1120' 'F1123' 'F1124' 'F1129' 'F1190' 'F1193' 'F1194' 'F1199';                                 /* Opioid - ICD-10   */  
%let SOP106 = 'F11120' 'F11121' 'F11122' 'F11129' 'F11150' 'F11151' 'F11159' 'F11181' 'F11182' 'F18188' 'F11220' 'F11221' 'F11222' 'F11229' 'F11250' 
              'F11251' 'F11259' 'F11281' 'F11282' 'F11288' 'F11920' 'F11921' 'F11922' 'F11929' 'F11950' 'F11951' 'F11959' 'F11981' 'F11982' 'F11988' 
           /* 'T400X1' 'T400X2' 'T400X3' 'T400X4' 'T400X5' 'T400X6' 'T402X1' 'T402X2' 'T402X3' 'T402X4' 'T402X5' 'T402X6' 'T403X1' 'T403X2' 'T403X3' 
              'T403X4' 'T403X5' 'T403X6' 'T404X1' 'T404X2' 'T404X3' 'T404X4' 'T404X5' 'T404X6' 'T40601' 'T40602' 'T40603' 'T40604' 'T40605' 'T40606' 
              'T40691' 'T40692' 'T40693' 'T40694' 'T40695' 'T40696' */;

%let SCA95 =  '30430' '30431' '30520' '30521' '30522';                                                                                  /* Cannabis - ICD-9    */ 
%let SCA105 = 'F1210' 'F1229' 'F1290' 'F1219' 'F1220' 'F1299';                                                                          /* Cannabis - ICD-10   */
%let SCA106 = 'F12188' 'F12120' 'F12121' 'F12122' 'F12129' 'F12150' 'F12151' 'F12159' 'F12180' 'F12220' 'F12221' 'F12222' 'F12229' 
              'F12250' 'F12251' 'F12259' 'F12280' 'F12288' 'F12920' 'F12921' 'F12922' 'F12929' 'F12950' 'F12951' 'F12959' 'F12980' 
              'F12988' /* 'T407X1' 'T407X2' 'T407X3' 'T407X4' 'T407X5' 'T407X6'*/ ;

%let SCC95  = '30420' '30422' '30560' '30561' '30562' '97081' '97089' /* 'E9385' */;                                                    /* Cocaine - ICD-9    */ 
%let SCC105 = 'F1410' 'F1414' 'F1420' 'F1419' 'F1423' 'F1424' 'F1429' 'F1490' 'F1494' 'F1499';                                          /* Cocaine - ICD-10   */
%let SCC106 = 'F14120' 'F14121' 'F14122' 'F14129' 'F14150' 'F14151' 'F14159' 'F14180' 'F14181' 'F14182' 'F14188' 
              'F14220' 'F14221' 'F14222' 'F14229' 'F14250' 'F14251' 'F14259' 'F14280' 'F14281' 'F14282' 'F14288' 
              'F14920' 'F14921' 'F14922' 'F14929' 'F14950' 'F14951' 'F14959' 'F14980' 'F14981' 'F14982' 'F14988' 
           /* 'T405X1' 'T405X2' 'T405X3' 'T405X4' 'T405X5' 'T405X6'*/ ;

%let SSO95 = '30460' '30461' '30462' '30470' '30471' '30472' '30480' '30481' '30490' '30491' '30492' '30580' 
             '30581' '30582' '30590' '30591' '30592';                                                                                   /* Other substance - ICD-9    */ 
%let SSO105 = 'F1910' 'F1914' 'F1916' 'F1917' 'F1919' 'F1920' 'F1924' 'F1926' 'F1927' 'F1929' 'F1990' 'F1994' 'F1996' 'F1997' 'F1999';  /* Other substance - ICD-10   */
%let SSO106 = 'F19120' 'F19121' 'F19122' 'F19129' 'F19150' 'F19151' 'F19159' 'F19180' 'F19181' 'F19182' 'F19188' 'F19220' 
              'F19221' 'F19222' 'F19229' 'F19230' 'F19231' 'F19232' 'F19239' 'F19250' 'F19251' 'F19259' 'F19280' 'F19281' 
              'F19282' 'F19288' 'F19920' 'F19921' 'F19922' 'F19929' 'F19930' 'F19931' 'F19932' 'F19939' 'F19950' 'F19951' 
              'F19959' 'F19980' 'F19981' 'F19982' 'F19988'; 


/********************************************* END OF GLOBAL MACRO **********************************************/

			  /* STEP 1.1 -  IDENTIFY A PRIMARY DISEASE in IP */

%macro DA9 (year);

data dir.DX1_&year
(keep= KEY_NIS Age Amonth FEMALE Dx1-Dx15 DXCCS LOS RACE TOTCHG PAY1 YEAR dyear DISPUNIFORM DISPUNIF APRDRG_S APRDRG_Severity 
HIT MIS PPT SMD SSC SAS SSM SOP SCA SCC SAC SSO
); 
/* (keep=Age Amonth Died DQTR FEMALE Dx1-Dx15 PR1-PR15 LOS RACE TOTCHG PAY1 YEAR dyear DISPUNIFORM HOSP_LOCATION PL_NCHS2006 PL_NCHS APRDRG_S APRDRG_Severity LC HF PC MV EM); */
set data.NIS_&year;

/* Housing instability  */
array DXH (1:30) Dx1-Dx30;
length HIT $8; HIT='0';
do i=1 to 30;
if (YEAR <  2015 and                (substr(DXH{i}, 1,4) in (&dxI9) )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(DXH{i}, 1,4) in (&dxI9) )) or 
   (YEAR =  2015 and AMONTH >9  and (substr(DXH{i}, 1,4) in (&dxI10))) 
    then HIT='1';
end;

/* Mistreatment */
array DXA (1:30) Dx1-Dx30;
length MIS $8; MIS='0';
do i=1 to 30;
if (YEAR <  2015 and                (substr(DXA{i}, 1,5) in (&dxM9) )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(DXA{i}, 1,5) in (&dxM9) )) or 
   (YEAR =  2015 and AMONTH >9  and (substr(DXA{i}, 1,5) in (&dxM10))) 
    then MIS='1';
end;

/* Perpetrator */
array DXB (1:30) Dx1-Dx30;
length PPT $8; PPT='0';
do i=1 to 30;
if (YEAR <  2015 and                (substr(DXB{i}, 1,5) in (&dxP9) )) or
   (YEAR =  2015 and AMONTH <10 and (substr(DXB{i}, 1,5) in (&dxP9) )) or 
   (YEAR =  2015 and AMONTH >9  and (substr(DXB{i}, 1,4) in (&dxP10))) 
    then PPT='1';
end;

/*********************** Mental Health - START **************************/

/* Mood Disorders */
array DHA (1:15) Dx1-Dx15;
length SMD $8; SMD='0';
do i=1 to 15;
if (YEAR <  2015 and                (substr(DHA{i}, 1,4) in (&SMD94)  )) or 
   (YEAR <  2015 and                (substr(DHA{i}, 1,5) in (&SMD95)  )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(DHA{i}, 1,4) in (&SMD94)  )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(DHA{i}, 1,5) in (&SMD95)  )) or 
   (YEAR =  2015 and AMONTH >9  and (substr(DHA{i}, 1,3) in (&SMD103) )) or
   (YEAR =  2015 and AMONTH >9  and (substr(DHA{i}, 1,4) in (&SMD104) )) or
   (YEAR =  2015 and AMONTH >9  and (substr(DHA{i}, 1,5) in (&SMD105) )) 
    then SMD='1';
end;

/* Schizophrenia */
array DHB (1:15) Dx1-Dx15;
length SSC $8; SSC='0';
do i=1 to 15;
if (YEAR <  2015 and                (substr(DHB{i}, 1,4) in (&SSC94)  )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(DHB{i}, 1,4) in (&SSC94)  )) or 
   (YEAR =  2015 and AMONTH >9  and (substr(DHB{i}, 1,3) in (&SSC103) )) or
   (YEAR =  2015 and AMONTH >9  and (substr(DHB{i}, 1,4) in (&SSC104) )) or
   (YEAR =  2015 and AMONTH >9  and (substr(DHB{i}, 1,5) in (&SSC105) )) 
    then SSC='1';
end;

/*  Anxiety  */
array DHC (1:15) Dx1-Dx15;
length SAS $8; SAS='0';
do i=1 to 15;
if (YEAR <  2015 and                (substr(DHC{i}, 1,4) in (&SAS94)  )) or 
   (YEAR <  2015 and                (substr(DHC{i}, 1,5) in (&SAS95)  )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(DHC{i}, 1,4) in (&SAS94)  )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(DHC{i}, 1,5) in (&SAS95)  )) or 
   (YEAR =  2015 and AMONTH >9  and (substr(DHC{i}, 1,4) in (&SAS104) )) or
   (YEAR =  2015 and AMONTH >9  and (substr(DHC{i}, 1,5) in (&SAS105) )) or
   (YEAR =  2015 and AMONTH >9  and (substr(DHC{i}, 1,6) in (&SAS106) )) 
    then SAS='1';
end;

/******************** Substance use disorders  *********************************/

/*  Smoking  */
array DHS (1:15) Dx1-Dx15;
length SSM $8; SSM='0';
do i=1 to 15;
if (YEAR <  2015 and                (substr(DHS{i}, 1,4) in (&SSM94)  )) or 
   (YEAR <  2015 and                (substr(DHS{i}, 1,5) in (&SSM95)  )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(DHS{i}, 1,4) in (&SSM94)  )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(DHS{i}, 1,5) in (&SSM95)  )) or 
   (YEAR =  2015 and AMONTH >9  and (substr(DHS{i}, 1,5) in (&SSM104) )) or
   (YEAR =  2015 and AMONTH >9  and (substr(DHS{i}, 1,6) in (&SSM105) )) 
    then SSM='1';
end;

/*  Opioid  */
array DHD (1:15) Dx1-Dx15;
length SOP $8; SOP='0';
do i=1 to 15;
if (YEAR <  2015 and                (substr(DHD{i}, 1,5) in (&SOP95)  )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(DHD{i}, 1,5) in (&SOP95)  )) or 
   (YEAR =  2015 and AMONTH >9  and (substr(DHD{i}, 1,5) in (&SOP105) )) or
   (YEAR =  2015 and AMONTH >9  and (substr(DHD{i}, 1,6) in (&SOP106) )) 
    then SOP='1';
end;

/*  Cannabis  */
array DHE (1:15) Dx1-Dx15;
length SCA $8; SCA='0';
do i=1 to 15;
if (YEAR <  2015 and                (substr(DHE{i}, 1,5) in (&SCA95)  )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(DHE{i}, 1,5) in (&SCA95)  )) or 
   (YEAR =  2015 and AMONTH >9  and (substr(DHE{i}, 1,5) in (&SCA105) )) or
   (YEAR =  2015 and AMONTH >9  and (substr(DHE{i}, 1,6) in (&SCA106) )) 
    then SCA='1';
end;

/*  Alcohol  */
array DHF (1:15) Dx1-Dx15;
length SAC $8; SAC='0';
do i=1 to 15;
if (YEAR <  2015 and                (substr(DHF{i}, 1,4) in (&SAC94)  )) or 
   (YEAR <  2015 and                (substr(DHF{i}, 1,5) in (&SAC95)  )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(DHF{i}, 1,4) in (&SAC94)  )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(DHF{i}, 1,5) in (&SAC95)  )) or 
   (YEAR =  2015 and AMONTH >9  and (substr(DHF{i}, 1,5) in (&SAC105) )) or 
   (YEAR =  2015 and AMONTH >9  and (substr(DHF{i}, 1,6) in (&SAC106) )) 
    then SAC='1';
end;

/*  Cocaine  */
array DHG (1:15) Dx1-Dx15;
length SCC $8; SCC='0';
do i=1 to 15;
if (YEAR <  2015 and                (substr(DHG{i}, 1,5) in (&SCC95)  )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(DHG{i}, 1,5) in (&SCC95)  )) or 
   (YEAR =  2015 and AMONTH >9  and (substr(DHG{i}, 1,5) in (&SCC105) )) or
   (YEAR =  2015 and AMONTH >9  and (substr(DHG{i}, 1,6) in (&SCC106) )) 
    then SCC='1';
end;


/*  Other substance  */
array DHH (1:15) Dx1-Dx15;
length SSO $8; SSO='0';
do i=1 to 15;
if (YEAR <  2015 and                (substr(DHH{i}, 1,5) in (&SSO95)  )) or 
   (YEAR =  2015 and AMONTH <10 and (substr(DHH{i}, 1,5) in (&SSO95)  )) or 
   (YEAR =  2015 and AMONTH >9  and (substr(DHH{i}, 1,5) in (&SSO105) )) or
   (YEAR =  2015 and AMONTH >9  and (substr(DHH{i}, 1,6) in (&SSO106) )) 
    then SSO='1';
end;

/******************** Mental Health -  END *********************************/

rename APRDRG_SEVERITY=APRDRG_S;
rename DXCCS1=DXCCS;
rename DISPUNIF=DISPUNIFORM;
dyear=&year;

run;

%mend DA9;
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


proc freq data=dir.dx1_2015; table 
/*IDDA IDDB IDDC IDDD MT PT SHP SO SCL SG SS SH SA SM SC ST SCV SSA SGW SUI ASD*/
HIT MIS PPT SMD SSC SAS SSM SOP SCA SCC SSO
/*SMD SSC SAS SOP SCA SAC SCC SSO*/
;run;

proc freq data=data.nis_2003; table year; run;


%macro DA10 (year);

data dir.DX1_&year
(keep=KEY_NIS Age Amonth FEMALE Dx1-Dx15 LOS RACE TOTCHG PAY1 YEAR dyear DISPUNIFORM HIT MIS PPT SMD SSC SAS SSM SOP SCA SCC SAC SSO); 
/*(keep=Age Amonth Died DQTR FEMALE I10_DX1-I10_DX15 I10_PR1-I10_PR15 LOS RACE TOTCHG PAY1 APRDRG_Severity PL_NCHS YEAR DISPUNIFORM DYEAR PL_NCHS D1 LC HF PC MV EM); */
set data.NIS_&year;

/* Housing instability  */
array DXH (1:30) I10_DX1-I10_DX30;
length HIT $8; HIT='0';
do i=1 to 30;
if (substr(DXH{i}, 1,4) in (&dxI10)) then HIT='1';
end;

/* Mistreatment */
array DXA (1:30) I10_DX1-I10_DX30;
length MIS $8; MIS='0';
do i=1 to 30;
if (substr(DXA{i}, 1,5) in (&dxM10)) then MIS='1';
end;

/* Perpetrator */
array DXB (1:30) I10_DX1-I10_DX30;
length PPT $8; PPT='0';
do i=1 to 30;
if (substr(DXB{i}, 1,4) in (&dxP10)) then PPT='1';
end;

/*********************** Mental Health - START **************************/

/* Mood Disorders */
array DHA (1:15) I10_DX1-I10_DX15;
length SMD $8; SMD='0';
do i=1 to 15;
if (substr(DHA{i}, 1,3) in (&SMD103)) or
   (substr(DHA{i}, 1,4) in (&SMD104)) or
   (substr(DHA{i}, 1,5) in (&SMD105)) 
   then SMD='1';
end;

/* Schizophrenia */
array DHB (1:15) I10_DX1-I10_DX15;
length SSC $8; SSC='0';
do i=1 to 15;
if (substr(DHB{i}, 1,3) in (&SSC103)) or
   (substr(DHB{i}, 1,4) in (&SSC104)) or
   (substr(DHB{i}, 1,5) in (&SSC105)) 
    then SSC='1';
end;

/*  Anxiety  */
array DHC (1:15) I10_DX1-I10_DX15;
length SAS $8; SAS='0';
do i=1 to 15;
if (substr(DHC{i}, 1,4) in (&SAS104)) or
   (substr(DHC{i}, 1,5) in (&SAS105)) or
   (substr(DHC{i}, 1,6) in (&SAS106)) 
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

data dir.DX1_&year; set dir.DX1_&year;
rename I10_DX1-I10_Dx15=Dx1-Dx15;
/*rename I10_PR1-I10_PR15=Pr1-Pr15;*/
/*rename APRDRG_SEVERITY=APRDRG_S;*/
/*rename DXCCSR=DXCCS;*/
/*rename DXCCSR_DEFAULT_DX1=DXCCS;*/
run;

%mend DA10;
%DA10 (2016);
%DA10 (2017);
%DA10 (2018);
%DA10 (2019);
%DA10 (2020);
%DA10 (2021);
%DA10 (2022);

proc freq data=dir.dx1_2022; table 
/*IDDA IDDB IDDC IDDD MT PT SHP SO SCL SG SS SH SA SM SC ST SCV SSA SGW SUI ASD*/
MIS PPT SMD SSC SAS SSM SOP SCA SAC SCC SSO
/*SMD SSC SAS SOP SCA SAC SCC SSO*/
;run;

proc freq data=dir.dx1_2004; table MIS; run;

/* COMBINE DATA + DATA CLEANING + SEVERITY + PAYER REGROUP + AGE CATEGORY */
data dir.AMA_ALL(drop=dx1-dx15); set dir.dx1_2003-dir.dx1_2022; run;

data dir.AMA ; set dir.AMA_ALL;
/* ts */
/*length yrmo 6;*/
/*yrmo=dyear*100+amonth;*/
/* Treatment */
/*if yrmo <200903 then YD=0;*/
/*else if yrmo >=200903 then YD=1;*/

/* Mistreatment  */
if MIS in ('1') or PPT in ('1') then MIT ='1'; else MIT ='0';

/* Mental health + Substance */
if SMD in ('1') or SSC in ('1') or SAS in ('1') then MH2 ='1'; else MH2 ='0';
if SSM in ('1') or SOP in ('1') or SCA in ('1') or SAC in ('1') or SCC in ('1') or SSO in ('1') then SUB ='1'; else SUB ='0';

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

where (0< amonth<13) and (age >=18) and (HIT='1') and (DISPUNIFORM is not null);

run;

data dir.AMA ; set dir.AMA;
if MIT ='0'and SUB ='0' then MS='0';  
if MIT ='1'and SUB ='0' then MS='1';
if MIT ='0'and SUB ='1' then MS='2';
if MIT ='1'and SUB ='1' then MS='3';
run;

proc freq data=dir.ama; tables ms; where (0< amonth<13) and (age >=18) and (HIT='1') and (DISPUNIFORM is not null) and (race is not null);
run;

proc freq data=dir.ama_all; tables mis*hit; where (0< amonth<13) and (age >=18) and (DISPUNIFORM is not null) and (race is not null);
run;


data test; set dir.ama;
if mit ='1';
run;


/* Unadjusted - FINAL 11/15/25 */
%MACRO AMAU(DEP);
proc logistic data=dir.AMA descending;
class MS (ref='0') agegrp (ref='1') female (ref='0') race2 (ref='1') MH2 (ref='0') SUB (ref='0') gov4 (ref='1') dyear (ref='2003')/ param=ref;
model &DEP= MS /link=glogit;
run;
%MEND (AMAU);
%AMAU (DISP); 

%MACRO AMAU(DEP);
proc logistic data=dir.AMA descending;
class MS (ref='0') agegrp (ref='2') female (ref='0') race2 (ref='1') MH2 (ref='0') SUB (ref='0') gov4 (ref='1') dyear (ref='2003')/ param=ref;
model &DEP= MH2 /* SUB */ /link=glogit;
run;
%MEND (AMAU);
%AMAU (DISP); 

/* Adjusted - FINAL MODEL 11/15/25 */
%MACRO AMAA(DEP);
proc logistic data=dir.AMA descending;
class MS (ref='0') agegrp (ref='1') female (ref='0') race2 (ref='1') MH2 (ref='0') SUB (ref='0') gov4 (ref='1') dyear (ref='2003')/ param=ref;
model &DEP= MS female agegrp race2 MH2 gov4 /*dyear*//link=glogit;
run;
%MEND (AMAA);
%AMAA (DISP); 

proc freq data=dir.ama; tables ms mit; run;
proc freq data=dir.ama; table dyear agegrp; run;


PROC EXPORT DATA= dir.AMA
     outfile = "C:\Users\kimy89\Dropbox\Research\AMA\data\AMA"
     DBMS=xlsx REPLACE;
     sheet="AMA";
RUN;



/*************** AMA (dep)- UPDATED/ DISREGARDED 11/15/25  *******************/
/* Two different models used */

/* Unadjusted */
%MACRO AMAU(DEP, IND);
proc logistic data=dir.AMA descending;
class SUB (ref='0') /* MIT (ref='1') MS (ref='0')*/ agegrp (ref='1') female (ref='0') race2 (ref='1') MH2 (ref='0') gov4 (ref='1') dyear (ref='2003')/ param=ref;
model &DEP= sub;
where MIT in (&IND);
run;
%MEND (AMAU);
%AMAU (DISP, '0'); /*Without mistreatment*/
%AMAU (DISP, '1'); /*With    mistreatment*/

/* Adjusted */
%MACRO AMAU(DEP, IND);
proc logistic data=dir.AMA descending;
class SUB (ref='0') /* MIT (ref='1') MS (ref='0')*/ agegrp (ref='1') female (ref='0') race2 (ref='1') MH2 (ref='0') gov4 (ref='1') dyear (ref='2003')/ param=ref;
model &DEP= sub female agegrp race2 MH2 gov4 /*dyear*/;
where MIT in (&IND);
run;
%MEND (AMAU);
%AMAU (DISP, '0'); 
%AMAU (DISP, '1'); 


/* DESC - FINAL AS OF 11/14/25 */

/* T1 */
proc freq data=dir.ama; table agegrp female race2 gov4 mh2 disp mit sub; run;

/* T2 */
proc freq data=dir.ama; table agegrp female race2 gov4 mh2 disp mit sub; where MIT in ('1');run;
proc freq data=dir.ama; table agegrp female race2 gov4 mh2 disp mit sub; where MIT in ('0');run;


/****************************************** END 11/15/25 *************************************************/


/* STD Diff - NOT SELECTED */

/* Step 1: Get proportions for each group */
proc freq data=dir.ama noprint;
    tables female*mit / out=freqs;
run;

/* Step 2: Compute standardized difference */
data stddiff_prop;
    set freqs;
    retain p1 p0;

    /* Percent is from PROC FREQ output */
    if female=1 then p1 = percent/100;
    if female=0 then p0 = percent/100;

    /* Only calculate once when p1 and p0 are both stored */
    if _n_=2 then do;
        pooled = sqrt((p1*(1-p1) + p0*(1-p0)) / 2);
        std_diff = (p1 - p0) / pooled;
        output;
    end;
run;

proc print data=stddiff_prop;
run;

data stddiff_prop;
    set freqs;
    retain p1 p0;

    /* Percent is from PROC FREQ output */
    if group=1 then p1 = percent/100;
    if group=0 then p0 = percent/100;

    /* Only calculate once when p1 and p0 are both stored */
    if _n_=2 then do;
        pooled = sqrt((p1*(1-p1) + p0*(1-p0)) / 2);
        std_diff = (p1 - p0) / pooled;
        output;
    end;
run;

proc print data=stddiff_prop;
run;




proc means data=dir.ama noprint;
    class mit;        /* 0/1 groups */
    var female;       /* continuous variable */
    output out=stats mean=mean std=sd;
run;

proc means data=dir.ama print;
    class mit;        /* 0/1 groups */
    var female       /* continuous variable */
;run;

data stddiff;
    set stats;
    retain mean1 sd1 mean0 sd0;
    if group=1 then do; mean1=mean; sd1=sd; end;
    if group=0 then do; mean0=mean; sd0=sd; end;
    if _n_=2 then do;
        pooled_sd = sqrt((sd1*sd1 + sd0*sd0)/2);
        std_diff = (mean1 - mean0) / pooled_sd;
        output;
    end;
run;

proc print data=stddiff;
run;



/***************** END ******************/



