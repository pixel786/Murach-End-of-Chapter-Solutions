-- Zainab Sherani
-- Date Completed: 03-25-20
-- Purpose: End of Chapter Practice Problems 

-- Q6
-- return three columns from the Vendors table
-- and sort the result by vendor's last name and then vendor's first name (both should be ascending order)
select vendor_name, vendor_contact_last_name, vendor_contact_first_name
from vendors
order by vendor_contact_last_name, vendor_contact_first_name;

-- Q7
-- return the vendor's first and last name as ('Doe, John') and rename column as full_name
-- return contacts whose names last name begins with the letter A, B, C, or E
select concat(vendor_contact_last_name, ', ', vendor_contact_first_name) as full_name
from vendors
where (left(vendor_contact_last_name, 1) < 'D') OR (left(vendor_contact_last_name, 1) = 'E')
order by vendor_contact_last_name, vendor_contact_first_name;

-- Q8
-- return invoice_due_date as 'Due Date', invoice_total as 'Invoice Total', 
-- and a column that calculates .1 of invoice_total, 
-- and another column that calculates the value of invoice_total plus 10%
-- return rows with an invoice total >= 500 and <= 1000 
-- sort by invoice_due_date in descending order 
select invoice_due_date as "Due Date", invoice_total as "Invoice Total", 
	invoice_total * .1, (invoice_total * .1) + invoice_total
from invoices
where invoice_total between 500 and 1000
order by invoice_due_date;

-- Q9
-- return invoice_number, invoice_total, sum of payment_total and credit_total as payment_credit_total
-- and (invoice_total - payment_total - credit_total) as balance_due 
-- where balance_due > 50 and order by balance_due in descending order
-- only include 5 results
select invoice_number, invoice_total, payment_total + credit_total as payment_credit_total, 
	(invoice_total - payment_total - credit_total) as balance_due
from invoices 
where (invoice_total - payment_total - credit_total) > 50 
order by balance_due desc
limit 5;

-- Q10
-- return invoice_number, invoice_date, and (invoice_total - payment_total - credit_total) as balance_due 
-- where payment_date contains a null value
select invoice_number, invoice_date, (invoice_total - payment_total - credit_total) as balance_due, 
	payment_date
from invoices
where payment_date IS NULL;

-- Q11
-- return the current date in mm-dd-yyyy format
select date_format(current_date, '%e-%b-%Y') as "current_date";

-- Q12
-- create a row with 50000 as the starting_principal, 50000 * .6 as interest and 
-- 50000 + (50000 * .6) as principal_plus_interest
select 50000 as starting_principal, 50000 * .6 as interest, 
	50000 + (50000 * .6) as principal_plus_interest;
