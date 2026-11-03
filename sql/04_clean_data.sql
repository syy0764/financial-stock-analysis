CREATE SCHEMA IF NOT EXISTS clean;

CREATE TABLE IF NOT EXISTS clean.kb_financial (
    trade_date DATE,
    open_price NUMERIC,
    high_price NUMERIC,
    low_price NUMERIC,
    close_price NUMERIC,
    volume BIGINT,
    change_rate NUMERIC
);

SELECT *
FROM raw.kb_financial_raw
LIMIT 5;

TRUNCATE TABLE clean.kb_financial;

INSERT INTO clean.kb_financial (
    trade_date,
    open_price,
    high_price,
    low_price,
    close_price,
    volume,
    change_rate
)
SELECT
    CAST(trade_date AS DATE) AS trade_date,
    CAST(open_price AS NUMERIC) AS open_price,
    CAST(high_price AS NUMERIC) AS high_price,
    CAST(low_price AS NUMERIC) AS low_price,
    CAST(close_price AS NUMERIC) AS close_price,
    CAST(volume AS BIGINT) AS volume,
    CAST(change_rate AS NUMERIC) AS change_rate
FROM raw.kb_financial_raw;

SELECT COUNT(*), MIN(trade_date), MAX(trade_date)
FROM clean.kb_financial;


CREATE TABLE IF NOT EXISTS clean.shinhan_financial (
    trade_date DATE,
    open_price NUMERIC,
    high_price NUMERIC,
    low_price NUMERIC,
    close_price NUMERIC,
    volume BIGINT,
    change_rate NUMERIC
);

TRUNCATE TABLE clean.shinhan_financial;

INSERT INTO clean.shinhan_financial (
    trade_date,
    open_price,
    high_price,
    low_price,
    close_price,
    volume,
    change_rate
)
SELECT
    CAST(trade_date AS DATE) AS trade_date,
    CAST(open_price AS NUMERIC) AS open_price,
    CAST(high_price AS NUMERIC) AS high_price,
    CAST(low_price AS NUMERIC) AS low_price,
    CAST(close_price AS NUMERIC) AS close_price,
    CAST(volume AS BIGINT) AS volume,
    CAST(change_rate AS NUMERIC) AS change_rate
FROM raw.shinhan_financial_raw;

SELECT COUNT(*), MIN(trade_date), MAX(trade_date)
FROM clean.shinhan_financial;


CREATE TABLE IF NOT EXISTS clean.hana_financial (
    trade_date DATE,
    open_price NUMERIC,
    high_price NUMERIC,
    low_price NUMERIC,
    close_price NUMERIC,
    volume BIGINT,
    change_rate NUMERIC
);

TRUNCATE TABLE clean.hana_financial;

INSERT INTO clean.hana_financial (
    trade_date,
    open_price,
    high_price,
    low_price,
    close_price,
    volume,
    change_rate
)
SELECT
    CAST(trade_date AS DATE) AS trade_date,
    CAST(open_price AS NUMERIC) AS open_price,
    CAST(high_price AS NUMERIC) AS high_price,
    CAST(low_price AS NUMERIC) AS low_price,
    CAST(close_price AS NUMERIC) AS close_price,
    CAST(volume AS BIGINT) AS volume,
    CAST(change_rate AS NUMERIC) AS change_rate
FROM raw.hana_financial_raw;


CREATE TABLE IF NOT EXISTS clean.woori_financial (
    trade_date DATE,
    open_price NUMERIC,
    high_price NUMERIC,
    low_price NUMERIC,
    close_price NUMERIC,
    volume BIGINT,
    change_rate NUMERIC
);

TRUNCATE TABLE clean.woori_financial;

INSERT INTO clean.woori_financial (
    trade_date,
    open_price,
    high_price,
    low_price,
    close_price,
    volume,
    change_rate
)
SELECT
    CAST(trade_date AS DATE) AS trade_date,
    CAST(open_price AS NUMERIC) AS open_price,
    CAST(high_price AS NUMERIC) AS high_price,
    CAST(low_price AS NUMERIC) AS low_price,
    CAST(close_price AS NUMERIC) AS close_price,
    CAST(volume AS BIGINT) AS volume,
    CAST(change_rate AS NUMERIC) AS change_rate
