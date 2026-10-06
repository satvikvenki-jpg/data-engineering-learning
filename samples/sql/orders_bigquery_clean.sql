-- Synthetic reference query. No database connection is required for linting.
SELECT
    order_id,
    market,
    amount
FROM `practice-project.practice_analytics.orders`
WHERE amount > 0;
