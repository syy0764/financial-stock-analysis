\encoding UTF8

TRUNCATE TABLE
    raw.kb_financial_raw,
    raw.shinhan_financial_raw,
    raw.hana_financial_raw,
    raw.woori_financial_raw,
    raw.kospi_raw,
    raw.usd_krw_raw,
    raw.base_rate_raw,
    raw.usd_krw_fred_raw;
    
\copy raw.kb_financial_raw FROM 'data/raw/kb_financial.csv' WITH (FORMAT CSV, HEADER TRUE, DELIMITER ',');

\copy raw.shinhan_financial_raw FROM 'data/raw/shinhan_financial.csv' WITH (FORMAT CSV, HEADER TRUE, DELIMITER ',');

\copy raw.hana_financial_raw FROM 'data/raw/hana_financial.csv' WITH (FORMAT CSV, HEADER TRUE, DELIMITER ',');

\copy raw.woori_financial_raw FROM 'data/raw/woori_financial.csv' WITH (FORMAT CSV, HEADER TRUE, DELIMITER ',');

\copy raw.kospi_raw FROM 'data/raw/kospi.csv' WITH (FORMAT CSV, HEADER TRUE, DELIMITER ',');

\copy raw.usd_krw_raw FROM 'data/raw/usd_krw.csv' WITH (FORMAT CSV, HEADER TRUE, DELIMITER ',');

\copy raw.base_rate_raw FROM 'data/raw/bok_base_rate.csv' WITH (FORMAT CSV, HEADER TRUE, DELIMITER ',');

\copy raw.usd_krw_fred_raw FROM 'data/raw/usd_krw_fred.csv' WITH (FORMAT CSV, HEADER TRUE, DELIMITER ',');
