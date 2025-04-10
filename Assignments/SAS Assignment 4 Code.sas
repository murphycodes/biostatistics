/*******************/
/* SASAssignment 4 */
/*  Thomas Murphy  */
/*******************/

/* Importing Data */

libname xptfile xport 'C:\Users\murphy\OneDrive - University of Tennessee\Spring 2025\Biostatistics II\Datasets\BRFSS 2023\LLCP2023.XPT' access=readonly; 
proc copy inlib=xptfile outlib=work;
run;

data BRFSS2023; set LLCP2023;
run;

/* Variables */

/* dependent variable = HIVTST7 */

data BRFSS2023;
	set BRFSS2023;
		if HIVTST7 = 1 then testedHIV = 1; /* ever been tested for HIV */
		if HIVTST7 = 2 then testedHIV = 0; /* never been testsed for HIV */
		if HIVTST7 = 7 then testedHIV = .; /* missing data/don't know/refused */
		if HIVTST7 = 9 then testedHIV = .;
		if HIVTST7 = . then testedHIV = .;
run;

proc freq data = BRFSS2023;
	table testedHIV;
		title "Ever Tested for HIV";
run;

/* independent variables */

/* var = SEXVAR (sex of respondent) */

data BRFSS2023;
	set BRFSS2023;
	if SEXVAR = 1 then male = 1;
	if SEXVAR = 2 then male = 0;
run;

proc freq data = BRFSS2023;
	table male;
		title "Sex of Respondents";
run;

/* var = RRCLASS3 (race) */

data BRFSS2023; set BRFSS2023;
	if RRCLASS3 = 1 then race = 1; /* non-Hispanic white */
	if RRCLASS3 = 2 then race = 2; /* non-Hispanic black */
	if RRCLASS3 = 3 then race = 3; /* Hispanic or Latino */
	if RRCLASS3 = 4 then race = 4; /* Asian and Pacific Islander */
	if RRCLASS3 = 5 then race = 5; /* non-Hispanic others or mixed race */
	if RRCLASS3 = 6 then race = 5;
	if RRCLASS3 = 7 then race = 5;
	if RRCLASS3 = 8 then race = 5;
	if RRCLASS3 = 77 then race = .; /* missing/refused/don't know */
	if RRCLASS3 = 99 then race = .;
	if RRCLASS3 = . then race = .;
run;

proc freq data = BRFSS2023;
	table race; title "Race and Ethinicity";
run;

/* var = MENTHLTH (bad mental health days) */

data BRFSS2023; set BRFSS2023;
	if MENTHLTH = 88 then mentalHealth = 0; /* good mental health */
	if MENTHLTH in (1:14) then mentalHealth = 1; /* fair mental health */
	if MENTHLTH in (15:30) then mentalHealth = 2; /* bad mental health */
	if MENTHLTH = 77 then mentalHealth = .;
	if MENTHLTH = 99 then mentalHealth = .;
	if MENTHLTH = . then mentalHealth = .;
run;

proc freq data = BRFSS2023;
	table mentalHealth; title "Mental Health Rating";
run;

/* var = SMOKE100 (ever smoked more than five packs in lifetime) */

data BRFSS2023; set BRFSS2023;
	if SMOKE100 = 2 then everSmoked = 0; /* never smoked */
	if SMOKE100 = 1 then everSmoked = 1; /* smoked five packs or more in lifetime */
	if SMOKE100 in (3:9) then everSmoked = .; /* don't know/refused */
	if SMOKE100 = . then everSmoked = .; /* missing data */
run;

proc freq data = BRFSS2023;
	table everSmoked; title "Ever Smoked in Lifetime";
run;

/* var = AVEDRNK3 (average alcohol consumption) */

data BRFSS2023; set BRFSS2023;
	if AVEDRNK3 > 4 and male = 1 then alcoholAbuse = 1; /* heavy user of alcohol, male (as defined by NIAAA) */
	if AVEDRNK3 > 3 and male = 0 then alcoholAbuse = 1; /* heavy user of alcohol, female (as defined by NIAAA) */
	if AVEDRNK3 < 4 and male = 1 then alcoholAbuse = 0; /* not a heavy user of alcohol, male (as defined by NIAAA) */
	if AVEDRNK3 < 3 and male = 0 then alcoholAbuse = 0; /* not a heavy user of alcohol, male (as defined by NIAAA) */
run;

*Heavy alcohol use, according to the National Institute on Alcohol Abuse and Alcoholism (NIAAA), is defined as consuming 5 or more drinks on any day for men, or 4 or more drinks on any day for women, or 15 or more drinks per week for men, and 8 or more drinks per week for women. *;

proc freq data = BRFSS2023;
	table alcoholAbuse; title "Drank Excessively";
run;

proc surveyfreq data = BRFSS2023 varmethod = TAYLOR;
	strata _STSTR;
	cluster _PSU;
	weight _LLCPWT;
	table male race mentalHealth alcoholAbuse everSmoked testedHIV /cl;
run;

/* Creating Cross Table */

proc freq data = BRFSS2023;
	table male * testedHIV / nocol; title "Sex";
	table race * testedHIV / nocol; title "Race";
	table mentalHealth * testedHIV / nocol; title "Mental Health Status";
	table alcoholAbuse * testedHIV / nocol; title "Heavy Alcohol Use";
	table everSmoked * testedHIV / nocol; title "Tobacoo Usage";
run;
