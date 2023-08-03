
libname data "C:\Users\kimy89\Documents\Data\CHIA\Final_SAS_Files";
libname dir "C:\Users\kimy89\Documents\Data\GI-ED";

/*Static Parameters Start*/
%let cannabis9 = '30430' '30431' '30433' '30520' '30521' '30522' '30523';
%let cannabis10 = 'F12' ;
%let nausea9 = '5362' '78701' '78702' '78703' '78704';
%let nausea10 = 'R11' ;
%let nicotine9 = '3051' '64900' '64901' '64902' '64903' '64904' ;
%let nicotine10 = 'F17' ;
%let alcohol9 = '30300' '30301' '30302' '30303' '30390' '30391' '30392' '30393' '30500' '30501' '30502' '30503';
%let alcohol10 = 'F10' ;
%let opioid9 = '30400' '30401' '30402' '30403' '30550' '30551' '30552' '30553';
%let opioid10 = 'F11' ;
%let sedatives9 = '30410' '30411' '30413' '30540' '30541' '30542' '30543';
%let sedatives10 = 'F13';
%let cocaine9 = '30420' '30422' '30423' '30560' '30561' '30562' '30563'; /* 305.20? */
%let cocaine10 = 'F14' ;
%let SHO9 = '30400' '30441' '30442' '30443' '30570' '30571' '30572' '30573' '30450' '30451' '30452' '30453' '30530' '30531' '30532' '30553';
%let SHO10 = 'F15' 'F16' 'F18' 'F19' ;
/* Stimulant, hallucinogen, others */
%let mood9 = '29600' '29601' '29602' '29603' '29604' '29605' '29606' '29610' '29611' '29612' '29613' '29614' '29615' '29616' '29620' '29621' '29622' '29623' '29624' '29625' '29626' '29630' '29631' '29632' '29633' '29634' '29635' '29640' '29641' '29642' '29643' '29644' '29645' '29646' '29650' '29651' '29653' '29654' '29655' '29656' '29660' '29661' '29662' '29663' '29664' '29665' '29666' '2967' '29680' '29681' '29682' '29689' '29690' '29699';
%let mood10 = 'F30', 'F31', 'F32', 'F33','F34', 'F39';
%let iteration = 20;

/*options validvarname = V7;*/



%macro ED (year);

data ED_&year; set data.ED_&year; 
d_1 =  substr(diag01, 1, 3); d_2  = substr(diag02, 1, 3); d_3  = substr(diag03, 1, 3); d_4  = substr(diag04, 1, 3); d_5  = substr(diag05, 1, 3); 
d_6 =  substr(diag06, 1, 3); d_7  = substr(diag07, 1, 3); d_8  = substr(diag08, 1, 3); d_9  = substr(diag09, 1, 3); d_10 = substr(diag10, 1, 3); 
d_11 = substr(diag11, 1, 3); d_12 = substr(diag12, 1, 3); d_13 = substr(diag13, 1, 3); d_14 = substr(diag14, 1, 3); d_15 = substr(diag15, 1, 3); 
d_16 = substr(diag16, 1, 3); d_17 = substr(diag17, 1, 3); d_18 = substr(diag18, 1, 3); d_19 = substr(diag19, 1, 3); d_20 = substr(diag20, 1, 3); 

rename Diag01 = Diag_1;  rename Diag02 = Diag_2;  rename Diag03 = Diag_3;   rename Diag04 = Diag_4;  rename Diag05 = Diag_5; 
rename Diag06 = Diag_6;  rename Diag07 = Diag_7;  rename Diag08 = Diag_8;   rename Diag09 = Diag_9;  rename Diag10 = Diag_10; 
rename Diag11 = Diag_11; rename Diag12 = Diag_12; rename Diag13 = Diag_13;  rename Diag14 = Diag_14; rename Diag15 = Diag_15; 
rename Diag16 = Diag_16; rename Diag17 = Diag_17; rename Diag18 = Diag_18;  rename Diag19 = Diag_19; rename Diag20 = Diag_20; 

run;

/*%do i=1 %to &iteration;*/
%do i=1 %to 20;

data ED_&year._&i (keep=DischYear DischQuarter PrvID PatZip PatStateCode PatCountyName Race_val race AgeInYears Gender_val AdmitType
PointOfOrigin DischargeStatus TotalCharge LOS Payer1_val  Payer1 MSDRG CaseMix PrincipalDiagCat_val PrincipalDiagCat 
diag_1-diag_20 d_1-d_20
/*diag_&i*/

Rev01 CPT01 Srv01 Rev02 CPT02 Srv02 Rev03 CPT03 CHIAID); 
set ED_&year;


where
   (DischYear <  2015 and diag_&i in (&cannabis9))
or (DischYear =  2015 and DischQuarter < 4 and diag_&i in (&cannabis9)) 
or (DischYear =  2015 and DischQuarter = 4 and d_&i in (&cannabis10)) 
or (DischYear >= 2016 and d_&i in (&cannabis10))
;run;

%end;

data dir.EDCom_&year;
set ED_&year._1 - ED_&year._20;
CAN1 = '1';
run;

%mend ED;
%ED (2013); /*  5,415 / 859861 */
%ED (2014); /*  6,935 / 926115 */
%ED (2015); /* 11,156  990881 */
%ED (2016); /* 14,442 /1027321 */
%ED (2017); /* 13,877/ 1062794 */
%ED (2018); /* 13,647/ 1107949 */
%ED (2019); /* 13,422/ 1153402 */
%ED (2020); /* 13,316/ 929563 */
%ED (2021); /* 11,876/ 1029364 */



/* Creating indicator variables */

%macro IND (year);

/*%do i=1 %to 20;*/

data IND_&year (keep=
DischYear DischQuarter PrvID PatZip PatStateCode PatCountyName Race_val Race AgeInYears Gender_val AdmitType
PointOfOrigin DischargeStatus TotalCharge LOS Payer1_val  Payer1 MSDRG CaseMix PrincipalDiagCat_val PrincipalDiagCat 
diag_1-diag_20 d_1-d_20
/*diag_&i*/
Rev01 CPT01 Srv01 Rev02 CPT02 Srv02 Rev03 CPT03 CHIAID CAN1
); 
set dir.EDCom_&year;
run; 

data IND_&year;
set IND_&year;  

/* Cannabis */

if (DischYear <  2015 and 
(diag_1  in (&cannabis9) or diag_2  in (&cannabis9) or diag_3  in (&cannabis9) or diag_4  in (&cannabis9) or diag_5  in (&cannabis9) or
 diag_6  in (&cannabis9) or diag_7  in (&cannabis9) or diag_8  in (&cannabis9) or diag_9  in (&cannabis9) or diag_10 in (&cannabis9) or
 diag_11 in (&cannabis9) or diag_12 in (&cannabis9) or diag_13 in (&cannabis9) or diag_14 in (&cannabis9) or diag_15 in (&cannabis9) or
 diag_16 in (&cannabis9) or diag_17 in (&cannabis9) or diag_18 in (&cannabis9) or diag_19 in (&cannabis9) or diag_20 in (&cannabis9) )
 )

or (DischYear =  2015 and DischQuarter < 4 and 
(diag_1  in (&cannabis9) or diag_2  in (&cannabis9) or diag_3  in (&cannabis9) or diag_4  in (&cannabis9) or diag_5  in (&cannabis9) or
 diag_6  in (&cannabis9) or diag_7  in (&cannabis9) or diag_8  in (&cannabis9) or diag_9  in (&cannabis9) or diag_10 in (&cannabis9) or
 diag_11 in (&cannabis9) or diag_12 in (&cannabis9) or diag_13 in (&cannabis9) or diag_14 in (&cannabis9) or diag_15 in (&cannabis9) or
 diag_16 in (&cannabis9) or diag_17 in (&cannabis9) or diag_18 in (&cannabis9) or diag_19 in (&cannabis9) or diag_20 in (&cannabis9) )
 )

or (DischYear =  2015 and DischQuarter = 4 and 
(d_1  in (&cannabis10) or d_2  in (&cannabis10) or d_3  in (&cannabis10) or d_4  in (&cannabis10) or d_5  in (&cannabis10) or
 d_6  in (&cannabis10) or d_7  in (&cannabis10) or d_8  in (&cannabis10) or d_9  in (&cannabis10) or d_10 in (&cannabis10) or
 d_11 in (&cannabis10) or d_12 in (&cannabis10) or d_13 in (&cannabis10) or d_14 in (&cannabis10) or d_15 in (&cannabis10) or
 d_16 in (&cannabis10) or d_17 in (&cannabis10) or d_18 in (&cannabis10) or d_19 in (&cannabis10) or d_20 in (&cannabis10) )
 ) 

or (DischYear >= 2016 and 
(d_1  in (&cannabis10) or d_2  in (&cannabis10) or d_3  in (&cannabis10) or d_4  in (&cannabis10) or d_5  in (&cannabis10) or
 d_6  in (&cannabis10) or d_7  in (&cannabis10) or d_8  in (&cannabis10) or d_9  in (&cannabis10) or d_10 in (&cannabis10) or
 d_11 in (&cannabis10) or d_12 in (&cannabis10) or d_13 in (&cannabis10) or d_14 in (&cannabis10) or d_15 in (&cannabis10) or
 d_16 in (&cannabis10) or d_17 in (&cannabis10) or d_18 in (&cannabis10) or d_19 in (&cannabis10) or d_20 in (&cannabis10) )
 ) 
then CAN = '1'; else CAN ='0';



/* nausea */
if (DischYear <  2015 and 
(diag_1  in (&nausea9) or diag_2  in (&nausea9) or diag_3  in (&nausea9) or diag_4  in (&nausea9) or diag_5  in (&nausea9) or
 diag_6  in (&nausea9) or diag_7  in (&nausea9) or diag_8  in (&nausea9) or diag_9  in (&nausea9) or diag_10 in (&nausea9) or
 diag_11 in (&nausea9) or diag_12 in (&nausea9) or diag_13 in (&nausea9) or diag_14 in (&nausea9) or diag_15 in (&nausea9) or
 diag_16 in (&nausea9) or diag_17 in (&nausea9) or diag_18 in (&nausea9) or diag_19 in (&nausea9) or diag_20 in (&nausea9) )
 )

or (DischYear =  2015 and DischQuarter < 4 and 
(diag_1  in (&nausea9) or diag_2  in (&nausea9) or diag_3  in (&nausea9) or diag_4  in (&nausea9) or diag_5  in (&nausea9) or
 diag_6  in (&nausea9) or diag_7  in (&nausea9) or diag_8  in (&nausea9) or diag_9  in (&nausea9) or diag_10 in (&nausea9) or
 diag_11 in (&nausea9) or diag_12 in (&nausea9) or diag_13 in (&nausea9) or diag_14 in (&nausea9) or diag_15 in (&nausea9) or
 diag_16 in (&nausea9) or diag_17 in (&nausea9) or diag_18 in (&nausea9) or diag_19 in (&nausea9) or diag_20 in (&nausea9) )
 )

or (DischYear =  2015 and DischQuarter = 4 and 
(d_1  in (&nausea10) or d_2  in (&nausea10) or d_3  in (&nausea10) or d_4  in (&nausea10) or d_5  in (&nausea10) or
 d_6  in (&nausea10) or d_7  in (&nausea10) or d_8  in (&nausea10) or d_9  in (&nausea10) or d_10 in (&nausea10) or
 d_11 in (&nausea10) or d_12 in (&nausea10) or d_13 in (&nausea10) or d_14 in (&nausea10) or d_15 in (&nausea10) or
 d_16 in (&nausea10) or d_17 in (&nausea10) or d_18 in (&nausea10) or d_19 in (&nausea10) or d_20 in (&nausea10) )
 ) 

or (DischYear >= 2016 and 
(d_1  in (&nausea10) or d_2  in (&nausea10) or d_3  in (&nausea10) or d_4  in (&nausea10) or d_5  in (&nausea10) or
 d_6  in (&nausea10) or d_7  in (&nausea10) or d_8  in (&nausea10) or d_9  in (&nausea10) or d_10 in (&nausea10) or
 d_11 in (&nausea10) or d_12 in (&nausea10) or d_13 in (&nausea10) or d_14 in (&nausea10) or d_15 in (&nausea10) or
 d_16 in (&nausea10) or d_17 in (&nausea10) or d_18 in (&nausea10) or d_19 in (&nausea10) or d_20 in (&nausea10) )
 ) 
then NAU = '1'; else NAU ='0';

/* Nicotine */

if (DischYear <  2015 and 
(diag_1  in (&nicotine9) or diag_2  in (&nicotine9) or diag_3  in (&nicotine9) or diag_4  in (&nicotine9) or diag_5  in (&nicotine9) or
 diag_6  in (&nicotine9) or diag_7  in (&nicotine9) or diag_8  in (&nicotine9) or diag_9  in (&nicotine9) or diag_10 in (&nicotine9) or
 diag_11 in (&nicotine9) or diag_12 in (&nicotine9) or diag_13 in (&nicotine9) or diag_14 in (&nicotine9) or diag_15 in (&nicotine9) or
 diag_16 in (&nicotine9) or diag_17 in (&nicotine9) or diag_18 in (&nicotine9) or diag_19 in (&nicotine9) or diag_20 in (&nicotine9) )
 )

or (DischYear =  2015 and DischQuarter < 4 and 
(diag_1  in (&nicotine9) or diag_2  in (&nicotine9) or diag_3  in (&nicotine9) or diag_4  in (&nicotine9) or diag_5  in (&nicotine9) or
 diag_6  in (&nicotine9) or diag_7  in (&nicotine9) or diag_8  in (&nicotine9) or diag_9  in (&nicotine9) or diag_10 in (&nicotine9) or
 diag_11 in (&nicotine9) or diag_12 in (&nicotine9) or diag_13 in (&nicotine9) or diag_14 in (&nicotine9) or diag_15 in (&nicotine9) or
 diag_16 in (&nicotine9) or diag_17 in (&nicotine9) or diag_18 in (&nicotine9) or diag_19 in (&nicotine9) or diag_20 in (&nicotine9) )
 )

or (DischYear =  2015 and DischQuarter = 4 and 
(d_1  in (&nicotine10) or d_2  in (&nicotine10) or d_3  in (&nicotine10) or d_4  in (&nicotine10) or d_5  in (&nicotine10) or
 d_6  in (&nicotine10) or d_7  in (&nicotine10) or d_8  in (&nicotine10) or d_9  in (&nicotine10) or d_10 in (&nicotine10) or
 d_11 in (&nicotine10) or d_12 in (&nicotine10) or d_13 in (&nicotine10) or d_14 in (&nicotine10) or d_15 in (&nicotine10) or
 d_16 in (&nicotine10) or d_17 in (&nicotine10) or d_18 in (&nicotine10) or d_19 in (&nicotine10) or d_20 in (&nicotine10) )
 ) 

or (DischYear >= 2016 and 
(d_1  in (&nicotine10) or d_2  in (&nicotine10) or d_3  in (&nicotine10) or d_4  in (&nicotine10) or d_5  in (&nicotine10) or
 d_6  in (&nicotine10) or d_7  in (&nicotine10) or d_8  in (&nicotine10) or d_9  in (&nicotine10) or d_10 in (&nicotine10) or
 d_11 in (&nicotine10) or d_12 in (&nicotine10) or d_13 in (&nicotine10) or d_14 in (&nicotine10) or d_15 in (&nicotine10) or
 d_16 in (&nicotine10) or d_17 in (&nicotine10) or d_18 in (&nicotine10) or d_19 in (&nicotine10) or d_20 in (&nicotine10) )
 ) 
then NIC = '1'; else NIC ='0';

/* Alcohol */
if (DischYear <  2015 and 
(diag_1  in (&alcohol9) or diag_2  in (&alcohol9) or diag_3  in (&alcohol9) or diag_4  in (&alcohol9) or diag_5  in (&alcohol9) or
 diag_6  in (&alcohol9) or diag_7  in (&alcohol9) or diag_8  in (&alcohol9) or diag_9  in (&alcohol9) or diag_10 in (&alcohol9) or
 diag_11 in (&alcohol9) or diag_12 in (&alcohol9) or diag_13 in (&alcohol9) or diag_14 in (&alcohol9) or diag_15 in (&alcohol9) or
 diag_16 in (&alcohol9) or diag_17 in (&alcohol9) or diag_18 in (&alcohol9) or diag_19 in (&alcohol9) or diag_20 in (&alcohol9) )
 )

or (DischYear =  2015 and DischQuarter < 4 and 
(diag_1  in (&alcohol9) or diag_2  in (&alcohol9) or diag_3  in (&alcohol9) or diag_4  in (&alcohol9) or diag_5  in (&alcohol9) or
 diag_6  in (&alcohol9) or diag_7  in (&alcohol9) or diag_8  in (&alcohol9) or diag_9  in (&alcohol9) or diag_10 in (&alcohol9) or
 diag_11 in (&alcohol9) or diag_12 in (&alcohol9) or diag_13 in (&alcohol9) or diag_14 in (&alcohol9) or diag_15 in (&alcohol9) or
 diag_16 in (&alcohol9) or diag_17 in (&alcohol9) or diag_18 in (&alcohol9) or diag_19 in (&alcohol9) or diag_20 in (&alcohol9) )
 )

