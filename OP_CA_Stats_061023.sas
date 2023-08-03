
libname data "C:\Users\kimy89\Documents\Data\CHIA\Final_SAS_Files";
libname dir "C:\Users\kimy89\Documents\Data\GI-ED";

/* Get today's date */
%let today = %sysfunc(date(), yymmddn8.);


/* DESCRIPTIVE STATS */


proc freq data=dir.IEDOP_All; tables can opi; 
run;

proc freq data=dir.IEDOP_All; tables can opi; 
where dischyear in (2013, 2014, 2015, 2016) or (dischyear in (2017) and dischquarter in (1,2));
run;

proc freq data=dir.IEDOP_All; tables can opi; 
where dischyear in (2018, 2019, 2020, 2021) or (dischyear in (2017) and dischquarter in (3,4));
run;



proc freq data=dir.IEDOP_All; tables dischyear agegrp race gender_val can opi; 
where opi in ('1');
run;

proc freq data=dir.IEDOP_All; tables dischyear agegrp race gender_val payer1 can opi; 
where opi in ('1') and (dischyear in (2013, 2014, 2015, 2016) or (dischyear in (2017) and dischquarter in (1,2)));
run;

proc freq data=dir.IEDOP_All; tables dischyear agegrp race gender_val payer1 can opi; 
where opi in ('1') and (dischyear in (2018, 2019, 2020, 2021) or (dischyear in (2017) and dischquarter in (3,4)));
run;


/* Calculating avg age */
proc means data=dir.IEDOP_All; var ageinyears; 
run;

proc means data=dir.IEDOP_All; var ageinyears;
where (dischyear in (2013, 2014, 2015, 2016) or (dischyear in (2017) and dischquarter in (1,2)));
run;

proc means data=dir.IEDOP_All; var ageinyears;
where (dischyear in (2018, 2019, 2020, 2021) or (dischyear in (2017) and dischquarter in (3,4)));
run;


proc means data=dir.IEDOP_All; var ageinyears; 
where opi in ('1');
run;

proc means data=dir.IEDOP_All; var ageinyears;
where opi in ('1') and (dischyear in (2013, 2014, 2015, 2016) or (dischyear in (2017) and dischquarter in (1,2)));
run;

proc means data=dir.IEDOP_All; var ageinyears;
where opi in ('1') and (dischyear in (2018, 2019, 2020, 2021) or (dischyear in (2017) and dischquarter in (3,4)));
run;



/* Time-Series */


/* ALL - for OO */

data dir.taggedop;
  set dir.aggedop3; /* Replace 'your_data' with the name of your dataset */
    /* Create a new variable to hold the converted time values */
  format time yymmn6.; /* Define the desired time format */
  time = input(put(tm, 6.), yymmn6.); /* Convert the old_time variable */
 drop tm;
run;

proc sort data=dir.taggedop;
  by time;
run;



/* WITH/WITHOUT MODEL*/


data dir.tagg;
  set dir.agg21; /* Replace 'your_data' with the name of your dataset */
    /* Create a new variable to hold the converted time values */
  format time yymmn6.; /* Define the desired time format */
  time = input(put(tm, 6.), yymmn6.); /* Convert the old_time variable */
 drop tm;
run;

proc sort data=dir.tagg;
  by time;
run;


data dir.agg5;
  set dir.agg4; /* Replace 'your_data' with the name of your dataset */
    /* Create a new variable to hold the converted time values */
  format time yymmn6.; /* Define the desired time format */
  time = input(put(tm, 6.), yymmn6.); /* Convert the old_time variable */
 drop tm;
run;

proc sort data=dir.agg5;
  by time;
run;


/* Plots */

/* ALL */
%macro plotB (var1, var2);
proc sgplot data=dir.taggedop;
  series x=time y=&var1 / markerattrs=(symbol=squarefilled color=red);
  series x=time y=&var2 / markerattrs=(symbol=squarefilled color=red);
run;

