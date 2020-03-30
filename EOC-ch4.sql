-- Zainab Sherani
-- Date Completed: 03-26-20
-- Purpose: End of Chapter Practice Problems 

-- Q1
-- inner join on vendors and invoices
select * 
from vendors 
	join invoices using (vendor_id);

-- Q2
-- join vendors and invocies and show result set with a non-zero balance
-- order by vendor_name ascending
select vendor_name, invoice_number, invoice_date, 
	(invoice_total - payment_total - credit_total) as balance_due
from vendors v 
	join invoices i using (vendor_id) 
where (invoice_total - payment_total - credit_total) > 0
order by vendor_name;

-- Q3
-- join vendors and general_ledger_accounts 
-- order by account_description and then vendor_name
select vendor_name, default_account_number as default_account, account_description as "description" 
from vendors v 
	join general_ledger_accounts g 
	on g.account_number = v.default_account_number
order by account_description, vendor_name;

-- Q4
-- join vendors, invoices, invoice_line_items
-- return vendor_name, invoice_date, invoice_number, invoice_sequence as li_sequence, 
-- line_item_amount as li_amount
-- and order by vendor_name, invoice_date, invoice_number, invoice_sequence 
select vendor_name, invoice_date, invoice_number, 
	invoice_sequence as li_sequence, line_item_amount as li_amount
from vendors 
	join invoices using (vendor_id)
    join invoice_line_items using (invoice_id)
order by vendor_name, invoice_date, invoice_number, invoice_sequence;

-- using table aliases 
select vendor_name, invoice_date, invoice_number, 
	invoice_sequence as li_sequence, line_item_amount as li_amount
from vendors v 
	join invoices i on i.vendor_id = v.vendor_id
    join invoice_line_items li on li.invoice_id = i.invoice_id 
order by vendor_name, invoice_date, invoice_number, invoice_sequence;

-- Q5
-- self-join 
-- return vendors that have contacts with the same last names
select v1.vendor_id, v1.vendor_name, 
	concat(v1.vendor_contact_first_name, " ", v1.vendor_contact_last_name) as contact_name
from vendors v1 join vendors v2 
	on v1.vendor_contact_last_name = v2.vendor_contact_last_name
    and v1.vendor_id <> v2.vendor_id
order by v1.vendor_contact_last_name;

-- Q6
-- return account_number, acount_description for 
-- all accounts that have not been used 
select account_number, account_description -- , invoice_id
from general_ledger_accounts
	left join invoice_line_items using (account_number)
where invoice_id is null;

-- Q7
-- return column with vendor_name, vendor_state 
-- vendor_state column should have CA for vendors from CA and "Outside CA" from anywhere else
select vendor_name, vendor_state
from vendors 
where vendor_state = "CA"
union 
select vendor_name, "Outside CA" as vendor_state
from vendors 
where vendor_state <> "CA"
order by vendor_name;