or (DischYear =  2015 and DischQuarter = 4 and 
(d_1  in (&alcohol10) or d_2  in (&alcohol10) or d_3  in (&alcohol10) or d_4  in (&alcohol10) or d_5  in (&alcohol10) or
 d_6  in (&alcohol10) or d_7  in (&alcohol10) or d_8  in (&alcohol10) or d_9  in (&alcohol10) or d_10 in (&alcohol10) or
 d_11 in (&alcohol10) or d_12 in (&alcohol10) or d_13 in (&alcohol10) or d_14 in (&alcohol10) or d_15 in (&alcohol10) or
 d_16 in (&alcohol10) or d_17 in (&alcohol10) or d_18 in (&alcohol10) or d_19 in (&alcohol10) or d_20 in (&alcohol10) )
 ) 

or (DischYear >= 2016 and 
(d_1  in (&alcohol10) or d_2  in (&alcohol10) or d_3  in (&alcohol10) or d_4  in (&alcohol10) or d_5  in (&alcohol10) or
 d_6  in (&alcohol10) or d_7  in (&alcohol10) or d_8  in (&alcohol10) or d_9  in (&alcohol10) or d_10 in (&alcohol10) or
 d_11 in (&alcohol10) or d_12 in (&alcohol10) or d_13 in (&alcohol10) or d_14 in (&alcohol10) or d_15 in (&alcohol10) or
 d_16 in (&alcohol10) or d_17 in (&alcohol10) or d_18 in (&alcohol10) or d_19 in (&alcohol10) or d_20 in (&alcohol10) )
 ) 
then ALC = '1'; else ALC ='0';


/* Opioid */
if (DischYear <  2015 and 
(diag_1  in (&opioid9) or diag_2  in (&opioid9) or diag_3  in (&opioid9) or diag_4  in (&opioid9) or diag_5  in (&opioid9) or
 diag_6  in (&opioid9) or diag_7  in (&opioid9) or diag_8  in (&opioid9) or diag_9  in (&opioid9) or diag_10 in (&opioid9) or
 diag_11 in (&opioid9) or diag_12 in (&opioid9) or diag_13 in (&opioid9) or diag_14 in (&opioid9) or diag_15 in (&opioid9) or
 diag_16 in (&opioid9) or diag_17 in (&opioid9) or diag_18 in (&opioid9) or diag_19 in (&opioid9) or diag_20 in (&opioid9) )
 )

or (DischYear =  2015 and DischQuarter < 4 and 
(diag_1  in (&opioid9) or diag_2  in (&opioid9) or diag_3  in (&opioid9) or diag_4  in (&opioid9) or diag_5  in (&opioid9) or
 diag_6  in (&opioid9) or diag_7  in (&opioid9) or diag_8  in (&opioid9) or diag_9  in (&opioid9) or diag_10 in (&opioid9) or
 diag_11 in (&opioid9) or diag_12 in (&opioid9) or diag_13 in (&opioid9) or diag_14 in (&opioid9) or diag_15 in (&opioid9) or
 diag_16 in (&opioid9) or diag_17 in (&opioid9) or diag_18 in (&opioid9) or diag_19 in (&opioid9) or diag_20 in (&opioid9) )
 )

or (DischYear =  2015 and DischQuarter = 4 and 
(d_1  in (&opioid10) or d_2  in (&opioid10) or d_3  in (&opioid10) or d_4  in (&opioid10) or d_5  in (&opioid10) or
 d_6  in (&opioid10) or d_7  in (&opioid10) or d_8  in (&opioid10) or d_9  in (&opioid10) or d_10 in (&opioid10) or
 d_11 in (&opioid10) or d_12 in (&opioid10) or d_13 in (&opioid10) or d_14 in (&opioid10) or d_15 in (&opioid10) or
 d_16 in (&opioid10) or d_17 in (&opioid10) or d_18 in (&opioid10) or d_19 in (&opioid10) or d_20 in (&opioid10) )
 ) 

or (DischYear >= 2016 and 
(d_1  in (&opioid10) or d_2  in (&opioid10) or d_3  in (&opioid10) or d_4  in (&opioid10) or d_5  in (&opioid10) or
 d_6  in (&opioid10) or d_7  in (&opioid10) or d_8  in (&opioid10) or d_9  in (&opioid10) or d_10 in (&opioid10) or
 d_11 in (&opioid10) or d_12 in (&opioid10) or d_13 in (&opioid10) or d_14 in (&opioid10) or d_15 in (&opioid10) or
 d_16 in (&opioid10) or d_17 in (&opioid10) or d_18 in (&opioid10) or d_19 in (&opioid10) or d_20 in (&opioid10) )
 ) 
then OPI = '1'; else OPI ='0';


/* Sedatives */

if (DischYear <  2015 and 
(diag_1  in (&sedatives9) or diag_2  in (&sedatives9) or diag_3  in (&sedatives9) or diag_4  in (&sedatives9) or diag_5  in (&sedatives9) or
 diag_6  in (&sedatives9) or diag_7  in (&sedatives9) or diag_8  in (&sedatives9) or diag_9  in (&sedatives9) or diag_10 in (&sedatives9) or
 diag_11 in (&sedatives9) or diag_12 in (&sedatives9) or diag_13 in (&sedatives9) or diag_14 in (&sedatives9) or diag_15 in (&sedatives9) or
 diag_16 in (&sedatives9) or diag_17 in (&sedatives9) or diag_18 in (&sedatives9) or diag_19 in (&sedatives9) or diag_20 in (&sedatives9) )
 )

or (DischYear =  2015 and DischQuarter < 4 and 
(diag_1  in (&sedatives9) or diag_2  in (&sedatives9) or diag_3  in (&sedatives9) or diag_4  in (&sedatives9) or diag_5  in (&sedatives9) or
 diag_6  in (&sedatives9) or diag_7  in (&sedatives9) or diag_8  in (&sedatives9) or diag_9  in (&sedatives9) or diag_10 in (&sedatives9) or
 diag_11 in (&sedatives9) or diag_12 in (&sedatives9) or diag_13 in (&sedatives9) or diag_14 in (&sedatives9) or diag_15 in (&sedatives9) or
 diag_16 in (&sedatives9) or diag_17 in (&sedatives9) or diag_18 in (&sedatives9) or diag_19 in (&sedatives9) or diag_20 in (&sedatives9) )
 )

or (DischYear =  2015 and DischQuarter = 4 and 
(d_1  in (&sedatives10) or d_2  in (&sedatives10) or d_3  in (&sedatives10) or d_4  in (&sedatives10) or d_5  in (&sedatives10) or
 d_6  in (&sedatives10) or d_7  in (&sedatives10) or d_8  in (&sedatives10) or d_9  in (&sedatives10) or d_10 in (&sedatives10) or
 d_11 in (&sedatives10) or d_12 in (&sedatives10) or d_13 in (&sedatives10) or d_14 in (&sedatives10) or d_15 in (&sedatives10) or
 d_16 in (&sedatives10) or d_17 in (&sedatives10) or d_18 in (&sedatives10) or d_19 in (&sedatives10) or d_20 in (&sedatives10) )
 ) 

or (DischYear >= 2016 and 
(d_1  in (&sedatives10) or d_2  in (&sedatives10) or d_3  in (&sedatives10) or d_4  in (&sedatives10) or d_5  in (&sedatives10) or
 d_6  in (&sedatives10) or d_7  in (&sedatives10) or d_8  in (&sedatives10) or d_9  in (&sedatives10) or d_10 in (&sedatives10) or
 d_11 in (&sedatives10) or d_12 in (&sedatives10) or d_13 in (&sedatives10) or d_14 in (&sedatives10) or d_15 in (&sedatives10) or
 d_16 in (&sedatives10) or d_17 in (&sedatives10) or d_18 in (&sedatives10) or d_19 in (&sedatives10) or d_20 in (&sedatives10) )
 ) 
then SED = '1'; else SED ='0';


/* Cocaine */

if (DischYear <  2015 and 
(diag_1  in (&cocaine9) or diag_2  in (&cocaine9) or diag_3  in (&cocaine9) or diag_4  in (&cocaine9) or diag_5  in (&cocaine9) or
 diag_6  in (&cocaine9) or diag_7  in (&cocaine9) or diag_8  in (&cocaine9) or diag_9  in (&cocaine9) or diag_10 in (&cocaine9) or
 diag_11 in (&cocaine9) or diag_12 in (&cocaine9) or diag_13 in (&cocaine9) or diag_14 in (&cocaine9) or diag_15 in (&cocaine9) or
 diag_16 in (&cocaine9) or diag_17 in (&cocaine9) or diag_18 in (&cocaine9) or diag_19 in (&cocaine9) or diag_20 in (&cocaine9) )
 )

or (DischYear =  2015 and DischQuarter < 4 and 
(diag_1  in (&cocaine9) or diag_2  in (&cocaine9) or diag_3  in (&cocaine9) or diag_4  in (&cocaine9) or diag_5  in (&cocaine9) or
 diag_6  in (&cocaine9) or diag_7  in (&cocaine9) or diag_8  in (&cocaine9) or diag_9  in (&cocaine9) or diag_10 in (&cocaine9) or
 diag_11 in (&cocaine9) or diag_12 in (&cocaine9) or diag_13 in (&cocaine9) or diag_14 in (&cocaine9) or diag_15 in (&cocaine9) or
 diag_16 in (&cocaine9) or diag_17 in (&cocaine9) or diag_18 in (&cocaine9) or diag_19 in (&cocaine9) or diag_20 in (&cocaine9) )
 )

or (DischYear =  2015 and DischQuarter = 4 and 
(d_1  in (&cocaine10) or d_2  in (&cocaine10) or d_3  in (&cocaine10) or d_4  in (&cocaine10) or d_5  in (&cocaine10) or
 d_6  in (&cocaine10) or d_7  in (&cocaine10) or d_8  in (&cocaine10) or d_9  in (&cocaine10) or d_10 in (&cocaine10) or
 d_11 in (&cocaine10) or d_12 in (&cocaine10) or d_13 in (&cocaine10) or d_14 in (&cocaine10) or d_15 in (&cocaine10) or
 d_16 in (&cocaine10) or d_17 in (&cocaine10) or d_18 in (&cocaine10) or d_19 in (&cocaine10) or d_20 in (&cocaine10) )
 ) 

or (DischYear >= 2016 and 
(d_1  in (&cocaine10) or d_2  in (&cocaine10) or d_3  in (&cocaine10) or d_4  in (&cocaine10) or d_5  in (&cocaine10) or
 d_6  in (&cocaine10) or d_7  in (&cocaine10) or d_8  in (&cocaine10) or d_9  in (&cocaine10) or d_10 in (&cocaine10) or
 d_11 in (&cocaine10) or d_12 in (&cocaine10) or d_13 in (&cocaine10) or d_14 in (&cocaine10) or d_15 in (&cocaine10) or
 d_16 in (&cocaine10) or d_17 in (&cocaine10) or d_18 in (&cocaine10) or d_19 in (&cocaine10) or d_20 in (&cocaine10) )
 ) 
then COC = '1'; else COC ='0';


/* SHO */

if (DischYear <  2015 and 
(diag_1  in (&SHO9) or diag_2  in (&SHO9) or diag_3  in (&SHO9) or diag_4  in (&SHO9) or diag_5  in (&SHO9) or
 diag_6  in (&SHO9) or diag_7  in (&SHO9) or diag_8  in (&SHO9) or diag_9  in (&SHO9) or diag_10 in (&SHO9) or
 diag_11 in (&SHO9) or diag_12 in (&SHO9) or diag_13 in (&SHO9) or diag_14 in (&SHO9) or diag_15 in (&SHO9) or
 diag_16 in (&SHO9) or diag_17 in (&SHO9) or diag_18 in (&SHO9) or diag_19 in (&SHO9) or diag_20 in (&SHO9) )
 )

or (DischYear =  2015 and DischQuarter < 4 and 
(diag_1  in (&SHO9) or diag_2  in (&SHO9) or diag_3  in (&SHO9) or diag_4  in (&SHO9) or diag_5  in (&SHO9) or
 diag_6  in (&SHO9) or diag_7  in (&SHO9) or diag_8  in (&SHO9) or diag_9  in (&SHO9) or diag_10 in (&SHO9) or
 diag_11 in (&SHO9) or diag_12 in (&SHO9) or diag_13 in (&SHO9) or diag_14 in (&SHO9) or diag_15 in (&SHO9) or
 diag_16 in (&SHO9) or diag_17 in (&SHO9) or diag_18 in (&SHO9) or diag_19 in (&SHO9) or diag_20 in (&SHO9) )
 )

or (DischYear =  2015 and DischQuarter = 4 and 
(d_1  in (&SHO10) or d_2  in (&SHO10) or d_3  in (&SHO10) or d_4  in (&SHO10) or d_5  in (&SHO10) or
 d_6  in (&SHO10) or d_7  in (&SHO10) or d_8  in (&SHO10) or d_9  in (&SHO10) or d_10 in (&SHO10) or
 d_11 in (&SHO10) or d_12 in (&SHO10) or d_13 in (&SHO10) or d_14 in (&SHO10) or d_15 in (&SHO10) or
 d_16 in (&SHO10) or d_17 in (&SHO10) or d_18 in (&SHO10) or d_19 in (&SHO10) or d_20 in (&SHO10) )
 ) 

or (DischYear >= 2016 and 
(d_1  in (&SHO10) or d_2  in (&SHO10) or d_3  in (&SHO10) or d_4  in (&SHO10) or d_5  in (&SHO10) or
 d_6  in (&SHO10) or d_7  in (&SHO10) or d_8  in (&SHO10) or d_9  in (&SHO10) or d_10 in (&SHO10) or
 d_11 in (&SHO10) or d_12 in (&SHO10) or d_13 in (&SHO10) or d_14 in (&SHO10) or d_15 in (&SHO10) or
 d_16 in (&SHO10) or d_17 in (&SHO10) or d_18 in (&SHO10) or d_19 in (&SHO10) or d_20 in (&SHO10) )
 ) 
then SHO = '1'; else SHO ='0';



/* Mood */

if (DischYear <  2015 and 
(diag_1  in (&mood9) or diag_2  in (&mood9) or diag_3  in (&mood9) or diag_4  in (&mood9) or diag_5  in (&mood9) or
 diag_6  in (&mood9) or diag_7  in (&mood9) or diag_8  in (&mood9) or diag_9  in (&mood9) or diag_10 in (&mood9) or
 diag_11 in (&mood9) or diag_12 in (&mood9) or diag_13 in (&mood9) or diag_14 in (&mood9) or diag_15 in (&mood9) or
 diag_16 in (&mood9) or diag_17 in (&mood9) or diag_18 in (&mood9) or diag_19 in (&mood9) or diag_20 in (&mood9) )
 )

or (DischYear =  2015 and DischQuarter < 4 and 
(diag_1  in (&MOOD9) or diag_2  in (&MOOD9) or diag_3  in (&MOOD9) or diag_4  in (&MOOD9) or diag_5  in (&MOOD9) or
 diag_6  in (&MOOD9) or diag_7  in (&MOOD9) or diag_8  in (&MOOD9) or diag_9  in (&MOOD9) or diag_10 in (&MOOD9) or
 diag_11 in (&MOOD9) or diag_12 in (&MOOD9) or diag_13 in (&MOOD9) or diag_14 in (&MOOD9) or diag_15 in (&MOOD9) or
 diag_16 in (&MOOD9) or diag_17 in (&MOOD9) or diag_18 in (&MOOD9) or diag_19 in (&MOOD9) or diag_20 in (&MOOD9) )
 )

or (DischYear =  2015 and DischQuarter = 4 and 
(d_1  in (&MOOD10) or d_2  in (&MOOD10) or d_3  in (&MOOD10) or d_4  in (&MOOD10) or d_5  in (&MOOD10) or
 d_6  in (&MOOD10) or d_7  in (&MOOD10) or d_8  in (&MOOD10) or d_9  in (&MOOD10) or d_10 in (&MOOD10) or
 d_11 in (&MOOD10) or d_12 in (&MOOD10) or d_13 in (&MOOD10) or d_14 in (&MOOD10) or d_15 in (&MOOD10) or
 d_16 in (&MOOD10) or d_17 in (&MOOD10) or d_18 in (&MOOD10) or d_19 in (&MOOD10) or d_20 in (&MOOD10) )
 ) 

or (DischYear >= 2016 and 
(d_1  in (&MOOD10) or d_2  in (&MOOD10) or d_3  in (&MOOD10) or d_4  in (&MOOD10) or d_5  in (&MOOD10) or
 d_6  in (&MOOD10) or d_7  in (&MOOD10) or d_8  in (&MOOD10) or d_9  in (&MOOD10) or d_10 in (&MOOD10) or
 d_11 in (&MOOD10) or d_12 in (&MOOD10) or d_13 in (&MOOD10) or d_14 in (&MOOD10) or d_15 in (&MOOD10) or
 d_16 in (&MOOD10) or d_17 in (&MOOD10) or d_18 in (&MOOD10) or d_19 in (&MOOD10) or d_20 in (&MOOD10) )
 ) 
then MOD = '1'; else MOD ='0';


run;

/*%end;*/

/* 
data IND_&year;
set IND_&year._1 - IND_&year._20;
run;
*/
/**/
/*proc delete data=IND_&year._1 - IND_&year._20;*/
/*run;*/

%mend IND;
%IND (2013);
%IND (2014);
%IND (2015);
%IND (2016);
%IND (2017);
%IND (2018);
%IND (2019);
%IND (2020);
%IND (2021);




/* IGNORE INDB BELOW ? */

%macro INDB (year);

%do i=1 %to 20;

