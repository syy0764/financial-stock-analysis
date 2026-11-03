CREATE SCHEMA IF NOT EXISTS raw;

CREATE TABLE IF NOT EXISTS raw.kb_financial_raw (
    trade_date TEXT,
    open_price TEXT,
    high_price TEXT,
    low_price TEXT,
    close_price TEXT,
    volume TEXT,
    change_rate TEXT
);

CREATE TABLE IF NOT EXISTS raw.shinhan_financial_raw (
    trade_date TEXT,
    open_price TEXT,
    high_price TEXT,
    low_price TEXT,
    close_price TEXT,
    volume TEXT,
    change_rate TEXT
);

CREATE TABLE IF NOT EXISTS raw.hana_financial_raw (
    trade_date TEXT,
    open_price TEXT,
    high_price TEXT,
    low_price TEXT,
    close_price TEXT,
    volume TEXT,
    change_rate TEXT
);

CREATE TABLE IF NOT EXISTS raw.woori_financial_raw (
    trade_date TEXT,
    open_price TEXT,
    high_price TEXT,
    low_price TEXT,
    close_price TEXT,
    volume TEXT,
    change_rate TEXT
);

CREATE TABLE IF NOT EXISTS raw.kospi_raw (
    trade_date TEXT,
    close_price TEXT,
    up_down TEXT,
    change_amount TEXT,
    change_rate TEXT,
    open_price TEXT,
    high_price TEXT,
    low_price TEXT,
    volume TEXT,
    trading_value TEXT,
    market_cap TEXT
);

CREATE TABLE IF NOT EXISTS raw.usd_krw_raw (
    trade_date TEXT,
    open_price TEXT,
    high_price TEXT,
    low_price TEXT,
    close_price TEXT,
    volume TEXT,
    adjusted_close_price TEXT
);

CREATE TABLE IF NOT EXISTS raw.base_rate_raw (
    change_date TEXT,
    base_rate TEXT
);

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'raw'
ORDER BY table_name;

CREATE TABLE IF NOT EXISTS raw.usd_krw_fred_raw(
    trade_date TEXT,
    exchange_rate TEXT
);