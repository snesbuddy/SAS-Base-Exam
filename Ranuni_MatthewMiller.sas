data temp; /*Creating dataset to show 10 trials of the ranuni function*/
	infile datalines;
	input trial $;
	ranvar=ranuni(0); /*Using 0 as the seed uses the clock time
						as the seed, generating a different number in
						(0,1) each time. If a constant was used, the same
						list would be generated repeatedly*/
datalines;
TryOne
TryTwo
TryThree
TryFour
TryFive
TrySix
TrySeven
TryEight
TryNine
TryTen
;

proc print data=work.temp noobs; /*This displays the values calculated for ranuni*/
	title "Printout of RanVar";
run;

proc sort data=temp out=temp2; /* Here we sort by the value of ranuni displayed*/
	by ranvar;
run;

proc print data=work.temp2 noobs;
	title "Ordering of Random Variables";
run;

proc print data=work.temp2 (obs=3) noobs; /*By keeping only the first 3 observations,
											we create a simple random sample with n=3
											from our population N=10 each execution*/
	title "Ordering of Random Variables";
run;


/*Transformations of Ranuni*/

data transformations;
	infile datalines;
	input trial $;
	ranvar=3*ranuni(0)+2; /*Say you're interested in simulating a uniform
							distribution, but the range is different than
							(0,1). Ranuni may still be used for a range of
							(b,a+b) by modifying the function as such:
							a*ranuni(seed)+b ; in this case, it is (2,5)*/
datalines;
TryOne
TryTwo
TryThree
TryFour
TryFive
TrySix
TrySeven
TryEight
TryNine
TryTen
;

proc print data=work.transformations noobs;
	title "Transformation of RanVar";
run;



/*Randomly Assigning Patients to Study Groups*/

/*Say you wish to randomly assign 30 patients to a study or control group, with equally likely probability
  of each outcome. Ranuni function may be used to select a simple random sample*/

proc format;
	value grpfmt 0='Control' 1='Treatment';
run;


Data trials;
	do PatientID = 1 to 30;
		if ranuni(0) LE .98 Then group = 0; /*by changing p=0.5 here, you can change the probability of "success"
											which, in this case, means selection for the trial drug*/
		else group = 1;
		output;
	end;
run;
proc sort data=work.trials out=work.trials2; /*Sorting Control v Treatment*/
	by Group;
run;

proc print Data = work.trials2; /*Viewing Assignments by Group*/
	by Group;
	title"Patient Assignments";
	format group grpfmt.;
run;