data IND_&year._&i (keep=
DischYear DischQuarter PrvID PatZip PatStateCode PatCountyName Race_val Race AgeInYears Gender_val AdmitType
PointOfOrigin DischargeStatus TotalCharge LOS Payer1_val  Payer1 MSDRG CaseMix PrincipalDiagCat_val PrincipalDiagCat 
diag_1-diag_20 d_1-d_20
diag_&i

Rev01 CPT01 Srv01 Rev02 CPT02 Srv02 Rev03 CPT03 CHIAID can1
); 
set dir.EDCom_&year;
run; 

data IND_&year._&i;
set IND_&year._&i;  

/* Cannabis */
if (DischYear <  2015 and diag_&i in (&cannabis9)) 
or (DischYear =  2015 and DischQuarter < 4 and diag_&i in (&cannabis9)) 
or (DischYear =  2015 and DischQuarter = 4 and d_&i in (&cannabis10)) 
or (DischYear >= 2016 and d_&i in (&cannabis10)) 
then CAN = '1'; else CAN ='0';


/* nausea */
if (DischYear <  2015 and diag_&i in (&nausea9)) 
or (DischYear =  2015 and DischQuarter < 4 and diag_&i in (&nausea9)) 
or (DischYear =  2015 and DischQuarter = 4 and d_&i in (&nausea10)) 
or (DischYear >= 2016 and d_&i in (&nausea10)) 
then NAU = '1'; else NAU ='0';

/* nicotine */
if (DischYear <  2015 and diag_&i in (&nicotine9)) 
or (DischYear =  2015 and DischQuarter < 4 and diag_&i in (&nicotine9)) 
or (DischYear =  2015 and DischQuarter = 4 and d_&i in (&nicotine10)) 
or (DischYear >= 2016 and d_&i in (&nicotine10)) 
then NIC = '1'; else NIC ='0';


/* alcohol */
if (DischYear <  2015 and diag_&i in (&alcohol9)) 
or (DischYear =  2015 and DischQuarter < 4 and diag_&i in (&alcohol9)) 
or (DischYear =  2015 and DischQuarter = 4 and d_&i in (&alcohol10)) 
or (DischYear >= 2016 and d_&i in (&alcohol10)) 
then ALC = '1'; else ALC ='0';


/* opioid */
if (DischYear <  2015 and diag_&i in (&opioid9)) 
or (DischYear =  2015 and DischQuarter < 4 and diag_&i in (&opioid9)) 
or (DischYear =  2015 and DischQuarter = 4 and d_&i in (&opioid10)) 
or (DischYear >= 2016 and d_&i in (&opioid10)) 
then OPI = '1'; else OPI ='0';


/* sedative */
if (DischYear <  2015 and diag_&i in (&sedatives9)) 
or (DischYear =  2015 and DischQuarter < 4 and diag_&i in (&sedatives9)) 
or (DischYear =  2015 and DischQuarter = 4 and d_&i in (&sedatives10)) 
or (DischYear >= 2016 and d_&i in (&sedatives10)) 
then SED = '1'; else SED ='0';


/* cocaine */
if (DischYear <  2015 and diag_&i in (&cocaine9)) 
or (DischYear =  2015 and DischQuarter < 4 and diag_&i in (&cocaine9)) 
or (DischYear =  2015 and DischQuarter = 4 and d_&i in (&cocaine10)) 
or (DischYear >= 2016 and d_&i in (&cocaine10)) 
then COC = '1'; else COC ='0';


/* SHO9 */
if (DischYear <  2015 and diag_&i in (&SHO9)) 
or (DischYear =  2015 and DischQuarter < 4 and diag_&i in (&SHO9)) 
or (DischYear =  2015 and DischQuarter = 4 and d_&i in (&SHO10)) 
or (DischYear >= 2016 and d_&i in (&SHO10)) 
then SHO = '1'; else SHO ='0';


/* mood */
/*
if 
(DischYear <  2016 and diag_&i in (&mood9)) or (DischYear >= 2016 and d_&i in (&mood10)) 
then MOD = '1'; else MOD ='0';
*/
run;

%end;

data IND_&year;
set IND_&year._1 - IND_&year._20;
run;
/**/
/*proc delete data=IND_&year._1 - IND_&year._20;*/
/*run;*/

%mend INDB;
%INDB (2013); /* 108300 */

/* 
IND and INDB give the same numbers for counts of each diagnosis
BUT USE IND as INDB generates duplicates
*/


/*proc freq data=ind_2015; table can; where dischquarter=4; run;*/
/*proc freq data=ind_2013; table can nau; run;*/
/*proc freq data=ind_2015; table can; by dischquarter; run;*/

data dir.IND_All 
(keep= time dischyear dischquarter patzip patcountyname race_val Race AgeInYears agegrp gender_val payer1 can2 can nau nic alc opi sed coc sho mod);
set IND_2013 - IND_2021;
if ageinyears <12 then agegrp='Under12';
else if ageinyears <20 then agegrp='12-19';
else if ageinyears <30 then agegrp='21-29';
else if ageinyears <45 then agegrp='30-44';
else if ageinyears <65 then agegrp='45-64';
else if ageinyears => 65 then agegrp='65UP';

run;


/* Total Count */

%macro CNT (year, quarter);

proc sql; create table cnt_&year._&quarter
as select 
dischYear as YR,
dischquarter as QT,
count (*) as denom,

from data.ed_&year
where dischquarter in (&quarter);
quit;

proc sort data=cnt_&year._&quarter nodupkey; by yr qt denom ;run;

%mend CNT;
%CNT (2013, 1);
%CNT (2013, 2);
%CNT (2013, 3);
%CNT (2013, 4);
%CNT (2014, 1);
%CNT (2014, 2);
%CNT (2014, 3);
%CNT (2014, 4);
%CNT (2015, 1);
%CNT (2015, 2);
%CNT (2015, 3);
%CNT (2015, 4);
%CNT (2016, 1);
%CNT (2016, 2);
%CNT (2016, 3);
%CNT (2016, 4);
%CNT (2017, 1);
%CNT (2017, 2);
%CNT (2017, 3);
%CNT (2017, 4);
%CNT (2018, 1);
%CNT (2018, 2);
%CNT (2018, 3);
%CNT (2018, 4);
%CNT (2019, 1);
%CNT (2019, 2);
%CNT (2019, 3);
%CNT (2019, 4);
%CNT (2020, 1);
%CNT (2020, 2);
%CNT (2020, 3);
%CNT (2020, 4);
%CNT (2021, 1);
%CNT (2021, 2);
%CNT (2021, 3);
%CNT (2021, 4);


data dir.tcnt;
set 
cnt_2013_1 - cnt_2013_4 cnt_2014_1 - cnt_2014_4 cnt_2015_1 - cnt_2015_4 cnt_2016_1 - cnt_2016_4
cnt_2017_1 - cnt_2017_4 cnt_2018_1 - cnt_2018_4 cnt_2019_1 - cnt_2019_4 cnt_2020_1 - cnt_2020_4
cnt_2021_1 - cnt_2021_4 ;
run;



proc sql; create table dir.AGG
as select 
dischYear as YR,
dischquarter as QT,
/*count (*) as denom,*/
sum (can='1') as CAN,
count (can='1') as CAN,
sum (nau='1') as NAU,
sum (nic='1') as NIC,
sum (alc='1') as ALC,
sum (opi='1') as OPI,
sum (sed='1') as SED,
sum (coc='1') as COC,
sum (sho='1') as SHO

from dir.ind_all

group by DischYear, DischQuarter
order by DischYear, DischQuarter;
quit;




proc sql; create table dir.AGG
as select 
dischYear as YR,
dischquarter as QT,
/*count (*) as denom,*/
sum (can='1') as CAN,
sum (nau='1') as NAU,
sum (nic='1') as NIC,
sum (alc='1') as ALC,
sum (opi='1') as OPI,
sum (sed='1') as SED,
sum (coc='1') as COC,
sum (sho='1') as SHO,

sum (race_val=2) as ASIA,
sum (race_val=3) as AFRI,
sum (race_val=4) as WHIT,
sum (race_val=5) as HISP,

sum (gender_val='F') as F,
sum (gender_val='M') as M

/*sum(case when race_val = 2 then 1 else 0 end) as ASIA*/

from dir.ind_all

group by DischYear, DischQuarter
order by DischYear, DischQuarter;
quit;


data test; set dir.ind_all; /* 13240 */
if dischyear ='2014' and dischquarter ='1' and gender_val ='M';
run;


proc sql; create table dir.agg1
as select 
a.*,
b.denom as denom,
a.can/b.denom as can_r,
a.nic/b.denom as nic_r,
a.alc/b.denom as alc_r,
a.nau/b.denom as nau_r,
a.opi/b.denom as opi_r,
a.sed/b.denom as sed_r,
a.coc/b.denom as coc_r,
a.sho/b.denom as sho_r

from dir.agg as a
left join dir.tcnt as b on a.yr=b.yr and a.qt=b.qt;
quit;

data tmod;
   input tm t tx x zt zx ztx;
   datalines;
201301 1 0 0 1 0 0
201302 2 0 0 2 0 0
201303 3 0 0 3 0 0
201304 4 0 0 4 0 0
201401 5 0 0 5 0 0
201402 6 0 0 6 0 0
201403 7 0 0 7 0 0
201404 8 0 0 8 0 0
201501 9 0 0 9 0 0
201502 10 0 0 10 0 0
201503 11 0 0 11 0 0
201504 12 0 0 12 0 0
201601 13 0 0 13 0 0
201602 14 0 0 14 0 0
201603 15 0 0 15 0 0
201604 16 0 0 16 0 0
201701 17 0 0 17 0 0
201702 18 0 0 18 0 0
201703 19 0 0 19 0 0
201704 20 0 0 20 0 0
201801 21 1 1 21 1 1
201802 22 2 1 22 2 1
201803 23 3 1 23 3 1
201804 24 4 1 24 4 1
201901 25 5 1 25 5 1
201902 26 6 1 26 6 1
201903 27 7 1 27 7 1
201904 28 8 1 28 8 1
202001 29 9 1 29 9 1
202002 30 10 1 30 10 1
202003 31 11 1 31 11 1
202004 32 12 1 32 12 1
202101 33 13 1 33 13 1
202102 34 14 1 34 14 1
202103 35 15 1 35 15 1
202104 36 16 1 36 16 1
;
run;


data dir.agg2; set dir.agg1; 
tm=yr*100+qt;
if tm gt 201702 then RCM=1; else RCM=0;
if tm gt 201704 then RCM1=1; else RCM1=0;
z=1;
run;



proc sql; create table dir.agg3
as select 
a.*,
b.t,
b.tx,
b.x,
b.zt,
b.zx,
b.ztx

from dir.agg2  as a
left join tmod as b on a.tm=b.tm;
quit;



proc export data= dir.agg
	outfile = "C:\Users\kimy89\Dropbox\Research\GI-ED\data\data"
	DBMS=xlsx REPLACE;
	sheet="GI-ED";
run;


/* End of WIHT CANNABIS */


/* BEGINNING of WIHTOUT CANNABIS */



%macro EDW (year);

data EDW_&year; set data.ED_&year; 
d_1 =  substr(diag01, 1, 3); d_2  = substr(diag02, 1, 3); d_3  = substr(diag03, 1, 3); d_4  = substr(diag04, 1, 3); d_5  = substr(diag05, 1, 3); 
d_6 =  substr(diag06, 1, 3); d_7  = substr(diag07, 1, 3); d_8  = substr(diag08, 1, 3); d_9  = substr(diag09, 1, 3); d_10 = substr(diag10, 1, 3); 
d_11 = substr(diag11, 1, 3); d_12 = substr(diag12, 1, 3); d_13 = substr(diag13, 1, 3); d_14 = substr(diag14, 1, 3); d_15 = substr(diag15, 1, 3); 
d_16 = substr(diag16, 1, 3); d_17 = substr(diag17, 1, 3); d_18 = substr(diag18, 1, 3); d_19 = substr(diag19, 1, 3); d_20 = substr(diag20, 1, 3); 

rename Diag01 = Diag_1;  rename Diag02 = Diag_2;  rename Diag03 = Diag_3;   rename Diag04 = Diag_4;  rename Diag05 = Diag_5; 
rename Diag06 = Diag_6;  rename Diag07 = Diag_7;  rename Diag08 = Diag_8;   rename Diag09 = Diag_9;  rename Diag10 = Diag_10; 
rename Diag11 = Diag_11; rename Diag12 = Diag_12; rename Diag13 = Diag_13;  rename Diag14 = Diag_14; rename Diag15 = Diag_15; 
rename Diag16 = Diag_16; rename Diag17 = Diag_17; rename Diag18 = Diag_18;  rename Diag19 = Diag_19; rename Diag20 = Diag_20; 

run;

data EDW_&year (keep=DischYear DischQuarter PrvID PatZip PatStateCode PatCountyName Race_val AgeInYears Gender_val AdmitType
PointOfOrigin DischargeStatus TotalCharge LOS Payer1_val  Payer1 MSDRG CaseMix PrincipalDiagCat_val PrincipalDiagCat 
diag_1-diag_20 d_1-d_20
/*diag_&i*/

Rev01 CPT01 Srv01 Rev02 CPT02 Srv02 Rev03 CPT03 CHIAID can1 ); 
set EDW_&year;

if (DischYear <  2015 and 
(diag_1  in (&cannabis9) or diag_2  in (&cannabis9) or diag_3  in (&cannabis9) or diag_4  in (&cannabis9) or diag_5  in (&cannabis9) or
 diag_6  in (&cannabis9) or diag_7  in (&cannabis9) or diag_8  in (&cannabis9) or diag_9  in (&cannabis9) or diag_10 in (&cannabis9) or
 diag_11 in (&cannabis9) or diag_12 in (&cannabis9) or diag_13 in (&cannabis9) or diag_14 in (&cannabis9) or diag_15 in (&cannabis9) or
 diag_16 in (&cannabis9) or diag_17 in (&cannabis9) or diag_18 in (&cannabis9) or diag_19 in (&cannabis9) or diag_20 in (&cannabis9) )
 )

or (DischYear =  2015 and DischQuarter < 4 and 
(diag_1  in (&cannabis9) or diag_2  in (&cannabis9) or diag_3  in (&cannabis9) or diag_4  in (&cannabis9) or diag_5  in (&cannabis9) or
 diag_6  in (&cannabis9) or diag_7  in (&cannabis9) or diag_8  in (&cannabis9) or diag_9  in (&cannabis9) or diag_10 in (&cannabis9) or
 diag_11 in (&cannabis9) or diag_12 in (&cannabis9) or diag_13 in (&cannabis9) or diag_14 in (&cannabis9) or diag_15 in (&cannabis9) or
 diag_16 in (&cannabis9) or diag_17 in (&cannabis9) or diag_18 in (&cannabis9) or diag_19 in (&cannabis9) or diag_20 in (&cannabis9) )
 )

or (DischYear =  2015 and DischQuarter = 4 and 
(d_1  in (&cannabis10) or d_2  in (&cannabis10) or d_3  in (&cannabis10) or d_4  in (&cannabis10) or d_5  in (&cannabis10) or
 d_6  in (&cannabis10) or d_7  in (&cannabis10) or d_8  in (&cannabis10) or d_9  in (&cannabis10) or d_10 in (&cannabis10) or
 d_11 in (&cannabis10) or d_12 in (&cannabis10) or d_13 in (&cannabis10) or d_14 in (&cannabis10) or d_15 in (&cannabis10) or
 d_16 in (&cannabis10) or d_17 in (&cannabis10) or d_18 in (&cannabis10) or d_19 in (&cannabis10) or d_20 in (&cannabis10) )
 ) 

or (DischYear >= 2016 and 
(d_1  in (&cannabis10) or d_2  in (&cannabis10) or d_3  in (&cannabis10) or d_4  in (&cannabis10) or d_5  in (&cannabis10) or
 d_6  in (&cannabis10) or d_7  in (&cannabis10) or d_8  in (&cannabis10) or d_9  in (&cannabis10) or d_10 in (&cannabis10) or
 d_11 in (&cannabis10) or d_12 in (&cannabis10) or d_13 in (&cannabis10) or d_14 in (&cannabis10) or d_15 in (&cannabis10) or
 d_16 in (&cannabis10) or d_17 in (&cannabis10) or d_18 in (&cannabis10) or d_19 in (&cannabis10) or d_20 in (&cannabis10) )
 ) 
then CAN1 = '1'; else CAN1 ='0';

run;

data EDW_&year; set EDW_&year;
where can1='0';
run;

%mend EDW;
%EDW (2013); /*   854,446 +  5,415 =   859,861 */
%EDW (2014); /*   919,171 +  6,935 =   926,115 */
%EDW (2015); /*   979,734 + 11,156 =   990,881 */
%EDW (2016); /* 1,012,893 + 14,442 = 1,027,321 */
%EDW (2017); /* 1,048,939 + 13,877 = 1,062,794 */
%EDW (2018); /* 1,094,321 + 13,647 = 1,107,949 */
%EDW (2019); /* 1,140,016 + 13,422 = 1,153,402 */
%EDW (2020); /*   916,282 + 13,316 =   929,563 */
%EDW (2021); /* 1,017,528 + 11,876 = 1,029,364 */

proc freq data=edw_2013; table can1; run;


/* Creating indicator variables */

%macro INDW (year);

/*%do i=1 %to 20;*/

