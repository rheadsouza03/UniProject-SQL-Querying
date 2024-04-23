SELECT r.robber_id, r.nickname, SUM(a.robbery_share) AS total_share
FROM Robbers r
JOIN Accomplices a ON r.robber_id = a.robber_id
GROUP BY r.robber_id, r.nickname
HAVING SUM(a.robbery_share) >= 50000
ORDER BY total_share DESC;
