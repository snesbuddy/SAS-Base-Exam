/* Problem 10-1 */


proc format;
	value Gender 1='Male' 2='Female';
	value $Ques '1'='Strongly Disagree'
				'2'='Disagree'
				'3'='No Opinion'
				'4'='Agree'
				'5'='Strongly Agree';
	value AgeGrp 0-20='Young'
				 21-40='Still Young'
				 41-60='Middle'
				 61-high='Older';
run;

data Questionnaire;
	informat Gender 1. Q1-Q4 $1. Visit date 9.;
		input Gender Q1-Q4 Visit Age;
		format Gender gender. Q1-Q4 $Ques. Visit mmddyy10. Age AgeGrp.;
datalines;
1 3 4 1 2 29May2015 16
1 5 5 4 3 01Sep2015 25
2 2 2 1 3 04Jul2014 45
2 3 3 3 4 07Feb2015 65
;
title "Listing of Data Set QUESTIONNAIRE";
proc print data=Questionnaire noobs;
	title "Question 10-1";
run;


/* Problem 10-2 */


proc format;
	value Agerange 0-20='Group 1'
				   21-40='Group 2'
				   41-60='Group 3'
				   61-80='Group 4'
				   81-high='Group 5';
run;

proc print data=Questionnaire noobs;
	title "Question 10-2";
	var Gender Q1-Q4 Visit Age;
	format Gender gender. Q1-Q4 $Ques. Visit mmddyy10. Age Agerange.;
run;
