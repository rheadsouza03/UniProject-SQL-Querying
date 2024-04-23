-- This file just contains miscellanious queries to make it easier for me to edit 
-- and paste into the terminal for the data population
CREATE TEMP TABLE temp_has_skills (
  robber_nickname VARCHAR(100),
  description VARCHAR(100),
  preference INT,
  grade CHAR(2)
);

 \copy temp_has_skills from ./datafiles/hasskills_24.data WITH DELIMITER E'\t';

INSERT INTO HasSkills (robber_id, skill_id, preference, grade)
SELECT r.robber_id, s.skill_id, hs.preference, hs.grade
FROM temp_has_skills hs
JOIN Robbers r ON r.nickname = hs.robber_nickname
JOIN Skills s ON s.description = hs.description;

DROP TABLE temp_has_skills CASCADE;



CREATE TEMP TABLE temp_has_accounts (
  nickname VARCHAR(20),
  bank_name VARCHAR(20),
  city VARCHAR(20)
);

 \copy temp_has_accounts from ./datafiles/hasaccounts_24.data WITH DELIMITER E'\t';

 INSERT INTO HasAccounts (robber_id, bank_name, city)
 SELECT r.robber_id, b.bank_name, b.city
 FROM temp_has_accounts ha
 JOIN Robbers r ON ha.nickname = r.nickname
 JOIN Banks b ON ha.bank_name = b.bank_name AND ha.city = b.city;

 DROP TABLE temp_has_accounts CASCADE;

 CREATE TEMP TABLE temp_accomplices (
   nickname VARCHAR(20),
   bank_name VARCHAR(20),
   city VARCHAR(20),
   date_robbed DATE,
   robbery_share DECIMAL(10, 2)
 );

 INSERT INTO Accomplices (robber_id, bank_name, city, date_robbed, robbery_share)
 SELECT r.robber_id, a.bank_name, a.city, a.date_robbed, a.robbery_share
 FROM temp_accomplices a
 JOIN Robbers r ON a.nickname = r.nickname;






 DELETE FROM Robberies WHERE bank_name = 'Loanshark Bank' AND city = 'Chicago' AND date_robbed = '' AND amount = '';
