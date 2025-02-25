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
		if HIVTST7 = 1 then binTestedHIV = 1; /* ever been tested for HIV */
		if HIVTST7 = 2 then binTestedHIV = 0; /* never been testsed for HIV */
		if HIVTST7 = 7 then binTestedHIV = .; /* missing data/don't know/refused */
		if HIVTST7 = 9 then binTestedHIV = .;
		if HIVTST7 = . then binTestedHIV = .;
run;

data BRFSS2023;
	set BRFSS2023;
		if testedHIV = "Missing" then delete;
run;

data BRFSS2023;
	set BRFSS2023;
		if binTestedHIV = . then delete;
run;

proc freq data = BRFSS2023;
	table testedHIV;
		title "Ever Tested for HIV";
run;

proc freq data = BRFSS2023;
	table binTestedHIV;
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

