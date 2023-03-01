libname data "C:\Users\kimy89\Documents\Data\CHIA\Final_SAS_Files";




/****** ED - if Diag 1 thru 3 includes asthma  *****/

%macro ED (year);


data ed_&year (keep=DischYear DischQuarter ProvID PatZip PatStateCode PatCountyName Race_val AgeInYears Gender_val
PointOfOrigin DischargeStatus TotalCharge Payer1_val Payer1 PrincipalDiagCat_val PrincipalDiagCat Diag01 Diag02 Diag03
Rev01 CPT01 Srv01 Rev02 CPT02 Srv02 Rev03 CPT03 CHIAID); 
set data.ed_&year; 
where patstatecode in ('NV'); run;


/*data res_&year; set ed_&year; where PrincipalDiagCat in ('08-Diseases of the REspiratory System (460-519)'); run;*/

data ed_&year; set ed_&year; 
d01 = substr(diag01, 1, 3); 
d02 = substr(diag02, 1, 3); 
d03 = substr(diag03, 1, 3); 
/*where d01 in ('493');*/

s01 = substr(diag01, 1, 4); 
s02 = substr(diag02, 1, 4); 
s03 = substr(diag03, 1, 4); 

if s01 in ('J453') or s02 in ('J453') or s03 in ('J453') then sev = '1';
else if s01 in ('J454') or s02 in ('J454') or s03 in ('J454') then sev = '2';
else if s01 in ('J455') or s02 in ('J455') or s03 in ('J455') then sev = '3';
else sev='9';

run;
 
data cat_&year; set ed_&year;
where (DischYear <  2016 and (d01 in ('493') or d02 in ('493') or d03 in ('493')))
or    (DischYear >= 2016 and (d01 in ('J45') or d02 in ('J45') or d03 in ('J45')));
run;


%mend ED;
%ED (2013);
%ED (2014);
%ED (2015);
%ED (2016);
%ED (2017);
%ED (2018);
%ED (2019);
%ED (2020);
%ED (2021); /* 1,029,364 */



data catED_all; set cat_2013-cat_2021;
run;

proc sort data=cated_all; by race_val; run;
proc freq data=cated_all; table sev; by race_val; run;

/* 
1. Native or Alaskan
2. Asian or Pacific Islander
3. African Americans
4. White
5. Hispanic
6. Other
*/



/* race/ethnicity by year */
proc freq data=catED_all; table race_val; by DischYear; run;


/* Top 10 Comorb by race */

%macro top (race);

proc freq data=catED_all; table d01/ out=catED_&race; by DischYear; where race_val in (&race); run;
proc sort data= catED_&race; by DischYear descending count; run;


proc rank data=catED_&race descending out=rank_&race;
by DischYear;
var count; 
ranks rank;
run;


data rank_&race; set rank_&race;
where rank <11;
run;

%mend;

%TOP (1);
%TOP (2);
%TOP (3);
%TOP (4);
%TOP (5);
%TOP (6);

/* 9/9/2022 */





/****** ED - if Asthma is primary  *****/


%macro PRIM (year);


data ed_&year (keep=DischYear DischQuarter ProvID PatZip PatStateCode PatCountyName Race_val AgeInYears Gender_val
PointOfOrigin DischargeStatus TotalCharge Payer1_val Payer1 PrincipalDiagCat_val PrincipalDiagCat Diag01 Diag02 Diag03
Rev01 CPT01 Srv01 Rev02 CPT02 Srv02 Rev03 CPT03 CHIAID); 
set data.ed_&year; 
where patstatecode in ('NV'); run;


/*data res_&year; set ed_&year; where PrincipalDiagCat in ('08-Diseases of the REspiratory System (460-519)'); run;*/

data ed_&year; set ed_&year; 
d01 = substr(diag01, 1, 3); 
d02 = substr(diag02, 1, 3); 
d03 = substr(diag03, 1, 3); 
/*where d01 in ('493');*/
run;
 
data prim_&year; set ed_&year;
where (DischYear <  2016 and (d01 in ('493')))
or    (DischYear >= 2016 and (d01 in ('J45')));
run;


