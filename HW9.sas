/*Problem 16-1*/

data Clinic;
	informat Date mmddyy10. Subj $3.;
	input Subj Date Heart_Rate Weight;
	format Date date9.;
datalines;
001 10/1/2015 68 150
003 6/25/2015 75 185
001 6/25/2015 66 148
001 11/5/2015 72 152
002 1/1/2014 75 120
003 4/25/2015 80 200
003 5/25/2015 78 190
003 8/20/2015 70 179
;

proc sort data = Clinic;
	by Subj Date;
run;

data Diff;
	set work.clinic;
	by Subj;
	if first.Subj and last.Subj then delete;
	Diff_HR = Heart_Rate - lag(Heart_Rate);
	Diff_Weight = dif(Weight);
	if not first.Subj then output;
run;
title "Listing of Data Set Clinic";
proc print data=Diff noobs;
run;

/*Problem 16-2*/

proc sort data=Clinic;
by Subj Date;
run;

data Prob2;
set Clinic;
by Subj;
retain First_Heart_Rate First_Weight;
if first.Subj and last.Subj then delete;

if first.Subj then 
    do;
        N_Visits = 0;
        First_Heart_Rate = Heart_Rate;
        First_Weight = Weight;
    end;

N_Visits + 1;

if last.Subj then do;
        Diff_Heart_Rate = Heart_Rate - First_Heart_Rate;
        Diff_Weight = Weight - First_Weight;
        output;
        end;
run;

proc print data=work.prob2;
run;


/*Problem 16-3*/

data predictions;
	input Obs LastX;
datalines;
1 0
2 6
3 0
4 7
5 10
;

proc print data=work.predictions noobs;
run;
