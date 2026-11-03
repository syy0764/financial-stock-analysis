SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
FROM clean.kb_financial
ORDER BY trade_date
LIMIT 5;

WITH kb_prices AS (
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.kb_financial
)
SELECT trade_date, close_price, prev_close,
       (close_price - prev_close) / prev_close * 100 AS daily_return
FROM kb_prices
ORDER BY trade_date
LIMIT 5;

WITH kb_prices AS (
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.kb_financial
)
SELECT COUNT(*), COUNT(prev_close), COUNT(*) - COUNT(prev_close)
FROM kb_prices;


WITH shinhan_prices AS (
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.shinhan_financial
)
SELECT trade_date, close_price, prev_close,
       (close_price - prev_close) / prev_close * 100 AS daily_return
FROM shinhan_prices
ORDER BY trade_date
LIMIT 5;

WITH shinhan_prices AS (
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.shinhan_financial
)
SELECT COUNT(*), COUNT(prev_close), COUNT(*) - COUNT(prev_close)
FROM shinhan_prices;


WITH hana_prices AS (
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.hana_financial
)
SELECT trade_date, close_price, prev_close,
       (close_price - prev_close) / prev_close * 100 AS daily_return
FROM hana_prices
ORDER BY trade_date
LIMIT 5;

WITH hana_prices AS (
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.hana_financial
)
SELECT COUNT(*), COUNT(prev_close), COUNT(*) - COUNT(prev_close)
FROM hana_prices;


WITH woori_prices AS (
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.woori_financial
)
SELECT trade_date, close_price, prev_close,
       (close_price - prev_close) / prev_close * 100 AS daily_return
FROM woori_prices
ORDER BY trade_date
LIMIT 5;

WITH woori_prices AS (
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.woori_financial
)
SELECT COUNT(*), COUNT(prev_close), COUNT(*) - COUNT(prev_close)
FROM woori_prices;


WITH kospi_prices AS (
    SELECT trade_date, close_price, 
    LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.kospi
)
SELECT trade_date, close_price, prev_close, (close_price - prev_close) / prev_close * 100 AS daily_return
FROM kospi_prices
ORDER BY trade_date
LIMIT 5;


WITH kb_prices AS (
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.kb_financial
),
kospi_prices AS(
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.kospi
)
SELECT k.trade_date, k.close_price AS kb_close, m.close_price AS kospi_close,
      (k.close_price - k.prev_close) / k.prev_close * 100 AS kb_return, (m.close_price - m.prev_close) / m.prev_close * 100  AS kospi_return
FROM kb_prices AS k
LEFT JOIN kospi_prices AS m
ON k.trade_date = m.trade_date
ORDER BY k.trade_date
LIMIT 5;


WITH kb_prices AS (
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.kb_financial
),
kospi_prices AS(
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.kospi
)
SELECT COUNT(*), COUNT(DISTINCT k.trade_date), 
       COUNT((k.close_price - k.prev_close) / k.prev_close * 100),
       COUNT((m.close_price - m.prev_close) / m.prev_close * 100)
FROM kb_prices AS k
LEFT JOIN kospi_prices AS m
ON k.trade_date = m.trade_date;


WITH shinhan_prices AS (
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.shinhan_financial
),
kospi_prices AS(
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.kospi
)
SELECT s.trade_date, s.close_price AS shinhan_close, m.close_price AS kospi_close,
      (s.close_price - s.prev_close) / s.prev_close * 100 AS shinhan_return, (m.close_price - m.prev_close) / m.prev_close * 100  AS kospi_return
FROM shinhan_prices AS s
LEFT JOIN kospi_prices AS m
ON s.trade_date = m.trade_date
ORDER BY s.trade_date
LIMIT 5;


WITH shinhan_prices AS (
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.shinhan_financial
),
kospi_prices AS(
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.kospi
)
SELECT COUNT(*), COUNT(DISTINCT s.trade_date), 
       COUNT((s.close_price - s.prev_close) / s.prev_close * 100),
       COUNT((m.close_price - m.prev_close) / m.prev_close * 100)
FROM shinhan_prices AS s
LEFT JOIN kospi_prices AS m
ON s.trade_date = m.trade_date;


WITH hana_prices AS (
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.hana_financial
),
kospi_prices AS(
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.kospi
)
SELECT h.trade_date, h.close_price AS hana_close, m.close_price AS kospi_close,
      (h.close_price - h.prev_close) / h.prev_close * 100 AS hana_return, (m.close_price - m.prev_close) / m.prev_close * 100  AS kospi_return
FROM hana_prices AS h
LEFT JOIN kospi_prices AS m
ON h.trade_date = m.trade_date
ORDER BY h.trade_date
LIMIT 5;


