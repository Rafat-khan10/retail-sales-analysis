1. Which customers collectively generate the top 20% of total revenue?

WITH cte AS
  (SELECT c.customerkey,
          c.name,
          c.country,
          SUM(s.quantity*p.unit_price) AS total_revenue
   FROM customers AS c
   INNER JOIN sales AS s ON c.customerkey= s.customerkey
   INNER JOIN products AS p ON s.productkey = p.productkey
   GROUP BY c.customerkey,
            c.name,
            c.country),
     cte2 AS
  (SELECT *,
          ROUND(SUM(total_revenue) 
          OVER(ORDER BY total_revenue DESC)*100.0/ SUM(total_revenue) OVER (), 2) AS cumulative_revenue_percent
   FROM cte)
SELECT *
FROM cte2
WHERE cumulative_revenue_percent <=20

 =================================================================================================================================================================================
  
2. How can customers be segmented using RFM analysis?

WITH unique_customers AS
  (SELECT DISTINCT customerkey,
                   order_date
   FROM sales),
     next_order AS
  (SELECT customerkey,
          order_date,
          LEAD(order_date) 
  OVER(PARTITION BY customerkey ORDER BY order_date ASC) AS next_order_date
   FROM unique_customers),
     avg_days AS
  (SELECT customerkey,
          ROUND(AVG(next_order_date - order_date)::NUMERIC) AS avg_days
   FROM next_order
   WHERE next_order_date IS NOT NULL
   GROUP BY customerkey),
     revenue AS
  (SELECT s.customerkey,
          COUNT(DISTINCT s.order_number) AS total_orders,
          SUM(s.quantity * p.unit_price) AS total_revenue
   FROM sales AS s
   INNER JOIN products AS p ON s.productkey = p.productkey
   GROUP BY s.customerkey),
     customer_segment AS
  (SELECT r.customerkey,
          r.total_orders,
          r.total_revenue,
          a.avg_days,
          NTILE(5) OVER(
                        ORDER BY r.total_orders DESC) AS frequency_score,
          NTILE(5) OVER(
                        ORDER BY a.avg_days DESC) AS recency_score,
          NTILE(5) OVER(
                        ORDER BY r.total_revenue DESC) AS monetary_score
   FROM revenue AS r
   LEFT JOIN avg_days AS a ON r.customerkey = a.customerkey)
SELECT *,
       CASE
           WHEN recency_score>=4
                AND frequency_score>=4
                AND monetary_score>=4 THEN 'Champion'
           WHEN recency_score>=4
                AND frequency_score>=4 THEN 'Loyal Customers'
           WHEN recency_score>=4
                AND frequency_score <=2 THEN 'New Customers'
           WHEN recency_score <=2
                AND frequency_score >=3 THEN ' At Risk'
           WHEN recency_score =1
                AND frequency_score =1 THEN 'Lost Customer'
           ELSE 'Needs Attention '
       END AS customer_segment
FROM customer_segment
  
==============================================================================================================================================================================

3. What is the Average Order Value (AOV) per customer?

WITH cte AS
  (SELECT s.customerkey,
          COUNT(DISTINCT order_number) AS total_orders,
          SUM(s.quantity * p.unit_price) AS total_revenue
   FROM sales AS s
   INNER JOIN products AS p ON s.productkey = p.productkey
   GROUP BY s.customerkey)
SELECT *,
       ROUND(total_revenue::NUMERIC/total_orders, 2) AS average_order_value
FROM cte
ORDER BY average_order_value DESC

===============================================================================================================================================================================

4. How does monthly revenue compare between new and returning customers over time?

WITH first_purchase AS
  (SELECT customerkey,
          MIN(order_date) AS first_order_date
   FROM sales
   GROUP BY customerkey),
     monthly_sales AS
  (SELECT EXTRACT(YEAR FROM s.order_date) AS YEAR,
          EXTRACT(MONTH FROM s.order_date) AS month_num,
          TO_CHAR(s.order_date, 'Mon') AS month_name,
          CASE
              WHEN s.order_date = fp.first_order_date THEN 'New Customer'
              ELSE 'Returning Customer'
          END AS customer_type,
          SUM(s.quantity * p.unit_price) AS revenue,
          COUNT(DISTINCT s.order_number) AS total_orders
   FROM sales s
   JOIN products p ON s.productkey = p.productkey
   JOIN first_purchase fp ON s.customerkey = fp.customerkey
   GROUP BY YEAR,
            month_num,
            month_name,
            customer_type)
SELECT YEAR,
       month_num,
       month_name,
       customer_type,
       total_orders,
       revenue,
       ROUND(revenue * 100.0 / SUM(revenue) OVER (PARTITION BY YEAR, month_num), 2) AS revenue_percentage
FROM monthly_sales
ORDER BY YEAR DESC, month_num DESC,customer_type;

 =================================================================================================================================================================================

5. Which customers fall in the top 10% by lifetime spend?
  
WITH cte AS
  (SELECT s.customerkey,
          SUM(s.quantity * p.unit_price) AS total_revenue
   FROM sales AS s
   INNER JOIN products AS p ON s.productkey = p.productkey
   GROUP BY s.customerkey),
     cte2 AS
  (SELECT *,
          ROUND((CUME_DIST() 
          OVER(ORDER BY total_revenue DESC)::NUMERIC)*100, 2)AS cumulative_perc
   FROM cte)
SELECT *
FROM cte2
WHERE cumulative_perc <=10

