FROM raw.woori_financial_raw;


SELECT 'hana' AS company, COUNT(*), MIN(trade_date), MAX(trade_date)
FROM clean.hana_financial
UNION ALL
SELECT 'woori' AS company, COUNT(*), MIN(trade_date), MAX(trade_date)
FROM clean.woori_financial;

SELECT *
FROM raw.kospi_raw
LIMIT 5;

CREATE TABLE IF NOT EXISTS clean.kospi(
    trade_date DATE,
    high_price NUMERIC,
    low_price NUMERIC,
    close_price NUMERIC,
    open_price NUMERIC,
    change_amount NUMERIC,
    change_rate NUMERIC,
    volume BIGINT,
    trading_value BIGINT,
    market_cap NUMERIC,
    up_down SMALLINT
);

TRUNCATE TABLE clean.kospi;

INSERT INTO clean.kospi(
    trade_date,
    high_price,
    low_price,
    close_price,
    open_price,
    change_amount,
    change_rate,
    volume,
    trading_value,
    market_cap,
    up_down
)
SELECT
    CAST(trade_date AS DATE),
    CAST(high_price AS NUMERIC),
    CAST(low_price AS NUMERIC),
    CAST(close_price AS NUMERIC),
    CAST(open_price AS NUMERIC),
    CAST(change_amount AS NUMERIC),
    CAST(change_rate AS NUMERIC),
    CAST(volume AS BIGINT),
    CAST(trading_value AS BIGINT),
    CAST(market_cap AS NUMERIC),
    CAST(up_down AS SMALLINT)
FROM raw.kospi_raw;

SELECT COUNT(*), MIN(trade_date) , MAX(trade_date)
FROM clean.kospi;

SELECT COUNT(*), COUNT(DISTINCT trade_date), COUNT(close_price),COUNT(volume)
FROM clean.kospi;

SELECT COUNT(*)
FROM clean.kospi
WHERE high_price IS NULL
   OR low_price IS NULL
   OR open_price IS NULL
   OR change_amount IS NULL
   OR change_rate IS NULL
   OR trading_value IS NULL
   OR market_cap IS NULL
   OR up_down IS NULL;

SELECT *
FROM raw.usd_krw_raw
LIMIT 5;

SELECT COUNT(*), MIN(trade_date), MAX(trade_date), COUNT(DISTINCT trade_date)
FROM raw.usd_krw_raw

SELECT volume, COUNT(*)
FROM raw.usd_krw_raw
GROUP BY volume
ORDER BY COUNT(*) DESC;

SELECT trade_date, close_price, adjusted_close_price, volume
FROM raw.usd_krw_raw
WHERE close_price IS DISTINCT FROM adjusted_close_price
   OR close_price IS NULL
   OR adjusted_close_price IS NULL;

SELECT trade_date, open_price, high_price, low_price, close_price
FROM raw.usd_krw_raw
WHERE close_price IS NULL;

SELECT
    COUNT(*) AS target_rows,
    COUNT(DISTINCT trade_date) AS distinct_dates,
    MIN(trade_date) AS first_date,
    MAX(trade_date) AS last_date
FROM raw.usd_krw_raw
WHERE CAST(trade_date AS DATE) >= DATE '2021-01-01'
  AND CAST(trade_date AS DATE) < DATE '2026-01-01'
  AND open_price IS NOT NULL
  AND high_price IS NOT NULL
  AND low_price IS NOT NULL
  AND close_price IS NOT NULL;

  CREATE TABLE IF NOT EXISTS clean.usd_krw(
    trade_date DATE,
    open_price NUMERIC,
    high_price NUMERIC,
    low_price NUMERIC,
    close_price NUMERIC
  );

TRUNCATE TABLE clean.usd_krw;

