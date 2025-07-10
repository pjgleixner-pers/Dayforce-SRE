-- 1. Retrieve the Sales table data with only the sales_id, store_id and sales_amount columns.

SELECT sales_id, store_id, sales_amount
FROM Sales

-- 2. Retrieve all of the sales for the 'Pink' store for 2019 in Mexico (all columns from the Sales and Store tables).

SELECT *
FROM sales INNER JOIN store ON sales.store_id = store.store_id
WHERE
store.store_name Like '%Pink%' AND sales.country Like '%Mexico%' AND sales.year = 2019

--post interview answer
SELECT *
FROM Sales
INNER JOIN Store ON Sales.store_id = Store.store_id
WHERE Store.store_name = 'Pink Store'
  AND Sales.country = 'Mexico'
  AND Sales.year = 2019;


-- 3. Retrieve the total number of sales per store for the year 2019 (store_id, total_sales).

SELECT COUNT(*) AS total_sales, sales.store_id
FROM sales INNER JOIN Store ON sales.store_id = store.store_id
WHERE sales.year = 2019
GROUP BY sales.store_id

-- 4. Retrieve the store_names which had more than 1 sales for the year 2019 (store_name, count_of_sales).

--interview answer
SELECT store.store_name , COUNT(*) AS total_sales
FROM sales FULL OUTER JOIN Store ON sales.store_id = store.store_id
WHERE sales.year = 2019
GROUP BY sales.store_name

--post interview answer
SELECT Store.store_name, COUNT(*) AS count_of_sales
FROM Sales
INNER JOIN Store ON Sales.store_id = Store.store_id
WHERE Sales.year = 2019
GROUP BY Store.store_name
HAVING COUNT(*) > 1;

-- 5. Create an index on Sales that would make your query from Question 2 more efficient. 

--interview answer
select *
from sales inner join Store on sales.store_id = store.store_id
where store.store_name Like '%Pink%' and sales.country Like '%Mexico%' and sales.year = 2019

--post interview answer
CREATE INDEX idx_sales_country_year_store
ON Sales (country, year, store_id);