%mend PRIM;
%PRIM (2013);
%PRIM (2014);
%PRIM (2015);
%PRIM (2016);
%PRIM (2017);
%PRIM (2018);
%PRIM (2019);
%PRIM (2020);



data prim_all; set prim_2013-prim_2020;
run;



/****** ED - if Asthma is primary, secondary, or tertiry  *****/


%macro PRIPED (year);


data ED_&year (keep=DischYear DischQuarter ProviderID PatZip PatStateCode PatCountyName Race_val AgeInYears Gender_val AdmitType
PointOfOrigin DischargeStatus TotalCharge Payer1_val LOS Payer1 MSDRG CaseMix PrincipalDiagCat_val PrincipalDiagCat 
Diag01 Diag02 Diag03 Diag04 Diag05 Diag06 Diag07 Diag08 Diag09 Diag10
Rev01 CPT01 Srv01 Rev02 CPT02 Srv02 Rev03 CPT03 CHIAID); 
set data.ED_&year; 
where patstatecode in ('NV'); run;


/*data res_&year; set ed_&year; where PrincipalDiagCat in ('08-Diseases of the REspiratory System (460-519)'); run;*/

data ED_&year; set ED_&year; 
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
 
data diag3_ED_&year; set ED_&year;
where (DischYear <  2016 and (d01 in ('493') or d02 in ('493') or d03 in ('493')))
or    (DischYear >= 2016 and (d01 in ('J45') or d02 in ('J45') or d03 in ('J45')));
run;


data diag3_ED_&year; set diag3_ED_&year;
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

%mend PRIMPED;
%PRIPED (2013);
%PRIPED (2014);
%PRIPED (2015);
%PRIPED (2016);
%PRIPED (2017);
%PRIPED (2018);
%PRIPED (2019);
%PRIPED (2020);
%PRIPED (2021);


/* Incomplete */
data primED_all; set primED_2013-primED_2021;
race=put(race_val, 6.);
run;



data  diag3ED_all; set  diag3_ED_2013- diag3_ED_2021;
race=put(race_val, 6.);
run;


/* race/ethnicity by year */
proc freq data=primED_all; table race_val / out=out1; by DischYear; run;


/* Top 10 Comorb by race */

/*proc freq data=prim_all; table d02/ out=prim_4; by DischYear; where race_val in (4); run;*/

%macro top (race);

proc freq data=prim_all; table d02/ out=prim_&race; by DischYear; where race_val in (&race); run;
proc sort data= prim_&race; by DischYear descending count; run;


proc rank data=prim_&race descending out=prank_&race;
by DischYear;
var count; 
ranks rank;
run;


data prank_&race; set prank_&race;
where rank <11;
run;

%mend;

%TOP (1);
%TOP (2);
%TOP (3);
%TOP (4);
%TOP (5);
%TOP (6);




/* Create data with BMI indicator */

data diag3ED_02; set diag3ED_all;

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

/*if los > 3 then clos = '1';*/
/*else if los =< 3 then clos = '0';*/

dmn=input(dm, 8.);

where dischyear >= 2016;
run;




/* Distribution */

%macro distr(var);

/*ods graphics on;*/
/*ods select Plots SSPlots;*/
proc univariate data=diag3ED_02 plots; 
var &var; run;

%mend distr;
/*%distr (los);   - NOT AVAILABLE */
%distr (totalcharge);


proc univariate data=diag3ED_02 plots; 
var los; run;

proc freq data=diag3ED_02; table sev; run;
proc freq data=diag3ED_02; table bsev; run;
proc freq data=diag3ED_02; table pa; run;


proc sort data=diag3ED_02; by race_val; run;
proc freq data=diag3ED_02; table sev; by race_val; run;
proc freq data=diag3ED_02; table sev; by race_val; where sev not in ('9'); run;
proc freq data=diag3ED_02; table bsev; by race_val; run;
proc freq data=diag3ED_02; table pa; by race_val; run;
proc freq data=diag3ED_02; table bmi; by race_val; run;


data test; set diag3ED_02;
where d01 in ('z88') or d02 in ('z68') or d03 in ('z68') or d04 in ('z68') or d05 in ('z68') or d06 in ('z68');
run;

data obs_n; set diag3ED_02; /* n=3,040 out of 263,514*/
where obs in ('1');
run;

