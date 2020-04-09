-- Zainab Sherani
-- Date Completed: 04-09-20
-- Purpose: End of Chapter Practice Problems 	

-- Q1
use ap;
select invoice_total, round(invoice_total, 1), round(invoice_total)
from invoices;

-- Q2
use ex;
select start_date, date_format(start_date, "%b/%d/%y"), date_format(start_date, "%c/%e/%y"), 
	date_format(start_date, "%r"), date_format(start_date, "%c/%d/%y %r")
from date_sample;

-- Q3 and Q4 are easy, they can easily be done by looking over the textbook

