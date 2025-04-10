/* SAS Assignment 6 */
/*  Thomas Murphy  */

/* Merging Datasets */

libname assign 'C:\Users\murphy\OneDrive - University of Tennessee\Spring 2025\Biostatistics II\Assignments\Assignment 6'; run;
data yearOne; set assign.year1; run;
data yearTwo; set assign.year2; run;
data yearThree; set assign.year3; run;

data combinedData; set yearOne yearTwo yearThree; run;

proc freq data = combinedData;
	table c_smoking male race_eth dep child_house survey;
run;

/* Q1 */

proc surveyfreq data = combinedData;
	cluster _PSU;
	strata _STSTR;
	weight _WEIGHT;
	table survey * c_smoking / chisq cl row;
run;
