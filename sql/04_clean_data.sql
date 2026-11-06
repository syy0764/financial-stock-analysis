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



-- 최종 분석에 사용하는 FRED 환율 정제
CREATE TABLE IF NOT EXISTS clean.usd_krw_fred (
    trade_date DATE PRIMARY KEY,
    exchange_rate NUMERIC
);

TRUNCATE TABLE clean.usd_krw_fred;

INSERT INTO clean.usd_krw_fred (
    trade_date,
    exchange_rate
)
SELECT
    CAST(trade_date AS DATE),
    CAST(exchange_rate AS NUMERIC)
FROM raw.usd_krw_fred_raw;

SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT trade_date) AS unique_dates,
       COUNT(exchange_rate) AS valid_exchange_rows,
       COUNT(*) - COUNT(exchange_rate) AS missing_exchange_rows,
       MIN(trade_date) AS first_date,
       MAX(trade_date) AS last_date
FROM clean.usd_krw_fred;