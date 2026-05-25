1. What are the top 5 revenue-generating product categories for each store? 

WITH cte AS
  (SELECT s.storekey,
          p.category,
          SUM(s.quantity * p.unit_price) AS total_revenue
   FROM stores AS st
   INNER JOIN sales AS s ON st.storekey = s.storekey
   INNER JOIN products AS p ON p.productkey = s.productkey
   GROUP BY s.storekey,
            p.category
   ORDER BY total_revenue DESC),
     category_ranking AS
  (SELECT *,
          DENSE_RANK() OVER(PARTITION BY storekey ORDER BY total_revenue DESC) AS category_rank
   FROM cte)
SELECT *
FROM category_ranking
WHERE category_rank <=5

2. What is the average delivery time in days for each store?
  

3. Which states generate the highest revenue  within each country?

WITH cte AS
  (SELECT c.country,
          c.state,
          SUM(s.quantity * p.unit_price) AS total_revenue
   FROM customers AS c
   INNER JOIN sales AS s ON c.customerkey = s.customerkey
   INNER JOIN products AS p ON p.productkey = s.productkey
   GROUP BY c.country,
            c.state),
     cte2 AS
  (SELECT *,
          DENSE_RANK() OVER(PARTITION BY country ORDER BY total_revenue DESC) AS rank_by_revenue
   FROM cte)
SELECT *
FROM cte2
WHERE rank_by_revenue <=5
