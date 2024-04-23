-- Nested Approach
SELECT DISTINCT rb.bank_name, rb.city
FROM Robberies rb
WHERE (rb.bank_name, rb.city) NOT IN (
        SELECT rb.bank_name, rb.city
        FROM Robbers r
        JOIN Accomplices a ON r.robber_id = a.robber_id
        WHERE rb.bank_name = a.bank_name AND rb.city = a.city
);

-- Stepwise Approach
CREATE VIEW TotalRobbers AS
SELECT COUNT(DISTINCT robber_id) AS total_robbers
FROM Robbers;

CREATE VIEW RobberiesPerBank AS
SELECT bank_name, city, COUNT(DISTINCT robber_id) AS robbers_count
FROM Accomplices
GROUP BY bank_name, city;

CREATE VIEW BanksRobbedByAll AS
SELECT bank_name, city
FROM RobberiesPerBank
WHERE robbers_count = (SELECT total_robbers FROM TotalRobbers);

SELECT * FROM BanksRobbedByAll;
