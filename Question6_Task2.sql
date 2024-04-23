-- Nested Approach
CREATE VIEW SecurityLevelStats AS
SELECT rb.sec_level, COUNT(rb.bank_name) AS total_robberies, AVG(rb.amount) AS average_amount
FROM (
    SELECT b.bank_name, b.city, b.sec_level, r.amount
    FROM Robberies r
    JOIN Banks b ON r.bank_name = b.bank_name AND r.city = b.city
) AS rb
JOIN (SELECT bank_name, city, sec_level FROM Banks) AS b ON rb.bank_name = b.bank_name AND rb.city = b.city
GROUP BY rb.sec_level;

SELECT * FROM SecurityLevelStats;
