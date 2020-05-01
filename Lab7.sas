/*Lab problem 1*/

data increase;
	set orion.staff;
	Increase=Salary*0.10;
	NewSalary=sum(Salary,Increase);
	BdayQtr=qtr(Birth_Date);
	keep Employee_ID Birth_Date Salary Increase NewSalary BdayQtr;
	format Salary Increase NewSalary comma8.;
run;

proc print data=increase label;
run;


/*Lab Problem 3*/

data work.region;
	set orion.supplier;
	length Region $ 17;
	if Country in ('CA','US') then do;
		Discount=0.10;
		DiscountType='Required';
		Region='North America';
	end;
	else do;
		Discount=0.05;
		DiscountType='Optional';
		Region='Not North America';
	end;
	keep Supplier_Name Country Discount DiscountType Region;
run;


proc sort data=work.region;
	by Country;
run;

proc print data=work.region;
run;


/*Lab Problem 4*/

data work.season;
	set orion.customer_dim;
	length Promo2 $ 6;
	Quarter=qtr(Customer_BirthDate);
	if Quarter=1 then Promo='Winter';
	else if Quarter=2 then Promo='Spring';
	else if Quarter=3 then Promo='Summer';
	else if Quarter=4 then Promo='Fall';
	if Customer_Age>=18 and Customer_Age<=25 then Promo2='YA';
	else if Customer_Age>=65 then Promo2='Senior';
	keep Customer_FirstName Customer_LastName Customer_BirthDate Promo Customer_Age Promo2;
run;

proc print data=work.season;
	var Customer_FirstName Customer_LastName Customer_BirthDate Promo Customer_Age Promo2;
run;


proc print data=work.season;
	where Promo2='Senior';
	var Customer_FirstName Customer_LastName Customer_BirthDate Promo Customer_Age Promo2;
run;


/*Lab Problem 5*/

data work.ordertype;
	set orion.orders;
	length Type $ 13 SaleAds $ 5;
	DayOfWeek=weekday (Order_Date);
	if Order_Type=1 then
		Type='Retail Sale';
	else if Order_Type=2 then do;
		Type='Catalog Sale';
		SaleAds='Mail';
	end;
	else if Order_Type=3 then do;
		Type='Internet Sale';
		SaleAds='Email';
	end;
	drop Order_Type Employee_ID Customer_ID;
run;


proc sort data=work.ordertype;
	by SaleAds;
run;

proc print data=work.ordertype;
run;

ods pdf file = "\\Client\E$\Lab7Question10.pdf" startpage=no;

goptions reset=all;

proc print data=work.ordertype;
run;

Quit;run;

ods pdf close;