data INDW_&year (keep=
DischYear DischQuarter PrvID PatZip PatStateCode PatCountyName Race_val AgeInYears Gender_val AdmitType
PointOfOrigin DischargeStatus TotalCharge LOS Payer1_val  Payer1 MSDRG CaseMix PrincipalDiagCat_val PrincipalDiagCat 
diag_1-diag_20 d_1-d_20
/*diag_&i*/
Rev01 CPT01 Srv01 Rev02 CPT02 Srv02 Rev03 CPT03 CHIAID CAN1
); 
set EDW_&year;
run; 

data INDW_&year;
set INDW_&year;  

/* Cannabis */

if (DischYear <  2015 and 
(diag_1  in (&cannabis9) or diag_2  in (&cannabis9) or diag_3  in (&cannabis9) or diag_4  in (&cannabis9) or diag_5  in (&cannabis9) or
 diag_6  in (&cannabis9) or diag_7  in (&cannabis9) or diag_8  in (&cannabis9) or diag_9  in (&cannabis9) or diag_10 in (&cannabis9) or
 diag_11 in (&cannabis9) or diag_12 in (&cannabis9) or diag_13 in (&cannabis9) or diag_14 in (&cannabis9) or diag_15 in (&cannabis9) or
 diag_16 in (&cannabis9) or diag_17 in (&cannabis9) or diag_18 in (&cannabis9) or diag_19 in (&cannabis9) or diag_20 in (&cannabis9) )
 )

or (DischYear =  2015 and DischQuarter < 4 and 
(diag_1  in (&cannabis9) or diag_2  in (&cannabis9) or diag_3  in (&cannabis9) or diag_4  in (&cannabis9) or diag_5  in (&cannabis9) or
 diag_6  in (&cannabis9) or diag_7  in (&cannabis9) or diag_8  in (&cannabis9) or diag_9  in (&cannabis9) or diag_10 in (&cannabis9) or
 diag_11 in (&cannabis9) or diag_12 in (&cannabis9) or diag_13 in (&cannabis9) or diag_14 in (&cannabis9) or diag_15 in (&cannabis9) or
 diag_16 in (&cannabis9) or diag_17 in (&cannabis9) or diag_18 in (&cannabis9) or diag_19 in (&cannabis9) or diag_20 in (&cannabis9) )
 )

or (DischYear =  2015 and DischQuarter = 4 and 
(d_1  in (&cannabis10) or d_2  in (&cannabis10) or d_3  in (&cannabis10) or d_4  in (&cannabis10) or d_5  in (&cannabis10) or
 d_6  in (&cannabis10) or d_7  in (&cannabis10) or d_8  in (&cannabis10) or d_9  in (&cannabis10) or d_10 in (&cannabis10) or
 d_11 in (&cannabis10) or d_12 in (&cannabis10) or d_13 in (&cannabis10) or d_14 in (&cannabis10) or d_15 in (&cannabis10) or
 d_16 in (&cannabis10) or d_17 in (&cannabis10) or d_18 in (&cannabis10) or d_19 in (&cannabis10) or d_20 in (&cannabis10) )
 ) 

or (DischYear >= 2016 and 
(d_1  in (&cannabis10) or d_2  in (&cannabis10) or d_3  in (&cannabis10) or d_4  in (&cannabis10) or d_5  in (&cannabis10) or
 d_6  in (&cannabis10) or d_7  in (&cannabis10) or d_8  in (&cannabis10) or d_9  in (&cannabis10) or d_10 in (&cannabis10) or
 d_11 in (&cannabis10) or d_12 in (&cannabis10) or d_13 in (&cannabis10) or d_14 in (&cannabis10) or d_15 in (&cannabis10) or
 d_16 in (&cannabis10) or d_17 in (&cannabis10) or d_18 in (&cannabis10) or d_19 in (&cannabis10) or d_20 in (&cannabis10) )
 ) 
then CAN = '1'; else CAN ='0';



/* nausea */
if (DischYear <  2015 and 
(diag_1  in (&nausea9) or diag_2  in (&nausea9) or diag_3  in (&nausea9) or diag_4  in (&nausea9) or diag_5  in (&nausea9) or
 diag_6  in (&nausea9) or diag_7  in (&nausea9) or diag_8  in (&nausea9) or diag_9  in (&nausea9) or diag_10 in (&nausea9) or
 diag_11 in (&nausea9) or diag_12 in (&nausea9) or diag_13 in (&nausea9) or diag_14 in (&nausea9) or diag_15 in (&nausea9) or
 diag_16 in (&nausea9) or diag_17 in (&nausea9) or diag_18 in (&nausea9) or diag_19 in (&nausea9) or diag_20 in (&nausea9) )
 )

or (DischYear =  2015 and DischQuarter < 4 and 
(diag_1  in (&nausea9) or diag_2  in (&nausea9) or diag_3  in (&nausea9) or diag_4  in (&nausea9) or diag_5  in (&nausea9) or
 diag_6  in (&nausea9) or diag_7  in (&nausea9) or diag_8  in (&nausea9) or diag_9  in (&nausea9) or diag_10 in (&nausea9) or
 diag_11 in (&nausea9) or diag_12 in (&nausea9) or diag_13 in (&nausea9) or diag_14 in (&nausea9) or diag_15 in (&nausea9) or
 diag_16 in (&nausea9) or diag_17 in (&nausea9) or diag_18 in (&nausea9) or diag_19 in (&nausea9) or diag_20 in (&nausea9) )
 )

or (DischYear =  2015 and DischQuarter = 4 and 
(d_1  in (&nausea10) or d_2  in (&nausea10) or d_3  in (&nausea10) or d_4  in (&nausea10) or d_5  in (&nausea10) or
 d_6  in (&nausea10) or d_7  in (&nausea10) or d_8  in (&nausea10) or d_9  in (&nausea10) or d_10 in (&nausea10) or
 d_11 in (&nausea10) or d_12 in (&nausea10) or d_13 in (&nausea10) or d_14 in (&nausea10) or d_15 in (&nausea10) or
 d_16 in (&nausea10) or d_17 in (&nausea10) or d_18 in (&nausea10) or d_19 in (&nausea10) or d_20 in (&nausea10) )
 ) 

or (DischYear >= 2016 and 
(d_1  in (&nausea10) or d_2  in (&nausea10) or d_3  in (&nausea10) or d_4  in (&nausea10) or d_5  in (&nausea10) or
 d_6  in (&nausea10) or d_7  in (&nausea10) or d_8  in (&nausea10) or d_9  in (&nausea10) or d_10 in (&nausea10) or
 d_11 in (&nausea10) or d_12 in (&nausea10) or d_13 in (&nausea10) or d_14 in (&nausea10) or d_15 in (&nausea10) or
 d_16 in (&nausea10) or d_17 in (&nausea10) or d_18 in (&nausea10) or d_19 in (&nausea10) or d_20 in (&nausea10) )
 ) 
then NAU = '1'; else NAU ='0';

/* Nicotine */

if (DischYear <  2015 and 
(diag_1  in (&nicotine9) or diag_2  in (&nicotine9) or diag_3  in (&nicotine9) or diag_4  in (&nicotine9) or diag_5  in (&nicotine9) or
 diag_6  in (&nicotine9) or diag_7  in (&nicotine9) or diag_8  in (&nicotine9) or diag_9  in (&nicotine9) or diag_10 in (&nicotine9) or
 diag_11 in (&nicotine9) or diag_12 in (&nicotine9) or diag_13 in (&nicotine9) or diag_14 in (&nicotine9) or diag_15 in (&nicotine9) or
 diag_16 in (&nicotine9) or diag_17 in (&nicotine9) or diag_18 in (&nicotine9) or diag_19 in (&nicotine9) or diag_20 in (&nicotine9) )
 )

or (DischYear =  2015 and DischQuarter < 4 and 
(diag_1  in (&nicotine9) or diag_2  in (&nicotine9) or diag_3  in (&nicotine9) or diag_4  in (&nicotine9) or diag_5  in (&nicotine9) or
 diag_6  in (&nicotine9) or diag_7  in (&nicotine9) or diag_8  in (&nicotine9) or diag_9  in (&nicotine9) or diag_10 in (&nicotine9) or
 diag_11 in (&nicotine9) or diag_12 in (&nicotine9) or diag_13 in (&nicotine9) or diag_14 in (&nicotine9) or diag_15 in (&nicotine9) or
 diag_16 in (&nicotine9) or diag_17 in (&nicotine9) or diag_18 in (&nicotine9) or diag_19 in (&nicotine9) or diag_20 in (&nicotine9) )
 )

or (DischYear =  2015 and DischQuarter = 4 and 
(d_1  in (&nicotine10) or d_2  in (&nicotine10) or d_3  in (&nicotine10) or d_4  in (&nicotine10) or d_5  in (&nicotine10) or
 d_6  in (&nicotine10) or d_7  in (&nicotine10) or d_8  in (&nicotine10) or d_9  in (&nicotine10) or d_10 in (&nicotine10) or
 d_11 in (&nicotine10) or d_12 in (&nicotine10) or d_13 in (&nicotine10) or d_14 in (&nicotine10) or d_15 in (&nicotine10) or
 d_16 in (&nicotine10) or d_17 in (&nicotine10) or d_18 in (&nicotine10) or d_19 in (&nicotine10) or d_20 in (&nicotine10) )
 ) 

or (DischYear >= 2016 and 
(d_1  in (&nicotine10) or d_2  in (&nicotine10) or d_3  in (&nicotine10) or d_4  in (&nicotine10) or d_5  in (&nicotine10) or
 d_6  in (&nicotine10) or d_7  in (&nicotine10) or d_8  in (&nicotine10) or d_9  in (&nicotine10) or d_10 in (&nicotine10) or
 d_11 in (&nicotine10) or d_12 in (&nicotine10) or d_13 in (&nicotine10) or d_14 in (&nicotine10) or d_15 in (&nicotine10) or
 d_16 in (&nicotine10) or d_17 in (&nicotine10) or d_18 in (&nicotine10) or d_19 in (&nicotine10) or d_20 in (&nicotine10) )
 ) 
then NIC = '1'; else NIC ='0';

/* Alcohol */
if (DischYear <  2015 and 
(diag_1  in (&alcohol9) or diag_2  in (&alcohol9) or diag_3  in (&alcohol9) or diag_4  in (&alcohol9) or diag_5  in (&alcohol9) or
 diag_6  in (&alcohol9) or diag_7  in (&alcohol9) or diag_8  in (&alcohol9) or diag_9  in (&alcohol9) or diag_10 in (&alcohol9) or
 diag_11 in (&alcohol9) or diag_12 in (&alcohol9) or diag_13 in (&alcohol9) or diag_14 in (&alcohol9) or diag_15 in (&alcohol9) or
 diag_16 in (&alcohol9) or diag_17 in (&alcohol9) or diag_18 in (&alcohol9) or diag_19 in (&alcohol9) or diag_20 in (&alcohol9) )
 )

or (DischYear =  2015 and DischQuarter < 4 and 
(diag_1  in (&alcohol9) or diag_2  in (&alcohol9) or diag_3  in (&alcohol9) or diag_4  in (&alcohol9) or diag_5  in (&alcohol9) or
 diag_6  in (&alcohol9) or diag_7  in (&alcohol9) or diag_8  in (&alcohol9) or diag_9  in (&alcohol9) or diag_10 in (&alcohol9) or
 diag_11 in (&alcohol9) or diag_12 in (&alcohol9) or diag_13 in (&alcohol9) or diag_14 in (&alcohol9) or diag_15 in (&alcohol9) or
 diag_16 in (&alcohol9) or diag_17 in (&alcohol9) or diag_18 in (&alcohol9) or diag_19 in (&alcohol9) or diag_20 in (&alcohol9) )
 )

or (DischYear =  2015 and DischQuarter = 4 and 
(d_1  in (&alcohol10) or d_2  in (&alcohol10) or d_3  in (&alcohol10) or d_4  in (&alcohol10) or d_5  in (&alcohol10) or
 d_6  in (&alcohol10) or d_7  in (&alcohol10) or d_8  in (&alcohol10) or d_9  in (&alcohol10) or d_10 in (&alcohol10) or
 d_11 in (&alcohol10) or d_12 in (&alcohol10) or d_13 in (&alcohol10) or d_14 in (&alcohol10) or d_15 in (&alcohol10) or
 d_16 in (&alcohol10) or d_17 in (&alcohol10) or d_18 in (&alcohol10) or d_19 in (&alcohol10) or d_20 in (&alcohol10) )
 ) 

or (DischYear >= 2016 and 
(d_1  in (&alcohol10) or d_2  in (&alcohol10) or d_3  in (&alcohol10) or d_4  in (&alcohol10) or d_5  in (&alcohol10) or
 d_6  in (&alcohol10) or d_7  in (&alcohol10) or d_8  in (&alcohol10) or d_9  in (&alcohol10) or d_10 in (&alcohol10) or
 d_11 in (&alcohol10) or d_12 in (&alcohol10) or d_13 in (&alcohol10) or d_14 in (&alcohol10) or d_15 in (&alcohol10) or
 d_16 in (&alcohol10) or d_17 in (&alcohol10) or d_18 in (&alcohol10) or d_19 in (&alcohol10) or d_20 in (&alcohol10) )
 ) 
then ALC = '1'; else ALC ='0';


/* Opioid */
if (DischYear <  2015 and 
(diag_1  in (&opioid9) or diag_2  in (&opioid9) or diag_3  in (&opioid9) or diag_4  in (&opioid9) or diag_5  in (&opioid9) or
 diag_6  in (&opioid9) or diag_7  in (&opioid9) or diag_8  in (&opioid9) or diag_9  in (&opioid9) or diag_10 in (&opioid9) or
 diag_11 in (&opioid9) or diag_12 in (&opioid9) or diag_13 in (&opioid9) or diag_14 in (&opioid9) or diag_15 in (&opioid9) or
 diag_16 in (&opioid9) or diag_17 in (&opioid9) or diag_18 in (&opioid9) or diag_19 in (&opioid9) or diag_20 in (&opioid9) )
 )

or (DischYear =  2015 and DischQuarter < 4 and 
(diag_1  in (&opioid9) or diag_2  in (&opioid9) or diag_3  in (&opioid9) or diag_4  in (&opioid9) or diag_5  in (&opioid9) or
 diag_6  in (&opioid9) or diag_7  in (&opioid9) or diag_8  in (&opioid9) or diag_9  in (&opioid9) or diag_10 in (&opioid9) or
 diag_11 in (&opioid9) or diag_12 in (&opioid9) or diag_13 in (&opioid9) or diag_14 in (&opioid9) or diag_15 in (&opioid9) or
 diag_16 in (&opioid9) or diag_17 in (&opioid9) or diag_18 in (&opioid9) or diag_19 in (&opioid9) or diag_20 in (&opioid9) )
 )

or (DischYear =  2015 and DischQuarter = 4 and 
(d_1  in (&opioid10) or d_2  in (&opioid10) or d_3  in (&opioid10) or d_4  in (&opioid10) or d_5  in (&opioid10) or
 d_6  in (&opioid10) or d_7  in (&opioid10) or d_8  in (&opioid10) or d_9  in (&opioid10) or d_10 in (&opioid10) or
 d_11 in (&opioid10) or d_12 in (&opioid10) or d_13 in (&opioid10) or d_14 in (&opioid10) or d_15 in (&opioid10) or
 d_16 in (&opioid10) or d_17 in (&opioid10) or d_18 in (&opioid10) or d_19 in (&opioid10) or d_20 in (&opioid10) )
 ) 

or (DischYear >= 2016 and 
(d_1  in (&opioid10) or d_2  in (&opioid10) or d_3  in (&opioid10) or d_4  in (&opioid10) or d_5  in (&opioid10) or
 d_6  in (&opioid10) or d_7  in (&opioid10) or d_8  in (&opioid10) or d_9  in (&opioid10) or d_10 in (&opioid10) or
 d_11 in (&opioid10) or d_12 in (&opioid10) or d_13 in (&opioid10) or d_14 in (&opioid10) or d_15 in (&opioid10) or
 d_16 in (&opioid10) or d_17 in (&opioid10) or d_18 in (&opioid10) or d_19 in (&opioid10) or d_20 in (&opioid10) )
 ) 
then OPI = '1'; else OPI ='0';


/* Sedatives */

if (DischYear <  2015 and 
(diag_1  in (&sedatives9) or diag_2  in (&sedatives9) or diag_3  in (&sedatives9) or diag_4  in (&sedatives9) or diag_5  in (&sedatives9) or
 diag_6  in (&sedatives9) or diag_7  in (&sedatives9) or diag_8  in (&sedatives9) or diag_9  in (&sedatives9) or diag_10 in (&sedatives9) or
 diag_11 in (&sedatives9) or diag_12 in (&sedatives9) or diag_13 in (&sedatives9) or diag_14 in (&sedatives9) or diag_15 in (&sedatives9) or
 diag_16 in (&sedatives9) or diag_17 in (&sedatives9) or diag_18 in (&sedatives9) or diag_19 in (&sedatives9) or diag_20 in (&sedatives9) )
 )

