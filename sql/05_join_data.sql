
-- KB금융 거래일을 기준으로 FRED 환율 데이터를 LEFT JOIN한다.
-- 해당 날짜의 환율이 없으면 NULL을 유지한다.
-- 환율 결측은 이전 값이나 보간 값으로 채우지 않는다.


SELECT k.trade_date, k.close_price, b.change_date, b.base_rate
FROM clean.kb_financial AS k
LEFT JOIN clean.base_rate AS b
ON b.change_date = (
    SELECT MAX(r.change_date)
    FROM clean.base_rate AS r
    WHERE r.change_date <= k.trade_date
)
WHERE k.trade_date >= DATE '2021-08-25' AND k.trade_date <= DATE '2021-08-27'
ORDER BY k.trade_date;

-- 각 거래일 이하의 금리 변경일 중 가장 최근 날짜의 금리를 연결한다.
-- 기준금리는 변경일부터 다음 변경 전까지 적용된다.


SELECT k.trade_date, k.close_price AS kb_close, m.close_price AS kospi_close, f.exchange_rate, b.change_date, b.base_rate
FROM clean.kb_financial AS k
LEFT JOIN clean.kospi AS m
ON k.trade_date = m.trade_date
LEFT JOIN clean.usd_krw_fred AS f
ON k.trade_date = f.trade_date
LEFT JOIN clean.base_rate AS b
ON b.change_date = (
    SELECT MAX(r.change_date)
    FROM clean.base_rate AS r
    WHERE r.change_date <= k.trade_date
)
ORDER BY k.trade_date
LIMIT 5;

SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT k.trade_date) AS unique_dates,
       COUNT(*) - COUNT(DISTINCT k.trade_date) AS duplicate_rows,
       COUNT(*) - COUNT(k.close_price) AS missing_bank_close,
       COUNT(*) - COUNT(m.close_price) AS missing_kospi_close,
       COUNT(*) - COUNT(f.exchange_rate) AS missing_exchange_rows,
       COUNT(*) - COUNT(b.base_rate) AS missing_base_rate FROM clean.kb_financial AS k
LEFT JOIN clean.kospi AS m
ON k.trade_date = m.trade_date
LEFT JOIN clean.usd_krw_fred AS f
ON k.trade_date = f.trade_date
LEFT JOIN clean.base_rate AS b
ON b.change_date = (
   SELECT MAX(r.change_date)
   FROM clean.base_rate AS r
   WHERE r.change_date <= k.trade_date
);


SELECT s.trade_date, s.close_price AS shinhan_close, m.close_price AS kospi_close, f.exchange_rate, b.change_date, b.base_rate
FROM clean.shinhan_financial AS s
LEFT JOIN clean.kospi AS m
ON s.trade_date = m.trade_date
LEFT JOIN clean.usd_krw_fred AS f
ON s.trade_date = f.trade_date
LEFT JOIN clean.base_rate AS b
ON b.change_date = (
    SELECT MAX(r.change_date)
    FROM clean.base_rate AS r
    WHERE r.change_date <= s.trade_date
)
ORDER BY s.trade_date
LIMIT 5;

SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT s.trade_date) AS unique_dates,
       COUNT(*) - COUNT(DISTINCT s.trade_date) AS duplicate_rows,
       COUNT(*) - COUNT(s.close_price) AS missing_bank_close,
       COUNT(*) - COUNT(m.close_price) AS missing_kospi_close,
       COUNT(*) - COUNT(f.exchange_rate) AS missing_exchange_rows,
       COUNT(*) - COUNT(b.base_rate) AS missing_base_rate FROM clean.shinhan_financial AS s
LEFT JOIN clean.kospi AS m
ON s.trade_date = m.trade_date
LEFT JOIN clean.usd_krw_fred AS f
ON s.trade_date = f.trade_date
LEFT JOIN clean.base_rate AS b
ON b.change_date = (
   SELECT MAX(r.change_date)
   FROM clean.base_rate AS r
   WHERE r.change_date <= s.trade_date
);


SELECT h.trade_date, h.close_price AS hana_close, m.close_price AS kospi_close, f.exchange_rate, b.change_date, b.base_rate
FROM clean.hana_financial AS h
LEFT JOIN clean.kospi AS m
ON h.trade_date = m.trade_date
LEFT JOIN clean.usd_krw_fred AS f
ON h.trade_date = f.trade_date
LEFT JOIN clean.base_rate AS b
ON b.change_date = (
    SELECT MAX(r.change_date)
    FROM clean.base_rate AS r
    WHERE r.change_date <= h.trade_date
)
ORDER BY h.trade_date
LIMIT 5;

SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT h.trade_date) AS unique_dates,
       COUNT(*) - COUNT(DISTINCT h.trade_date) AS duplicate_rows,
       COUNT(*) - COUNT(h.close_price) AS missing_bank_close,
       COUNT(*) - COUNT(m.close_price) AS missing_kospi_close,
       COUNT(*) - COUNT(f.exchange_rate) AS missing_exchange_rows,
       COUNT(*) - COUNT(b.base_rate) AS missing_base_rate FROM clean.hana_financial AS h
LEFT JOIN clean.kospi AS m
ON h.trade_date = m.trade_date
LEFT JOIN clean.usd_krw_fred AS f
ON h.trade_date = f.trade_date
LEFT JOIN clean.base_rate AS b
ON b.change_date = (
   SELECT MAX(r.change_date)
   FROM clean.base_rate AS r
   WHERE r.change_date <= h.trade_date
);


SELECT w.trade_date, w.close_price AS woori_close, m.close_price AS kospi_close, f.exchange_rate, b.change_date, b.base_rate
FROM clean.woori_financial AS w
LEFT JOIN clean.kospi AS m
ON w.trade_date = m.trade_date
LEFT JOIN clean.usd_krw_fred AS f
ON w.trade_date = f.trade_date
LEFT JOIN clean.base_rate AS b
ON b.change_date = (
    SELECT MAX(r.change_date)
    FROM clean.base_rate AS r
    WHERE r.change_date <= w.trade_date
)
ORDER BY w.trade_date
LIMIT 5;

SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT w.trade_date) AS unique_dates,
       COUNT(*) - COUNT(DISTINCT w.trade_date) AS duplicate_rows,
       COUNT(*) - COUNT(w.close_price) AS missing_bank_close,
       COUNT(*) - COUNT(m.close_price) AS missing_kospi_close,
       COUNT(*) - COUNT(f.exchange_rate) AS missing_exchange_rows,
       COUNT(*) - COUNT(b.base_rate) AS missing_base_rate FROM clean.woori_financial AS w
LEFT JOIN clean.kospi AS m
ON w.trade_date = m.trade_date
LEFT JOIN clean.usd_krw_fred AS f
ON w.trade_date = f.trade_date
LEFT JOIN clean.base_rate AS b
ON b.change_date = (
   SELECT MAX(r.change_date)
   FROM clean.base_rate AS r
   WHERE r.change_date <= w.trade_date
);