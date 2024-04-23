-- Nested Approach
SELECT r.robber_id, r.nickname, s.description AS preferred_skill
FROM Robbers r
JOIN (
    SELECT robber_id, skill_id, preference, ROW_NUMBER() OVER (PARTITION BY robber_id ORDER BY preference) AS rank
    FROM HasSkills
) hs ON r.robber_id = hs.robber_id
JOIN Skills s ON hs.skill_id = s.skill_id
WHERE hs.rank = 1 AND r.robber_id IN (
    SELECT robber_id
    FROM HasSkills
    GROUP BY robber_id
    HAVING COUNT(*) >= 2
);

-- Stepwise Approach
CREATE VIEW RobberSkillsCount AS
SELECT robber_id, COUNT(*) AS num_skills
FROM HasSkills
GROUP BY robber_id;

CREATE VIEW RobbersWithMultipleSkills AS
SELECT robber_id
FROM RobberSkillsCount
WHERE num_skills >= 2;

CREATE VIEW FirstPreferredSkills AS
SELECT robber_id, skill_id
FROM HasSkills
WHERE preference = 1;

SELECT r.robber_id, r.nickname, s.description
FROM Robbers r
JOIN FirstPreferredSkills f ON r.robber_id = f.robber_id
JOIN Skills s ON f.skill_id = s.skill_id
WHERE r.robber_id IN (SELECT robber_id FROM RobbersWithMultipleSkills);