or (DischYear =  2015 and DischQuarter < 4 and 
(diag_1  in (&sedatives9) or diag_2  in (&sedatives9) or diag_3  in (&sedatives9) or diag_4  in (&sedatives9) or diag_5  in (&sedatives9) or
 diag_6  in (&sedatives9) or diag_7  in (&sedatives9) or diag_8  in (&sedatives9) or diag_9  in (&sedatives9) or diag_10 in (&sedatives9) or
 diag_11 in (&sedatives9) or diag_12 in (&sedatives9) or diag_13 in (&sedatives9) or diag_14 in (&sedatives9) or diag_15 in (&sedatives9) or
 diag_16 in (&sedatives9) or diag_17 in (&sedatives9) or diag_18 in (&sedatives9) or diag_19 in (&sedatives9) or diag_20 in (&sedatives9) )
 )

or (DischYear =  2015 and DischQuarter = 4 and 
(d_1  in (&sedatives10) or d_2  in (&sedatives10) or d_3  in (&sedatives10) or d_4  in (&sedatives10) or d_5  in (&sedatives10) or
 d_6  in (&sedatives10) or d_7  in (&sedatives10) or d_8  in (&sedatives10) or d_9  in (&sedatives10) or d_10 in (&sedatives10) or
 d_11 in (&sedatives10) or d_12 in (&sedatives10) or d_13 in (&sedatives10) or d_14 in (&sedatives10) or d_15 in (&sedatives10) or
 d_16 in (&sedatives10) or d_17 in (&sedatives10) or d_18 in (&sedatives10) or d_19 in (&sedatives10) or d_20 in (&sedatives10) )
 ) 

or (DischYear >= 2016 and 
(d_1  in (&sedatives10) or d_2  in (&sedatives10) or d_3  in (&sedatives10) or d_4  in (&sedatives10) or d_5  in (&sedatives10) or
 d_6  in (&sedatives10) or d_7  in (&sedatives10) or d_8  in (&sedatives10) or d_9  in (&sedatives10) or d_10 in (&sedatives10) or
 d_11 in (&sedatives10) or d_12 in (&sedatives10) or d_13 in (&sedatives10) or d_14 in (&sedatives10) or d_15 in (&sedatives10) or
 d_16 in (&sedatives10) or d_17 in (&sedatives10) or d_18 in (&sedatives10) or d_19 in (&sedatives10) or d_20 in (&sedatives10) )
 ) 
then SED = '1'; else SED ='0';


/* Cocaine */

if (DischYear <  2015 and 
(diag_1  in (&cocaine9) or diag_2  in (&cocaine9) or diag_3  in (&cocaine9) or diag_4  in (&cocaine9) or diag_5  in (&cocaine9) or
 diag_6  in (&cocaine9) or diag_7  in (&cocaine9) or diag_8  in (&cocaine9) or diag_9  in (&cocaine9) or diag_10 in (&cocaine9) or
 diag_11 in (&cocaine9) or diag_12 in (&cocaine9) or diag_13 in (&cocaine9) or diag_14 in (&cocaine9) or diag_15 in (&cocaine9) or
 diag_16 in (&cocaine9) or diag_17 in (&cocaine9) or diag_18 in (&cocaine9) or diag_19 in (&cocaine9) or diag_20 in (&cocaine9) )
 )

or (DischYear =  2015 and DischQuarter < 4 and 
(diag_1  in (&cocaine9) or diag_2  in (&cocaine9) or diag_3  in (&cocaine9) or diag_4  in (&cocaine9) or diag_5  in (&cocaine9) or
 diag_6  in (&cocaine9) or diag_7  in (&cocaine9) or diag_8  in (&cocaine9) or diag_9  in (&cocaine9) or diag_10 in (&cocaine9) or
 diag_11 in (&cocaine9) or diag_12 in (&cocaine9) or diag_13 in (&cocaine9) or diag_14 in (&cocaine9) or diag_15 in (&cocaine9) or
 diag_16 in (&cocaine9) or diag_17 in (&cocaine9) or diag_18 in (&cocaine9) or diag_19 in (&cocaine9) or diag_20 in (&cocaine9) )
 )

or (DischYear =  2015 and DischQuarter = 4 and 
(d_1  in (&cocaine10) or d_2  in (&cocaine10) or d_3  in (&cocaine10) or d_4  in (&cocaine10) or d_5  in (&cocaine10) or
 d_6  in (&cocaine10) or d_7  in (&cocaine10) or d_8  in (&cocaine10) or d_9  in (&cocaine10) or d_10 in (&cocaine10) or
 d_11 in (&cocaine10) or d_12 in (&cocaine10) or d_13 in (&cocaine10) or d_14 in (&cocaine10) or d_15 in (&cocaine10) or
 d_16 in (&cocaine10) or d_17 in (&cocaine10) or d_18 in (&cocaine10) or d_19 in (&cocaine10) or d_20 in (&cocaine10) )
 ) 

or (DischYear >= 2016 and 
(d_1  in (&cocaine10) or d_2  in (&cocaine10) or d_3  in (&cocaine10) or d_4  in (&cocaine10) or d_5  in (&cocaine10) or
 d_6  in (&cocaine10) or d_7  in (&cocaine10) or d_8  in (&cocaine10) or d_9  in (&cocaine10) or d_10 in (&cocaine10) or
 d_11 in (&cocaine10) or d_12 in (&cocaine10) or d_13 in (&cocaine10) or d_14 in (&cocaine10) or d_15 in (&cocaine10) or
 d_16 in (&cocaine10) or d_17 in (&cocaine10) or d_18 in (&cocaine10) or d_19 in (&cocaine10) or d_20 in (&cocaine10) )
 ) 
then COC = '1'; else COC ='0';


/* SHO */

if (DischYear <  2015 and 
(diag_1  in (&SHO9) or diag_2  in (&SHO9) or diag_3  in (&SHO9) or diag_4  in (&SHO9) or diag_5  in (&SHO9) or
 diag_6  in (&SHO9) or diag_7  in (&SHO9) or diag_8  in (&SHO9) or diag_9  in (&SHO9) or diag_10 in (&SHO9) or
 diag_11 in (&SHO9) or diag_12 in (&SHO9) or diag_13 in (&SHO9) or diag_14 in (&SHO9) or diag_15 in (&SHO9) or
 diag_16 in (&SHO9) or diag_17 in (&SHO9) or diag_18 in (&SHO9) or diag_19 in (&SHO9) or diag_20 in (&SHO9) )
 )

or (DischYear =  2015 and DischQuarter < 4 and 
(diag_1  in (&SHO9) or diag_2  in (&SHO9) or diag_3  in (&SHO9) or diag_4  in (&SHO9) or diag_5  in (&SHO9) or
 diag_6  in (&SHO9) or diag_7  in (&SHO9) or diag_8  in (&SHO9) or diag_9  in (&SHO9) or diag_10 in (&SHO9) or
 diag_11 in (&SHO9) or diag_12 in (&SHO9) or diag_13 in (&SHO9) or diag_14 in (&SHO9) or diag_15 in (&SHO9) or
 diag_16 in (&SHO9) or diag_17 in (&SHO9) or diag_18 in (&SHO9) or diag_19 in (&SHO9) or diag_20 in (&SHO9) )
 )

or (DischYear =  2015 and DischQuarter = 4 and 
(d_1  in (&SHO10) or d_2  in (&SHO10) or d_3  in (&SHO10) or d_4  in (&SHO10) or d_5  in (&SHO10) or
 d_6  in (&SHO10) or d_7  in (&SHO10) or d_8  in (&SHO10) or d_9  in (&SHO10) or d_10 in (&SHO10) or
 d_11 in (&SHO10) or d_12 in (&SHO10) or d_13 in (&SHO10) or d_14 in (&SHO10) or d_15 in (&SHO10) or
 d_16 in (&SHO10) or d_17 in (&SHO10) or d_18 in (&SHO10) or d_19 in (&SHO10) or d_20 in (&SHO10) )
 ) 

or (DischYear >= 2016 and 
(d_1  in (&SHO10) or d_2  in (&SHO10) or d_3  in (&SHO10) or d_4  in (&SHO10) or d_5  in (&SHO10) or
 d_6  in (&SHO10) or d_7  in (&SHO10) or d_8  in (&SHO10) or d_9  in (&SHO10) or d_10 in (&SHO10) or
 d_11 in (&SHO10) or d_12 in (&SHO10) or d_13 in (&SHO10) or d_14 in (&SHO10) or d_15 in (&SHO10) or
 d_16 in (&SHO10) or d_17 in (&SHO10) or d_18 in (&SHO10) or d_19 in (&SHO10) or d_20 in (&SHO10) )
 ) 
then SHO = '1'; else SHO ='0';


run;

%mend INDW;
%INDW (2013);
%INDW (2014);
%INDW (2015);
%INDW (2016);
%INDW (2017);
%INDW (2018);
%INDW (2019);
%INDW (2020);
%INDW (2021);


data dir.INDW_All 
(keep= time dischyear dischquarter patzip patcountyname race_val angeinyears gender_val can2 can nau nic alc opi sed coc sho);
set INDW_2013 - INDW_2021;
run;

/* Total Count: Generated */

proc sql; create table dir.AGGW
as select 
dischYear as YR,
dischquarter as QT,
/*count (*) as denom,*/
sum (can='1') as CANW,
sum (nau='1') as NAUW,
sum (nic='1') as NICW,
sum (alc='1') as ALCW,
sum (opi='1') as OPIW,
sum (sed='1') as SEDW,
sum (coc='1') as COCW,
sum (sho='1') as SHOW

from dir.INDW_all

group by DischYear, DischQuarter
order by DischYear, DischQuarter;
quit;

proc sql; create table dir.aggW1
as select 
a.*,
b.denom as denom,
a.canw/b.denom as canw_r,
a.nicw/b.denom as nicw_r,
a.alcw/b.denom as alcw_r,
a.nauw/b.denom as nauw_r,
a.opiw/b.denom as opiw_r,
a.sedw/b.denom as sedw_r,
a.cocw/b.denom as cocw_r,
a.show/b.denom as show_r

from dir.aggW as a
left join dir.tcnt as b on a.yr=b.yr and a.qt=b.qt;
quit;

/* tmod generated above */

data dir.aggW2; set dir.aggW1; 
tm=yr*100+qt;
if tm gt 201702 then RCM=1; else RCM=0;
if tm gt 201704 then RCM1=1; else RCM1=0;
z=0;
zt=0;
zx=0;
ztx=0;
run;


proc sql; create table dir.aggw3
as select 
a.*,
b.t,
b.x,
b.tx

from dir.aggw2  as a
left join tmod as b on a.tm=b.tm;
quit;



/* End of WIHTOUT CANNABIS */


/* COMBINING WITH AND WITHOUT */


proc sql; create table dir.agg21
as select 
a.*,
b.*,
c.t,
c.x

from dir.agg2       as a
left join dir.aggw3 as b on a.tm=b.tm
left join tmod      as c on a.tm=c.tm;
quit;


/* FOR COMPARATIVE TS MODEL */



data dir.agg3; set dir.agg3;
CON='0'; run;

data dir.aggw3; set dir.aggw3;
CON='1'; 
rename canw=can nauw=nau nicw=nic alcw=alc opiw=opi sedw=sed cocw=coc show=sho
       canw_r=can_r nauw_r=nau_r nicw_r=nic_r alcw_r=alc_r opiw_r=opi_r sedw_r=sed_r cocw_r=coc_r show_r=sho_r; 
run;

data dir.agg4; set dir.agg3 dir.aggw3;
run;



/* END OF CANNABIS - ED 6/14/23 */























ods graphics on;

proc sgplot data=dir.agg;
  series x=time y=can / markerattrs=(symbol=circlefilled color=blue);
  series x=time y=nau / markerattrs=(symbol=squarefilled color=red);
  series x=time y=nic / markerattrs=(symbol=squarefilled color=red);
  series x=time y=opi / markerattrs=(symbol=squarefilled color=red);
  series x=time y=sed / markerattrs=(symbol=squarefilled color=red);
  series x=time y=coc / markerattrs=(symbol=squarefilled color=red);
  series x=time y=sho / markerattrs=(symbol=squarefilled color=red);
run;



proc sgplot data=dir.agg;
  series x=tm y=can / markerattrs=(symbol=circlefilled color=blue);
/*  series x=time y=nau / markerattrs=(symbol=squarefilled color=red);*/
/*  series x=time y=nic / markerattrs=(symbol=squarefilled color=red);*/
/*  series x=time y=opi / markerattrs=(symbol=squarefilled color=red);*/
/*  series x=time y=sed / markerattrs=(symbol=squarefilled color=red);*/
/*  series x=time y=coc / markerattrs=(symbol=squarefilled color=red);*/
/*  series x=time y=sho / markerattrs=(symbol=squarefilled color=red);*/
run;


%mend;
%INC (2013);
%INC (2014);
%INC (2015);
%INC (2016);
%INC (2017);
%INC (2018);
%INC (2019);
%INC (2020);
%INC (2021);

proc freq data=ind_2013; table can nau nic alc opi sed coc sho; run;


data test2
(keep= DischYear data); 
set ED_2013;
data='data';
run;

if 
(DischYear <  2016 and diag_1 in (30430)) or (DischYear >= 2016 and d_1 in (30430)) 
then can = '1'; else can ='0';



%macro ED (year);

data ED_&year; set data.ED_&year; 
d_1 =  substr(diag01, 1, 3); d_2  = substr(diag02, 1, 3); d_3  = substr(diag03, 1, 3); d_4  = substr(diag04, 1, 3); d_5  = substr(diag05, 1, 3); 
d_6 =  substr(diag06, 1, 3); d_7  = substr(diag07, 1, 3); d_8  = substr(diag08, 1, 3); d_9  = substr(diag09, 1, 3); d_10 = substr(diag10, 1, 3); 
d_11 = substr(diag11, 1, 3); d_12 = substr(diag12, 1, 3); d_13 = substr(diag13, 1, 3); d_14 = substr(diag14, 1, 3); d_15 = substr(diag15, 1, 3); 
d_16 = substr(diag16, 1, 3); d_17 = substr(diag17, 1, 3); d_18 = substr(diag18, 1, 3); d_19 = substr(diag19, 1, 3); d_20 = substr(diag20, 1, 3); 

rename Diag01 = Diag_1;  rename Diag02 = Diag_2;  rename Diag03 = Diag_3;   rename Diag04 = Diag_4;  rename Diag05 = Diag_5; 
rename Diag06 = Diag_6;  rename Diag07 = Diag_7;  rename Diag08 = Diag_8;   rename Diag09 = Diag_9;  rename Diag10 = Diag_10; 
rename Diag11 = Diag_11; rename Diag12 = Diag_12; rename Diag13 = Diag_13;  rename Diag14 = Diag_14; rename Diag15 = Diag_15; 
rename Diag16 = Diag_16; rename Diag17 = Diag_17; rename Diag18 = Diag_18;  rename Diag19 = Diag_19; rename Diag20 = Diag_20; 

run;



%do i=1 %to &iteration;

data IND_&year._&i (keep=DischYear DischQuarter PrvID PatZip PatStateCode PatCountyName Race_val AgeInYears Gender_val AdmitType
PointOfOrigin DischargeStatus TotalCharge LOS Payer1_val  Payer1 MSDRG CaseMix PrincipalDiagCat_val PrincipalDiagCat 
diag_1-diag_20 d_1-d_20
/*diag_&i*/

Rev01 CPT01 Srv01 Rev02 CPT02 Srv02 Rev03 CPT03 CHIAID); 
set ED_&year;



%end;


%mend ED;
%ED (2013); /* 5,415 / 859861 */

if 
DischYear <  2016 and diag_&i in (&cannabis9) or DischYear >= 2016 and d_&i in (&cannabis10) then can = '1';
;run;


data IND_&year;
set IND_&year._1 - IND_&year._&iteration;
run;

%mend ED;
%ED (2013); /* 5,415 / 859861 */









data ED_2016; set data.ED_2016; 
rename Diag01 = Diag_1;  rename Diag02 = Diag_2;  rename Diag03 = Diag_3;   rename Diag04 = Diag_4;  rename Diag05 = Diag_5; 
rename Diag06 = Diag_6;  rename Diag07 = Diag_7;  rename Diag08 = Diag_8;   rename Diag09 = Diag_9;  rename Diag10 = Diag_10; 
rename Diag11 = Diag_11; rename Diag12 = Diag_12; rename Diag13 = Diag_13;  rename Diag14 = Diag_14; rename Diag15 = Diag_15; 
rename Diag16 = Diag_16; rename Diag17 = Diag_17; rename Diag18 = Diag_18;  rename Diag19 = Diag_19; rename Diag20 = Diag_20; 
run;


data ED_2016_1 (keep=DischYear DischQuarter PrvID PatZip PatStateCode PatCountyName Race_val AgeInYears Gender_val AdmitType
PointOfOrigin DischargeStatus TotalCharge LOS Payer1_val  Payer1 MSDRG CaseMix PrincipalDiagCat_val PrincipalDiagCat 
diag_1-diag_20
Rev01 CPT01 Srv01 Rev02 CPT02 Srv02 Rev03 CPT03 CHIAID); 
set ED_2016;

where 
DischYear >= 2016 and diag_1 in ('F12')
;run;


data EDCom_&year;
set ED_&year._1 - ED_&year._&iteration;
run;





/* Define a macro to repeatedly select data using WHERE statement */
%macro ED1(year);

  /* Use a DO loop to iterate over the WHERE conditions */
  %do i = 1 &iteration;


    /* Get the i-th WHERE condition */
    %let cond = %scan(&where, &i);

    /* Use PROC SQL to select data based on the i-th WHERE condition */
    proc sql noprint;
      create table temp_&i as
      select *
      from &data
      where &cond;
    quit;

    /* Append the selected data to the final output dataset */
    data output;
      set output temp_&i;
    run;

  %end;

  /* Delete the temporary datasets */
  proc datasets lib=work nolist;
    delete temp_:;
  quit;

