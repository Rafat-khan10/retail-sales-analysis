1. Which are the top 20 revenue-generating products by each category?

WITH product_category AS
  (SELECT p.category,
          p.product_name,
          SUM(s.quantity * p.unit_price) AS total_revenue
   FROM products AS p
   INNER JOIN sales AS s ON p.productkey = s.productkey
   GROUP BY p.category,
            p.product_name
   ORDER BY total_revenue DESC),
     caterogy_ranking AS
  (SELECT *,
          DENSE_RANK() OVER(PARTITION BY category ORDER BY total_revenue DESC) AS category_rank
   FROM product_category)
SELECT *
FROM caterogy_ranking
WHERE category_rank <=20

============================================================================================================================================================================  
  
2. What are the top 20 most profitable products within each category?

WITH cte AS
  (SELECT p.category,
          p.product_name,
          COUNT(DISTINCT order_number) AS total_orders,
          SUM(s.quantity * p.unit_price) AS total_revenue,
          SUM(s.quantity * (p.unit_price - p.unit_cost)) AS total_Profit
   FROM sales AS s
   INNER JOIN products AS p ON s.productkey = p.productkey
   GROUP BY p.category,
            p.product_name
   ORDER BY total_profit DESC),
     cte2 AS
  (SELECT *,
          DENSE_RANK() OVER(PARTITION BY category ORDER BY total_profit DESC) AS rank_by_profit
   FROM cte)
SELECT *
FROM cte2
WHERE rank_by_profit <=20

 ============================================================================================================================================================================ 
  

3. Which product categories have the highest profit margin? 

WITH cte AS
  (SELECT p.category,
          SUM(s.quantity) AS total_units_sold,
          COUNT(DISTINCT s.productkey) AS num_products,
          SUM((p.unit_price - p.unit_cost)*s.quantity) AS total_profit,
          SUM(s.quantity * p.unit_price) AS total_revenue
   FROM sales AS s
   INNER JOIN products AS p ON s.productkey = p.productkey
   GROUP BY p.category)
SELECT *,
       ROUND(total_profit*100.0 / total_revenue, 2) AS profit_margin_percentage
FROM cte
ORDER BY profit_margin_percentage DESC
  
============================================================================================================================================================================
  
4. What are the most profitable products within each category? 

WITH cte AS
  (SELECT p.category,
          p.product_name,
          SUM(s.quantity) AS total_units_sold,
          SUM((p.unit_price - p.unit_cost)*s.quantity) AS total_profit
   FROM sales AS s
   INNER JOIN products AS p ON s.productkey = p.productkey
   GROUP BY p.category, p.product_name),
     cte2 AS
  (SELECT *,
          DENSE_RANK() OVER(PARTITION BY category ORDER BY total_profit DESC) AS rank_by_profit
   FROM cte)
SELECT *
FROM cte2
WHERE rank_by_profit <=20

============================================================================================================================================================================

  
5. Which brands generate the least profit within each category?

WITH cte AS
  (SELECT category,
          brand,
          COUNT(s.order_number) AS total_orders,
          SUM((p.unit_price - p.unit_cost)*s.quantity) AS total_profit
   FROM products AS p
   INNER JOIN sales AS s ON p.productkey = s.productkey
   GROUP BY category, brand)
SELECT *,
       DENSE_RANK() OVER(PARTITION BY category ORDER BY total_profit ASC) AS rank_by_less_profit
FROM cte
  
============================================================================================================================================================================

  
6. Which products contribute to the top 10% of revenue within each category?

WITH cte AS
  (SELECT p.category,
          p.product_name,
          SUM(s.quantity * p.unit_price) AS total_revenue
   FROM products AS p
   INNER JOIN sales AS s ON p.productkey = s.productkey
   GROUP BY p.category,
            p.product_name),
     cte2 AS
  (SELECT *,
          SUM(total_revenue) OVER(PARTITION BY category ORDER BY total_revenue DESC) AS cumulative_sum,
          ROUND(SUM(total_revenue) OVER(PARTITION BY category ORDER BY total_revenue DESC)*100.0 / SUM(total_revenue) OVER(), 2)AS revenue_percentage
   FROM cte)
SELECT *
FROM cte2
WHERE revenue_percentage <=10












