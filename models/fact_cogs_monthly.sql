SELECT
  DATE_TRUNC(pl.calendar_month, MONTH) AS month,
  SUM(pl.amount)                       AS cogs
FROM {{ source('quickbooks', 'quickbooks__profit_and_loss') }} pl
{# WHERE LOWER(pl.account_type) = 'cost of goods sold' #}
WHERE LOWER(pl.account_type) = 'income'
GROUP BY 1
ORDER BY 1;