/* SAS Assignment 5 */
/*  Thomas Murphy  */

libname assign 'C:\Users\murphy\OneDrive - University of Tennessee\Spring 2025\Biostatistics II\Assignments\Assignment 5'; run;
data data; set assign.SAS_assignment5_logistic; run;

/* Q1 */

data data; set data;
	table data;
run;