%mend (plotB);
%plotB (can, can);
%plotB (opiw, opiw);
%plotB (opiw_r, opiw_r);
%plotB (can, opi);
%plotB (can_r, can_r);
%plotB (opi_r, opi_r);
%plotB (opi_r, opiw_r);


/* WITH/WITHOUT MODEL*/
%macro plotA (var1, var2);
proc sgplot data=dir.tagg;
  series x=time y=&var1 / markerattrs=(symbol=squarefilled color=red);
  series x=time y=&var2 / markerattrs=(symbol=squarefilled color=red);
run;

%mend (plotA);
%plotA (can, can);
%plotA (opi, opi);
%plotA (can, opi);
%plotA (opi, opiw);
%plotA (can_r, can_r);
%plotA (nau_r, nau_r);
%plotA (opi_r, opi_r);
%plotA (opi_r, opiw_r);
%plotA (opiw_r, opiw_r);




/************ Single ITS ***************/

/* ALL */
%macro ITSA(dev);
proc glm data=dir.taggEDOP;
/*model &dev = time rcm1 time*rcm1 ;*/
model &dev = t x t*x ;
/*model &dev = t;*/
output out=output predicted=predicted_values;
run;

proc sgplot data=output;
  scatter x=t y=&dev / markerattrs=(symbol=squarefilled color=red);
  series x=t y=predicted_values / markerattrs=(color=blue);
run;

%mend;
%itsA (opiw); /* Sig. */
%itsA (opiw_r); /* Sig. */



/* WITH/WITHOUT MODEL*/
%macro ITS(dev);
proc glm data=dir.tagg;
/*model &dev = time rcm1 time*rcm1 ;*/
model &dev = t x t*x ;
/*model &dev = t;*/
output out=output predicted=predicted_values;
run;

proc sgplot data=output;
  scatter x=t y=&dev / markerattrs=(symbol=squarefilled color=red);
  series x=t y=predicted_values / markerattrs=(color=blue);
run;

%mend;
%its (opi); /* Sig. */
%its (opi_r); /* Sig. */
%its (opiw_r); /* Sig. */
%its (can); /* Sig. */
%its (can_r); /* Sig. */





/* ARIMA */

/* Intervention significant */

proc arima data=dir.taggedop; /* Best for Opioid (rate) for All */
   identify var=opiw_r(1) stationarity=(adf) crosscorr=rcm;
   estimate p=0 q=(0,2) input=rcm;
run;

proc arima data=dir.taggedop; /* rcm0 - 2016Q4*/
   identify var=opiw_r(1) stationarity=(adf) crosscorr=rcm0;
   estimate p=0 q=(0,2) input=rcm0;
run;

proc arima data=dir.taggedop; /* rcm1 */
   identify var=opiw_r(1) stationarity=(adf) crosscorr=rcm1;
   estimate p=0 q=(0,2) input=rcm1;
run;

proc arima data=dir.taggedop; /* rcm2 - 2016Q2 */
   identify var=opiw_r(1) stationarity=(adf) crosscorr=rcm2;
   estimate p=0 q=(0,2) input=rcm2;
run;

proc arima data=dir.taggedop; /* rcm2 - 2015Q4 */
   identify var=opiw_r(1) stationarity=(adf) crosscorr=rcm3;
   estimate p=0 q=(0,2) input=rcm3;
run;

proc arima data=dir.taggedop; /* rcm4 - 2015Q2 */
   identify var=opiw_r(1) stationarity=(adf) crosscorr=rcm4;
   estimate p=0 q=(0,2) input=rcm4;
run;

proc arima data=dir.taggedop; /* rcm5 - 2018Q2 */
   identify var=opiw_r(1) stationarity=(adf) crosscorr=rcm5;
   estimate p=0 q=(0,2) input=rcm5;
run;


proc arima data=dir.taggedop; /* rcm6 - 2014Q2 */
   identify var=opiw_r(1) stationarity=(adf) crosscorr=rcm6;
   estimate p=0 q=(0,2) input=rcm6;
run;


proc arima data=dir.taggedop; /* rcm7 - 2018Q2 */
   identify var=opiw_r(1) stationarity=(adf) crosscorr=rcm7;
   estimate p=0 q=(0,2) input=rcm7;