%mend;

/* Call the macro to select data */
%select_data(data=have, where=id=1 id=3);


/* Define a macro to repeatedly select data using WHERE statement */
%macro select_data(data=, where=);

  /* Use a DO loop to iterate over the WHERE conditions */
  %do i = 1 %to %sysfunc(countw(&where));

    /* Get the i-th WHERE condition */
    %let cond = %scan(&where, &i);

    /* Use PROC SQL to select data based on the i-th WHERE condition */
    proc sql noprint;
      create table temp_&i as
      select *
      from &data
      where &cond;
    quit;

    /* Append the selected data to the final output dataset */
    data output;
      set output temp_&i;
    run;

  %end;

  /* Delete the temporary datasets */
  proc datasets lib=work nolist;
    delete temp_:;
  quit;

%mend;

/* Call the macro to select data */
%select_data(data=have, where=id=1 id=3);





data Ip_&year; set Ip_&year; 






proc sql;
   create table out.reliever_med as
        select *
		from out.med_all
        where Medication_List in ('Asthma Reliever Medications') /* 140,703 */
/*		where (ndc in (select ndc from amr_rel)) */
/*		where Medication_List in (&Asthma_Reliever_Med.)  /* 140,703 */
/*		where AMR_A_DESC in (&Asthma_Reliever_Med.)  /* 140,703 */
		and '01Jan2018'D<=rx_serv_Dt<='31Dec2018'd;
/*		and "&rpt_prior12mn."D<=rx_serv_Dt<="&rpt_priormn."D;*/
quit;




/*%let out_loc=\\svm3cifs\SASGrid_Data\SAS Data\yonsuk\AMR\AMR_Data;*/


%let med_loc=\\Pixley\hoa\01_Monthly_Reports\Pharmacy_PDC\02_SAS_Data_Files\August2019;
%let HOAUSR=ykim;
%let HOAPWD=fEB2020!!;
proc printto; run;
%let USR=ykim;
%let PWD=fEB2020!!;
libname HOA ORACLE USER="&USR" PW="&PWD" PATH="@HOAP" SCHEMA=HOA;run;
/*Update Parameters End*/






%macro IP (year);


data Ip_&year (keep=DischYear DischQuarter PrvID PatZip PatStateCode PatCountyName Race_val AgeInYears Gender_val AdmitType
PointOfOrigin DischargeStatus TotalCharge LOS Payer1_val  Payer1 MSDRG CaseMix PrincipalDiagCat_val PrincipalDiagCat 
Diag01 Diag02 Diag03 Diag04 Diag05 Diag06 Diag07 Diag08 Diag09 Diag10 
Diag11 Diag12 Diag13 Diag14 Diag15 Diag16 Diag17 Diag18 Diag09 Diag20
Rev01 CPT01 Srv01 Rev02 CPT02 Srv02 Rev03 CPT03 CHIAID); 
set data.Ip_&year; 
where patstatecode in ('NV'); run;


/*data res_&year; set ed_&year; where PrincipalDiagCat in ('08-Diseases of the REspiratory System (460-519)'); run;*/

data Ip_&year; set Ip_&year; 
d01 = substr(diag01, 1, 3); 
d02 = substr(diag02, 1, 3); 
d03 = substr(diag03, 1, 3); 
d04 = substr(diag04, 1, 3); 
d05 = substr(diag05, 1, 3); 
d06 = substr(diag06, 1, 3); 
d07 = substr(diag07, 1, 3); 
d08 = substr(diag08, 1, 3); 
d09 = substr(diag09, 1, 3); 
d10 = substr(diag10, 1, 3);
d11 = substr(diag11, 1, 3); 
d12 = substr(diag12, 1, 3); 
d13 = substr(diag13, 1, 3); 
d14 = substr(diag14, 1, 3); 
d15 = substr(diag15, 1, 3); 
d16 = substr(diag16, 1, 3); 
d17 = substr(diag17, 1, 3); 
d18 = substr(diag18, 1, 3); 
d19 = substr(diag19, 1, 3); 
d20 = substr(diag20, 1, 3); 
 
/*where d01 in ('493');*/
run;
 
data catIP_&year; set Ip_&year;
where (DischYear <  2016 and (d01 in ('493') or d02 in ('493') or d03 in ('493')))
or    (DischYear >= 2016 and (d01 in ('J45') or d02 in ('J45') or d03 in ('J45')));
run;


%mend IP;
%IP (2013);
%IP (2014);
%IP (2015);
%IP (2016);
%IP (2017);
%IP (2018);
%IP (2019);
%IP (2020);
%IP (2021); /* 374,318 */



data data.catIP_all; set catIP_2013-catIP_2021;
run;


/* 
1. Native or Alaskan
2. Asian or Pacific Islander
3. African Americans
4. White
5. Hispanic
6. Other
*/


/****** IP - if Asthma is primary, secondary, or tertiry  *****/


%macro PRIP (year);

data IP_&year (keep=DischYear DischQuarter ProviderID PatZip PatStateCode PatCountyName Race_val AgeInYears Gender_val AdmitType
PointOfOrigin DischargeStatus TotalCharge Payer1_val LOS Payer1 MSDRG CaseMix PrincipalDiagCat_val PrincipalDiagCat 
Diag01 Diag02 Diag03 Diag04 Diag05 Diag06 Diag07 Diag08 Diag09 Diag10
Diag11 Diag12 Diag13 Diag14 Diag15 Diag16 Diag17 Diag18 Diag09 Diag20
Rev01 CPT01 Srv01 Rev02 CPT02 Srv02 Rev03 CPT03 CHIAID); 
set data.IP_&year; 
where patstatecode in ('NV'); run;

/*data res_&year; set ed_&year; where PrincipalDiagCat in ('08-Diseases of the REspiratory System (460-519)'); run;*/

data IP_&year; set IP_&year; 
d01 = substr(diag01, 1, 3); 
d02 = substr(diag02, 1, 3); 
d03 = substr(diag03, 1, 3); 
d04 = substr(diag04, 1, 3); 
d05 = substr(diag05, 1, 3); 
d06 = substr(diag06, 1, 3); 
d07 = substr(diag07, 1, 3); 
d08 = substr(diag08, 1, 3); 
d09 = substr(diag09, 1, 3); 
d10 = substr(diag10, 1, 3); 
d11 = substr(diag11, 1, 3); 
d12 = substr(diag12, 1, 3); 
d13 = substr(diag13, 1, 3); 
d14 = substr(diag14, 1, 3); 
d15 = substr(diag15, 1, 3); 
d16 = substr(diag16, 1, 3); 
d17 = substr(diag17, 1, 3); 
d18 = substr(diag18, 1, 3); 
d19 = substr(diag19, 1, 3); 
d20 = substr(diag20, 1, 3); 

/*where d01 in ('493');*/
run;
 
data diag3_IP_&year; set IP_&year;
where (DischYear <  2016 and (d01 in ('493') or d02 in ('493') or d03 in ('493')))
or    (DischYear >= 2016 and (d01 in ('J45') or d02 in ('J45') or d03 in ('J45')));
run;



data diag3_IP_&year; set diag3_IP_&year;
s01 = substr(diag01, 1, 4); 
s02 = substr(diag02, 1, 4); 
s03 = substr(diag03, 1, 4); 
s04 = substr(diag04, 1, 4); 
s05 = substr(diag05, 1, 4); 
s06 = substr(diag06, 1, 4); 
s07 = substr(diag07, 1, 4); 
s08 = substr(diag08, 1, 4); 
s09 = substr(diag09, 1, 4); 
s10 = substr(diag10, 1, 4); 
s11 = substr(diag01, 1, 4); 
s12 = substr(diag02, 1, 4); 
s13 = substr(diag03, 1, 4); 
s14 = substr(diag04, 1, 4); 
s15 = substr(diag05, 1, 4); 
s16 = substr(diag06, 1, 4); 
s17 = substr(diag07, 1, 4); 
s18 = substr(diag08, 1, 4); 
s19 = substr(diag09, 1, 4); 
s20 = substr(diag10, 1, 4); 


     if s01 in ('J452') or s02 in ('J452') or s03 in ('J452') then sev = '0'; /* Intermittent asthma */
else if s01 in ('J453') or s02 in ('J453') or s03 in ('J453') then sev = '1'; /* Mild */
else if s01 in ('J454') or s02 in ('J454') or s03 in ('J454') then sev = '2'; /* Moderate */
else if s01 in ('J455') or s02 in ('J455') or s03 in ('J455') then sev = '3'; /* Severe */
else sev='9';

     if s01 in ('J452') or s02 in ('J452') or s03 in ('J452') then bsev = '0';
else if s01 in ('J453') or s02 in ('J453') or s03 in ('J453') then bsev = '0';
else if s01 in ('J454') or s02 in ('J454') or s03 in ('J454') then bsev = '0';
else if s01 in ('J455') or s02 in ('J455') or s03 in ('J455') then bsev = '1';
else bsev='0';

     if s01 in ('J452') or s02 in ('J452') or s03 in ('J452') then int = '0';
else if s01 in ('J453') or s02 in ('J453') or s03 in ('J453') then int = '0';
else if s01 in ('J454') or s02 in ('J454') or s03 in ('J454') then int = '1';
else if s01 in ('J455') or s02 in ('J455') or s03 in ('J455') then int = '1';
else int='0';

     if s01 in ('J452') or s02 in ('J452') or s03 in ('J452') then pa = '0';
else if s01 in ('J453') or s02 in ('J453') or s03 in ('J453') then pa = '1';
else if s01 in ('J454') or s02 in ('J454') or s03 in ('J454') then pa = '1';
else if s01 in ('J455') or s02 in ('J455') or s03 in ('J455') then pa = '1';
else pa='0';

     if s01 in ('J452') or s02 in ('J452') or s03 in ('J452') then ca = '9';
else if s01 in ('J453') or s02 in ('J453') or s03 in ('J453') then ca = '9';
else if s01 in ('J454') or s02 in ('J454') or s03 in ('J454') then ca = '9';
else if s01 in ('J455') or s02 in ('J455') or s03 in ('J455') then ca = '1';
else ca='0';

run;



%mend PRIMP;
%PRIP (2013);
%PRIP (2014);
%PRIP (2015);
%PRIP (2016);
%PRIP (2017);
%PRIP (2018);
%PRIP (2019);
%PRIP (2020);
%PRIP (2021);



data  data.diag3IP_all; set  diag3_IP_2013- diag3_IP_2021;
race=put(race_val, 6.);
run;



/* Create data with BMI indicator */

data diag3IP_02; set data.diag3IP_all;

/*if d01 in ('Z68') or d02 in ('Z68') or d03 in ('Z68') or d04 in ('Z68')  or d05 in ('Z68') */
/*or d06 in ('Z68') or d07 in ('Z68') or d08 in ('Z68') or d09 in ('Z68') or d10 in ('Z68')  */
/*then bmi = '1';*/
/*else bmi= '0';*/


     if 
s01 in ('Z683', 'Z684') or 
s02 in ('Z683', 'Z684') or 
s03 in ('Z683', 'Z684') or 
s04 in ('Z683', 'Z684') or 
s05 in ('Z683', 'Z684') or 
s06 in ('Z683', 'Z684') or 
s07 in ('Z683', 'Z684') or 
s08 in ('Z683', 'Z684') or 
s09 in ('Z683', 'Z684') or 
s10 in ('Z683', 'Z684') or
s11 in ('Z683', 'Z684') or 
s12 in ('Z683', 'Z684') or 
s13 in ('Z683', 'Z684') or 
s14 in ('Z683', 'Z684') or 
s15 in ('Z683', 'Z684') or 
s16 in ('Z683', 'Z684') or 
s17 in ('Z683', 'Z684') or 
s18 in ('Z683', 'Z684') or 
s19 in ('Z683', 'Z684') or 
s20 in ('Z683', 'Z684') 

then obs = '1';


else if 
(s01 in ('Z685') and diag01 in ('Z6854')) or 
(s02 in ('Z685') and diag02 in ('Z6854')) or 
(s03 in ('Z685') and diag03 in ('Z6854')) or 
(s04 in ('Z685') and diag04 in ('Z6854')) or 
(s05 in ('Z685') and diag05 in ('Z6854')) or 
(s06 in ('Z685') and diag06 in ('Z6854')) or 
(s07 in ('Z685') and diag07 in ('Z6854')) or 
(s08 in ('Z685') and diag08 in ('Z6854')) or 
(s09 in ('Z685') and diag09 in ('Z6854')) or 
(s10 in ('Z685') and diag10 in ('Z6854')) or
(s11 in ('Z685') and diag11 in ('Z6854')) or 
(s12 in ('Z685') and diag12 in ('Z6854')) or 
(s13 in ('Z685') and diag13 in ('Z6854')) or 
(s14 in ('Z685') and diag14 in ('Z6854')) or 
(s15 in ('Z685') and diag15 in ('Z6854')) or 
(s16 in ('Z685') and diag16 in ('Z6854')) or 
(s17 in ('Z685') and diag17 in ('Z6854')) or 
(s18 in ('Z685') and diag18 in ('Z6854')) or 
(s19 in ('Z685') and diag19 in ('Z6854')) or 
(s20 in ('Z685') and diag20 in ('Z6854')) 
 
then obs = '1';

else obs='0';

/* BMI categories */
/*https://www.cdc.gov/obesity/basics/adult-defining.html#:~:text=If%20your%20BMI%20is%20less,falls%20within%20the%20obesity%20range.*/

if 
s01 in ('Z681') or s02 in ('Z681') or s03 in ('Z681') or s04 in ('Z681') or s05 in ('Z681') or 
s06 in ('Z681') or s07 in ('Z681') or s08 in ('Z681') or s09 in ('Z681') or s10 in ('Z681') or
s11 in ('Z681') or s12 in ('Z681') or s13 in ('Z681') or s14 in ('Z681') or s15 in ('Z681') or 
s16 in ('Z681') or s17 in ('Z681') or s18 in ('Z681') or s19 in ('Z681') or s20 in ('Z681') 

then bmi='0';

else if
 (s01 in ('Z682') and diag01 in ('Z6820', 'Z6821', 'Z6822', 'Z6823','Z6824')) or 
 (s02 in ('Z682') and diag02 in ('Z6820', 'Z6821', 'Z6822', 'Z6823','Z6824')) or 
 (s03 in ('Z682') and diag03 in ('Z6820', 'Z6821', 'Z6822', 'Z6823','Z6824')) or 
 (s04 in ('Z682') and diag04 in ('Z6820', 'Z6821', 'Z6822', 'Z6823','Z6824')) or 
 (s05 in ('Z682') and diag05 in ('Z6820', 'Z6821', 'Z6822', 'Z6823','Z6824')) or 
 (s06 in ('Z682') and diag06 in ('Z6820', 'Z6821', 'Z6822', 'Z6823','Z6824')) or 
 (s07 in ('Z682') and diag07 in ('Z6820', 'Z6821', 'Z6822', 'Z6823','Z6824')) or 
 (s08 in ('Z682') and diag08 in ('Z6820', 'Z6821', 'Z6822', 'Z6823','Z6824')) or 
 (s09 in ('Z682') and diag09 in ('Z6820', 'Z6821', 'Z6822', 'Z6823','Z6824')) or 
 (s10 in ('Z682') and diag10 in ('Z6820', 'Z6821', 'Z6822', 'Z6823','Z6824')) or
 (s11 in ('Z682') and diag11 in ('Z6820', 'Z6821', 'Z6822', 'Z6823','Z6824')) or
 (s12 in ('Z682') and diag12 in ('Z6820', 'Z6821', 'Z6822', 'Z6823','Z6824')) or
 (s13 in ('Z682') and diag13 in ('Z6820', 'Z6821', 'Z6822', 'Z6823','Z6824')) or
 (s14 in ('Z682') and diag14 in ('Z6820', 'Z6821', 'Z6822', 'Z6823','Z6824')) or
 (s15 in ('Z682') and diag15 in ('Z6820', 'Z6821', 'Z6822', 'Z6823','Z6824')) or
 (s16 in ('Z682') and diag16 in ('Z6820', 'Z6821', 'Z6822', 'Z6823','Z6824')) or
 (s17 in ('Z682') and diag17 in ('Z6820', 'Z6821', 'Z6822', 'Z6823','Z6824')) or
 (s18 in ('Z682') and diag18 in ('Z6820', 'Z6821', 'Z6822', 'Z6823','Z6824')) or
 (s19 in ('Z682') and diag19 in ('Z6820', 'Z6821', 'Z6822', 'Z6823','Z6824')) or
 (s20 in ('Z682') and diag20 in ('Z6820', 'Z6821', 'Z6822', 'Z6823','Z6824')) 

then bmi = '0';