WITH hana_prices AS (
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.hana_financial
),
kospi_prices AS(
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.kospi
)
SELECT COUNT(*), COUNT(DISTINCT h.trade_date), 
       COUNT((h.close_price - h.prev_close) / h.prev_close * 100),
       COUNT((m.close_price - m.prev_close) / m.prev_close * 100)
FROM hana_prices AS h
LEFT JOIN kospi_prices AS m
ON h.trade_date = m.trade_date;


WITH woori_prices AS (
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.woori_financial
),
kospi_prices AS(
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.kospi
)
SELECT w.trade_date, w.close_price AS woori_close, m.close_price AS kospi_close,
      (w.close_price - w.prev_close) / w.prev_close * 100 AS woori_return, (m.close_price - m.prev_close) / m.prev_close * 100  AS kospi_return
FROM woori_prices AS w
LEFT JOIN kospi_prices AS m
ON w.trade_date = m.trade_date
ORDER BY w.trade_date
LIMIT 5;


WITH woori_prices AS (
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.woori_financial
),
kospi_prices AS(
    SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.kospi
)
SELECT COUNT(*), COUNT(DISTINCT w.trade_date), 
       COUNT((w.close_price - w.prev_close) / w.prev_close * 100),
       COUNT((m.close_price - m.prev_close) / m.prev_close * 100)
FROM woori_prices AS w
LEFT JOIN kospi_prices AS m
ON w.trade_date = m.trade_date;


WITH bank_prices AS (
SELECT trade_date , 'KB금융' AS bank_name, close_price
FROM clean.kb_financial
UNION ALL
SELECT trade_date, '하나금융' AS bank_name, close_price
FROM clean.hana_financial
UNION ALL
SELECT trade_date, '신한지주' AS bank_name, close_price
FROM clean.shinhan_financial
UNION ALL
SELECT trade_date, '우리금융' AS bank_name, close_price
FROM clean.woori_financial
)
,bank_lag AS (
SELECT trade_date, bank_name, close_price, 
       LAG(close_price) OVER(PARTITION BY bank_name ORDER BY trade_date) AS prev_close
FROM bank_prices
)
,kospi_lag AS (
SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
FROM clean.kospi
)
SELECT b.trade_date, b.bank_name, b.close_price AS bank_close, m.close_price AS kospi_close, 
(b.close_price - b.prev_close) / b.prev_close * 100 AS bank_return,
(m.close_price - m.prev_close) / m.prev_close * 100 AS kospi_return
FROM bank_lag AS b
LEFT JOIN kospi_lag AS m
ON b.trade_date = m.trade_date
ORDER BY b.trade_date, b.bank_name
LIMIT 10;


WITH bank_prices AS (
SELECT trade_date , 'KB금융' AS bank_name, close_price
FROM clean.kb_financial
UNION ALL
SELECT trade_date, '하나금융' AS bank_name, close_price
FROM clean.hana_financial
UNION ALL
SELECT trade_date, '신한지주' AS bank_name, close_price
FROM clean.shinhan_financial
UNION ALL
SELECT trade_date, '우리금융' AS bank_name, close_price
FROM clean.woori_financial
)
,bank_lag AS (
SELECT trade_date, bank_name, close_price, 
       LAG(close_price) OVER(PARTITION BY bank_name ORDER BY trade_date) AS prev_close
FROM bank_prices
)
SELECT bank_name, COUNT(*), COUNT(prev_close), COUNT(*) - COUNT(prev_close)
FROM bank_lag
GROUP BY bank_name
ORDER BY bank_name;


WITH bank_prices AS (
SELECT trade_date , 'KB금융' AS bank_name, close_price
FROM clean.kb_financial
UNION ALL
SELECT trade_date, '하나금융' AS bank_name, close_price
FROM clean.hana_financial
UNION ALL
SELECT trade_date, '신한지주' AS bank_name, close_price
FROM clean.shinhan_financial
UNION ALL
SELECT trade_date, '우리금융' AS bank_name, close_price
FROM clean.woori_financial
)
,bank_lag AS (
SELECT trade_date, bank_name, close_price, 
       LAG(close_price) OVER(PARTITION BY bank_name ORDER BY trade_date) AS prev_close
FROM bank_prices
)
,kospi_lag AS (
SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
FROM clean.kospi
)
SELECT b.bank_name, COUNT(*), COUNT(DISTINCT b.trade_date), COUNT(*) - COUNT(m.close_price), COUNT(*) - COUNT(m.prev_close)
FROM bank_lag AS b
LEFT JOIN kospi_lag AS m
ON b.trade_date = m.trade_date
GROUP BY b.bank_name
ORDER BY b.bank_name;