run;

/* Controls used - UNEMP, POP, POP_DN, UNINSURED, WHITE, BLACK, HISPANIC, ASIAN
- UNEMP is significant  */


proc arima data=dir.taggedop; /* Best for control variables for All - rcm (2017Q3)*/
   identify var=opiw_r(1) stationarity=(adf) crosscorr=(rcm unemp);
   estimate p=0 q=(0,2) input=(rcm unemp);
   run;

proc arima data=dir.taggedop; /* rcm1 (2018Q1)*/
   identify var=opiw_r(1) stationarity=(adf) crosscorr=(rcm1 unemp);
   estimate p=0 q=(0,2) input=(rcm1 unemp);
   run;

proc arima data=dir.taggedop; 
   identify var=opiw_r(1) stationarity=(adf) crosscorr=(rcm7 unemp);
   estimate p=0 q=(0,2) input=(rcm7 unemp);
   run;

proc arima data=dir.taggedop; /* Best for control - Opioid (count) for All : No control variable significant*/
   identify var=opiw(1) stationarity=(adf) crosscorr=(rcm);
   estimate p=0 q=(0,2) input=(rcm);
run;

proc arima data=dir.taggedop; /* Best for control - Opioid (count) for All : No control variable significant*/
   identify var=opiw(1) stationarity=(adf) crosscorr=(rcm);
   estimate p=0 q=2 input=(rcm);
run;



/* Export for ggplot */
proc export data= dir.taggedop
	outfile = "C:\Users\kimy89\Dropbox\Research\Cannabis_Opioid\data\TS"
	DBMS=xlsx REPLACE;
	sheet="TS";
run;




proc arima data=dir.tagg; /* Best for without cannabis */
   identify var=opiw_r(1) stationarity=(adf) crosscorr=rcm;
   estimate p=0 q=(0,2) input=rcm;
run;


proc arima data=dir.tagg; 
   identify var=opiw_r(1) stationarity=(adf) crosscorr=rcm;
   estimate p=0 q=2 input=rcm;
run;


proc arima data=dir.tagg; 
   identify var=opiw_r(1) stationarity=(adf) crosscorr=rcm;
   estimate p=0 q=1 input=rcm;
run;

proc arima data=dir.tagg; /* best as of 6/30/23 for with cannabis*/
   identify var=opi_r(1) stationarity=(adf) crosscorr=rcm1;
   estimate p=0 q=1 input=rcm1;
run;

proc arima data=dir.tagg;
   identify var=opi_r(1, 12) stationarity=(adf) crosscorr=rcm1;
   estimate p=0 q=(1,3) input=rcm1;
run;


proc arima data=dir.tagg; /* CN as a control -> Not sig. */
   identify var=opi_r(1) stationarity=(adf) crosscorr=(rcm1 can_r);
   estimate p=0 q=1 input=(rcm1 can_r);
run;





/*** DID  6/30/23 ***/
/* Compare OPI with 
proc reg data=dir.cagg;
model opi_r

RCM1
z=1 if 





/* Intervention not significant - Due to small sample (serieis)? */
proc arima data=dir.tagg;
   identify var=nau_r(1, 12) stationary=(adf) crosscorr=rcm1;
   estimate p=0 q=(1,3) input=rcm1;
run;

proc arima data=dir.tagg;
   identify var=nau_r(1) stationary=(adf) crosscorr=rcm1;
   estimate p=0 q=1 input=rcm1;
run;



proc arima data=dir.tagg;
   identify var=nau_r(1, 12) nlag=12;
   estimate p=2 q=2 input=(1 12) noint;
/*   forecast interval=quarter lead=12 out=work.forecast;*/
run;

proc arima data=dir.cagg;
   identify var=t;
   estimate p=1 method=ml;
run;




/* CITS - COMPARATIVE */

data dir.cagg;
  set dir.agg4; /* Replace 'your_data' with the name of your dataset */
    /* Create a new variable to hold the converted time values */
  format time yymmn6.; /* Define the desired time format */
  time = input(put(tm, 6.), yymmn6.); /* Convert the old_time variable */
 drop tm;
