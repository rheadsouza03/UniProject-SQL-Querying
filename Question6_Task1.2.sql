-- Stepwise Approach
CREATE VIEW CountRobberies AS
SELECT robber_id, COUNT(*) AS num_robberies
FROM Accomplices
GROUP BY robber_id;

CREATE VIEW AverageRobberies AS
SELECT AVG(num_robberies) AS avg_robberies
FROM CountRobberies;

CREATE VIEW RobbersAboveAverage AS
SELECT c.robber_id
FROM CountRobbersRobberies c
GROUP BY c.robber_id, c.num_robberies
HAVING c.num_robberies > (SELECT avg_robberies FROM AverageRobberies);

CREATE VIEW ActiveRobbersWithoutPrison AS
SELECT r.robber_id, r.nickname
FROM Robbers r
JOIN RobbersAboveAverage ra ON r.robber_id = ra.robber_id
WHERE r.no_years = 0;

CREATE VIEW ActiveRobbersSorted AS
SELECT a.nickname AS total_earnings
FROM ActiveRobbersWithoutPrison a
JOIN Accomplices ac ON a.robber_id = ac.robber_id
GROUP BY a.robber_id, a.nickname
ORDER BY SUM(ac.robbery_share) DESC;

SELECT * FROM ActiveRobbersSorted;