WITH bank_prices AS (
SELECT trade_date , 'KB금융' AS bank_name, close_price
FROM clean.kb_financial
UNION ALL
SELECT trade_date, '하나금융' AS bank_name, close_price
FROM clean.hana_financial
UNION ALL
SELECT trade_date, '신한지주' AS bank_name, close_price
FROM clean.shinhan_financial
UNION ALL
SELECT trade_date, '우리금융' AS bank_name, close_price
FROM clean.woori_financial
)
,bank_lag AS (
SELECT trade_date, bank_name, close_price, 
       LAG(close_price) OVER(PARTITION BY bank_name ORDER BY trade_date) AS prev_close
FROM bank_prices
)
,kospi_lag AS (
SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
FROM clean.kospi
)
,bank_returns AS (
SELECT b.trade_date, b.bank_name, 
(b.close_price - b.prev_close) / b.prev_close * 100 AS bank_return,
(m.close_price - m.prev_close) / m.prev_close * 100 AS kospi_return
FROM bank_lag AS b
LEFT JOIN kospi_lag AS m
ON b.trade_date = m.trade_date
)
SELECT *
FROM bank_returns
ORDER BY trade_date, bank_name
LIMIT 8;


WITH bank_prices AS (
SELECT trade_date , 'KB금융' AS bank_name, close_price
FROM clean.kb_financial
UNION ALL
SELECT trade_date, '하나금융' AS bank_name, close_price
FROM clean.hana_financial
UNION ALL
SELECT trade_date, '신한지주' AS bank_name, close_price
FROM clean.shinhan_financial
UNION ALL
SELECT trade_date, '우리금융' AS bank_name, close_price
FROM clean.woori_financial
)
,bank_lag AS (
SELECT trade_date, bank_name, close_price, 
       LAG(close_price) OVER(PARTITION BY bank_name ORDER BY trade_date) AS prev_close
FROM bank_prices
)
,kospi_lag AS (
SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
FROM clean.kospi
)
,bank_returns AS (
SELECT b.trade_date, b.bank_name, 
(b.close_price - b.prev_close) / b.prev_close * 100 AS bank_return,
(m.close_price - m.prev_close) / m.prev_close * 100 AS kospi_return
FROM bank_lag AS b
LEFT JOIN kospi_lag AS m
ON b.trade_date = m.trade_date
)
SELECT bank_name, COUNT(bank_return) AS return_days, 
       AVG(bank_return) AS avg_bank_return,
       AVG(kospi_return) AS avg_kospi_return,
       STDDEV_SAMP(bank_return) AS bank_volatility, 
       STDDEV_SAMP(kospi_return) AS kospi_volatility,
       CORR(bank_return, kospi_return) AS kospi_correlation
FROM bank_returns
GROUP BY bank_name
ORDER BY bank_name;


-- 전체 기간 분석 결과
-- 분석 기간에 은행 4개 모두 KOSPI보다 평균 일별 수익률과 변동성이 높았다.
-- KB금융은 은행 4개 중 평균 일별 수익률과 변동성이 모두 가장 높았다.
-- 평균은 일별 수익률의 산술평균이며, 변동성은 일별 수익률의 표본표준편차로 계산했다.
-- 은행 4개의 일별 수익률은 KOSPI 일별 수익률과 모두 양의 상관관계를 보였다.
-- 상관계수는 약 0.4745~0.4993이며, 하나금융이 가장 높았지만 은행 간 차이는 작았다.


WITH bank_prices AS (
SELECT trade_date , 'KB금융' AS bank_name, close_price
FROM clean.kb_financial
UNION ALL
SELECT trade_date, '하나금융' AS bank_name, close_price
FROM clean.hana_financial
UNION ALL
SELECT trade_date, '신한지주' AS bank_name, close_price
FROM clean.shinhan_financial
UNION ALL
SELECT trade_date, '우리금융' AS bank_name, close_price
FROM clean.woori_financial
)
,bank_lag AS (
SELECT trade_date, bank_name, close_price, 
       LAG(close_price) OVER(PARTITION BY bank_name ORDER BY trade_date) AS prev_close
FROM bank_prices
)
,kospi_lag AS (
SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
FROM clean.kospi
)
,bank_returns AS (
SELECT b.trade_date, b.bank_name, 
(b.close_price - b.prev_close) / b.prev_close * 100 AS bank_return,
(m.close_price - m.prev_close) / m.prev_close * 100 AS kospi_return
FROM bank_lag AS b
LEFT JOIN kospi_lag AS m
ON b.trade_date = m.trade_date
)
SELECT EXTRACT(YEAR FROM trade_date) AS trade_year,
       bank_name, COUNT(bank_return) AS return_days, 
       AVG(bank_return) AS avg_bank_return,
       AVG(kospi_return) AS avg_kospi_return,
       STDDEV_SAMP(bank_return) AS bank_volatility, 
       STDDEV_SAMP(kospi_return) AS kospi_volatility,
       CORR(bank_return, kospi_return) AS kospi_correlation     
