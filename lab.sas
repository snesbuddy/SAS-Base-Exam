proc sort data=orion.customer out=work.customer;
	by country;
run;

data allcustomer;
	merge work.customer
		  orion.lookup_country;
	by country;
