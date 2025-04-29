/********************************************/
/************* Biostatistics II *************/
/**************** Spring 2025 ***************/
/******* SAS Exercise-Model Fit Test ********/
/********************************************/

*Download data and create a SAS library;

Libname ABC "C:\Users\murphy\OneDrive - University of Tennessee\Spring 2025\PUBH 531 - Biostatistics II\SAS Lab\Lab 10 - Model Fit Test";

data model_fit; set ABC.model_fit;
run;

*Sex;
data model_fit; set model_fit; 
	if _SEX = 1 then male = 1;
	if _SEX = 2 then male = 0;
run;
*1: male, 0: female;

*RACEETH --> race_eth;
data model_fit;  
set model_fit; 
if _imprace = 1 then race_eth = 0;
if _imprace = 2 then race_eth = 1;
if _imprace = 3 then race_eth = 3;
if _imprace = 4 then race_eth = 3;
if _imprace = 5 then race_eth = 2;
if _imprace = 6 then race_eth = 3;
run;
*0: NH-White, 1: NH-Black, 2: Hispanic, 3: NH-Others;

*Current smoking;
data model_fit;  
set model_fit;  
if _SMOKER3 = 1 then c_smoking = 1;
if _SMOKER3 = 2 then c_smoking = 1;
if _SMOKER3 = 3 then c_smoking = 0;
if _SMOKER3 = 4 then c_smoking = 0;
if _SMOKER3 = 9 then c_smoking = .;
run;
*1: current (every day or some days) smoker, 0: no current smoker (never/former smoker);

*Current E-cigarette use;
data model_fit;  
set model_fit;  
if ECIGNOW2 = 1 then c_ecig = 0; *Never used;
if ECIGNOW2 = 2 then c_ecig = 1; *Every day;
if ECIGNOW2 = 3 then c_ecig = 1; *Some days;
if ECIGNOW2 = 4 then c_ecig = 0; *Former;
if ECIGNOW2 = 7 then c_ecig = .; *missing;
if ECIGNOW2 = 9 then c_ecig = .; *missing;
if ECIGNOW2 = . then c_ecig = .; *missing;
run;

*Physical health is not good;
data model_fit;  
set model_fit; 
if PHYSHLTH in (1:30) then ph_nogood = PHYSHLTH; *1-30 days physical health is not good;
if PHYSHLTH =  88     then ph_nogood = 0;        *88 --> 0 days;
if PHYSHLTH =  77     then ph_nogood = .;        *88 --> 0 days;
if PHYSHLTH =  99     then ph_nogood = .;        *88 --> 0 days;
if PHYSHLTH =  .      then ph_nogood = .;        *88 --> 0 days;
run;

*Mental health is not good;
data model_fit;  
set model_fit; 
if MENTHLTH in (1:30) then mh_nogood = MENTHLTH; *1-30 days mental health is not good;
if MENTHLTH =  88     then mh_nogood = 0;        *88 --> 0 days;
if MENTHLTH =  77     then mh_nogood = .;        *77 --> 0 days;
if MENTHLTH =  99     then mh_nogood = .;        *99 --> 0 days;
if MENTHLTH =  .      then mh_nogood = .;        *.  --> 0 days;
run; 

data model_fit;  
set model_fit; 
if _BMI5CAT = 1 then bmi_c = 0; *under-weight;
if _BMI5CAT = 2 then bmi_c = 0; *normal weight;
if _BMI5CAT = 3 then bmi_c = 1; *over-weight;
if _BMI5CAT = 4 then bmi_c = 2; *obese;
if _BMI5CAT = . then bmi_c = .; *missing;
run;

data model_fit;
set model_fit;
if ph_nogood = . | mh_nogood = . | bmi_c = . | male = . | race_eth = . then delete;
run;

data model_fit;
set model_fit;
if c_smoking = . and c_ecig = . then delete;
run;

proc freq data=model_fit;
tables male race_eth _BMI5CAT bmi_c ph_nogood mh_nogood c_smoking c_ecig;
run;

/*Exercise: Compare logistic regression models 
to find out the best fitted model */

*Dependent variable: Cigarette smoking;
*Independent variable: Mental Health, Physical Health, Race/ethnicity, Obese category, and Sex;

*Model-1: only "Mental Health";
proc logistic data=model_fit; 
model c_smoking (event = "1")= mh_nogood;
RUN;

*Model-2: only "Physical Health";
proc logistic data=model_fit; 
model c_smoking (event = "1")= ph_nogood;
RUN;

* Q1) Model-1 vs. Model-2 ?;
* Model 1 is better as AIC and SI is smaller for Model 1;
* Non-nested model - compare AIC and SI

*Model-3: Model-1 + "Physical Health";
proc logistic data=model_fit; 
model c_smoking (event = "1")= mh_nogood ph_nogood ;
RUN;

* Q2) Winner of Q1) vs. Model 3 ?
* Model 3, as reduce model has significantly different result, therefore
* full model is better.;

*Model-4: Model-3 + "Race/ethnicity";
proc logistic data=model_fit; 
class  race_eth (ref = "0") /param=ref;
model c_smoking (event = "1")= mh_nogood ph_nogood race_eth;
RUN;

* Q3) Winner of Q2) vs. Model 4 ?
* p = 0.07, cannot reject null that reduced model fits better;
* use model 3 instead of model 4;

*Model-5: Model-3 + "BMI category";
proc logistic data=model_fit; 
class  bmi_c (ref = "0") /param=ref;
model c_smoking (event = "1")= mh_nogood ph_nogood bmi_c;
RUN;

* Q4) Winner of Q3) vs. Model 5 ?
* p < 0.001, reject null that reduced model fits better;
* use model 5 instead of model 3;

*Model-6: Model-5 + "Race/ethnicity";
proc logistic data=model_fit; 
class  bmi_c (ref = "0") race_eth (ref = "0") /param=ref;
model c_smoking (event = "1")= mh_nogood ph_nogood bmi_c race_eth;
RUN;

* Q5) Winner of Q4) vs. Model 6 ?
* p = 0.093, cannot reject null;
* Model 5 is better compared to model 6;

*Model-7: Model-5 + "Race/ethnicity" + "Sex";
proc logistic data=model_fit; 
class  bmi_c (ref = "0") race_eth (ref = "0") /param=ref;
model c_smoking (event = "1")= mh_nogood ph_nogood bmi_c race_eth male;
RUN;

* Q6) Winner of Q5) vs. Model 5 ?
* p = 0.063, cannot reject null;
* Model 5 is better fit compared to model 7