FROM bank_returns
GROUP BY trade_year, bank_name
ORDER BY trade_year, bank_name;


-- 연도별 분석 결과
-- 2021·2022·2024년에는 은행 4개 모두 KOSPI보다 평균 일별 수익률이 높았다.
-- 2023년에는 은행 4개 모두 KOSPI보다 평균 일별 수익률이 낮았다.
-- 2025년에는 우리금융만 KOSPI보다 평균 일별 수익률이 높았다.
-- 2021~2025년 모든 연도에서 은행 4개 모두 KOSPI보다 일별 수익률의 변동성이 높았다.
-- 전체 기간의 평균 수익률 비교 결과가 매년 동일하게 유지되지는 않았다.

SELECT trade_date, exchange_rate, LAG(exchange_rate) OVER(ORDER BY trade_date) AS prev_exchange_rate
FROM clean.usd_krw_fred
ORDER BY trade_date
LIMIT 10;


WITH exchange_lag AS (
SELECT trade_date, exchange_rate, LAG(exchange_rate) OVER(ORDER BY trade_date) AS prev_exchange_rate
FROM clean.usd_krw_fred
)
SELECT trade_date, exchange_rate, prev_exchange_rate,
       (exchange_rate - prev_exchange_rate) / prev_exchange_rate * 100 AS exchange_rate_change
FROM exchange_lag
ORDER BY trade_date
LIMIT 10;


WITH exchange_lag AS (
SELECT trade_date, exchange_rate, LAG(exchange_rate) OVER(ORDER BY trade_date) AS prev_exchange_rate
FROM clean.usd_krw_fred
)
,exchange_changes AS (
SELECT trade_date, exchange_rate, prev_exchange_rate,
       (exchange_rate - prev_exchange_rate) / prev_exchange_rate * 100 AS exchange_rate_change
FROM exchange_lag
)
SELECT COUNT(*), COUNT(exchange_rate_change), COUNT(*) - COUNT(exchange_rate_change)
FROM exchange_changes;


WITH exchange_lag AS (
SELECT k.trade_date, f.exchange_rate, LAG(f.exchange_rate) OVER(ORDER BY k.trade_date) AS prev_exchange_rate
FROM clean.kb_financial AS k
LEFT JOIN clean.usd_krw_fred AS f 
ON k.trade_date = f.trade_date
)
SELECT trade_date, exchange_rate, prev_exchange_rate,
       (exchange_rate - prev_exchange_rate) / prev_exchange_rate * 100 AS exchange_rate_change
FROM exchange_lag
ORDER BY trade_date
LIMIT 10;


WITH exchange_lag AS (
SELECT k.trade_date, f.exchange_rate, LAG(f.exchange_rate) OVER(ORDER BY k.trade_date) AS prev_exchange_rate
FROM clean.kb_financial AS k
LEFT JOIN clean.usd_krw_fred AS f 
ON k.trade_date = f.trade_date
)
,exchange_changes AS (
SELECT trade_date, exchange_rate, prev_exchange_rate,
       (exchange_rate - prev_exchange_rate) / prev_exchange_rate * 100 AS exchange_rate_change
FROM exchange_lag
)
SELECT COUNT(*), COUNT(exchange_rate_change), COUNT(*) - COUNT(exchange_rate_change)
FROM exchange_changes;


WITH bank_prices AS (
SELECT trade_date , 'KB금융' AS bank_name, close_price
FROM clean.kb_financial
UNION ALL
SELECT trade_date, '하나금융' AS bank_name, close_price
FROM clean.hana_financial
UNION ALL
SELECT trade_date, '신한지주' AS bank_name, close_price
FROM clean.shinhan_financial
UNION ALL
SELECT trade_date, '우리금융' AS bank_name, close_price
FROM clean.woori_financial
)
,bank_lag AS (
SELECT trade_date, bank_name, close_price, 
       LAG(close_price) OVER(PARTITION BY bank_name ORDER BY trade_date) AS prev_close
FROM bank_prices
)
,kospi_lag AS (
SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
FROM clean.kospi
)
,bank_returns AS (
SELECT b.trade_date, b.bank_name, 
(b.close_price - b.prev_close) / b.prev_close * 100 AS bank_return,
(m.close_price - m.prev_close) / m.prev_close * 100 AS kospi_return
FROM bank_lag AS b
LEFT JOIN kospi_lag AS m
ON b.trade_date = m.trade_date
)
,exchange_lag AS (
SELECT k.trade_date, f.exchange_rate, LAG(f.exchange_rate) OVER(ORDER BY k.trade_date) AS prev_exchange_rate
FROM clean.kb_financial AS k
LEFT JOIN clean.usd_krw_fred AS f 
ON k.trade_date = f.trade_date
)
,exchange_changes AS (
SELECT trade_date, exchange_rate, prev_exchange_rate,
       (exchange_rate - prev_exchange_rate) / prev_exchange_rate * 100 AS exchange_rate_change
FROM exchange_lag
)
SELECT b.bank_name, COUNT(*) AS paired_days, 
       CORR(b.bank_return, f.exchange_rate_change) AS exchange_correlation
