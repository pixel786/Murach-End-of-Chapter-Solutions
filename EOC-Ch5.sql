-- Zainab Sherani
-- Date Completed: 03-27-20
-- Purpose: End of Chapter Practice Problems 

-- Q1
-- add a specifc row to the Terms table
insert into terms values
(default, 'Net due 120 days', 120);

-- Q2 
-- update statement to modify the row just added in Q1
update terms 
set terms_description = 'Net due 125 days',
	terms_due_days = 125
where terms_id = 6;

-- Q3
-- delete the row that was inserted in Q1
delete from terms
where terms_id = 6;

-- Q4 
-- add a row to the invoices table
insert into invoices values 
(default, 32, 'AX-014-027', date('2014-08-1'), 434.58, 0, 0, 2, 
	date('2014-08-31'), null);
    
-- Q5
-- add rows to Invoice_Line_Items table
-- invoice_id is not autoincrement which is why the default keyword is not used
insert into invoice_line_items values
(115, 1, 160, 180.23, "Hard Drive"),
(115, 2, 527, 254.35, "Exchange Server update");

-- Q6
-- update Q4 by changing credit_total column so it's 10% of the invoice_total column
-- also change payment_total column to be payment_total + credit_total = invoice_total 
update invoices 
set credit_total = invoice_total * .1,
	payment_total = 434.58 - (invoice_total * .1)
where invoice_id = 115;
	
-- Q7 
-- modify vendors table and 
-- change default_account_number column to 403 for the vendor with an ID of 44
update vendors
set default_account_number = 403
where vendor_id = 44;

-- Q8
-- modify Invoices table and 
-- change terms_id column to 2 for each invoice that's for a vendor with a default_terms_id of 2
SET SQL_SAFE_UPDATES = 0;
update invoices 
set terms_id = 2
where vendor_id in 
	(select vendor_id
	from vendors
	where default_terms_id = 2);
    
-- Q9
-- delete row that was added in Q4
-- since the invoices table has related rows in invoice_line_items.
-- first delete rows from invoice_line_items and then invoices
delete from invoice_line_items
where invoice_id = 115;

delete from invoices
where invoice_id = 115;







