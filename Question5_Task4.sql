-- Nested Approach
SELECT robber_id, nickname
FROM Robbers
WHERE robber_id NOT IN (
    SELECT DISTINCT h.robber_id
    FROM HasAccounts h
    INNER JOIN Robberies r ON h.bank_name = r.bank_name AND h.city = r.city
);

-- Stepwise Approach
CREATE VIEW RobbedRobbers AS
SELECT DISTINCT h.robber_id
FROM HasAccounts h
INNER JOIN Robberies r ON h.bank_name = r.bank_name AND h.city = r.city;

CREATE VIEW RobbersNotRobbedBanks AS
SELECT robber_id, nickname
FROM Robbers
WHERE robber_id NOT IN (
    SELECT robber_id FROM RobbedRobbers
);

SELECT * FROM RobbersNotRobbedBanks;
