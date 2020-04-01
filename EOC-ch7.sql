-- Zainab Sherani
-- Date Completed: 03-31-20
-- Purpose: End of Chapter Practice Problems 

-- Q1
-- vendors join invoices using (vendor_id) 
-- retrieve the vendors that have invoices 
select distinct vendor_name
from vendors join invoices using (vendor_id)
order by vendor_name;

-- rewritten as 
select distinct vendor_name
from vendors
where vendor_id IN
	(select vendor_id from invoices)
order by vendor_name;

-- Q2
-- which invoices have a payment total that's greater than the average payment total for all invoices 
-- with a payment total greater than 0?
select invoice_number, invoice_total
from invoices 
where payment_total > 
	(select avg(payment_total) as avg_payment_total
	from invoices
    where payment_total > 0)
order by invoice_total;

-- Q3
-- return one row for each account number that has never been assigned to any line item 
-- in the invoice_line_items 
select account_number, account_description
from general_ledger_accounts gl
where not exists 
	(select * 
    from invoice_line_items
    where account_number = gl.account_number)
order by account_number;

-- Q4
-- return a row for each line item of each invoice that has more than one line item 
-- in the invoice_line_items table

select vendor_name, invoice_id, invoice_sequence, line_item_amount
from vendors join invoices using (vendor_id)
	join invoice_line_items using (invoice_id)
where invoice_id in
	(select distinct invoice_id from invoice_line_items
	 where invoice_sequence > 1) 
order by vendor_name, invoice_id, invoice_sequence;

-- Q5
-- return largest unpaid invoice for each vendor
select sum(t.balance_due) as max_balance
from
	(select vendor_id, max(invoice_total - payment_total - credit_total) as balance_due
	from invoices
	group by vendor_id
	having max(invoice_total - payment_total - credit_total) > 0) t;
    
-- solution
SELECT SUM(invoice_max) AS sum_of_maximums
FROM (SELECT vendor_id, MAX(invoice_total) AS invoice_max
      FROM invoices
      WHERE invoice_total - credit_total - payment_total > 0
      GROUP BY vendor_id) t;
      
-- Q6 
-- include vendors that don't have a city and state in common with another vendor
select v1.vendor_name, v1.vendor_city, v1.vendor_state
from vendors v1 join vendors v2 using (vendor_id)
where v1.vendor_id <> v2.vendor_id and 
(v1.vendor_city <> v2.vendor_city or
v1.vendor_state <> v2.vendor_state);
    
-- soln doesn't work
SELECT vendor_name, vendor_city, vendor_state
FROM vendors
WHERE CONCAT(vendor_state, vendor_city) NOT IN 
    (SELECT CONCAT(vendor_state, vendor_city) as vendor_city_state
     FROM vendors
     GROUP BY vendor_city_state
     HAVING COUNT(*) > 1)
ORDER BY vendor_state, vendor_city;

-- Q7
-- return one row per vendor representing the vendor's oldest invoice 
select vendor_name, invoice_number, invoice_date, invoice_total
from vendors join invoices i using (vendor_id)
where invoice_date = 
	(select min(invoice_date) as invoice_date
    from invoices
    where vendor_id = i.vendor_id)
order by vendor_name;

-- Q8 
-- code queries in the from clause
-- select vendor_name
-- from 
-- 	(select vendor_name, invoice_number, invoice_date, invoice_total
-- 	vendors join invoices i using (vendor_id)
-- 	where invoice_date = 
-- 		(select min(invoice_date) as invoice_date
-- 		from invoices
-- 		where vendor_id = i.vendor_id)) t
-- order by vendor_name;

-- soln
SELECT vendor_name, invoice_number,
       invoice_date, invoice_total
FROM invoices i
    JOIN
    (
      SELECT vendor_id, MIN(invoice_date) AS oldest_invoice_date
      FROM invoices
      GROUP BY vendor_id
    ) oi
    ON i.vendor_id = oi.vendor_id AND
       i.invoice_date = oi.oldest_invoice_date
    JOIN vendors v
    ON i.vendor_id = v.vendor_id
ORDER BY vendor_name



