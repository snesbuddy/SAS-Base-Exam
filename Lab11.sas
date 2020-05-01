/*Problem 1*/

proc sort data=orion.employee_donations out=donations nodupkey;
	by Employee_ID;
run;

proc print data=work.donations; run;

/*Problem 2*/

proc sort data=work.donations;
	by Paid_by;
run;

proc print data=work.donations; run;

/*Problem 3*/

data firstqtr(label="a subset of employee_donations");
set Orion.Employee_donations;
format Qtr1 Dollar4.0;
if Qtr1 > 0 ; run;

proc print data=work.firstqtr; run;

/*Problem 4*/

proc means data=firstqtr n mean; run;

/*Problem 5*/

proc univariate data=work.firstqtr;
	var Qtr1;
run;

/*Problem 6 and 7*/

Proc Print data=firstqtr(where=(Employee_ID = 120660)); run;

/*Problem 8 and 9*/

proc freq data=work.firstqtr; run;


/*Problem 10*/

data charity_perQtr;
set orion.employee_donations;
array EmpContrib{*} Qtr:;
 array CompanyMatch{4} Match1-Match4;
 do i=1 to 4;
 if EmpContrib{i}= . then EmpContrib{i}=0;
 CompanyMatch{i}= EmpContrib{i}*0.50;
 end;
run;

proc print data=work.charity_perqtr; run;

/*Problem 11*/

Array EmpContrib{4} Qtr1-Qtr4;
data charityperQtr;
set orion.employee_donations;
Array EmpContrib{4} Qtr1-Qtr4;
 array CompanyMatch{4} Match1-Match4;
 do i=1 to 4;
 if EmpContrib{i}= . then EmpContrib{i}=0;
 CompanyMatch{i}= EmpContrib{i}*0.50;
 end;
run;

Proc compare base=charityperQtr compare=charity_perQtr;

/*Problem 12*/

Data charity(Label="adding up the quarterly donations to get yearly totals");
 set charity_perQTR;
 array EmpContrib{4} Qtr1 Qtr2 Qtr3 Qtr4;
 CompanyDonation = Match1 + Match2 + match3 + Match4;
 AnnualEmp= sum(of EmpContrib{*});
 Annualtotal=CompanyDonation + AnnualEmp; run;

 proc print data=work.charity; run;

 /*Problem 13*/

 Proc Means data=Charity sum;
Var Annualtotal;
Run;

/*Problems 14, 15 and 16*/

Data charity
 (Label="adding up the quarterly donations to get yearly totals");
 set charity_perQTR;
 array EmpContrib{1} Qtr4;
 CompanyDonation = Match4;
 AnnualEmp= sum(of EmpContrib{*});
 Annualtotal=CompanyDonation + AnnualEmp; run;

 proc print data=work.charity; run;

 Proc Means data=Charity sum;
Var Annualtotal;
Run;
