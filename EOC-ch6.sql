-- Zainab Sherani
-- Date Completed: 03-29-20
-- Purpose: End of Chapter Practice Problems 

-- Q1
-- return one row for each vendor in the Invoices table with the 
-- vendor_id and invoice_total columns
select vendor_id, sum(invoice_total) as total_invoice_amt
from vendors join invoices using (vendor_id)
group by vendor_id;

-- Q2 
-- return one row for each row that contains vendor_name and 
-- sum of the payment_total columns for that vendor 
select vendor_name, sum(payment_total) as payment_total 
from vendors join invoices using (vendor_id)
group by vendor_id
order by sum(payment_total) desc;

-- Q3 
-- return one row for each vendor that contains the 
-- vendor_name, count of invoices for each vendor, and sum of invoice_total for each vendor
select vendor_name, count(*) as invoice_qty,
sum(invoice_total) as all_invoice_total
from vendors join invoices using (vendor_id)
group by vendor_id
order by all_invoice_total desc;

-- Q4 
-- return one row for each general ledger account (gla) number with 
-- account_description (from gla), count of items (from invoice_line_items), 
-- sum of line_item_amount (from invoice_line_items)
-- group by account_description, and limit results set to vendors with line_items > 1
select account_description, count(*) as items_qty, sum(line_item_amount) as line_item_total
from general_ledger_accounts 
	join invoice_line_items using (account_number)
group by account_description
having items_qty > 1
order by line_item_total desc;

-- Q5
-- modify Q4 so that it returns invoices dated April 1, 2014 to June 30, 2014
select account_description, count(*) as items_qty, sum(line_item_amount) as line_item_total
from general_ledger_accounts 
	join invoice_line_items using (account_number)
    join invoices using (invoice_id)
where invoice_date between '2014-04-01' and '2014-06-30'
group by account_description
having items_qty > 1
order by line_item_total desc;

-- Q6 
-- retreive the total amount invoiced for each general ledger account number 
-- and include a summary row 
select account_number, sum(line_item_amount) as line_item_total
from invoice_line_items
group by account_number with rollup;

-- Q7
-- answer the question:
-- 'which vendors are being paid from more than one account?'
select vendor_name, count(distinct li.account_number) as account_number
from vendors
	join invoices using (vendor_id)
	join invoice_line_items li using (invoice_id)
group by vendor_name
having account_number > 1
order by vendor_name;
