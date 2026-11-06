-- 검증: 은행·KOSPI 일별 수익률 계산 미리보기
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

-- 검증: 은행별 전 거래일 종가 결측 확인
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
SELECT bank_name,
       COUNT(*) AS total_rows,
       COUNT(prev_close) AS valid_prev_close_days,
       COUNT(*) - COUNT(prev_close) AS missing_prev_close_days
FROM bank_lag
GROUP BY bank_name
ORDER BY bank_name;

-- 분석: 전체 기간 은행 수익률·변동성과 KOSPI 비교
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

-- 분석: 연도별 은행 수익률·변동성과 KOSPI 비교
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


-- 검증: KB금융 거래일 기준 환율 변화율 미리보기
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

-- 검증: 환율 변화율 계산 가능 건수와 결측 확인
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
SELECT COUNT(*) AS total_rows,
       COUNT(exchange_rate_change) AS valid_change_days,
       COUNT(*) - COUNT(exchange_rate_change) AS missing_change_days
FROM exchange_changes;

-- 분석: 전체 기간 환율 변화율과 은행 수익률의 관계
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


-- 검증: 은행별 거래일에 적용된 기준금리 미리보기
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

-- 검증: 은행별 기준금리 연결 건수·중복·결측 확인
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
SELECT b.bank_name,
       COUNT(*) AS total_rows,
       COUNT(DISTINCT b.trade_date) AS unique_dates,
       COUNT(*) - COUNT(DISTINCT b.trade_date) AS duplicate_rows,
       COUNT(*) - COUNT(r.base_rate) AS missing_base_rate
FROM bank_returns AS b
LEFT JOIN clean.base_rate AS r
ON r.change_date = (SELECT MAX(change_date)
                    FROM clean.base_rate
                    WHERE change_date <= b.trade_date)
GROUP BY b.bank_name
ORDER BY b.bank_name;

-- 분석: 기준금리 수준별 은행·KOSPI 수익률 요약
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
-- 금리별 거래일 수가 다르고 당시 시장 상황이 함께 반영되므로, 금리 자체의 효과로 해석할 수 없다.


-- 검증: 은행별 KOSPI 연결 건수와 결측 확인
WITH bank_prices AS (
    SELECT trade_date, 'KB금융' AS bank_name, close_price
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
),
bank_lag AS (
    SELECT trade_date, bank_name, close_price,
           LAG(close_price) OVER(
               PARTITION BY bank_name ORDER BY trade_date
           ) AS prev_close
    FROM bank_prices
),
kospi_lag AS (
    SELECT trade_date, close_price,
           LAG(close_price) OVER(ORDER BY trade_date) AS prev_close
    FROM clean.kospi
)
SELECT b.bank_name,
       COUNT(*) AS total_rows,
       COUNT(DISTINCT b.trade_date) AS unique_dates,
       COUNT(*) - COUNT(m.close_price) AS missing_kospi_close,
       COUNT(*) - COUNT(m.prev_close) AS missing_kospi_prev_close
FROM bank_lag AS b
LEFT JOIN kospi_lag AS m
ON b.trade_date = m.trade_date
GROUP BY b.bank_name
ORDER BY b.bank_name;