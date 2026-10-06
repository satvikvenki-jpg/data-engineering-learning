-- Synthetic dialect-translation example, not production migration SQL.
SELECT DATEADD(day, 1, order_date) AS next_day
FROM orders;
