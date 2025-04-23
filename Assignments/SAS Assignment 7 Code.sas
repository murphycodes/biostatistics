/* SAS Assignment 7 */

libname assign 'C:\Users\murphy\OneDrive - University of Tennessee\Spring 2025\PUBH 531 - Biostatistics II\Assignments\Assignment 7';
data assignData; set assign.SAS_assignment7_interaction; run;

data assignData; set assignData;
	if binge = . | male = . | race_eth = . | grade = . | sad = . | c_evp = . then delete;
run;

proc freq data = assignData;
	table binge male race_eth grade sad c_evp;
run;

proc reg data = assignData;
	model binge = sad male race_eth grade c_evp  / clb stb ;
run;

ods graphics on;
proc corr data = assignData plots = matrix(histogram);
run;

/* Q1 */

proc freq data = assignData;
	table sad * binge / relrisk nocol;
run;

/* Q2 */

proc surveylogistic data = assignData nomcar varmethod = TAYLOR; 
	class male (ref = "1") race_eth (ref = "0") grade (ref = "9") sad (ref = "0") c_evp (ref = "0") / param = ref;
	strata _stratum;
	cluster _PSU;
	weight p_weight;
	model binge (event = "1") = sad male race_eth grade c_evp;
run;

/* Q4 */

proc surveylogistic data = assignData nomcar varmethod = TAYLOR; 
	class male (ref = "1") race_eth (ref = "0") grade (ref = "9") sad (ref = "0") c_evp (ref = "0") / param = ref;
	strata _stratum;
	cluster _PSU;
	weight p_weight;
	model binge (event = "1") = sad male race_eth grade;
	where c_evp = 0;
run;