FROM bank_returns AS b
LEFT JOIN exchange_changes AS f
ON b.trade_date = f.trade_date
WHERE b.bank_return IS NOT NULL
  AND f.exchange_rate_change IS NOT NULL
GROUP BY b.bank_name
ORDER BY b.bank_name;

-- 환율 변동률과 은행 수익률의 전체 기간 상관분석 결과
-- KB 거래일 기준으로 두 값이 모두 있는 1,136일을 분석했다.
-- 은행 4개 모두 환율 변동률과 약한 음의 상관관계를 보였다.
-- 상관계수는 KB금융 -0.2121, 신한지주 -0.1997,
-- 우리금융 -0.2043, 하나금융 -0.1989였다.
-- 은행 간 차이는 작았으며, 이 결과가 인과관계를 의미하지는 않는다.


WITH bank_prices AS (
SELECT trade_date , 'KB금융' AS bank_name, close_price
FROM clean.kb_financial
UNION ALL
SELECT trade_date, '하나금융' AS bank_name, close_price
FROM clean.hana_financial
UNION ALL
SELECT trade_date, '신한지주' AS bank_name, close_price
FROM clean.shinhan_financial
UNION ALL
SELECT trade_date, '우리금융' AS bank_name, close_price
FROM clean.woori_financial
)
,bank_lag AS (
SELECT trade_date, bank_name, close_price, 
       LAG(close_price) OVER(PARTITION BY bank_name ORDER BY trade_date) AS prev_close
FROM bank_prices
)
,kospi_lag AS (
SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
FROM clean.kospi
)
,bank_returns AS (
SELECT b.trade_date, b.bank_name, 
(b.close_price - b.prev_close) / b.prev_close * 100 AS bank_return,
(m.close_price - m.prev_close) / m.prev_close * 100 AS kospi_return
FROM bank_lag AS b
LEFT JOIN kospi_lag AS m
ON b.trade_date = m.trade_date
)
,exchange_lag AS (
SELECT k.trade_date, f.exchange_rate, LAG(f.exchange_rate) OVER(ORDER BY k.trade_date) AS prev_exchange_rate
FROM clean.kb_financial AS k
LEFT JOIN clean.usd_krw_fred AS f 
ON k.trade_date = f.trade_date
)
,exchange_changes AS (
SELECT trade_date, exchange_rate, prev_exchange_rate,
       (exchange_rate - prev_exchange_rate) / prev_exchange_rate * 100 AS exchange_rate_change
FROM exchange_lag
)
SELECT EXTRACT(YEAR FROM b.trade_date) AS trade_year, b.bank_name, COUNT(*) AS paired_days, 
       CORR(b.bank_return, f.exchange_rate_change) AS exchange_correlation
FROM bank_returns AS b
LEFT JOIN exchange_changes AS f
ON b.trade_date = f.trade_date
WHERE b.bank_return IS NOT NULL
  AND f.exchange_rate_change IS NOT NULL
GROUP BY trade_year, b.bank_name
ORDER BY trade_year, b.bank_name;


-- 환율 변동률과 은행 수익률의 연도별 상관분석 결과
-- 2021~2025년 모든 연도에서 은행 4개 모두 음의 상관관계를 보였다.
-- 2022년에는 은행 4개 모두 다른 연도보다 음의 상관관계가 강했다.
-- 2024·2025년에는 2022년보다 음의 상관관계가 약했다.
-- 음의 방향은 매년 유지됐지만, 관계의 강도는 달랐다.
-- 은행별 연도별 분석 날짜 수의 합계는 1,136일로 전체 기간과 일치했다.


SELECT k.trade_date, b.change_date, b.base_rate
FROM clean.kb_financial AS k
LEFT JOIN clean.base_rate AS b 
ON b.change_date = (
      SELECT MAX(r.change_date)
      FROM clean.base_rate AS r
      WHERE r.change_date <= k.trade_date
)
ORDER BY k.trade_date
LIMIT 10;


SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT k.trade_date) AS unique_dates,
       COUNT(*) - COUNT(DISTINCT k.trade_date) AS duplicate_rows,
       COUNT(*) - COUNT(b.base_rate) AS missing_base_rate
FROM clean.kb_financial AS k
LEFT JOIN clean.base_rate AS b 
ON b.change_date = (
      SELECT MAX(r.change_date)
      FROM clean.base_rate AS r
      WHERE r.change_date <= k.trade_date
);


WITH bank_prices AS (
SELECT trade_date , 'KB금융' AS bank_name, close_price
FROM clean.kb_financial
UNION ALL
SELECT trade_date, '하나금융' AS bank_name, close_price
FROM clean.hana_financial
UNION ALL
SELECT trade_date, '신한지주' AS bank_name, close_price
FROM clean.shinhan_financial
UNION ALL
SELECT trade_date, '우리금융' AS bank_name, close_price
FROM clean.woori_financial
)
,bank_lag AS (
SELECT trade_date, bank_name, close_price, 
       LAG(close_price) OVER(PARTITION BY bank_name ORDER BY trade_date) AS prev_close
FROM bank_prices
)
,kospi_lag AS (
SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
FROM clean.kospi
)
,bank_returns AS (
SELECT b.trade_date, b.bank_name, 
(b.close_price - b.prev_close) / b.prev_close * 100 AS bank_return,
(m.close_price - m.prev_close) / m.prev_close * 100 AS kospi_return
FROM bank_lag AS b
LEFT JOIN kospi_lag AS m
ON b.trade_date = m.trade_date
)
,base_by_date AS (
SELECT k.trade_date, b.change_date, b.base_rate
FROM clean.kb_financial AS k
LEFT JOIN clean.base_rate AS b 
ON b.change_date = (
      SELECT MAX(r.change_date)
      FROM clean.base_rate AS r
      WHERE r.change_date <= k.trade_date
)
)
SELECT b.bank_name, r.base_rate, COUNT(*) AS return_days,
       AVG(b.bank_return) AS avg_bank_return,
       STDDEV_SAMP(b.bank_return) AS bank_volatility
FROM bank_returns AS b
LEFT JOIN base_by_date AS r
ON b.trade_date = r.trade_date
WHERE b.bank_return IS NOT NULL AND r.base_rate IS NOT NULL
GROUP BY b.bank_name, r.base_rate
ORDER BY r.base_rate, b.bank_name;

-- 기준금리 수준별 은행 수익률 분석 결과
-- 각 거래일에 적용되는 가장 최근 기준금리를 연결했으며, 누락과 날짜 중복은 없었다.
-- 첫 거래일의 수익률 NULL을 제외하고 은행별 1,224일을 분석했다.
-- 기준금리 1.75% 구간에서는 은행 4개 모두 평균 일별 수익률이 음수였다.
-- 기준금리 3.50% 구간에서는 은행 4개 모두 평균 일별 수익률이 양수였다.
-- 금리가 높아질수록 평균 일별 수익률이나 변동성이 일관되게 증가하지는 않았다.
-- 금리 수준별 분석 날짜 수가 다르고, 같은 금리가 적용된 서로 다른 시기가 함께 집계됐다.
-- 따라서 구간별 수익률 차이를 기준금리의 영향으로 단정할 수 없다.


WITH bank_prices AS (
SELECT trade_date , 'KB금융' AS bank_name, close_price
FROM clean.kb_financial
UNION ALL
SELECT trade_date, '하나금융' AS bank_name, close_price
FROM clean.hana_financial
UNION ALL
SELECT trade_date, '신한지주' AS bank_name, close_price
FROM clean.shinhan_financial
UNION ALL
SELECT trade_date, '우리금융' AS bank_name, close_price
FROM clean.woori_financial
)
,bank_lag AS (
SELECT trade_date, bank_name, close_price, 
       LAG(close_price) OVER(PARTITION BY bank_name ORDER BY trade_date) AS prev_close
FROM bank_prices
)
,kospi_lag AS (
SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
FROM clean.kospi
)
,bank_returns AS (
SELECT b.trade_date, b.bank_name, 
(b.close_price - b.prev_close) / b.prev_close * 100 AS bank_return,
(m.close_price - m.prev_close) / m.prev_close * 100 AS kospi_return
FROM bank_lag AS b
LEFT JOIN kospi_lag AS m
ON b.trade_date = m.trade_date
)
,exchange_lag AS (
SELECT k.trade_date, f.exchange_rate, LAG(f.exchange_rate) OVER(ORDER BY k.trade_date) AS prev_exchange_rate
FROM clean.kb_financial AS k
LEFT JOIN clean.usd_krw_fred AS f 
ON k.trade_date = f.trade_date
)
,exchange_changes AS (
SELECT trade_date, exchange_rate, prev_exchange_rate,
       (exchange_rate - prev_exchange_rate) / prev_exchange_rate * 100 AS exchange_rate_change
FROM exchange_lag
)
SELECT b.bank_name, COUNT(*) AS paired_days, 
       CORR(b.bank_return, f.exchange_rate_change) AS exchange_correlation,
       REGR_SLOPE(b.bank_return, f.exchange_rate_change) AS exchange_slope,
       REGR_R2(b.bank_return, f.exchange_rate_change) AS exchange_r2