data dm_n; set diag3ED_02; /* n=6,564 */
where dm in ('1');
run;

proc freq data=diag3ED_02; table obs; run;
proc freq data=diag3ED_02; table dm; run;


/*Statistical analyses*/

data logit; set prim_2020;
if d02 = 'E11' or d03 = 'E11' then DM =1;
else DM =0;


run;

/* Sampling for non-DM/non-OBS */

/* OBS */

proc sql outobs=3040;
create table obs_n as select
*
from diag3ED_02
where obs not in ('1')
order by ranuni(0);
quit;


proc freq data=diag3ED_02; table race_val; run;
proc freq data=obs_n; table race_val; run;

proc freq data=diag3ED_02; table ageinyears gender_val; run;
proc freq data=obs_n; table ageinyears gender_val; run;

data obs_y; set diag3ED_02;
where obs in ('1');
run;

data obs; set obs_y obs_n; run;


data obs_y; set diag3ED_02;
where obs in ('1');
run;


/*Desc Stats*/
proc sort data=logit; by race_val;run;
proc means data=logit; var dm; by race_val; where ageinyears < 19;run;
/* 2, 5, 6 are higher for all
   5 is higher for all
*/






/*Logistic regression - not Sig*/
proc logistic data=logit descending;
class /* DM (ref='0')* gender_val (ref='F') */ race_val /* age_category spa_f (ref='0') lang (ref='Eng') src_lang */ / param=ref;
model dm = race_val ;
WHERE RACE_val in (2, 3, 4, 5) and ageinyears <19;
;
run;


%macro log (iv, dv);

proc logistic data=diag3ed_02 descending;
class dm (ref='0') obs (ref='0') bsev gender_val (ref='F') race_val (ref='4')  payer1 Medi (ref='0')/ param=ref;
model &dv = &iv race_val gender_val Medi;
where race_val in (2, 3, 4, 5) 
and &dv not in ('9')
/*and ageinyears >=19*/
/*and DischYear in (2020)*/
;run;

%mend log;
%log (obs, bsev);
%log (obs, pa);
%log (dm, bsev);
%log (dm, pa);


/* Using sampling data */


%macro logs (iv, dv);

proc logistic data=obs descending;
class dm (ref='0') obs (ref='0') bsev gender_val (ref='F') race_val (ref='4')  payer1 Medi (ref='0')/ param=ref;
model &dv = &iv race_val gender_val Medi;
where race_val in (2, 3, 4, 5) 
and &dv not in ('9')
/*and ageinyears >=19*/
/*and DischYear in (2020)*/
;run;

%mend logs;
%logs (obs, bsev);
%logs (obs, pa);
%logs (dm, bsev);
%logs (dm, pa);






/* BMI & Asthma */

proc sql; create table bmi_01 as 
select *
from diag3ED_02
where d01  in ('Z68') or d02  in ('Z68') or d03  in ('Z68') or d04  in ('Z68') or d05  in ('Z68') or 
      d06  in ('Z68') or d07  in ('Z68') or d08  in ('Z68') or d09  in ('Z68') or d10  in ('Z68');
/*where d01 or d02 or d03 or d04 or d05 or d06 or d07 or d08 or d09 or d10 in ('Z68') ;*/
quit;
/* n= 3,310 */


data bmi_02; set bmi_01;
 
if d01 in ('Z68') and input(substr(diag01, 4, 2), 8.) <20 then bmi = '1';
else if 
d01 in ('Z68') and input(substr(diag01, 4, 2), 8.) <30 then bmi = '2';
else if 
d01 in ('Z68') and input(substr(diag01, 4, 2), 8.) <40 then bmi = '3';
else if 
d01 in ('Z68') and input(substr(diag01, 4, 2), 8.) >=40 then bmi = '4';


else if 
d02 in ('Z68') and input(substr(diag02, 4, 2), 8.) <20 then bmi = '1';
else if 
d02 in ('Z68') and input(substr(diag02, 4, 2), 8.) <30 then bmi = '2';
else if 
d02 in ('Z68') and input(substr(diag02, 4, 2), 8.) <40 then bmi = '3';
else if 
d02 in ('Z68') and input(substr(diag02, 4, 2), 8.) >=40 then bmi = '4';


