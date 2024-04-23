-- Nested Approach
SELECT bank_name, city
FROM RobberyPlans
WHERE (bank_name, city) NOT IN (
    SELECT bank_name, city
    FROM Robberies
    WHERE EXTRACT(YEAR FROM RobberyPlans.planned_date) = EXTRACT(YEAR FROM Robberies.date_robbed)
);

-- Stepwise Approach
CREATE VIEW PlannedYear AS
SELECT bank_name, city, EXTRACT(YEAR FROM planned_date) AS planned_year
FROM RobberyPlans;

CREATE VIEW RobberyYear AS
SELECT bank_name, city, EXTRACT(YEAR FROM date_robbed) AS robbed_year
FROM Robberies;

CREATE VIEW BanksNotRobbed AS
SELECT p.bank_name, p.city
FROM PlannedYear p
LEFT JOIN RobberyYear r ON p.bank_name = r.bank_name AND p.city = r.city AND p.planned_year = r.robbed_year
WHERE r.bank_name IS NULL AND r.city IS NULL;

SELECT bank_name, city FROM BanksNotRobbed;
