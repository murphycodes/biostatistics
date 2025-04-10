/*******************/
/* SAS Assignment 3*/
/*  Thomas Murphy  */
/*******************/

/* Importing Data */

libname xptfile xport 'G:\My Drive\Spring 2025\Biostatistics II\Datasets\BRFSS\LLCP2023.XPT' access=readonly; 
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

data BRFSS2023;
	set BRFSS2023;
		if testedHIV = . then delete;
run;

proc freq data = BRFSS2023;
	table testedHIV;
		title "Ever Tested for HIV";
run;

/* independent variables */
/* var = MARITAL (marital status) */

data BRFSS2023;
	set BRFSS2023;
		if MARITAL = 1 then married = 1;
		if MARITAL = 2 then married = 0;
		if MARITAL = 3 then married = 0;
		if MARITAL = 4 then married = 0;
		if MARITAL = 5 then married = 0;
		if MARITAL = 6 then married = 0;
		if MARITAL = 9 then married = .;
		if MARITAL = . then married = .;
run;

data BRFSS2023;
	set BRFSS2023;
		if married = . then delete;
run;

proc freq data = BRFSS2023;
	table married;
		title "Martital Status";
run;

/* var = SEXVAR (sex of respondent) */

data BRFSS2023;
	set BRFSS2023;
	if SEXVAR = 1 then male = 1;
	if SEXVAR = 2 then male = 0;
run;

proc freq data = BRFSS2023;
	table male;
		title "Sex of Respondent";
run;

/* var = GENHLTH (perception of general health) */

data BRFSS2023;
	set BRFSS2023;
		if GENHLTH = 1 then healthPerception = 1; /* good health */
		if GENHLTH = 2 then healthPerception = 1;
		if GENHLTH = 3 then healthPerception = 1;
		if GENHLTH = 4 then healthPerception = 0; /* fair or poor health */
		if GENHLTH = 5 then healthPerception = 0;
		if GENHLTH = 7 then healthPerception = .;
		if GENHLTH = 9 then healthPerception = .;
		if GENHLTH = . then healthPerception = .;
run;

data BRFSS2023;
	set BRFSS2023;
		if healthPerception = . then delete;
run;

proc freq data = BRFSS2023;
	table healthPerception;
		title "Perception of Health";
run;

/* var = EMPLOY1 (employment status) */

data BRFSS2023;
	set BRFSS2023;
		if EMPLOY1 = 1 then employment = 1; /* employed */
		if EMPLOY1 = 2 then employment = 1;
		if EMPLOY1 = 3 then employment = 0; /* not employed */
		if EMPLOY1 = 4 then employment = 0;
		if EMPLOY1 = 5 then employment = 2; /* not in workforce */
		if EMPLOY1 = 6 then employment = 2; /* missing */
		if EMPLOY1 = 7 then employment = 2;
		if EMPLOY1 = 8 then employment = 2;
		if EMPLOY1 = 9 then employment = .;
		if EMPLOY1 = . then employment = .;
run;

data BRFSS2023;
	set BRFSS2023;
		if employment = . then delete;
run;

proc freq data = BRFSS2023;
	table employment;
		title "Employment Status";
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

data BRFSS2023; set BRFSS2023;
	if race = . then delete;
run;

proc freq data = BRFSS2023;
	table race; title "Race and Ethinicity";
run;

/* main independent variable */

data BRFSS2023; set BRFSS2023;
	if PRIMINS1 = 1 then govtInsured = 0; /* privately insured */
	if PRIMINS1 = 2 then govtInsured = 0;
	if PRIMINS1 = 3 then govtInsured = 1; /* insured through govt */
	if PRIMINS1 = 4 then govtInsured = 1;
	if PRIMINS1 = 5 then govtInsured = 1;
	if PRIMINS1 = 6 then govtInsured = 1;
	if PRIMINS1 = 7 then govtInsured = 1;
	if PRIMINS1 = 8 then govtInsured = 1;
	if PRIMINS1 = 9 then govtInsured = 1;
	if PRIMINS1 = 10 then govtInsured = 1;
	if PRIMINS1 = 88 then govtInsured = .;
	if PRIMINS1 = 77 then govtInsured = .;
	if PRIMINS1 = 99 then govtInsured = .;
run;

data BRFSS2023; set BRFSS2023;
	if govtInsured = . then delete;
run;

proc freq data = BRFSS2023;
	table govtInsured; title "Insured by Govt. Program";
run;

/* Creating Cross Table */

proc freq data = BRFSS2023;
	table male * testedHIV / nocol;
		title " Sex x Tested for HIV";
run;

proc freq data = BRFSS2023;
	table employment * testedHIV / nocol;
		title " Employment Status x Tested for HIV";
run;

proc freq data = BRFSS2023;
	table race * testedHIV / nocol;
		title " Race x Tested for HIV";
run;

proc freq data = BRFSS2023;
	table married * testedHIV / nocol;
		title "Martial Status x Tested for HIV";
run;

proc freq data = BRFSS2023;
	table healthPerception * testedHIV / nocol;
		title "Perception of Health x Tested for HIV";
run;

proc freq data = BRFSS2023;
	table govtInsured * testedHIV / nocol;
		title "Insured by Govt. Program x Tested for HIV";
run;
