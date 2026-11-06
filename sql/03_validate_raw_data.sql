SELECT 'kb_financial' AS dataset, COUNT(*) AS row_count
FROM raw.kb_financial_raw

UNION ALL

SELECT 'shinhan_financial', COUNT(*)
FROM raw.shinhan_financial_raw

UNION ALL

SELECT 'hana_financial', COUNT(*)
FROM raw.hana_financial_raw

UNION ALL

SELECT 'woori_financial', COUNT(*)
FROM raw.woori_financial_raw

UNION ALL

SELECT 'kospi', COUNT(*)
FROM raw.kospi_raw

UNION ALL

SELECT 'usd_krw', COUNT(*)
FROM raw.usd_krw_raw
UNION ALL

SELECT 'base_rate', COUNT(*)
FROM raw.base_rate_raw

UNION ALL

SELECT 'usd_krw_fred', COUNT(*)
FROM raw.usd_krw_fred_raw;

SELECT *
FROM raw.usd_krw_raw
LIMIT 5;

SELECT *
FROM raw.hana_financial_raw
LIMIT 3;

SELECT *
FROM raw.kospi_raw
LIMIT 3;

SELECT *
FROM raw.base_rate_raw
LIMIT 5;

SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT trade_date) AS unique_dates,
       COUNT(*) - COUNT(DISTINCT trade_date) AS duplicate_rows,
       COUNT(exchange_rate) AS valid_exchange_rows,
       COUNT(*) - COUNT(exchange_rate) AS missing_exchange_rows
FROM raw.usd_krw_fred_raw;