/*******************/
/* SAS Assignment 3*/
/*  Thomas Murphy  */
/*******************/

/* Importing Data */

libname xptfile xport 'G:\My Drive\Spring 2025\Biostatistics II\Datasets\BRFSS\LLCP2023.XPT' access=readonly; 
proc copy inlib=xptfile outlib=work;
run;

data BRFSS2023;
set LLCP2023;
run;

/* Variables */

/* dependent variable = HIVTST7 */

data BRFSS2023;
	set BRFSS2023;
		if HIVTST7 = 1 then testedHIV = "Yes"; /* ever been tested for HIV */
		if HIVTST7 = 2 then testedHIV = "No"; /* never been testsed for HIV */
		if HIVTST7 = 7 then testedHIV = "Missing"; /* missing data/don't know/refused */
		if HIVTST7 = 9 then testedHIV = "Missing";
		if HIVTST7 = . then testedHIV = "Missing";
run;

data BRFSS2023;
	set BRFSS2023;
		if testedHIV = "Missing" then delete;
run;

proc freq data = BRFSS2023;
	table testedHIV;
		title "Ever Tested for HIV";
run;

/* independent variables */
/* var = MARITAL (marital status) */

data BRFSS2023;
	set BRFSS2023;
		if MARITAL = 1 then married = "Yes";
		if MARITAL = 2 then married = "No";
		if MARITAL = 3 then married = "No";
		if MARITAL = 4 then married = "No";
		if MARITAL = 5 then married = "No";
		if MARITAL = 6 then married = "No";
		if MARITAL = 9 then married = "Missing";
		if MARITAL = . then married = "Missing";
run;

data BRFSS2023;
	set BRFSS2023;
		if married = "Missing" then delete;
run;

proc freq data = BRFSS2023;
	table married;
		title "Martital Status";
run;

/* var = SEXVAR (sex of respondent) */

data BRFSS2023;
	set BRFSS2023;
	if SEXVAR = 1 then sex = "Male";
	if SEXVAR = 2 then sex = "Female";
run;

proc freq data = BRFSS2023;
	table sex;
		title "Sex of Respondent";
run;

/* var = GENHLTH (perception of general health) */

data BRFSS2023;
	set BRFSS2023;
		if GENHLTH = 1 then healthPerception = "Good";
		if GENHLTH = 2 then healthPerception = "Good";
		if GENHLTH = 3 then healthPerception = "Good";
		if GENHLTH = 4 then healthPerception = "Fair or Poor";
		if GENHLTH = 5 then healthPerception = "Fair or Poor";
		if GENHLTH = 7 then healthPerception = 9999;
		if GENHLTH = 9 then healthPerception = 9999;
		if GENHLTH = . then healthPerception = 9999;
run;

data BRFSS2023;
	set BRFSS2023;
		if healthPerception = 9999 then delete;
run;

proc freq data = BRFSS2023;
	table healthPerception;
		title "Perception of Health";
run;

/* var = EMPLOY1 (employment status) */

data BRFSS2023;
	set BRFSS2023;
		if EMPLOY1 = 1 then employment = "Yes";
		if EMPLOY1 = 2 then employment = "Yes";
		if EMPLOY1 = 3 then employment = "No";
		if EMPLOY1 = 4 then employment = "No";
		if EMPLOY1 = 5 then employment = "Retired or Non-Workforce";
		if EMPLOY1 = 6 then employment = "Retired or Non-Workforce";
		if EMPLOY1 = 7 then employment = "Retired or Non-Workforce";
		if EMPLOY1 = 8 then employment = "Retired or Non-Workforce";
		if EMPLOY1 = 9 then employment = 9999;
		if EMPLOY1 = . then employment = 9999;
run;

data BRFSS2023;
	set BRFSS2023;
		if employment = 9999 then delete;
run;

proc freq data = BRFSS2023;
	table employment;
		title "Employment Status";
run;



