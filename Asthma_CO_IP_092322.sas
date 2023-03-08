libname data "C:\Users\..........\Final_SAS_Files";




/****** IP - if Diag 1 thru 3 includes asthma  *****/

%macro IP (year);


data Ip_&year (keep=DischYear DischQuarter PrvID PatZip PatStateCode PatCountyName Race_val AgeInYears Gender_val
PointOfOrigin DischargeStatus TotalCharge LOS Payer1_val  Payer1 MSDRG CaseMix PrincipalDiagCat_val PrincipalDiagCat 
Diag01 Diag02 Diag03 Diag04 Diag05 Diag06 Diag07 Diag08 Diag09 Diag10 
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



data catIP_all; set catIP_2013-catIP_2021;
run;


/* 
1. Native or Alaskan
2. Asian or Pacific Islander
3. African Americans
4. White
5. Hispanic
6. Other
*/



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


/****** IP - if Asthma is primary, secondary, or tertiry  *****/


%macro PRIP (year);


data IP_&year (keep=DischYear DischQuarter ProviderID PatZip PatStateCode PatCountyName Race_val AgeInYears Gender_val AdmitType
PointOfOrigin DischargeStatus TotalCharge Payer1_val LOS Payer1 MSDRG CaseMix PrincipalDiagCat_val PrincipalDiagCat 
Diag01 Diag02 Diag03 Diag04 Diag05 Diag06 Diag07 Diag08 Diag09 Diag10
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


     if s01 in ('J452') or s02 in ('J452') or s03 in ('J452') then sev = '0';
else if s01 in ('J453') or s02 in ('J453') or s03 in ('J453') then sev = '1';
else if s01 in ('J454') or s02 in ('J454') or s03 in ('J454') then sev = '2';
else if s01 in ('J455') or s02 in ('J455') or s03 in ('J455') then sev = '3';
else sev='9';

     if s01 in ('J452') or s02 in ('J452') or s03 in ('J452') then bsev = '0';
else if s01 in ('J453') or s02 in ('J453') or s03 in ('J453') then bsev = '0';
else if s01 in ('J454') or s02 in ('J454') or s03 in ('J454') then bsev = '0';
else if s01 in ('J455') or s02 in ('J455') or s03 in ('J455') then bsev = '1';
else bsev='9';

     if s01 in ('J452') or s02 in ('J452') or s03 in ('J452') then pa = '0';
else if s01 in ('J453') or s02 in ('J453') or s03 in ('J453') then pa = '1';
else if s01 in ('J454') or s02 in ('J454') or s03 in ('J454') then pa = '1';
else if s01 in ('J455') or s02 in ('J455') or s03 in ('J455') then pa = '1';
else pa='9';

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


data  diag3IP_all; set  diag3_IP_2013- diag3_IP_2021;
race=put(race_val, 6.);
run;



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

/* Create data with BMI indicator */

data diag3IP_02; set diag3IP_all;

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
s10 in ('Z683', 'Z684') 
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
(s10 in ('Z685') and diag10 in ('Z6854'))  
then obs = '1';

else obs='0';


if d01 in ('E11') or d02 in ('E11') or d03 in ('E11')
then dm = '1';
else dm = '0';

if payer1 in ('16-Nevada Medicaid', '17-Other Medicaid', '28-Nevada Medicaid HOM')
then medi = '1';
else medi = '0';

if los > 3 then clos = '1'; /* need to confirm los >3 or los >= */
else if los =< 3 then clos = '0';

dmn=input(dm, 8.);

where dischyear >= 2016;
run;

proc sort  data=diag3ip_02; by bmi; run;
proc means data=diag3ip_02; var los; by bmi;run;


/*data diag3ip_02; set diag3ip_02; */
/*dmn=input(dm, 8.);*/
/*run;*/

proc sort  data=diag3ip_02; by race_val; run;
proc means data=diag3ip_02; var dmn; by race_val;run;


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


/* Persistent & severe Asthma */

%macro log (iv, dv);

proc logistic data=diag3IP_02 descending;
class dm (ref='0') obs (ref='0') bsev gender_val (ref='F') race_val (ref='4')  payer1 Medi (ref='0')/ param=ref;
model &dv = &iv &iv*race_val gender_val Medi;
WHERE race_val in (2, 3, 4, 5) 
and &dv not in ('9')
/*and ageinyears >=19*/
/*and DischYear in (2020)*/
;run;

%mend log;
%log (obs, bsev);
%log (obs, pa);
%log (dm, bsev);
%log (dm, pa);




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






