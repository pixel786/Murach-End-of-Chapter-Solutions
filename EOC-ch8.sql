-- Zainab Sherani
-- Date Completed: 04-09-20
-- Purpose: End of Chapter Practice Problems 

-- data types
-- numeric data type: integers (numbers w/o decimal points) and real numbers (numbers with decimal points)
-- date and time: date, time, or stores both
-- Large Object (LOB) Data Types: useful for storing images, sound, video, and large amounts of character data
-- spatial data types: useful for storing GPS data

-- char: to store fixed-length strings, data stored in this always occupy the the same number of bytes
-- regardless of actual length of the string CHAR(2) stores 2 characters and if 2 characters were 
-- used in char(10), then MySQL appends eight spaces so that it contains 10 characters

-- Q1
select invoice_total, format(invoice_total, 1), convert(invoice_total, signed), 
	cast(invoice_total as signed) 
from invoices;

-- Q2
select invoice_total, cast(invoice_date as datetime), cast(invoice_date as char(7))
from invoices;




