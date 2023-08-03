
libname data "C:\Users\...\Data\CHIA\Final_SAS_Files";
libname dir "C:\Users\...\Documents\Data\GI-ED";

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

data EDA_&year; set data.ED_&year; 
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

data EDA_&year._&i (keep=DischYear DischQuarter PrvID PatZip PatStateCode PatCountyName Race_val race AgeInYears Gender_val AdmitType
PointOfOrigin DischargeStatus TotalCharge LOS Payer1_val  Payer1 MSDRG CaseMix PrincipalDiagCat_val PrincipalDiagCat 
diag_1-diag_20 d_1-d_20
/*diag_&i*/

Rev01 CPT01 Srv01 Rev02 CPT02 Srv02 Rev03 CPT03 CHIAID); 
set EDA_&year;



%end;

data EDACom_&year;
set EDA_&year._1 - EDA_&year._20;
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

data INDA_&year (keep=
DischYear DischQuarter PrvID PatZip PatStateCode PatCountyName Race_val Race AgeInYears Gender_val AdmitType
PointOfOrigin DischargeStatus TotalCharge LOS Payer1_val  Payer1 MSDRG CaseMix PrincipalDiagCat_val PrincipalDiagCat 
diag_1-diag_20 d_1-d_20
/*diag_&i*/
Rev01 CPT01 Srv01 Rev02 CPT02 Srv02 Rev03 CPT03 CHIAID CAN1
); 
set EDACom_&year;
run; 

data INDA_&year;
set INDA_&year;  

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

proc freq data=dir.inda_all; table dischyear; run;


data dir.INDA_All 
(keep= time dischyear dischquarter patzip patcountyname race_val Race AgeInYears agegrp gender_val payer1 can2 can nau nic alc opi sed coc sho mod);
set INDA_2013 - INDA_2021;
if ageinyears <12 then agegrp='Under12';
else if ageinyears <20 then agegrp='12-19';
else if ageinyears <30 then agegrp='21-29';
else if ageinyears <45 then agegrp='30-44';
else if ageinyears <65 then agegrp='45-64';
else if ageinyears => 65 then agegrp='65UP';

run;