else if 
d03 in ('Z68') and input(substr(diag03, 4, 2), 8.) <20 then bmi = '1';
else if 
d03 in ('Z68') and input(substr(diag03, 4, 2), 8.) <30 then bmi = '2';
else if 
d03 in ('Z68') and input(substr(diag03, 4, 2), 8.) <40 then bmi = '3';
else if 
d03 in ('Z68') and input(substr(diag03, 4, 2), 8.) >=40 then bmi = '4';

else if 
d04 in ('Z68') and input(substr(diag04, 4, 2), 8.) <20 then bmi = '1';
else if 
d04 in ('Z68') and input(substr(diag04, 4, 2), 8.) <30 then bmi = '2';
else if 
d04 in ('Z68') and input(substr(diag04, 4, 2), 8.) <40 then bmi = '3';
else if 
d04 in ('Z68') and input(substr(diag04, 4, 2), 8.) >=40 then bmi = '4';

else if 
d05 in ('Z68') and input(substr(diag05, 4, 2), 8.) <20 then bmi = '1';
else if 
d05 in ('Z68') and input(substr(diag05, 4, 2), 8.) <30 then bmi = '2';
else if 
d05 in ('Z68') and input(substr(diag05, 4, 2), 8.) <40 then bmi = '3';
else if 
d05 in ('Z68') and input(substr(diag05, 4, 2), 8.) >=40 then bmi = '4';

else if 
d06 in ('Z68') and input(substr(diag06, 4, 2), 8.) <20 then bmi = '1';
else if 
d06 in ('Z68') and input(substr(diag06, 4, 2), 8.) <30 then bmi = '2';
else if 
d06 in ('Z68') and input(substr(diag06, 4, 2), 8.) <40 then bmi = '3';
else if 
d06 in ('Z68') and input(substr(diag06, 4, 2), 8.) >=40 then bmi = '4';

else if 
d07 in ('Z68') and input(substr(diag07, 4, 2), 8.) <20 then bmi = '1';
else if 
d07 in ('Z68') and input(substr(diag07, 4, 2), 8.) <30 then bmi = '2';
else if 
d07 in ('Z68') and input(substr(diag07, 4, 2), 8.) <40 then bmi = '3';
else if 
d07 in ('Z68') and input(substr(diag07, 4, 2), 8.) >=40 then bmi = '4';

else if 
d08 in ('Z68') and input(substr(diag08, 4, 2), 8.) <20 then bmi = '1';
else if 
d08 in ('Z68') and input(substr(diag08, 4, 2), 8.) <30 then bmi = '2';
else if 
d08 in ('Z68') and input(substr(diag08, 4, 2), 8.) <40 then bmi = '3';
else if 
d08 in ('Z68') and input(substr(diag08, 4, 2), 8.) >=40 then bmi = '4';

else if 
d09 in ('Z68') and input(substr(diag09, 4, 2), 8.) <20 then bmi = '1';
else if 
d09 in ('Z68') and input(substr(diag09, 4, 2), 8.) <30 then bmi = '2';
else if 
d09 in ('Z68') and input(substr(diag09, 4, 2), 8.) <40 then bmi = '3';
else if 
d09 in ('Z68') and input(substr(diag09, 4, 2), 8.) >=40 then bmi = '4';


else if 
d10 in ('Z68') and input(substr(diag10, 4, 2), 8.) <20 then bmi = '1';
else if 
d10 in ('Z68') and input(substr(diag10, 4, 2), 8.) <30 then bmi = '2';
else if 
d10 in ('Z68') and input(substr(diag10, 4, 2), 8.) <40 then bmi = '3';
else if 
d10 in ('Z68') and input(substr(diag10, 4, 2), 8.) >=40 then bmi = '4';
else bmi = '9';

run;


%macro logb (iv, dv);

proc logistic data=bmi_02 descending;
class dm (ref='0') bmi bsev gender_val (ref='F') race_val (ref='4')  payer1 Medi (ref='0')/ param=ref;
model &dv = &iv race_val gender_val Medi;
where race_val in (2, 3, 4, 5) 
and &dv not in ('9')
/*and ageinyears >=19*/
/*and DischYear in (2020)*/
;run;

