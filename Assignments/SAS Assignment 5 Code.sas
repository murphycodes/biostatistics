/* SAS Assignment 5 */
/*  Thomas Murphy  */

libname assign 'C:\Users\murphy\OneDrive - University of Tennessee\Spring 2025\Biostatistics II\Assignments\Assignment 5'; run;
data assignData; set assign.SAS_assignment5_logistic; run;

/* Cleaning data for var mh_nogood */

data assignData; set assignData;
	if mh_nogood = 0 then mentalHealth = 0; /* good mental health */
	if mh_nogood in (1:15) then mentalHealth = 1; /* fair mental health */
	if mh_nogood in (16:30) then mentalHealth = 2; /* bad mental health */
run;

/* Q1 */

proc freq data = assignData;
	table c_smoking male race_eth mh_nogood;
run;

/* Q2 */

data assignData; set assignData;
	if c_smoking = . then delete;
	if male = . then delete;
	if race_eth = . then delete;
	if mh_nogood = . then delete;
run;

/* Q3-Q5 */

proc surveylogistic data = assignData nomcar varmethod = TAYLOR; 
	class male (ref = "0") race_eth (ref = "0") mentalHealth (ref = "0") / param=ref;
	STRATA STRATA_VARIABLE;
	CLUSTER CLUSTER_VARIABLE;
	WEIGHT PERSONAL_WEIGHT;
	model c_smoking (event = "1") = male race_eth mentalHealth;
run;