run;

proc sort data=dir.cagg;
  by time;
run;

data dir.cagg; set dir.cagg;
rdiff_nau = nauw_r - nau_r;
run;

proc sort data=dir.cagg;
  by time;
run;






/* Step 6: Output the forecasted values */
proc print data=work.forecast;
   title 'ARIMA Forecasted Values';
run;


proc reg data=dir.tagg;
model can = time;
run;

proc glm data=dir.tagg;
model can = time rcm time*rcm;
run;

/* GLM */
%macro glm(dev);
proc glm data=dir.tagg;
model &dev = time ;
/*model &dev = time rcm time*rcm;*/
run;
%mend;
%glm (nau_r); /* Sig. */
%glm (nauw_r); /* Sig. */







proc sort data=dir.tagg by time; run;

%macro ITS(dev);
proc glm data=dir.tagg;
/*model &dev = time rcm1 time*rcm1 ;*/
model &dev = time x time*x ;
/*model &dev = t;*/
output out=output predicted=predicted_values;
run;

proc sgplot data=output;
  scatter x=time y=nau_r / markerattrs=(symbol=squarefilled color=black);
  series x=time y=predicted_values / markerattrs=(color=blue);
run;

%mend;
%its (nau_r); /* Sig. */


proc sgplot data=output;
series x=time y=nau_r;
series x=time y=predicted_values / group=rcm1 ;
run;

/* TO BE CONTINUED
proc reg data=dir.tagg plots=none noprint;
model nau_r=t;
output out=my_data p=predicted1;
run;

proc reg data=dir.tagg plots=none noprint;
model nau_r=t;
output out=my_data p=predicted2;
run;


data mydata; set my_data;
if t<=20 then predicted=.;
run;

/*

proc sgplot data=output;
  scatter x=time y=nau_r / markerattrs=(symbol=squarefilled color=red);
  series x=time y=predicted_values / group=x markerattrs=(color=blue);
run;

proc sgplot data=output;
  series x=time y=predicted_values / markerattrs=(color=blue);
run;



proc sgplot data=output;
  scatter x=t y=nau_r;
  scatter x=t y=predicted_values;
/*/ lineattrs=(symbol=squarefilled color=blue));*/
run;

proc sgplot data=output;
  scatter x=t y=nau_r / markerattrs=(symbol=squarefilled color=red);
  scatter x=t y=predicted_values;
/*/ lineattrs=(symbol=squarefilled color=blue));*/
run;


proc sgplot data=output;
  scatter x=t y=nau_r / markerattrs=(symbol=squarefilled color=red);
  series x=t y=predicted_values/ lineattrs=(color=blue thickness=4);;
run;



proc arima data=dir.tagg;
   identify var=nau_r stationary=(adf);
run;

/* Stationary and White noise*/
proc arima data=dir.tagg;
   identify var=nau_r(1, 12) stationary=(adf);
   estimate p=0 q=(1,3) method=ml;
run;



/* ITS - ARIMA */
/* Intervention not significant - Due to small sample (serieis)? */
proc arima data=dir.tagg;
   identify var=nau_r(1, 12) stationary=(adf) crosscorr=rcm1;
   estimate p=0 q=(1,3) input=rcm1;
run;

proc arima data=dir.tagg;
   identify var=nau_r(1) stationary=(adf) crosscorr=rcm1;
   estimate p=0 q=1 input=rcm1;
run;



proc arima data=dir.tagg;
   identify var=nau_r(1, 12) nlag=12;
   estimate p=2 q=2 input=(1 12) noint;
/*   forecast interval=quarter lead=12 out=work.forecast;*/
run;

proc arima data=dir.cagg;
   identify var=t;
   estimate p=1 method=ml;
run;



proc arima data=dir.cagg;
   identify var=nau_r;
run;


proc arima data=dir.cagg;
   identify var=nau_r stationary=(adf);
   estimate p=1 q=1 method=ml;
run;


