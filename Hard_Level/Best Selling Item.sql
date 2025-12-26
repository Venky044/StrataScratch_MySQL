                -- Best Selling Item

-- Find the best-selling item for each month (no need to separate months by year).
-- The best-selling item is determined by the highest total sales amount, calculated as: total_paid = unitprice * quantity.
-- A negative quantity indicates a return or cancellation (the invoice number begins with 'C'.
-- To calculate sales, ignore returns and cancellations. Output the month, description of the item, and the total amount paid.

-- Table: online_retail

-- invoiceno: text
-- stockcode: text
-- description: text 
-- quantity: bigint
-- invoicedate: date
-- unitprice: double
-- customerid: double
-- country: text

-- Solution:

with total_paid as (
    select month(invoicedate) as Month_no, description, sum(quantity * unitprice) as t_paid
    from online_retail
    where invoiceno not like ("C%")
    group by Month_no, description
),
max_paid as (
    select Month_no, max(t_paid) as max_t_paid
    from total_paid
    group by Month_no
)
select 
    tp.Month_no, tp.description, tp.t_paid
from total_paid tp
inner join max_paid mp on tp.Month_no = mp.Month_no
                        and tp.t_paid = mp.max_t_paid
order by tp.Month_no;
