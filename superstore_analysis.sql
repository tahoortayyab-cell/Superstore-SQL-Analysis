Use superstore;


-- Find cities whose total sales are greater than the average total sales across all cities -- 

WITH CTE AS(
Select city, sum(Sales) as total_sales
from train
group by city)
select city, total_sales
from CTE 
where total_sales > (select avg(total_sales) from CTE);

-- Calculate total sales for each city -- 

Select city, sum(Sales) as total_sales
from train
group by city;


-- Calculate total sales and total number of orders for each category using two separate CTEs -- 

WITH CTE1 AS(
select Category, SUM(sales) as total_sales
from train
group by Category),
CTE2 AS(
select Category, COUNT(`Order ID`) as total_orders
from train
group by Category)
select CTE1.Category, CTE1.total_sales, CTE2.total_orders
from CTE1 JOIN CTE2 ON
CTE1.Category=CTE2.Category;



-- Calculate region-wise total sales and order count, and sort by sales descending and order count ascending -- 

select Region, sum(sales) as total_sales, count(`Order ID`) as total_order
from train 
GROUP by Region
ORDER by SUM(Sales) DESC, count(`Order ID`) ASC ;

-- Find the top-selling Sub-Category within each Category using window functions -- 

WITH CTE AS(
Select Category, `Sub-Category`, SUM(Sales) as total_sales,
ROW_NUMBER() OVER(PARTITION BY Category
 ORDER BY SUM(Sales) DESC ) as rnk
from train
group by Category, `Sub-Category`)
Select Category , `Sub-Category`, total_sales
from CTE
WHERE rnk=1;

-- Find customers who placed only one order along with their total spending -- 

Select `Customer ID`, `Customer Name`, 
Count(`Order ID`) as total_order,
SUM(Sales) as total_spending
from train
group by `Customer ID`, `Customer Name`
Having count(`Order ID`) =1;

-- Calculate monthly total sales and return months where sales are above the average monthly sales -- 

WITH CTE AS(
Select 
MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) as month_no,
 Sum(Sales) as total_sales
from train 
group by MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')))
select month_no, total_sales
from CTE
where total_sales> (Select AVG(total_sales) from CTE)
and month_no IS NOT NULL;

-- Find top 3 customers by sales in each region using ranking --

WITH CTE AS(
SELECT `Customer Name`, Region, Sum(Sales) as total_sales,
ROW_NUMBER() OVER(Partition by Region ORDER BY Sum(Sales) DESC) as rnk
from train
group by Region, `Customer Name`)
select * from CTE 
WHERE rnk<=3;

-- Calculate yearly total sales and sort in descending order -- 

select YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')),
 sum(Sales) as total_sales
from train 
where YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) IS NOT NULL
group by YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))
order by total_sales DESC;


-- Calculate average order value per state based on order-level sales --
 
WITH CTE AS(
select State, `Order ID`, Sum(Sales) as order_value
from train
group by State, `Order ID`)
select State,
AVG(order_value) as avg_order_value from CTE 
GROUP BY State
ORDER BY avg_order_value DESC
LIMIT 10;

-- Calculate total sales for each Segment and Category combination -- 

Select Segment, Category, Sum(Sales) as `Total Sales`
from train 
group by Segment, Category;

-- Find products that appear only once in the dataset along with their total sales -- 

select `Product Name`, 
 Sum(Sales) as total_sales
from train
group by `Product Name`
HAVING count(*) =1;

-- Calculate average shipping time for each ship mode -- 

WITH CTE AS (
SELECT `Ship Mode`,
       DATEDIFF(
           STR_TO_DATE(`Ship Date`, '%m/%d/%Y'),
           STR_TO_DATE(`Order Date`, '%m/%d/%Y')
       ) AS total_time
FROM train)
select `Ship Mode` , 
avg(total_time) as `AVG SHIP TIME`
from CTE
group by `Ship Mode`;