proc arima data=dir.tagg;
   identify var=can (0,0) nlag=12;
   estimate p=1 q=1;
/*   forecast interval=quarter lead=12 out=work.forecast;*/
run;

proc arima data=dir.tagg;
   identify var=nau_r (0,0) nlag=12;
   estimate p=1 q=1;
/*   forecast interval=quarter lead=12 out=work.forecast;*/
run;



/* Comparative ITS */
%macro CITS(dev);
proc glm data=dir.cagg;
model &dev = t x*t z z*t z*x z*x*t  ;
/*model &dev = t x x*t z z*t z*x z*x*t  ;*/
run;
%mend;
%Cits (nau_r); /* Sig. */





ods graphics on;

proc sgplot data=dir.tagg;
  series x=time y=can / markerattrs=(symbol=circlefilled color=blue);
  series x=time y=nau / markerattrs=(symbol=squarefilled color=red);
  series x=time y=nic / markerattrs=(symbol=squarefilled color=red);
  series x=time y=opi / markerattrs=(symbol=squarefilled color=red);
  series x=time y=sed / markerattrs=(symbol=squarefilled color=red);
  series x=time y=coc / markerattrs=(symbol=squarefilled color=red);
  series x=time y=sho / markerattrs=(symbol=squarefilled color=red);
run;


proc sgplot data=dir.tagg;
  series x=time y=can_r / markerattrs=(symbol=circlefilled color=blue);
run;


%macro plot (var1, var2);
proc sgplot data=dir.tagg;
  series x=time y=&var1 / markerattrs=(symbol=squarefilled color=red);
  series x=time y=&var2 / markerattrs=(symbol=squarefilled color=red);
run;

%mend (plot);
%plot (nau_r, nau_r); /**/
%plot (can, can);
%plot (nic, nicw);
%plot (nic, nic);
%plot (nau, nauw); /**/
%plot (nau, nau);  /**/
%plot (nauw, nauw);
%plot (alc, alcw);
%plot (alc, alc);
%plot (opi, opiw);
%plot (opi, opi);
%plot (sed, sedw);
%plot (coc, cocw);
%plot (sho, show);
%plot (denom, denom);
%plot (can_r, can_r);
%plot (nic_r, nicw_r);
%plot (nau_r, nauw_r); /**/
%plot (nau_r, nau_r); /**/
%plot (nauw_r, nauw_r); /**/
%plot (alc_r, alcw_r);
%plot (opi_r, opiw_r);
%plot (opi_r, opi_r);
%plot (opiw_r, opiw_r);
%plot (sed_r, sedw_r);
%plot (coc_r, cocw_r);
%plot (sho_r, show_r);
%plot (rdiff_nau, rdiff_nau);


data today(); set dir.ind_all;
where can in ('0');
run;



proc export data= dir.tagg
	outfile = "C:\Users\kimy89\Dropbox\Research\GI-ED\data\data_&today..xlsx"
	DBMS=xlsx REPLACE;
/*	sheet="&today.";*/
run;



/* Back-up */
data dir.tagg2; set dir.tagg; run;
data dir.cagg2; set dir.cagg; run;




proc sgplot data=dir.tagg;
/*  series x=time y=denom / markerattrs=(symbol=circlefilled color=blue);*/
  series x=time y=can / markerattrs=(symbol=circlefilled color=blue);
run;





proc varmax data=have plots=(model residual); 
  ods output ParameterEstimates=arma_est;
  id date interval=month;
  model sales = price income / p=1 q=2 dify(1);* difx(1);
  output out=out lead=0; 
run;




/*** Descriptive Stats ***/

ods listing close;
ods pdf file="GI-ED.txt";
/* Your SAS code producing the output */


ods pdf file="d:\reg1.pdf";

proc freq data=dir.ind_all; tables race gender_val CAN NAU; run;
proc means data=dir.ind_all; var ageinyears; run;

proc freq data=dir.ind_all; tables race gender_val CAN; where NAU in ('0'); run;
proc means data=dir.ind_all; var ageinyears;  where NAU in ('0'); run;

ods pdf close;



ods pdf close;
ods listing;
