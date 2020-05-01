/*Problem 19-7*/

title "PROC UNIVARIATE Stats for Height and Weight";
proc univariate data=sashelp.heart;
	var Height Weight;
	histogram;
run;


/*Problem 20-5*/

title "Summary Data from SASHELP Heart Data Set";
proc freq data=sashelp.heart(where=(Weight_Status ne 'Underweight'));
	tables sex*Weight_Status*Status / chisq;
run;