%mend logb;
%logb (bmi, bsev); /* Not sig */
%logb (bmi, pa);  /* Not sig */


data bmi_02; set bmi_01;
 
if d01 in ('Z68') and input(substr(diag01, 4, 2), 8.) <20 then bmi = '1';
else if 
d01 in ('Z68') and input(substr(diag01, 4, 2), 8.) <30 then bmi = '2';
else if 
d01 in ('Z68') and input(substr(diag01, 4, 2), 8.) <40 then bmi = '3';
else if 
d01 in ('Z68') and input(substr(diag01, 4, 2), 8.) >=40 then bmi = '4';


else if 
d02 in ('Z68') and input(substr(diag02, 4, 2), 8.) <20 then bmi = '1';
else if 
d02 in ('Z68') and input(substr(diag02, 4, 2), 8.) <30 then bmi = '2';
else if 
d02 in ('Z68') and input(substr(diag02, 4, 2), 8.) <40 then bmi = '3';
else if 
d02 in ('Z68') and input(substr(diag02, 4, 2), 8.) >=40 then bmi = '4';


else if 
d03 in ('Z68') and input(substr(diag03, 4, 2), 8.) <20 then bmi = '1';
else if 
d03 in ('Z68') and input(substr(diag03, 4, 2), 8.) <30 then bmi = '2';
else if 
d03 in ('Z68') and input(substr(diag03, 4, 2), 8.) <40 then bmi = '3';
else if 
d03 in ('Z68') and input(substr(diag03, 4, 2), 8.) >=40 then bmi = '4';

else if 
d04 in ('Z68') and input(substr(diag04, 4, 2), 8.) <20 then bmi = '1';
else if 
d04 in ('Z68') and input(substr(diag04, 4, 2), 8.) <30 then bmi = '2';
else if 
d04 in ('Z68') and input(substr(diag04, 4, 2), 8.) <40 then bmi = '3';
else if 
d04 in ('Z68') and input(substr(diag04, 4, 2), 8.) >=40 then bmi = '4';

else if 
d05 in ('Z68') and input(substr(diag05, 4, 2), 8.) <20 then bmi = '1';
else if 
d05 in ('Z68') and input(substr(diag05, 4, 2), 8.) <30 then bmi = '2';
else if 
d05 in ('Z68') and input(substr(diag05, 4, 2), 8.) <40 then bmi = '3';
else if 
d05 in ('Z68') and input(substr(diag05, 4, 2), 8.) >=40 then bmi = '4';

else if 
d06 in ('Z68') and input(substr(diag06, 4, 2), 8.) <20 then bmi = '1';
else if 
d06 in ('Z68') and input(substr(diag06, 4, 2), 8.) <30 then bmi = '2';
else if 
d06 in ('Z68') and input(substr(diag06, 4, 2), 8.) <40 then bmi = '3';
else if 
d06 in ('Z68') and input(substr(diag06, 4, 2), 8.) >=40 then bmi = '4';

else if 
d07 in ('Z68') and input(substr(diag07, 4, 2), 8.) <20 then bmi = '1';
else if 
d07 in ('Z68') and input(substr(diag07, 4, 2), 8.) <30 then bmi = '2';
else if 
d07 in ('Z68') and input(substr(diag07, 4, 2), 8.) <40 then bmi = '3';
else if 
d07 in ('Z68') and input(substr(diag07, 4, 2), 8.) >=40 then bmi = '4';

else if 
d08 in ('Z68') and input(substr(diag08, 4, 2), 8.) <20 then bmi = '1';
else if 
d08 in ('Z68') and input(substr(diag08, 4, 2), 8.) <30 then bmi = '2';
else if 
d08 in ('Z68') and input(substr(diag08, 4, 2), 8.) <40 then bmi = '3';
else if 
d08 in ('Z68') and input(substr(diag08, 4, 2), 8.) >=40 then bmi = '4';

else if 
d09 in ('Z68') and input(substr(diag09, 4, 2), 8.) <20 then bmi = '1';
else if 
d09 in ('Z68') and input(substr(diag09, 4, 2), 8.) <30 then bmi = '2';
else if 
d09 in ('Z68') and input(substr(diag09, 4, 2), 8.) <40 then bmi = '3';
else if 
d09 in ('Z68') and input(substr(diag09, 4, 2), 8.) >=40 then bmi = '4';