INSERT INTO clean.usd_krw(
    trade_date,
    open_price,
    high_price,
    low_price,
    close_price
)
SELECT
    CAST(trade_date AS DATE),
    CAST(open_price AS NUMERIC),
    CAST(high_price AS NUMERIC),
    CAST(low_price AS NUMERIC),
    CAST(close_price AS NUMERIC)
FROM raw.usd_krw_raw
WHERE CAST(trade_date AS DATE) >= DATE '2021-01-01'
  AND CAST(trade_date AS DATE) < DATE '2026-01-01'
  AND open_price IS NOT NULL
  AND high_price IS NOT NULL
  AND low_price IS NOT NULL
  AND close_price IS NOT NULL;

SELECT COUNT(*), COUNT(DISTINCT trade_date), MIN(trade_date), MAX(trade_date)
FROM clean.usd_krw;

SELECT *
FROM raw.base_rate_raw
LIMIT 5;

SELECT COUNT(*), COUNT(DISTINCT change_date), COUNT(base_rate), MIN(change_date), MAX(change_date)
FROM raw.base_rate_raw;

CREATE TABLE IF NOT EXISTS clean.base_rate(
    change_date DATE PRIMARY KEY,
    base_rate NUMERIC NOT NULL
);

TRUNCATE TABLE clean.base_rate;

INSERT INTO clean.base_rate(
    change_date,
    base_rate
)
SELECT
    CAST(change_date AS DATE),
    CAST(base_rate AS NUMERIC)
FROM raw.base_rate_raw;

SELECT COUNT(*), COUNT(DISTINCT change_date), MIN(change_date), MAX(change_date)
FROM clean.base_rate;

SELECT COUNT(*) 
FROM clean.kb_financial AS kb 
JOIN clean.kospi AS k  
ON kb.trade_date = k.trade_date;

SELECT MIN(kb.trade_date), MAX(kb.trade_date) 
FROM clean.kb_financial AS kb 
JOIN clean.kospi AS k  
ON kb.trade_date = k.trade_date
JOIN clean.usd_krw AS fx
ON fx.trade_date = k.trade_date;

SELECT kb.trade_date
FROM clean.kb_financial AS kb
LEFT JOIN clean.usd_krw AS fx
ON kb.trade_date = fx.trade_date
WHERE fx.trade_date IS NULL
ORDER BY kb.trade_date
LIMIT 10;

SELECT trade_date, close_price
FROM clean.usd_krw
WHERE trade_date BETWEEN DATE '2025-10-22' AND DATE '2025-10-27'
ORDER BY trade_date;

SELECT trade_date, close_price
FROM raw.usd_krw_raw
WHERE trade_date = '2025-10-24';

SELECT COUNT(*), EXTRACT(ISODOW FROM kb.trade_date) 
FROM clean.kb_financial AS kb 
LEFT JOIN clean.usd_krw AS fx 
ON kb.trade_date = fx.trade_date 
WHERE fx.trade_date IS NULL 
GROUP BY EXTRACT(ISODOW FROM kb.trade_date) 
ORDER BY EXTRACT(ISODOW FROM kb.trade_date);

SELECT COUNT(*), EXTRACT(ISODOW FROM trade_date) 
FROM clean.usd_krw
GROUP BY EXTRACT(ISODOW FROM trade_date) 
ORDER BY EXTRACT(ISODOW FROM trade_date);

SELECT trade_date, close_price
FROM clean.usd_krw
WHERE trade_date BETWEEN DATE '2021-04-08' AND DATE '2021-04-12'
ORDER BY trade_date;

CREATE TABLE IF NOT EXISTS clean.usd_krw_fred(
    trade_date DATE PRIMARY KEY,
    exchange_rate NUMERIC
);

INSERT INTO clean.usd_krw_fred
SELECT 
    CAST(trade_date AS DATE),
    CAST(exchange_rate AS NUMERIC)
FROM raw.usd_krw_fred_raw;

SELECT COUNT(*), COUNT(DISTINCT trade_date), COUNT(exchange_rate), MIN(trade_date), MAX(trade_date)
FROM clean.usd_krw_fred
