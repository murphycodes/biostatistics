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

proc freq data = BRFSS2023;
	table testedHIV;
		title "Ever Tested for HIV";
		title2 "BRFSS2023";
run;



