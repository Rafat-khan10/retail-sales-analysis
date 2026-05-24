1. Data overview

SELECT 'customers' AS table_name, COUNT(*) FROM customers
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'stores', COUNT(*) FROM stores
UNION ALL
SELECT 'exchange_rates', COUNT(*) FROM exchange_rates
UNION ALL
SELECT 'sales', COUNT(*) FROM sales;
