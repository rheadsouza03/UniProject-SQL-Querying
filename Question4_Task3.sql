SELECT r.robber_id, r.nickname, r.age, s.description
FROM Robbers r
JOIN HasSkills hs ON r.robber_id = hs.robber_id
JOIN Skills s ON hs.skill_id = s.skill_id
WHERE r.age >= 35;
