1. What is the month-over-month revenue growth rate?

WITH cte AS
  (SELECT EXTRACT(YEAR FROM s.order_date) AS YEAR,
          TO_CHAR(s.order_date, 'Mon') AS month_char,
          EXTRACT(MONTH FROM s.order_date) AS month_num,
          SUM(s.quantity * p.unit_price) AS current_month_revenue
   FROM sales AS s
   INNER JOIN products AS p ON s.productkey = p.productkey
   GROUP BY YEAR,
            month_char,
            month_num),
     cte2 AS
  (SELECT *,
          LAG(current_month_revenue) 
  OVER(PARTITION BY YEAR ORDER BY month_num ASC) AS previous_month_revenue
   FROM cte)
SELECT *,
       ROUND((current_month_revenue - previous_month_revenue)::NUMERIC/NULLIF(previous_month_revenue, 0), 2) AS mom_revenue_growth
FROM cte2


2. Which quarter generates the highest revenue each year?

SELECT EXTRACT(YEAR FROM s.order_date) AS YEAR,
       EXTRACT(QUARTER FROM s.order_date) AS QUARTER,
       SUM(s.quantity * p.unit_price) AS current_month_revenue
FROM sales AS s
INNER JOIN products AS p ON s.productkey = p.productkey
GROUP BY YEAR,
         QUARTER
ORDER BY YEAR ASC,current_month_revenue DESC

