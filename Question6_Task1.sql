-- Nested Approach
CREATE VIEW ActiveRobbersWithoutPrison AS
SELECT r.nickname
FROM Robbers r
JOIN Accomplices a ON r.robber_id = a.robber_id
WHERE r.robber_id IN (
    SELECT robber_id
    FROM Accomplices
    GROUP BY robber_id
    HAVING COUNT(*) > (
        SELECT AVG(num_robberies)
        FROM (
            SELECT COUNT(*) AS num_robberies
            FROM Accomplices
            GROUP BY robber_id
        ) AS avg_robberies
    )
) AND r.no_years = 0
GROUP BY r.nickname
ORDER BY SUM(a.robbery_share) DESC;

SELECT * FROM ActiveRobbersWithoutPrison;
