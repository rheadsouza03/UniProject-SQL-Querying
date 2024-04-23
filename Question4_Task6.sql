SELECT s.description, r.robber_id, r.nickname
FROM Skills s
JOIN HasSkills hs ON s.skill_id = hs.skill_id
JOIN Robbers r ON hs.robber_id = r.robber_id
ORDER BY s.description;