else if 
d10 in ('Z68') and input(substr(diag10, 4, 2), 8.) <20 then bmi = '1';
else if 
d10 in ('Z68') and input(substr(diag10, 4, 2), 8.) <30 then bmi = '2';
else if 
d10 in ('Z68') and input(substr(diag10, 4, 2), 8.) <40 then bmi = '3';
else if 
d10 in ('Z68') and input(substr(diag10, 4, 2), 8.) >=40 then bmi = '4';
else bmi = '9';

run;




/* 
1. Native or Alaskan
2. Asian or Pacific Islander
3. African Americans
4. White
5. Hispanic
6. Other
*/









data test; set nv1;
where DischYear < 2016 and (d01 in ('493') or d02 in ('493') or d03 in ('493'));
run;

if DischYear < 2016 and (diag01 in ('493') or diag02 in ('493') or diag03 in ('493'));


data test; set ed_2017;
where DischYear >= 2017 and (d01 in ('J45') or d02 in ('J45') or d03 in ('J45'));
run;



data cat_all; set cat_2013-cat_2020;
run;


proc sort data=cat_all out=cat_sort; by PrincipalDiagCat; run;


proc sql; create table cat_avg as select

*,
avg(count)as avg

from cat_sort
group by PrincipalDiagCat;
quit;


proc sort data=cat_avg out=cat_avg2; by descending avg; run;

















%macro ED (year);

/*proc freq data=data.ed_&year; table patstatecode; run;*/
proc freq data=data.ed_&year; table PrincipalDiagCat/ out=Cat_&year; run;

data cat_&year; set cat_&year;
year=&year;
run;

proc rank data=cat_&year descending out=cat_&year;
var count; 
ranks rank;
run;

%mend ED;
%ED (2013);
%ED (2014);
%ED (2015);
%ED (2016);
%ED (2017);
%ED (2018);
%ED (2019);
%ED (2020);


data cat_all; set cat_2013-cat_2020;
run;



data test; set ed_2017; 
d01 = substr(diag01, 1, 3); 
d02 = substr(diag02, 1, 3); 
d03 = substr(diag03, 1, 3); 
/*where d01 in ('493');*/
run;

 
data test2; set test;
where d01 in ('J45') or d02 in ('J45') or d03 in ('J45');
run;


proc freq data=test2; table diag01; where d01 in ('J45'); run;



proc sort data=cat_all out=cat_sort; by PrincipalDiagCat; run;


proc sql; create table cat_avg as select

*,
avg(count)as avg

from cat_sort
group by PrincipalDiagCat;
quit;


proc sort data=cat_avg out=cat_avg2; by descending avg; run;


proc export data= cat_avg
outfile = "C:\Users\kimy89\Dropbox\Research\Asthma_Cormobdities\Out\Cat_avg.xlsx"
     dbms=xlsx replace;
     sheet="Cat_Avg";
run;




data test (keep=Count); set cat_2013-cat_2020;
run;








/*** ED 2013 - Commorbidities ***/


proc freq data=data.ed_2013; table patstatecode; run;
proc freq data=data.ed_2013; table PrincipalDiagCat; run;
/*proc freq data=data.ed_2013; table CHIAID; run;*/


data nv (keep=DischYear DischQuarter ProvID PatZip PatStateCode PatCountyName Race_val AgeInYears Gender_val
PointOfOrigin DischargeStatus TotalCharge Payer1_val Payer1 PrincipalDiagCat_val PrincipalDiagCat Diag01 Diag02 Diag03
Rev01 CPT01 Srv01 Rev02 CPT02 Srv02 Rev03 CPT03 CHIAID); 
set data.ed_2013; 
where patstatecode in ('NV'); run;




data res; set nv; where PrincipalDiagCat in ('08-Diseases of the REspiratory System (460-519)'); run;

data nv1; set nv; 
d01 = substr(diag01, 1, 3); 
d02 = substr(diag02, 1, 3); 
d03 = substr(diag03, 1, 3); 
/*where d01 in ('493');*/
run;
 
data asthma; set nv1;
where d01 in ('493') or d02 in ('493') or d03 in ('493');
run;