FROM bank_returns AS b
LEFT JOIN exchange_changes AS f
ON b.trade_date = f.trade_date
WHERE b.bank_return IS NOT NULL
  AND f.exchange_rate_change IS NOT NULL
GROUP BY b.bank_name
ORDER BY b.bank_name;

-- 은행 4종 모두 환율 변화율이 높을수록 일별 수익률이 대체로 낮은 관계를 보였다.
-- 환율 변화율만 사용한 단순회귀의 결정계수는 약 0.040~0.045로,
-- 은행 수익률 변동의 약 4~4.5%를 설명하는 수준이었다.
-- KOSPI 등 다른 요인은 고려하지 않았으며, 인과관계로 해석할 수 없다.


-- 환율 변화율과 은행 수익률의 관계: 연도별 분석
WITH bank_prices AS (
SELECT trade_date , 'KB금융' AS bank_name, close_price
FROM clean.kb_financial
UNION ALL
SELECT trade_date, '하나금융' AS bank_name, close_price
FROM clean.hana_financial
UNION ALL
SELECT trade_date, '신한지주' AS bank_name, close_price
FROM clean.shinhan_financial
UNION ALL
SELECT trade_date, '우리금융' AS bank_name, close_price
FROM clean.woori_financial
)
,bank_lag AS (
SELECT trade_date, bank_name, close_price, 
       LAG(close_price) OVER(PARTITION BY bank_name ORDER BY trade_date) AS prev_close
FROM bank_prices
)
,kospi_lag AS (
SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
FROM clean.kospi
)
,bank_returns AS (
SELECT b.trade_date, b.bank_name, 
(b.close_price - b.prev_close) / b.prev_close * 100 AS bank_return,
(m.close_price - m.prev_close) / m.prev_close * 100 AS kospi_return
FROM bank_lag AS b
LEFT JOIN kospi_lag AS m
ON b.trade_date = m.trade_date
)
,exchange_lag AS (
SELECT k.trade_date, f.exchange_rate, LAG(f.exchange_rate) OVER(ORDER BY k.trade_date) AS prev_exchange_rate
FROM clean.kb_financial AS k
LEFT JOIN clean.usd_krw_fred AS f 
ON k.trade_date = f.trade_date
)
,exchange_changes AS (
SELECT trade_date, exchange_rate, prev_exchange_rate,
       (exchange_rate - prev_exchange_rate) / prev_exchange_rate * 100 AS exchange_rate_change
FROM exchange_lag
)
SELECT b.bank_name, COUNT(*) AS paired_days, 
       EXTRACT(YEAR FROM b.trade_date) AS trade_year,
       CORR(b.bank_return, f.exchange_rate_change) AS exchange_correlation,
       REGR_SLOPE(b.bank_return, f.exchange_rate_change) AS exchange_slope,
       REGR_R2(b.bank_return, f.exchange_rate_change) AS exchange_r2
FROM bank_returns AS b
LEFT JOIN exchange_changes AS f
ON b.trade_date = f.trade_date
WHERE b.bank_return IS NOT NULL
  AND f.exchange_rate_change IS NOT NULL
GROUP BY b.bank_name, trade_year
ORDER BY b.bank_name, trade_year;

-- 모든 은행·연도에서 환율 변화율과 은행 수익률 사이에 음의 상관관계가 나타났다.
-- 은행별로 비교했을 때 상관계수의 절댓값과 결정계수는 모두 2022년에 가장 컸다.
-- 다만 환율 변화율만 고려한 모형으로 설명력은 제한적이며, 인과관계로 해석할 수 없다.