else if
 (s01 in ('Z682') and diag01 in ('Z6825', 'Z6826','Z6827', 'Z6828','Z6829')) or 
 (s02 in ('Z682') and diag02 in ('Z6825', 'Z6826','Z6827', 'Z6828','Z6829')) or 
 (s03 in ('Z682') and diag03 in ('Z6825', 'Z6826','Z6827', 'Z6828','Z6829')) or 
 (s04 in ('Z682') and diag04 in ('Z6825', 'Z6826','Z6827', 'Z6828','Z6829')) or 
 (s05 in ('Z682') and diag05 in ('Z6825', 'Z6826','Z6827', 'Z6828','Z6829')) or 
 (s06 in ('Z682') and diag06 in ('Z6825', 'Z6826','Z6827', 'Z6828','Z6829')) or 
 (s07 in ('Z682') and diag07 in ('Z6825', 'Z6826','Z6827', 'Z6828','Z6829')) or 
 (s08 in ('Z682') and diag08 in ('Z6825', 'Z6826','Z6827', 'Z6828','Z6829')) or 
 (s09 in ('Z682') and diag09 in ('Z6825', 'Z6821','Z6827', 'Z6828','Z6829')) or 
 (s10 in ('Z682') and diag10 in ('Z6825', 'Z6826','Z6827', 'Z6828','Z6829')) or
 (s11 in ('Z682') and diag11 in ('Z6825', 'Z6826','Z6827', 'Z6828','Z6829')) or 
 (s12 in ('Z682') and diag12 in ('Z6825', 'Z6826','Z6827', 'Z6828','Z6829')) or 
 (s13 in ('Z682') and diag13 in ('Z6825', 'Z6826','Z6827', 'Z6828','Z6829')) or 
 (s14 in ('Z682') and diag14 in ('Z6825', 'Z6826','Z6827', 'Z6828','Z6829')) or 
 (s15 in ('Z682') and diag15 in ('Z6825', 'Z6826','Z6827', 'Z6828','Z6829')) or 
 (s16 in ('Z682') and diag16 in ('Z6825', 'Z6826','Z6827', 'Z6828','Z6829')) or 
 (s17 in ('Z682') and diag17 in ('Z6825', 'Z6826','Z6827', 'Z6828','Z6829')) or 
 (s18 in ('Z682') and diag18 in ('Z6825', 'Z6826','Z6827', 'Z6828','Z6829')) or 
 (s19 in ('Z682') and diag19 in ('Z6825', 'Z6821','Z6827', 'Z6828','Z6829')) or 
 (s20 in ('Z682') and diag20 in ('Z6825', 'Z6826','Z6827', 'Z6828','Z6829')) 

then bmi = '0';

else if
 (s01 in ('Z683') and diag01 in ('Z6830', 'Z6831', 'Z6832', 'Z6833','Z6834')) or 
 (s02 in ('Z683') and diag02 in ('Z6830', 'Z6831', 'Z6832', 'Z6833','Z6834')) or 
 (s03 in ('Z683') and diag03 in ('Z6830', 'Z6831', 'Z6832', 'Z6833','Z6834')) or 
 (s04 in ('Z683') and diag04 in ('Z6830', 'Z6831', 'Z6832', 'Z6833','Z6834')) or 
 (s05 in ('Z683') and diag05 in ('Z6830', 'Z6831', 'Z6832', 'Z6833','Z6834')) or 
 (s06 in ('Z683') and diag06 in ('Z6830', 'Z6831', 'Z6832', 'Z6833','Z6834')) or 
 (s07 in ('Z683') and diag07 in ('Z6830', 'Z6831', 'Z6832', 'Z6833','Z6834')) or 
 (s08 in ('Z683') and diag08 in ('Z6830', 'Z6831', 'Z6832', 'Z6833','Z6834')) or 
 (s09 in ('Z683') and diag09 in ('Z6830', 'Z6831', 'Z6832', 'Z6833','Z6834')) or 
 (s10 in ('Z683') and diag10 in ('Z6830', 'Z6831', 'Z6832', 'Z6833','Z6834')) or
 (s10 in ('Z683') and diag10 in ('Z6830', 'Z6831', 'Z6832', 'Z6833','Z6834')) or
 (s11 in ('Z683') and diag11 in ('Z6830', 'Z6831', 'Z6832', 'Z6833','Z6834')) or 
 (s12 in ('Z683') and diag12 in ('Z6830', 'Z6831', 'Z6832', 'Z6833','Z6834')) or 
 (s13 in ('Z683') and diag13 in ('Z6830', 'Z6831', 'Z6832', 'Z6833','Z6834')) or 
 (s14 in ('Z683') and diag14 in ('Z6830', 'Z6831', 'Z6832', 'Z6833','Z6834')) or 
 (s15 in ('Z683') and diag15 in ('Z6830', 'Z6831', 'Z6832', 'Z6833','Z6834')) or 
 (s16 in ('Z683') and diag16 in ('Z6830', 'Z6831', 'Z6832', 'Z6833','Z6834')) or 
 (s17 in ('Z683') and diag17 in ('Z6830', 'Z6831', 'Z6832', 'Z6833','Z6834')) or 
 (s18 in ('Z683') and diag18 in ('Z6830', 'Z6831', 'Z6832', 'Z6833','Z6834')) or 
 (s19 in ('Z683') and diag19 in ('Z6830', 'Z6831', 'Z6832', 'Z6833','Z6834')) or 
 (s20 in ('Z683') and diag20 in ('Z6830', 'Z6831', 'Z6832', 'Z6833','Z6834')) 

then bmi = '1';

else if
 (s01 in ('Z683') and diag01 in ('Z6835', 'Z6836', 'Z6837', 'Z6838','Z6839')) or 
 (s02 in ('Z683') and diag02 in ('Z6835', 'Z6836', 'Z6837', 'Z6838','Z6839')) or 
 (s03 in ('Z683') and diag03 in ('Z6835', 'Z6836', 'Z6837', 'Z6838','Z6839')) or 
 (s04 in ('Z683') and diag04 in ('Z6835', 'Z6836', 'Z6837', 'Z6838','Z6839')) or 
 (s05 in ('Z683') and diag05 in ('Z6835', 'Z6836', 'Z6837', 'Z6838','Z6839')) or 
 (s06 in ('Z683') and diag06 in ('Z6835', 'Z6836', 'Z6837', 'Z6838','Z6839')) or 
 (s07 in ('Z683') and diag07 in ('Z6835', 'Z6836', 'Z6837', 'Z6838','Z6839')) or 
 (s08 in ('Z683') and diag08 in ('Z6835', 'Z6836', 'Z6837', 'Z6838','Z6839')) or 
 (s09 in ('Z683') and diag09 in ('Z6835', 'Z6836', 'Z6837', 'Z6838','Z6839')) or 
 (s10 in ('Z683') and diag10 in ('Z6835', 'Z6836', 'Z6837', 'Z6838','Z6839')) or
 (s11 in ('Z683') and diag01 in ('Z6835', 'Z6836', 'Z6837', 'Z6838','Z6839')) or 
 (s12 in ('Z683') and diag02 in ('Z6835', 'Z6836', 'Z6837', 'Z6838','Z6839')) or 
 (s13 in ('Z683') and diag03 in ('Z6835', 'Z6836', 'Z6837', 'Z6838','Z6839')) or 
 (s14 in ('Z683') and diag04 in ('Z6835', 'Z6836', 'Z6837', 'Z6838','Z6839')) or 
 (s15 in ('Z683') and diag05 in ('Z6835', 'Z6836', 'Z6837', 'Z6838','Z6839')) or 
 (s16 in ('Z683') and diag06 in ('Z6835', 'Z6836', 'Z6837', 'Z6838','Z6839')) or 
 (s17 in ('Z683') and diag07 in ('Z6835', 'Z6836', 'Z6837', 'Z6838','Z6839')) or 
 (s18 in ('Z683') and diag08 in ('Z6835', 'Z6836', 'Z6837', 'Z6838','Z6839')) or 
 (s19 in ('Z683') and diag09 in ('Z6835', 'Z6836', 'Z6837', 'Z6838','Z6839')) or 
 (s20 in ('Z683') and diag10 in ('Z6835', 'Z6836', 'Z6837', 'Z6838','Z6839')) 
then bmi = '2';

else if
s01 in ('Z684') or s02 in ('Z684') or s03 in ('Z684') or s04 in ('Z684') or s05 in ('Z684') or 
s06 in ('Z684') or s07 in ('Z684') or s08 in ('Z684') or s09 in ('Z684') or s10 in ('Z684') or
s11 in ('Z684') or s12 in ('Z684') or s13 in ('Z684') or s14 in ('Z684') or s15 in ('Z684') or 
s16 in ('Z684') or s17 in ('Z684') or s18 in ('Z684') or s19 in ('Z684') or s20 in ('Z684') 
then bmi = '3';

else bmi='0';

/* obesity categories end here */



if d01 in ('E11') or d02 in ('E11') or d03 in ('E11')
then dm = '1';
else dm = '0';

if payer1 in ('16-Nevada Medicaid', '17-Other Medicaid', '28-Nevada Medicaid HOM')
then medi = '1';
else medi = '0';

if los > 3 then clos = '1'; /* need to confirm los >3 or los >= */
else if los =< 3 then clos = '0';

if ageinyears < 19 then age ='1';
else if 30> ageinyears >=19 then age ='2';
else if 50> ageinyears >=30 then age ='3';
else age ='4';


/*if ageinyears <6 then age ='1'; /* Based on the suggestion by Sheniz - Age group not sig.*/*/
/*else if 19> ageinyears >=6 then age ='2';*/
/*else if 30> ageinyears >=19 then age ='3';*/
/*else if 35> ageinyears >=30 then age ='4';*/
/*else if 56> ageinyears >=35 then age ='5';*/
/*else age ='6';*/

/*if ageinyears <19 then age ='1'; /* Based on the equal distribution by group */*/
/*else if 31> ageinyears >=19 then age ='2';*/
/*else if 51> ageinyears >=31 then age ='3';*/
/*else age ='4';*/

dmn=input(dm, 8.);

where dischyear >= 2016;
run;



/* Persistent & severe Asthma - Best model */

%macro logip (iv, dv);

proc logistic data=diag3IP_02 descending;
class sev (ref='0') dm (ref='0') obs (ref='0') bsev gender_val (ref='F') payer1 Medi (ref='0') AdmitType PointOfOrigin
race_val (ref='4')  bmi (ref='0')
age (ref='4')
/ param=ref;
model &dv = &iv medi gender_val race_val 
age
/*AdmitType*/
;
where race_val in (2, 3, 4, 5) 
and gender_val in ('M','F')
/*and &dv not in ('9')*/
and ageinyears >= 19
/*and ageinyears < 19*/ /*and DischYear in (2020)*/ /*and AdmitType in ('1-Emergency', '2-Urgent', '3-Elective')*/
and bmi in ('0','3') /* 0, 1, 2, 3 */
and sev in ('0','1') /* 0, 1, 2, 3 */

%mend logip;
%logip (bmi, sev); /* Final */
%logip (bmi, int); /* Final */
%logip (bmi, pa);
%logip (bmi, bsev); 
%logip (obs, sev); /* obs incudes children while bmi does not include them -> different results */
%logip (obs, bsev); 
%logip (obs, int); 
%logip (obs, pa);  
%logip (obs, clos);
%logip (dm, bsev);
%logip (dm, pa);
%logip (dm, clos);



/* AGG model */
%macro aggip (iv, dv);

proc logistic data=diag3IP_02 descending;
class sev (ref='0') dm (ref='0') obs (ref='0') bsev (ref='0')gender_val (ref='F') payer1 Medi (ref='0') AdmitType PointOfOrigin
race_val (ref='4')  bmi (ref='0') age (ref='4') / param=ref;
model &dv = &iv Medi gender_val race_val age
;
where race_val in (2, 3, 4, 5) and gender_val in ('M','F')
/*and &dv not in ('9')*/
and ageinyears >= 19
and sev in ('0','1', '2', '3') /* 0, 1, 2, 3 */
;run;

%mend aggip;
%aggip (obs, bsev);
%aggip (obs, pa);


/* AGG - Unadjusted model */
%macro unadj (iv, dv);

proc logistic data=diag3IP_02 descending;
class sev (ref='0') dm (ref='0') obs (ref='0') bsev (ref='0')gender_val (ref='F') payer1 Medi (ref='0') AdmitType PointOfOrigin
race_val (ref='4')  bmi (ref='0') age (ref='4') / param=ref;
model &dv = &iv;
where race_val in (2, 3, 4, 5) and gender_val in ('M','F')
and ageinyears >= 19
and sev in ('0','1', '2', '3')
/* 0, 1, 2, 3 */
;run;

%mend unadj;
%unadj (obs, bsev);
%unadj (obs, pa);



proc freq data=diag3IP_02; tables bmi*int; run;
proc freq data=diag3IP_02; tables obs*int; run;

/* AME analyses */


proc means data=margeff;
var pred;
class obs gender_val race_val medi;
output out=ame mean=pred_ame;
run;


%macro AME (iv, dv);

proc logistic data=diag3IP_02 descending;
class dm (ref='0') obs (ref='0') bsev gender_val (ref='F')
race_val (ref='4')  
payer1 Medi (ref='0') AdmitType PointOfOrigin
age (ref='4')
/ param=ref;
model &dv = &iv*Medi gender_val  
race_val 
age
/*AdmitType*/
;
/*WHERE race_val in (5) */
WHERE race_val in (2, 3, 4, 5) 
and &dv not in ('9')
/*and ageinyears >= 19*/
/*and ageinyears < 19*/
/*and DischYear in (2020)*/
/*and AdmitType in ('1-Emergency', '2-Urgent', '3-Elective')*/
;run;

%mend logip;
%AME (obs, bsev); /* all, children */
%AME (obs, int); /* all, adults, children */
%AME (obs, pa); /* all, adults, children */





/* ANALYSES WITH OBESITY CATEGORIES */

/*proc freq data=diag3IP_02; tables bmi; run;*/


%macro obct (iv, dv);

proc logistic data=diag3IP_02 descending;
class dm (ref='0') bmi (ref='0') obs (ref='0') bsev gender_val (ref='F') age (ref='4') race_val (ref='4')  payer1 Medi (ref='0') AdmitType PointOfOrigin/ param=ref;
model &dv = &iv age race_val gender_val Medi 
/*AdmitType*/
;
WHERE race_val in (2, 3, 4, 5) 
and &dv not in ('9')
and ageinyears >=19
/*and bmi not in ('9')*/
/*and DischYear in (2020)*/
/*and AdmitType in ('1-Emergency', '2-Urgent', '3-Elective')*/
;run;

%mend obct;
%obct (bmi, bsev); /* BMI >30: none; BMI >34: none; BMI > 39: none */
%obct (bmi, pa);   /* BMI >30: adults; BMI >34: adults ; BMI >39: adults */
%obct (bmi, clos);


/* Export */


PROC EXPORT DATA= diag3IP_02
     outfile = "C:\Users\kimy89\Dropbox\Research\Asthma_Cormobdities\Out\out"
     DBMS=xlsx REPLACE;
     sheet="COMM_IP";
RUN;



/*** DESC. STATS ***/

/* Asthma by year */
proc freq data=data.diag3IP_all; table dischyear; run;
proc freq data=diag3IP_02; table dischyear; run;

proc freq data=data.diag3IP_all; table dischyear; where ageinyears >= 19; run;


/* Asthma by severity */
proc freq data=diag3IP_02; table sev; where ageinyears >=19; run;
proc freq data=diag3IP_02; table sev; where ageinyears >=19 and bmi ne '0'; run;
proc sort data=diag3IP_02; by race_val; run;
proc freq data=diag3IP_02; table sev; by race_val; run;
proc freq data=diag3IP_02; table sev; by race_val; where bmi ne '0'; run;
proc freq data=diag3IP_02; table bmi; where ageinyears >=19; run;

proc freq data=diag3IP_02; table sev*bmi; where ageinyears >=19; run;
proc freq data=diag3IP_02; table age; where ageinyears >=19 and sev in ('0', '1', '2' '3') and race_val in (2, 3, 4, 5) ; run;
proc freq data=diag3IP_02; table age; where ageinyears >=19 and obs in ('0') and sev in ('0', '1', '2' '3') and race_val in (2, 3, 4, 5) ; run;
proc freq data=diag3IP_02; table age; where ageinyears >=19 and obs in ('1') and sev in ('0', '1', '2' '3') and race_val in (2, 3, 4, 5) ; run;

proc freq data=diag3IP_02; table gender_val; where ageinyears >=19 and sev in ('0', '1', '2' '3') and race_val in (2, 3, 4, 5) ; run;
proc freq data=diag3IP_02; table gender_val; where ageinyears >=19 and obs in ('0') and sev in ('0', '1', '2' '3') and race_val in (2, 3, 4, 5)  ; run;
proc freq data=diag3IP_02; table gender_val; where ageinyears >=19 and obs in ('1') and sev in ('0', '1', '2' '3') and race_val in (2, 3, 4, 5) ; run;

proc freq data=diag3IP_02; table race_val; where ageinyears >=19 and sev in ('0', '1', '2' '3') and race_val in (2, 3, 4, 5) ; run;
proc freq data=diag3IP_02; table race_val; where ageinyears >=19 and obs in ('0') and sev in ('0', '1', '2' '3') and race_val in (2, 3, 4, 5) ; run;
proc freq data=diag3IP_02; table race_val; where ageinyears >=19 and obs in ('1') and sev in ('0', '1', '2' '3') and race_val in (2, 3, 4, 5) ; run;

proc freq data=diag3IP_02; table sev; where ageinyears >=19 and sev in ('0', '1', '2' '3') and race_val in (2, 3, 4, 5) ; run;
proc freq data=diag3IP_02; table sev; where ageinyears >=19 and obs in ('0') and sev in ('0', '1', '2' '3') and race_val in (2, 3, 4, 5) ; run;
proc freq data=diag3IP_02; table sev; where ageinyears >=19 and obs in ('1') and sev in ('0', '1', '2' '3') and race_val in (2, 3, 4, 5) ; run;

