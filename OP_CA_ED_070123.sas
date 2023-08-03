
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



/* BEGINNING of WIHTOUT CANNABIS */



%macro EDW (year);

data EDOP_&year; set data.ED_&year; 
d_1 =  substr(diag01, 1, 3); d_2  = substr(diag02, 1, 3); d_3  = substr(diag03, 1, 3); d_4  = substr(diag04, 1, 3); d_5  = substr(diag05, 1, 3); 
d_6 =  substr(diag06, 1, 3); d_7  = substr(diag07, 1, 3); d_8  = substr(diag08, 1, 3); d_9  = substr(diag09, 1, 3); d_10 = substr(diag10, 1, 3); 
d_11 = substr(diag11, 1, 3); d_12 = substr(diag12, 1, 3); d_13 = substr(diag13, 1, 3); d_14 = substr(diag14, 1, 3); d_15 = substr(diag15, 1, 3); 
d_16 = substr(diag16, 1, 3); d_17 = substr(diag17, 1, 3); d_18 = substr(diag18, 1, 3); d_19 = substr(diag19, 1, 3); d_20 = substr(diag20, 1, 3); 

rename Diag01 = Diag_1;  rename Diag02 = Diag_2;  rename Diag03 = Diag_3;   rename Diag04 = Diag_4;  rename Diag05 = Diag_5; 
rename Diag06 = Diag_6;  rename Diag07 = Diag_7;  rename Diag08 = Diag_8;   rename Diag09 = Diag_9;  rename Diag10 = Diag_10; 
rename Diag11 = Diag_11; rename Diag12 = Diag_12; rename Diag13 = Diag_13;  rename Diag14 = Diag_14; rename Diag15 = Diag_15; 
rename Diag16 = Diag_16; rename Diag17 = Diag_17; rename Diag18 = Diag_18;  rename Diag19 = Diag_19; rename Diag20 = Diag_20; 

run;

data EDOP_&year (keep=DischYear DischQuarter PrvID PatZip PatStateCode PatCountyName Race Race_val AgeInYears Gender_val AdmitType
PointOfOrigin DischargeStatus TotalCharge LOS Payer1_val  Payer1 MSDRG CaseMix PrincipalDiagCat_val PrincipalDiagCat 
diag_1-diag_20 d_1-d_20
/*diag_&i*/

Rev01 CPT01 Srv01 Rev02 CPT02 Srv02 Rev03 CPT03 CHIAID can1 ); 
set EDOP_&year;

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

data IEDOP_&year (keep=
DischYear DischQuarter PrvID PatZip PatStateCode PatCountyName Race Race_val AgeInYears Gender_val AdmitType
PointOfOrigin DischargeStatus TotalCharge LOS Payer1_val  Payer1 MSDRG CaseMix PrincipalDiagCat_val PrincipalDiagCat 
diag_1-diag_20 d_1-d_20
/*diag_&i*/
Rev01 CPT01 Srv01 Rev02 CPT02 Srv02 Rev03 CPT03 CHIAID CAN1
); 
set EDOP_&year;
run; 

data IEDOP_&year;
set IEDOP_&year;  

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


data dir.IEDOP_All 
(keep= time dischyear dischquarter patzip patcountyname race payer1 race_val ageinyears agegrp gender_val can2 can nau nic alc opi sed coc sho);
set IEDOP_2013 - IEDOP_2021;
if ageinyears < 21 then agegrp = 'Uner21';
else if ageinyears <30 then agegrp = '21-29';
else if ageinyears < 44 then agegrp ='30-44';
else if ageinyears < 64 then agegrp = '45-64';
else if ageinyears > 64 then agegrp ='65up'; 
run;

/* Total Count: Generated */

proc sql; create table dir.AGGEDOP
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

from dir.IEDOP_all

group by DischYear, DischQuarter
order by DischYear, DischQuarter;
quit;

proc sql; create table dir.AGGEDOP1
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

from dir.aggEDOP as a
left join dir.tcnt as b on a.yr=b.yr and a.qt=b.qt;
quit;

/* tmod generated above */

data dir.aggEDOP2; set dir.aggEDOP1; 
tm=yr*100+qt;
if tm gt 201402 then RCM6=1; else RCM6=0;
if tm gt 201502 then RCM4=1; else RCM4=0;
if tm gt 201504 then RCM3=1; else RCM3=0;
if tm gt 201602 then RCM2=1; else RCM2=0;
if tm gt 201604 then RCM0=1; else RCM0=0;
if tm gt 201702 then RCM=1; else RCM=0;
if tm gt 201704 then RCM1=1; else RCM1=0;
if tm gt 201802 then RCM5=1; else RCM5=0;
if tm gt 201804 then RCM7=1; else RCM7=0;
z=0;
zt=0;
zx=0;
ztx=0;
run;


proc sql; create table dir.aggEDOP3
as select 
a.*,
b.t,
b.x,
b.tx,
c.*,
(c.uninsured/c.pop_dn) as uninsr

from dir.aggEDOP2  as a
left join tmod as b on a.tm=b.tm
left join cont as c on a.yr=c.yr and a.qt=c.qt;
quit;



/* ADD MACRO-CONTROL VARIABLES */

proc import datafile="C:\Users\kimy89\Dropbox\Research\Cannabis_Opioid\Data\Covariate_data_071123.xlsx"
dbms= xlsx out=cont replace; 
SHEET='Comb'; GETNAMES=YES; quit;


/* 7/12/2023 */





























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

data EDOP_&year._&i (keep=DischYear DischQuarter PrvID PatZip PatStateCode PatCountyName Race_val race AgeInYears Gender_val AdmitType
PointOfOrigin DischargeStatus TotalCharge LOS Payer1_val  Payer1 MSDRG CaseMix PrincipalDiagCat_val PrincipalDiagCat 
diag_1-diag_20 d_1-d_20
/*diag_&i*/

Rev01 CPT01 Srv01 Rev02 CPT02 Srv02 Rev03 CPT03 CHIAID); 
set ED_&year;


where
   (DischYear <  2015 and diag_&i in (&opioid9))
or (DischYear =  2015 and DischQuarter < 4 and diag_&i in (&opioid9)) 
or (DischYear =  2015 and DischQuarter = 4 and d_&i in (&opioid10)) 
or (DischYear >= 2016 and d_&i in (&opioid10))
;run;

%end;

data dir.EDOP_&year;
set EDOP_&year._1 - EDOP_&year._20;
OPI = '1';
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

data dir.EDOP_All 
(keep= time dischyear dischquarter patzip patcountyname race_val Race AgeInYears gender_val opi
/*can2 can nau nic alc opi sed coc sho*/
);
set dir.EDOP_2013 - dir.EDOP_2021;
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



proc sql; create table dir.EDOP_AGG
as select 
dischYear as YR,
dischquarter as QT,
/*count (*) as denom,*/
sum (opi='1') as OPI

from dir.EDOP_all

group by DischYear, DischQuarter
order by DischYear, DischQuarter;
quit;





proc sql; create table dir.EDOP_agg1
as select 
a.*,
b.denom as denom,
a.opi/b.denom as opi_r

from dir.EDOP_agg as a
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


data dir.EDOP_agg2; set dir.EDOP_agg1; 
tm=yr*100+qt;
if tm gt 201702 then RCM=1; else RCM=0;
if tm gt 201704 then RCM1=1; else RCM1=0;
z=1;
run;



proc sql; create table dir.EDOP_agg3
as select 
a.*,
b.t,
b.tx,
b.x,
b.zt,
b.zx,
b.ztx

from dir.EDOP_agg2  as a
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