WITH bank_prices AS (
SELECT trade_date , 'KB금융' AS bank_name, close_price
FROM clean.kb_financial
UNION ALL
SELECT trade_date, '하나금융' AS bank_name, close_price
FROM clean.hana_financial
UNION ALL
SELECT trade_date, '신한지주' AS bank_name, close_price
FROM clean.shinhan_financial
UNION ALL
SELECT trade_date, '우리금융' AS bank_name, close_price
FROM clean.woori_financial
)
,bank_lag AS (
SELECT trade_date, bank_name, close_price, 
       LAG(close_price) OVER(PARTITION BY bank_name ORDER BY trade_date) AS prev_close
FROM bank_prices
)
,kospi_lag AS (
SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
FROM clean.kospi
)
,bank_returns AS (
SELECT b.trade_date, b.bank_name, 
(b.close_price - b.prev_close) / b.prev_close * 100 AS bank_return,
(m.close_price - m.prev_close) / m.prev_close * 100 AS kospi_return
FROM bank_lag AS b
LEFT JOIN kospi_lag AS m
ON b.trade_date = m.trade_date
)
SELECT b.trade_date, b.bank_name, b.bank_return, b.kospi_return,r.change_date, r.base_rate
FROM bank_returns AS b
LEFT JOIN clean.base_rate AS r
ON r.change_date = (SELECT MAX(change_date)
                    FROM clean.base_rate
                    WHERE change_date <= b.trade_date)
ORDER BY b.bank_name, b.trade_date
LIMIT 10;


WITH bank_prices AS (
SELECT trade_date , 'KB금융' AS bank_name, close_price
FROM clean.kb_financial
UNION ALL
SELECT trade_date, '하나금융' AS bank_name, close_price
FROM clean.hana_financial
UNION ALL
SELECT trade_date, '신한지주' AS bank_name, close_price
FROM clean.shinhan_financial
UNION ALL
SELECT trade_date, '우리금융' AS bank_name, close_price
FROM clean.woori_financial
)
,bank_lag AS (
SELECT trade_date, bank_name, close_price, 
       LAG(close_price) OVER(PARTITION BY bank_name ORDER BY trade_date) AS prev_close
FROM bank_prices
)
,kospi_lag AS (
SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
FROM clean.kospi
)
,bank_returns AS (
SELECT b.trade_date, b.bank_name, 
(b.close_price - b.prev_close) / b.prev_close * 100 AS bank_return,
(m.close_price - m.prev_close) / m.prev_close * 100 AS kospi_return
FROM bank_lag AS b
LEFT JOIN kospi_lag AS m
ON b.trade_date = m.trade_date
)
SELECT b.bank_name, COUNT(*), COUNT(DISTINCT b.trade_date), COUNT(*) - COUNT(r.base_rate)
FROM bank_returns AS b
LEFT JOIN clean.base_rate AS r
ON r.change_date = (SELECT MAX(change_date)
                    FROM clean.base_rate
                    WHERE change_date <= b.trade_date)
GROUP BY b.bank_name
ORDER BY b.bank_name;


WITH bank_prices AS (
SELECT trade_date , 'KB금융' AS bank_name, close_price
FROM clean.kb_financial
UNION ALL
SELECT trade_date, '하나금융' AS bank_name, close_price
FROM clean.hana_financial
UNION ALL
SELECT trade_date, '신한지주' AS bank_name, close_price
FROM clean.shinhan_financial
UNION ALL
SELECT trade_date, '우리금융' AS bank_name, close_price
FROM clean.woori_financial
)
,bank_lag AS (
SELECT trade_date, bank_name, close_price, 
       LAG(close_price) OVER(PARTITION BY bank_name ORDER BY trade_date) AS prev_close
FROM bank_prices
)
,kospi_lag AS (
SELECT trade_date, close_price, LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
FROM clean.kospi
)
,bank_returns AS (
SELECT b.trade_date, b.bank_name, 
(b.close_price - b.prev_close) / b.prev_close * 100 AS bank_return,
(m.close_price - m.prev_close) / m.prev_close * 100 AS kospi_return
FROM bank_lag AS b
LEFT JOIN kospi_lag AS m
ON b.trade_date = m.trade_date
)
SELECT b.bank_name, r.base_rate, COUNT(*) AS trade_days, AVG(b.bank_return) AS avg_bank_return, 
       AVG(b.kospi_return) AS avg_kospi_return, STDDEV_SAMP(b.bank_return) AS bank_volatility
FROM bank_returns AS b
LEFT JOIN clean.base_rate AS r
ON r.change_date = (SELECT MAX(change_date)
                    FROM clean.base_rate
                    WHERE change_date <= b.trade_date)
WHERE b.bank_return IS NOT NULL
GROUP BY b.bank_name, r.base_rate
ORDER BY b.bank_name, r.base_rate;

-- 은행 4종 모두 기준금리 수준에 따라 평균 일별 수익률이 일관되게 증가하거나 감소하지 않았다.
-- 모든 은행에서 기준금리 1.75% 구간의 평균 수익률이 가장 낮았으며, 같은 구간의 KOSPI 평균 수익률도 음수였다.
-- 금리별 분석일 수가 다르고 당시 시장 상황이 함께 반영되므로, 금리 자체의 효과로 해석할 수 없다.