proc freq data=diag3IP_02; table medi; where ageinyears >=19 and sev in ('0', '1', '2' '3') and race_val in (2, 3, 4, 5) ; run;
proc freq data=diag3IP_02; table medi; where ageinyears >=19 and obs in ('0') and sev in ('0', '1', '2' '3') and race_val in (2, 3, 4, 5) ; run;
proc freq data=diag3IP_02; table medi; where ageinyears >=19 and obs in ('1') and sev in ('0', '1', '2' '3') and race_val in (2, 3, 4, 5) ; run;

proc means data=diag3IP_02; var los; where ageinyears >=19 and sev in ('0', '1', '2' '3') and race_val in (2, 3, 4, 5) ; run;
proc means data=diag3IP_02; var los; where ageinyears >=19 and obs in ('0') and sev in ('0', '1', '2' '3') and race_val in (2, 3, 4, 5) ; run;
proc means data=diag3IP_02; var los; where ageinyears >=19 and obs in ('1') and sev in ('0', '1', '2' '3') and race_val in (2, 3, 4, 5) ; run;


proc freq data=diag3IP_02; table age*sev; where ageinyears >=19; run;
proc freq data=diag3IP_02; table gender_val*sev; where ageinyears >=19; run;
proc freq data=diag3IP_02; table gender_val*sev; where ageinyears >=19 and obs in ('0'); run;
proc freq data=diag3IP_02; table gender_val*sev; where ageinyears >=19 and obs in ('1'); run;


proc freq data=diag3IP_02; table dischyear; where sev not in ('9') and race_val in (2, 3, 4, 5) ; run;
proc freq data=diag3IP_02; table sev; where sev not in ('9') and race_val in (2, 3, 4, 5) ; run;

proc freq data=diag3IP_02; table dischyear; where ageinyears >=19 and obs in ('1') and sev in ('0', '1', '2' '3') and race_val in (2, 3, 4, 5) ; run;



/* Cost estimates */

proc sort data=diag3IP_02; by sev;run;
proc means data=diag3IP_02; var los totalcharge; by sev; run;

proc sort data=diag3IP_02; by bsev;run;
proc means data=diag3IP_02; var los totalcharge; by bsev; run;


/* Comparison by Obesity/non-Obesity */
/** Col pct **/
%macro COMPIP (var);

proc freq data=diag3IP_02; table &var; where sev not in ('9') and obs in ('1') and race_val in (2, 3, 4, 5) and AdmitType in ('1-Emergency', '2-Urgent', '3-Elective') ;run;
proc freq data=diag3IP_02; table &var; where sev not in ('9') and obs in ('0') and race_val in (2, 3, 4, 5) and AdmitType in ('1-Emergency', '2-Urgent', '3-Elective') ;run;

%mend COMP;
%COMPIP (sev);
%COMPIP (gender_val);
%COMPIP (race_val);
%COMPIP (age);
%COMPIP (medi);
%COMPIP (admittype);


/** Row pct **/
%macro COMIPR (var);

proc freq data=diag3IP_02; table &var; where sev not in ('9') and obs in ('1') and race_val in (2, 3, 4, 5) and AdmitType in ('1-Emergency', '2-Urgent', '3-Elective') ;run;
proc freq data=diag3IP_02; table &var; where sev not in ('9') and obs in ('0') and race_val in (2, 3, 4, 5) and AdmitType in ('1-Emergency', '2-Urgent', '3-Elective') ;run;

%mend COMPIPR;
%COMIPR (sev);
%COMIPR (gender_val);
%COMIPR (race_val);
%COMIPR (age);
%COMIPR (medi);
%COMIPR (admittype);



/************** Older Adults only - FOR APHA 2023 (3/21/23) - BEGINS HERE ****************************/

%macro OLDip (iv, dv);

proc logistic data=diag3IP_02 descending;
class dm (ref='0') obs (ref='0') bsev gender_val (ref='F') age (ref='4') race_val (ref='4')  payer1 Medi (ref='0') AdmitType PointOfOrigin/ param=ref;
model &dv = &iv age race_val gender_val Medi 
AdmitType
;
WHERE race_val in (2, 3, 4, 5) 
and &dv not in ('9')
and ageinyears > 64
/*and DischYear in (2020)*/
and AdmitType in ('1-Emergency', '2-Urgent', '3-Elective')
;run;

%mend OLDip;
%OLDip (obs, bsev);
%OLDip (obs, pa);
%OLDip (obs, clos); /* Sig if 65 and older */
%OLDip (dm, bsev);
%OLDip (dm, pa);
%OLDip (dm, clos); /* Sig if 65 and older BUT NEGATIVE */

proc freq data=diag3IP_02; table obs; 
where ageInyears > 64 and race_val in (2, 3, 4, 5) and obs not in ('9') and ageinyears > 64 and AdmitType in ('1-Emergency', '2-Urgent', '3-Elective');
run;

proc freq data=diag3IP_02; table obs*race_val; 
where ageInyears > 64 and race_val in (2, 3, 4, 5) and obs not in ('9') and ageinyears > 64 and AdmitType in ('1-Emergency', '2-Urgent', '3-Elective');
run;

proc freq data=diag3IP_02; table obs*gender_val; 
where ageInyears > 64 and race_val in (2, 3, 4, 5) and obs not in ('9') and ageinyears > 64 and AdmitType in ('1-Emergency', '2-Urgent', '3-Elective');
run;


/* Older Adults only - FOR APHA 2023 - ENDS HERE */






/* Below - For extra tests only */


/* race/ethnicity by year */
proc freq data=catIP_all; table race_val; by DischYear; run;


/* Top 10 Comorb by race */


%macro topIP (race);

proc freq data=catIP_all; table d01/ out=catIP_&race; by DischYear; where race_val in (&race); run;
proc sort data= catIP_&race; by DischYear descending count; run;


proc rank data=catIP_&race descending out=rankIP_&race;
by DischYear;
var count; 
ranks rank;
run;


data rankIP_&race; set rankIP_&race;
where rank <11;
run;

%mend;

%TOPIP (1);
%TOPIP (2);
%TOPIP (3);
%TOPIP (4);
%TOPIP (5);
%TOPIP (6);

/* 9/9/2022 */





/****** IP - if Asthma is primary  *****/


%macro PRIP (year);


data IP_&year (keep=DischYear DischQuarter ProviderID PatZip PatStateCode PatCountyName Race_val AgeInYears Gender_val AdmitType
PointOfOrigin DischargeStatus TotalCharge Payer1_val LOS Payer1 MSDRG CaseMix PrincipalDiagCat_val PrincipalDiagCat Diag01 Diag02 Diag03
Rev01 CPT01 Srv01 Rev02 CPT02 Srv02 Rev03 CPT03 CHIAID); 
set data.IP_&year; 
where patstatecode in ('NV'); run;


/*data res_&year; set ed_&year; where PrincipalDiagCat in ('08-Diseases of the REspiratory System (460-519)'); run;*/

data IP_&year; set IP_&year; 
d01 = substr(diag01, 1, 3); 
d02 = substr(diag02, 1, 3); 
d03 = substr(diag03, 1, 3); 
/*where d01 in ('493');*/
run;
 
data primIP_&year; set IP_&year;
where (DischYear <  2016 and (d01 in ('493')))
or    (DischYear >= 2016 and (d01 in ('J45')));
run;


%mend PRIMP;
%PRIP (2013);
%PRIP (2014);
%PRIP (2015);
%PRIP (2016);
%PRIP (2017);
%PRIP (2018);
%PRIP (2019);
%PRIP (2020);
%PRIP (2021);


/*
data primIP_all; set primIP_2013-primIP_2021;
race=put(race_val, 6.);
run;
*/





/* race/ethnicity by year */
proc freq data=primIP_all; table race_val / out=out1; by DischYear; run;


/* Top 10 Comorb by race */

/*proc freq data=prim_all; table d02/ out=prim_4; by DischYear; where race_val in (4); run;*/

%macro topPIP (race);

proc freq data=primIP_all; table d01 / out=primIP_&race._1; by DischYear; where race_val in (&race); run;
proc sort data=primIP_&race; by DischYear descending count; run;


proc rank data=primeIP_&race descending out=primIP_rankIP_&race;
by DischYear;
var count; 
ranks rank;
run;


data primIP_rankIP2_&race; set primIP_rankIP_&race;
where rank <11;
run;


%mend;

%TOPPIP (1);
%TOPPIP (2);
%TOPPIP (3);
%TOPPIP (4);
%TOPPIP (5);
%TOPPIP (6);



/* 9/23/2022 */



/* DATA ANALYSIS */

%macro freq (var1, var2);

proc sort data=primip_all; by &var2; run;
proc freq data=PrimIp_all; tables &var1; by &var2  ; where DischYear in (2021); run;

%mend freq;

%freq (admittype, race_val);
%freq (admittype, );
%freq (pointoforigin);
%freq (pointoforigin, race_val);
%freq (dischargestatus);
%freq (payer1);




proc freq data=Primip_all; by race_val ; where DischYear in ('2021'); run;


/** Numeric variables **/

%macro means (var1, var2);

proc sort data=primip_all; by &var2; run;
proc means data=primIP_all; var &var1; by &var2; where dischyear in (2021); run;

%mend means;

%means (LOS, Race_val );
%means (totalcharge, Race_val );



%macro means (var1, var2);

proc sort data=diag3IP_all; by &var2; run;
proc means data=diag3IP_all; var &var1; by &var2; 
/*where dischyear in (2021);*/
run;

%mend means;

%means (LOS, Race_val );
%means (totalcharge, Race_val );


/* BMI */

data test; set diag3ip_all; 
where d01 in ('Z68') or d02 in ('Z68') or d03 in ('Z68');
run;

/* 2021 - #37 out of 1286 */

data bmi_01; set diag3ip_all; 
where (d01 in ('Z68') or d02 in ('Z68') or d03 in ('Z68')) and (dischyear >=2016) ;
run;


proc freq data=diag3ip_all; table race_val/ out=test2; run;
proc freq data=bmi_01;      table race_val/ out=test3; run;


proc sql; create table ratio as select

a.race_val,
a.Count as freq_all,
b.Count as freq_bmi,
b.Count/a.Count as ratio

from test2 as a
left join test3 as b on a.race_val=b.race_val;
quit;



/*proc freq data=bmi_01; table diag02 diag03; run;*/
/*proc sort data-bmi_01; by dischyear; run;*/
/*proc freq data=bmi_01; table race_val; by dischyear; run;*/



/* 
1. Native or Alaskan
2. Asian or Pacific Islander
3. African Americans
4. White
5. Hispanic
6. Other
*/



/* 339 - 2016 thru 2021 */



proc sort  data=diag3ip_02; by bmi; run;
proc means data=diag3ip_02; var los; by bmi;run;


/*data diag3ip_02; set diag3ip_02; */
/*dmn=input(dm, 8.);*/
/*run;*/

proc sort  data=diag3ip_02; by race_val; run;
proc means data=diag3ip_02; var dmn; by race_val;run;


/*** t-test ***/

proc ttest data=diag3ip_02; /* Only AFRI sig if age >=19 */
class bmi;
var los;
where Race_val in (3) 
and AgeInYears >=19
;
run;




/* Distribution */

%macro distr(var);

/*ods graphics on;*/
/*ods select Plots SSPlots;*/
proc univariate data=diag3ip_02 plots; 
var &var; run;

%mend distr;
%distr (los);
%distr (totalcharge);


%macro means (var1, var2);
proc sort data=diag3IP_all; by &var2; run;
proc means data=diag3IP_all; var &var1; by &var2; 
run;
%mend means;
%means (LOS, Race_val );
%means (totalcharge, Race_val );


proc sort data=diag3IP_02; by race_val; run;
proc freq data=diag3IP_02; table sev; by race_val; run;
proc freq data=diag3IP_02; table sev; by race_val; where sev not in ('9'); run;
proc freq data=diag3IP_02; table bsev; by race_val; run;
proc freq data=diag3IP_02; table pa; by race_val; run;
proc freq data=diag3IP_02; table AdmitType; by race_val; run;
proc freq data=diag3IP_02; table PointOfOrigin; by race_val; run;
proc freq data=diag3IP_02; table obs; where ageInyears > 64; run;      /* 7.24 */
proc freq data=diag3IP_02; table obs; where 18 < ageInyears < 65; run; /*12.08 */
proc freq data=diag3IP_02; table obs; where 18 < ageInyears < 30; run; /* 7.56 */
proc freq data=diag3IP_02; table obs; where 29 < ageInyears < 40; run; /*14.57 */
proc freq data=diag3IP_02; table obs; where 39 < ageInyears < 50; run; /*15.12 */
proc freq data=diag3IP_02; table obs; where 49 < ageInyears < 65; run; /*12.46 */

proc freq data=diag3IP_02; table dm;  where ageInyears > 64; run;
proc sort data=diag3IP_02; by race_val; run;
proc freq data=diag3IP_02; table obs*race_val; where ageInyears > 64; run;
proc freq data=diag3IP_02; table dm*race_val; where ageInyears > 64; run;


data obs_n; set diag3IP_02; /* n=2,569 out of 31,422 */
where obs in ('1');
run;

data dm_n; set diag3IP_02; /* n=667 */
where dm in ('1');
run;


/* GLM */

proc glm data=diag3ip_02; 
class bmi dm race_val (ref='4') gender_val medi;
model los = dm race_val gender_val medi/ solution;
where
/*Race_val in (3) and*/
/*AgeInYears >= 19*/
/*and */
race_val in (2, 3, 4, 5) 
;
run;

/* Sig - AFRI OVER 19 */


/*** Total Charge ***/

proc glm data=diag3ip_02; 
class bmi dm race_val (ref='4') gender_val medi;
model totalcharge = dm race_val gender_val medi/ solution;
where
/*and*/
/*AgeInYears >= 19*/
/*and */
race_val in (2,3,4,5) 
;
run;




/*Logistic regression - */

proc logistic data=diag3ip_02 descending;
class /* DM (ref='0')*/ gender_val (ref='F') race_val (ref='4')  payer1 Medi/ param=ref;
model dm = race_val gender_val Medi;
WHERE RACE_val in (2, 3, 4, 5) 
/*and ageinyears >=19*/
/*and DischYear in (2020)*/
;run;

/* Sig
HISP: <19, All ages,
AFRI: >=19, All ages,
ASIA: >=19, All ages,

Year specific
2020(n=     ): ?? >=19
2020(n=2,684 out of 339,438): AFRI, >=19
2019(n=4,062 out of 368,212): AFRI,ASIA, HISP >=19
2018(n=3,784 out of 367,556): HISP >=19
2017(n=3,264 out of 352,262): NO >=19
2016(n=3,497 out of 337,646): ASIA >=19

*/


proc logistic data=diag3ip_02 descending;
class dm (ref='0') bmi (ref='0') gender_val (ref='F') race_val (ref='4')  payer1 Medi (ref='0')clos (ref='0')/ param=ref;
model clos = bmi race_val gender_val Medi;
WHERE RACE_val in (2, 3, 4, 5) 
/*and ageinyears >=19*/
/*and DischYear in (2020)*/
;run;


proc logistic data=diag3ip_02 descending;
class dm (ref='0') bmi (ref='0') gender_val (ref='F') race_val (ref='4')  payer1 Medi (ref='0')clos (ref='0')/ param=ref;
model clos = bmi race_val gender_val medi;
WHERE RACE_val in (2, 3, 4, 5) 
and ageinyears <19
/*and DischYear in (2021)*/
;run;






proc logistic data=diag3IP_02 descending;
class dm (ref='0') bmi (ref='0') bsev gender_val (ref='F') race_val (ref='4')  payer1 Medi (ref='0')/ param=ref;
model pa = bmi race_val gender_val Medi;
WHERE RACE_val in (2, 3, 4, 5) 
and pa not in ('9')
/*and ageinyears >=19*/
/*and DischYear in (2020)*/
;run;


proc logistic data=diag3IP_02 descending;
class dm (ref='0') bmi (ref='0') bsev gender_val (ref='F') race_val (ref='4')  payer1 Medi (ref='0')/ param=ref;
model bsev = dm race_val gender_val Medi;
WHERE RACE_val in (2, 3, 4, 5) 
and bsev not in ('9')
/*and ageinyears >=19*/
/*and DischYear in (2020)*/
;run;



/* Interaction */
proc logistic data=diag3ip_02 descending;
class dm (ref='0') gender_val (ref='F') race_val (ref='4')  payer1 Medi clos (ref='0')/ param=ref;
model clos = dm*race_val gender_val Medi;
WHERE RACE_val in (2, 3, 4, 5) 
/*and ageinyears >=19*/
/*and DischYear in (2020)*/
;run;


proc logistic data=diag3ip_02 descending;
class dm (ref='0') bmi (ref='0') gender_val (ref='F') race_val (ref='4')  payer1 Medi (ref='0') clos (ref='0')/ param=ref;
model clos = bmi race_val bmi*race_val gender_val Medi;
WHERE RACE_val in (2, 3, 4, 5) 
and ageinyears <19
/*and DischYear in (2020)*/
;run;


data test; set diag3ip_02;
if race_val eq 5;
where dischyear in (2020);
run;


/* DM */

data dm; set diag3IP_02; /* 21 out of 1286 */
where d01 in ('E11') or d02 in ('E11') or d03 in ('E11');
run;






