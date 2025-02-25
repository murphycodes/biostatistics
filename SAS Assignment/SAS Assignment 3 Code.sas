/*******************/
/* SAS Assignment 3*/
/*  Thomas Murphy  */
/*******************/

/* Importing Data */

libname xptfile xport 'G:\My Drive\Spring 2025\Biostatistics II\Datasets\BRFSS\LLCP2023.XPT' access=readonly; 
proc copy inlib=xptfile outlib=work;
run;

/* Question 1 */

